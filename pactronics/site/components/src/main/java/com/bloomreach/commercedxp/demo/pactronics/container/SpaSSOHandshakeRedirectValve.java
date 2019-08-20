package com.bloomreach.commercedxp.demo.pactronics.container;

import org.hippoecm.hst.container.valves.AbstractOrderableValve;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.container.ContainerException;
import org.hippoecm.hst.core.container.ValveContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;

public class SpaSSOHandshakeRedirectValve extends AbstractOrderableValve {
    @Override
    public void invoke(ValveContext context) throws ContainerException {
        try {
            HttpServletRequest servletRequest = context.getServletRequest();
            HttpServletResponse servletResponse = context.getServletResponse();

            if (context.getRequestContext().isCmsRequest() && hasPageModelProperty(context) && hasPublicRequestParameter(servletRequest, "org.hippoecm.hst.container.render_host")) {
                servletResponse.sendRedirect(context.getRequestContext().getServletRequest().getRequestURI());
            } else {
                context.invokeNext();
            }
        } catch (IOException e) {
            throw new HstComponentException("Could not redirect. ", e);
        }
    }

    private boolean hasPageModelProperty(final ValveContext context) {
        Optional<Boolean> pageModelApi = Optional.ofNullable(context.getRequestContext().getResolvedMount())
                .map(resolvedMount -> resolvedMount.getMount())
                .map(mount -> mount.getPropertyNames().contains("hst:pagemodelapi"));
        return pageModelApi.get();
    }


    public boolean hasPublicRequestParameter(HttpServletRequest request, String parameterName) {

        Map<String, String[]> namespaceLessParameters = request.getParameterMap();
        String[] paramValues = namespaceLessParameters.get(parameterName);

        if (paramValues != null && paramValues.length > 0) {
            return true;
        }

        return false;
    }
}
