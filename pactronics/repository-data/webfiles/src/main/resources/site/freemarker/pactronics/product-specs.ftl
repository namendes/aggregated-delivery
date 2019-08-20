<#include "../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.bloomreach.commercedxp.demo.pactronics.beans.Productfeature" -->


<#if cparam.dimensions?has_content || cparam.storage?has_content || cparam.display?has_content ||
cparam.battery?has_content || cparam.graphics?has_content || cparam.memory?has_content>
<div>
  <section id="product_details_section">
    <div class="prod_specs">
      <h2>Tech Specs</h2>
          <#if cparam.dimensions?has_content>
          <div class="strip">
            <h3>Dimensions:</h3> ${cparam.dimensions}
          </div>
          </#if>

          <#if cparam.storage?has_content>
          <div class="strip">
            <h3>Storage:</h3> ${cparam.storage}
          </div>
          </#if>

          <#if cparam.display?has_content>
            <div class="strip">
              <h3>Display:</h3> ${cparam.display}
            </div>
          </#if>

          <#if cparam.battery?has_content>
            <div class="strip">
              <h3>Battery:</h3>  ${cparam.battery}
            </div>
          </#if>

          <#if cparam.memory?has_content>
            <div class="strip">
              <h3>Memory:</h3> ${cparam.memory}
            </div>
          </#if>

          <#if cparam.graphics?has_content>
            <div class="strip">
              <h3>Graphics:</h3> ${cparam.graphics}
            </div>
          </#if>
    </div>
  </section>
</div>
  <hst.headContribution category="seo" keyHint="metaDescription">
    <meta name="description" content="${cparam.battery}"/>
  </hst.headContribution>
<#elseif editMode>
<div>
  <figure style="position: relative">
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Product Specs
  </figure>
</div>
</#if>