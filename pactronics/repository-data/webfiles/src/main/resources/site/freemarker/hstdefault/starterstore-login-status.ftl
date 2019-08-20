<!doctype html>
<#include "../include/imports.ftl">

<#--<@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages, essentials.global"/>-->
<@hst.setBundle basename="essentials.global"/>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.login" var="login"/>
<@fmt.message key="text.logout" var="logout"/>
<@fmt.message key="text.search" var="search"/>

<@hst.link var="destination" />

<#if storeUser??>
  <li id ="two" class="dropdown pull-left">
      <a href="<@hst.link path='/account'/>"  class="dropdown-toggle" data-toggle="dropdown">
          ${storeUser.firstName!} ${storeUser.middleName!} ${storeUser.lastName!}
          <span class="caret"></span></a>
      <ul class="dropdown-menu">
          <li><a class="dropdown" href="<@hst.link path='/account'/>"><@fmt.message key="account.status.menu.account"/></a></li>
          <li><a class="dropdown" href="<@hst.link path='/account/creds'/>"><@fmt.message key="account.status.menu.changePassword"/></a></li>
          <li><a class="dropdown" href="<@hst.link path='/account/addresses'/>"><@fmt.message key="account.status.menu.addresses"/></a></li>
          <li><a class="dropdown" href="<@hst.link path='/orders'/>"><@fmt.message key="account.status.menu.orders"/></a></li>
      </ul>
  </li>
  <li class="pull-left">
      <a href="<@hst.actionURL><@hst.param name='_action' value='logout'/><@hst.param name='destination' value='${destination!}'/></@hst.actionURL>">
          ${logout}
      </a>
  </li>
<#else>
  <li class="pull-left">
      <a href="<@hst.link path='/signin'><@hst.param name='destination' value='${destination!}'/></@hst.link>">
          ${login}
      </a>
  </li>
</#if>


<@hst.include ref="cart-status"/>



 <li class="pull-left">
     <a href="#" id="search-text"  class="search-text">${search?upper_case}</a>
     <div id="cart-counter" class="pull-right" style="margin-left: 5px"> </div>
 </li>


<@hst.headContribution category="htmlBodyEnd">
            <script>

                $("#search-text").click(function(ev) {
                    $('#search-form').toggleClass('d-none');
                    $('#search-form input').focus();
                    ev.stopPropagation();
                });

                $(window).click(function() {
                    $('#search-form').addClass('d-none');
                });
            </script>
</@hst.headContribution>