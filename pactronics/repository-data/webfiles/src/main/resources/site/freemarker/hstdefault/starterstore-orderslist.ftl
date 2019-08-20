<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="beanResult" type="java.util.Collection<com.bloomreach.commercedxp.api.v2.connector.model.CustomerModel>" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>
<#if beanResult??>
<div class="col-xs-12">
  <#if beanResult?size == 0>
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
      <#list beanResult as order>
        <tr data-toggle="collapse" data-target="#collapse-me-${order?index}">
          <td>${order.id!}</td>
          <td>${order.status!}</td>
          <td></td>
          <td></td>
          <td>
            <#list order.totalAmount as total>
              ${total.displayValue}
            </#list>
          </td>
          <td>${order.creationDate.time?datetime}</td>
        </tr>
        <tr id="collapse-me-${order?index}" class="collapse">
          <td colspan="6">
          </td>
        </tr>
      </#list>
      </tbody>
    </table>
  </#if>
</div>
<#else>
  <#include "v1/starterstore-orderslist.ftl" />
</#if>


