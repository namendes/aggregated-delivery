package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:productgallery")
@Node(jcrType = "pactronics:productgallery")
public class Productgallery extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:imagefour")
    public Pactronics getImagefour() {
        return getLinkedBean("pactronics:imagefour", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:imagetwo")
    public Pactronics getImagetwo() {
        return getLinkedBean("pactronics:imagetwo", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:imagefive")
    public Pactronics getImagefive() {
        return getLinkedBean("pactronics:imagefive", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:imagethree")
    public Pactronics getImagethree() {
        return getLinkedBean("pactronics:imagethree", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:imageone")
    public Pactronics getImageone() {
        return getLinkedBean("pactronics:imageone", Pactronics.class);
    }
}
