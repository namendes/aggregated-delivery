<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Articledocument" -->
<body xmlns="http://www.w3.org/1999/html">
  <div class="bloomreach container">
    <section class="blog">
      <div class="row">

        <!-- Blog Content -->
        <div class="col-md-9 col-sm-12 col-xs-12">

              <@hst.include ref="content"/>
              <@hst.include ref="container"/>
        </div>
        <!-- End Blog Content -->

        <!-- Sidebar -->
        <div class="col-md-3 col-sm-12 col-xs-12 sidebar">

          <div class="blog-widget blog-tags">
            <#if hstRequestContext.contentBean.tags?? && hstRequestContext.contentBean.tags?has_content>
              <h4>Tags</h4>
                <ul class="tags-list">
                  <#list hstRequestContext.contentBean.tags as tag>
                    <li style="padding:0;"><p>${tag}</p></li>
                  </#list>
                </ul>
            </#if>
          </div>

             <@hst.include ref="right"/>

        </div>
        <!-- End Sidebar -->

      </div>

      <div class="post-share">
        <a href="#"><i class="ion-social-facebook"></i> <span>Share</span></a>
        <a href="#"><i class="ion-social-twitter"></i> <span>Tweet</span></a>
        <a href="#"><i class="ion-social-pinterest"></i> <span>Pin it</span></a>
        <a href="#"><i class="ion-social-googleplus"></i></a>
      </div>

  </div>
  </section>
  </div>
</body>
