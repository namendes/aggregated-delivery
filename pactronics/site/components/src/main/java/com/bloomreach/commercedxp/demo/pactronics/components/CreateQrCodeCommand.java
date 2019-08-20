package com.bloomreach.commercedxp.demo.pactronics.components;

import com.bloomreach.commercedxp.demo.pactronics.utils.ConfigurationUtil;
import com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil;
import com.bloomreach.commercedxp.starterstore.StarterStoreConstants;
import com.bloomreach.commercedxp.starterstore.commands.AbstractStarterStoreCommand;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;
import com.bloomreach.commercedxp.starterstore.utils.StarterStoreHstUtils;
import org.hippoecm.hst.core.component.HstRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.jcr.RepositoryException;
import javax.servlet.http.Cookie;

@Component
public class CreateQrCodeCommand extends AbstractStarterStoreCommand {

    private static Logger LOGGER = LoggerFactory.getLogger(CreateQrCodeCommand.class);

    private final String CHECKOUT_BUNDLE_NAME = "instore-checkout-configuration";
    private final String ATTRIBUTE_QRCODE = "qrcode";

    @Override
    protected void doExecuteInternal(final CommerceExchangeState exchangeState) {

        if(isRenderPhase(exchangeState)) {
            final HstRequest hstRequest = exchangeState.getContext().getRequest();

            Cookie cookie = StarterStoreHstUtils.getCookie(exchangeState, StarterStoreConstants.CART_NAME);
            String cartId = cookie.getValue();

            try {
                ConfigurationUtil config = new ConfigurationUtil(hstRequest.getRequestContext().getSession(), CHECKOUT_BUNDLE_NAME);
                hstRequest.setAttribute(ATTRIBUTE_QRCODE, SiteUtil.getQRCodeImage(cartId, config.getQRCodeWidth(), config.getQRCodeWidth()));

            } catch (RepositoryException ex) {
                LOGGER.error("Error obtaining session", ex);
            }
        }
    }
}
