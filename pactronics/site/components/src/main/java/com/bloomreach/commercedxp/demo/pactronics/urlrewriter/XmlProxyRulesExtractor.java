/**
 * Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.bloomreach.commercedxp.demo.pactronics.urlrewriter;

import org.apache.commons.lang3.StringUtils;
import org.onehippo.forge.rewriting.repo.AbstractRulesExtractor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.print.DocFlavor;
import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.List;

/**
 * @version $Id$
 */
public class XmlProxyRulesExtractor extends AbstractRulesExtractor {

    private static final String CHANNELCONFIG_NODE = "siteproxy:channels";
    private static final String CHANNEL_PATH_PROPERTY = "siteproxy:contextPath";
    private static final String SERVER_URL_PROPERTY = "siteproxy:serverUrl";
    private static final String ROOT_PATH_PROPERTY = "siteproxy:rootPath";
    private static Logger log = LoggerFactory.getLogger(XmlProxyRulesExtractor.class);

    public static final String PRIMARY_TYPE_SPAXMLRULE = "siteproxy:rule";
    public static final String XML_RULE_PROPERTY = "siteproxy:xmlRule";
    private static final String PLACEHOLDER_CONTEXT_PATH = "##contextPath##";
    private static final String PLACEHOLDER_ROOT_CONTEXT_PATH = "##rootContextPath##";
    private static final String PLACEHOLDER_URL = "##url##";

    @Override
    public String extract(Node node, ServletContext context) throws RepositoryException {
        return null;
    }

    @Override
    public List<String> extractMultiple(final Node ruleNode, final ServletContext context) throws RepositoryException {

        if (!ruleNode.isNodeType(PRIMARY_TYPE_SPAXMLRULE)) {
            return null;
        }
        String baseRule = extractProperty(ruleNode, XML_RULE_PROPERTY, false);

        List<Channel> channels = parseChannels(ruleNode);

        List<String> rules = new ArrayList<>();
        for (Channel channel : channels) {
            String rule = baseRule.replace(PLACEHOLDER_CONTEXT_PATH, channel.getChannelPath());
            rule = rule.replace(PLACEHOLDER_URL, channel.getServerUrl());

            if(StringUtils.isNotEmpty(channel.getRootPath())){
                if(channel.getRootPath().startsWith("/")) {
                    rule = rule.replace(PLACEHOLDER_ROOT_CONTEXT_PATH,  channel.getRootPath());
                }else{
                    rule = rule.replace(PLACEHOLDER_ROOT_CONTEXT_PATH, "/" + channel.getRootPath());
                }
            }else{
                rule = rule.replace(PLACEHOLDER_ROOT_CONTEXT_PATH,StringUtils.EMPTY);
            }

            if (validateRule(rule, context)) {
                rules.add(rule);
            } else {
                log.info("invalid rule");
            }
        }

        return rules;
    }

    private List<Channel> parseChannels(final Node ruleNode) {
        List<Channel> channels = new ArrayList<>();
        try {
            NodeIterator channelsIt = ruleNode.getNodes(CHANNELCONFIG_NODE);
            while (channelsIt.hasNext()) {
                Node channelNode = channelsIt.nextNode();
                channels.add(extractChannelConfiguration(channelNode));
            }
        } catch (Exception e) {
            log.error("Error parsing channel configuration", e);
        }
        return channels;
    }

    private Channel extractChannelConfiguration(final Node serverNode) {
        String serverUrl = extractProperty(serverNode, SERVER_URL_PROPERTY);
        String channelPath = extractProperty(serverNode, CHANNEL_PATH_PROPERTY);
        String rootPath = extractProperty(serverNode, ROOT_PATH_PROPERTY);


        return new Channel(channelPath, serverUrl, rootPath);
    }
}
