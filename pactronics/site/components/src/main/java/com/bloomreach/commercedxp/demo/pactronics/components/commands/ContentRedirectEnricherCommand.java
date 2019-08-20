/**
 * Copyright 2018 BloomReach Inc. (https://www.bloomreach.com/)
 */
package com.bloomreach.commercedxp.demo.pactronics.components.commands;

import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.channels.StarterStoreChannelInfo;
import com.bloomreach.commercedxp.starterstore.commands.AbstractStarterStoreCommand;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreChannelUtils;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.HstQueryResult;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.query.filter.Filter;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoBeanIterator;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.linking.HstLink;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * This action will try to set a content bean based on specific information coming from the external service
 */
@Component
public class ContentRedirectEnricherCommand extends AbstractStarterStoreCommand {

    private final String CONTENT_PROPERTY_NAME = "document";

    @Override
    protected void doExecuteInternal(final CommerceExchangeState exchangeState) {
        if (isRenderPhase(exchangeState)) {
            processRenderPhase(exchangeState);
        }
    }

    private void processRenderPhase(final CommerceExchangeState exchangeState) {
        final HstRequestContext requestContext = RequestContextProvider.get();
        final HstRequest hstRequest = exchangeState.getContext().getRequest();

        //check if the document property is in the component parameter
        if (exchangeState.getContext().has(CONTENT_PROPERTY_NAME)) {
            //if the content param is there, then append the content bean to the request
            final String documentPath = (String) exchangeState.getContext().get(CONTENT_PROPERTY_NAME);
            final HippoBean root = requestContext.getSiteContentBaseBean();
            hstRequest.setModel(CONTENT_PROPERTY_NAME, root.getBean(documentPath));
        } else {
            HippoBean contentBaseBean = requestContext.getSiteContentBaseBean();
            //fetching the namespace from the project
            final StarterStoreChannelInfo channelInfo = StarterStoreChannelUtils.getCurrentChannelInfo();
            String projectNamespace = channelInfo.getProjectNamespace();
            Object extId = exchangeState.getContext().get(StarterStoreConstants.ATTRIBUTE_EXTERNAL_REFERENCE_ID);
            if (extId != null) {
                //in case of a detail component, search a document related containing the same id
                try {
                    //check if the id of the external item is included in one of the product document
                    HstQuery hstQuery =
                            requestContext.getQueryManager().createQuery(contentBaseBean, projectNamespace + ":productdecorator", projectNamespace + ":categorydecorator");
                    Filter idFilter = hstQuery.createFilter();
                    hstQuery.setFilter(idFilter);
                    idFilter.addContains(projectNamespace + ":id", hstRequest.getAttribute(StarterStoreConstants.ATTRIBUTE_EXTERNAL_REFERENCE_ID).toString());
                    Filter extDocFilter = hstQuery.createFilter();
                    extDocFilter.addContains(projectNamespace + ":relatedexdocids", (String) extId);
                    idFilter.addOrFilter(extDocFilter);
                    HstQueryResult result = hstQuery.execute();
                    HippoBeanIterator iterator = result.getHippoBeans();
                    while (iterator.hasNext()) {
                        HippoBean bean = iterator.nextHippoBean();
                        HstLink hstLink = requestContext.getHstLinkCreator().create(bean, requestContext);
                        if (!hstLink.isNotFound()) {
                            hstRequest.setModel(CONTENT_PROPERTY_NAME, bean);
                            String redirectUrl = hstLink.toUrlForm(requestContext, true);
                            if (!exchangeState.getContext().getRequest().getRequestURL().toString().equals(redirectUrl)) {
                                exchangeState.getContext().getResponse().sendRedirect(redirectUrl);
                            }
                            break;
                        }
                    }

                } catch (QueryException e) {
                    throw new HstComponentException(
                            "Exception occured during creation or execution of HstQuery.", e);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

}
