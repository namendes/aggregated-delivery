<!doctype html>
<#include "../include/imports.ftl">
<html lang="en">
<head>
    <meta charset="utf-8"/>
</head>
<body>
<div class="bloomreach row">
    <@hst.include ref="main"/>
</div>
Freemarker template
headincludes->
<link rel="stylesheet" href="<@hst.webfile  path="css/master.css" fullyQualified=false/>" type="text/css"/>
<@hst.headContributions xhtml=true/>
<-headincludes

</body>
</html>


