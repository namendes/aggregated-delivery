package org.example.rest;

import org.example.rest.model.Page;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.jaxrs.services.AbstractResource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@Produces({MediaType.APPLICATION_JSON})
@Path("/page/")
public class PageResource extends AbstractResource {

    @GET
    @Path("/ping")
    public String getCurrentDate(@Context HttpServletRequest request,
                                 @Context HttpServletResponse response) {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));
    }

    @POST
    @Path("/url")
    public Response getPageUri(@Context HttpServletRequest request,
                            @Context HttpServletResponse response,
                            @FormParam("mount") String mount,
                            @FormParam("url") String url) {
        final HstRequestContext requestContext = getRequestContext(request);

        //to fix the partial page render on the root
        if(url.equals("/") || url.equals("")){
            url = "/root";
        }
        PageProvider pp = new PageProvider(requestContext);
        Page page = pp.getPageUri(mount,url);
        pp.logoutSession();

        if (page != null) {
            return Response.ok(page, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @GET
    @Path("/id/{uuid}")
    @Produces("application/json")
    public Response getPage(@Context HttpServletRequest request,
                            @Context HttpServletResponse response,
                            @PathParam("uuid") String uuid) {
        final HstRequestContext requestContext = getRequestContext(request);

        PageProvider pp = new PageProvider(requestContext);
        Page page = pp.getPageById(uuid);
        pp.logoutSession();


        if (page != null) {
            return Response.ok(page, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @POST
    @Path("/id/{uuid}")
    public Response updateContainer(@Context HttpServletRequest request,
                            @Context HttpServletResponse response,
                            @PathParam("uuid") String uuid,
                                    @FormParam("name") String containerName,
                                    @FormParam("selector") String selector,
                                    @FormParam("mode") String mode) {
        final HstRequestContext requestContext = getRequestContext(request);

        PageProvider pp = new PageProvider(requestContext);
        boolean result = pp.updateContainers(uuid, containerName, selector, mode);
        pp.logoutSession();

        if (result) {
            return Response.ok().build();
        } else {
            return Response.notModified().build();
        }
    }

    @DELETE
    @Path("/id/{uuid}")
    public Response deleteContainer(@Context HttpServletRequest request,
                                    @Context HttpServletResponse response,
                                    @PathParam("uuid") String uuid,
                                    @FormParam("name") String containerName) {
        final HstRequestContext requestContext = getRequestContext(request);

        PageProvider pp = new PageProvider(requestContext);
        boolean result = pp.deleteContainer(uuid, containerName);
        pp.logoutSession();

        if (result) {
            return Response.ok().build();
        } else {
            return Response.notModified().build();
        }
    }
}
