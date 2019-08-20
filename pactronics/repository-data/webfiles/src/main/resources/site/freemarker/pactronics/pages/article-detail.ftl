<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Articledocument" -->
<#if document??>
    <@hst.manageContent hippobean=document />

            <div class="blog-post">
              <div class="carousel owl-carousel owl-theme mt20 mb20 owl-loaded owl-drag">
                <div class="owl-stage-outer owl-height" style="max-height: 477px;">
                  <div class="owl-stage" style="transform: translate3d(0px, 0px, 0px); transition: all 0s ease 0s;">
                    <div class="owl-item active" style="display: flex; justify-content: center;width: 100%;">
                      <#if document.image??>
                      <@hst.link var="img" hippobean=document.image/>
                        <picture>
                        <#if document.image??>
                            <source media="(min-width: 1200px)" srcset="${img}">
                        </#if>
                        <#if document.image.desktop??>
                            <@hst.link var="imgDesktop" hippobean=document.image.desktop/>
                            <source media="(min-width: 1000px)" srcset="${imgDesktop}">
                        </#if>
                        <#if document.image.laptop??>
                            <@hst.link var="imgLaptop" hippobean=document.image.laptop/>
                            <source media="(min-width: 800px)" srcset="${imgLaptop}">
                        </#if>
                        <#if document.image.tablet??>
                            <@hst.link var="imgTablet" hippobean=document.image.tablet/>
                            <source media="(min-width: 600px)" srcset="${imgTablet}">
                        </#if>
                        <#if document.image.mobile??>
                            <@hst.link var="img" hippobean=document.image.mobile/>
                        </#if>
                        <img src="${img}" class="img-responsive width100" alt="#">
                      </picture>
                      </#if>
                    </div>
                  </div>
                </div>
              </div>

              <div class="post-header">
                  <h3
                    style="    font-family: 'Montserrat', sans-serif;
                    /*color: #191a1c;*/
                    color: #262626;
                    font-weight: 700;">
                    <strong>${document.title?html}</strong>
                  </h3>
              </div>
                <@hst.html var="content" hippohtml=document.content/>
              <p>${content}</p>

            </div>


    <#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
    <#elseif editMode>
  <div class="has-edit-button">
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/simple-content.png" />"> Click to edit Article
    <@hst.manageContent documentTemplateQuery="new-articledocument-document" parameterName="document" rootPath="articles"/>
  </div>
</#if>