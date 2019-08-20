package com.bloomreach.commercedxp.demo.pactronics.cms.targeting;

import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.request.resource.ResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.wicketstuff.js.ext.util.ExtClass;

import com.onehippo.cms7.targeting.frontend.plugin.TermsFrequencyCharacteristicPlugin;


@ExtClass("Hippo.Targeting.TermsFrequencyCharacteristicPlugin")
public class CategoriesCharacteristicPlugin extends TermsFrequencyCharacteristicPlugin {

    public CategoriesCharacteristicPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
    }

    @Override
    protected ResourceReference getIcon() {
        return new PackageResourceReference(CategoriesCharacteristicPlugin.class, "CategoriesCharacteristicPlugin.png");
    }

}
