<#include "../include/imports.ftl">
<#import "starterstore-pixel.ftl" as pixelmacro>

<div class="container-fluid">
  <div class="row">
    <@hst.include ref="top-container"/>
    <div class="col-md-3">
          <@hst.include ref="facet-list"/>
    </div>
    <div class="col-md-9">
          <@hst.include ref="product-list"/>
    </div>
  </div>
</div>

<@pixelmacro.add/>