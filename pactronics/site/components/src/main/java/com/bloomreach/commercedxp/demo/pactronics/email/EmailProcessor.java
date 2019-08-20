package com.bloomreach.commercedxp.demo.pactronics.email;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.jcr.RepositoryException;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.naming.NamingException;

import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bloomreach.commercedxp.demo.pactronics.beans.Emailtemplate;
import com.bloomreach.commercedxp.demo.pactronics.beans.Imagekeyvalue;
import com.bloomreach.commercedxp.demo.pactronics.utils.ConfigurationUtil;
import com.onehippo.cms7.eforms.hst.util.FreemarkerHtmlEscapedClassTemplateLoader;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class EmailProcessor {

    private final Logger LOGGER = LoggerFactory.getLogger(EmailProcessor.class);

    private final String ENCODING = "UTF-8";
    private final String IMAGE_TEMPLATE = "<img src=\"cid:###\">"; // ### is to be replaced by the images key
    private final String REGEX_IMAGE_PATTERN = "\\$\\{IMG-[a-zA-Z0-9]*\\}"; // lookup for images int he template and replace with the image template code

    private EmailClient emailClient;
    private HstRequestContext hstContext;
    private ConfigurationUtil config;

    public EmailProcessor(HstRequestContext context, ConfigurationUtil config) {
        this.hstContext = context;
        this.config = config;
    }

    public boolean sendEmail(String messageSubject, String recipientEmail, Map<String, Object> data) {

        Emailtemplate emailTemplate = hstContext.getSiteContentBaseBean().getBean(config.getTemplatePath(), Emailtemplate.class);

        String htmlTemplate = emailTemplate.getHtmltemplate().getContent();

        //replace image freemarker with email image code
        htmlTemplate = replaceImages(htmlTemplate);
        //replace cart freemarker with cart macro code
        htmlTemplate = StringUtils.replace(htmlTemplate, "${cart}", "<@renderCart items/>");
        //add cart macro code to the end of the template
        htmlTemplate += config.getRenderCartMacro();

        if (emailClient == null) {
            try {
                emailClient = new EmailClient();
            } catch (NamingException e) {
                LOGGER.error("Not possible to initialize email client", e);
                return false;
            }
        }

        if (recipientEmail == null) {
            recipientEmail = config.getEmailTo();
        }
        Message message = new MimeMessage(emailClient.getMailSession());

        LOGGER.debug(String.format("Sending store email: Subject {} (From:{}; To:{})", messageSubject, config.getEmailFrom(), recipientEmail));
        try {
            message.setFrom(new InternetAddress(config.getEmailFrom()));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail));
            message.setSubject(messageSubject);
            MimeMultipart multipart = new MimeMultipart("related");

            BodyPart messageBodyPart = new MimeBodyPart();

            messageBodyPart.setContent(renderFreemakerEmailContent(htmlTemplate, data), "text/html");
            multipart.addBodyPart(messageBodyPart);

            //add images to the email
            for (Map.Entry<String, Object> entry : data.entrySet()) {
                if (entry.getValue().getClass() == byte[].class) {
                    messageBodyPart = new MimeBodyPart();
                    DataSource fds = new ByteArrayDataSource((byte[]) entry.getValue(), "image/png");
                    messageBodyPart.setDataHandler(new DataHandler(fds));
                    messageBodyPart.setHeader("Content-ID", "<" + entry.getKey() + ">");
                    multipart.addBodyPart(messageBodyPart);
                }
            }

            //add images to the email
            for (Imagekeyvalue templateImage : emailTemplate.getImages()) {
                messageBodyPart = new MimeBodyPart();
                byte[] targetArray = new byte[templateImage.getValue().getOriginal().getNode().getProperty("jcr:data").getBinary().getStream().available()];
                templateImage.getValue().getOriginal().getNode().getProperty("jcr:data").getBinary().getStream().read(targetArray);
                DataSource fds = new ByteArrayDataSource(targetArray, templateImage.getValue().getOriginal().getMimeType());

                messageBodyPart.setDataHandler(new DataHandler(fds));
                messageBodyPart.setHeader("Content-ID", "<" + templateImage.getKey() + ">");
                multipart.addBodyPart(messageBodyPart);
            }

            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart);

        } catch (MessagingException | RepositoryException | IOException me) {
            LOGGER.error("Error composing email {} - {}", messageSubject, recipientEmail);
        }

        if (emailClient.sendMail(message)) {
            LOGGER.debug("Email send to {}", recipientEmail);
        } else {
            LOGGER.error("Fail to send email to {}", recipientEmail);
        }

        return true;
    }

    private String replaceImages(String html) {
        Pattern pattern = Pattern.compile(REGEX_IMAGE_PATTERN);
        Matcher matcher = pattern.matcher(html);

        StringBuffer stringBuffer = new StringBuffer();
        while (matcher.find()) {
            String imageRef = matcher.group().substring(6, matcher.group().length() - 1);
            matcher.appendReplacement(stringBuffer, IMAGE_TEMPLATE.replace("###", imageRef));
        }
        matcher.appendTail(stringBuffer);
        return stringBuffer.toString();

    }


    private String renderFreemakerEmailContent(String freemarkerText, Map<String, Object> data) {
        Template template = createEmailTemplate(freemarkerText, false);
        if (data == null) {
            data = new HashMap<>();
        }

        String result = populateFreemarkerTemplate(template, data);
        return result;
    }

    /**
     * Create freemarker template for given String
     *
     * @param templateContent string containing ftl markup (freemarker template)  @return freemarker template or null
     *                        if creation fails
     * @param escapeHtml      Escape HTML?
     * @return template
     */
    private Template createEmailTemplate(final String templateContent, boolean escapeHtml) {
        StringTemplateLoader loader = new StringTemplateLoader();
        String name = "store-template";
        loader.putTemplate(name,
                escapeHtml ? FreemarkerHtmlEscapedClassTemplateLoader.addHtmlEscapeDirectives(templateContent) :
                        templateContent);
        Configuration config = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        config.setTemplateLoader(loader);
        try {
            return config.getTemplate(name, ENCODING);
        } catch (IOException e) {
            LOGGER.error("Error creating freemarker template", e);
        }
        return null;
    }

    /**
     * Creates body of email message which we are going to send
     *
     * @param template freemarker template
     * @param data     data which will be used to populate template variables
     * @return null if populating fails
     */
    private String populateFreemarkerTemplate(final Template template, final Map<String, Object> data) {
        try {
            // NOTE: no cleanup needed
            StringWriter writer = new StringWriter();
            template.process(data, writer);
            return StringUtils.trimToEmpty(writer.toString());
        } catch (TemplateException | IOException e) {
            LOGGER.error("Error populating template data", e);
        }
        return null;
    }
}
