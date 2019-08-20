package com.bloomreach.commercedxp.demo.pactronics.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CookieUtils {

    private static final Logger log = LoggerFactory.getLogger(CookieUtils.class);

    public static String decodeCookie(final String cookieValue) {
        try {
            return URLDecoder.decode(cookieValue, "UTF-8");
        }
        catch(UnsupportedEncodingException uee) {
            log.error("Fail to decode cookie value " + cookieValue, uee);
        }
        return "";
    }

    public static<T> T getObject(String string, Class<T> clazz) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(string, clazz);
        }
        catch(IOException ioe) {
            log.error("Fail to parse JSON response - URL:" + string, ioe);
        }
        return null;
    }

}
