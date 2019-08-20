<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoDocument" -->
<#-- @ftlvariable name="mapping" type="java.lang.String" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<#function getName >
    <#if document?? && document.title?has_content >
        <#return document.title >
    <#else>
        <#return hstRequest.requestContext.servletRequest.requestURI?split("/")?last />
    </#if>
</#function>

<#function getId >
    <#if document?? && document.externalCategories?has_content >
        <#return document.externalCategories?first >
    <#else>
        <#return hstRequest.requestContext.servletRequest.requestURI?split("/")?last />
    </#if>
</#function>

<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <#list hstRequest.getAttribute("commerceResponseStatus").getItems() as item>
        <div class="alert alert-danger alert-dismissible" id="notification-" role="alert">
            ${item.message}
        </div>
    </#list>
</#if>

<div style="position:relative;">
    <@hst.manageContent hippobean=document documentTemplateQuery="new-categorydecorator-document" parameterName="document" rootPath="categories"/>
</div>
<#if document??>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">

                <h1>${document.title}</h1>
                <@hst.html hippohtml=document.description/>
            </div>
        </div>
    </div>

</#if>


<#assign cName=getName() />
<#assign cId=getId() />


<@hst.include ref="product-list"/>
<@hst.headContribution category="pixelInjection">
    <script type="text/javascript">


      var categoryName = "${cName}";
      var categoryId = "${cId}";

      if (br_data) {

        br_data.ptype = "category";
        br_data.cat = categoryName;
        br_data.cat_id = categoryId;

      }
    </script>
</@hst.headContribution>


<@hst.setBundle basename="starterstore.mapping.bloomreach" var="bloomreach"/>

<#if pageable?? && pageable?has_content>
    <div class="bloomreach row">
        <#if showFacets?? && showFacets=="on">
            <div class="col-md-3" style="margin-top: 25px">
                <#include "starterstore-facetlist.ftl">
            </div>
        </#if>
        <#assign productlist = pageable.getItems()/>
        <div ${(showFacets?? && showFacets=="on")?then("class=\"col-md-9\"","")} style="margin-top:25px;">
            <#list productlist as item>
                <@productmacro.renderIntro item mappingResourceBundle/>
            </#list>
            <div style="clear: both;">
                <#if showPagination?? && showPagination=="on">
                    <#include "../include/pagination.ftl">
                </#if>
            </div>
        </div>

    </div>
<#elseif result??>
    <#assign productlist = helper.resolveProperty(result, "productlist", mappingResourceBundle).children/>
    <div class="row">
        <#list 0..productlist.size()-1 as index>
            <@productmacro.renderIntro productlist.get(index) mappingResourceBundle/>
        </#list>
    </div>
</#if>




