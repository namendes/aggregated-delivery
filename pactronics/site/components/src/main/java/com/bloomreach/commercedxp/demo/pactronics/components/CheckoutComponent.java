package com.bloomreach.commercedxp.demo.pactronics.components;

import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.components.AbstractStarterStoreComponent;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.state.ConnectorExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreHstUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.onehippo.cms7.crisp.api.broker.ResourceServiceBroker;
import org.onehippo.cms7.crisp.api.exchange.ExchangeHint;
import org.onehippo.cms7.crisp.api.exchange.ExchangeHintBuilder;
import org.onehippo.cms7.crisp.api.resource.Resource;
import org.onehippo.cms7.crisp.api.resource.ResourceCollection;
import org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource;
import org.onehippo.cms7.crisp.hst.module.CrispHstServices;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


public class CheckoutComponent extends AbstractStarterStoreComponent {

    private static final Logger LOGGER = LoggerFactory.getLogger(CheckoutComponent.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) throws HstComponentException {

        CommerceExchangeState exchangeState = getCommerceExchangeState(request, response, true);
        Cookie cookie = StarterStoreHstUtils.getCookie(exchangeState, StarterStoreConstants.CART_NAME);


        if (checkCartId(exchangeState)) {
            HttpServletRequest httpServletRequest = exchangeState.getContext().getRequest();

            final ConnectorExchangeState connectorState = exchangeState.getConnectorExchangeState();

            connectorState.resetConnectorComponent(connectorState.getConnector(), connectorState.getConnector().getComponentById("cartProductList"));

            final ResourceServiceBroker broker = CrispHstServices.getDefaultResourceServiceBroker();
            final ExchangeHint hint = ExchangeHintBuilder.create().noCache(true).build();

            Resource result = broker.resolve(connectorState.getResourceSpace(), connectorState.getServiceBaseUrl(), hint);


            ResourceCollection lineItems = ((JacksonResource) result.getValue("lineItems")).getChildren();

            double totalValue = 0;
            String id = (String) result.getValue("id");

            JSONObject items = new JSONObject();
            JSONArray itemsArray = new JSONArray();


            for (Resource lineItem : lineItems.getCollection()) {

                totalValue += Double.parseDouble(lineItem.getValue("price/value/centAmount").toString()) / 100;

                JSONObject item = new JSONObject();

                item.put("prod_id", lineItem.getValue("productId"));
                item.put("sku", lineItem.getValue("variant/sku"));
                item.put("name", lineItem.getValue("name/en"));
                item.put("quantity", lineItem.getValue("quantity"));
                item.put("price", Double.parseDouble(lineItem.getValue("price/value/centAmount").toString()) / 100);

                itemsArray.add(item);
            }

            items.put("items", itemsArray);

            request.setAttribute("cartItems", items.toString());
            request.setAttribute("cartId", id);
            request.setAttribute("totalValue", totalValue);

            //TODO:
            // after making the order the cart will automatically be deleted from CT
            cookie.setMaxAge(0);
            cookie.setPath("/");
            cookie.setValue("");
            response.addCookie(cookie);
        }
    }

   /* public static Cookie getCookie(final HttpServletRequest request, final String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie;
                }
            }
        }
        return null;
    }
*/

    protected boolean checkCartId(final CommerceExchangeState exchangeState) {
        HttpServletRequest httpServletRequest = exchangeState.getContext().getRequest();
        Cookie cartCookie = StarterStoreHstUtils.getCookie(exchangeState, StarterStoreConstants.CART_NAME);
        //check if the cart has been already created during by the user
        String cartId = null;
        //TODO the way it's implemented the is always a carid ID in the cookie
        if (cartCookie != null && StringUtils.isNotBlank(cartCookie.getValue())) {
            cartId = cartCookie.getValue();
        } else {
            cartId = (String) httpServletRequest.getSession().getAttribute(StarterStoreConstants.CART_NAME);
        }
        if (cartId != null) {
            httpServletRequest.setAttribute(StarterStoreConstants.CART_NAME, cartId);
            return true;
        }
        return false;
    }

}
