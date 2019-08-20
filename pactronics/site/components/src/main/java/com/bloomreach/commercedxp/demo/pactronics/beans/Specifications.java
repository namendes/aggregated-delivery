package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@HippoEssentialsGenerated(internalName = "pactronics:specifications")
@Node(jcrType = "pactronics:specifications")
public class Specifications extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:dimensions")
    public HippoHtml getDimensions() {
        return getHippoHtml("pactronics:dimensions");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:storage")
    public HippoHtml getStorage() {
        return getHippoHtml("pactronics:storage");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:display")
    public HippoHtml getDisplay() {
        return getHippoHtml("pactronics:display");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:battery")
    public HippoHtml getBattery() {
        return getHippoHtml("pactronics:battery");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:memory")
    public HippoHtml getMemory() {
        return getHippoHtml("pactronics:memory");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:graphics")
    public HippoHtml getGraphics() {
        return getHippoHtml("pactronics:graphics");
    }
}
