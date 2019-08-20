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

@ExtClass("Pactronics.CommerceCategoriesCollectorPlugin")
public class CommerceCategoriesCollectorPlugin extends TermsFrequencyCollectorPlugin {

    Logger log = LoggerFactory.getLogger(CommerceCategoriesCollectorPlugin.class);
    private final List<JSONObject> categories;
    private static final JavaScriptResourceReference JS = new JavaScriptResourceReference(
            CommerceCategoriesCollectorPlugin.class, "CommerceCategoriesCollectorPlugin.js");

    public CommerceCategoriesCollectorPlugin(IPluginContext context, IPluginConfig config) {
        super(context, config);
        this.categories = Arrays.stream(config.getString("categories").split(",")).map(
                String::trim
        ).map( category -> {
                    JSONObject json = new JSONObject();
                    try {
                        json.put("name", category);
                        json.put("category", category);
                    } catch (JSONException jse) {
                        log.error("problem creating json object for category " + category, jse);
                    }
                    return json;
                }
        ).collect(Collectors.toList());
    }

    protected void onRenderProperties(JSONObject properties) throws JSONException {
        super.onRenderProperties(properties);
        if (this.categories != null) {
            properties.put("categories", this.categories);
        }
    }

    @Override
    public void renderHead(final Component component, final IHeaderResponse response) {
        super.renderHead(component, response);

        response.render(JavaScriptHeaderItem.forReference(JS));
    }
}