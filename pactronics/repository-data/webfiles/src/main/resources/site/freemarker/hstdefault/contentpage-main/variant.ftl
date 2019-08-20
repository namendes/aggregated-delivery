<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.boot.beans.ContentDocument" -->
<#if document??>
<article class="has-edit-button">
  <@hst.manageContent hippobean=document/>
  <h3>${document.title?html}
  </h3>
  <#if document.introduction??>
    <p class="lead">${document.introduction?html}</p>
  </#if>
  <@hst.html hippohtml=document.content/>
</article>
</#if>