package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageBean;

@HippoEssentialsGenerated(internalName = "pactronics:pactronics")
@Node(jcrType = "pactronics:pactronics")
public class Pactronics extends HippoGalleryImageSet {
    @HippoEssentialsGenerated(internalName = "pactronics:desktop")
    public HippoGalleryImageBean getDesktop() {
        return getBean("pactronics:desktop", HippoGalleryImageBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:laptop")
    public HippoGalleryImageBean getLaptop() {
        return getBean("pactronics:laptop", HippoGalleryImageBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:tablet")
    public HippoGalleryImageBean getTablet() {
        return getBean("pactronics:tablet", HippoGalleryImageBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:mobile")
    public HippoGalleryImageBean getMobile() {
        return getBean("pactronics:mobile", HippoGalleryImageBean.class);
    }
}
