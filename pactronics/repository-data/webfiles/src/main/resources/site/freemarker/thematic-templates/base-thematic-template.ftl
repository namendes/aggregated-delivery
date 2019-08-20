<#include "../include/imports.ftl">


<#import "product-grid-element.ftl" as grid>
<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#import "../hstdefault/starterstore-productmacro.ftl" as productmacro>
<link rel="stylesheet" href="<@hst.webfile  path="css/master.css"/>" type="text/css"/>
<#--<@hst.webfile var="thematicStyle" path="css/thematic.css" />-->
<@hst.webfile var="thematicJs" path="js/thematic.js" />


<#--<#if thematic??>-->
    <#--<@hst.headContribution category="htmlHead">-->
            <#--<title>${thematic.getValue('page_header/title')}</title>-->
    <#--</@hst.headContribution>-->
    <#--<@hst.headContribution category="htmlHead">-->
            <#--<meta name="keywords" content="${thematic.getValue('page_header/meta_keywords')}">-->
    <#--</@hst.headContribution>-->
    <#--<@hst.headContribution category="htmlHead">-->
            <#--<meta name="description" content="${thematic.getValue('page_header/meta_description')}">-->
    <#--</@hst.headContribution>-->
<#--</#if> -->

  <div class="container-fluid">
    <div class="row">
        <@hst.include ref="container1"/>
    </div>
    <div class="row">
    <#if thematic??>
      <div class="col-md-3">
        <#include "../hstdefault/thematic-facetlist.ftl">
      </div>
      <div class="col-md-9" style="margin-top: 20px;">
      <#list thematic.getValue('response/docs').children.collection as newsDoc>
        <@productmacro.renderIntro newsDoc mappingResourceBundle/>
      </#list>
    <#else>
       <h1>Failed to Fetch Thematic Page</h1>
       <h3>Check whether this Thematic Page exists or not</h3>
    </#if>
    </div>
  </div>

    <div class="row">
      <div class="col-md-3">
        <#--empty for styling-->
      </div>
      <div class="col-md-9">
          <ul class="pagination">
           <#if (currentPage != 1)>
           <#-- First Page is always indexed from 1 -->
              <li><a onclick="redirectPage('1')">1</a></li>
              <li><a>...</a></li>
               <#if currentPage != 2>
                <li><a onclick="redirectPage(${currentPage-1})">${currentPage-1}</a></li>
               </#if>
           </#if>
           <li class="active"><a>${currentPage}</a></li>
           <#if (currentPage != totalPages)>
               <#if currentPage != totalPages - 1>
                <li><a onclick="redirectPage(${currentPage+1})">${currentPage+1}</a></li>
               </#if>
              <li><a>...</a></li>
           <#-- Last Page is always indexed at totalPages -->
              <li><a onclick="redirectPage(${totalPages})">${totalPages}</a></li>
           </#if>
          </ul>
        </div>
    </div>
  </div>

  <div class="row">
    <@hst.include ref="container2"/>
  </div>
<#--<link rel="stylesheet" href="${thematicStyle}">-->

  <script src="${thematicJs}"></script>

<#--<#if sort??>-->
<#--<form method="get" id="sort" style="margin-top: 30px; margin-bottom: 30px;">-->
<#--<label>Sort : </label>-->
<#--<select name="sort" form="sort" onchange="this.form.submit()">-->
<#--<option value="" <#if (sort == "")> selected="selected"</#if>>Relevance</option>-->
<#--<option value="price asc" <#if (sort == "price asc")> selected="selected"</#if>>Price Ascending-->
<#--</option>-->
<#--<option value="price desc" <#if (sort == "price desc")> selected="selected"</#if>>Price Descending-->
<#--</option>-->
<#--<option value="title asc" <#if (sort == "title asc")> selected="selected"</#if>>Title Ascending-->
<#--</option>-->
<#--<option value="title desc" <#if (sort == "title desc")> selected="selected"</#if>>Title Descending-->
<#--</option>-->
<#--</select>-->
<#--</form>-->
<#--</#if>-->


<#--<#if leftNav != "">
    <div class="sidenav">
        <#if leftNav.getValue("heading")??>
            <a href="#" style="color:white;">${leftNav.getValue("heading")}</a>
            <#if leftNav.getValue("attribute_groups")??>
                <#list leftNav.getValue("attribute_groups").children.collection as attrGroup>
                    <#if attrGroup.getValue("heading")??>
                    <a href="#" style="color:white;margin-left: 10px;">${attrGroup.getValue("heading")}</a>
                        <#list attrGroup.getValue("links").children.collection as attrLink>
                        <a href="${attrLink.getValue("url")}"
                           style="margin-left: 20px;">${attrLink.getValue("anchor_text")}</a>
                        </#list>
                    </#if>
                </#list>
            </#if>
        </#if>
    </div>
</#if>-->