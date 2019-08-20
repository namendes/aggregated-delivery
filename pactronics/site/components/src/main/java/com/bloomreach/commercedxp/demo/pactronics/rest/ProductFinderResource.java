package com.bloomreach.commercedxp.demo.pactronics.rest;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.query.filter.Filter;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.linking.HstLink;
import org.hippoecm.hst.core.linking.HstLinkCreator;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.onehippo.cms7.essentials.components.rest.BaseRestResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bloomreach.commercedxp.demo.pactronics.rest.model.ProductFinderLabels;
import com.bloomreach.commercedxp.demo.pactronics.rest.model.ProductFinderOption;


/**
 * @version "$Id$"
 */

@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML, MediaType.APPLICATION_FORM_URLENCODED})
@Path("/product-finder/")
public class ProductFinderResource extends BaseRestResource {

    private static final Logger LOGGER = LoggerFactory.getLogger(ProductFinderResource.class);

    @GET
    @Path("/labels")
    public ProductFinderLabels index(@Context HttpServletRequest request) {

        HstRequestContext hstRequestContext = RequestContextProvider.get();


        try {
            HstQuery query = hstRequestContext.getQueryManager().createQuery(hstRequestContext.getSiteContentBaseBean(), "resourcebundle:resourcebundle");
            query.setLimit(1);

            Filter filter = query.createFilter();

            filter.addEqualTo("resourcebundle:id", "product.finder");

            query.setFilter(filter);

            HstQueryResult hstQueryResult = query.execute();

            final HstLinkCreator hstLinkCreator = hstRequestContext.getHstLinkCreator();
            final HippoBean folderBean = hstRequestContext.getSiteContentBaseBean().getParentBean().getParentBean().getBean("gallery/brxforcdemo/product-finder");
            final HstLink folderLink = hstLinkCreator.create(folderBean, hstRequestContext);
            String folderPath = folderLink.toUrlForm(hstRequestContext, true) + "/";

            if (hstQueryResult.getSize() > 0) {
                HippoBean resourceBundleBean = hstQueryResult.getHippoBeans().nextHippoBean();

                String[] keys = resourceBundleBean.getProperty("resourcebundle:keys");
                String[] values = resourceBundleBean.getProperty("resourcebundle:messages");

                ProductFinderLabels productFinderLabels = new ProductFinderLabels();

                String tab1Name = "";
                String tab2Name = "";
                String tab3Name = "";
                String tab4Name = "";

                String tab1Heading = "";
                String tab2Heading = "";
                String tab3Heading = "";
                String tab4Heading = "";

                String tab1Image = folderPath;
                String tab2Image = folderPath;
                String tab3Image = folderPath;
                String tab4Image = folderPath;

                ProductFinderOption tab1Option1 = new ProductFinderOption();
                ProductFinderOption tab1Option2 = new ProductFinderOption();
                ProductFinderOption tab1Option3 = new ProductFinderOption();
                ProductFinderOption tab2Option1 = new ProductFinderOption();
                ProductFinderOption tab2Option2 = new ProductFinderOption();
                ProductFinderOption tab2Option3 = new ProductFinderOption();
                ProductFinderOption tab3Option1 = new ProductFinderOption();
                ProductFinderOption tab3Option2 = new ProductFinderOption();
                ProductFinderOption tab3Option3 = new ProductFinderOption();
                ProductFinderOption tab4Option1 = new ProductFinderOption();
                ProductFinderOption tab4Option2 = new ProductFinderOption();
                ProductFinderOption tab4Option3 = new ProductFinderOption();


                for (int i = 0; i < keys.length; i++) {

                    String key = keys[i];

                    String value = values[i];

                    switch (key) {
                        case "tab1.name":
                            tab1Name = value;
                            break;
                        case "tab2.name":
                            tab2Name = value;
                            break;
                        case "tab3.name":
                            tab3Name = value;
                            break;
                        case "tab4.name":
                            tab4Name = value;
                            break;
                        case "tab1.heading":
                            tab1Heading = value;
                            break;
                        case "tab2.heading":
                            tab2Heading = value;
                            break;
                        case "tab3.heading":
                            tab3Heading = value;
                            break;
                        case "tab4.heading":
                            tab4Heading = value;
                            break;
                        case "tab1.image":
                            tab1Image += value;
                            break;
                        case "tab2.image":
                            tab2Image += value;
                            break;
                        case "tab3.image":
                            tab3Image += value;
                            break;
                        case "tab4.image":
                            tab4Image += value;
                            break;
                        case "tab1.option1.text":
                            tab1Option1.setText(value);
                            break;
                        case "tab1.option2.text":
                            tab1Option2.setText(value);
                            break;
                        case "tab1.option3.text":
                            tab1Option3.setText(value);
                            break;
                        case "tab2.option1.text":
                            tab2Option1.setText(value);
                            break;
                        case "tab2.option2.text":
                            tab2Option2.setText(value);
                            break;
                        case "tab2.option3.text":
                            tab2Option3.setText(value);
                            break;
                        case "tab3.option1.text":
                            tab3Option1.setText(value);
                            break;
                        case "tab3.option2.text":
                            tab3Option2.setText(value);
                            break;
                        case "tab3.option3.text":
                            tab3Option3.setText(value);
                            break;
                        case "tab4.option1.text":
                            tab4Option1.setText(value);
                            break;
                        case "tab4.option2.text":
                            tab4Option2.setText(value);
                            break;
                        case "tab4.option3.text":
                            tab4Option3.setText(value);
                            break;
                        case "tab1.option1.category":
                            tab1Option1.setFacetCategory(value);
                            break;
                        case "tab1.option2.category":
                            tab1Option2.setFacetCategory(value);
                            break;
                        case "tab1.option3.category":
                            tab1Option3.setFacetCategory(value);
                            break;
                        case "tab2.option1.category":
                            tab2Option1.setFacetCategory(value);
                            break;
                        case "tab2.option2.category":
                            tab2Option2.setFacetCategory(value);
                            break;
                        case "tab2.option3.category":
                            tab2Option3.setFacetCategory(value);
                            break;
                        case "tab3.option1.category":
                            tab3Option1.setFacetCategory(value);
                            break;
                        case "tab3.option2.category":
                            tab3Option2.setFacetCategory(value);
                            break;
                        case "tab3.option3.category":
                            tab3Option3.setFacetCategory(value);
                            break;
                        case "tab4.option1.category":
                            tab4Option1.setFacetCategory(value);
                            break;
                        case "tab4.option2.category":
                            tab4Option2.setFacetCategory(value);
                            break;
                        case "tab4.option3.category":
                            tab4Option3.setFacetCategory(value);
                            break;
                        case "tab1.option1.value":
                            tab1Option1.setFacetValue(value);
                            break;
                        case "tab1.option2.value":
                            tab1Option2.setFacetValue(value);
                            break;
                        case "tab1.option3.value":
                            tab1Option3.setFacetValue(value);
                            break;
                        case "tab2.option1.value":
                            tab2Option1.setFacetValue(value);
                            break;
                        case "tab2.option2.value":
                            tab2Option2.setFacetValue(value);
                            break;
                        case "tab2.option3.value":
                            tab2Option3.setFacetValue(value);
                            break;
                        case "tab3.option1.value":
                            tab3Option1.setFacetValue(value);
                            break;
                        case "tab3.option2.value":
                            tab3Option2.setFacetValue(value);
                            break;
                        case "tab3.option3.value":
                            tab3Option3.setFacetValue(value);
                            break;
                        case "tab4.option1.value":
                            tab4Option1.setFacetValue(value);
                            break;
                        case "tab4.option2.value":
                            tab4Option2.setFacetValue(value);
                            break;
                        case "tab4.option3.value":
                            tab4Option3.setFacetValue(value);
                            break;
                    }
                }


                productFinderLabels.addTabName(tab1Name);
                productFinderLabels.addTabName(tab2Name);
                productFinderLabels.addTabName(tab3Name);
                productFinderLabels.addTabName(tab4Name);
                productFinderLabels.addTabHeading(tab1Heading);
                productFinderLabels.addTabHeading(tab2Heading);
                productFinderLabels.addTabHeading(tab3Heading);
                productFinderLabels.addTabHeading(tab4Heading);
                productFinderLabels.addTabImage(tab1Image);
                productFinderLabels.addTabImage(tab2Image);
                productFinderLabels.addTabImage(tab3Image);
                productFinderLabels.addTabImage(tab4Image);

                ArrayList<ProductFinderOption> tab1Options = new ArrayList<>();
                tab1Options.add(tab1Option1);
                tab1Options.add(tab1Option2);
                tab1Options.add(tab1Option3);
                productFinderLabels.addProductFinderOptionList(tab1Options);

                ArrayList<ProductFinderOption> tab2Options = new ArrayList<>();
                tab2Options.add(tab2Option1);
                tab2Options.add(tab2Option2);
                tab2Options.add(tab2Option3);
                productFinderLabels.addProductFinderOptionList(tab2Options);

                ArrayList<ProductFinderOption> tab3Options = new ArrayList<>();
                tab3Options.add(tab3Option1);
                tab3Options.add(tab3Option2);
                tab3Options.add(tab3Option3);
                productFinderLabels.addProductFinderOptionList(tab3Options);

                ArrayList<ProductFinderOption> tab4Options = new ArrayList<>();
                tab4Options.add(tab4Option1);
                tab4Options.add(tab4Option2);
                tab4Options.add(tab4Option3);
                productFinderLabels.addProductFinderOptionList(tab4Options);

                return productFinderLabels;

            }

        } catch (QueryException e) {
            LOGGER.error("Error getting product finder labels", e);
        }

        return null;

    }


}
