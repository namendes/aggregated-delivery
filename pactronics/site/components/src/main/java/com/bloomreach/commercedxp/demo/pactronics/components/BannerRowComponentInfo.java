package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(value = {
                "document1", "document2", "document3"
        }, titleKey = "documents"),
        @FieldGroup(value = {
                "Show Content"
        }, titleKey = "options")
})
public interface BannerRowComponentInfo {


    @Parameter(
            name = "document1",
            required = true
    )
    @JcrPath(
            isRelative = true,
            pickerConfiguration = "cms-pickers/documents",
            pickerSelectableNodeTypes = {"pactronics:bannerdocument"}
    )
    String getDocument1();

    @Parameter(
            name = "document2",
            required = true
    )
    @JcrPath(
            isRelative = true,
            pickerConfiguration = "cms-pickers/documents",
            pickerSelectableNodeTypes = {"pactronics:bannerdocument"}
    )
    String getDocument2();


    @Parameter(
            name = "document3",
            required = true
    )
    @JcrPath(
            isRelative = true,
            pickerConfiguration = "cms-pickers/documents",
            pickerSelectableNodeTypes = {"pactronics:bannerdocument"}
    )
    String getDocument3();

    @Parameter(name = "Show Content", defaultValue = "false")
    Boolean getShowContent();

}
