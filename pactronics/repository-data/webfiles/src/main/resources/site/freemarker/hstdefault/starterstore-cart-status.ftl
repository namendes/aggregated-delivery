<!doctype html>
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.cart" var="cart"/>

<#if result?? && result.getValue('lineItems')?? && result.getValue('lineItems').childCount gt 0>


         <li class="pull-left">
             <a href="<@hst.link siteMapItemRefId="cart"/>"> ${cart?starts_with("???")?then("Cart", cart)}
                 <div id="cart-counter" class="pull-right" style="margin-left: 5px"> (${result.getValue('lineItems').childCount})</div>
             </a>
         </li>

<#else>
 <li class="pull-left">
     <a><@fmt.message var="cart" key="cart"/> ${cart?starts_with("???")?then("Cart", cart)}
         <div id="cart-counter" class="pull-right" style="margin-left: 5px"></div>
     </a>
 </li>
</#if>

