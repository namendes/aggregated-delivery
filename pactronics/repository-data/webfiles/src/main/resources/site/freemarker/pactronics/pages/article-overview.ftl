<#include "../../include/imports.ftl">


<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#if pageable?? && pageable.items?has_content>
        <ul class="blog-list">
            <#list pageable.items as item>
            <li class="row vertical-align">
                <#if item.title??>
                    <#assign linkName=item.title>
                </#if>
                <@hst.manageContent hippobean=item />
                <@hst.link var="link" hippobean=item canonical=true/>
                <@hst.link var="img" hippobean=item.image/>
              <div class="col-md-6 mt20 mb20">
                <#if img?? >
                    <a href="${link}"><img src="${img}" class="img-responsive width100" alt="#"></a>
                </#if>
              </div>
              <div class="col-md-6">
                <div class="post-header">
                    <#if item.tags?has_content>
                        <h5><span>In</span><strong> ${item.tags[0]}</strong></h5>
                    </#if>
                  <a href="${link}"><h3><strong>${linkName?html}</strong></h3></a>
                </div>
                <#if item.introduction??>
                  <p><@hst.html hippohtml=item.introduction/></p>
                </#if>
              </div>
            </li>
            </#list>
        </ul>
        <div class="has-new-content-button">
            <@hst.manageContent documentTemplateQuery="new-article-document" rootPath="buying-guides"/>
        </div>
<#if cparam.showPagination>
    <#include "../../include/pagination.ftl">
</#if>

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/generic-list.png'/>"> Click to edit Generic List
  </div>
</#if>