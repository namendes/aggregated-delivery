<#include "../include/imports.ftl">
<#import "../hstdefault/starterstore-helper.ftl" as helper>

<#macro notifications>

<script>

  function sendNotification(type, result, reference){
    var alert = document.createElement('div');
    var notificationId = "notification-"+reference;
    alert.setAttribute("id", notificationId);
    alert.setAttribute("class", "alert alert-"+type+" alert-dismissible");
    alert.setAttribute("role", "alert");
    alert.innerText = result;

    var notifications = document.getElementById("notifications");

    if(document.getElementById(notificationId) == null){
      //in case the notification with that reference id hasn' been showed yet, then append it
      notifications.append(alert);
      setTimeout(function() {alert.remove()}, 6000);
    }

  }

</script>

</#macro>

<#macro notify message reference=0>
    <#if message??>
        <@notifications/>
        <#if message?starts_with("4")>
        <script>sendNotification("danger", "Something went wrong, please contact us for further details", ${reference})</script>
        <#elseif message?starts_with("2")>
        <script>sendNotification("success", "Operation successfully completed", ${reference})</script>
        </#if>
    </#if>
</#macro>

<#macro updateCartStatus quantity=0>
    <#if ((quantity?number) >= 1) >aaa
        <script>
          function updateCartQuantity(quantity){
            var cartCounter = document.getElementById('cart-counter');
            if(quantity > 0) {
              cartCounter.innerText = "("+quantity+")";
            }
          }

          updateCartQuantity(${quantity});
        </script>
    </#if>
</#macro>