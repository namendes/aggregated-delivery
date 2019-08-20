<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Video" -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsVideoComponentInfo"--%> -->
<#if document??>
<section id="product_details_section">
  <div style="margin-bottom:50px">
    <iframe style="width:${cparam.width?replace("," "")}px; height:${cparam.height?replace("," "")}px; max-width: 100%" src="${document.link?html}" frameborder="0" allowfullscreen></iframe>
  </div>
</section>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/video.png" />"> Click to edit Video
  </div>
</#if>
