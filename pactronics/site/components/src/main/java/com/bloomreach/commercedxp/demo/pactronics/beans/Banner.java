package com.bloomreach.commercedxp.demo.pactronics.beans;


import java.util.Optional;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.json.JSONArray;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;


@HippoEssentialsGenerated(internalName = "pactronics:bannerdocument")
@Node(jcrType = "pactronics:bannerdocument")
public class Banner extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:title")
    public String getTitle() {
        return getProperty("pactronics:title");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:content")
    public HippoHtml getContent() {
        return getHippoHtml("pactronics:content");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:link")
    public HippoBean getLink() {
        return getLinkedBean("pactronics:link", HippoBean.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:externalLink")
    public String getExternalLink() {
        return Optional.of(this).map(
                banner -> (String)banner.getProperty("pactronics:externalLink")
        ).orElse("");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:image")
    public Pactronics getImage() {
        return getLinkedBean("pactronics:image", Pactronics.class);
    }

    @HippoEssentialsGenerated(internalName = "pactronics:bynderImage")
    public String getBynderImage() {
        return Optional.of(this).map(
            banner -> (String)banner.getProperty("pactronics:bynderImage")
        ).map(
            JSONArray::new
        ).map(
            jsonArray -> jsonArray.getJSONObject(0)
        ).map(
            jsonObject -> jsonObject.getJSONObject("thumbnails")
        ).map(
            jsonObject -> jsonObject.getString("webimage")
        ).orElse("");
    }
    
}
