<#--
@deprecated since 2.0, it is preferred to use templates using Connector SDK based POJO objects.
-->

<#-- @ftlvariable name="result" type="org.onehippo.cms7.crisp.core.resource.jackson.JacksonResource" -->
<#-- @ftlvariable name="productlist" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.crisp.core.resource.jackson.ListResourceCollection" -->
<#include "../../include/imports.ftl">
<#import "../starterstore-helper.ftl" as helper>
<#import "../starterstore-productmacro.ftl" as productmacro>

<@hst.setBundle basename="checkout"/>

<style>
  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
  }

  li.right {
    float: right;
  }

  li.left {
    float: left;
  }

  li.checkout a {
    display: block;
    text-align: center;
    padding: 16px;
    text-decoration: none;
  }

  #loading {
    background: url('<@hst.webfile path="images/ajax-loader.gif"/>') no-repeat center center;
    height: 20px;
    width: 20px;
  }
</style>

<#if result??>
  <#assign productlist = helper.resolveProperty(result, "cart.productlist", mappingResourceBundle) />
  <#assign productlist = productlist.isAnyChildContained()?then(productlist.children,"")/>
  <h3>${(productlist?has_content)?then((mappingResourceBundle['cart.intro.label']!""),(mappingResourceBundle['cart.empty.label']!""))}</h3>
  <div class="row">

    <#if productlist?has_content>
      <#list 0..productlist.size()-1 as index>
        <@productmacro.renderCartProductIntro productlist.get(index) mappingResourceBundle/>
      </#list>
    </#if>
  </div>
</#if>

<#if productlist?has_content>
  <ul class="checkout">
    <li class="checkout right">
      <a href="<@hst.link path="checkout"/>">Checkout</a>
    </li>
    <li class="checkout left">
      <a class="quickview" onclick="resetForm();openModal(document.getElementById('checkout-in-store'));">Checkout on
        your local
        store <img width="50px" src="<@hst.webfile  path="images/barcode.png"/>"/></a>
    </li>
  </ul>
</#if>


<div class="modal fade" id="checkout-in-store" tabindex="-1" role="dialog">
  <div class="modal-product-dialog" role="document">
    <div class="modal-product-content">
      <span class="modal-close" onclick="closeModal(document.getElementById('checkout-in-store'));">&times;</span>
      <div class="modal-product-body">
        <div class="col-md-4">
          <div class="row" style="text-align: center">
            Use the following QR code to checkout this cart in one of our physical stores:
          </div>

          <div class="row">
            &nbsp;
          </div>

          <div class="row" style="text-align: center">
            <#if qrcode??>
              <img src="${qrcode}"/>
            </#if>
          </div>
        </div>
        <div class="col-md-8">
          <form method="POST" id="emailform">
            <div class="row" style="text-align: center">
              <@fmt.message key='checkout.label.sendtoemail' />
            </div>

            <div class="row">
              &nbsp;
            </div>

            <div class="form-group">
              <label>
                <@fmt.message key='checkout.label.name' />
              </label>
              <input type="text" name="cname" class="form-control"
                     placeholder="<@fmt.message key='checkout.placeholder.name' />"/>
            </div>
            <div class="form-group">
              <label>
                <@fmt.message key='checkout.label.email' />
              </label>
              <input type="text" name="email" class="form-control"
                     placeholder="<@fmt.message key='checkout.placeholder.email' />"/>
            </div>

            <div class="row"> &nbsp;
              <div class="alert alert-info text-center d-none" id="successmessage">
                <strong>Success!</strong> <@fmt.message key='checkout.message.success' />
              </div>
              <div class="alert alert-danger text-center d-none" id="errormessage">
                <@fmt.message key='checkout.message.error' />
              </div>
            </div>

            <div class="row">
              <div class="col-md-12"
                   style="text-align: center; display: flex;align-items: center;justify-content: center;">
                <span> <a name="submit" id="submitbutton" class="btn btn-primary" onclick="sendEmail();">
                    <@fmt.message key='checkout.send.email'/></a>
                </span>
                <span id="loading" class="d-none"></span>
              </div>
            </div>
            <div class="row">
              &nbsp;
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</div>

<@hst.include ref="container"/>

<@hst.headContribution category="htmlHead">
  <script type="text/javascript">

    function sendEmail() {
      var url = "<@hst.link path="/"/>rest/instore/checkout";
      var formData = {
        'cname': $('input[name=cname]').val(), //for get name
        'email': $('input[name=email]').val() //for get email
      };

      if (valid(formData)) {// avoid to send an empty form
        $('input[name=cname]').css("border-bottom-color", "");
        $('input[name=email]').css("border-bottom-color", "");
        $("#successmessage").hide();
        $("#errormessage").hide();
        $("#loading").show();
        $.ajax({
                  type: "POST",
                  url: url,
                  data: formData,
                  success: function (data) {
                    $("#loading").hide();
                    if (data) {
                      $("#successmessage").show();
                      $("#errormessage").hide();
                    } else {
                      $("#successmessage").hide();
                      $("#errormessage").show();
                    }
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#loading").hide();
                    $("#successmessage").hide();
                    $("#errormessage").show();
                  }
                }
        );
      } else {
        $("#successmessage").hide();
        $("#errormessage").hide();
        if ($('input[name=cname]').val() === "") {
          $('input[name=cname]').css("border-bottom-color", "red");
        } else {
          $('input[name=cname]').css("border-bottom-color", "");
        }
        if ($('input[name=email]').val() === "" || !/(.+)@(.+){2,}\.(.+){2,}/.test($('input[name=email]').val())) {
          $('input[name=email]').css("border-bottom-color", "red");
        } else {
          $('input[name=email]').css("border-bottom-color", "");
        }

      }
    }

    function valid(formdata) {
      if (formdata.cname == "" || formdata.email == "" || !/(.+)@(.+){2,}\.(.+){2,}/.test(formdata.email)) {
        return false;
      }
      return true;
    }

    function hideLoader() {
      $('#loading').hide();
    }

    // Strongly recommended: Hide loader after 20 seconds, even if the page hasn't finished loading
    setTimeout(hideLoader, 20 * 1000);

    function resetForm() {
      $("#successmessage").hide();
      $("#errormessage").hide();
      $('input[name=cname]').val("");
      $('input[name=email]').val("");
    }

  </script>
</@hst.headContribution>
