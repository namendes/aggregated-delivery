package com.bloomreach.commercedxp.demo.pactronics.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Locale;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import org.apache.commons.lang.StringUtils;
import org.hippoecm.hst.configuration.hosting.Mount;
import org.hippoecm.hst.container.RequestContextProvider;
import org.hippoecm.hst.content.beans.ObjectBeanManagerException;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.core.linking.HstLink;
import org.hippoecm.hst.core.linking.HstLinkCreator;
import org.hippoecm.hst.core.request.HstRequestContext;
import org.hippoecm.hst.site.HstServices;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Credentials;
import javax.jcr.Repository;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import static com.bloomreach.commercedxp.demo.pactronics.constants.SiteConstants.FULLY_QUALIFIED_RESOURCE_URLS;

public class SiteUtil {
    private static String CHANNEL_ID_PREVIEW_POSTFIX = "-preview";
    private static Logger LOGGER = LoggerFactory.getLogger(SiteUtil.class);

    public static Session getSystemSession() throws RepositoryException {
        return getSystemRepository().login(getSystemCredentials());
    }

    private static Repository getSystemRepository() {
        return HstServices.getComponentManager().getComponent(Repository.class.getName());
    }

    private static Credentials getSystemCredentials() {
        return HstServices.getComponentManager().getComponent(Credentials.class.getName() + ".hstconfigreader");
    }

    public static Mount getMount() {
        Mount mount = RequestContextProvider.get().getResolvedMount().getMount();
        if (!mount.isExplicit()) {
            mount = mount.getParent();
        }
        return mount;
    }

    public static String getSubSitePath(final Mount mount) {
        String path = mount.getMountPath();
        // removing first part of the path since its the name of the brand which behaves as a root mount
        if (StringUtils.isNotBlank(path) && path.indexOf("/", 1) > 0) {
            return path.substring(path.indexOf("/", 1));
        }
        return "";
    }

    public static String getChannelId() {
        Mount mount = getMount();
        String channelId = mount.getChannel().getId();
        if (mount.isPreview()) {
            channelId = StringUtils.removeEnd(channelId, CHANNEL_ID_PREVIEW_POSTFIX);
        }
        return channelId;
    }

    public static Locale convertToLocale(String localeString) {
        if(StringUtils.isNotBlank(localeString)) {
            if(localeString.contains("_")) {
                return new Locale(
                        localeString.substring(0, localeString.indexOf("_")),
                        localeString.substring(localeString.indexOf("_") + 1)
                );
            } else {
                return new Locale(localeString);
            }
        }
        return null;
    }

    public static String getLinkForPath(final HstRequestContext requestContext, final String path) {
        HstLinkCreator hstLinkCreator = requestContext.getHstLinkCreator();
        HippoBean bean = getModelForPath(requestContext, path);
        if (bean != null) {
            HstLink hstLink = hstLinkCreator.create(bean.getNode(), SiteUtil.getMount());
            if (hstLink != null) {
                return hstLink.toUrlForm(requestContext, FULLY_QUALIFIED_RESOURCE_URLS);
            }
        }
        return null;
    }

    public static HippoBean getModelForPath(final HstRequestContext requestContext, final String path) {
        try {
            return (HippoBean)requestContext.getObjectBeanManager().getObject(path);
        } catch (ObjectBeanManagerException e) {
            LOGGER.debug("Unable to find object with path: " + path, e);
        }
        return null;
    }

    public static ByteArrayOutputStream getQRCodeImageStream(String text, int width, int height) {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = null;

        try {
            bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", bos);
            return bos;
        } catch (WriterException | IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static String getQRCodeImage(String text, int width, int height) {

        ByteArrayOutputStream bos = getQRCodeImageStream(text, width, height);
        byte[] imageBytes = bos.toByteArray();
        final byte[] bytes = Base64.getEncoder().encode(imageBytes);
        final String data = "data:image/" + "PNG" + ";base64," + new String(bytes, StandardCharsets.UTF_8);
        return data;

    }

    public static Cookie getCookie(final HttpServletRequest request, final String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie;
                }
            }
        }
        return null;
    }

}
