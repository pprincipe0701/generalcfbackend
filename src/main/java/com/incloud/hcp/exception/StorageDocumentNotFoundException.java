package com.incloud.hcp.exception;

public class StorageDocumentNotFoundException extends StorageException {

    public StorageDocumentNotFoundException(String message) {
        super(message);
    }

    public StorageDocumentNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
