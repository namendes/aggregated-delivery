<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../starterstore-helper.ftl" as helper>
<#import "../starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>

<@hst.headContribution category="scripts">
<script type="text/javascript">

    $("#confirmShipment").click(function(){
      $.ajax({
        <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
        url: "${hstRequestContext.servletContext.contextPath}/restservices/checkouts/shipmentAddresses",
        <#else>
        url: "/restservices/checkouts/shipmentAddresses",
        </#if>
        method: "POST",
        dataType: "json",
        data: JSON.stringify({
          "shippingAddress": "${customerDefaultBillingAddress.shippingAddress?then("true", "false")}",
          "billingAddress": "${customerDefaultBillingAddress.billingAddress?then("true", "false")}",
          "streetNumber": "${customerDefaultBillingAddress.streetNumber!}",
          "streetName": "${customerDefaultBillingAddress.streetName!}",
          "additionalStreetInfo": "${customerDefaultBillingAddress.additionalStreetInfo!}",
          "city": "${customerDefaultBillingAddress.city!}",
          "state": "${customerDefaultBillingAddress.state!}",
          "postalCode": "${customerDefaultBillingAddress.postalCode!}",
          "country": "${customerDefaultBillingAddress.country!}",
          "phone": "${customerDefaultBillingAddress.phone!}",
          "mobile": "${customerDefaultBillingAddress.mobile!}",
          "fax": "${customerDefaultBillingAddress.fax!}",
          "id": "${customerDefaultBillingAddress.id!}",
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
    <b><@fmt.message key='streetNumber' /></b>: ${customerDefaultBillingAddress.streetNumber!}<br/>
    <b><@fmt.message key='streetName' /></b>: ${customerDefaultBillingAddress.streetName!}<br/>
    <b><@fmt.message key='additionalStreetInfo' /></b>: ${customerDefaultBillingAddress.additionalStreetInfo!}<br/>
    <b><@fmt.message key='city' /></b>: ${customerDefaultBillingAddress.city!}<br/>
    <b><@fmt.message key='state' /></b>: ${customerDefaultBillingAddress.state!}<br/>
    <b><@fmt.message key='postalCode' /></b>: ${customerDefaultBillingAddress.postalCode!}<br/>
    <b><@fmt.message key='country' /></b>: ${customerDefaultBillingAddress.country!}<br/>
    <b><@fmt.message key='phone' /></b>: ${customerDefaultBillingAddress.phone!}<br/>
    <b><@fmt.message key='mobile' /></b>: ${customerDefaultBillingAddress.mobile!}<br/>
    <b><@fmt.message key='fax' /></b>: ${customerDefaultBillingAddress.fax!}<br/>
</div>
<br/>
<div><@fmt.message key='changeDefaultShipmentAddress' /></div>
<br/>
<button id="confirmShipment"><@fmt.message key='confirmShipment'/></button>
