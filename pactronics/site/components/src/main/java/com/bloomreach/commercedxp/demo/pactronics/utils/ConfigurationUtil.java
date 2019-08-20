package com.bloomreach.commercedxp.demo.pactronics.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.*;
import javax.jcr.query.Query;
import javax.jcr.query.QueryResult;
import java.util.HashMap;
import java.util.Map;

public class ConfigurationUtil {

    private static final Logger log = LoggerFactory.getLogger(ConfigurationUtil.class);

    private static final String RESOURCEBUNDLES_XPATH_QUERY = "content/documents/administration//element(*,resourcebundle:resourcebundle)[(@hippo:availability='live') and (@resourcebundle:id='%s')]";
    private static final String KEY_TEMPLATE_PATH = "template-path";
    private static final String KEY_EMAIL_FROM = "store-recipient-from";
    private static final String KEY_EMAIL_TO = "store-recipient-to";
    private static final String KEY_RENDER_CART_MACRO = "renderCartItems";
    private static final String KEY_EMAIL_SUBJECT = "store-email-subject";
    private static final String KEY_QRCODE_WIDTH = "store-qrcode-width";
    private static final String KEY_LOGO = "store-logo";

    private Map<String, String> notificationConfig;
    private Session session;

    public ConfigurationUtil(Session session, String resourcebundleName) {
        this.session = session;
        init(resourcebundleName);
    }

    private void init(String resourcebundleName) {
        try {
            notificationConfig = loadConfiguration(resourcebundleName);
        } catch (RepositoryException e) {
            log.error("Not possible to load email configuration");
        }
    }

    private Map<String, String> loadConfiguration(String resourcebundleName) throws RepositoryException {
        Map<String, String> configuration = new HashMap<>();

        String resourceBundleQuery = String.format(RESOURCEBUNDLES_XPATH_QUERY, resourcebundleName);
        QueryResult result = session.getWorkspace().getQueryManager().createQuery(resourceBundleQuery, Query.XPATH).execute();
        NodeIterator nodesIt = result.getNodes();

        if (nodesIt.getSize() != 1) {
            log.error("Can't load configuration resource bundle with ID: {}", resourcebundleName);
            return null;
        }

        Node rbNode = nodesIt.nextNode();
        PropertyIterator keysIt = rbNode.getProperties("resourcebundle:keys");
        PropertyIterator valuesIt = rbNode.getProperties("resourcebundle:messages");

        while (keysIt.hasNext()) {
            Value[] keys = keysIt.nextProperty().getValues();
            Value[] values = valuesIt.nextProperty().getValues();

            for (int i = 0; i < keys.length; i++) {
                String k = keys[i].getString();
                String v = values[i].getString();
                configuration.put(k, v);
            }
        }
        return configuration;
    }

    public String getEmailFrom() {
        return getConfig(KEY_EMAIL_FROM);
    }

    public String getEmailTo() {
        return getConfig(KEY_EMAIL_TO);
    }

    public String getTemplatePath() {
        return getConfig(KEY_TEMPLATE_PATH);
    }

    public String getRenderCartMacro() {
        return getConfig(KEY_RENDER_CART_MACRO);
    }

    public String getEmailSubject() {
        return getConfig(KEY_EMAIL_SUBJECT);
    }

    public int getQRCodeWidth() {
        return getIntValueConfig(KEY_QRCODE_WIDTH);
    }

    public String getLogo() {
        return getConfig(KEY_LOGO);
    }

    public String getConfig(String key) {
        if (notificationConfig != null) {
            if (notificationConfig.containsKey(key)) {
                return notificationConfig.get(key);
            } else {
                log.error("Can't find entry for Editors configuration key: {}", key);
            }
        }
        log.error("Store configuration not present.");
        return null;
    }

    public Integer getIntValueConfig(String key) {
        String value = getConfig(key);
        if (value != null) {
            return Integer.parseInt(value);
        }
        return null;
    }
}
