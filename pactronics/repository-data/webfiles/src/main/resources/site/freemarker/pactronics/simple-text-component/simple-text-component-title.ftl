<#include "../../include/imports.ftl">





<#if cparam.text?has_content>
    <div class="bloomreach container">
      <div class="product_feature_benefit row s-img-align-right s-bg-white">
        <div class="col-md-12 col-sm-12">
            <#if cparam.text?has_content>
              <div class="text_component">
                <div class="text_component_title">
                  <h1>${cparam.text}</h1>
                </div>
              </div>
            </#if>
        </div>
      </div>
    </div>
<#elseif editMode>
<div>
  <figure style="position: relative">
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/banner.png'/>"> Click to edit Simple Text
  </figure>
</div>
</#if>
