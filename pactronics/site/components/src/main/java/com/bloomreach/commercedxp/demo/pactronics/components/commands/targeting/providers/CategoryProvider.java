package com.bloomreach.commercedxp.demo.pactronics.components.commands.targeting.providers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


import javax.servlet.http.HttpServletRequest;

import org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class CategoryProvider implements Provider {

    private static final Logger log = LoggerFactory.getLogger(CategoryProvider.class);

    @Override
    public String getPrefix() {
        return "categories";
    }

    @Override
    public List<String> getData(HttpServletRequest request) {
        try {
            JacksonResource result = (JacksonResource) request.getAttribute("result");
            JacksonResource categoriesMap = (JacksonResource) result.getValueMap().get("category_map");

            /*return categoriesMap.getValueMap().keySet().stream()
                .collect(
                    Collectors.toList());*/
            String category = (String) categoriesMap.getValueMap().values().stream().reduce(
                (first, second) -> second).orElse(null);

            return (category != null)?
                    Collections.singletonList(category):Collections.EMPTY_LIST;
        }
        catch (Exception e){
            log.error("Error getting categories from the request", e);
        }
        return Collections.EMPTY_LIST;
    }
}
