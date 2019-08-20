<#include "../../include/imports.ftl">
<#include "../../include/banner-util.ftl">

<#-- @ftlvariable name="document1" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<#-- @ftlvariable name="document2" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->
<#-- @ftlvariable name="document3" type="com.bloomreach.commercedxp.demo.pactronics.beans.Banner" -->

${showContent}
<div class="bloomreach modes">
    <div class="modes_card">
        <@printDocument document=document1 showContent=showContent type="fittorow"/>
    </div>
    <div class="modes_card">
        <@printDocument document=document2 showContent=showContent index=1 type="fittorow"/>
    </div>
    <div class="modes_card">
        <@printDocument document=document3 showContent=showContent index=2 type="fittorow"/>
    </div>
</div>
