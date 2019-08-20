<#-- @ftlvariable name="facets" type="org.hippoecm.hst.content.beans.standard.HippoFacetNavigationBean" -->
<#include "../include/imports.ftl">

<#if facets?? && facets?has_content>
  <#list facets.folders as facet>
    <div class="col-lg-4">
      <h3>${facet.name?html}</h3>
      <div>
        <ul>
          <#list facet.folders as value>
            <#if value.count &gt; 0>
                <#if value.leaf>
                    <@hst.facetnavigationlink var="link" remove=value current=facets />
                    <li><a href="${link}" class="remove">${value.name?html}<i class="fa fa-times"></i></a></li>
                <#else>
                    <@hst.link var="link" hippobean=value />
                    <li><a href="${link}">${value.name?html}&nbsp;(${value.count})</a></li>
                </#if>
            </#if>
          </#list>
        </ul>
      </div>
    </div>
  </#list>
</#if>