package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:imagekeyvalue")
@Node(jcrType = "pactronics:imagekeyvalue")
public class Imagekeyvalue extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:key")
    public String getKey() {
        return getProperty("pactronics:key");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:value")
    public Pactronics getValue() {
        return getLinkedBean("pactronics:value", Pactronics.class);
    }
}
