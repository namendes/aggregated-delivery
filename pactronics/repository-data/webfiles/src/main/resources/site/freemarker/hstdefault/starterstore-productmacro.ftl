<#include "../include/imports.ftl">
<#import "starterstore-helper.ftl" as helper>
<#import "../pactronics/starterstore-genericmacro.ftl" as genericmacro>
<@hst.setBundle basename="translations.labels"/>
<@fmt.message key="text.knowmore" var="knowmore"/>

<#macro renderIntro result resourceBundle bootstrapClasses="col-sm-6 col-lg-4 col-md-6">

<div class="col-xs-12 ${bootstrapClasses} search-card">
    <div class="thumbnail">
        <div class="center-cropped"
             style="margin-left:auto;margin-right:auto; background-image: url(${helper.resolveProperty(result, "product.image", resourceBundle)!"http://placehold.it/320x150"});">
        </div>
    <#--<img src="" alt="">-->
        <div class="caption details_card" style="height: 155px;">
        <#--<h4 class="pull-right"></h4>-->
      <@hst.link siteMapItemRefId="product" var="basePath"/>
      <#assign productLink=helper.generateLink(basePath, helper.resolveProperty(result, "product.id", resourceBundle)!"")/>
            <a href="${productLink}">
                ${helper.resolveProperty(result, "product.name", resourceBundle)!}
            </a>

        <#assign  productid=helper.resolveProperty(result, "product.id", resourceBundle)!/>
        <#assign  productname=helper.resolveProperty(result, "product.name", resourceBundle)!/>
        <#assign reviews=helper.resolveProperty(result, "product.reviews", resourceBundle)!/>
        <#assign reviewscount=helper.resolveProperty(result, "product.reviewscount", resourceBundle)!/>

        <#if !reviewscount?has_content>
            <#assign reviewscount=0/>
        </#if>

            <p class="quickview" onclick="openModal(${productid}); BrTrk.getTracker().logEvent('product', 'quickview', {'prod_id' : '${productid}','prod_name':'${productname}','sku':''});">Quickview</p>

        <#if reviewscount!=0>
            <#list 0..4 as starCount>
                <#if starCount<=reviews?round-1>
              <span>★</span>
                <#else>
              <span>☆</span>
                </#if>
            </#list>
        <span class="rating_text">${reviews} (${reviewscount})</span>
        <#else>
          <p>No reviews available</p>
        </#if>
            <p class="price">$ ${helper.resolveProperty(result, "product.price", resourceBundle)!}
         <@hst.actionURL var="cartProductAddLink"/>
            <form style="float:right;margin-top:-33px;margin-right:-19px" action="${cartProductAddLink}" id="cart"
                  method="POST"
                  onsubmit="BrTrk.getTracker().logEvent('cart', 'click-add', {'prod_id': '${productid}', 'sku' : ''});">
                <input type="hidden" id="_pid" name="_pid" value="${productid}"/>
                <input type="submit" style="width: 60px; height: 32px;" class="btn btn-secondary" value="Buy"/>
            </form>

            </p>
        </div>
    </div>
</div>



<div class="modal fade" id="${productid!}" tabindex="-1" role="dialog">
    <div class="modal-product-dialog" role="document">
        <div class="modal-product-content">
            <span class="modal-close" onclick="closeModal(${productid!})">&times;</span>
            <div class="modal-product-body">
                <div class="col-md-4">
                    <img src="${helper.resolveProperty(result, "product.image", resourceBundle)!"http://placehold.it/320x150"}">
                </div>
                <div class="col-md-8">
                    <h1 class="title">${helper.resolveProperty(result, "product.name", resourceBundle)!}</h1>

            <#if !reviewscount?has_content>
                <#assign reviewscount=0/>
            </#if>

            <#if reviewscount!=0>
                <#list 0..4 as starCount>
                    <#if starCount<=reviews?round-1>
                  <span>★</span>
                    <#else>
                  <span>☆</span>
                    </#if>
                </#list>
            <span class="rating_text">${reviews} (${reviewscount})</span>
            <#else>
              <p>No reviews available</p>
            </#if>

                    <p class="price">$ ${helper.resolveProperty(result, "product.price", resourceBundle)!}</p>
                    <p class="light-text">${helper.resolveProperty(result, "product.description", resourceBundle)!}</p>
                    <a href="${helper.addParameterToLink(productLink, hstRequest, "_cc", resourceBundle["connector"])}"
                       class="more-detail-btn">More details</a>
                </div>
            </div>
        </div>
    </div>
</div>

</#macro>

<#macro renderIntroAtc result resourceBundle addToCartLink bootstrapClasses="col-sm-4 col-lg-4 col-md-4" >

    <div class="col-xs-12 ${bootstrapClasses}" style="min-width: 270px">
        <div class="thumbnail">
            <div class="center-cropped"
                 style="background-image: url(${helper.resolveProperty(result, "product.image", resourceBundle)!"http://placehold.it/320x150"});">
            </div>
            <img src="" alt=""/>
            <div class="caption">
                <h4 class="pull-right"></h4>
                <@hst.link siteMapItemRefId="product" var="basePath"/>
                <#local pid = helper.resolveProperty(result, "product.code", resourceBundle)!""/>
                <#if pid?is_hash>
                    <#local pid = pid.defaultValue/>
                </#if>
                <#local productLink=helper.generateLink(basePath, pid)/>
                <h4>
                    <a href="${productLink}">
                        ${helper.resolveProperty(result, "product.name", resourceBundle)!}
                    </a>
                </h4>
                <#local atc><@addToCartButton addToCartLink pid/></#local>
                <@renderPrice result mappingResourceBundle atc/>
            </div>
        </div>
    </div>

</#macro>

<#macro renderIntroCheckout result resourceBundle>

<div class="col-xs-12 col-sm-6 col-lg-4 col-md-6 search-card">
    <div class="thumbnail">
        <div class="center-cropped"
             style="margin-left:auto;margin-right:auto;background-image: url(${helper.resolveProperty(result, "product.image", resourceBundle)!"http://placehold.it/320x150"});">
        </div>
    <#--<img src="" alt="">-->
        <div class="caption details_card" style="height: 155px;">
        <#--<h4 class="pull-right"></h4>-->
      <@hst.link siteMapItemRefId="product" var="basePath"/>
      <#assign productLink=helper.generateLink(basePath, helper.resolveProperty(result, "product.id", resourceBundle)!"")/>
            <a href="${helper.addParameterToLink(productLink, hstRequest, "_cc", resourceBundle["connector"])}">
                ${helper.resolveProperty(result, "product.name", resourceBundle)!}
            </a>

        <#assign  productid=helper.resolveProperty(result, "product.id", resourceBundle)!/>
        <#assign  productname=helper.resolveProperty(result, "product.name", resourceBundle)!/>
        <#assign reviews=helper.resolveProperty(result, "product.reviews", resourceBundle)!/>
        <#assign reviewscount=helper.resolveProperty(result, "product.reviewscount", resourceBundle)!/>

        <#if !reviewscount?has_content>
            <#assign reviewscount=0/>
        </#if>

            <p class="quickview" onclick="openModal(${productid}); BrTrk.getTracker().logEvent('product', 'quickview', {'prod_id' : '${productid}','prod_name':'${productname}','sku':''});">Quickview</p>

        <#if reviewscount!=0>
            <#list 0..4 as starCount>
                <#if starCount<=reviews?round-1>
              <span>★</span>
                <#else>
              <span>☆</span>
                </#if>
            </#list>
        <span class="rating_text">${reviews} (${reviewscount})</span>
        <#else>
          <p>No reviews available</p>
        </#if>
            <p class="price">$ ${helper.resolveProperty(result, "product.price", resourceBundle)!}
            <form style="float:right;margin-top:-33px;margin-right:-19px" action="${helper.addParameterToLink(productLink, hstRequest, "_cc", resourceBundle["connector"])}" id="cart"
                  method="POST">
                <input type="hidden" id="_pid" name="_pid" value="${productid}"/>
                <input type="submit" style="width: auto; height: 32px;" class="btn btn-primary" value="Details"/>
            </form>
            </p>
        </div>
    </div>
</div>



<div class="modal fade" id="${productid!}" tabindex="-1" role="dialog">
    <div class="modal-product-dialog" role="document">
        <div class="modal-product-content">
            <span class="modal-close" onclick="closeModal(${productid!})">&times;</span>
            <div class="modal-product-body">
                <div class="col-md-4">
                    <img src="${helper.resolveProperty(result, "product.image", resourceBundle)!"http://placehold.it/320x150"}">
                </div>
                <div class="col-md-8">
                    <h1 class="title">${helper.resolveProperty(result, "product.name", resourceBundle)!}</h1>

            <#if !reviewscount?has_content>
                <#assign reviewscount=0/>
            </#if>

            <#if reviewscount!=0>
                <#list 0..4 as starCount>
                    <#if starCount<=reviews?round-1>
                  <span>★</span>
                    <#else>
                  <span>☆</span>
                    </#if>
                </#list>
            <span class="rating_text">${reviews} (${reviewscount})</span>
            <#else>
              <p>No reviews available</p>
            </#if>

                    <p class="price">$ ${helper.resolveProperty(result, "product.price", resourceBundle)!}</p>
                    <p class="light-text">${helper.resolveProperty(result, "product.description", resourceBundle)!}</p>
                    <a href="${helper.addParameterToLink(productLink, hstRequest, "_cc", resourceBundle["connector"])}"
                       class="more-detail-btn">More details</a>
                </div>
            </div>
        </div>
    </div>
</div>

</#macro>

<#macro renderFull title image description fullResponse resourceBundle pid>

<section id="product_page_banner" style="max-height: 560px;">
    <div id="background" class="product_background">
        <div class="row" style="background-image: url(${image}); background-size:cover; width: 100%; min-height: 600px;">
            <div class="col-md-offset-1 col-sm-offset-1 col-xs-12">
                <div class="product_details_box">
                    <h4><a class="title" href="#">${title!}</a></h4>
                    <div class="model_text">
                        <p>${description!}</p>
                    </div>
                    <h4 class="price"><@renderPrice fullResponse resourceBundle/></h4>

                    <div class="add_to_cart_box">
            <@hst.actionURL var="cartProductAddLink"/>
            <@addToCartButton cartProductAddLink pid ""/>
            <@hst.link var="locations" path="locations"/>
                        <a style="text-decoration: none" href=${locations}>
                            <p class="light-text" style="font-weight: 600; color: #ffffff; text-align: center;padding-top: 10px;">FIND A STORE NEAR YOU</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</#macro>

<#macro addToCartButton addToCartLink pid className="">
   <form action="${addToCartLink}" id="cart" method="POST" class="${className}"
         onsubmit="BrTrk.getTracker().logEvent('cart', 'click-add', {'prod_id': '${pid}', 'sku' : ''});">
       <input type="hidden" id="_pid" name="_pid" value="${pid}"/>
       <input type="submit" class="btn btn-primary" value="Add to Cart"/>
   </form>
</#macro>

<#macro renderFullNonExperience title image description fullResponse resourceBundle pid>
        <div class="product_details_non_experience row">
            <div class="col-md-7 col-sm-12" style="margin-left: auto;margin-right: auto;">
                <img class="centered_img" src="${image!}" alt="">
            </div>
            <div class="col-md-5 col-sm-12" style="margin-right: auto; margin-left: auto;">
                <div class="product_details">
                    <h2>${title!}</h2>
                    <div class="model_text">
                        <p>- Long Lasting Battery</p>
                        <p>- Set goals for your health and nutrition</p>
                        <p>- Keep track of conversations</p>
                        <p>- Stylish and Light</p>
                        <p>The ${title} is the ultimate smartwatch!</p>
                    </div>
                    <div class="price">
                        <h3><@renderPrice fullResponse resourceBundle/></h3>
                    </div>
                    <@hst.actionURL var="cartProductAddLink"/>
                    <div class="add_to_cart_box">
                        <form action="${cartProductAddLink}" id="cart" method="POST">
                            <input type="hidden" id="_pid" name="_pid" value="${pid}"/>
                            <input type="submit" class="add_to_cart_btn" value="Add to Cart"/>
                        </form>
                        <input type="submit" class="save_later_btn" value="Save for Later"/>
                      <@hst.link var="locations" path="locations"/>
                        <a style="text-decoration: none" href=${locations}>
                            <p class="light-text" style="font-weight: 600">FIND A STORE NEAR YOU</p></a>
                    </div>

                </div>
            </div>
        </div>
        <div class="row">
            <div class="detail_description col-md-12">
                <h2>${knowmore}</h2>
                <p style="font-weight: 600;"> ${description!}</p>
            </div>
        </div>



</#macro>

<#macro renderCartItems result resourceBundle>
<div>
    <img class="center-cropped" src="${helper.resolveProperty(result, "product.image", resourceBundle)!""}">
</div>
<div>
    <h4 style="margin-bottom:0px;">
    <@hst.link siteMapItemRefId="product" var="basePath"/>
    <#assign productLink=helper.generateLink(basePath, helper.resolveProperty(result, "cart.product.id", resourceBundle)!"")/>
        <a class="title"
           href="${basePath}/${result.getValue("variant/sku")}">
            ${helper.resolveProperty(result, "product.name", resourceBundle)!}
        </a>
    </h4>
    <p class="light_text"><@renderPrice result resourceBundle/> -
        Quantity ${helper.resolveProperty(result, "cart.item.quantity", resourceBundle)}</p>

    <h4 style="margin-left:10px;margin-top:0px">
        <form method="POST">
            <input type="hidden" id="_action" name="_action" value="remove"/>
            <input type="hidden" id="_cartItemid" name="_cartItemId" name="cartItemId"
                   value="${helper.resolveProperty(result, "cart.item.id", resourceBundle)!""}"/>
            <@hst.actionURL var="cartProductRemoveLink"/>
            <button class="btn btn-md btn-primary btn-scroll" type="submit" formaction="${cartProductRemoveLink}">
                Remove
            </button>
        </form>
    </h4>
</div>
</#macro>

<#macro renderCartProductIntro result resourceBundle>
<div class="row cart-row">
  <@renderCartItems result resourceBundle/>
    <div class="quantity-div">
        <form method="POST">
            <h4 style="margin-top:0px;display:inline-block">
                Quantity
            </h4>
            <input type="hidden" id="_action" name="_action" value="update"/>
            <input type="hidden" id="_cartItemid" name="_cartItemId"
                   value="${helper.resolveProperty(result, "cart.item.id", resourceBundle)!""}"/>
            <input type="text" id="_ciq" name="_ciq" size="3"
                   value="${helper.resolveProperty(result, "cart.item.quantity", resourceBundle)!"1"}"/>
          <@hst.actionURL var="cartProductUpdateLink"/>
            <button style="display:block;margin: 0px;margin-left:76px;margin-top: 10px;width: 100px;"
                    class="btn btn-md btn-primary btn-scroll quantity-btn" type="submit"
                    formaction="${cartProductUpdateLink}">Set
            </button>
        </form>

    </div>
</div>

</#macro>

<#macro renderPrice fullResponse resourceBundle additionalContent="">
    <#local currency=helper.resolveProperty(fullResponse, "product.currency", resourceBundle)/>
    <#local precision = resourceBundle["product.priceprecision"]?number/>
    <#local price = helper.resolveProperty(fullResponse, "product.price", resourceBundle) />
    <#if price?is_number>
        <div class="h4 mb-none">
            <#if currency?has_content>
                ${currency}
            <#else>
                ${resourceBundle["product.currency"]!""}
            </#if>
            ${(helper.resolveProperty(fullResponse, "product.price", resourceBundle)/precision)!""}
            ${additionalContent}
        </div>
    </#if>
</#macro>

<@hst.headContribution category="htmlHead">
            <script>
                function openModal (id) {
                    id.style.display = 'block';
                    id.style.opacity = 1;
                }

                function closeModal (id) {
                    id.style.display = 'none';
                    id.style.opacity = 0;
                }
            </script>
</@hst.headContribution>
