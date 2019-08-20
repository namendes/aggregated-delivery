<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../../hstdefault/starterstore-helper.ftl" as helper>
<#import "../../hstdefault/starterstore-productmacro.ftl" as productmacro>
<#import "../morelikethis.ftl" as morelikethis>


<@hst.setBundle basename="starterstore.mapping.bloomreach" var="bloomreach"/>



<@morelikethis.printTitle />

<div id="grid2">


<#if pageable?? && pageable?has_content>
    <div class="row">
      <#if showFacets?? && showFacets=="on">
        <div class="col-md-3">
            <#include "../../hstdefault/starterstore-facetlist.ftl">
        </div>
      </#if>
      <#assign productlist = pageable.getItems()/>
        <div ${(showFacets?? && showFacets=="on")?then("class=\"col-md-9\"","")}>
            <#list productlist as item>
                <@productmacro.renderIntroCheckout item mappingResourceBundle/>
            </#list>
            <div style="clear: both;">
                <#--<#if showPagination?? && showPagination=="on">
                  <#include "../include/pagination.ftl">
                </#if>-->
            </div>
        </div>

    </div>
<#elseif result??>
    <#assign productlist = helper.resolveProperty(result, "productlist", mappingResourceBundle).children/>
    <div class="row">
        <#list 0..productlist.size()-1 as index>
            <@productmacro.renderIntroCheckout productlist.get(index) mappingResourceBundle/>
        </#list>
    </div>
</#if>
</div>