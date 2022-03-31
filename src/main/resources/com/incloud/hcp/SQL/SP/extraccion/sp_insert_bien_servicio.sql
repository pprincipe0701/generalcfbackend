CREATE PROCEDURE sp_insert_bien_servicio (
	p_codigo_sap				NVARCHAR(20),
	p_descripcion				NVARCHAR(80),
	p_descripcion_larga			NVARCHAR(300),
	p_numero_parte				NVARCHAR(40),
	p_tipo_item					NVARCHAR(1),
	p_id_rubro_bien				INTEGER,
	p_id_unidad_medida			INTEGER,
	p_id_empresa				INTEGER,
	p_kardex					INTEGER,
	p_unidad_inventario			NVARCHAR(105),
	p_unidad_presentacion		NVARCHAR(10),
	p_tipo_categoria			NVARCHAR(12),
	p_factor_conversion			DECIMAL(14,4)
) AS
BEGIN

	declare v_id_rubro_bien	  	integer;
  	declare v_id_unidad_medida  integer;
	declare v_found           	integer := 0;

	-- valida existencia de rubro bien
	IF p_id_rubro_bien IS NOT NULL AND p_id_rubro_bien <> 0 THEN
	select ID_RUBRO into v_id_rubro_bien
		from RUBRO_BIEN
		where ID_RUBRO = p_id_rubro_bien;
	END IF;

	-- valida existencia de unidad de medida //TEMP
	IF p_id_unidad_medida IS NOT NULL AND p_id_unidad_medida <> 0 THEN
		select ID_UNIDAD_MEDIDA into v_id_unidad_medida
			from UNIDAD_MEDIDA
			where CODIGO_SAP = UPPER(p_unidad_presentacion) AND DESCRIPCION = p_unidad_inventario;
	END IF;

	-- valida existencia de bien_servicio
	select count(1) into v_found
		from BIEN_SERVICIO
		where KARDEX = p_kardex AND LOWER(CODIGO_SAP) = LOWER(p_codigo_sap) AND ID_EMPRESA = p_id_empresa;

	IF :v_found = 0 THEN

		INSERT INTO BIEN_SERVICIO(ID_BIEN_SERVICIO,
			CODIGO_SAP,
			DESCRIPCION,
			DESCRIPCION_LARGA,
			NUMERO_PARTE,
			TIPO_ITEM,
			ID_RUBRO,
			ID_UNIDAD_MEDIDA,
			KARDEX,
			UNIDAD_INVENTARIO,
			UNIDAD_PRESENTACION,
			TIPO_CATEGORIA,
			FACTOR_CONVERSION,
			ID_EMPRESA)
		VALUES(BIEN_SERVICIO_ID_SEQ.nextval,
			p_codigo_sap,
			p_descripcion,
			p_descripcion_larga,
			p_numero_parte,
			p_tipo_item,
			p_id_rubro_bien,
			v_id_unidad_medida,
			p_kardex,
			p_unidad_inventario,
			p_unidad_presentacion,
			p_tipo_categoria,
			p_factor_conversion,
			p_id_empresa);

	ELSE

		UPDATE BIEN_SERVICIO SET
			CODIGO_SAP=p_codigo_sap,
			DESCRIPCION=p_descripcion,
			DESCRIPCION_LARGA=p_descripcion_larga,
			NUMERO_PARTE=p_numero_parte,
			TIPO_ITEM=p_tipo_item,
			ID_RUBRO=p_id_rubro_bien,
			ID_UNIDAD_MEDIDA=v_id_unidad_medida,
			KARDEX=p_kardex,
			UNIDAD_INVENTARIO=p_unidad_inventario,
			UNIDAD_PRESENTACION=p_unidad_presentacion,
			TIPO_CATEGORIA=p_tipo_categoria,
			FACTOR_CONVERSION=p_factor_conversion,
			ID_EMPRESA=p_id_empresa
		WHERE KARDEX = p_kardex AND CODIGO_SAP = p_codigo_sap AND ID_EMPRESA = p_id_empresa;

	END IF;

END;