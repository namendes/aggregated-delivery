<!doctype html>
<#include "../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<div class="col-xs-12 col-md-offset-3 col-md-6 col-lg-offset-4 col-lg-4">
  <h1><@fmt.message key='signin.title'/></h1>

  <#if formErrors?? && formErrors.hasItem('form')>
    <#assign formErrorItem=formErrors.getItem('form') />
    <div class="alert alert-danger" role="alert">
      ${formErrorItem.message}
    </div>
  </#if>

  <form method="POST" action="<@hst.actionURL />">
    <div class="form-group <#if formErrors?? && formErrors.hasItem('email')>has-error</#if>">
      <label class="control-label" for="email">
        <@fmt.message key='signup.label.email' />
      </label>
      <input type="email" class="form-control"
        id="email" name="email"
        autofocus="true" placeholder="<@fmt.message key='signup.placeholder.email' />"
        value="<#if formObject??>${formObject.email!}</#if>" />
      <#if formErrors?? && formErrors.hasItem('email')>
        <#assign formErrorItem=formErrors.getItem('email') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group <#if formErrors?? && formErrors.hasItem('password')>has-error</#if>">
      <label class="control-label" for="password">
        <@fmt.message key='signup.label.password' />
      </label>
      <input type="password" class="form-control"
        name="password" id="password"
        placeholder="<@fmt.message key='signup.placeholder.password' />" />
      <#if formErrors?? && formErrors.hasItem('password')>
        <#assign formErrorItem=formErrors.getItem('password') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group mb-none">
        <input type="hidden" name="destination" value="${destination!}" />
        <button type="submit" class="btn btn-primary mr-md">
          <@fmt.message key='signin.button.signin'/>
        </button>
        <a href="<@hst.link path='/signup'/>" role="button" class="btn btn-link">Sign up</a>
    </div>
  </form>
</div>
