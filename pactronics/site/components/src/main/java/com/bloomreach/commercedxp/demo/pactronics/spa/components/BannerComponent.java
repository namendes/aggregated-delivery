package com.bloomreach.commercedxp.demo.pactronics.spa.components;

import com.bloomreach.commercedxp.demo.pactronics.spa.components.info.BannerComponentInfo;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.onehippo.cms7.essentials.components.EssentialsDocumentComponent;

@ParametersInfo(type = BannerComponentInfo.class)
public class BannerComponent extends EssentialsDocumentComponent {

    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) {
        super.doBeforeRender(request, response);
    }
}
