package org.example.rest.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

@XmlRootElement(name = "page")
@XmlAccessorType(XmlAccessType.NONE)
public class Page {
    String uuid;
    List<Container> containers;

    public Page() {
    }

    public Page(String uuid) {
        this.uuid = uuid;
    }

    public Page(String uuid, List<Container> containers) {
        this.uuid = uuid;
        this.containers = containers;
    }

    @XmlElement
    public List<Container> getContainers() {
        return containers;
    }

    public void setContainers(List<Container> containers) {
        this.containers = containers;
    }

    @XmlElement
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @XmlElement
    public void addContainer(Container c){
        if(containers == null){
            containers = new ArrayList<>();
        }
        containers.add(c);
    }

}
