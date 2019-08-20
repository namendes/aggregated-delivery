package com.bloomreach.commercedxp.demo.pactronics.cms.targeting;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.wicketstuff.js.ext.util.ExtClass;

import com.onehippo.cms7.targeting.frontend.BaseVisitorDetailsPanel;

@ExtClass("Pactronics.CommercePanel")
public class CommercePanel extends BaseVisitorDetailsPanel {

    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(CommercePanel.class, "CommercePanel.js");

    public CommercePanel(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);

        response.render(JavaScriptHeaderItem.forReference(JS));
    }
}
