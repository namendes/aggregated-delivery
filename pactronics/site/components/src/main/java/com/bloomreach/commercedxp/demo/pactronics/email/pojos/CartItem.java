package com.bloomreach.commercedxp.demo.pactronics.email.pojos;

import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.core.linking.HstLink;
import org.hippoecm.hst.core.linking.HstLinkCreator;
import org.hippoecm.hst.core.request.HstRequestContext;

public class CartItem {

    private String productId;
    private String sku;
    private String name;
    private int quantity;
    private String currencyCode;
    private int price;
    private int fractionDigits;

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getFractionDigits() {
        return fractionDigits;
    }

    public void setFractionDigits(int fractionDigits) {
        this.fractionDigits = fractionDigits;
    }

    public int getSubtotal(){
        return quantity * price;
    }

    public String getProductLink(){
        HstRequestContext requestContext = RequestContextProvider.get();
        HstLinkCreator linkCreator = requestContext.getHstLinkCreator();
        Mount mount = requestContext.getMount("root");


        HstLink baseProductLink = linkCreator.createByRefId("product", mount);
        String baseUrl = baseProductLink.toUrlForm(requestContext,true);
        return baseUrl.concat("/" + this.sku);
    }
}
