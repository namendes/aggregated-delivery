<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoDocument" -->
<#-- @ftlvariable name="mappingResourceBundle" type="java.lang.String" -->
<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>
<#import "starterstore-genericmacro.ftl" as genericmacro>


<script src="<@hst.webfile path="/js/pactronics/jssor.slider-27.5.0.min.js"/>"></script>
<script src="<@hst.webfile path="/js/pactronics/carouselinit.js"/>"></script>
<link href="<@hst.webfile path="/css/brxforcdemo/carouseljs.css"/>" rel="stylesheet">



<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <@genericmacro.notify hstRequest.getAttribute("commerceResponseStatus")/>
</#if>


<#if document??>


<#elseif editMode>
  <div class="has-edit-button">
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/simple-content.png" />"> Click to select/add product decorator
    <@hst.manageContent documentTemplateQuery="new-productdecorator-document" parameterName="document" rootPath="products"/>
  </div>

</#if>