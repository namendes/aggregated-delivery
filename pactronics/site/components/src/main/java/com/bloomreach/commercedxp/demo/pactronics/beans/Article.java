package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import java.util.List;
import java.util.Calendar;
import com.bloomreach.commercedxp.demo.pactronics.beans.Pactronics;

/** 
 * TODO: Beanwriter: Failed to create getter for node type: hippo:compound
 */
@HippoEssentialsGenerated(internalName = "pactronics:article")
@Node(jcrType = "pactronics:article")
public class Article extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:tags")
    public String[] getTags() {
        return getProperty("pactronics:tags");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:introduction")
    public HippoHtml getIntroduction() {
        return getHippoHtml("pactronics:introduction");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:content")
    public HippoHtml getContent() {
        return getHippoHtml("pactronics:content");
    }

    public List<?> getEntries() {
        return getChildBeansByName("pactronics:entries");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:date")
    public Calendar getDate() {
        return getProperty("pactronics:date");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:image")
    public Pactronics getImage() {
        return getLinkedBean("pactronics:image", Pactronics.class);
    }
}
