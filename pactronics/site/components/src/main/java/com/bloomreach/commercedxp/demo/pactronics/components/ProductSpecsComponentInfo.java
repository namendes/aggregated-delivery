package com.bloomreach.commercedxp.demo.pactronics.components;

import org.hippoecm.hst.core.parameters.Parameter;
import org.onehippo.cms7.essentials.components.info.EssentialsDocumentComponentInfo;

public interface ProductSpecsComponentInfo {

    @Parameter(name = "dimensions")
    String getDimensions();

    @Parameter(name = "storage")
    String getStorage();

    @Parameter(name = "display")
    String getDisplay();

    @Parameter(name = "battery")
    String getBattery();

    @Parameter(name = "memory")
    String getMemory();

    @Parameter(name = "graphics")
    String getGraphics();

}