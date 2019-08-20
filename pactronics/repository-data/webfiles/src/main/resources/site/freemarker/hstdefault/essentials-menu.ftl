<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->
<#-- @ftlvariable name="externalInfoMap" type="java.util.Map" -->

<@hst.setBundle basename="essentials.global"/>
<@hst.setBundle basename=mapping var="context"/>
<style>

    .dropdown-menu-large {
        padding: 20px 0px;
    }

    .dropdown-menu-large > li > ul {
        padding: 0;
        margin: 0;
    }

    .dropdown-menu-large > li > ul > li {
        list-style: none;
    }

    .dropdown-menu-large > li > ul > li > a {
        display: block;
        padding: 3px 20px;
        clear: both;
        font-weight: normal;
        line-height: 1.428571429;
        color: red;
        white-space: normal;
    }

    .dropdown-menu-large > li ul > li > a:hover,
    .dropdown-menu-large > li ul > li > a:focus {
        text-decoration: none;
        color: #262626;
        background-color: green;
    }

    .dropdown-menu-large .disabled > a,
    .dropdown-menu-large .disabled > a:hover,
    .dropdown-menu-large .disabled > a:focus {
        color: red;
        background-color: green;
    }

    .dropdown-menu-large .disabled > a:hover,
    .dropdown-menu-large .disabled > a:focus {
        text-decoration: none;
        background-color: green;
        background-image: none;
        filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
        cursor: not-allowed;
    }

    .dropdown-menu-large .dropdown-header {
        color: #428bca;
        font-size: 18px;
    }

    .dropdown:hover .dropdown-menu {
        display: block;
    }

    @media (max-width: 768px) {
        .dropdown-menu-large {
            margin-left: 0;
            margin-right: 0;
        }

        .dropdown-menu-large > li {
            margin-bottom: 30px;
        }

        .dropdown-menu-large > li:last-child {
            margin-bottom: 0;
        }

        .dropdown-menu-large .dropdown-header {
            padding: 3px 15px !important;
        }
    }

</style>

<#assign MENU_ITEM_DIVIDER_LABEL = '-' />
<#assign curPageHref><@hst.link /></#assign>
<#assign categoriesBasePath><@hst.link siteMapItemRefId="categories"/></#assign>

<#macro renderMenuItem item level=0 mappingResourceBundle=mappingResourceBundle>
    <#local linkHref=curPageHref />
    <#local externalRefs = [] />
    <#local hasAnyMenuItemChild = false />
    <#local hasAnyExtResChild = false />
    <#local itemActive = false />
    <#local itemLabel = '' />
    <#local beanMappingResourceBundle = mappingResourceBundle/>

    <#if hst.isBeanType(item, 'org.onehippo.cms7.crisp.api.resource.Resource')>
        <#local linkHref = helper.generateLink(categoriesBasePath, helper.resolveProperty(item, "list.item.id", mappingResourceBundle)!"") />
        <#local itemLabel = helper.resolveProperty(item, "list.item.name", mappingResourceBundle) />
        <#if externalInfoMap??>
            <#local menuItemId = mappingResourceBundle["list.item.id"]!"id"/>
            <#local externalRefs = externalInfoMap['_category:' + item.valueMap[menuItemId]]![] />
        </#if>
        <#local hasAnyExtResChild = externalRefs?has_content />
    <#else>
        <#local hasAnyMenuItemChild = item.childMenuItems?has_content />
        <#local itemActive = item.selected || item.expanded />
        <#local itemLabel = item.name />

        <#if item.hstLink??>
            <#local basePath="/"+ hstRequestContext.siteContentBasePath />
            <#local bean = hstRequestContext.getObjectBeanManager().getObject(basePath + "/"+ item.hstLink.path)!"" />
            <#if bean?? && bean!= "" && bean.mappingResourceBundle??>
                <#local beanMappingResourceBundle = bean.mappingResourceBundle/>
            </#if>
            <#local linkHref><@hst.link link=item.hstLink/></#local>
            <#if externalInfoMap??>
                <#local externalRefs = externalInfoMap[item.hstLink.path]![] />
            </#if>
            <#local hasAnyExtResChild = externalRefs?has_content />
        <#elseif item.externalLink??>
            <#local linkHref>${item.externalLink?replace("\"", "")}</#local>
        </#if>
    </#if>

    <#local hasAnyChild = hasAnyMenuItemChild || hasAnyExtResChild />
    <#local isDivider = (itemLabel == MENU_ITEM_DIVIDER_LABEL) />

    <#if isDivider>
    <li class="divider"></li>
    <#else>
    <#-- Note: active menu selection is skipped for now because external reference menu items are hard to find which parent to be active at the moment. -->
    <li class="dropdown <#if level != 0 && hasAnyChild>dropdown-submenu</#if> <#-- if itemActive>active"</#if-->">
        <a href="${linkHref}" class="dropdown-toggle" data-toggle="dropdown"
        <#if linkHref?has_content>onclick="location.href='${linkHref}';"</#if>>
            ${itemLabel?html} <#if hasAnyChild><b class="caret"></b></#if>
        </a>
      <#if hasAnyChild>
        <ul class="dropdown-menu">
          <#if hasAnyMenuItemChild>
              <#list item.childMenuItems as childMenuItem>
                  <@renderMenuItem childMenuItem level+1 beanMappingResourceBundle/>
              </#list>
          </#if>
          <#if hasAnyExtResChild>
              <#list externalRefs as childExtResItem>
                  <@renderMenuItem childExtResItem level+1 beanMappingResourceBundle/>
              </#list>
          </#if>
        </ul>
      </#if>
    </li>
    </#if>
</#macro>

<#if menu??>
  <div role="navigation" class="col-md-8 col-sm-8 col-xs-12" style="padding-left: 0px; padding-right: 0px;">

      <#if menu??>tes</#if>


      <ul class="nav navbar-nav">

          <#list menu.siteMenuItems as item>
          <@renderMenuItem item />
          </#list>
          <@hst.cmseditmenu menu=menu/>
      </ul>
  </div>

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/menu.png" />"> Click to edit Menu
  </div>
</#if>
