<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>

<#macro add result="" id="-1" name="">
      <#local page_type = hstRequestContext.resolvedSiteMapItem.getLocalParameter("br_data.ptype")!"other" />
      <#if page_type == "category">
        <#if mappingResourceBundle?? && mappingResourceBundle.containsKey("pixel.categories")  >
            <#local categoryListPath=mappingResourceBundle["pixel.categories"]/>
            <#local catPropNam="cat_id" />
            <#local breadCrumbPropName="crumb"/>
            <#local categoryList = result.getValue(categoryListPath).children/>
            <#list 0..(categoryList.size()-1) as index>
                <#local category = categoryList.get(index)/>
                <#if category.getValue(catPropNam) == id>
                    <#local category_crumb = category.getValue(breadCrumbPropName) />
                </#if>
            </#list>
            <@hst.headContribution category="pixelInjection">
              <script type="text/javascript">
                if (br_data) {
                  br_data.cat = "${category_crumb!}";
                  br_data.cat_id = "${id!}";
                }
              </script>
            </@hst.headContribution>
        </#if>
      <#elseif page_type = "search">
          <@hst.headContribution category="pixelInjection">
          <script type="text/javascript">
            if (br_data) {
              br_data.search_term = "${hstRequest.requestContext.servletRequest.getParameter("_sq")!}";
            }
          </script>
          </@hst.headContribution>
      <#elseif page_type = "product">
          <@hst.headContribution category="pixelInjection">
          <script type="text/javascript">
            if (br_data) {
              br_data.prod_id = "${id}";
              br_data.prod_name = "${name}";
            }
          </script>
          </@hst.headContribution>
      </#if>

</#macro>