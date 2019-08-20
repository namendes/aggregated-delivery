package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

@HippoEssentialsGenerated(internalName = "pactronics:productdecorator")
@Node(jcrType = "pactronics:productdecorator")
public class Productdecorator extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:description")
    public HippoHtml getDescription() {
        return getHippoHtml("pactronics:description");
    }

    public String[] getRelatedexdocids() {
        return getProperty("pactronics:relatedexdocids");
    }

    public String getFirstRelatedexdocid() {
        String[] relatedexdocids = getRelatedexdocids();
        if (relatedexdocids == null || relatedexdocids.length == 0) {
            return null;
        }
        return relatedexdocids[0];
    }

    @HippoEssentialsGenerated(internalName = "pactronics:image")
    public Pactronics getImage() {
        return getLinkedBean("pactronics:image", Pactronics.class);
    }
}
