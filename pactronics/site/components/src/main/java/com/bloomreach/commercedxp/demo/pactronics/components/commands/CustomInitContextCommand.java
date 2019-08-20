/**
 * Copyright 2018 BloomReach Inc. (https://www.bloomreach.com/)
 */
package com.bloomreach.commercedxp.demo.pactronics.components.commands;

import java.util.ResourceBundle;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.hippoecm.hst.component.support.forms.FormField;
import org.hippoecm.hst.component.support.forms.FormMap;
import org.hippoecm.hst.component.support.forms.FormUtils;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstComponent;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.utils.ParameterUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.channels.StarterStoreChannelInfo;
import com.bloomreach.commercedxp.starterstore.commands.AbstractStarterStoreCommand;
import com.bloomreach.commercedxp.starterstore.commands.InitContextCommand;
import com.bloomreach.commercedxp.starterstore.components.info.QueryComponentInfo;
import com.bloomreach.commercedxp.starterstore.security.StoreUser;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.CommerceConnectorUtils;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreChannelUtils;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreHstUtils;


/**
 * This action helps to build the request for the external service and tries to fill all the placeholders defined in the dxp configuration
 */
@Component
public class CustomInitContextCommand extends InitContextCommand {

    private static Logger log = LoggerFactory.getLogger(CustomInitContextCommand.class);

    @Override
    protected void doExecuteInternal(final CommerceExchangeState exchangeState) {
        if (isRenderPhase(exchangeState) || isResourcePhase(exchangeState)) {
            processRenderPhase(exchangeState);
        }
    }

    private void addDefaultParams(final CommerceExchangeState exchangeState) {

        HstRequest hstRequest = exchangeState.getContext().getRequest();

        String pageSize = (String) hstRequest.getAttribute(StarterStoreConstants.ATTRIBUTE_PAGE_SIZE);
        String page = (String) hstRequest.getAttribute(StarterStoreConstants.ATTRIBUTE_CURRENT_PAGE);

        if (pageSize != null && page != null) {
            int currentPageSize = NumberUtils.toInt(pageSize, 10);
            int currentPage = NumberUtils.toInt(page, 0);
            hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_OFFSET, String.valueOf((currentPage - 1) * currentPageSize));
        }

        HippoBean contentBean = hstRequest.getRequestContext().getContentBean();
        if (contentBean == null) {
            //in case the request content bean is empty, then check if there is a component param with a reference to a document
            Object path = hstRequest.getAttribute("document");
            if (path instanceof String) {
                HippoBean root = hstRequest.getRequestContext().getSiteContentBaseBean();
                contentBean = root.getBean((String) path, HippoBean.class);
            }
        }
        if (contentBean != null) {
            //in case the request contains a bean, then check if the document contains references to external documents
            final StarterStoreChannelInfo channelInfo = StarterStoreChannelUtils.getCurrentChannelInfo();
            final String relatedExtResId = StarterStoreHstUtils.getFirstRelatedExternalResourceIds(contentBean,
                    channelInfo.getProjectNamespace());
            if (relatedExtResId != null) {
                exchangeState.getContext().getRequest()
                        .setAttribute(StarterStoreConstants.ATTRIBUTE_EXTERNAL_REFERENCE_ID, relatedExtResId);
            }
            //moreover, set the connector id in the hst request in case the content bean defines one
            final String connectorId = StarterStoreHstUtils.findCommerceConnectorIdFromCurrentContentBean();
            if (StringUtils.isNotBlank(connectorId) &&
                    !StringUtils.startsWithIgnoreCase(connectorId, StarterStoreConstants.BLOOMREACH_API_CONNECTOR_ID)) {
                hstRequest.setAttribute(StarterStoreConstants.PARAM_COMMERCE_CONNECTOR_ID, connectorId);
            }
        }
    }

    private void processRenderPhase(final CommerceExchangeState exchangeState) {
        final HstRequestContext requestContext = RequestContextProvider.get();
        final HstRequest hstRequest = exchangeState.getContext().getRequest();
        final HstResponse hstResponse = exchangeState.getContext().getResponse();

        setUpQueryParameterInfo(exchangeState, requestContext, hstRequest);

        String pageSize = hstRequest.getParameter(StarterStoreConstants.PARAM_PAGE_SIZE);
        if (StringUtils.isNotBlank(pageSize)) {
            hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_PAGE_SIZE, pageSize);
        }

        String currentPage = hstRequest.getParameter(StarterStoreConstants.PARAM_CURRENT_PAGE);
        if (StringUtils.isNotBlank(currentPage)) {
            hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_CURRENT_PAGE, currentPage);
        }

        String[] facetQueries = requestContext.getServletRequest().getParameterValues(StarterStoreConstants.PARAM_FACET_QUERY);
        if (facetQueries != null && facetQueries.length > 0) {
            StringBuilder stringBuilder = new StringBuilder(200).append(facetQueries[0]);
            //in case of multiple values in the url, the key value pair must be repeated in the external request.
            //since the key is part of the component service base url, then it need to be retrieved from the resource bundle
            ResourceBundle mapping = CommerceConnectorUtils
                    .getMappingResourceBundle(exchangeState.getConnectorExchangeState().getConnector());
            if (mapping == null) {
                //fallback to bloomreach mapping bundle in case of the default connector doesn't include it
                mapping = CommerceConnectorUtils.
                        getMappingResourceBundle(StarterStoreConstants.BLOOMREACH_API_CONNECTOR_ID);
            }
            final String facetAttributeName = mapping.getString("facet.attribute.name");
            for (int i = 1; i < facetQueries.length; i++) {
                stringBuilder.append("&").append(facetAttributeName).append("=").append(facetQueries[i]);
            }
            hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_FACET_QUERY, stringBuilder.toString());
        }

        final StoreUser storeUser = getStoreUserInSession(hstRequest, hstResponse);
        if (storeUser != null) {
            hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_STORE_USER, storeUser);
        }

        //in case of messages left by previous commands, fetch the commerce response message
        final FormMap formMap = new FormMap();
        FormUtils.populate(hstRequest, formMap);
        final FormField responseStatusField = formMap.getField(StarterStoreConstants.MESSAGE_COMMERCE_RESPONSE_STATUS);
        if (responseStatusField != null) {
            try {
                final String responseStatus = StarterStoreHstUtils.fromJsonString(responseStatusField.getValue(), String.class);
                hstRequest.setAttribute(StarterStoreConstants.MESSAGE_COMMERCE_RESPONSE_STATUS, responseStatus);
            } catch (Exception e) {
                log.warn("Failed to read responseStatus from form fields.", e);
            }
        }

        exchangeState.getContext().keySet().forEach(varName -> {
            if (hstRequest.getAttribute((String) varName) == null) {
                hstRequest.setAttribute((String) varName, exchangeState.getContext().get(varName));
            }
        });

        hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_PIXEL_DATA, StarterStoreHstUtils.getPixelData(exchangeState));

        addDefaultParams(exchangeState);
    }

    private void setUpQueryParameterInfo(final CommerceExchangeState exchangeState, final HstRequestContext requestContext, final HstRequest hstRequest) {
        String query = "";
        String showFacets = "false";
        String pageSize = "10";
        String showPagination = "false";
        String widgetId = "";
        Class componentParameterInfoClazz = StarterStoreHstUtils.getComponentParameterInfoClass(exchangeState);
        //in case the query is defined in the component parameters, try to use its value
        if (componentParameterInfoClazz != null && QueryComponentInfo.class.isAssignableFrom(componentParameterInfoClazz)) {
            HstComponent hstComponent = (HstComponent) exchangeState.getContext().get(HstComponent.class.getName());
            QueryComponentInfo queryComponentInfo = ParameterUtils.getParametersInfo(hstComponent, hstComponent.getComponentConfiguration(), hstRequest);
            query = queryComponentInfo.getQuery();
            showFacets = String.valueOf(queryComponentInfo.getShowFacets());
            pageSize = String.valueOf(queryComponentInfo.getPageSize());
            showPagination = String.valueOf(queryComponentInfo.getShowPagination());
            widgetId = queryComponentInfo.getWidgetId();
        }
        if (StringUtils.isBlank(query)) {
            //in case the component doesn't specify a query param, have a look at the URL  params
            query = requestContext.getServletRequest().getParameter(StarterStoreConstants.PARAM_QUERY);
            if (StringUtils.isBlank(query)) {
                //in case the URL params don't contain the query, then check if the parent component has defined a query
                query = (String) requestContext.getAttribute(StarterStoreConstants.ATTRIBUTE_QUERY);
            }
        }
        hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_QUERY, query);
        hstRequest.setAttribute("showFacets", showFacets);
        hstRequest.setAttribute(StarterStoreConstants.ATTRIBUTE_PAGE_SIZE, pageSize);
        hstRequest.setAttribute("showPagination", showPagination);
        hstRequest.setAttribute(StarterStoreConstants.PARAM_WIDGET_ID, widgetId);
    }

}
