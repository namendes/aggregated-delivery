package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.parameters.Parameter;

public interface SimpleTextComponentInfo {

    @Parameter(name = "text")
    String getText();
}