package com.bloomreach.commercedxp.demo.pactronics.cms.targeting;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.wicket.Component;
import org.apache.wicket.markup.head.IHeaderResponse;
import org.apache.wicket.markup.head.JavaScriptHeaderItem;
import org.apache.wicket.request.resource.JavaScriptResourceReference;
import org.hippoecm.frontend.plugin.IPluginContext;
import org.hippoecm.frontend.plugin.config.IPluginConfig;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.wicketstuff.js.ext.util.ExtClass;

import com.onehippo.cms7.targeting.frontend.plugin.TermsFrequencyCollectorPlugin;

@ExtClass("Pactronics.CommerceBrandsCollectorPlugin")
public class CommerceBrandsCollectorPlugin extends TermsFrequencyCollectorPlugin {

    Logger log = LoggerFactory.getLogger(CommerceBrandsCollectorPlugin.class);
    private final List<JSONObject> brands;
    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(
            CommerceBrandsCollectorPlugin.class, "CommerceBrandsCollectorPlugin.js");

    public CommerceBrandsCollectorPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
        this.brands = Arrays.stream(config.getString("brands").split(",")).map(
            String::trim
        ).map( brand -> {
            JSONObject json = new JSONObject();
            try {
                json.put("name", brand);
                json.put("brand", brand);
            } catch (JSONException jse) {
                log.error("problem creating json object for brand " + brand, jse);
            }
            return json;
            }
        ).collect(Collectors.toList());
    }

    protected void onRenderProperties(JSONObject properties) throws JSONException {
        super.onRenderProperties(properties);
        if (this.brands != null) {
            properties.put("brands", this.brands);
        }
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);

        response.render(JavaScriptHeaderItem.forReference(JS));
    }
}