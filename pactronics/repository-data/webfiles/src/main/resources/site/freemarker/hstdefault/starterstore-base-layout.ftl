<!doctype html>
<#include "../include/imports.ftl">
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8"/>
        <link rel="stylesheet" href="<@hst.webfile  path="css/master.css"/>" type="text/css"/>
        <link rel="icon" href="<@hst.webfile  path="images/favicon.ico"/>"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700%7CHind:600,500,400,300" rel="stylesheet"
              type="text/css">

        <#if hstRequest.requestContext.cmsRequest>
          <link rel="stylesheet" href="<@hst.webfile  path="/css/cms-request.css"/>" type="text/css"/>
        </#if>
        <script type="text/javascript" src="<@hst.webfile path="/js/jquery.js"/>"></script>
        <@hst.headContributions categoryExcludes="htmlBodyEnd, scripts, pixel-data-scriptlet, pixelInjection, pixel-jslib-scriptlet" />
    </head>
    <body class="bloomreach">
        <nav style="position:relative;" class="navbar navbar-fixed-top  bg-blue" role="navigation">
            <div class="container">
                        <@hst.include ref="top"/>
            </div>
        </nav>
            <div class="container">
            <div id="notifications" name="notifications" style="position: fixed; z-index:1000; width: inherit"></div>
            <div class="row">
                        <@hst.include ref="main"/>
            </div>
        </div>

        <@hst.include ref="footer"/>

        <script type="text/javascript" src="<@hst.webfile  path="/js/bootstrap.min.js"/>"></script>
        <script type="text/javascript" src="<@hst.webfile path="js/jquery.typeahead.min.js"/>"></script>
        <script type="text/javascript" src="<@hst.webfile  path="/js/starterstore-boot-footer.js"/>"></script>


        <#-- Customize universal pixel contribution values by interpolating variables such as account name and domain key. -->
        <@starterstore.interpolateHeadContributionsTag categoryIncludes="pixel-data-scriptlet, pixel-jslib-scriptlet" />

        <#-- The default universal pixel br_data contributions -->
        <@hst.headContributions categoryIncludes="htmlBodyEnd, scripts" />

        <#-- StarterStore-Boot specific pixel contributions -->
        <@hst.headContributions categoryIncludes="pixel-data-scriptlet" xhtml=true/>
        <#if hstRequestContext.resolvedMount.mount.channelInfo.enabled>
            <@hst.headContributions categoryIncludes="pixelInjection" />
          <script type="text/javascript">
              if (br_data) {
              <#list hstRequestContext.resolvedSiteMapItem.localParameters?keys as localParameterName>
                  <#if localParameterName?starts_with("br_data.")>
                      ${localParameterName} = "${hstRequestContext.resolvedSiteMapItem.getLocalParameter(localParameterName)}";
                  </#if>
              </#list>
              }
          </script>
        </#if>

        <#-- Universal Pixel JS Library contribution -->
        <@hst.headContributions categoryIncludes="pixel-jslib-scriptlet" xhtml=true/>
    </body>
</html>
