<!DOCTYPE html>
<#include "../include/imports.ftl">
<@hst.setBundle basename="spa.config.kiosk"/>
<#if cmsHostname?? && cmsHostname != "localhost">
  <@fmt.message key="baseUrl.production" var="baseUrl"/>
<#else>
  <@fmt.message key="baseUrl.localhost" var="baseUrl"/>
</#if>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Sample React App showcasing BloomReach Experience integration">

  <meta name="brx:baseUrl" content="${cmsBaseUrl!'not provided'}"/>
  <meta name="brx:cmsLocation" content="${cmsLocation!'not provided'}"/>
  <meta name="brx:contextPath" content="${cmsContextPath!'not available'}"/>
  <meta name="brx:hostname" content="${cmsHostname!'not available'}"/>
  <meta name="brx:mountPath" content="${cmsMountPath!'not available'}"/>
  <meta name="brx:port" content="${cmsPort?c!'not available'}"/>
  <meta name="brx:scheme" content="${cmsScheme!'not available'}"/>

  <title>Kiosk App | Pacific Electronics</title>
  <base href="/">

  <link type="text/css" rel="stylesheet" href="${baseUrl}/assets/css/bootstrap.min.css" media="screen">
  <link type="text/css" rel="stylesheet" href="${baseUrl}/assets/css/custom.css" media="screen">
  <link type="text/css" rel="stylesheet" href="${baseUrl}/assets/css/style.css" media="screen" />
  <link type="text/css" rel="stylesheet" href="${baseUrl}/assets/css/default.css" media="screen" />
  <link type="text/css" rel="stylesheet" href="${baseUrl}/assets/css/init.css" media="screen" />

  <link rel="icon" type="image/x-icon" href="${baseUrl}/favicon.ico">

</head>
<body>
<noscript>
  You need to enable JavaScript to run this app.
</noscript>

<app-root></app-root>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="${baseUrl}/assets/js/jquery.min.js"><\/script>')</script>
<script type="text/javascript" src="${baseUrl}/runtime.js"></script>
<script type="text/javascript" src="${baseUrl}/polyfills.js"></script>
<script type="text/javascript" src="${baseUrl}/styles.js"></script>
<script type="text/javascript" src="${baseUrl}/vendor.js"></script>
<script type="text/javascript" src="${baseUrl}/main.js"></script>
</html>