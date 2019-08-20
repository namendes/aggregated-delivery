<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Article" -->
<#include "../include/imports.ftl">

<#if pageable?? && pageable?has_content>
    <#assign contentlist = pageable.getItems()/>
      <div>
        <#list contentlist as document>
        <a href="<@hst.link hippobean=document/>">
            <h2>${document.title}</h2>
        </a>
            <#if editMode!false>
            <div style="position:relative"><@hst.manageContent hippobean=document /></div>
            </#if>
        <h3 style="font-weight: 300;"><@hst.html hippohtml=document.introduction/></h3>
        <hr/>
        </#list>
          <div style="clear: both;">
            <@hst.manageContent documentTemplateQuery="new-article-document" rootPath="articles"/>
            <#if cparam.showPagination?? && cparam.showPagination>
                <#include "../include/pagination.ftl">
            </#if>
          </div>
      </div>
</#if>