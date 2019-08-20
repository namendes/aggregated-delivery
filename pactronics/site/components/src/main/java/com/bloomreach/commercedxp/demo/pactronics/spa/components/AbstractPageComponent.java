package com.bloomreach.commercedxp.demo.pactronics.spa.components;

import com.bloomreach.commercedxp.demo.pactronics.spa.channel.WebsiteInfo;
import com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.linking.HstLinkCreator;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.onehippo.cms7.essentials.components.CommonComponent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import java.util.HashMap;
import java.util.Map;

import static com.bloomreach.commercedxp.demo.pactronics.constants.SiteConstants.COMPONENT_REFERENCE_PROPERTY;
import static com.bloomreach.commercedxp.demo.pactronics.utils.SiteUtil.getLinkForPath;

public class AbstractPageComponent extends CommonComponent {

    private static Logger LOGGER = LoggerFactory.getLogger(AbstractPageComponent.class);

    private static String ATTR_LOGO_URL = "logoUrl";
    private static String ATTR_LOGO_SMALL_URL = "logoSmallUrl";
    private static String ATTR_LOGO_ALTERNATIVE_URL = "logoAlternativeUrl";
    private static String ATTR_PAGE_TYPE = "pageType";
    private static String ATTR_PAGE_ID = "pageId";
    private static String ATTR_ROUTES = "routes";
    /*private static String ATTR_PRODUCT_ROUTES = "productRoutes";
    private static String ATTR_PRODUCT_TYPE = "productType";*/
    private static String ATTR_LOCALE = "locale";

    // These id's are a project convention and shouldn't be changed. New id's can be added for new static pages and used as ref id in sitemapitem configuration
    private static String[] STATIC_SITEMAP_IDS = {"cart"};


    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) {
        super.doBeforeRender(request, response);
        setWebsiteInfoOnRequest(request);
        setPageTypeOnRequest(request);
        setStaticRoutesOnRequest(request);
        setLocaleOnRequest(request);
    }

    private void setStaticRoutesOnRequest(final HstRequest request) {
        HstRequestContext requestContext = request.getRequestContext();
        HstLinkCreator linkCreator = requestContext.getHstLinkCreator();
        Map<String, String> routes = new HashMap();
        Mount mount = SiteUtil.getMount();
        for(String id : STATIC_SITEMAP_IDS) {
            routes.put(id, linkCreator.createByRefId(id, mount).toUrlForm(requestContext, false));
        }
        request.setModel(ATTR_ROUTES, routes);
    }

    private void setLocaleOnRequest(final HstRequest request) {
        Mount mount = SiteUtil.getMount();
        request.setModel(ATTR_LOCALE, mount.getLocale());
    }

    private void setPageTypeOnRequest(final HstRequest request) {
        HstRequestContext requestContext = request.getRequestContext();
        String page = requestContext.getResolvedSiteMapItem().getHstComponentConfiguration().getId();
        if(requestContext.getResolvedSiteMapItem().getHstSiteMapItem().getRefId() != null){
            String sitemapId = requestContext.getResolvedSiteMapItem().getHstSiteMapItem().getRefId();
            request.setModel(ATTR_PAGE_ID, sitemapId);
        }

        String id =requestContext.getResolvedMount().getMount().getHstSite().getComponentsConfiguration().getComponentConfiguration(page).getCanonicalIdentifier();

        try {
            Session session = SiteUtil.getSystemSession();
            Node n = session.getNodeByIdentifier(id);
            if(n != null && n.hasProperty(COMPONENT_REFERENCE_PROPERTY)){
                String pageReference = n.getProperty(COMPONENT_REFERENCE_PROPERTY).getString();
                String pageName = StringUtils.substringAfter(pageReference,"/");
                request.setModel(ATTR_PAGE_TYPE, pageName);
            }

        } catch (RepositoryException e) {
            LOGGER.debug("Unable to read page type for: %s", page);
        }
    }

    private void setWebsiteInfoOnRequest(final HstRequest request) {
        HstRequestContext requestContext = request.getRequestContext();
        Mount mount = SiteUtil.getMount();
        WebsiteInfo info = mount.getChannelInfo();

        request.setModel(ATTR_LOGO_URL, getLinkForPath(requestContext, info.getLogoPath()));
        request.setModel(ATTR_LOGO_SMALL_URL, getLinkForPath(requestContext, info.getLogoSmallPath()));
        request.setModel(ATTR_LOGO_ALTERNATIVE_URL, getLinkForPath(requestContext, info.getLogoAlternativePath()));

    }


}
