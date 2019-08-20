package com.bloomreach.commercedxp.demo.pactronics.components.commands.targeting.providers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface Provider {

    String getPrefix();

    List<String> getData(HttpServletRequest request);
}
