package com.incloud.hcp.jco.maestro.service.impl;

import com.incloud.hcp.jco.maestro.dto.FiltroProveedorDto;
import com.incloud.hcp.jco.maestro.dto.ProveedorDto;
import com.incloud.hcp.jco.maestro.service.JCOProveedorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
//@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
public class JCOProveedorServiceImpl implements JCOProveedorService {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public List<ProveedorDto> listaProveedor(FiltroProveedorDto dto) throws Exception {
        logger.error("listaProveedor__" + dto);
        List<ProveedorDto> lista = new ArrayList<ProveedorDto>();
        ProveedorDto dtoUno = new ProveedorDto();
        dtoUno.setRazonSocial("rz 01_01");
        dtoUno.setRuc("10987666543_02");
        lista.add(dtoUno);
        return lista;
    }

}
