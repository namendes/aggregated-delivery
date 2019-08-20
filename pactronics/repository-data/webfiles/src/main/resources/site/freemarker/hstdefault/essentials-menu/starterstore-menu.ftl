<#include "../../include/imports.ftl">

<@hst.setBundle basename="essentials.global"/>

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->
<#if menu??>
  <@fmt.message key="footer.menu."+menu.name var="menuname"/>
  <p class="lead">${menuname?html}</p>
  <div class="has-edit-button">
      <#list menu.siteMenuItems as item>
        <#if !item.hstLink?? && !item.externalLink??>
          <#if item.selected || item.expanded>
              <div style="padding: 10px 15px;" class="list-group-item"><u>${item.name?html}</u></div>

          <#else>
              <div style="padding: 10px 15px;" class="list-group-item">${item.name?html}</div>
          </#if>
        <#else>
          <#if item.hstLink??>
            <#assign href><@hst.link link=item.hstLink/></#assign>
          <#elseif item.externalLink??>
            <#assign href>${item.externalLink?replace("\"", "")}</#assign>
          </#if>
          <#if  item.selected || item.expanded>
            <a href="${href}" class="list-group-item"><u>${item.name?html}</u></a>
          <#else>
            <a href="${href}" class="list-group-item">${item.name?html}</a>
          </#if>
        </#if>
      </#list>
    <@hst.cmseditmenu menu=menu/>
  </div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/menu.png" />"> Click to edit Menu
  </div>
</#if>