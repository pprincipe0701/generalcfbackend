package com.incloud.hcp.validation;

import org.springframework.validation.BindingResult;

public interface Validator<T> {
    void validate(T dto, BindingResult errors);
}
