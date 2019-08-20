package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@HippoEssentialsGenerated(internalName = "pactronics:storelocations")
@Node(jcrType = "pactronics:storelocations")
public class Storelocations extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:introduction")
    public String getIntroduction() {
        return getProperty("pactronics:introduction");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:content")
    public String getContent() {
        return getProperty("pactronics:content");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:location1")
    public String getLocation1() {
        return getProperty("pactronics:location1");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:location2")
    public String getLocation2() {
        return getProperty("pactronics:location2");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:location3")
    public String getLocation3() {
        return getProperty("pactronics:location3");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:location4")
    public String getLocation4() {
        return getProperty("pactronics:location4");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:address1")
    public String getAddress1() {
        return getProperty("pactronics:address1");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:address2")
    public String getAddress2() {
        return getProperty("pactronics:address2");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:address3")
    public String getAddress3() {
        return getProperty("pactronics:address3");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:address4")
    public String getAddress4() {
        return getProperty("pactronics:address4");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:map1")
    public HippoHtml getMap1() {
        return getHippoHtml("pactronics:map1");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:map2")
    public HippoHtml getMap2() {
        return getHippoHtml("pactronics:map2");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:map3")
    public HippoHtml getMap3() {
        return getHippoHtml("pactronics:map3");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:map4")
    public HippoHtml getMap4() {
        return getHippoHtml("pactronics:map4");
    }
}
