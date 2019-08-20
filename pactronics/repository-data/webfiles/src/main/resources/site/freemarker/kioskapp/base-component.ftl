<#include "../../include/imports.ftl">

<#-- This template only renders the name of the content model -->
<div>
    </br>
    <span><strong>Catalog item: ${hstRequest.componentWindow.componentName}</strong></span></br>
    <span style="position: relative;">
    <#if document??>
        <@hst.manageContent hippobean=document />
        ${document}
        <#if document.name?has_content>
          -  <a href="<@hst.link hippobean=document />">${document.name}</a>
            <@hst.manageContent hippobean=document />
        </#if>

    <#elseif pageable?? >
        <#list pageable.items as item>
            ${item.type}
          <#if item.name?has_content>
            -  <a href="<@hst.link hippobean=item />">${item.name}</a>
          </#if>
          </br>
            <@hst.manageContent hippobean=item />
        </#list >
    </#if>
    </span>
</div>