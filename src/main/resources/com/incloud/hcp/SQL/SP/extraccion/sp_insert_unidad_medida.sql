CREATE PROCEDURE sp_insert_unidad_medida (
p_codigo_sap					NVARCHAR(10),
p_descripcion					NVARCHAR(100),
p_texto_um						NVARCHAR(20)
) AS
BEGIN

	DECLARE v_found integer := 0;

	-- valida existencia de unidad_medida
	select count(1) into v_found
		from UNIDAD_MEDIDA um
		WHERE CODIGO_SAP = UPPER(p_codigo_sap) AND DESCRIPCION = p_descripcion;

	IF :v_found = 0 THEN

		INSERT INTO UNIDAD_MEDIDA(ID_UNIDAD_MEDIDA,
			CODIGO_SAP,
			DESCRIPCION,
			TEXTO_UM)
		VALUES (UNIDAD_MEDIDA_ID_SEQ.nextval,
			p_codigo_sap,
			p_descripcion,
			p_texto_um);

	ELSE

		UPDATE UNIDAD_MEDIDA SET
			CODIGO_SAP = p_codigo_sap,
			DESCRIPCION = p_descripcion,
			TEXTO_UM = p_texto_um
		WHERE CODIGO_SAP = UPPER(p_codigo_sap) AND DESCRIPCION = p_descripcion;

	END IF;

END;