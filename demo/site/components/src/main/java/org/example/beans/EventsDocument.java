package org.example.beans;

import java.util.Calendar;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import org.onehippo.cms7.essentials.components.rest.adapters.HippoHtmlAdapter;
import org.onehippo.cms7.essentials.components.rest.adapters.HippoGalleryImageAdapter;

@XmlRootElement(name = "eventsdocument")
@XmlAccessorType(XmlAccessType.NONE)
@HippoEssentialsGenerated(internalName = "myproject:eventsdocument")
@Node(jcrType = "myproject:eventsdocument")
public class EventsDocument extends HippoDocument {
    /** 
     * The document type of the events document.
     */
    public static final String DOCUMENT_TYPE = "myproject:eventsdocument";
    private static final String TITLE = "myproject:title";
    private static final String DATE = "myproject:date";
    private static final String INTRODUCTION = "myproject:introduction";
    private static final String IMAGE = "myproject:image";
    private static final String CONTENT = "myproject:content";
    private static final String LOCATION = "myproject:location";
    private static final String END_DATE = "myproject:enddate";

    /** 
     * Get the title of the document.
     * @return the title
     */
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:title")
    public String getTitle() {
        return getSingleProperty(TITLE);
    }

    /** 
     * Get the date of the document, i.e. the start date of the event.
     * @return the (start) date
     */
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:date")
    public Calendar getDate() {
        return getSingleProperty(DATE);
    }

    /** 
     * Get the introduction of the document.
     * @return the introduction
     */
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:introduction")
    public String getIntroduction() {
        return getSingleProperty(INTRODUCTION);
    }

    /** 
     * Get the image of the document.
     * @return the image
     */
    @XmlJavaTypeAdapter(HippoGalleryImageAdapter.class)
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:image")
    public HippoGalleryImageSet getImage() {
        return getLinkedBean(IMAGE, HippoGalleryImageSet.class);
    }

    /** 
     * Get the main content of the document.
     * @return the content
     */
    @XmlJavaTypeAdapter(HippoHtmlAdapter.class)
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:content")
    public HippoHtml getContent() {
        return getHippoHtml(CONTENT);
    }

    /** 
     * Get the location of the document.
     * @return the location
     */
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:location")
    public String getLocation() {
        return getSingleProperty(LOCATION);
    }

    /** 
     * Get the end date of the document, i.e. the end date of the event.
     * @return the end date
     */
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:enddate")
    public Calendar getEndDate() {
        return getSingleProperty(END_DATE);
    }
}
