<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="orderDraft" type="com.bloomreach.commercedxp.api.v2.connector.model.OrderModel" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>
<#if orderDraft??>
  <#if !orderDraft.shippingAddresses?has_content>
    <div class="alert alert-info"><@fmt.message key="order.no.shipping.address"/></div>
  <#else>
    <#list orderDraft.shippingAddresses as key, customerShippingAddresses>
        <#list customerShippingAddresses as customerShippingAddress>
            <@hst.setBundle basename="checkout"/>

            <@hst.headContribution category="scripts">
            <script type="text/javascript">

                $("#confirmShipment").click(function(){
                  $.ajax({
                    <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
                    url: "${hstRequestContext.servletContext.contextPath}/restservices/orders/shipmentAddresses/${key}",
                    <#else>
                    url: "/restservices/orders/shipmentAddresses/${key}",
                    </#if>
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({
                      "id": "${customerShippingAddress.id!}",
                      "streetName": "${customerShippingAddress.streetAddress!}",
                      "city": "${customerShippingAddress.city!}",
                      "state": "${customerShippingAddress.state!}",
                      "postalCode": "${customerShippingAddress.postalCode!}",
                      "country": "${customerShippingAddress.country!}",
                    }),
                    headers: {
                      'Content-Type': 'application/json'
                    }
                  }).
                  done(function(result){
                    window.location.href = "<@hst.link siteMapItemRefId="payment"/>";
                  }).
                  fail(function(result){
                    alert("<@fmt.message key='genericErrorMessage' />");
                  });
                });

            </script>
            </@hst.headContribution>

            <h3><@fmt.message key='address.defaultshipment'/></h3>
            <div>
                <b><@fmt.message key='streetName' /></b>: ${customerShippingAddress.streetAddress!}<br/>
                <b><@fmt.message key='city' /></b>: ${customerShippingAddress.city!}<br/>
                <b><@fmt.message key='state' /></b>: ${customerShippingAddress.state!}<br/>
                <b><@fmt.message key='postalCode' /></b>: ${customerShippingAddress.postalCode!}<br/>
                <b><@fmt.message key='country' /></b>: ${customerShippingAddress.country!}<br/>
            </div>
            <br/>
            <div><@fmt.message key='changeDefaultShipmentAddress' /></div>
            <br/>
            <button id="confirmShipment"><@fmt.message key='confirmShipment'/></button>
        </#list>
    </#list>
  </#if>
<#else>
    <#include "v1/starterstore-shipment.ftl" />
</#if>