/*
 * Copyright 2012-2017 Hippo B.V. (http://www.onehippo.com)
 */
(function () {
  "use strict";

  Ext.namespace('Pactronics');

  Pactronics.CommerceBrandsCollectorPlugin = Ext.extend(Hippo.Targeting.TermsFrequencyCollectorPlugin, {

    constructor: function (config) {
      this.brands = new Hippo.Targeting.Map(config.brands, 'brand', 'name');

      Pactronics.CommerceBrandsCollectorPlugin.superclass.constructor.call(this, Ext.apply(config, {
        editor: {
          termToDisplayNameMap: this.brands,
          size: config.size,
          xtype: 'Hippo.Targeting.TermsFrequencyTargetingDataCheckboxGroup'
        },
        termToDisplayNameMap: this.brands
      }));
    }

  });

}());