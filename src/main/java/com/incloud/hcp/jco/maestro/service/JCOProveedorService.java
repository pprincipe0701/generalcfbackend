package com.incloud.hcp.jco.maestro.service;


import com.incloud.hcp.jco.maestro.dto.FiltroProveedorDto;
import com.incloud.hcp.jco.maestro.dto.ProveedorDto;

import java.util.List;

public interface JCOProveedorService {
    List<ProveedorDto> listaProveedor(FiltroProveedorDto dto) throws Exception;
}
