<#-- @ftlvariable name="enableAutosuggest" type="java.lang.Boolean" -->
<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>

<@hst.link path="/search" var="searchLink"/>
<@hst.link siteMapItemRefId="product" var="productDetailLink"/>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.search" var="search"/>

<@hst.resourceURL resourceId="autosuggest" var="autosuggestUrl"/>
<#assign autosuggestUrl = autosuggestUrl?split("&amp;_sq=")[0]/>

<form id="search-form" id="search-form" action="${searchLink}" class="pull-right d-none" onsubmit="BrTrk.getTracker().logEvent('suggest', 'submit',{q:document.getElementById('_sq').value},{},true);">
    <div class="typeahead__container">
        <div class="typeahead__field">
      <span class="typeahead__query">
          <span class="typeahead__search-icon" style="position:absolute;top:22px;left:10px;"></span>
          <input class="js-typeahead" id="_sq" name="_sq" type="search"
                 value="" autocomplete="off" data-enable="on"
                 data-autosuggesturl="${autosuggestUrl}" data-searchurl="${searchLink}"
                 data-producturl="${productDetailLink}"
                 placeholder="${search?upper_case}.." onkeydown="BrTrk.getTracker().logEvent('suggest','click', {aq:document.getElementById('_sq').value , q:document.getElementById('_sq').value}, {},true);">
      </span>
        <#--<span class="typeahead__button">-->
        <#--<button type="submit"><span class="typeahead__search-icon"></span></button>-->
        <#--</span>-->
        </div>
    </div>
</form>





<@hst.headContribution category="htmlBodyEnd">
            <script>

                $("#search-form input").click(function(ev) {
                    $('#search-form').removeClass('d-none');
                    ev.stopPropagation();
                });

            </script>
</@hst.headContribution>