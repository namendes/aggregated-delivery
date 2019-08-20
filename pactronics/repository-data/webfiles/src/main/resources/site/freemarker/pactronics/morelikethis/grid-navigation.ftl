<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../../hstdefault/starterstore-helper.ftl" as helper>
<#import "../../hstdefault/starterstore-productmacro.ftl" as productmacro>
<#import "../morelikethis.ftl" as morelikethis>

<@hst.setBundle basename="starterstore.mapping.bloomreach" var="bloomreach"/>

<@morelikethis.printTitle />

<div id="grid2">
	<#if pageable?? && pageable?has_content>
    	<div class="row">
      		<#if showFacets?? && showFacets=="on">
        		<div class="col-md-3">
            		<#include "../../hstdefault/starterstore-facetlist.ftl">
        		</div>
      		</#if>
      		
      		<#assign productlist = pageable.getItems()/>
      		<@hst.setBundle basename="essentials.pagination"/>
      		
      		<div style="width:3%; display:inline;">
      			<#list pageable.pageNumbersArray as pageNr>
          			<@hst.renderURL var="pageUrl">
              			<@hst.param name="page" value="${pageNr}"/>
              			<@hst.param name="_sps" value="${pageable.pageSize}"/>
          			</@hst.renderURL>
          			<#if (pageNr_index==0 && pageable.previous)>
             			<@hst.renderURL var="pageUrlPrevious">
                  			<@hst.param name="page" value="${pageable.previousPage}"/>
                  			<@hst.param name="_sps" value="${pageable.pageSize}"/>
              			</@hst.renderURL>
            			<a href="${pageUrlPrevious}" style="text-decoration:none;"><@fmt.message key="page.previous" var="prev"/>
            				<i class="ion-ios-arrow-back" style="font-size:60px; color:#565CE4;"></i>
            			</a>
            		<#elseif pageNr_index==0> <i class="ion-ios-arrow-back" style="font-size:60px; color:#CDCDF6"></i>
          			</#if>
          		</#list>
      		</div>
      
        	<div ${(showFacets?? && showFacets=="on")?then("class=\"col-md-9\"","")} style="width:94%; display:inline-flex">
            	<#list productlist as item>
                	<@productmacro.renderIntro item mappingResourceBundle/>
            	</#list>
            	<div style="clear: both;">
               <#-- <#if showPagination?? && showPagination=="on">
                  <#include "../../include/pagination.ftl">
                </#if>-->
            	</div>
        	</div> <#-- facet div -->
        	
        	<div style="width:3%; display:inline;">
        		<#list pageable.pageNumbersArray as pageNr>
          			<@hst.renderURL var="pageUrl">
              			<@hst.param name="page" value="${pageNr}"/>
              			<@hst.param name="_sps" value="${pageable.pageSize}"/>
          			</@hst.renderURL>
          			<#if !pageNr_has_next && pageable.next>
              			<@hst.renderURL var="pageUrlNext">
                  			<@hst.param name="page" value="${pageable.nextPage}"/>
                  			<@hst.param name="_sps" value="${pageable.pageSize}"/>
              			</@hst.renderURL>
            			<a href="${pageUrlNext}" style="text-decoration:none;"><@fmt.message key="page.next" var="next"/>
            				<i class="ion-ios-arrow-forward" style="font-size:60px; color:#565CE4;"></i> 
            			</a>
            		<#elseif !pageNr_has_next> <i class="ion-ios-arrow-forward" style="font-size:60px; color:#CDCDF6"></i>
          			</#if>
          		</#list>
      		</div>
        	
    	</div> <#-- row div -->
	<#elseif result??>
    	<#assign productlist = helper.resolveProperty(result, "productlist", mappingResourceBundle).children/>
    	<div class="row">
        	<#list 0..productlist.size()-1 as index>
            	<@productmacro.renderIntro productlist.get(index) mappingResourceBundle/>
        	</#list>
    	</div>
	</#if>
</div>