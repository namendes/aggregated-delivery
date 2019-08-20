package com.bloomreach.commercedxp.demo.pactronics.components;

import com.google.common.base.Strings;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.onehippo.cms7.essentials.components.CommonComponent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ParametersInfo(type = BannerRowComponentInfo.class)
public class BannerRowComponent extends CommonComponent {

    private static final Logger LOGGER = LoggerFactory.getLogger(BannerRowComponent.class);

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) throws HstComponentException {
        super.doBeforeRender(request, response);
        BannerRowComponentInfo paramInfo = this.getComponentParametersInfo(request);
        String documentPath1 = paramInfo.getDocument1();
        /*LOGGER.debug("Calling EssentialsDocumentComponent for document path:  [{}]", documentPath1);*/
        String documentPath2 = paramInfo.getDocument2();
        /*LOGGER.debug("Calling EssentialsDocumentComponent for document path:  [{}]", documentPath1);*/
        String documentPath3 = paramInfo.getDocument3();
        /*LOGGER.debug("Calling EssentialsDocumentComponent for document path:  [{}]", documentPath1);*/
        this.setContentBeanForPath(documentPath1, "document1", request, response);
        this.setContentBeanForPath(documentPath2, "document2", request, response);
        this.setContentBeanForPath(documentPath3, "document3", request, response);
        request.setAttribute("cparam", paramInfo);
        request.setAttribute("showContent", paramInfo.getShowContent());
    }



    public void setContentBeanForPath(String documentPath, String attributeName, HstRequest request, HstResponse response) {
        HstRequestContext context = request.getRequestContext();
        if (!Strings.isNullOrEmpty(documentPath)) {
            HippoBean root = context.getSiteContentBaseBean();
            request.setModel(attributeName, root.getBean(documentPath));
        }

    }
}
