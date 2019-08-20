package com.bloomreach.commercedxp.demo.pactronics.spa.components.info.providers;

import org.hippoecm.hst.core.parameters.ValueListProvider;
import org.hippoecm.hst.resourcebundle.ResourceBundleUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

public class BannerTemplateProvider implements ValueListProvider {

    private static final String TEMPLATE_BUNDLE = "banner-templates";

    @Override
    public List<String> getValues() {
        ResourceBundle bundle = ResourceBundleUtils.getBundle(TEMPLATE_BUNDLE, null);
        return new ArrayList<String> (bundle.keySet());
    }

    @Override
    public String getDisplayValue(final String value) {
        return getDisplayValue(value, null);
    }

    @Override
    public String getDisplayValue(final String value, final Locale locale) {
        ResourceBundle bundle = ResourceBundleUtils.getBundle(TEMPLATE_BUNDLE, locale);
        final String displayValue = bundle.getString(value);
        return (displayValue != null) ? displayValue : value;
    }
}