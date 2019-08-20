package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import java.util.List;
import org.hippoecm.hst.content.beans.standard.HippoBean;

@HippoEssentialsGenerated(internalName = "pactronics:faqlist")
@Node(jcrType = "pactronics:faqlist")
public class Faqlist extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:description")
    public HippoHtml getDescription() {
        return getHippoHtml("pactronics:description");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:faqitem")
    public List<HippoBean> getFaqitem() {
        return getLinkedBeans("pactronics:faqitem", HippoBean.class);
    }
}
