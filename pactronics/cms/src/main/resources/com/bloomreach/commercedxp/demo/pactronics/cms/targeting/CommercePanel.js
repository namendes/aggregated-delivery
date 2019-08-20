/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";

Ext.namespace('Pactronics');

Pactronics.CommercePanel = Ext.extend(Hippo.Targeting.BaseVisitorDetailsPanel, {

    constructor: function (config) {
        Ext.apply(config, {
            items: [
                {
                    xtype: 'Hippo.Targeting.Journey'
                },
                {
                    xtype: 'Hippo.Targeting.Spacer'
                },
                {
                    xtype: 'Hippo.Targeting.VisitorDetailsRightColumn',
                    items: [
                        {
                            xtype: 'Hippo.Targeting.MatchingSegments'
                        },
                        {
                            xtype: 'Hippo.Targeting.VisitorDetailsRightColumnPanel',
                            title: config.resources['interest-title'],
                            height: 220,
                            layout: 'hbox',
                            layoutConfig: {
                                align: 'stretch'
                            },
                            items: [
                                {
                                    flex: 1,
                                    xtype: 'Hippo.Targeting.TermsFrequencyChart',
                                    characteristic: 'commerceCategories',
                                    noDataText: config.resources['commerce-categories-no-data'],
                                    title: config.resources['commerce-categories-title']
                                },
                                {
                                    flex: 1,
                                    xtype: 'Hippo.Targeting.TermsFrequencyChart',
                                    characteristic: 'commerceBrands',
                                    noDataText: config.resources['commerce-brands-no-data'],
                                    title: config.resources['commerce-brands-title']
                                }
                            ]
                        },
                        {
                            xtype: 'Hippo.Targeting.VisitorCharacteristics'
                        }
                    ]
                }
            ]
        });
        Pactronics.CommercePanel.superclass.constructor.call(this, config);
    }

});