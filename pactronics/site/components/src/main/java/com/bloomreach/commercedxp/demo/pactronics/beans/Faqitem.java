package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

@HippoEssentialsGenerated(internalName = "pactronics:faqitem")
@Node(jcrType = "pactronics:faqitem")
public class Faqitem extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:question")
    public String getQuestion() {
        return getProperty("pactronics:question");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:answer")
    public HippoHtml getAnswer() {
        return getHippoHtml("pactronics:answer");
    }
}
