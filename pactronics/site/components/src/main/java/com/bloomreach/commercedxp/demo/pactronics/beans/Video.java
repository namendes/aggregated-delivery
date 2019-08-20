package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;

@HippoEssentialsGenerated(internalName = "pactronics:video")
@Node(jcrType = "pactronics:video")
public class Video extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:link")
    public String getLink() {
        return getProperty("pactronics:link");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:description")
    public String getDescription() {
        return getProperty("pactronics:description");
    }
}
