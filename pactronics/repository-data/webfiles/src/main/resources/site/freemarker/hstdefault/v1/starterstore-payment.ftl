<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../starterstore-helper.ftl" as helper>
<#import "../starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>

<@hst.headContribution category="scripts">
<script type="text/javascript">

  $("#confirmPayment").click(function () {
    $.ajax({
      <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
      url: "${hstRequestContext.servletContext.contextPath}/restservices/checkouts/paymentRegistrations",
      <#else>
      url: "/restservices/checkouts/paymentRegistrations",
      </#if>
      method: "POST",
      data: "cartId=${cartId!}"
    }).done(function () {
        $.ajax({
          <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
          url: "${hstRequestContext.servletContext.contextPath}/restservices/checkouts/orderRegistrations",
          <#else>
          url: "/restservices/checkouts/orderRegistrations",
          </#if>
          method: "POST",
          data: "cartId=${cartId!}"
        }).done(function () {
          window.location.href = "<@hst.link siteMapItemRefId="order"/>";
        }).fail(function () {
          alert("<@fmt.message key='genericErrorMessage' />");
        });
      }
    ).fail(function () {
      alert("<@fmt.message key='genericErrorMessage' />");
    });
  });

</script>
</@hst.headContribution>
<h3>Payment</h3>
<div>
    <pre>
<h4>Add your payment provider integration!</h4>
The Snippet below represents the current implementation of the payment process, but <b>it's not complete</b>!
At the moment the payment process only registers the payment in the e-commerce.

To complete the payment process, you have at least two options:
  1. Client side integration, basically integrating the payment process in (or as part of) ajax callback
  2. Server side integration, changing the implementation of CheckoutResource

  $("#confirmPayment").click(function () {
    //You can add your client side payment integration here, before invoking the backend
    $.ajax({
      <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
          url: "${hstRequestContext.servletContext.contextPath}/restservices/checkouts/paymentRegistrations",
      <#else>
          url: "/restservices/checkouts/paymentRegistrations",
      </#if>
      method: "POST",
      data: "cartId=${cartId!}"
    }).done(function () {
        $.ajax({
          <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
              url: "${hstRequestContext.servletContext.contextPath}/restservices/checkouts/orderRegistrations",
          <#else>
              url: "/restservices/checkouts/orderRegistrations",
          </#if>
          method: "POST",
          data: "cartId=${cartId!}"
        }).done(function () {
          window.location.href = "<@hst.link siteMapItemRefId="order"/>";
        }).fail(function () {
          alert("<@fmt.message key='genericErrorMessage' />");
        });
      }
    ).fail(function () {
      alert("<@fmt.message key='genericErrorMessage' />");
    });
  });

<b>If you press </b>the Confirm Payment button, then the payment will be *only* registered in the e-commerce system and the related order placed
    </pre>
</div>
<br/>
<div>
    <button id="confirmPayment"><@fmt.message key='confirmPayment'/></button>
</div>
