package com.incloud.hcp.exception;

import org.springframework.http.HttpStatus;

/**
 * Created by George on 08/06/2017.
 */
public class ServiceException extends RuntimeException {

    private final Integer errorCode;
    private final String keyMessage;
    private final Object[] args;
    private final Object data;
    private final HttpStatus httpStatus;

    public ServiceException(String messageByCause) {
        super(messageByCause);
        this.errorCode = null;
        this.keyMessage = null;
        this.args = null;
        this.data = null;
        this.httpStatus = null;
    }

    public ServiceException(KeyMessageEnum keyMessageEnum, Integer errorCode) {
        this.keyMessage = keyMessageEnum.getKey();
        this.errorCode = errorCode;
        this.args = null;
        this.data = null;
        this.httpStatus = null;
    }

    public ServiceException(KeyMessageEnum keyMessageEnum, Integer errorCode, HttpStatus httpStatus) {
        this.keyMessage = keyMessageEnum.getKey();
        this.errorCode = errorCode;
        this.httpStatus = httpStatus;
        this.args = null;
        this.data = null;
    }

    public ServiceException(Object data, KeyMessageEnum keyMessageEnum, Integer errorCode) {
        this.data = data;
        this.keyMessage = keyMessageEnum.getKey();
        this.errorCode = errorCode;
        this.args = null;
        this.httpStatus = null;
    }

    /***
     * @param keyMessageEnum clave de mensaje
     * @param args argumentos de mensaje ({0}, {1}, ...)
     * @param errorCode codigo interno
     */
    public ServiceException(KeyMessageEnum keyMessageEnum, Object[] args, Integer errorCode) {
        this.keyMessage = keyMessageEnum.getKey();
        this.args = args;
        this.errorCode = errorCode;
        this.data = null;
        this.httpStatus = null;
    }

    public ServiceException(Object data, KeyMessageEnum keyMessageEnum, Object[] args, Integer errorCode) {
        this.data = data;
        this.keyMessage = keyMessageEnum.getKey();
        this.args = args;
        this.errorCode = errorCode;
        this.httpStatus = null;
    }

    public Object getData() {
        return data;
    }

    public String getKeyMessage() {
        return keyMessage;
    }

    public Integer getErrorCode() {
        return errorCode;
    }

    public Object[] getArgs() {
        return this.args;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
