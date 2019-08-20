<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<!doctype html>
<#include "../../include/imports.ftl">

<#-- <@hst.setBundle basename="com.bloomreach.commercedxp.starterstore.components.messages"/> -->

<div class="col-xs-12">
  <h1><@fmt.message key='signup.label.manageAddresses'/></h1>

  <div class="row">
    <div class="col-xs-12 col-md-4 pull-right">
      <div class="panel panel-info">
        <div class="panel-heading"><@fmt.message key='signup.label.address.defaultAddresses'/></div>
        <div class="panel-body">
          <form method="POST" action="<@hst.actionURL />">
            <div class="form-group">
              <label for="default_shipping_address">
                <@fmt.message key='signup.label.address.defaultShippingAddress' />
              </label>
              <select name="default_shipping_address_id" id="default_shipping_address" class="form-control">
                <option value=""><@fmt.message key='signup.placeholder.address.defaultShippingAddress' /></option>
                <#if formObject??>
                  <#list formObject.addresses as address>
                    <option value="${address.id!}" <#if formObject?? && formObject.defaultShippingAddressId! == address.id!>selected</#if>>
                      <@fmt.message key='signup.label.address' /> ${address?index + 1}
                    </option>
                  </#list>
                </#if>
              </select>
            </div>
            <div class="form-group">
              <label for="default_billing_address">
                <@fmt.message key='signup.label.address.defaultBillingAddress' />
              </label>
              <select name="default_billing_address_id" id="default_billing_address" class="form-control">
                <option value=""><@fmt.message key='signup.placeholder.address.defaultShippingAddress' /></option>
                <#if formObject??>
                  <#list formObject.addresses as address>
                    <option value="${address.id!}" <#if formObject?? && formObject.defaultBillingAddressId! == address.id!>selected</#if>>
                      <@fmt.message key='signup.label.address' /> ${address?index + 1}
                    </option>
                  </#list>
                </#if>
              </select>
            </div>
            <div class="form-group mb-none">
              <input type="hidden" name="_action" value="set_default_addresses" />
              <button type="submit" class="btn btn-primary">
                <@fmt.message key='signup.button.save'/>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div class="col-xs-12 col-md-8">
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
              <#if formObject?? && formObject.addresses?has_content>
                <#list formObject.addresses as address>
                  <tr>
                    <th scope="row">
                      <a href="${addressesUrl}/item/${address.id!}">
                        <@fmt.message key='signup.label.address' /> ${address?index + 1}
                      </a>
                    </th>
                    <td valign="middle">
                      <a href="${addressesUrl}/item/${address.id!}">${address.streetNumber!} ${address.streetName!}</a>
                    </td>
                    <td valign="middle">
                      <a href="${addressesUrl}/item/${address.id!}">${address.city!}</a>
                    </td>
                    <td valign="middle">
                      <a href="${addressesUrl}/item/${address.id!}">${address.state!}</a>
                    </td>
                    <td valign="middle">
                      <a href="${addressesUrl}/item/${address.id!}">${address.postalCode!}</a>
                    </td>
                    <td valign="middle">
                      <a href="${addressesUrl}/item/${address.id!}">${address.country!}</a>
                    </td>
                    <td valign="top" class="text-right">
                      <form method="POST" action="<@hst.actionURL/>">
                        <input type="hidden" name="_action" value="delete" />
                        <input type="hidden" name="addressId" value="${address.id!}" />
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
  </div>
</div>
