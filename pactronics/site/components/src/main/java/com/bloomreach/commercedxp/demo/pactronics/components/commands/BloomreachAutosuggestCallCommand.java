package com.bloomreach.commercedxp.demo.pactronics.components.commands;



import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.onehippo.cms7.crisp.api.resource.Resource;
import org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource;
import org.springframework.stereotype.Component;

import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.commands.CrispCommand;
import com.bloomreach.commercedxp.starterstore.connectors.CommerceConnector;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreChannelUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Component
public class BloomreachAutosuggestCallCommand extends CrispCommand {

    private static final String SUGGESTIONS_NAME = "autosuggestions.suggestions";
    private static final String PRODUCTS_NAME = "autosuggestions.products";
    private static final String SUGGESTION_QUERY = "autosuggestions.suggestions.query";

    @Override
    protected void doExecuteInternal(final CommerceExchangeState exchangeState) {

        //in case the connector id hasn't explicitly defined (eg. by the component, content), then use the Bloomreach API if enabled
        if (StarterStoreChannelUtils.getCurrentChannelInfo().isBloomReachApisEnabled() && isResourcePhase(exchangeState)) {

            CommerceConnector commerceConnector =
                    StarterStoreChannelUtils.getCurrentChannelConnectorSet(true).getConnectorById("bloomreach_autosuggest");

            resetCommerceConnectorComponent(exchangeState, commerceConnector, (String) exchangeState.getContext().get(StarterStoreConstants.PARAM_COMMERCE_CONNECTOR_COMPONENT_ID));

            process(exchangeState, StarterStoreConstants.ATTRIBUTE_COMMERCE_RESPONSE);

            HttpServletRequest request = exchangeState.getContext().getRequest();

            JSONObject customResult = getcustomResult(request);

            request.setAttribute("customResult", customResult.toString());

        }
    }

    private JSONObject getcustomResult(final HttpServletRequest request) {
        Resource defaultResult = (JacksonResource)request.getAttribute(StarterStoreConstants.ATTRIBUTE_COMMERCE_RESPONSE);
        ResourceBundle resourceBundle = (ResourceBundle)request.getAttribute(StarterStoreConstants.ATTRIBUTE_MAPPING_RESOURCE_BUNDLE);


        JSONObject customResult = new JSONObject();

        JSONArray suggestionsJSON = new JSONArray();
        Resource suggestions = (Resource) getValue(defaultResult, getPaths(SUGGESTIONS_NAME, resourceBundle));
        for (Resource suggestion: suggestions.getChildren()) {
            suggestionsJSON.add(getValue(suggestion, getPaths(SUGGESTION_QUERY, resourceBundle)));
        }

        JSONArray productsJSON = new JSONArray();
        Resource products = (Resource) getValue(defaultResult, getPaths(PRODUCTS_NAME, resourceBundle));
        for (Resource product: products.getChildren()) {
            JSONObject productJSON = new JSONObject();
            productJSON.put(
                "title", getValue(product, getPaths("autosuggestions.products.title", resourceBundle)));
            String price = String.valueOf((Double)getValue(product, getPaths("autosuggestions.products.price", resourceBundle)));
            productJSON.put(
                "price", resourceBundle.containsKey("autosuggestions.products.price.currency")?
                    resourceBundle.getString("autosuggestions.products.price.currency") + " " + price:
                    price);
            productJSON.put(
                "image", getValue(product, getPaths("autosuggestions.products.image", resourceBundle)));
            productJSON.put(
                "pid", getValue(product, getPaths("autosuggestions.products.id", resourceBundle)));
            productsJSON.add(productJSON);
        }

        customResult.put("suggestions", suggestionsJSON);
        customResult.put("products", productsJSON);
        return customResult;
    }

    private String[] getPaths(String propertyName, ResourceBundle resourceBundle) {
        return resourceBundle.getString(propertyName).split(",");
    }

    private Object getValue(Resource resource, String[] paths) {
        for (String path: paths){
            Object value = resource.getValue(path);
            if (value != null) {
                return resource.getValue(path);
            }
        }
        return null;
    }
}