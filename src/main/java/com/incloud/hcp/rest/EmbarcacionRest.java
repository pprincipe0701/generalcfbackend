package com.incloud.hcp.rest;


import com.incloud.hcp.jco.gestionpesca.dto.EmbarcacionDto;
import com.incloud.hcp.jco.gestionpesca.service.JCOEmbarcacionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping(value = "/api/embarcacion")
public class EmbarcacionRest {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    /*@Autowired
    private JCOPeticionOfertaService jcoPeticionOfertaService;*/

    @Autowired
    private JCOEmbarcacionService jcoEmbarcacionService;

   /* @Autowired
    private JCOGrupoArticuloServiceNew jcoGrupoArticuloServiceNew;h*/




    //@ApiOperation(value = "Lista Embarcacion x", produces = "application/json")
    @GetMapping(value = "/listaEmbarcacion", produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<List<EmbarcacionDto>> listaEmbarcacion(
    ) {
        //Parametro dto = new Parametro();
        try {
            return Optional.ofNullable(this.jcoEmbarcacionService.listaEmbarcacion("CDEMB = '0000004529'"))
                    .map(l -> new ResponseEntity<>(l, HttpStatus.OK)).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
        } catch (Exception e) {
            //String error = Utils.obtieneMensajeErrorException(e);
            throw new RuntimeException(e.toString());
        }
    }

}
