package com.onehippo.cms7.targeting.demo.bootstrap;
/*
 * Copyright 2015-2017 Hippo B.V. (http://www.onehippo.com)
 */
import java.io.IOException;
import java.util.Collection;
import java.util.Map;

import javax.jcr.Credentials;
import javax.jcr.LoginException;
import javax.jcr.Repository;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import com.onehippo.cms7.targeting.storage.DataStoreException;
import com.onehippo.cms7.targeting.storage.DataStoreService;

import org.hippoecm.hst.core.container.ComponentManager;
import org.hippoecm.hst.site.HstServices;
import org.onehippo.repository.security.JvmCredentials;
import org.slf4j.Logger;

import static org.slf4j.LoggerFactory.getLogger;

class PactronicsDataLoader extends DataLoader {
    public static final String DEFAULT_REPO_USER = "hippo-relevance";
    public static final String DATA_STORE_SERVICE_MODULE_NAME = "com.onehippo.cms7.targeting";
    public static final String DATA_STORE_SERVICE_BEAN_ID = "com.onehippo.cms7.targeting.DataStoreService";
    private static Logger log = getLogger(DataLoader.class);

    private Repository repository;
    private Credentials credentials = JvmCredentials.getCredentials(DEFAULT_REPO_USER);
    private boolean doBootstrap = true;
    private boolean doTruncate = false;

    private Session session;
    private boolean doLogout = false;
    private DataStoreService dataStoreService;

    PactronicsDataLoader() throws RepositoryException {
        super();
    }

    public void setRepository(final Repository repository) {
        this.repository = repository;
    }

    public void setCredentials(final Credentials credentials) {
        this.credentials = credentials;
    }

    public void setSession(final Session session) {
        this.session = session;
    }

    public void setDoBootstrap(final boolean doBootstrap) {
        this.doBootstrap = doBootstrap;
    }

    public void setDoTruncate(final boolean doTruncate) {
        this.doTruncate = doTruncate;
    }

    /**
     * Run bootstrap() in the background
     */
    public void trigger() {
        log.debug("trigger() called");
        Thread bootstrapThread = new Thread(this::bootstrap, "bootstrapTargeting");
        bootstrapThread.start();
    }

    /**
     * Attempt to bootstrap, unless doBootstrap is set to false.
     */
    private void bootstrap() {
        try {
            log.info("Trying to bootstrap");

            session = connectRepository();
            dataStoreService = connectDataStoreService();
            bootstrap(session);
        } catch (Exception e) {
            log.error("Exception while bootstrapping relevance data", e);
        } finally {
            if (doLogout) {
                session.logout();
            }
        }
    }

    private Session connectRepository() throws LoginException, InterruptedException, BootstrapException {
        if (session != null) {
            return session;
        }

        if (repository == null || credentials == null) {
            throw new BootstrapException("Either session or repo+credentials should be set");
        }
        log.info("Connecting to repository");
        int attempts = 0;
        while (true) {
            attempts++;
            LoginException exceptionToThrow = null;
            try {
                session = repository.login(credentials);
                doLogout = true;
                if (attempts > 1) {
                    log.info("Repository is available now");
                }
                return session;
            } catch (LoginException e) {
                // wrong credentials?
                exceptionToThrow = e;
            } catch (RepositoryException e) {
                if (attempts == 1) {
                    log.info("Repository not available, will retry: {}", e.toString());
                } else if (attempts % 60 == 0) {
                    log.error("Repository still not available", e);
                }
                Thread.sleep(1000);
                continue;
            }
            if (exceptionToThrow != null) {
                throw exceptionToThrow;
            }
        }
    }

    private DataStoreService connectDataStoreService() {
        boolean waiting = false;
        while (!HstServices.isAvailable()) {
            if (!waiting) {
                log.info("Waiting for HstServices to come up");
                waiting = true;
            }
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        if (waiting) {
            log.info("HstServices now available");
        }
        final ComponentManager componentManager = HstServices.getComponentManager();
        return componentManager.getComponent(DATA_STORE_SERVICE_BEAN_ID, DATA_STORE_SERVICE_MODULE_NAME);
    }

    private void bootstrap(final Session session) throws RepositoryException, BootstrapException, IOException,
            DataStoreException, InterruptedException {
        long now = System.currentTimeMillis();

        final PactronicsRepositoryBootstrap repoBootstrap = new PactronicsRepositoryBootstrap(session, log);
        if (!repoBootstrap.isBootstrapEnabled()) {
            log.info("Bootstrap has already been done");
            return;
        }

        repoBootstrap.clearBootstrapEnabled();
        long delta = repoBootstrap.decideDelta(now);
        if (delta < 0) {
            throw new BootstrapException("Reference time is in the future, bootstrap suppressed");
        }

        // ensure data stores work before making any changes
        final TargetingDataLoader targetingDataLoader = new TargetingDataLoader(delta, doTruncate, dataStoreService);
        targetingDataLoader.connect();

        final DataflowAdjuster dataflowAdjuster = new DataflowAdjuster(repoBootstrap);
        final Collection<String> serviceNodesToRestart = dataflowAdjuster.stopServices();
        repoBootstrap.saveSession();
        if (!serviceNodesToRestart.isEmpty()) {
            log.info("Sleeping to allow services to stop");
            Thread.sleep(5_000);
        }

        try {
            dataflowAdjuster.adjustJobTimestamps(now);

            final ExperimentsAdjuster experimentsAdjuster = new ExperimentsAdjuster(repoBootstrap);
            experimentsAdjuster.adjustTimestamps(delta);
            experimentsAdjuster.lockExperimentContainers(now);

            final Map<String, String> mountIds = repoBootstrap.getMountIds();
            repoBootstrap.fixGoalMountIds();

            repoBootstrap.saveSession();

            if (doBootstrap) {
                targetingDataLoader.loadData(mountIds);
            } else {
                log.info("Bootstrap suppressed");
            }
        } finally {
            dataflowAdjuster.startServices(serviceNodesToRestart);
            repoBootstrap.saveSession();
        }
    }
}
