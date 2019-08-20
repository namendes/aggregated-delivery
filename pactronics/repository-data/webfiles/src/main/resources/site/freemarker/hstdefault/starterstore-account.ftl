<!doctype html>
<#include "../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<div class="col-xs-12 col-md-offset-3 col-md-6">
  <h1><@fmt.message key='signup.tab.account.title'/></h1>

  <#if formErrors?? && formErrors.hasItem('form')>
    <#assign formErrorItem=formErrors.getItem('form') />
    <div class="alert alert-danger" role="alert">
      ${formErrorItem.message}
    </div>
  </#if>

  <form method="POST" action="<@hst.actionURL />">
    <div class="form-group">
      <span class="<#if formErrors?? && (formErrors.hasItem('firstName')
        || formErrors.hasItem('middleName')
        || formErrors.hasItem('lastName'))>has-error</#if>">
        <label class="control-label" for="first_name" id="label-customer-name">
          <@fmt.message key='signup.label.name' />
        </label>
      </span>
      <div class="row">
        <div class="col-xs-4 <#if formErrors?? && formErrors.hasItem('firstName')>has-error</#if>">
          <input type="text" class="form-control"
            name="first_name" id="first_name"
            placeholder="<@fmt.message key='signup.placeholder.firstName' />"
            value="<#if formObject??>${formObject.firstName!}</#if>" />
          <#if formErrors?? && formErrors.hasItem('firstName')>
            <#assign formErrorItem=formErrors.getItem('firstName') />
            <small class="help-block">
              ${formErrorItem.message}
            </small>
          </#if>
        </div>
        <div class="col-xs-4 <#if formErrors?? && formErrors.hasItem('middleName')>has-error</#if>">
          <input type="text" class="form-control" aria-describedBy="label-customer-name"
            name="middle_name" id="middle_name"
            placeholder="<@fmt.message key='signup.placeholder.middleName' />"
            value="<#if formObject??>${formObject.middleName!}</#if>" />
          <#if formErrors?? && formErrors.hasItem('middleName')>
            <#assign formErrorItem=formErrors.getItem('middleName') />
            <small class="help-block">
              ${formErrorItem.message}
            </small>
          </#if>
        </div>
        <div class="col-xs-4 <#if formErrors?? && formErrors.hasItem('lastName')>has-error</#if>">
          <input type="text" class="form-control" aria-describedBy="label-customer-name"
            name="last_name" id="last_name"
            placeholder="<@fmt.message key='signup.placeholder.lastName' />"
            value="<#if formObject??>${formObject.lastName!}</#if>" />
          <#if formErrors?? && formErrors.hasItem('lastName')>
            <#assign formErrorItem=formErrors.getItem('lastName') />
            <small class="help-block">
              ${formErrorItem.message}
            </small>
          </#if>
        </div>
      </div>
    </div>

    <div class="form-group <#if formErrors?? && formErrors.hasItem('email')>has-error</#if>">
      <label class="control-label" for="email">
        <@fmt.message key='signup.label.email' />
      </label>
      <input type="email" class="form-control"
        name="email" id="email"
        placeholder="<@fmt.message key='signup.placeholder.email' />"
        value="<#if formObject??>${formObject.email!}</#if>" />
      <#if formErrors?? && formErrors.hasItem('email')>
        <#assign formErrorItem=formErrors.getItem('email') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group mb-none">
      <input type="hidden" name="id" value="${formObject.id!}" />
      <button type="submit" class="btn btn-primary">
        <@fmt.message key='signup.button.save'/>
      </button>
    </div>
  </form>
</div>
