<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoDocument" -->
<#-- @ftlvariable name="mappingResourceBundle" type="java.lang.String" -->
<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>
<#import "starterstore-genericmacro.ftl" as genericmacro>

<@hst.include ref="top-container" />

<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <@genericmacro.notify hstRequest.getAttribute("commerceResponseStatus")/>
</#if>


<#if result?? && mappingResourceBundle??>

    <#if document??>

    <div class="bloomreach container" style="text-align: center;">
      <div class="row" style="display: flex">
        <@hst.link hippobean=document.image var="image"/>
        <@hst.html hippohtml=document.description var="description"/>
        <@productmacro.renderFull
        document.title
        image!""
        description
        result
        mappingResourceBundle
        helper.resolveProperty(result, "product.id", mappingResourceBundle)!""/>
      </div>
    </div>

    <#else>

      <div class="bloomreach container">

        <@productmacro.renderFullNonExperience
        helper.resolveProperty(result, "product.name", mappingResourceBundle)!""
        helper.resolveProperty(result, "product.image", mappingResourceBundle)!""
        helper.resolveProperty(result, "product.description", mappingResourceBundle)!""
        result
        mappingResourceBundle
        result.getValue("response/docs[1]/pid")/>
      </div>
    </#if>

<#--Category: ${helper.resolveProperty(result, "product.category", mappingResourceBundle)!} -->
</#if>

<@hst.headContribution category="pixelInjection">
<script type="text/javascript">

  var prodId = "${result.getValue("response/docs[1]/pid")}";
  var prodName = "${helper.resolveProperty(result, "product.name", mappingResourceBundle)}";

  if (br_data) {

    br_data.ptype = "product";
    br_data.prod_id = prodId;
    br_data.prod_name = prodName;

  }
</script>
</@hst.headContribution>

<@hst.include ref="bottom-container" />
