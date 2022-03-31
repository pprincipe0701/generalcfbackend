package com.incloud.hcp.exception;

import java.util.List;

public class StorageException extends PortalException {

    public StorageException(String message) {
        super(message);
    }

    public StorageException(String message, Throwable cause) {
        super(message, (List<Error>) cause);
    }
}
