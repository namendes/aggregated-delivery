<#include "../../include/imports.ftl">
<#import "../starterstore-productmacro.ftl" as productmacro>

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.boot.beans.HippoDocument" -->
<#-- @ftlvariable name="documents" type="java.util.List" -->
<#-- @ftlvariable name="extDocuments" type="java.util.Map " -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsCarouselComponentInfo" -->

<#if hstRequest.getAttribute("commerceResponseStatus")??>
  <#list hstRequest.getAttribute("commerceResponseStatus").getItems() as item>
    <div class="alert alert-danger alert-dismissible" role="alert">
      ${item.message}
    </div>
  </#list>
</#if>

<#assign componentId><@hst.namespace/></#assign>

<#if documents?? && documents?has_content>
  <#if cparam.pause>
    <#assign pauseCarousel = 'hover'/>
  <#else>
    <#assign pauseCarousel = ''/>
  </#if>
  <div id="${componentId}" class="carousel slide" data-ride="carousel" data-interval="${cparam.interval?c}"
       data-pause="${pauseCarousel}" data-wrap="${cparam.cycle?string}">
    <div class="carousel-inner">
      <#list documents as document>
        <#if document?index==0>
          <#assign active = ' active'/>
        <#else>
          <#assign active = ''/>
        </#if>

        <div class="item${active}">
          <@hst.manageContent hippobean=document/>
          <img src="<@hst.link hippobean=document.image />" alt="${document.title?html}"/>

          <div class="carousel-caption">
            <h3><a href="<@hst.link hippobean=document/>">${document.title?html}</a></h3>
            <@hst.html hippohtml=document.description/>

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
    <#if cparam.showNavigation>
      <a class="left carousel-control" href="#${componentId}" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
      <a class="right carousel-control" href="#${componentId}" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </#if>
  <#--
    The Carousel component is initialized on page-load by means of the data attributes. However, when the
    channel-manager redraws a container (after actions like adding, removing or reordering components) it will only
    do a page reload if one of the affected components adds a headContribution that has not been processed yet
    (see HSTTWO-3747). To ensure it is also initialiazed when the page is *not* reloaded, the following snippet is
    used.
  -->
    <#if editMode>
      <script type="text/javascript">
        if (window.jQuery && window.jQuery.fn.carousel) {
          jQuery('#${componentId}').carousel();
        }
      </script>
    </#if>
  </div>

  <@hst.headContribution category="htmlHead">
    <style type="text/css">
      /* Carousel base class */
      #${componentId} {
        height: ${cparam.carouselHeight}px;
        margin-bottom: 60px;
      }

      /* Since positioning the image, we need to help out the caption */
      .carousel-caption {
        z-index: 10;
        background: rgba(51, 122, 183, 0.7);
      }

      /* Declare heights because of positioning of img element */
      #${componentId} .item {
        height: ${cparam.carouselHeight}px;
        background-color: ${cparam.carouselBackgroundColor};
      }

      /* center images*/
      .carousel-inner > .item > img {
        margin: 0 auto;
      }

      .carousel-caption a {
        color: white;
      }
    </style>
  </@hst.headContribution>

<#elseif editMode>

  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/carousel.png'/>"> Click to edit the Products Highlight
  </div>
  <div class="has-new-content-button">
    <@hst.manageContent documentTemplateQuery="new-productdecorator-document" parameterName="document1" rootPath="products"/>
  </div>

</#if>
