package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:calltoaction")
@Node(jcrType = "pactronics:calltoaction")
public class Calltoaction extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:name")
    public String getName() {
        return getProperty("pactronics:name");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:info")
    public String getInfo() {
        return getProperty("pactronics:info");
    }

    public String getType() {
        return "calltoaction";
    }

    @HippoEssentialsGenerated(internalName = "pactronics:externallink")
    public String getExternallink() {
        return getProperty("pactronics:externallink");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:internallink")
    public HippoBean getInternallink() {
        return getLinkedBean("pactronics:internallink", HippoBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:image")
    public Pactronics getImage() {
        return getLinkedBean("pactronics:image", Pactronics.class);
    }
}
