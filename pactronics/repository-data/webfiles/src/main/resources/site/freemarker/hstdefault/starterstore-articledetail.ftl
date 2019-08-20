<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Article" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>

<#if document??>
    <#if editMode!false>
          <div style="position: relative">
            <@hst.cmseditlink hippobean=document />
          </div>
    </#if>

    <#if document.image??>
    <style>
      .intro-header{
        background: no-repeat center center;
        background-size: cover;
        background-attachment: scroll;
        background-image: linear-gradient(rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.45)), url('<@hst.link hippobean=document.image/>');
        padding: 100px 0 50px;
        margin-bottom: 10px;
        color: white;
        font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
      }
    </style>
    </#if>

    <header class="intro-header">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="post-heading">
              <h1 style="font-size: 50px;">${document.title}</h1>
              <h2 class="subheading"><@hst.html hippohtml=document.introduction/></h2>
              <#if document.date?? && document.date?has_content>
                  <@fmt.formatDate value=document.date.time type="Date" pattern="MMMM d, yyyy" />
              </#if>
            </div>
          </div>
        </div>
      </div>
    </header>

    <div class="col-lg-8">
      <#list document.tags as tag>
        <b>#${tag}</b>
      </#list>
    </div>

    <article>
      <div class="container">
        <div class="col-lg-8">
              <div>
              <@hst.include ref="main-left"/>
              </div>
            <#list document.entries as entry>
              <div>
                <#if entry.getType() == "paragraph">
                    <h3>${entry.title}</h3>
                    <@hst.html hippohtml=entry.description/>
                <#elseif entry.getType() == "calltoaction">
                    <#assign ctaLink = "#"/>
                    <#if entry.internallink??>
                        <#assign ctaLink><@hst.link hippobean=entry.internallink/></#assign>
                    <#elseif entry.externallink?? && entry.externallink?has_content>
                        <#assign ctaLink=entry.externallink />
                    </#if>
                    <a href="${ctaLink}" class="btn btn-info" role="button">${entry.name}</a>
                </#if>
              </div>
            </#list>
        </div>
        <div class="col-lg-4">
          <div class="col-md-offset-3">
              <@hst.include ref="main-right">
                  <#if editMode!false>
                    <div class="configure-component-text alert alert-warning alert-dismissible">
                      <b>Channel Manager Message</b><br/>
                      Async container reloading is not working for article page. Click <a href="<@hst.link />">here</a> to reload the entire page
                    </div>
                  </#if>
              </@hst.include>
          </div>
        </div>
      </div>
    </article>
</#if>