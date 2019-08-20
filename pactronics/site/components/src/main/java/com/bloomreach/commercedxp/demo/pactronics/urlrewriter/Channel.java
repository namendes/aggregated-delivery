package com.bloomreach.commercedxp.demo.pactronics.urlrewriter;

public class Channel {

    public Channel(String channelPath, String serverUrl, String rootPath){
        this.channelPath = channelPath;
        this.serverUrl = serverUrl;
        this.rootPath = rootPath;

    }
    public String getChannelPath() {
        return channelPath;
    }

    public void setChannelPath(String channelPath) {
        this.channelPath = channelPath;
    }

    public String getServerUrl() {
        return serverUrl;
    }

    public void setServerUrl(String serverUrl) {
        this.serverUrl = serverUrl;
    }

    public String getRootPath() {
        return rootPath;
    }

    public void setRootPath(String rootPath) {
        rootPath = rootPath;
    }

    private String channelPath;
    private String serverUrl;
    private String rootPath;
}
