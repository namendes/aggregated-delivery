<!doctype html>
<#include "../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<#if hst.isBeanType(formObject, 'com.bloomreach.commercedxp.starterstore.model.Customer')>
  <#include "v1/starterstore-account-addresses.ftl"/>
<#else>
  <div class="col-xs-12">
    <h1><@fmt.message key='signup.label.manageAddresses'/></h1>

    <div class="panel panel-info mb-none">
      <div class="panel-heading"><@fmt.message key='signup.label.address.addresses'/></div>
      <div class="panel-body">
        <@hst.link var="addressesUrl" siteMapItemRefId='accountAddresses' />
        <table class="table table-responsive table-striped table-hover mb-none">
          <thead>
            <tr>
              <th scope="col" valign="middle">#</th>
              <th scope="col" valign="middle">Address</th>
              <th scope="col" valign="middle">City</th>
              <th scope="col" valign="middle">State</th>
              <th scope="col" valign="middle">Postal code</th>
              <th scope="col" valign="middle">Country</th>
              <th scope="col" valign="top" class="text-right">
                <a class="btn btn-primary btn-xs" href="${addressesUrl}/item" role="button">
                  <i class="glyphicon glyphicon-plus"></i>
                  <@fmt.message key='signup.button.address.addNew' />
                </a>
              </th>
            </tr>
          </thead>
          <tbody>
            <#if formObject?? && formObject.addressGroup?? && formObject.addressGroup.addresses?has_content >
              <#list formObject.addressGroup.addresses as address>
                <tr>
                  <th scope="row">
                    <a href="${addressesUrl}/item/${address?index!}">
                      <@fmt.message key='signup.label.address' /> ${address?index + 1}
                    </a>
                  </th>
                  <td valign="middle">
                    <a href="${addressesUrl}/item/${address?index!}">${address.streetAddress!}</a>
                  </td>
                  <td valign="middle">
                    <a href="${addressesUrl}/item/${address?index!}">${address.city!}</a>
                  </td>
                  <td valign="middle">
                    <a href="${addressesUrl}/item/${address?index!}">${address.state!}</a>
                  </td>
                  <td valign="middle">
                    <a href="${addressesUrl}/item/${address?index!}">${address.postalCode!}</a>
                  </td>
                  <td valign="middle">
                    <a href="${addressesUrl}/item/${address?index!}">${address.country!}</a>
                  </td>
                  <td valign="top" class="text-right">
                    <form method="POST" action="<@hst.actionURL/>">
                      <input type="hidden" name="_action" value="delete" />
                      <input type="hidden" name="addressId" value="${address.id!resourceId!}" />
                      <button type="submit" class="btn btn-danger btn-xs">
                        <i class="glyphicon glyphicon-remove"></i>
                        <@fmt.message key='signup.button.delete'/>
                      </button>
                    </form>
                  </td>
                </tr>
              </#list>
            </#if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</#if>
