<#include "../include/imports.ftl">

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#-- @ftlvariable name="documents" type="java.util.List"-->

<#if documents??>
  <div class="row">
    <#list documents as document>
      <div class="col-sm-4 col-lg-4 col-md-4">
        <div>
          <#if editMode!false>
            <div style="position:relative"><@hst.manageContent hippobean=document/></div>
          </#if>
          <a href="<@hst.link hippobean=document />">
            <div class="center-cropped" style="background-image: url(<@hst.link hippobean=document.image />)">
            </div>
            <h4>${document.title}</h4>
          </a>
          <@hst.html hippohtml=document.description />
        </div>
      </div>
    </#list>
  </div>
<#elseif editMode>
  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/carousel.png'/>"> Click to edit the Highlight
  </div>
</#if>
