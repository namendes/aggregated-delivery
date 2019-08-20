<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../starterstore-helper.ftl" as helper>
<#import "../starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>

<#if result??>
  <#assign orders = helper.resolveProperty(result, "orders", mappingResourceBundle) />
  <#if orders?? && orders.anyChildContained>
    <#assign ordersList = orders.children />
  </#if>
</#if>

<div class="col-xs-12">
  <#if !ordersList??>
    <div class="alert alert-info"><@fmt.message key="order.no.item"/></div>
  <#else>
    <table class="table table-responsive table-hover">
      <thead>
        <tr>
          <th><@fmt.message key="order.id.label"/></th>
          <th><@fmt.message key="order.state.label"/></th>
          <th><@fmt.message key="order.paymentstate.label"/></th>
          <th><@fmt.message key="order.shippingstate.label"/></th>
          <th><@fmt.message key="order.totalprice.label"/></th>
          <th><@fmt.message key="order.creation.label"/></th>
        </tr>
      </thead>
      <tbody>
        <#list ordersList.collection as orderItem>
          <tr data-toggle="collapse" data-target="#collapse-me-${orderItem?index}">
            <td>${helper.resolveProperty(orderItem, "order.id", mappingResourceBundle)!}</td>
            <td>${helper.resolveProperty(orderItem, "order.state", mappingResourceBundle)!}</td>
            <td>${helper.resolveProperty(orderItem, "order.paymentstate", mappingResourceBundle)!}</td>
            <td>${helper.resolveProperty(orderItem, "order.shippingstate", mappingResourceBundle)!}</td>
            <td><@productmacro.renderPrice orderItem mappingResourceBundle/></td>
            <td>${helper.resolveProperty(orderItem, "order.creation", mappingResourceBundle)!}</td>
          </tr>
          <tr id="collapse-me-${orderItem?index}" class="collapse">
            <td colspan="6">
              <#assign cartProductList = helper.resolveProperty(orderItem, "cart.productlist", mappingResourceBundle) />
              <#if cartProductList?? && cartProductList.anyChildContained>
                <#list cartProductList.children.collection as cartProductItem>
                  <div class="container">
                    <div class="row">
                      <@productmacro.renderCartItems cartProductItem mappingResourceBundle />
                    </div>
                  </div>
                </#list>
              </#if>
            </td>
          </tr>
        </#list>
      </tbody>
    </table>
  </#if>
</div>
