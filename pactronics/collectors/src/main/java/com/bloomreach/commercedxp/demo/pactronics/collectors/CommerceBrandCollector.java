package com.bloomreach.commercedxp.demo.pactronics.collectors;

import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bloomreach.commercedxp.demo.pactronics.model.BrandWrapper;
import com.bloomreach.commercedxp.demo.pactronics.util.CookieUtils;
import com.onehippo.cms7.targeting.collectors.AbstractTermsFrequencyCollector;

public class CommerceBrandCollector extends AbstractTermsFrequencyCollector {
    private static final Logger log = LoggerFactory.getLogger(CommerceBrandCollector.class);

    private final String cookieToCollect = "commerce_targeting";

    public CommerceBrandCollector(final String id, final Node node) throws RepositoryException {
        super(id, node);

    }

    @Override
    protected List<String> extractTerms(final HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }

        return Stream.of(cookies).filter(
            cookie -> cookieToCollect.contains(cookie.getName())
        ).findFirst().map(
            Cookie::getValue
        ).map(
            CookieUtils::decodeCookie
        ).map(
            json -> CookieUtils.getObject(json, BrandWrapper.class)
        ).map(
            BrandWrapper::getBrands
        ).orElse(
                Collections.EMPTY_LIST
        );
    }



}