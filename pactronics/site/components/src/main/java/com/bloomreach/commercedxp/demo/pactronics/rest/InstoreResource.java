package com.bloomreach.commercedxp.demo.pactronics.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jcr.RepositoryException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.onehippo.cms7.crisp.api.resource.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bloomreach.commercedxp.demo.pactronics.email.EmailProcessor;
import com.bloomreach.commercedxp.demo.pactronics.email.pojos.CartItem;
import com.bloomreach.commercedxp.demo.pactronics.utils.ConfigurationUtil;
import com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil;
import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.invokers.CommerceServiceInvoker;
import com.bloomreach.commercedxp.starterstore.jaxrs.AbstractStarterStoreResource;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;

import static com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil.getCookie;
import static com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil.getModelForPath;


/**
 * @version "$Id$"
 */

@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML, MediaType.APPLICATION_FORM_URLENCODED})
@Path("/instore/")
public class InstoreResource extends AbstractStarterStoreResource {

    @Autowired
    private CommerceServiceInvoker commerceServiceInvoker;

    private static final Logger LOGGER = LoggerFactory.getLogger(InstoreResource.class);
    private final String CHECKOUT_BUNDLE_NAME = "instore-checkout-configuration";
    private final String ATTRIBUTE_QRCODE = "qrcode";
    private final String ATTRIBUTE_CARTID = "cartid";
    private final String ATTRIBUTE_CART_ITEMS = "items";
    private final String ATTRIBUTE_CUSTOMER_NAME = "name";
    private final String ATTRIBUTE_CUSTOMER_EMAIL = "email";
    private final String ATTRIBUTE_COMPANY_LOGO = "logo";

    @POST
    @Path("/checkout")
    public boolean sendQrCode(@Context HttpServletRequest request,
                              @Context HttpServletResponse response,
                              MultivaluedMap<String, String> params) {

        HstRequestContext hstRequestContext = RequestContextProvider.get();
        Cookie cookie = getCookie(request, StarterStoreConstants.CART_NAME);
        String cartId = cookie.getValue();

        CommerceExchangeState commerceExchangeState = getCommerceExchangeState(request, response, true, HstRequest.RESOURCE_PHASE);
        Resource result = getCartResource(commerceExchangeState, cartId);

        //Resource result = (Resource) commerceExchangeState.getContext().getRequest().getAttribute(StarterStoreConstants.ATTRIBUTE_COMMERCE_RESPONSE);

        List<CartItem> cartItems = fetchCartItems(result);
        try {
            ConfigurationUtil config = new ConfigurationUtil(hstRequestContext.getSession(), CHECKOUT_BUNDLE_NAME);

            String customerName = params.getFirst("cname");
            String email = params.getFirst("email");
            Map<String, Object> data = new HashMap<>();
            data.put(ATTRIBUTE_QRCODE, SiteUtil.getQRCodeImageStream(cartId, config.getQRCodeWidth(), config.getQRCodeWidth()).toByteArray());
            data.put(ATTRIBUTE_CARTID, cartId);
            data.put(ATTRIBUTE_CART_ITEMS, cartItems);
            data.put(ATTRIBUTE_CUSTOMER_NAME, customerName);
            data.put(ATTRIBUTE_CUSTOMER_EMAIL, email);

            HippoGalleryImageSet logo = (HippoGalleryImageSet)getModelForPath(hstRequestContext,config.getLogo());
            try {
                byte[] logoArray = new byte[logo.getOriginal().getNode().getProperty("jcr:data").getBinary().getStream().available()];
                logo.getOriginal().getNode().getProperty("jcr:data").getBinary().getStream().read(logoArray);
                if(logoArray != null) {
                    data.put(ATTRIBUTE_COMPANY_LOGO, logoArray);
                }
            } catch (IOException e) {
                LOGGER.error("Unable to load company logo", e);
            }

            EmailProcessor ep;
            ep = new EmailProcessor(hstRequestContext, config);
            ep.sendEmail(
                    config.getEmailSubject(),
                    email,
                    data);
            return true;
        } catch (RepositoryException ex) {
            LOGGER.error("Error obtaining session", ex);
        }
        return false;
    }

    private List<CartItem> fetchCartItems(Resource result) {
        List<CartItem> items = new ArrayList<>();
        Resource lineItems = (Resource) result.getValueMap().get("lineItems");
        if (lineItems != null && lineItems.isArray()) {
            for (int i = 0; i < lineItems.getChildCount(); i++) {
                CartItem item = new CartItem();
                item.setProductId((String) lineItems.getChildren().get(i).getValue("productId"));
                item.setSku((String) lineItems.getChildren().get(i).getValue("variant/sku"));
                item.setName((String) lineItems.getChildren().get(i).getValue("name/en"));
                item.setQuantity((Integer) lineItems.getChildren().get(i).getValue("quantity"));
                item.setCurrencyCode((String) lineItems.getChildren().get(i).getValue("price/value/currencyCode"));
                item.setPrice((Integer) lineItems.getChildren().get(i).getValue("price/value/centAmount"));
                item.setFractionDigits((Integer) lineItems.getChildren().get(i).getValue("price/value/fractionDigits"));
                items.add(item);
            }
        }
        return items;
    }

}
