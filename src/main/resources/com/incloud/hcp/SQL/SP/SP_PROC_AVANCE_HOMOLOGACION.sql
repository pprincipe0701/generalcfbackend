DROP PROCEDURE SP_PROC_AVANCE_HOMOLOGACION;

CREATE PROCEDURE SP_PROC_AVANCE_HOMOLOGACION (
	pId_proveedor   INTEGER,
	OUT pAvance DECIMAL(5, 2)
) LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN

    SELECT ROUND(COALESCE(SUM(r.homologacion) / SUM(r.pregunta) * 100, 0), 2, ROUND_FLOOR) INTO pAvance
    FROM ( SELECT count(1) AS pregunta,
         ( SELECT COUNT(1) FROM PROVEEDOR_HOMOLOGACION ph
          WHERE ph.id_proveedor = pId_proveedor
            AND ph.id_homologacion = h.id_homologacion) AS homologacion
        FROM HOMOLOGACION h
        INNER JOIN (
            SELECT DISTINCT plc.id_linea_comercial
            FROM PROVEEDOR_LINEA_COMERCIAL plc
            WHERE plc.id_proveedor = pId_proveedor) l
            ON h.id_linea_comercial = l.id_linea_comercial
        GROUP BY h.id_homologacion
) r;
END;

