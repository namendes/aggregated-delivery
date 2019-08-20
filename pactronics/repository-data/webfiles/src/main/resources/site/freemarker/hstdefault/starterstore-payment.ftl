<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="orderDraft" type="com.bloomreach.commercedxp.api.v2.connector.model.OrderModel" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>
<#if orderDraft??>
    <@hst.headContribution category="scripts">
    <script type="text/javascript">

      $("#confirmPayment").click(function () {
        $.ajax({
          <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
          url: "${hstRequestContext.servletContext.contextPath}/restservices/orders/paymentMethods/default",
          <#else>
          url: "/restservices/orders/paymentMethods/default",
          </#if>
          method: "POST",
          dataType: "json",
          data: JSON.stringify({}),
          headers: {
            'Content-Type': 'application/json'
          }
        }).done(function () {
            $.ajax({
              <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
              url: "${hstRequestContext.servletContext.contextPath}/restservices/orders/confirmations/${orderDraft.id}",
              <#else>
              url: "/restservices/orders/confirmations/${orderDraft.id}",
              </#if>
              method: "POST",
              data: JSON.stringify({
                  "id": "${orderDraft.id!}"
              }),
              headers: {
                'Content-Type': 'application/json'
              }
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
              url: "${hstRequestContext.servletContext.contextPath}/restservices/orders/paymentMethods",
          <#else>
              url: "/restservices/orders/paymentMethods",
          </#if>
          method: "POST",
          data: ...
        }).done(function () {
            $.ajax({
              <#if hstRequestContext.servletContext.contextPath?? && (hstRequestContext.servletContext.contextPath?length>1)>
                  url: "${hstRequestContext.servletContext.contextPath}/restservices/orders/confirmations",
              <#else>
                  url: "/restservices/orders/confirmations",
              </#if>
              method: "POST",
              data: ...
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
<#else>
    <#include "v1/starterstore-payment.ftl" />
</#if>