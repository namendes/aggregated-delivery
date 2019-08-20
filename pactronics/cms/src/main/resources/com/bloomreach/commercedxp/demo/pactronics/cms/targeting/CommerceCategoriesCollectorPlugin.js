/*
 * Copyright 2012-2017 Hippo B.V. (http://www.onehippo.com)
 */
(function () {
  "use strict";

  Ext.namespace('Pactronics');

  Pactronics.CommerceCategoriesCollectorPlugin = Ext.extend(Hippo.Targeting.TermsFrequencyCollectorPlugin, {

    constructor: function (config) {
      this.categories = new Hippo.Targeting.Map(config.categories, 'category', 'name');

      Pactronics.CommerceCategoriesCollectorPlugin.superclass.constructor.call(this, Ext.apply(config, {
        editor: {
          termToDisplayNameMap: this.categories,
          size: config.size,
          xtype: 'Hippo.Targeting.TermsFrequencyTargetingDataCheckboxGroup'
        },
        termToDisplayNameMap: this.categories
      }));
    }

  });

}());