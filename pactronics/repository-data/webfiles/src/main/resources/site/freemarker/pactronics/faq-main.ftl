<#include "../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.FaqItem" -->
<#if document??>
<div class="has-edit-button">
  <@hst.manageContent hippobean=document/>
  <h1>${document.question?html}</h1>
  <@hst.html hippohtml=document.answer />
</div>
</#if>


