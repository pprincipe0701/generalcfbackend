package com.incloud.hcp.bean;

/**
 * Created by Administrador on 26/09/2017.
 */
public class CmisFile {
    private String id;
    private String name;
    private String url;
    private String type;
    private CmisFile parent;


    public CmisFile() {
        this.parent = null;
    }

    public CmisFile(String id, String name, String url, String type) {
        this.id = id;
        this.name = name;
        this.url = url;
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public CmisFile getParent() {
        return parent;
    }

    public void setParent(CmisFile parent) {
        this.parent = parent;
    }


    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("[ id : ");
        sb.append(this.id);
        sb.append(" , name : ");
        sb.append(this.name);
        sb.append(" , url : ");
        sb.append(this.url);
        sb.append(" , type : ");
        sb.append(this.type);
        if (this.parent != null){
            sb.append(this.parent.toString());
        }
        sb.append("]");
        return sb.toString();
    }
}
