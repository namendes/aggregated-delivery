<#include "imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>

<#macro printProductList type="default" columns=3>
    <#if result??>
        <@printResults type columns/>
    <#elseif beanResult??>
        <@renderBeanResult type />
    </#if>
</#macro>

<#macro renderBeanResult type="default" columns=3>
    <div class="bloomreach row">
        <#if showFacets?? && showFacets=="on">
        <div class="col-md-3">
            <#include "../hstdefault/starterstore-facetlist.ftl">
        </div>
        <div class="product-wrapper col-md-9">
            </#if>
            <#list beanResult.collection as item>
                <div class="${getBootstrapClasses(columns)}" style="min-width: 270px">
                    <div class="bloomreach thumbnail">
                        <div class="center-cropped"
                             style="background-image: url('${item.imageSet.original.selfLink.href!}');">
                        </div>
                        <img src="" alt="">
                        <div class="caption">
                            <h4 class="pull-right"></h4>

                            <h4>
                                <@hst.link siteMapItemRefId="product" var="basePath"/>
                                <a href="${basePath!?ensure_ends_with("/")}${item.code!}">
                                    ${item.displayName!}
                                </a>
                            </h4>

                            <#if type == "addToCart">
                                <#assign listPrice=item.listPrice />
                                <#assign purchasePrice=item.purchasePrice />
                                <#if listPrice??>
                                    <#assign moneyAmount=item.listPrice.moneyAmounts[0] />
                                    <h4>${moneyAmount.displayValue!}</h4>
                                </#if>
                                <form action="<@hst.actionURL />" id="cart" method="POST" class="${className!}">
                                    <input type="hidden" id="_pid" name="_pid" value="${item.id!}"/>
                                    <input type="submit" class="bloomreach btn btn-primary" value="Add to Cart"/>
                                </form>
                            <#else>
                                <p>
                                    ${item.description!}
                                </p>
                            </#if>
                        </div>
                    </div>
                </div>
            </#list>

            <#if showPagination?? && showPagination=="on">
                <div style="clear: both;">
                    <#assign pageable = beanResult/>
                    <#include "pagination.ftl">
                </div>
            </#if>
            <#if showFacets?? && showFacets=="on">
        </div>
        </#if>
    </div>
</#macro>

<#macro printResults type="default" columns=3>
    <@hst.setBundle basename="starterstore.mapping.bloomreach" var="bloomreach"/>

    <#if pageable?? && pageable?has_content>
        <div class="bloomreach row">
            <#if showFacets?? && showFacets=="on">
                <div class="col-md-3">
                    <#include "../hstdefault/starterstore-facetlist.ftl">
                </div>
            </#if>
            <#assign productlist = pageable.getItems()/>
            <div class="bloomerach product-wrapper ${(showFacets?? &&  showFacets=="on")?then("col-md-9","")}">
                <#list productlist as item>
                    <#if type=="addToCart" >
                        <@hst.actionURL var="cartProductAddLink"/>
                        <@productmacro.renderIntroAtc item mappingResourceBundle cartProductAddLink getBootstrapClasses(columns)/>
                    <#else>
                        <@productmacro.renderIntro item mappingResourceBundle getBootstrapClasses(columns)/>
                    </#if>
                </#list>
                <div style="clear: both;">
                    <#if showPagination?? && showPagination=="on">
                        <#include "pagination.ftl">
                    </#if>
                </div>
            </div>

        </div>
    <#elseif result??>
        <#assign productlist = helper.resolveProperty(result, "productlist", mappingResourceBundle).children/>
        <div class="bloomreach row">
            <#list 0..productlist.size()-1 as index>
                <@productmacro.renderIntro productlist.get(index) mappingResourceBundle/>
            </#list>
        </div>
    </#if>
</#macro>

<#function getBootstrapClasses columns>
    <#assign width = 12/columns />
    <#return "col-sm-${width} col-lg-${width} col-md-${width}" >
</#function>
