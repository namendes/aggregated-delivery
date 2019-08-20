package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.onehippo.cms7.essentials.components.CommonComponent;

@ParametersInfo(type = ProductSpecsComponentInfo.class)
public class ProductSpecsComponent extends CommonComponent {
    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) {
        super.doBeforeRender(request, response);
        request.setAttribute(REQUEST_ATTR_PARAM_INFO, getComponentParametersInfo(request));
    }
}
