<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.relatedtoproduct" var="relatedToProduct"/>
<@fmt.message key="text.relatedtoseen" var="relatedToSeen"/>

<@hst.setBundle basename="starterstore.mapping.bloomreach" var="bloomreach"/>


<#macro printTitle>
    <h3>
        <strong>
            <#if productId?? && productId != "" >
                ${relatedToSeen}
            <#else>
                ${relatedToProduct}
            </#if>
        </strong>
    </h3>
</#macro>



<#if pageable?? && pageable?has_content>
    <#assign productlist = pageable.getItems()/>
    <#if productlist?size gt 0 >
        <@printTitle />
        <div id="bloomreach grid2">
            <div class="bloomreach row">
              <#if showFacets?? && showFacets=="on">
                <div class="col-md-3">
                    <#include "../hstdefault/starterstore-facetlist.ftl">
                </div>
              </#if>

                <div ${(showFacets?? && showFacets=="on")?then("class=\"col-md-9\"","")}>
                    <#list productlist as item>
                        <@productmacro.renderIntro item mappingResourceBundle/>
                    </#list>
                    <div style="clear: both;">
                        <#--<#if showPagination?? && showPagination=="on">
                          <#include "../include/pagination.ftl">
                        </#if>-->
                    </div>
                </div>
            </div>
        </div>
    </#if>
<#elseif result??>
    <#assign productlist = helper.resolveProperty(result, "productlist", mappingResourceBundle).children/>
    <#if productlist.size() gt 0>
        <@printTitle />
        <div id="bloomreach grid2">
            <div class="bloomreach row">
                <#list 0..productlist.size()-1 as index>
                    <@productmacro.renderIntro productlist.get(index) mappingResourceBundle/>
                </#list>
            </div>
        </div>
    </#if>
</#if>
