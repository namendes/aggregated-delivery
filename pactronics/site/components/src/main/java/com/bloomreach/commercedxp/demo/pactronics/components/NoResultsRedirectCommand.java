package com.bloomreach.commercedxp.demo.pactronics.components;


import java.io.IOException;

import org.hippoecm.hst.configuration.sitemap.HstSiteMap;
import org.hippoecm.hst.configuration.sitemap.HstSiteMapItem;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.onehippo.cms7.essentials.components.paging.Pageable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.bloomreach.commercedxp.starterstore.commands.AbstractStarterStoreCommand;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;

@Component
public class NoResultsRedirectCommand extends AbstractStarterStoreCommand {

    private static Logger log = LoggerFactory.getLogger(NoResultsRedirectCommand.class);


    @Override
    protected void doExecuteInternal(final CommerceExchangeState exchangeState) {
        if (isRenderPhase(exchangeState)) {
            processRenderPhase(exchangeState);
        }
    }

    private void processRenderPhase(final CommerceExchangeState exchangeState) {
        final HstRequest hstRequest = exchangeState.getContext().getRequest();
        final HstResponse hstResponse = exchangeState.getContext().getResponse();

        Pageable searchResults = (Pageable) hstRequest.getAttribute("pageable");

        if (searchResults.getTotal() == 0) {
            String resultsNotFoundSiteMapRefId = "no-results-page";
            String resultsNotFoundUrl = getResultsNotFoundUrl(resultsNotFoundSiteMapRefId);
            try {
                hstResponse.forward(resultsNotFoundUrl);
            } catch (IOException e) {
                log.debug("No sitemap item matching \"no-results-page\".", e);
            }
        }
    }

    private String getResultsNotFoundUrl(final String refId) {
        final HstRequestContext requestContext = RequestContextProvider.get();
        final ResolvedSiteMapItem resolvedSiteMapItem = requestContext.getResolvedSiteMapItem();
        final HstSiteMap siteMap = resolvedSiteMapItem.getHstSiteMapItem().getHstSiteMap();
        final HstSiteMapItem siteMapItem = siteMap.getSiteMapItemByRefId(refId);
        if (siteMapItem != null) {
            return "/" + siteMapItem.getValue();
        } else {
            return "/no-results-found";
        }
    }
}
