package com.incloud.hcp.config;

import com.sap.conn.jco.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
public class CallBAPI {
	private Logger logger = LoggerFactory.getLogger(CallBAPI.class);

	//@ApiOperation(value = "Lista Embarcacion x", produces = "application/json")
	@GetMapping(value = "/listaEmbarcacion", produces = APPLICATION_JSON_VALUE)
	public ResponseEntity<List<EmbarcacionDto>> listaEmbarcacion(
	) throws Exception{
		//Parametro dto = new Parametro();
		List<EmbarcacionDto> listaEmbarcacion = new ArrayList<EmbarcacionDto>();
		logger.error("listaEmbarcacion_1_1_1");;
		JCoDestination destination = JCoDestinationManager.getDestination("TASA_DEST_RFC");
		//JCo
		logger.error("listaEmbarcacion_2_2_2_4");;
		JCoRepository repo = destination.getRepository();
		logger.error("listaEmbarcacion_3");;
		JCoFunction stfcConnection = repo.getFunction("ZFL_RFC_CONS_EMBARCA");
		JCoParameterList importx = stfcConnection.getImportParameterList();
		//stfcConnection.getImportParameterList().setValue("P_USER","FGARCIA");
		importx.setValue("P_USER", "XTS");
		logger.error("listaEmbarcacion_4");;
		JCoParameterList tables = stfcConnection.getTableParameterList();
		JCoTable tableImport = tables.getTable("P_OPTIONS");
		//tableImport.appendRow();
		logger.error("listaEmbarcacion_5");;
		//tableImport.setValue("WA", "CDEMB = '0000004529'");
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

		//return listaEmbarcacion;


		try {
			return Optional.ofNullable(listaEmbarcacion)
					.map(l -> new ResponseEntity<>(l, HttpStatus.OK)).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
		} catch (Exception e) {
			//String error = Utils.obtieneMensajeErrorException(e);
			throw new RuntimeException(e.toString());
		}
	}


	@GetMapping(path="/bapi", produces = "application/json; charset=UTF-8")
	public String getAssignments() {

		try {

			logger.debug("----> started");

			JCoDestination destination = JCoDestinationManager.getDestination("SAP_ECC");
			logger.debug("----> got destination: {}", destination.getDestinationName() );

			JCoRepository repo = destination.getRepository();
			logger.debug("----> got repo: {}", repo.getName() );
			
			JCoFunction stfcConnection = repo.getFunction("STFC_CONNECTION");
			logger.debug("----> got connection: {}", stfcConnection.getName() );

			JCoParameterList imports = stfcConnection.getImportParameterList();
			imports.setValue("REQUTEXT", "SAP Cloud Platform Connectivity runs with JCo");
			stfcConnection.execute(destination);

			JCoParameterList exports = stfcConnection.getExportParameterList();

			return exports.toString();

		} catch (AbapException abapException) {
			logger.error("----> abap exception: {}", abapException);
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, abapException.getMessageText(),
					abapException);

		} catch (JCoException jcoException) {
			logger.error("----> jcoException exception: {}", jcoException);
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, jcoException.getMessageText(),
					jcoException);

		} catch (Exception e) {
			logger.error("----> generic exception: {}", e);
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Exception", e);
		}

	}
}