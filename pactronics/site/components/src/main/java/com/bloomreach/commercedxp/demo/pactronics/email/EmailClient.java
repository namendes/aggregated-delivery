package com.bloomreach.commercedxp.demo.pactronics.email;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.naming.NamingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class EmailClient {

    private final Logger log = LoggerFactory.getLogger(EmailClient.class);
    private Session mailSession;

    public EmailClient() throws NamingException {
        initMailSession();
    }

    private void initMailSession() throws NamingException {

      //  final Context namingContext = new InitialContext();
      //  final Context myEnv = (Context) namingContext.lookup("java:comp/env");
      //  mailSession = (Session) myEnv.lookup("gmail/Session");

        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port",587 );
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.user","noreply.pactronics@gmail.com" );
        props.put("mail.smtp.password", "$9T6YN%eeRUP");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {

            //override the getPasswordAuthentication method
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("noreply.pactronics@gmail.com", "$9T6YN%eeRUP");
            }

        };
        mailSession = Session.getInstance(props, auth);


        log.debug("mail/Session = " + mailSession);
        logMailSessionProperties();

       /* mailSession = Session.getInstance(mailSession.getProperties(),
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(
                                mailSession.getProperty("mail.smtp.user"), mailSession.getProperty("mail.smtp.password"));
                    }
                });*/
    }

    private void logMailSessionProperties() {
        log.debug("mail/Session - auth = {}", mailSession.getProperty("auth"));
        log.debug("mail/Session - type = {}", mailSession.getProperty("type"));
        log.debug("mail/Session - mail.smtp.host = {}", mailSession.getProperty("mail.smtp.host"));
        log.debug("mail/Session - mail.smtp.port = {}", mailSession.getProperty("mail.smtp.port"));
        log.debug("mail/Session - mail.smtp.auth = {}", mailSession.getProperty("mail.smtp.auth"));
        log.debug("mail/Session - mail.smtp.starttls.enable = {}", mailSession.getProperty("mail.smtp.starttls.enable"));
        log.debug("mail/Session - mail.smtp.user = {}", mailSession.getProperty("mail.smtp.user"));
        log.debug("mail/Session - mail.smtp.password = {}", mailSession.getProperty("mail.smtp.password"));
    }

    public Session getMailSession(){
        return mailSession;
    }

    public boolean sendMail(Message message) {
        log.debug("Sending email");

        if (mailSession == null) {
            try {
                initMailSession();
            } catch (NamingException e) {
                log.error("Error configuring email", e);
                return false;
            }
        }

        try {
            Transport.send(message);
            log.debug("Email sent successfully");
        } catch (MessagingException e) {
            log.error("Error - sending email message", e);
            return false;
        }
        return true;
    }
}
