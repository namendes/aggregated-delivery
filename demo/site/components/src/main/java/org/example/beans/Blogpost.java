package org.example.beans;

import java.util.Calendar;
import java.util.List;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoHtml;
import org.onehippo.cms7.essentials.components.model.Authors;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import org.onehippo.cms7.essentials.components.rest.adapters.HippoHtmlAdapter;

@XmlRootElement(name = "blogpost")
@XmlAccessorType(XmlAccessType.NONE)
@HippoEssentialsGenerated(internalName = "myproject:blogpost")
@Node(jcrType = "myproject:blogpost")
public class Blogpost extends HippoDocument implements Authors {
    public static final String TITLE = "myproject:title";
    public static final String INTRODUCTION = "myproject:introduction";
    public static final String CONTENT = "myproject:content";
    public static final String PUBLICATION_DATE = "myproject:publicationdate";
    public static final String CATEGORIES = "myproject:categories";
    public static final String AUTHOR = "myproject:author";
    public static final String AUTHOR_NAMES = "myproject:authornames";
    public static final String LINK = "myproject:link";
    public static final String AUTHORS = "myproject:authors";
    public static final String TAGS = "hippostd:tags";

    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:publicationdate")
    public Calendar getPublicationDate() {
        return getSingleProperty(PUBLICATION_DATE);
    }

    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:authornames")
    public String[] getAuthorNames() {
        return getMultipleProperty(AUTHOR_NAMES);
    }

    @XmlElement
    public String getAuthor() {
        final String[] authorNames = getAuthorNames();
        if (authorNames != null && authorNames.length > 0) {
            return authorNames[0];
        }
        return null;
    }

    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:title")
    public String getTitle() {
        return getSingleProperty(TITLE);
    }

    @XmlJavaTypeAdapter(HippoHtmlAdapter.class)
    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:content")
    public HippoHtml getContent() {
        return getHippoHtml(CONTENT);
    }

    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:introduction")
    public String getIntroduction() {
        return getSingleProperty(INTRODUCTION);
    }

    @XmlElement
    @HippoEssentialsGenerated(internalName = "myproject:categories")
    public String[] getCategories() {
        return getMultipleProperty(CATEGORIES);
    }

    @Override
    @HippoEssentialsGenerated(internalName = "myproject:authors")
    public List<Author> getAuthors() {
        return getLinkedBeans(AUTHORS, Author.class);
    }
}
