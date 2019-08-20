package com.bloomreach.commercedxp.demo.pactronics.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import java.util.List;
import com.bloomreach.commercedxp.demo.pactronics.beans.Searchresult;

@HippoEssentialsGenerated(internalName = "pactronics:googlesearch")
@Node(jcrType = "pactronics:googlesearch")
public class Googlesearch extends BaseDocument {
    @HippoEssentialsGenerated(internalName = "pactronics:searchterm")
    public String getSearchterm() {
        return getProperty("pactronics:searchterm");
    }

    @HippoEssentialsGenerated(internalName = "pactronics:result")
    public List<Searchresult> getResult() {
        return getChildBeansByName("pactronics:result", Searchresult.class);
    }
}
