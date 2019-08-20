<#include "../include/imports.ftl">
<#import "starterstore-productmacro.ftl" as productmacro>

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

<#if documents?? && documents?has_content>

  <div class="row">
    <#list documents as document>
      <div class="col-sm-4 col-lg-4 col-md-4">
        <div>

          <#if editMode!false>
            <div style="position:relative"><@hst.cmseditlink hippobean=document/></div>
          </#if>

          <a href="<@hst.link hippobean=document />">
            <div class="center-cropped" style="background-image: url(<@hst.link hippobean=document.image />)">
            </div>
            <h4>${document.title}</h4>
          </a>

          <@hst.html hippohtml=document.description />

          <#assign productCode=document.firstRelatedexdocid! />

          <#if productCode?has_content>
            <#if productItems?? && productItems[productCode]??>
              <#assign productItem=productItems[productCode] />
              <b><@productmacro.renderItemPrice productItem /></b>
            <#elseif extDocuments?? && extDocuments[productCode]??>
              <#assign extDocument=extDocuments[productCode] />
              <b><@productmacro.renderPrice extDocument document.mappingResourceBundle/></b>
            </#if>
            <@hst.actionURL var="cartProductAddLink"/>
            <@productmacro.addToCartButton cartProductAddLink productCode className/>
          </#if>

        </div>
      </div>
    </#list>
  </div>

<#elseif editMode>

  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/carousel.png'/>"> Click to edit the Products Highlight
  </div>
  <div class="has-new-content-button">
    <@hst.manageContent documentTemplateQuery="new-productdecorator-document" parameterName="document1" rootPath="products"/>
  </div>

</#if>
