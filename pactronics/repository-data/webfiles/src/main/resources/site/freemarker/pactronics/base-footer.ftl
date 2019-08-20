<#include "../include/imports.ftl">
<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->

<@hst.setBundle basename="essentials.global"/>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.emailsignup" var="signup"/>

<div>
  <@hst.include ref="container"/>
</div>

<footer id="footer" class="footer style-1 dark">
    <ul data-reveal="top" data-sr-id="15">
        <li><a href="https://www.twitter.com/" target="_blank" class="color"><i class="ion-social-twitter"></i></a></li>
        <li><a href="https://www.facebook.com/" target="_blank" class="color"><i class="ion-social-facebook"></i></a></li>
        <li><a href="https://www.linkedin.com/" target="_blank" class="color"><i class="ion-social-linkedin"></i></a></li>
        <li><a href="https://www.pinterest.com/" target="_blank" class="color"><i class="ion-social-pinterest"></i></a></li>
        <li><a href="https://plus.google.com/" target="_blank" class="color"><i class="ion-social-googleplus"></i></a></li>
    </ul>

<#if menu??>
      <#list menu.siteMenuItems as item>
        <#if !item.hstLink?? && !item.externalLink??>
            <#if item.selected || item.expanded>
                <p class="text">${item.name?html}</p>
            <#else>
                <p class="text">${item.name?html}</p>
            </#if>
        <#else>
            <#if item.hstLink??>
                <#assign href><@hst.link link=item.hstLink/></#assign>
            <#elseif item.externalLink??>
                <#assign href>${item.externalLink?replace("\"", "")}</#assign>
            </#if>
            <#if  item.selected || item.expanded>
                <p class="text"><a href=${href}>${item.name?html}</a></p>
            <#else>
                <p class="text"><a href=${href}>${item.name?html}</a></p>
            </#if>
        </#if>
      </#list>
        <p class="light_text">© Pacific Electronics</p>
    <@hst.cmseditmenu menu=menu/>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/menu.png" />"> Click to edit Menu
  </div>
</#if>

    <@hst.link var="contactus" path="contact-us"/>
    <div id="email-signup">
    	<a href=${contactus}>
    		<i class="ion-ios-email-outline" style="font-size:35px;position: absolute;margin-top: 25px;margin-left: -30px;"></i>
    		<p class="light_text">${signup}</p>
    	</a>
    </div>
</footer>

<#--  
<hr/>
<div class="text-center">
  <sub><@fmt.message key="footer.text" var="footer"/>${footer?html}</sub>
</div>
-->