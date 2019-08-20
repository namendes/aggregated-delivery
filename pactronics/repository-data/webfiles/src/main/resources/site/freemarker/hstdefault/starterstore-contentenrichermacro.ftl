<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<#macro contentHighlight document additionalInfo="">
<div class="col-sm-4 col-lg-4 col-md-4">
  <div>
    <#if editMode!false>
        <div style="position:relative"><@hst.cmseditlink hippobean=document/></div>
    </#if>
    <@hst.link hippobean=document var="documentLink"/>
    <a href="${documentLink}">
      <div class="center-cropped"
           style="background-image: url(<@hst.link hippobean=document.image />)">
      </div>
      <h4>${document.title}</h4>
    </a>
    <@hst.html hippohtml=document.description/>
    ${additionalInfo}
  </div>
</div>
</#macro>

<#macro priceAndAddToCart document extDocuments className="">
    <#if document.resource?? && document.resource.name??>
        <b><@productmacro.renderPrice extDocuments[document.identifier] document.mappingResourceBundle/></b>
        <#if document.relatedexdocids?? && document.relatedexdocids?has_content>
            <@hst.actionURL var="cartProductAddLink"/>
            <@productmacro.addToCartButton cartProductAddLink document.relatedexdocids[0] className/>
        </#if>
    </#if>
</#macro>
