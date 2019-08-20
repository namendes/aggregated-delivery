<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="beanResult" type="com.bloomreach.commercedxp.api.v2.connector.model.CartModel" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>

<#if result??>
  <#include "v1/starterstore-cartproductlist.ftl"/>
<#elseif beanResult??>
  <#if beanResult.totalQuantity == 0>
    <div class="alert alert-info">
      <@fmt.message key='cart.empty'/>
    </div>
  <#else>
    <@hst.link siteMapItemRefId="signin" var="signinUrl"/>
    <@hst.link siteMapItemRefId="shipment" var="shipmentUrl"/>
    <#list beanResult.entries as entry>
      <#list entry.items as item>
        <div class="row">
          <div class="col-sm-7 col-md-8 col-lg-9 pl-none pr-none pb-md">
            <div class="col-xs-5 col-sm-3">
              <img class="img-responsive" src="${item.imageSet.original.selfLink.href!""}">
            </div>
            <div class="col-xs-7 col-sm-9">
              <div class="row">
                <div class="col-sm-8">
                  <h4 class="mb-none">
                    <@hst.link siteMapItemRefId="product" var="basePath"/>
                    <#assign productLink=helper.generateLink(basePath, item.code) />
                    <a href="${productLink!}">${item.displayName}</a>
                  </h4>
                </div>
                <#assign listPrice=item.listPrice />
                <#assign purchasePrice=item.purchasePrice />
                <#if listPrice??>
                  <#assign moneyAmount=item.listPrice.moneyAmounts[0] />
                  <div class="col-sm-4 text-right hidden-xs">
                    ${moneyAmount.displayValue!}
                  </div>
                  <div class="col-xs-12 mt-md mb-md visible-xs">
                    ${moneyAmount.displayValue!}
                  </div>
                </#if>
              </div>
            </div>
            <div class="clearfix hidden-xs"></div>
          </div>
          <div class="col-xs-7 col-sm-5 col-md-4 col-lg-3 pb-md">
            <div class="row">
              <div class="col-xs-6 col-sm-7">
                <form method="POST" action="<@hst.actionURL />">
                  <input type="hidden" id="_action" name="_action" value="update"/>
                  <input type="hidden" id="_cartId" name="_cartId" name="cartId" value="${beanResult.id!}"/>
                  <input type="hidden" id="_cartItemid" name="_cartItemId" value="${entry.id!}"/>
                  <div class="input-group">
                    <label class="input-group-addon" for="_ciq">
                      <span class="hidden-xs">Quantity</span>
                      <span class="visible-xs">&times;</span>
                    </label>
                    <input
                      class="form-control"
                      type="number" min="1" size="3"
                      id="_ciq" name="_ciq"
                      value="${entry.quantity!1}"
                    />
                  </div>
                </form>
              </div>
              <div class="col-xs-6 col-sm-5 text-right">
                <form method="POST" action="<@hst.actionURL />">
                    <input type="hidden" id="_action" name="_action" value="remove"/>
                    <input type="hidden" id="_cartId" name="_cartId" name="cartId" value="${beanResult.id!}"/>
                    <input type="hidden" id="_cartItemid" name="_cartItemId" name="cartItemId" value="${entry.id!}"/>
                    <button type="submit" class="btn btn-danger">Remove</button>
                </form>
              </div>
            </div>
          </div>
          <div class="col-xs-12 clearfix">
            <div class="border-bottom mb-md"></div>
          </div>
        </div>
      </#list>
    </#list>

    <div class="pull-right">
      <#if !storeUser??>
        <#assign shipmentUrl>
          <@hst.link siteMapItemRefId="checkout"/>?signin=${signinUrl}?destination=${shipmentUrl}
        </#assign>
      </#if>

      <a href="${shipmentUrl}" class="btn btn-primary"><@fmt.message key='checkout'/></a>
    </div>
    <div class="clearfix"></div>
  </#if>
</#if>
