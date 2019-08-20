<#include "imports.ftl">

<#macro printProductFeature document type="default" >
    <#if document??>
        <#if document.class.name == 'com.bloomreach.commercedxp.demo.pactronics.beans.Productfeature'>
            <#if editMode>
                <div class="bloomreach manage-product-feature">
                    <@hst.manageContent hippobean=document
                    documentTemplateQuery="new-productfeature-document"
                    parameterName="document"
                    rootPath="product-experience/product-features"/>
                </div>
            </#if>
            <#switch type>
                <#case "two-column">
                    <div class="bloomreach container">
                        <div class="product_feature_benefit row s-img-align-right s-bg-white">
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__text">
                                    <h2>${document.slogan}</h2>
                                    <p>${document.description}</p>
                                </div>
                            </div>
                            <@hst.link var="leftimg" hippobean=document.leftimage/>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__img-wrap">
                                    <img src="${leftimg}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#break>
                <#case "two-column-I">
                    <div class="bloomreach container">
                        <div class="product_feature_benefit row s-img-align-right s-bg-white">
                            <@hst.link var="leftimg" hippobean=document.leftimage/>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__img-wrap">
                                    <img src="${leftimg}"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__text">
                                    <h2>${document.slogan}</h2>
                                    <p>${document.description}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#break>
                <#case "two-column-square">
                    <div class=bloomreach container">
                        <div class="product_feature_benefit row s-img-align-right s-bg-white">
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__text">
                                    <h2>${document.slogan}</h2>
                                    <p>${document.description}</p>
                                </div>
                            </div>
                            <@hst.link var="leftimg" hippobean=document.leftimage/>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__img-wrap">
                                    <img style="border-radius: 0%" src="${leftimg}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#break>
                <#case "two-column-square-I">
                    <div class="bloomreach container">
                        <div class="product_feature_benefit row s-img-align-right s-bg-white">

                            <@hst.link var="leftimg" hippobean=document.leftimage/>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__img-wrap">
                                    <img style="border-radius: 0%" src="${leftimg}"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="product_feature_benefit__text">
                                    <h2>${document.slogan}</h2>
                                    <p>${document.description}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#break>
                <#default>
                    <div>
                        <section id="bloomreach product_details_section">
                            <div class="product_feature">
                                <h2>${document.slogan}</h2>
                                <p>${document.description}</p>
                                <@hst.link var="leftimg" hippobean=document.leftimage/>
                                <@hst.link var="centerimg" hippobean=document.centerimage/>
                                <@hst.link var="rightimg" hippobean=document.rightimage/>
                                <div class="modes">
                                    <div class="modes_card">
                                        <img src="${leftimg}"/>
                                        <h4>${document.leftcaption}</h4>
                                    </div>

                                    <div class="modes_card">
                                        <img src="${centerimg}"/>
                                        <h4>${document.centercaption}</h4>
                                    </div>

                                    <div class="modes_card">
                                        <img src="${rightimg}"/>
                                        <h4>${document.rightcaption}</h4>
                                    </div>
                                </div>
                        </section>
                    </div>
            </#switch>
        <#elseif editMode>
            <figure style="position: relative">
                <@hst.manageContent documentTemplateQuery="new-productfeature-document" parameterName="document" rootPath="product-experience/product-features"/>
                <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Selected document "${document.node.path}" is not of the correct type, please select or create a Product Feature document.
            </figure>
        </#if>
    <#elseif editMode>
        <div>
            <figure style="position: relative">
                <@hst.manageContent documentTemplateQuery="new-productfeature-document" parameterName="document" rootPath="product-experience/product-features"/>
                <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Product Feature
            </figure>
        </div>
    </#if>
</#macro>
