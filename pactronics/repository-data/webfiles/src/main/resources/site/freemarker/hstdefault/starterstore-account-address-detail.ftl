<!doctype html>
<#include "../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<#if hst.isBeanType(formObject, 'com.bloomreach.commercedxp.starterstore.model.Customer')>
  <#include "v1/starterstore-account-address-detail.ftl"/>
<#else>
  <div class="col-xs-12 col-md-offset-3 col-md-6">
    <h1>
      <#if address??>
        <@fmt.message key='signup.address.edit.label'/>
      <#else>
        <@fmt.message key='signup.address.new.label'/>
      </#if>
    </h1>

    <#if formErrors?? && formErrors.hasItem('form')>
      <#assign formErrorItem=formErrors.getItem('form') />
      <div class="alert alert-danger" role="alert">
        ${formErrorItem.message}
      </div>
    </#if>

    <form class="form" method="POST" action="<@hst.actionURL />">
      <div class="form-group <#if formErrors?? && formErrors.hasItem('streetAddress')>has-error</#if>">
        <label class="control-label" for="street_name">
          <@fmt.message key='signup.label.address.street'/>
        </label>
        <input type="text" class="form-control"
          name="street_name" id="street_name"
          placeholder="<@fmt.message key='signup.label.address.streetName' />"
          value="<#if address??>${address.streetAddress!}</#if>" />
        <#if formErrors?? && formErrors.hasItem('streetAddress')>
          <#assign formErrorItem=formErrors.getItem('streetAddress') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group <#if formErrors?? && formErrors.hasItem('additionalStreetInfo')>has-error</#if>">
        <label class="control-label" for="additional_street_info">
          <@fmt.message key='signup.label.address.additionalStreetInfo' />
        </label>
        <input type="text" class="form-control"
          name="additional_street_info" id="additional_street_info"
          value="<#if address??>${address.additionalStreetInfo!}</#if>" />
        <#if formErrors?? && formErrors.hasItem('additionalStreetInfo')>
          <#assign formErrorItem=formErrors.getItem('additionalStreetInfo') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group <#if formErrors?? && formErrors.hasItem('city')>has-error</#if>">
        <label class="control-label" for="city">
          <@fmt.message key='signup.label.address.city' />
        </label>
        <input type="text" class="form-control"
          name="city" id="city"
          value="<#if address??>${address.city!}</#if>" />
        <#if formErrors?? && formErrors.hasItem('city')>
          <#assign formErrorItem=formErrors.getItem('city') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group <#if formErrors?? && formErrors.hasItem('state')>has-error</#if>">
        <label class="control-label" for="state">
          <@fmt.message key='signup.label.address.state' />
        </label>
        <select class="form-control" name="state" id="state" >
          <option value=""><@fmt.message key='signup.placeholder.address.state' /></option>
          <#list americaStateCodeList as code>
            <option value="${code}" <#if address?? && address.state! == code>selected</#if>>${americaStateCodesMap[code]}</option>
          </#list>
        </select>
        <#if formErrors?? && formErrors.hasItem('state')>
          <#assign formErrorItem=formErrors.getItem('state') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group <#if formErrors?? && formErrors.hasItem('postalCode')>has-error</#if>">
        <label class="control-label" for="postal_code">
          <@fmt.message key='signup.label.address.postalCode' />
        </label>
        <input type="text" class="form-control"
          name="postal_code" id="postal_code"
          value="<#if address??>${address.postalCode!}</#if>" />
        <#if formErrors?? && formErrors.hasItem('postalCode')>
          <#assign formErrorItem=formErrors.getItem('postalCode') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group <#if formErrors?? && formErrors.hasItem('country')>has-error</#if>">
        <label class="control-label" for="country">
          <@fmt.message key='signup.label.address.country' />
        </label>
        <select class="form-control" name="country" id="country">
          <option value="">
            <@fmt.message key='signup.placeholder.address.country' />
          </option>
          <#list isoCountryCodeList as code>
            <option value="${code}" <#if address?? && address.country! == code>selected</#if>>${isoCountryCodesMap[code]}</option>
          </#list>
        </select>
        <#if formErrors?? && formErrors.hasItem('country')>
          <#assign formErrorItem=formErrors.getItem('country') />
          <small class="help-block">
            ${formErrorItem.message}
          </small>
        </#if>
      </div>

      <div class="form-group mb-none">
        <#if address?? && address.id?? && address.id?has_content>
          <input type="hidden" name="id" value="${address.id!}" />
        </#if>
        <button type="submit" class="btn btn-primary mr-md">
          <@fmt.message key='signup.button.save'/>
        </button>
        <a href="<@hst.link siteMapItemRefId='accountAddresses' />" role="button" class="btn btn-link">
          <@fmt.message key='signup.button.address.detail.backToAddresses' />
        </a>
      </div>
    </form>
  </div>
</#if>