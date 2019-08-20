<#include "../../include/imports.ftl">

<#if document??>
<div class="col-md-6">
    <@hst.manageContent hippobean=document />
    <h2>${document.title?html}</h2>

    <@hst.html var="content" hippohtml=document.content/>
    <p>${content}</p>
</div>
<#elseif editMode>
  <div class="has-edit-button">
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/simple-content.png" />"> Click to edit Document
  </div></#if>
