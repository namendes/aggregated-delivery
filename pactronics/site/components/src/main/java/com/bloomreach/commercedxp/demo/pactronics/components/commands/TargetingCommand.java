package com.bloomreach.commercedxp.demo.pactronics.components.commands;

import java.net.URLEncoder;
import java.util.Map;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.chain.Command;
import org.apache.commons.chain.Context;
import org.hippoecm.hst.site.HstServices;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.bloomreach.commercedxp.demo.pactronics.components.commands.targeting.providers.Provider;
import com.bloomreach.commercedxp.starterstore.state.CommerceExchangeState;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Component
public class TargetingCommand implements Command {

    private static final Logger log = LoggerFactory.getLogger(TargetingCommand.class);
    private static final String COOKIE_NAME = "commerce_targeting";

    @Override
    public boolean execute(final Context context) throws Exception {

        final CommerceExchangeState exchangeState =
                (CommerceExchangeState) context.get(CommerceExchangeState.class.getName());
        HttpServletRequest request = exchangeState.getContext().getRequest();
        HttpServletResponse response = exchangeState.getContext().getResponse();


        Map<String, Provider> providers = HstServices.getComponentManager().getComponentsOfType(Provider.class);
        JSONObject cookieValue = new JSONObject();
        for (Provider provider: providers.values()) {
            JSONArray array = new JSONArray();
            for (String name: provider.getData(request)) {
                array.add(name);
            }
            cookieValue.put(provider.getPrefix(), array);
        }

        Cookie cookie = new Cookie(COOKIE_NAME, URLEncoder.encode(cookieValue.toString(), "UTF-8"));
        response.addCookie(cookie);

        return false;
    }



}
