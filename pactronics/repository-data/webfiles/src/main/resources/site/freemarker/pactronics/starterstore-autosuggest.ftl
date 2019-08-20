<#import "../hstdefault/starterstore-helper.ftl" as helper>
<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="mappingResourceBundle" type="java.util.ResourceBundle" -->
<#if customResult??>
    ${customResult}
<#else>
{}
</#if>