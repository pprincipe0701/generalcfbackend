package com.incloud.hcp.jco.gestionpesca.service;

import com.incloud.hcp.jco.gestionpesca.dto.EmbarcacionDto;

import java.util.List;

public interface JCOEmbarcacionService {
    List<EmbarcacionDto> listaEmbarcacion(String condicion) throws Exception;
}
