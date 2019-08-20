package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@HippoEssentialsGenerated(internalName = "pactronics:searchresult")
@Node(jcrType = "pactronics:searchresult")
public class Searchresult extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:link")
    public String getLink() {
        return getProperty("pactronics:link");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:desc")
    public HippoHtml getDesc() {
        return getHippoHtml("pactronics:desc");
    }
}
