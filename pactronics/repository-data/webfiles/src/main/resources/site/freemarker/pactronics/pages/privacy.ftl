<#include "../../include/imports.ftl">


<#if document??>
    <@hst.manageContent hippobean=document />
    <h3 style="color:#337ab7;">${document.title?html}</h3>

    <p><b><i>${document.introduction}</i></b></p>

    <@hst.html var="content" hippohtml=document.content/>
    <p>${content}</p>

<#elseif editMode>
  <p>no document</p>
</#if>
