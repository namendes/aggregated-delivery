<!doctype html>
<#include "../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<div class="col-xs-12 col-md-offset-3 col-md-6">
  <h1><@fmt.message key='signup.tab.changepassword.title'/></h1>

  <#if formErrors?? && formErrors.hasItem('form')>
    <#assign formErrorItem=formErrors.getItem('form') />
    <div class="alert alert-danger" role="alert">
      ${formErrorItem.message}
    </div>
  </#if>

  <form method="POST" action="<@hst.actionURL />">
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

    <div class="form-group <#if formErrors?? && formErrors.hasItem('newPassword')>has-error</#if>">
      <label class="control-label" for="new_password">
        <@fmt.message key='signup.label.newPassword' />
      </label>
      <input type="password" class="form-control"
        name="new_password" id="new_password"
        placeholder="<@fmt.message key='signup.placeholder.newPassword' />" />
      <#if formErrors?? && formErrors.hasItem('newPassword')>
        <#assign formErrorItem=formErrors.getItem('newPassword') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group <#if formErrors?? && formErrors.hasItem('newPassword2')>has-error</#if>">
      <label class="control-label" for="new_password_confirmation">
        <@fmt.message key='signup.label.newPassword2' />
      </label>
      <input type="password" class="form-control"
        name="new_password2" id="new_password_confirmation"
        placeholder="<@fmt.message key='signup.placeholder.newPassword2' />" />
      <#if formErrors?? && formErrors.hasItem('newPassword2')>
        <#assign formErrorItem=formErrors.getItem('newPassword2') />
        <small class="help-block">
          ${formErrorItem.message}
        </small>
      </#if>
    </div>

    <div class="form-group mb-none">
      <button type="submit" class="btn btn-primary">
        <@fmt.message key='signup.button.save'/>
      </button>
    </div>
  </form>
</div>
