package com.bloomreach.commercedxp.demo.pactronics.rest;


import com.bloomreach.commercedxp.demo.pactronics.rest.model.Container;
import com.bloomreach.commercedxp.demo.pactronics.rest.model.Page;
import org.apache.commons.lang3.StringUtils;
import org.example.rest.Constants;
import org.hippoecm.hst.configuration.hosting.MatchException;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.configuration.hosting.VirtualHost;
import org.hippoecm.hst.core.container.ContainerConstants;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.core.request.ResolvedMount;
import org.hippoecm.hst.core.request.ResolvedSiteMapItem;
import org.hippoecm.hst.core.request.ResolvedVirtualHost;

import org.hippoecm.hst.site.request.ResolvedMountImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.*;
import javax.servlet.http.HttpSession;

import static org.example.rest.Constants.PREVIEW_SUFFIX;

import static org.example.rest.Constants.WORKSPACE_NODE;
import static org.hippoecm.hst.site.HstServices.getComponentManager;

public class PageProvider {

    private static final Logger log = LoggerFactory.getLogger(PageProvider.class);
    private static final String CONTAINER_NODE_TYPE = "hst:containercomponent";
    private static final String COMPONENT_NODE_TYPE = "hst:component";
    private final String CSS_SELECTOR = "selector";
    private final String REPLACEMENT_MODE = "mode";
    private Session jcrSession;
    private HstRequestContext requestContext;

    public PageProvider(HstRequestContext requestContext) {
        this.requestContext = requestContext;
        jcrSession = getPersistableSession();
    }

    public void logoutSession() {
        jcrSession.logout();
    }

    private Session getPersistableSession() {
        Credentials credentials = this.requestContext.getContextCredentialsProvider().getWritableCredentials(this.requestContext);
        Repository repository = getComponentManager().getComponent(Repository.class.getName());
        try {
            return repository.login(credentials);
        } catch (RepositoryException e) {
            log.error("Unable to create JcrSession", e);
        }
        return null;
    }

    public Page getPageById(String uuid) {
        Node pageNode = getPageNodeByIdentifier(uuid);
        return getPage(pageNode);
    }

    public Page getPageUri(String mountAlias, String uri) {
        Mount mount = null;
        if (mountAlias == null || mountAlias.equals("/")) {
            mount = requestContext.getResolvedMount().getMount().getParent();
        } else {
            mount = requestContext.getMount(mountAlias);
        }

        if (mount != null) {
            ResolvedSiteMapItem currentSitemap = getSitemapItem(mount, uri);

            String location = currentSitemap.getResolvedMount().getMount().getHstSite().getConfigurationPath();
            String pageId = currentSitemap.getHstComponentConfiguration().getId();

            if (pageId.contains("pagenotfound")) {
                return null;
            }
            if (currentSitemap.getResolvedMount().getMount().getHstSite().hasPreviewConfiguration()) {
                location = String.format("%s%s", location, PREVIEW_SUFFIX);
            }

            String pageConfiguration = String.format("%s/%s/%s", location, WORKSPACE_NODE, pageId);
            Node pageNode = getPageNodeByPath(pageConfiguration);
            if(pageNode == null){
                pageNode = getPageNodeByPath(currentSitemap.getHstComponentConfiguration().getCanonicalStoredLocation());
            }
            if (pageNode != null) {
                return getPage(pageNode);
            }
        } else {
            log.debug("Enable to get Mount point for : URI" + uri + " - mount:" + mountAlias);
        }
        return null;
    }

    private Page getPage(Node pageNode) {

        try {
            Page page = new Page(pageNode.getIdentifier());
            fetchContainers(page, pageNode);
            return page;
        } catch (RepositoryException e) {
            log.error("Unable to load page configuration", e);
        }
        return null;
    }

    private void fetchContainers(Page page, Node pageNode) {
        try {
            NodeIterator ni = pageNode.getNodes();
            while (ni.hasNext()) {
                Node node = ni.nextNode();
                if (node.isNodeType(CONTAINER_NODE_TYPE)) {
                    if (node.hasProperty(CSS_SELECTOR)) {
                        String cssSelector = node.getProperty(CSS_SELECTOR).getString();
                        String replacementMode = StringUtils.EMPTY;
                        if (node.hasProperty(REPLACEMENT_MODE)) {
                            replacementMode = node.getProperty(REPLACEMENT_MODE).getString();
                        }
                        page.addContainer(new Container(node.getName(), cssSelector, replacementMode, Constants.CONTAINER_TYPE.DYNAMIC));
                    } else {
                        page.addContainer(new Container(node.getName(), StringUtils.EMPTY, StringUtils.EMPTY, Constants.CONTAINER_TYPE.HYBRID));
                    }
                }else if(node.isNodeType(COMPONENT_NODE_TYPE)){
                    page.addContainer(new Container(node.getName(), StringUtils.EMPTY, StringUtils.EMPTY,Constants.CONTAINER_TYPE.STATIC));
                }
            }
        } catch (Exception e) {
            log.error("Unable to read page configuration", e);
        }
    }

    public boolean updateContainers(String uuid, String containerName, String selector, String mode) {
        try {
            Node pageNode = getPageNodeByIdentifier(uuid);
            boolean result;
            if (pageNode.hasNode(containerName)) {
                result = updateContainerName(pageNode, containerName, selector, mode);
            } else {
                result = addContainer(pageNode, containerName, selector, mode);
            }
            if (result) {
                pageNode.getSession().save();
            }
            return result;
        } catch (RepositoryException e) {
            log.error("Unable to updating page containers {}", uuid, e);
            return false;
        }
    }

    private Node getPageNodeByIdentifier(String uuid) {
        try {
            return jcrSession.getNodeByIdentifier(uuid);
        } catch (RepositoryException e) {
            log.error("Unable to load page node with id {}", uuid, e);
        }
        return null;
    }

    private Node getPageNodeByPath(String path) {
        try {
            if (jcrSession.itemExists(path)) {
                return jcrSession.getNode(path);
            } else
            {log.debug("Item does not exist: " + path);}
        } catch (RepositoryException e) {
            log.error("Unable to load page node with path {}", path, e);
        }
        return null;
    }

    public boolean updateContainerName(Node pageNode, String containerName, String selector, String mode) throws RepositoryException {
        Node container = pageNode.getNode(containerName);
        if (container.hasProperty(CSS_SELECTOR)) {
            container.getProperty(CSS_SELECTOR).setValue(selector);
        } else {
            container.addMixin("hippostd:relaxed");
            container.setProperty(CSS_SELECTOR, selector);
        }
        if (container.hasProperty(REPLACEMENT_MODE)) {
            container.getProperty(REPLACEMENT_MODE).setValue(mode);
        } else {
            container.addMixin("hippostd:relaxed");
            container.setProperty(REPLACEMENT_MODE, mode);
        }
        return true;
    }

    public boolean addContainer(Node pageNode, String containerName, String selector, String mode) throws RepositoryException {
        Node container = pageNode.addNode(containerName, CONTAINER_NODE_TYPE);
        container.setProperty("hst:xtype", "HST.vBox");
        container.addMixin("hippostd:relaxed");
        container.setProperty(CSS_SELECTOR, selector);
        container.setProperty(REPLACEMENT_MODE, mode);
        return true;
    }

    public boolean deleteContainer(String uuid, String containerName) {
        Node pageNode = getPageNodeByIdentifier(uuid);
        try {
            if (pageNode.hasNode(containerName)) {
                pageNode.getNode(containerName).remove();
                pageNode.getSession().save();
            }
            return true;
        } catch (RepositoryException e) {
            log.error("Unable to delete container on page: {}", uuid, e);
        }
        return false;
    }

    private ResolvedSiteMapItem getSitemapItem(final Mount mount, String pageUrl) {


        HttpSession session = requestContext.getServletRequest().getSession();
        session.setAttribute(ContainerConstants.CMS_REQUEST_RENDERING_MOUNT_ID, mount.getIdentifier());

        MutableResolvedVirtualHost resolvedHostForLink = new MutableResolvedVirtualHost() {
            private ResolvedMount resolvedMountForLink = null;

            @Override
            public VirtualHost getVirtualHost() {
                return mount.getVirtualHost();
            }

            @Override
            public ResolvedMount matchMount(final String contextPath, final String requestPath) throws MatchException {
                return resolvedMountForLink;
            }

            @Override
            public ResolvedMount matchMount(String requestPath) throws MatchException {
                return resolvedMountForLink;
            }

            @Override
            public void setResolvedMount(ResolvedMount resMount) {
                this.resolvedMountForLink = resMount;
            }
        };

        ResolvedMount resMount = new ResolvedMountImpl(mount, resolvedHostForLink, mount.getMountPath(),
                mount.getVirtualHost().getVirtualHosts().getCmsPreviewPrefix(), requestContext.getResolvedMount().getPortNumber());
        resolvedHostForLink.setResolvedMount(resMount);


        ResolvedSiteMapItem rsmi = requestContext.getSiteMapMatcher().match(pageUrl, resMount);

        return rsmi;
    }

    interface MutableResolvedVirtualHost extends ResolvedVirtualHost {
        void setResolvedMount(ResolvedMount resMount);
    }


}
