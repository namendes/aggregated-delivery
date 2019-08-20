package com.bloomreach.commercedxp.demo.pactronics.components.commands;

import com.bloomreach.commercedxp.demo.pactronics.components.ProductDecoratorInfo;
import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.channels.StarterStoreChannelInfo;
import com.bloomreach.commercedxp.starterstore.commands.ContentDecoratorCommand;
import com.bloomreach.commercedxp.starterstore.connectors.CommerceConnector;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreChannelUtils;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreHstUtils;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.component.HstComponent;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.utils.ParameterUtils;
import org.hippoecm.repository.util.JcrUtils;
import org.onehippo.cms7.crisp.api.resource.Resource;
import org.onehippo.cms7.essentials.components.info.EssentialsCarouselComponentInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.jcr.RepositoryException;
import java.util.*;

@Component
public class ContentSingleDecoratorCommand extends ContentDecoratorCommand {

    private static final Logger log = LoggerFactory.getLogger(ContentDecoratorCommand.class);


        protected Resource enrichContent(final CommerceExchangeState exchangeState, final HippoBean hippoBean) {

        //fetching the namespace from the project
        final StarterStoreChannelInfo channelInfo = StarterStoreChannelUtils.getCurrentChannelInfo();
        String projectNamespace = channelInfo.getProjectNamespace();
        //fetching the connector from the content bean
        String connectorId = StarterStoreHstUtils.findCommerceConnectorIdFromBean(projectNamespace, hippoBean);
        CommerceConnector commerceConnector = StarterStoreChannelUtils.getCurrentChannelConnectorSet(true).getConnectorById(connectorId);
        //resetting the commerce connector from the current exchange
        resetCommerceConnectorComponent(exchangeState, commerceConnector, (String) exchangeState.getContext().get(StarterStoreConstants.PARAM_COMMERCE_CONNECTOR_COMPONENT_ID));
        //fetching the relatedexdocids from the document
        try {
            String[] relatedexdocids = JcrUtils.getMultipleStringProperty(hippoBean.getNode(), projectNamespace + ":relatedexdocids", new String[0]);
            if (relatedexdocids.length > 0) {
                exchangeState.getContext().set(StarterStoreConstants.ATTRIBUTE_EXTERNAL_REFERENCE_ID, relatedexdocids[0]);
                //in case the relatedexdocids has been defined for the current document, then fetch the external data
                process(exchangeState, StarterStoreConstants.ATTRIBUTE_COMMERCE_RESPONSE);
            }
            //after the processing
            return (Resource) exchangeState.getContext().get(StarterStoreConstants.ATTRIBUTE_COMMERCE_RESPONSE);
        } catch (RepositoryException exception) {
            log.error("Something went wrong while extracting data using the external document picker field", exception);
        }
        return null;
    }

    private void fetchContentDecoratorDocuments(final CommerceExchangeState exchangeState) {
        HstRequest hstRequest = exchangeState.getContext().getRequest();
        HippoBean contentBaseBean = hstRequest.getRequestContext().getSiteContentBaseBean();

        //in case the component contains a list of document pickers, add the document list
        HippoBean document = null;
        Map<String, Resource> extDocuments = new HashMap();

        final String documentPath = (String) exchangeState.getContext().get("document");
        if (StringUtils.isNotBlank(documentPath)) {
            document = contentBaseBean.getBean(documentPath);
            //fetching the external document based on the external reference id (defined in the hippo bean)
            Resource extDocument = enrichContent(exchangeState, document);
            if (extDocument != null) {
                extDocuments.put(document.getIdentifier(), extDocument);
            }
        }

        hstRequest.setModel("document", document);
        hstRequest.setAttribute("extDocuments", extDocuments);
    }

    @Override
    protected void doExecuteInternal(CommerceExchangeState exchangeState) {
        super.doExecuteInternal(exchangeState);

        final HstRequest hstRequest = exchangeState.getContext().getRequest();
        //checking if the parameters info class name has been assigned to the context
        Class clazz = StarterStoreHstUtils.getComponentParameterInfoClass(exchangeState);
        //in case the current component is a carousel, then process all the decorator documents
        if (clazz != null && ProductDecoratorInfo.class.isAssignableFrom(clazz)) {
            //fetching the content decorator documents defined in the component
            fetchContentDecoratorDocuments(exchangeState);
            //fetching parameters info from the original hst component initiating the commands
            HstComponent hstComponent = (HstComponent) exchangeState.getContext().get(HstComponent.class.getName());
            EssentialsCarouselComponentInfo componentInfo =
                    ParameterUtils.getParametersInfo(hstComponent, hstComponent.getComponentConfiguration(), hstRequest);
            hstRequest.setAttribute("cparam", componentInfo);
            hstRequest.setAttribute("componentId", UUID.randomUUID().toString());
        }
    }
}
