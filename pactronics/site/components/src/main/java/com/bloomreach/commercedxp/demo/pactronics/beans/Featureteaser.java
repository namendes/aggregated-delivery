package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:featureteaser")
@Node(jcrType = "pactronics:featureteaser")
public class Featureteaser extends HippoCompound {
    @HippoEssentialsGenerated(internalName = "pactronics:slogan")
    public String getSlogan() {
        return getProperty("pactronics:slogan");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:leftcaption")
    public String getLeftcaption() {
        return getProperty("pactronics:leftcaption");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:centercaption")
    public String getCentercaption() {
        return getProperty("pactronics:centercaption");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:rightcaption")
    public String getRightcaption() {
        return getProperty("pactronics:rightcaption");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:featuredescription")
    public HippoHtml getFeaturedescription() {
        return getHippoHtml("pactronics:featuredescription");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:rightimage")
    public Pactronics getRightimage() {
        return getLinkedBean("pactronics:rightimage", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:leftimage")
    public Pactronics getLeftimage() {
        return getLinkedBean("pactronics:leftimage", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:centerimage")
    public Pactronics getCenterimage() {
        return getLinkedBean("pactronics:centerimage", Pactronics.class);
    }
}
