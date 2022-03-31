package com.incloud.hcp.exception;

public enum KeyMessageEnum {

    NOT_FOUND_KEY("Internal Server Error"),
    SAVE_ERROR_GENERIC("message.generic.error.save"),
    MESSAGE_ACCION_ERROR_RESULTADO("message.accion.error.resultado"),
    MESSAGE_FORBIDDEN("message.user.forbidden");

    private final String key;

    KeyMessageEnum(String key) {
        this.key = key;
    }

    public String getKey() {
        return this.key;
    }

}