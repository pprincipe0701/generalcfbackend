package com.incloud.hcp.domain._framework;

import org.springframework.data.domain.PageRequest;

public class BaseResponseDomain<T extends BaseDomain> {

    protected T bean;
    protected PageRequest pageRequest;

    public void setBean(T bean) {
        this.bean = bean;
    }

    public T getBean() {
        return this.bean;
    }

    public PageRequest getPageRequest() {
        return pageRequest;
    }

    public void setPageRequest(PageRequest pageRequest) {
        this.pageRequest = pageRequest;
    }

}
