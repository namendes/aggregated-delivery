<!doctype html>
<#include "../include/imports.ftl">
<html lang="en">
<head>
  <meta charset="utf-8"/>
</head>
<body>
<div class="row">
  <@hst.include ref="main"/>
</div>
Freemarker template
headincludes->
<link rel="stylesheet" href="<@hst.webfile  path="/css/bootstrap.css"/>" type="text/css"/>
<#if hstRequest.requestContext.channelManagerPreviewRequest>
  <link rel="stylesheet" href="<@hst.webfile  path="/css/cms-request.css"/>" type="text/css"/>
</#if>
<@hst.headContributions xhtml=true/>
<-headincludes
</body>
</html>


