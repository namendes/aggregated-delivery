<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoDocument" -->
<#-- @ftlvariable name="mapping" type="java.lang.String" -->
<#include "../../include/imports.ftl">
<#import "../starterstore-helper.ftl" as helper>
<#import "../starterstore-productmacro.ftl" as productmacro>
<#import "../starterstore-pixel.ftl" as pixelmacro>

<@hst.setBundle basename="essentials.global"/>

<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <#list hstRequest.getAttribute("commerceResponseStatus").getItems() as item>
      <div class="alert alert-danger alert-dismissible" id="notification-" role="alert">
        ${item.message}
      </div>
    </#list>
</#if>

<#if result?? && mappingResourceBundle??>
    <#if document??>
        <@hst.link hippobean=document var="documentLink"/>
        <@hst.link hippobean=document.image var="image"/>
        <@hst.html hippohtml=document.description var="description"/>
        <@productmacro.renderFull
            document.title
            image!""
            description
            result
            mappingResourceBundle
            helper.resolveProperty(result, "product.id", mappingResourceBundle)!""
            documentLink/>
        <#if editMode>
            <div style="position: relative; top: 10px; right: 15px;">
                <@hst.manageContent hippobean=document/>
            </div>
        </#if>
    <#else>
        <@productmacro.renderFull
            helper.resolveProperty(result, "product.name", mappingResourceBundle)!""
            helper.resolveProperty(result, "product.image", mappingResourceBundle)!""
            helper.resolveProperty(result, "product.description", mappingResourceBundle)!""
            result
            mappingResourceBundle
            helper.resolveProperty(result, "product.id", mappingResourceBundle)!""/>
    </#if>
    <@pixelmacro.add result externalReferenceId helper.resolveProperty(result, "product.name", mappingResourceBundle)?html/>
    <#--Category: ${helper.resolveProperty(result, "product.category", mappingResourceBundle)!} -->
</#if>
<div class="col-md-12">
    <@hst.include ref="bottom"/>
</div>