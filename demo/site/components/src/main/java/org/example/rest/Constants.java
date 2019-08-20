package org.example.rest;

public class Constants {

    public enum StageType {
        LIVE, PREVIEW
    }

    public static String LIVE = "myproject";
    public static String PREVIEW = "myproject-preview";
    public static String PREVIEW_SUFFIX = "-preview";
    public static String WORKSPACE_NODE = "hst:workspace";

    public enum CONTAINER_TYPE {
        STATIC,
        HYBRID,
        DYNAMIC,
    }

    private static final String CONTENT_DOC_PATH = "/content/documents/pages/pages";

    private static final String PROTOTYPE_PAGE_RELPATH = "/hst:prototypepages";
    private static final String WORKSPACE_PAGE_RELPATH = "/hst:workspace/hst:pages";
    private static final String WORKSPACE_SITEMAP_RELPATH = "/hst:workspace/hst:sitemap";
    private static final String WORKSPACE_CONTAINER_RELPATH = "/hst:workspace/hst:containers";

    private static final String PAGESETTINGS_DOC_TYPE = "pages:pageSettings";

    private static final String CONTENT_REL_PATH = "pages";

    public static final String API_UNLINKPAGES_RELPATH = "/api/pages/unlink";

    public static String getContentRelPath() {
        return CONTENT_REL_PATH;
    }

    public static String getPagesContentPath() {
        return CONTENT_DOC_PATH;
    }

    public static String getPageSettingsDocType() {
        return PAGESETTINGS_DOC_TYPE;
    }

    public static String getPrototypePagePath(StageType value) {
        return value == StageType.LIVE ?
                LIVE + PROTOTYPE_PAGE_RELPATH :
                PREVIEW + PROTOTYPE_PAGE_RELPATH;
    }

    public static String getWorkspacePagePath(StageType value) {
        return value == StageType.LIVE ?
                LIVE + WORKSPACE_PAGE_RELPATH :
                PREVIEW + WORKSPACE_PAGE_RELPATH;
    }

    public static String getWorkspaceSitemapPath(StageType value) {
        return value == StageType.LIVE ?
                LIVE + WORKSPACE_SITEMAP_RELPATH :
                PREVIEW + WORKSPACE_SITEMAP_RELPATH;
    }

    public static String getWorkspaceContainerPath(StageType value) {
        return value == StageType.LIVE ?
                LIVE + WORKSPACE_CONTAINER_RELPATH :
                PREVIEW + WORKSPACE_CONTAINER_RELPATH;
    }
}
