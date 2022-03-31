package com.incloud.hcp.rest;


import com.incloud.hcp.jco.maestro.dto.FiltroProveedorDto;
import com.incloud.hcp.jco.maestro.dto.ProveedorDto;
import com.incloud.hcp.jco.maestro.service.JCOProveedorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping(value = "/api/_jcoRest")
public class _JcoRest {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    /*@Autowired
    private JCOPeticionOfertaService jcoPeticionOfertaService;ddd*/

    @Autowired
    private JCOProveedorService jcoProveedorService;

   /* @Autowired
    private JCOGrupoArticuloServiceNew jcoGrupoArticuloServiceNew;*/




    //@ApiOperation(value = "Lista Proveedores RFC", produces = "application/json")
    @PostMapping(value = "/listaProveedoresByRFC", produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ProveedorDto>> listarProveedoresRFC(@RequestBody FiltroProveedorDto dto
                                                           ) {
        List<ProveedorDto> lista = new ArrayList<ProveedorDto>();
        try {
            lista = this.jcoProveedorService.listaProveedor(dto);
            return Optional.ofNullable(lista)
                    .map(l -> new ResponseEntity<>(l, HttpStatus.OK)).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
        } catch (Exception e) {
            //String error = Utils.obtieneMensajeErrorException(e);
            throw new RuntimeException(e.toString());
        }
    }
    //@ApiOperation(value = "Lista parametros RFC", produces = "application/json")
    /*@GetMapping(value = "/listarProveedoresRFCPrueba", produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<Parametro> listarProveedoresRFCPrueba(@RequestParam(value = "nroAcreedor", required = true) String nroAcreedor
    ) {
        Parametro dto = new Parametro();
        try {
            return Optional.ofNullable(dto)
                    .map(l -> new ResponseEntity<>(l, HttpStatus.OK)).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
        } catch (Exception e) {
            String error = Utils.obtieneMensajeErrorException(e);
            throw new RuntimeException(error);
        }
    }*/

}
