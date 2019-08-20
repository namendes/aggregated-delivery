package com.bloomreach.commercedxp.demo.pactronics.spa.channel;

import org.hippoecm.hst.configuration.channel.ChannelInfo;
import org.hippoecm.hst.core.parameters.FieldGroup;
import org.hippoecm.hst.core.parameters.FieldGroupList;
import org.hippoecm.hst.core.parameters.JcrPath;
import org.hippoecm.hst.core.parameters.Parameter;

@FieldGroupList({
        @FieldGroup(
                titleKey = "fields.channel",
                value = {"logo", "logoSmall", "logoAlternative"}
        )
})
public interface WebsiteInfo extends ChannelInfo {
    @Parameter(name = "logo")
    @JcrPath(
            pickerSelectableNodeTypes = {"hippogallery:imageset"},
            pickerInitialPath = "/content/gallery/logos"
    )
    String getLogoPath();

    @Parameter(name = "logoSmall")
    @JcrPath(
            pickerSelectableNodeTypes = {"hippogallery:imageset"},
            pickerInitialPath = "/content/gallery/logos"
    )
    String getLogoSmallPath();

    @Parameter(name = "logoAlternative")
    @JcrPath(
            pickerSelectableNodeTypes = {"hippogallery:imageset"},
            pickerInitialPath = "/content/gallery/logos"
    )
    String getLogoAlternativePath();
}