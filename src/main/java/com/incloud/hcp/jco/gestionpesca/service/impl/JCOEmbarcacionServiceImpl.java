package com.incloud.hcp.jco.gestionpesca.service.impl;

import com.incloud.hcp.jco.gestionpesca.dto.EmbarcacionDto;
import com.incloud.hcp.jco.gestionpesca.service.JCOEmbarcacionService;
import com.sap.conn.jco.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
//@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
public class JCOEmbarcacionServiceImpl implements JCOEmbarcacionService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    public List<EmbarcacionDto> listaEmbarcacion(String condicion) throws Exception {

        List<EmbarcacionDto> listaEmbarcacion = new ArrayList<EmbarcacionDto>();
        logger.error("listaEmbarcacion_1");;
        JCoDestination destination = JCoDestinationManager.getDestination("TASA_DEST_RFC");
        //JCo
        logger.error("listaEmbarcacion_2");;
        JCoRepository repo = destination.getRepository();
        logger.error("listaEmbarcacion_3");;
        JCoFunction stfcConnection = repo.getFunction("ZFL_RFC_CONS_EMBARCA");
        JCoParameterList importx = stfcConnection.getImportParameterList();
        //stfcConnection.getImportParameterList().setValue("P_USER","FGARCIA");
        importx.setValue("P_USER", "FGARCIA");
        logger.error("listaEmbarcacion_4");;
        JCoParameterList tables = stfcConnection.getTableParameterList();
        JCoTable tableImport = tables.getTable("P_OPTIONS");
        tableImport.appendRow();
        logger.error("listaEmbarcacion_5");;
        tableImport.setValue("WA", condicion);
        //Ejecutar Funcion
        stfcConnection.execute(destination);
        logger.error("listaEmbarcacion_6");
        //DestinationAcce

        //Recuperar Datos de SAP

        JCoTable tableExport = tables.getTable("STR_EMB");

        for (int i = 0; i < tableExport.getNumRows(); i++) {
            tableExport.setRow(i);
            EmbarcacionDto dto = new EmbarcacionDto();

            dto.setCodigoEmbarcacion(tableExport.getString("CDEMB"));
            dto.setNombreEmbarcacion(tableExport.getString("NMEMB"));
            listaEmbarcacion.add(dto);
            //lista.add(param);
        }

        return listaEmbarcacion;
    }
}
