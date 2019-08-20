package com.bloomreach.commercedxp.demo.pactronics.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class BrandWrapper {
    private List<String> brands;

    public List<String> getBrands() {
        return brands;
    }

    public void setBrands(final List<String> brands) {
        this.brands = brands;
    }
}
