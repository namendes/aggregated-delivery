<#include "../include/imports.ftl">
<#include "../include/banner-util.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<#if document??>
  <div>
    <#if document.class.name == 'com.bloomreach.commercedxp.demo.pactronics.beans.Banner'>
      <a href="${getLink(document)}" style="text-decoration: none">
        <figure style="position: relative">
          <@hst.manageContent hippobean=document parameterName="document" rootPath="banners"/>
          <section id="product_details_section">
            <div class="product_feature">
              <#if document.title??>
                <h2 style="text-align: center">${document.title?html}</h2>
              </#if>
              <p style="text-align: center"><@hst.html hippohtml=document.content/></p>
              <div class="pic_banner" style="text-align: center">
                <img src="<@hst.link hippobean=document.image />" alt="${document.title?html}"/>
              </div>
          </section>
        </figure>
      </a>
    <#elseif editMode>
      <figure style="position: relative">
        <@hst.manageContent documentTemplateQuery="new-banner-document" parameterName="document" rootPath="banners"/>
        <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Selected document "${document.node.path}" is not of the correct type, please select or create a Banner document.
      </figure>
    </#if>
  </div>
<#elseif editMode>
  <div>
    <figure style="position: relative">
      <@hst.manageContent documentTemplateQuery="new-banner-document" parameterName="document" rootPath="banners"/>
      <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Banner
    </figure>
  </div>
</#if>

