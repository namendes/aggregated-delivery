<!doctype html>
<#include "../include/imports.ftl">

<@hst.setBundle basename="essentials.global"/>

<div class="row">
  <div class="col-xs-6 col-md-3">
    <div class="row">
      <@hst.include ref="footer-logo"/>
    </div>
  </div>
  <div class="col-xs-6 col-md-3">
    <@hst.include ref="footer-left"/>
  </div>
  <div class="clearfix visible-xs visible-sm"></div>
  <div class="col-xs-6 col-md-3">
    <@hst.include ref="footer-middle"/>
  </div>
  <div class="col-xs-6 col-md-3">
    <@hst.include ref="footer-right"/>
  </div>
</div>
<div>
  <sub>
    <@fmt.message key="footer.text" var="footer"/>${footer?html}
  </sub>
</div>
