package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import java.util.List;
import com.bloomreach.commercedxp.demo.pactronics.beans.Imagekeyvalue;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@HippoEssentialsGenerated(internalName = "pactronics:emailtemplate")
@Node(jcrType = "pactronics:emailtemplate")
public class Emailtemplate extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:instructions")
    public String getInstructions() {
        return getProperty("pactronics:instructions");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:images")
    public List<Imagekeyvalue> getImages() {
        return getChildBeansByName("pactronics:images", Imagekeyvalue.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:htmltemplate")
    public HippoHtml getHtmltemplate() {
        return getHippoHtml("pactronics:htmltemplate");
    }
}
