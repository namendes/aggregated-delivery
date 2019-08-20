<#include "../../include/imports.ftl">

<#if document??>
    <@hst.manageContent hippobean=document />


    <div id="title" class="row" style="background: #272727; height: 180px; text-align: center; padding-top: 50px;">
      <div style="color:#565ce4;font-size: xx-large;">${document.title?html}</div>
      <div id="bottomtext" style="color:#fff;margin-top: 45px;">${document.introduction}</div>
      </p>
    </div>


        <div class="row buttons-tabs-centered">

          <div class="col-md-4">
            <ul id="buttonTabs" class="nav-tabs nav-tabs-center">
              <li class="active">
                <a href="#tab-c1" data-toggle="tab" aria-expanded="true">${document.location1}</a>
              </li>

                <#if document.location2?has_content>
                <li class="">
                  <a href="#tab-c2" data-toggle="tab" aria-expanded="false">${document.location2}</a>
                </li>
                </#if>

                <#if document.location3?has_content>
                <li class="">
                  <a href="#tab-c3" data-toggle="tab" aria-expanded="false">${document.location3}</a>
                </li>
                </#if>

                <#if document.location4?has_content>
                <li class="">
                  <a href="#tab-c4" data-toggle="tab" aria-expanded="false">${document.location4}</a>
                </li>
                </#if>

                <#if document.location5?has_content>
                <li class="">
                  <a href="#tab-c5" data-toggle="tab" aria-expanded="false">${document.location5}</a>
                </li>
                </#if>
            </ul>
          </div>
            <div class="col-md-2"></div>
          <div class="col-md-6">
            <div id="myTabContent" class="tab-content" style="margin-top: 50px;">

              <div class="tab-pane active" id="tab-c1">
                    <@hst.html var="map1" hippohtml=document.map1/>
                  ${map1}
              </div>

              <div class="tab-pane" id="tab-c2">
                    <@hst.html var="map2" hippohtml=document.map2/>
                  ${map2}
              </div>

              <div class="tab-pane" id="tab-c3">
                    <@hst.html var="map3" hippohtml=document.map3/>
                  ${map3}
              </div>

              <div class="tab-pane" id="tab-c4">
                    <@hst.html var="map4" hippohtml=document.map4/>
                  ${map4}
              </div>

              <div class="tab-pane" id="tab-c5">
                    <@hst.html var="map5" hippohtml=document.map5/>
                  ${map5}
              </div>

            </div>
          </div>

        </div>


<div class="row" style="text-align: center">
    <@hst.html var="content" hippohtml=document.content/>
    ${document.content}
</div>
<#elseif editMode>
  <p>no document</p>
</#if>
