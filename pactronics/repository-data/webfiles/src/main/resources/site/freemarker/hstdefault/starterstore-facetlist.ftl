<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>


<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->

<#if result??>
    <#assign facetResult=helper.resolveProperty(result, "facets", mappingResourceBundle) />
    <#if facetResult?? && (facetResult.getChildCount()>0) >
        <#assign facets=facetResult.children />
        <#list 0..facets.size()-1 as index>
            <#assign facetvalues={}/>
            <#assign canShowMore=false/>
            <#assign facetname=helper.resolveProperty(facets.get(index), "facet.name", mappingResourceBundle)/>
            <#if helper.resolveProperty(facets.get(index), "facet.values", mappingResourceBundle)??>
                <#assign facetvalues=helper.resolveProperty(facets.get(index), "facet.values", mappingResourceBundle).children/>
            <#elseif facets.get(index).isAnyChildContained() && facets.get(index).children?has_content>
                <#assign facetvalues=facets.get(index).children/>
            </#if>
            <#if facetvalues?has_content>
                <#if !facetname?contains("review") >
                    <#if facetvalues.size() gt 3>
                        <#assign initialFacets=2/>
                        <#assign canShowMore=true/>
                        <#assign facetsSize = facetvalues.size()-1/>
                    <#else>
                        <#assign initialFacets=facetvalues.size()-1/>
                    </#if>
                    <div class="title" align="center"><h4>${facetname!}</h4></div>
                    <div class="category-wrapper widget-categories">
                    <#list 0..initialFacets as facetindex>
                        <#if facetvalues?size gt facetindex>
                            <@renderFacet facetindex/>
                        </#if>
                    </#list>
                    <#if canShowMore>
                        <div id="${facetname}" style="display: none;">
                        <#list (initialFacets+1)..facetvalues.size()-1 as facetindex>
                            <#if facetvalues?size gt facetindex>
                                <@renderFacet facetindex/>
                            </#if>
                        </#list>
                        </div>
                      <p class="show-more" id="expand" onclick="showMore(this,${facetname})">Show more</p>
                    </#if>
                    </div>
                </#if>
            </#if>
        </#list>
        <@hst.headContribution category="htmlHead">
      <link rel="stylesheet" href="<@hst.webfile  path="/css/facets.css"/>" type="text/css"/>
        </@hst.headContribution>

        <@hst.headContribution category="htmlHead">
            <script>
              function showMore (e, id) {
                if (e.innerText === "Show less") {
                  e.innerText = "Show more";
                  id.style.display = 'none';
                } else {
                  e.innerText = "Show less";
                  id.style.display = 'block';
                }
              }
            </script>
        </@hst.headContribution>
    <#else>
        <div class="category-wrapper widget-categories"><h4>Facet navigation not available</h4></div>
    </#if>
</#if>


<#macro renderFacet facetindex>
    <#assign currentfacet = facetvalues.get(facetindex)/>
    <#assign facetvaluename = helper.resolveProperty(currentfacet, "facet.value.name", mappingResourceBundle)/>
    <#assign facetvalueid = (helper.resolveProperty(currentfacet, "facet.value.id", mappingResourceBundle)!"")?replace("\"", "\\\"")/>
    <#if !facetvalueid?? || !facetvalueid?has_content>
        <#assign facetvalueid = facetvaluename?replace("\"", "\\\"")/>
    </#if>
    <#assign facetvaluecount = helper.resolveProperty(currentfacet, "facet.value.count", mappingResourceBundle)/>
    <#assign facetparamname = mappingResourceBundle["facet.param.name"]/>
    <#assign facetparamvalue = hstRequest.getAttribute("starterstoreQueryParam_facetQuery")!""?replace("\"", "\\\"")/>

    <@hst.link var="currentlink" />
    <#if facetparamvalue?? && facetparamvalue?contains(facetname+":\""+facetvalueid+"\"")>
        <a class="category" href="${helper.removeFacetParameterToLink(currentlink, hstRequest, facetparamname, facetname, facetvalueid)?replace("page=[0-9]+", "page=1", "r")}"
           data-count="${facetvaluecount}">
          <span style="color: red">X
          </span>${facetvaluename}</a>
    <#else>
        <a class="category" href="${helper.addFacetParameterToLink(currentlink, hstRequest, facetparamname, facetname,facetvalueid)?replace("page=[0-9]+", "page=1", "r")}" data-count="${facetvaluecount}">
            ${facetvaluename}
        </a>
    </#if>
</#macro>
