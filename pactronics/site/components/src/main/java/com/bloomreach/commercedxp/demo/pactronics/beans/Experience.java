package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import com.bloomreach.commercedxp.demo.pactronics.beans.Featureteaser;
import com.bloomreach.commercedxp.demo.pactronics.beans.Specifications;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:experience")
@Node(jcrType = "pactronics:experience")
public class Experience extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:featureteaser")
    public Featureteaser getFeatureteaser() {
        return getBean("pactronics:featureteaser", Featureteaser.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:specifications")
    public Specifications getSpecifications() {
        return getBean("pactronics:specifications", Specifications.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:video")
    public HippoBean getVideo() {
        return getLinkedBean("pactronics:video", HippoBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:banner")
    public Pactronics getBanner() {
        return getLinkedBean("pactronics:banner", Pactronics.class);
    }
}
