<%@ page language="java" %>

<%@ page import="java.util.*" %>
<%@ page import="org.onehippo.cms7.services.*" %>
<%@ page import="org.onehippo.cms7.crisp.hst.module.*" %>
<%@ page import="org.onehippo.cms7.crisp.api.broker.*" %>
<%@ page import="org.onehippo.cms7.crisp.api.resource.*" %>
<%@ page import="org.onehippo.cms7.crisp.api.exchange.*" %>
<%@ page import="com.bloomreach.commercedxp.starterstore.connectors.*" %>
<%@ page import="com.bloomreach.commercedxp.starterstore.connectors.*" %>

<html>
  <body>
    <h1>Test</h1>
    <hr/>
    <pre>
      <%
        try {
          final CommerceConnectorSetProvider provider = HippoServiceRegistry.getService(CommerceConnectorSetProvider.class);
          final CommerceConnector connector = provider.getCommerceConnectorSet().getConnectorByModuleName("com.bloomreach.commercedxp.container.connector.elasticpath");
          final CommerceConnectorComponent component = connector.getComponentById("productSearch");

          final ResourceServiceBroker broker = CrispHstServices.getDefaultResourceServiceBroker();
          final Map<String, Object> pathVars = new HashMap<>();

          // TODO: serviceBaseUrl should come from 'DecoratingCommerceConnectorComponent' instance.
          // NOTE: For "FollowLocation", see https://developers.elasticpath.com/commerce/7.4.1/Cortex-API-Front-End-Development/API-Reference/Follow-Location
          String serviceBaseUrl = "/searches/LFC_STORE/keywords/form?FollowLocation=true&zoom=element,element:appliedpromotions,element:availability,element:code,element:definition,element:price";

          final Map<String, List<String>> requestHeaders = new HashMap<>();
          requestHeaders.put("Accept", Arrays.asList("application/json"));
          requestHeaders.put("Content-Type", Arrays.asList("application/json"));

          final ExchangeHint exchangeHint = ExchangeHintBuilder.create().methodName(component.getMethodType())
                  .requestHeaders(requestHeaders).requestBody(component.getRequestBody())
                  .build();

          final Resource resource = broker.findResources(connector.getResourceSpace(), serviceBaseUrl, pathVars, exchangeHint);

          out.println("resource: " + resource);
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
    </pre>
  </body>
</html>
