<#include "../../include/imports.ftl">
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.about" var="about"/>
<@fmt.message key="text.sidebarabout" var="sidebarAbout"/>



<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Articledocument" -->
<section class="bloomreach blog">
  <div class="container">
    <div class="row">

      <div class="col-md-9">
        <@hst.include ref="left"/>
      </div>

      <div class="col-md-3 sidebar">
        <div class="blog-widget">
          <h4>${about}</h4>
          <p>${sidebarAbout}</p>
        </div>

        <@hst.include ref="right"/>

        <div class="sidebar-share">
          <ul class="list-inline">
            <li><a href="#"><i class="ion-social-twitter"></i></a></li>
            <li><a href="#"><i class="ion-social-facebook"></i></a></li>
            <li><a href="#"><i class="ion-social-linkedin"></i></a></li>
            <li><a href="#"><i class="ion-social-pinterest"></i></a></li>
            <li><a href="#"><i class="ion-social-google"></i></a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>
