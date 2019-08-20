package com.bloomreach.commercedxp.demo.pactronics.rest.model;

import javax.xml.bind.annotation.XmlElement;

public class ProductFinderOption {


    @XmlElement
    String text;

    @XmlElement
    String facetCategory;

    @XmlElement
    String facetValue;


    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getFacetCategory() {
        return facetCategory;
    }

    public void setFacetCategory(String facetCategory) {
        this.facetCategory = facetCategory;
    }

    public String getFacetValue() {
        return facetValue;
    }

    public void setFacetValue(String facetValue) {
        this.facetValue = facetValue;
    }
}
