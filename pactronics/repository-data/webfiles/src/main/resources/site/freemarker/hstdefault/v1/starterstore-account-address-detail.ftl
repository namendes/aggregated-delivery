<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<!doctype html>
<#include "../../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<div class="col-xs-12 col-md-offset-3 col-md-6">
  <h1><@fmt.message key='signup.tab.account.title'/></h1>

  <#if formErrors?? && formErrors.hasItem('form')>
    <#assign formErrorItem=formErrors.getItem('form') />
    <div class="alert alert-danger" role="alert">
      ${formErrorItem.message}
    </div>
  </#if>

  <form class="form" method="POST" action="<@hst.actionURL />">
    <div class="form-group">
      <div class="checkbox">
        <label>
          <input type="checkbox" name="shipping_address" value="on"
            <#if formObject?? && formObject.hasShippingAddressId(address.id!)>checked="true"</#if> />
          <@fmt.message key='signup.label.address.shippingAddress' />
        </label>
      </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="billing_address" value="on"
            <#if formObject?? && formObject.hasBillingAddressId(address.id!)>checked="true"</#if> />
          <@fmt.message key='signup.label.address.billingAddress' />
        </label>
      </div>
    </div>

    <div class="form-group">
      <span class="<#if formErrors?? && (formErrors.hasItem('streetNumber')
        || formErrors.hasItem('streetName'))>has-error</#if>">
        <label class="control-label" for="street_number" id="label-street">
          <@fmt.message key='signup.label.address.street'/>
        </label>
      </span>
      <div class="row">
        <div class="col-xs-3 <#if formErrors?? && formErrors.hasItem('streetNumber')>has-error</#if>">
          <input type="text" class="form-control"
            name="street_number" id="street_number"
            placeholder="<@fmt.message key='signup.label.address.streetNumber' />"
            value="<#if address??>${address.streetNumber!}</#if>" />
          <#if formErrors?? && formErrors.hasItem('streetNumber')>
            <#assign formErrorItem=formErrors.getItem('streetNumber') />
            <small class="help-block">
              ${formErrorItem.message}
            </small>
          </#if>
        </div>
        <div class="col-xs-9 <#if formErrors?? && formErrors.hasItem('streetName')>has-error</#if>">
          <input type="text" class="form-control" aria-describedBy="label-street"
            name="street_name" id="street_name"
            placeholder="<@fmt.message key='signup.label.address.streetName' />"
            value="<#if address??>${address.streetName!}</#if>" />
          <#if formErrors?? && formErrors.hasItem('streetName')>
            <#assign formErrorItem=formErrors.getItem('streetName') />
            <small class="help-block">
              ${formErrorItem.message}
            </small>
          </#if>
        </div>
      </div>
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

    <div class="form-group <#if formErrors?? && formErrors.hasItem('phone')>has-error</#if>">
      <label class="control-label" for="phone">
        <@fmt.message key='signup.label.address.phone' />
      </label>
      <input type="text" class="form-control"
        name="phone" id="phone"
        value="<#if address??>${address.phone!}</#if>" />
      <#if formErrors?? && formErrors.hasItem('phone')>
        <#assign formErrorItem=formErrors.getItem('phone') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group <#if formErrors?? && formErrors.hasItem('mobile')>has-error</#if>">
      <label class="control-label" for="mobile">
        <@fmt.message key='signup.label.address.mobile' />
      </label>
      <input type="text" class="form-control"
        name="mobile" id="mobile"
        value="<#if address??>${address.mobile!}</#if>" />
      <#if formErrors?? && formErrors.hasItem('mobile')>
        <#assign formErrorItem=formErrors.getItem('mobile') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group <#if formErrors?? && formErrors.hasItem('fax')>has-error</#if>">
      <label class="control-label" for="fax">
        <@fmt.message key='signup.label.address.fax' />
      </label>
      <input type="text" class="form-control"
        name="fax" id="fax"
        value="<#if address??>${address.fax!}</#if>" />
      <#if formErrors?? && formErrors.hasItem('fax')>
        <#assign formErrorItem=formErrors.getItem('fax') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group mb-none">
      <input type="hidden" name="id" value="${address.id!}" />
      <button type="submit" class="btn btn-primary mr-md">
        <@fmt.message key='signup.button.save'/>
      </button>
      <a href="<@hst.link siteMapItemRefId='accountAddresses' />" role="button" class="btn btn-link">
        <@fmt.message key='signup.button.address.detail.backToAddresses' />
      </a>
    </div>
  </form>
</div>
