package com.incloud.hcp.util;

import java.io.Serializable;

/**
 * Created by USER on 31/10/2017.
 */
public class Log implements Serializable{

    private static final long serialVersionUID = 1L;

    private String code;
    private String message;

    public Log() {
    }

    public Log(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
