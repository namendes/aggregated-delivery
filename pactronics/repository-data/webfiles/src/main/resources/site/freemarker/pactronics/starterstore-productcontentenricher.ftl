<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "starterstore-contentenrichermacro.ftl" as contentenrichermacro>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#-- @ftlvariable name="documents" type="java.util.List"-->
<#-- @ftlvariable name="extDocuments" type="java.util.Map " -->


<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <#list hstRequest.getAttribute("commerceResponseStatus").getItems() as item>
      <div class="alert alert-danger alert-dismissible" role="alert">
          ${item.message}
      </div>
    </#list>
</#if>


<#if document??>
    <#if hstRequest.getAttribute("commerceResponseStatus")??>
        <@genericmacro.notify hstRequest.getAttribute("commerceResponseStatus")/>
    </#if>

    <#if result?? && mappingResourceBundle??>
        <#if document??>
            <div class="container" style="position:relative; text-align: center; padding:0px; width: 100%;">
                <@hst.manageContent hippobean=document/>
              <div class="row" style="display: inline-block; width: inherit">
                <@hst.link hippobean=document.image var="image"/>
                <@hst.html hippohtml=document.description var="description"/>
                <@productmacro.renderFull
                document.title
                image!""
                description
                result
                mappingResourceBundle
                document.getFirstRelatedexdocid()/>
                <#--<div id="product_specs_strip" class="row">
                  <div class="col-sm-12 col-md-2">
                    <p>Overview</p>
                  </div>
                  <div class="col-sm-12 col-md-2">
                    <p>Video</p>
                  </div>
                  <div class="col-sm-12 col-md-2">
                    <p>Specs</p>
                  </div>
                  <div class="col-sm-12 col-md-2">
                    <p>Gallery</p>
                  </div>
                  <div class="col-sm-12 col-md-2">
                    <p>Reviews</p>
                  </div>
                  <div class="col-sm-12 col-md-2">
                    <p>Related</p>
                  </div>
                </div>-->
              </div>
            </div>
            <#assign additionalInfo><@contentenrichermacro.priceAndAddToCart document extDocuments "pull-right"/></#assign>
        </#if>
    </#if>

<#elseif editMode>
  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/starterstore-bloomreach-dxp.png'/>"> Click
    to edit the product decorator
  </div>
  <div class="has-new-content-button">
    <@hst.manageContent templateQuery="new-productdecorator-document" parameterName="document" rootPath="products"/>
  </div>
</#if>

<@hst.headContribution category="pixelInjection">
<script type="text/javascript">

  var prodId = "${result.getValue("response/docs[1]/pid")}";
  var prodName = "${result.getValue("response/docs[1]/title")?html}";

  if (br_data) {

    br_data.ptype = "product";
    br_data.prod_id = prodId;
    br_data.prod_name = prodName;

  }
</script>
</@hst.headContribution>

<#--<p>DOC - ${document.title}</p>-->
<#--<p>EXDOC - ${extDocuments[document.identifier]}</p>-->