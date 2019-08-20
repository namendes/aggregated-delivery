package com.bloomreach.commercedxp.demo.pactronics.beans;

import java.util.ResourceBundle;

import javax.jcr.RepositoryException;

import org.apache.commons.lang3.StringUtils;
import org.apache.jackrabbit.commons.JcrUtils;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.utils.CommerceConnectorUtils;

@Node(jcrType="pactronics:basedocument")
public class BaseDocument extends HippoDocument {

    private static Logger log = LoggerFactory.getLogger(BaseDocument.class);

    /**
     * Return the ResourceBundle associated by <code><code>starterstore:connectorid</code> property value in a
     * <code>starterstore:connectorsettable</code> mixin type node if existing. Otherwise, return null.
     * @return the ResourceBundle associated by <code><code>starterstore:connectorid</code> property value in a
     * <code>starterstore:connectorsettable</code> mixin type node if existing. Otherwise, null
     */
    public ResourceBundle getMappingResourceBundle() {
        try {
            if (getNode().isNodeType(StarterStoreConstants.NT_MIXIN_CONNECTOR_SETTABLE)) {
                final String connectorId = JcrUtils.getStringProperty(getNode(), StarterStoreConstants.MIXIN_CONNECTOR_ID, null);

                if (StringUtils.isNotBlank(connectorId)) {
                    return CommerceConnectorUtils.getMappingResourceBundle(connectorId);
                }
            }
        } catch (RepositoryException e) {
            if (log.isDebugEnabled()) {
                log.warn("Cannot find the related connector's bundle.", e);
            } else {
                log.warn("Cannot find the related connector's bundle. {}", e.toString());
            }
        }

        return null;
    }

}
