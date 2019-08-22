package org.example.rest.model;

import org.example.rest.Constants;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "container")
@XmlAccessorType(XmlAccessType.NONE)
public class Container {
    String name;
    String selector;
    String mode;

    Constants.CONTAINER_TYPE type;

    public Container() {
    }

    public Container(String name, String selector, String mode, Constants.CONTAINER_TYPE type) {
        this.name = name;
        this.selector = selector;
        this.mode = mode;
        this.type = type;
    }

    @XmlElement
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlElement
    public String getSelector() {
        return selector;
    }

    public void setSelector(String selector) {
        this.selector = selector;
    }

    @XmlElement
    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    @XmlElement
    public Constants.CONTAINER_TYPE getType() {
        return type;
    }

    public void setType(Constants.CONTAINER_TYPE type) {
        this.type = type;
    }
}
