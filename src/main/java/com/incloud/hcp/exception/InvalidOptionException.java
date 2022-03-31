package com.incloud.hcp.exception;

import java.util.List;

public class InvalidOptionException extends PortalException {

    public InvalidOptionException(String message) {
        super(message);
    }

    public InvalidOptionException(String message, List<Error> details) {
        super(message, details);
    }
}
