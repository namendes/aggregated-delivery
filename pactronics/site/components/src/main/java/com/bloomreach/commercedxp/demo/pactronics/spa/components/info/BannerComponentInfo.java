package com.bloomreach.commercedxp.demo.pactronics.spa.components.info;

import com.bloomreach.commercedxp.demo.pactronics.spa.components.info.providers.BannerTemplateProvider;
import org.hippoecm.hst.core.parameters.*;
import org.onehippo.cms7.essentials.components.info.EssentialsDocumentComponentInfo;

@FieldGroupList({
        @FieldGroup(value = {
                "template"
        }, titleKey = "template.selector"),
        @FieldGroup(value = {
                "document"
        }, titleKey = "options")
})
public interface BannerComponentInfo extends EssentialsDocumentComponentInfo {
    String CMS_PICKERS_DOCUMENTS_ONLY = "cms-pickers/documents-only";

    @Parameter(name = "document", required = true)
    @JcrPath(
            isRelative = true,
            pickerConfiguration = CMS_PICKERS_DOCUMENTS_ONLY,
            pickerSelectableNodeTypes = {"pactronics:bannerdocument"}
    )
    @Override
    String getDocument();

    @Parameter(name = "template", required = true, defaultValue = "full-width", description = "Template selector")
    @DropDownList(valueListProvider = BannerTemplateProvider.class)
    String getTemplate();
}
