CREATE PROCEDURE SP_SEL_HOMOLOGACION_PROVEEDOR(
    pId_proveedor INTEGER
)
LANGUAGE SQLSCRIPT
SQL SECURITY INVOKER
READS SQL DATA AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE v_tipo INTEGER := 0;

    SELECT COUNT(1) INTO v_count FROM (
        SELECT DISTINCT plc.id_linea_comercial
          FROM PROVEEDOR_LINEA_COMERCIAL plc
        INNER JOIN LINEA_COMERCIAL lc ON (plc.id_linea_comercial = lc.id_linea_comercial AND lc.ind_general = 'B')
         WHERE plc.id_proveedor = pId_proveedor
         )   ;


    IF v_count = 0 THEN
        select pId_proveedor AS id_proveedor, H.ID_LINEA_COMERCIAL,LC.descripcion AS linea_comercial,
		    h.estado,
		    ph.valor_respuesta_libre,
        H.ID_HOMOLOGACION, H.pregunta, H.peso, 
        H.ind_adjunto,
        hr.id_homologacion_respuesta,
        hr.respuesta,
        (SELECT ph.id_homologacion_respuesta
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS id_homologacion_respuesta_proveedor,
        (SELECT ph.archivo_id
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_id,
        (SELECT ph.ruta_adjunto
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS ruta_adjunto,
        (SELECT ph.archivo_nombre
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_nombre

        from PROVEEDOR_HOMOLOGACION PH inner join HOMOLOGACION_RESPUESTA HR ON
        PH.ID_HOMOLOGACION = HR.ID_HOMOLOGACION INNER join HOMOLOGACION H ON
        PH.ID_HOMOLOGACION = H.ID_HOMOLOGACION  inner join LINEA_COMERCIAL lc on H.ID_LINEA_COMERCIAL = LC.ID_LINEA_COMERCIAL
        WHERE PH.ID_PROVEEDOR = pId_proveedor;
    ELSE
        SELECT COUNT(1) INTO v_count FROM (
        SELECT DISTINCT plc.id_linea_comercial
          FROM PROVEEDOR_LINEA_COMERCIAL plc
        INNER JOIN LINEA_COMERCIAL lc ON (plc.id_linea_comercial = lc.id_linea_comercial AND lc.ind_general != 'B')
         WHERE plc.id_proveedor = pId_proveedor
         )   ;

        if v_count = 0 THEN
           select pId_proveedor AS id_proveedor, H.ID_LINEA_COMERCIAL,LC.descripcion AS linea_comercial,
		     h.estado,
		      ph.valor_respuesta_libre,
        H.ID_HOMOLOGACION, H.pregunta, H.peso, 
        H.ind_adjunto,
        hr.id_homologacion_respuesta,
        hr.respuesta,
        (SELECT ph.id_homologacion_respuesta
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS id_homologacion_respuesta_proveedor,
        (SELECT ph.archivo_id
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_id,
        (SELECT ph.ruta_adjunto
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS ruta_adjunto,
        (SELECT ph.archivo_nombre
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_nombre

        from PROVEEDOR_HOMOLOGACION PH inner join HOMOLOGACION_RESPUESTA HR ON
        PH.ID_HOMOLOGACION = HR.ID_HOMOLOGACION INNER join HOMOLOGACION H ON
        PH.ID_HOMOLOGACION = H.ID_HOMOLOGACION  inner join LINEA_COMERCIAL lc on H.ID_LINEA_COMERCIAL = LC.ID_LINEA_COMERCIAL
        WHERE PH.ID_PROVEEDOR = pId_proveedor;
        else

            select pId_proveedor AS id_proveedor, H.ID_LINEA_COMERCIAL,LC.descripcion AS linea_comercial,
		h.estado,
		 ph.valor_respuesta_libre,
        H.ID_HOMOLOGACION, H.pregunta, H.peso, 
        H.ind_adjunto,
        hr.id_homologacion_respuesta,
        hr.respuesta,
        (SELECT ph.id_homologacion_respuesta
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS id_homologacion_respuesta_proveedor,
        (SELECT ph.archivo_id
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_id,
        (SELECT ph.ruta_adjunto
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS ruta_adjunto,
        (SELECT ph.archivo_nombre
        FROM PROVEEDOR_HOMOLOGACION ph
        WHERE ph.id_proveedor = pId_proveedor
        AND ph.id_homologacion = h.id_homologacion
        AND ph.id_homologacion_respuesta = hr.id_homologacion_respuesta) AS archivo_nombre

        from PROVEEDOR_HOMOLOGACION PH inner join HOMOLOGACION_RESPUESTA HR ON
        PH.ID_HOMOLOGACION = HR.ID_HOMOLOGACION INNER join HOMOLOGACION H ON
        PH.ID_HOMOLOGACION = H.ID_HOMOLOGACION  inner join LINEA_COMERCIAL lc on H.ID_LINEA_COMERCIAL = LC.ID_LINEA_COMERCIAL
        WHERE PH.ID_PROVEEDOR = pId_proveedor;

        end if;
    END IF;
END;