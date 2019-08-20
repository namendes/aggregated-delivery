<#include "../include/imports.ftl">
<#include "../include/banner-util.ftl">

<#-- @ftlvariable name="document1" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<#-- @ftlvariable name="document2" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<#-- @ftlvariable name="document3" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<div class="bloomreach">
    <div id="banner-main" class="row clearfix">
        <div id="banner" class="span_4 column">
            <@printDocument document=document1 showContent=showContent />
        </div>
        <div id="banner1" class="span_4 column">
            <@printDocument document=document2 showContent=showContent index=1 />
        </div>
        <div id="banner2" class="span_4 column">
            <@printDocument document=document3 showContent=showContent index=2 />
        </div>
    </div>
</div>
