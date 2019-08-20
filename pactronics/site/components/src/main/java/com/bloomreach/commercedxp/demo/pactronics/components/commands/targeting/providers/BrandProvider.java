package com.bloomreach.commercedxp.demo.pactronics.components.commands.targeting.providers;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.StreamSupport;

import javax.servlet.http.HttpServletRequest;

import org.onehippo.cms7.crisp.api.resource.ResourceCollection;
import org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class BrandProvider implements Provider {

    @Override
    public String getPrefix() {
        return "brands";
    }

    @Override
    public List<String> getData(HttpServletRequest request) {
        return Optional.of((JacksonResource)request.getAttribute("result")).map(
            result -> getInner(result,"response")
        ).map(
            response -> getInner(response,"docs")
        ).map(
           docs -> docs.getChildren().get(0).getValue("brand")
        ).map(Collections::singletonList).orElse(
            Collections.EMPTY_LIST
        );
    }

    private static JacksonResource getInner(JacksonResource jacksonResource, String childName) {
        return (JacksonResource)jacksonResource.getValueMap().get(childName);
    }
}