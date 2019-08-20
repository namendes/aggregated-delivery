<#include "../include/imports.ftl">

<@hst.setBundle basename="essentials.homepage"/>

<div class="container">
  <div class="row">
    <div class="col-xs-12">
      <h1><@fmt.message key="homepage.title" var="title"/>${title?html}</h1>
      <p><@fmt.message key="homepage.text" var="text"/>${text?html}</p>
      <@hst.include ref="main-top"/>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-12 col-md-3">
      <@hst.include ref="container-left"/>
    </div>

    <div class="col-xs-12 col-md-9">
      <@hst.include ref="container"/>
    </div>
  </div>
</div>
