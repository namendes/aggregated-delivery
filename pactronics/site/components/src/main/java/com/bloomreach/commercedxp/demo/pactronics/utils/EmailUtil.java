package com.bloomreach.commercedxp.demo.pactronics.utils;

import com.onehippo.cms7.eforms.hst.model.Form;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.component.support.forms.FormMap;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.request.ComponentConfiguration;

public class EmailUtil {

    /*public static boolean sendEmail{
        final String htmlContent = createHTMLContent(request, config, form, map, mailText, template);
    }

    private String createHTMLContent(final HstRequest request,
                                     final ComponentConfiguration config,
                                     final Form form,
                                     final FormMap map,
                                     final String mailText,
                                     final String template) {

        //in case editor uses the template field (Mail Template field) in the e-forms, then it will used instead of the
        //default one (htmlTemplate). NOTE that in the first case, in order to include mail form data, they must be
        //explicitly specified
        if (!StringUtils.isEmpty(template)) {
            return getHtml(request, config, form, map, mailText, true, template);
        } else {
            // Get template
            String htmlTemplate = BehaviorUtils.getTemplate(FTL_TEMPLATE, "html");
            return getHtml(request, config, form, map, mailText, true, htmlTemplate);
        }
    }*/
}
