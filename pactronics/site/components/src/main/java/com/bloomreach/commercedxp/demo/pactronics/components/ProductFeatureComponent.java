package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.onehippo.cms7.essentials.components.CommonComponent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = ProductFeatureComponentInfo.class)
public class ProductFeatureComponent extends CommonComponent {
    private static Logger log = LoggerFactory.getLogger(ProductFeatureComponent.class);

    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) {
        super.doBeforeRender(request, response);
        final ProductFeatureComponentInfo paramInfo = getComponentParametersInfo(request);
        final String documentPath = paramInfo.getProductFeatureDocument();

        log.debug("Calling EssentialsDocumentComponent for document path:  [{}]", documentPath);

        setContentBeanForPath(documentPath, request, response);
        request.setAttribute(REQUEST_ATTR_PARAM_INFO, paramInfo);
    }
}
