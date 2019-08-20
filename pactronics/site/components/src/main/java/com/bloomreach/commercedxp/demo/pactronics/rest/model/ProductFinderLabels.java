package com.bloomreach.commercedxp.demo.pactronics.rest.model;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class ProductFinderLabels {

    @XmlElement
    List<String> tabNames;

    @XmlElement
    List<String> tabHeadings;

    @XmlElement
    List<String> tabImages;

    @XmlElement
    List<ArrayList<ProductFinderOption>> tabOptions;

    public ProductFinderLabels() {
        tabNames = new ArrayList<>();
        tabHeadings = new ArrayList<>();
        tabImages = new ArrayList<>();
        tabOptions = new ArrayList<>();
    }

    public void addTabName(String tabName) {
        tabNames.add(tabName);
    }

    public void addTabHeading(String tabHeading) {
        tabHeadings.add(tabHeading);
    }

    public void addTabImage(String tabImage) {
        tabImages.add(tabImage);
    }

    public void addProductFinderOptionList(ArrayList<ProductFinderOption> productFinderOptions) {

        tabOptions.add(productFinderOptions);

    }

}
