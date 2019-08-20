package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.component.support.bean.BaseHstComponent;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.ResolvedMount;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RequestInfoComponent extends BaseHstComponent {
  Logger logger = LoggerFactory.getLogger(RequestInfoComponent.class);

  @Override
  public void doBeforeRender(HstRequest request, HstResponse response)
      throws HstComponentException {
    super.doBeforeRender(request, response);

    ResolvedMount resolvedMount = request.getRequestContext().getResolvedMount();
    Mount mount = resolvedMount.getMount();
    request.setAttribute("cmsBaseURL", mount.getVirtualHost().getBaseURL(request));
//    request.setAttribute("cmsLocation", mount.getCmsLocations().get(0));
    request.setAttribute("cmsContextPath", mount.getContextPath());
    request.setAttribute("cmsHostname", mount.getVirtualHost().getHostName());
    request.setAttribute("cmsMountPath", mount.getMountPath());
    request.setAttribute("cmsPort", mount.getPort());
    request.setAttribute("cmsScheme", mount.getScheme());
  }
}
