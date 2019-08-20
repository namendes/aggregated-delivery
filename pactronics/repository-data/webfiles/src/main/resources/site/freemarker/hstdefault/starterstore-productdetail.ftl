<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Productdecorator" -->
<#-- @ftlvariable name="beanResult" type="com.bloomreach.commercedxp.api.v2.connector.model.ItemModel" -->
<#-- @ftlvariable name="mapping" type="java.lang.String" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>
<#import "starterstore-pixel.ftl" as pixelmacro>

<@hst.setBundle basename="essentials.global"/>

<#macro productDetail id title="" description="" imagelink="" productlink="">
    <img class="img-responsive image-detail" src="${imagelink!}" alt=""/>
    <div class="pull-left" style="margin-right:50px; max-width:600px">
        <h4><a href="${productlink!"#"}">${title!}</a></h4>
        ${description!}
    </div>
</#macro>

<#if hstRequest.getAttribute("commerceResponseStatus")??>
    <#list hstRequest.getAttribute("commerceResponseStatus").getItems() as item>
      <div class="alert alert-danger alert-dismissible" id="notification-" role="alert">
        ${item.message}
      </div>
    </#list>
</#if>
<#if result??>
    <#include "v1/starterstore-productdetail.ftl"/>
</#if>
<#if beanResult??>
    <div class="col-xs-12">
        <#if document??>
            <@hst.link hippobean=document var="documentLink"/>
            <@hst.link hippobean=document.image var="image"/>
            <@hst.html hippohtml=document.description var="description"/>
            <@productDetail beanResult.id document.title description image documentLink/>
            <#if editMode>
                <div style="position: relative; top: 10px; right: 15px;">
                <@hst.manageContent hippobean=document/>
                </div>
            </#if>
        <#else>
            <@hst.link siteMapItemRefId="product" var="products"/>
            <#assign documentLink = (products+"/"+beanResult.code)/>
            <@productDetail beanResult.id beanResult.displayName beanResult.description beanResult.imageSet.original.selfLink.href documentLink/>
        </#if>
        <div class="pull-left">
            <#assign listPrice=beanResult.listPrice />
            <#assign purchasePrice=beanResult.purchasePrice />
            <#if listPrice??>
                <#assign moneyAmount=beanResult.listPrice.moneyAmounts[0] />
                <h4>${moneyAmount.displayValue!}</h4>
            </#if>
            <@hst.actionURL var="cartProductAddLink"/>
            <@productmacro.addToCartButton cartProductAddLink beanResult.id ""/>
        </div>
    </div>
    <@pixelmacro.add "" beanResult.id beanResult.displayName/>

</#if>
<div class="col-md-12">
    <@hst.include ref="bottom"/>
</div>