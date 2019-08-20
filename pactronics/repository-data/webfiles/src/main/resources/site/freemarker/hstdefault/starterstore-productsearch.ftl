<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->

<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<#if result?? && mappingResourceBundle??>
  <#assign productlist = pageable.getItems()/>

  <h3><@fmt.message key='results.for'/> ${starterstoreQueryParam_query!}</h3>

  <div class="row">
    <#list productlist as item>
      <@hst.actionURL var="cartProductAddLink"/>
      <@productmacro.renderIntro item mappingResourceBundle />
    </#list>
  </div>

  <#include "../include/pagination.ftl">
</#if>
