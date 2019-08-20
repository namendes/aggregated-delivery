package com.bloomreach.commercedxp.demo.pactronics.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.Property;
import javax.jcr.RepositoryException;
import javax.jcr.Value;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MultivaluePropertyUtil {

    private static final Logger log = LoggerFactory.getLogger(MultivaluePropertyUtil.class);

    public static Map<String, String> getKeyValuePair(Node userNode, String keyPropertyName, String valuePropertyName) {

        try {
            Value[] topicValues = userNode.getProperty(keyPropertyName).getValues();
            Value[] topicDeliveryValues = userNode.getProperty(valuePropertyName).getValues();

            Map<String, String> topics = new HashMap<>();
            for (int i = 0; i < topicValues.length; i++) {
                try {
                    String topic = topicValues[i].getString();
                    String topicDelivery = topicDeliveryValues[i].getString();
                    topics.put(topic, topicDelivery);
                } catch (RepositoryException e) {
                    log.error("Unable to read property",e);
                }
            }
            return topics;
        } catch (RepositoryException e) {
            log.error("Unable to read property",e);
        }
        return null;
    }

    public static boolean addMultiValuePropertyValue(Node node, String propertyName, String value) throws RepositoryException {
        return addMultiValuePropertyValue(node, propertyName, value, false);
    }

    public static boolean addMultiValuePropertyValue(Node node, String propertyName, String value, boolean checkExists) throws RepositoryException {
        List<String> values = getMultiValuePropertyValues(node, propertyName);
        if (!checkExists || !values.contains(value)) {
            values.add(value);
            updateMultiValueProperty(node, propertyName, values);
            return true;
        }
        return false;
    }

    public static void addMultiValuePropertyValues(Node node, String propertyName, List<String> newValues) throws RepositoryException {
        addMultiValuePropertyValues(node, propertyName, newValues, false);
    }

    public static void addMultiValuePropertyValues(Node node, String propertyName, List<String> newValues, boolean checkExists) throws RepositoryException {
        List<String> values = getMultiValuePropertyValues(node, propertyName);
        for (String value : newValues) {
            if (!checkExists || !values.contains(value)) {
                values.add(value);
            }
        }
        updateMultiValueProperty(node, propertyName, values);
    }

    public static List<String> getMultiValuePropertyValues(Node node, String propertyName) throws RepositoryException {
        if (node.hasProperty(propertyName)) {
            Property prop = node.getProperty(propertyName);
            Value[] values = prop.getValues();
            List<String> valueList = new ArrayList<String>(values.length);
            for (Value value : values) {
                valueList.add(value.getString());
            }
            return valueList;
        }
        return new ArrayList<String>();
    }

    public static void updateMultiValueProperty(Node node, String propertyName, List<String> values) throws RepositoryException {
        node.setProperty(propertyName, values.toArray(new String[values.size()]));
    }
}
