package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

public interface ProductDecoratorInfo {


    @Parameter(
            name = "document",
            required = true
    )
    @JcrPath(
            isRelative = true,
            pickerConfiguration = "cms-pickers/documents",
            pickerSelectableNodeTypes = {"hippo:document"}
    )
    String getDocument();
}
