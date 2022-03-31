drop PROCEDURE SP_PROC_HOMOLOGACION_PROVEEDOR;

CREATE PROCEDURE SP_PROC_HOMOLOGACION_PROVEEDOR (
	pId_proveedor                INTEGER,
	OUT pInd_homologado          CHAR(1),
	OUT pEvaluacion_homologacion DECIMAL(5, 2)
) LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE hr_still_exist CONDITION FOR sql_error_code 10003;

    SELECT COUNT(1) INTO v_count FROM PROVEEDOR p WHERE p.id_proveedor = pId_proveedor;

    IF v_count = 0 THEN
        SIGNAL hr_still_exist SET MESSAGE_TEXT = 'No existe el proveedor con id '||pId_proveedor;
    END IF;

    SELECT COUNT(1) INTO v_count FROM (
        SELECT DISTINCT plc.id_linea_comercial
          FROM PROVEEDOR_LINEA_COMERCIAL plc
        INNER JOIN LINEA_COMERCIAL lc ON (plc.id_linea_comercial = lc.id_linea_comercial AND lc.ind_general = 'B')
         WHERE plc.id_proveedor = pId_proveedor
         )   ;

    if (v_count = 0) then
        SELECT COALESCE(ROUND(SUM(resultado.total_linea)/COUNT(1), 1),0) INTO pEvaluacion_homologacion
        FROM (
            SELECT plc.id_linea_comercial, SUM(COALESCE(r.puntaje * h.peso / 100, 0)) AS total_linea
            FROM (
                SELECT lc.id_linea_comercial
                        FROM LINEA_COMERCIAL lc WHERE lc.ind_general = 'G'
                UNION ALL
                SELECT DISTINCT l.id_linea_comercial
                FROM PROVEEDOR_LINEA_COMERCIAL l
                WHERE l.id_proveedor = pId_proveedor
            ) plc
            INNER JOIN HOMOLOGACION h ON plc.id_linea_comercial = h.id_linea_comercial
            LEFT JOIN (
                SELECT r.puntaje,  p.id_homologacion
                FROM PROVEEDOR_HOMOLOGACION p
                INNER JOIN HOMOLOGACION_RESPUESTA r ON p.id_homologacion_respuesta = r.id_homologacion_respuesta
                WHERE p.id_proveedor = pId_proveedor
            ) r ON h.id_homologacion = r.id_homologacion
            where h.estado = '1'
            GROUP BY plc.id_linea_comercial
        ) resultado;
    else
        SELECT COUNT(1) INTO v_count FROM (
        SELECT DISTINCT plc.id_linea_comercial
          FROM PROVEEDOR_LINEA_COMERCIAL plc
        INNER JOIN LINEA_COMERCIAL lc ON (plc.id_linea_comercial = lc.id_linea_comercial AND lc.ind_general != 'B')
         WHERE plc.id_proveedor = pId_proveedor
         )   ;

        if (v_count = 0) then
            SELECT COALESCE(ROUND(SUM(resultado.total_linea)/COUNT(1), 1),0) INTO pEvaluacion_homologacion
            FROM (
                SELECT plc.id_linea_comercial, SUM(COALESCE(r.puntaje * h.peso / 100, 0)) AS total_linea
                FROM (
                    SELECT DISTINCT l.id_linea_comercial
                    FROM PROVEEDOR_LINEA_COMERCIAL l
                    WHERE l.id_proveedor = pId_proveedor
                ) plc
                INNER JOIN HOMOLOGACION h ON plc.id_linea_comercial = h.id_linea_comercial
                LEFT JOIN (
                    SELECT r.puntaje,  p.id_homologacion
                    FROM PROVEEDOR_HOMOLOGACION p
                    INNER JOIN HOMOLOGACION_RESPUESTA r ON p.id_homologacion_respuesta = r.id_homologacion_respuesta
                    WHERE p.id_proveedor = pId_proveedor
                ) r ON h.id_homologacion = r.id_homologacion
                where h.estado = '1'
                GROUP BY plc.id_linea_comercial
            ) resultado;
        else
            SELECT COALESCE(ROUND(SUM(resultado.total_linea)/COUNT(1), 1),0) INTO pEvaluacion_homologacion
            FROM (
                SELECT plc.id_linea_comercial, SUM(COALESCE(r.puntaje * h.peso / 100, 0)) AS total_linea
                FROM (
                    SELECT lc.id_linea_comercial
                            FROM LINEA_COMERCIAL lc WHERE lc.ind_general = 'G'
                    UNION ALL
                    SELECT DISTINCT l.id_linea_comercial
                    FROM PROVEEDOR_LINEA_COMERCIAL l
                    INNER JOIN LINEA_COMERCIAL lc ON (l.id_linea_comercial = lc.id_linea_comercial AND lc.ind_general != 'B')
                    WHERE l.id_proveedor = pId_proveedor

                ) plc
                INNER JOIN HOMOLOGACION h ON plc.id_linea_comercial = h.id_linea_comercial
                LEFT JOIN (
                    SELECT r.puntaje,  p.id_homologacion
                    FROM PROVEEDOR_HOMOLOGACION p
                    INNER JOIN HOMOLOGACION_RESPUESTA r ON p.id_homologacion_respuesta = r.id_homologacion_respuesta
                    WHERE p.id_proveedor = pId_proveedor
                ) r ON h.id_homologacion = r.id_homologacion
                where h.estado = '1'
                GROUP BY plc.id_linea_comercial
            ) resultado;
        end if;

    end if;
    pInd_homologado := '1';
END;
