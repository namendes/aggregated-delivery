<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<#include "../include/imports.ftl">

<#function resolveProperty item propertyName bundle>
    <#local propertyPath=bundle[propertyName]/>
    <#if propertyPath?? && propertyPath?has_content>
        <#list propertyPath?split(",") as propertyPathValue>
            <#if item.getValue(propertyPathValue?trim)??>
                <#return item.getValue(propertyPathValue?trim)/>
            </#if>
        </#list>
        <#return item[propertyPath]!"">
    <#else>
        <#return item.getValue(propertyName)!null>
    </#if>
</#function>

<#function generateLink basePath subPath>
    <#if basePath?ends_with("/")>
        <#return basePath+subPath>
    <#else>
        <#return basePath+"/"+subPath>
    </#if>
</#function>

<#function addParameterToLink link hstRequest paramname value appendQueryString=true>
    <#local queryString = appendQueryString?then(hstRequest.queryString!"", "")/>
    <#local paramValue = hstRequest.getAttribute(paramname)!"" />
    <#local paramToAdd = paramname+"="+value/>

    <#if queryString?? && !queryString?has_content>
        <#return link+"?"+paramToAdd>
    <#elseif queryString?contains(paramToAdd)>
        <#return link+"?"+queryString>
    <#else>
        <#return link+"?"+queryString+"&"+paramToAdd>
    </#if>
</#function>

<#function addFacetParameterToLink link hstRequest paramname facetname value>
    <#local queryString = hstRequest.queryString!"" />
    <#local paramValue = hstRequest.getAttribute(paramname)!"" />
    <#local facetquery = paramname+"="+facetname+":\""+value?url('UTF-8')+"\""/>
    <#local paramToAdd = paramname+"="+facetname+"%3A%22"+value?url('UTF-8')+"%22"/>

    <#if queryString?? && !queryString?has_content>
        <#return link+"?"+paramToAdd>
    <#elseif !paramValue?? || !paramValue?contains(facetquery)>
        <#return link+"?"+queryString+"&"+paramToAdd>
    <#else>
        <#return link+"?"+queryString>
    </#if>
</#function>

<#function removeFacetParameterToLink link hstRequest paramname facetname value>
    <#local queryString = hstRequest.queryString!"" />
    <#local paramValue = hstRequest.getAttribute(paramname)!"" />
    <#local facetquery = paramname+"="+facetname+":\""+value?url('UTF-8')+"\""/>
    <#local paramToRemove = paramname+"="+facetname+"%3A%22"+value?url('UTF-8')+"%22"/>
    <#if queryString?? && !queryString?has_content>
        <#return link>
    <#elseif !paramValue??>
        <#return link+"?"+queryString>
    <#else>
        <#local cleanedQueryString = (queryString?replace("[&?]?"+paramToRemove, "", "r")?replace("[&?]?"+paramToRemove?replace("%20", "+"), "", "r")) />
        <#return link+cleanedQueryString?has_content?then("?"+cleanedQueryString, cleanedQueryString) />
    </#if>
</#function>