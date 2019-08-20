<#include "imports.ftl">

<#macro printDocument document showContent index=0 type="default">
    <#if document??>
        <div ${(type=="fittorow")?then('id="banner${index}" class="span_4 column"', '')}>
            <a href="${getLink(document)}">
                <figure style="position: relative">
                    <@hst.manageContent hippobean=document parameterName="document${index+1}" rootPath="banners"/>
                    <img src="<@hst.link hippobean=document.image />" alt="${document.title?html}"/>
                </figure>
                <#if showContent>
                    <p>
                        <@hst.html hippohtml=document.content />
                    </p>
                </#if>
            </a>
        </div>
    <#elseif editMode>
        <div>
            <figure style="position: relative">
                <@hst.manageContent documentTemplateQuery="new-banner-document" parameterName="document${index+1}" rootPath="banners"/>
                <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Banner
            </figure>
        </div>
    </#if>
</#macro>

<#macro printIcons document showContent index=0 type="default">
    <#if document??>
        <div ${(type=="fittorow")?then('id="banner${index}" class="span_4 column"', '')}>
            <a href="${getLink(document)}">
                <figure style="position: relative">
                    <@hst.manageContent hippobean=document parameterName="document${index+1}" rootPath="banners"/>
                    <img height="150px" src="<@hst.link hippobean=document.image />" alt="${document.title?html}"/>
                </figure>
                <#if showContent>
                    <p>
                        <@hst.html hippohtml=document.content />
                    </p>
                </#if>
            </a>
        </div>
    <#elseif editMode>
        <div>
            <figure style="position: relative">
                <@hst.manageContent documentTemplateQuery="new-banner-document" parameterName="document${index+1}" rootPath="banners"/>
                <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Banner
            </figure>
        </div>
    </#if>
</#macro>

<#function getLink banner>
    <@hst.link hippobean=banner.link var='link'/>
    <#if !link?? || link ="">
        <#local link=banner.externalLink!'' />
    </#if>
    <#return link>
</#function>