package com.onehippo.cms7.targeting.demo.bootstrap;

import java.util.HashMap;
import java.util.Map;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

import javax.jcr.ItemNotFoundException;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;

import com.onehippo.cms7.targeting.model.goals.PageGoal;

import org.hippoecm.hst.configuration.HstNodeTypes;
import org.hippoecm.repository.util.NodeIterable;
import org.slf4j.Logger;

import static org.hippoecm.hst.configuration.HstNodeTypes.NODETYPE_HST_MOUNT;

public class PactronicsRepositoryBootstrap extends RepositoryBootstrap {

    public static final String DATAFLOW_NODE_PATH = "/targeting:targeting/targeting:dataflow";
    public static final String EXPERIMENTS_NODE_PATH = "/targeting:targeting/targeting:experiments";
    private static final String GOALS_NODE_PATH = "/targeting:targeting/targeting:goals";

    public static final String BOOTSTRAP_REF_TIME_PROP = "targeting:bootstrapReferenceTime";
    public static final String BOOTSTRAP_ENABLED_PROP = "targeting:bootstrapEnabled";
    public static final String EXPERIMENT_START_TIME_PROP = "startTime";
    public static final String PROCESSED_UNTIL_PROP = "processedUntil";
    public static final String MOUNT_ID_PROP = "mountId";
    public static final String MOUNT_PATH_PROP = "mountPath";

    public static final String BOOTSTRAP_METADATA_NODE_PATH = DATAFLOW_NODE_PATH;
    public static final String RUNNING_PROP = "running";
    public static final String GOAL_TYPE_PROP = "goalType";


    private final Logger log;
    private final Session session;
    private final String hstRootPath;
    private final String hstHostsPath;
    private Map<String, String> mountMap = null;

    public PactronicsRepositoryBootstrap(final Session session, final Logger log) {
        super(session, log);
        this.session = session;
        this.log = log;
        this.hstRootPath = findHstRootPath();
        this.hstHostsPath = this.hstRootPath + "/" + HstNodeTypes.NODENAME_HST_HOSTS;
    }

    public Session getSession() {
        return session;
    }

    public Logger getLogger() {
        return log;
    }

    public boolean isBootstrapEnabled() throws RepositoryException, BootstrapException {
        final String absPath = DATAFLOW_NODE_PATH + "/" + BOOTSTRAP_ENABLED_PROP;
        try {
            return session.getProperty(absPath).getBoolean();

        } catch (PathNotFoundException e) {
            final String message = "Missing required property " + absPath + ", should have been set by DataGenerator";
            throw new BootstrapException(message, e);
        }
    }

    public long decideDelta(long now) throws RepositoryException, BootstrapException {
        final String absPath = DATAFLOW_NODE_PATH + "/" + BOOTSTRAP_REF_TIME_PROP;
        try {
            final long refTime = session.getProperty(absPath).getLong();
            final long delta = now - refTime;
            log.info("Time delta is {} ms", delta);
            return delta;

        } catch (PathNotFoundException e) {
            final String message = "Cannot bootstrap without reference time property " + absPath;
            throw new BootstrapException(message, e);
        }
    }

    public Map<String, String> getMountIds() throws RepositoryException {
        if (mountMap == null)
        {
            int maxAttemps = 12;
            for (int i = 0; i < maxAttemps; ++i){
                try {
                    final Node rootNode = session.getNode(hstHostsPath);
                    mountMap = getMountIds(rootNode.getPath(), rootNode, new HashMap<>());
                    break;
                } catch (PathNotFoundException pnfe) {
                    if (i == (maxAttemps -1)) {
                        throw pnfe;
                    } else {
                        try {
                            log.error("PathNotFoundException when looking for path: " + hstHostsPath);
                            Thread.sleep(10000L);
                            log.error("Starting attemp " + i+2 + " of " + maxAttemps);
                        }catch (InterruptedException ie){
                            log.error("error sleeping thread", ie);
                        }
                    }
                }
            }
        }
        return mountMap;
    }

    private void printTree(final Node node) {
        try {
            log.error("Node: " + node.getPath());
            NodeIterator nodes = node.getNodes();

            while (nodes.hasNext()) {
                Node childNode = nodes.nextNode();
                log.error("Node: " + childNode.getPath());
                printTree(childNode);
            }
        } catch (RepositoryException re) {
            log.error("RepositoryException:", re);
        }
    }

    private Map<String, String> getMountIds(final String rootPath, Node node, HashMap<String, String> mountMap) throws RepositoryException {
        if (node.getPrimaryNodeType().isNodeType(NODETYPE_HST_MOUNT)) {
            String mountId = node.getIdentifier();
            String relPath = node.getPath().substring(rootPath.length() + 1);
            mountMap.put(relPath, mountId);
        }

        for (Node childNode : new NodeIterable(node.getNodes())) {
            getMountIds(rootPath, childNode, mountMap);
        }
        return mountMap;
    }

    public void clearBootstrapEnabled() throws RepositoryException {
        final String absPath = DATAFLOW_NODE_PATH + "/" + BOOTSTRAP_ENABLED_PROP;
        session.getProperty(absPath).setValue(false);
    }

    public void saveSession() throws RepositoryException {
        session.save();
    }

    public void fixGoalMountIds() throws RepositoryException {
        final Node goalsNode;
        try {
            goalsNode = session.getNode(GOALS_NODE_PATH);
        } catch (PathNotFoundException e) {
            // home early
            return;
        }

        fixGoalMountIds(goalsNode);
    }

    public String getHstRootPath() {
        return this.hstRootPath;
    }

    private void fixGoalMountIds(final Node node) throws RepositoryException {

        for (Node child : new NodeIterable(node.getNodes())) {
            fixGoalMountIds(child);
        }

        if (!node.getPrimaryNodeType().isNodeType("targeting:goal")) {
            return;
        }

        final String mountId;
        final String relPath;
        try {
            if (!node.getProperty(GOAL_TYPE_PROP).getString().equals(PageGoal.TYPE)) {
                return;
            }
            mountId = node.getProperty(MOUNT_ID_PROP).getString();
            relPath = node.getProperty(MOUNT_PATH_PROP).getString();
        } catch (PathNotFoundException e) {
            // not applicable for this node
            return;
        }

        try {
            session.getNodeByIdentifier(mountId);
            // if it exists we assume it's correct
            return;
        } catch (ItemNotFoundException e) {
            // we're about to fix that
        }

        final String absPath = hstHostsPath + "/" + relPath;
        final String correctId;
        try {
            Node mountNode = session.getNode(absPath);
            correctId = mountNode.getIdentifier();
        } catch (PathNotFoundException e) {
            // impossible to fix
            log.warn("Page goal {} cannot be linked to a mount: neither id '{}' nor path '{}' exist.",
                    node.getPath(), mountId, absPath);
            return;
        }

        node.setProperty(MOUNT_ID_PROP, correctId);
    }

    private String findHstRootPath() {
        return "/hst:pactronics";
    }

    private NodeIterator executeQuery(final String xpath) throws RepositoryException {
        final QueryManager queryManager = session.getWorkspace().getQueryManager();
        final Query query = queryManager.createQuery(xpath, Query.XPATH);
        return query.execute().getNodes();
    }
}
