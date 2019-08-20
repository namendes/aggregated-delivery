<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>

<@hst.setBundle basename=mapping var="context"/>

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#-- @ftlvariable name="documents" type="java.util.List"-->

<#if documents??>
    <div class="row">
    <#list documents as document>
        <div class="col-sm-4 col-lg-4 col-md-4">
          <div>
            <#if editMode??>
                <div style="position:relative"><@hst.cmseditlink hippobean=document/></div>
            </#if>
            <@hst.link hippobean=document var="documentLink"/>
            <a href="${helper.addParameterToLink(documentLink , hstRequest, "_cc", context.resourceBundle["connector"], false)}">
                <div class="center-cropped"
                     style="background-image: url(<@hst.link hippobean=document.image />)">
                </div>
                <h4>${document.title}</h4>
            </a>
            <@hst.html hippohtml=document.description/>
          </div>
        </div>
    </#list>
    </div>
</#if>