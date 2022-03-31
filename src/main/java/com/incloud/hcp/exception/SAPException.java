package com.incloud.hcp.exception;

public class SAPException extends RuntimeException {

    public SAPException(String message) {
        super(message);
    }

    public SAPException(String message, Throwable cause) {
        super(message, cause);
    }
}
