CREATE PROCEDURE sp_insert_documento_aceptacion(
	p_fecha_emision						date,
	p_fecha_publicacion					date,
	p_id_estado_documento_aceptacion	INTEGER,
	p_id_tipo_documento_aceptacion		INTEGER,
	p_numero_documento_aceptacion		NVARCHAR(10),
	p_numero_guia_proveedor				NVARCHAR(30),
	p_proveedor_ruc						NVARCHAR(16),
	p_op_guia_compra					INTEGER,
	p_codigo_almacen					INTEGER,
	p_codigo_direccion					INTEGER,
	p_observacion						NVARCHAR(255),
	p_id_empresa						INTEGER
) AS
BEGIN

	declare v_found           		integer := 0;
	declare v_found_proveedor		integer := 0;
	declare v_found_proveedor_ruc	NVARCHAR(300) := '';
	declare v_posicion_orden_compra	NVARCHAR(5) := '';
	DECLARE v_current_estado		integer := 0;

	IF p_id_tipo_documento_aceptacion = 2 THEN -- 2 -> Hoja de Servicio
		SELECT '1' INTO v_posicion_orden_compra FROM dummy; -- Por defecto 1 para Servicio
	END IF;

	-- ////
	SELECT count(1) INTO v_found_proveedor FROM PROVEEDOR p WHERE p.RUC = p_proveedor_ruc;
	if :v_found_proveedor != 0 then
		SELECT p2.RAZON_SOCIAL INTO v_found_proveedor_ruc FROM PROVEEDOR p2 WHERE p2.RUC=p_proveedor_ruc;
	END IF;


	select count(1) into v_found
		from DOCUMENTO_ACEPTACION
		where OP_GUIA_COMPRA = p_op_guia_compra;

	IF :v_found = 0 THEN

		INSERT INTO DOCUMENTO_ACEPTACION(ID_DOCUMENTO_ACEPTACION,
			CODIGO_MONEDA,
			FECHA_ACEPTACION,
			FECHA_EMISION,
			FECHA_PUBLICACION,
			ID_ESTADO_DOCUMENTO_ACEPTACION,
			ID_ORDEN_COMPRA,
			ID_TIPO_DOCUMENTO_ACEPTACION,
			NUMERO_DOCUMENTO_ACEPTACION,
			NUMERO_GUIA_PROVEEDOR,
			NUMERO_ORDEN_COMPRA,
			POSICION_ORDEN_COMPRA,
			PROVEEDOR_RAZON_SOCIAL,
			PROVEEDOR_RUC,
			STATUS_SAP,
			USUARIO_SAP_AUTORIZA,
			USUARIO_SAP_RECEPCION,
			OP_GUIA_COMPRA,
			CODIGO_ALMACEN,
			CODIGO_DIRECCION,
			OBSERVACION,
			ID_EMPRESA)
		VALUES(DOCUMENTO_ACEPTACION_ID_SEQ.nextval,
			null, -- moneda a actualizar
			null,
			p_fecha_emision,
			p_fecha_publicacion,
			p_id_estado_documento_aceptacion,
			null,
			p_id_tipo_documento_aceptacion,
			p_numero_documento_aceptacion,
			p_numero_guia_proveedor,
			null, -- numero orden compra
			v_posicion_orden_compra, -- posicion orden compra
			v_found_proveedor_ruc,
			p_proveedor_ruc,
			null, -- status s
			null, -- usuario autor s
			null, -- usuario recep s
			p_op_guia_compra,
			p_codigo_almacen,
			p_codigo_direccion,
			p_observacion,
			p_id_empresa);

	ELSE
		SELECT id_estado_documento_aceptacion INTO v_current_estado FROM DOCUMENTO_ACEPTACION da WHERE OP_GUIA_COMPRA = p_op_guia_compra;

		IF :v_current_estado != 5 OR :v_current_estado != 6 THEN

			UPDATE DOCUMENTO_ACEPTACION SET
				--CODIGO_MONEDA='',
				--FECHA_ACEPTACION='',
				FECHA_EMISION=p_fecha_emision,
				FECHA_PUBLICACION=p_fecha_publicacion,
				--ID_ESTADO_DOCUMENTO_ACEPTACION=p_id_estado_documento_aceptacion,
				--ID_ORDEN_COMPRA=0,
				ID_TIPO_DOCUMENTO_ACEPTACION=p_id_tipo_documento_aceptacion,
				NUMERO_DOCUMENTO_ACEPTACION=p_numero_documento_aceptacion,
				NUMERO_GUIA_PROVEEDOR=p_numero_guia_proveedor,
				--NUMERO_ORDEN_COMPRA='',
				POSICION_ORDEN_COMPRA=v_posicion_orden_compra,
				PROVEEDOR_RAZON_SOCIAL=v_found_proveedor_ruc,
				PROVEEDOR_RUC=p_proveedor_ruc,
				--STATUS_SAP='',
				--USUARIO_SAP_AUTORIZA='',
				--USUARIO_SAP_RECEPCION='',
				--OP_GUIA_COMPRA=0,
				CODIGO_ALMACEN=p_codigo_almacen,
				CODIGO_DIRECCION=p_codigo_direccion,
				OBSERVACION=p_observacion
				--ID_EMPRESA=p_id_empresa
				WHERE OP_GUIA_COMPRA = p_op_guia_compra AND ID_EMPRESA = p_id_empresa;

		END IF;

	END IF;

END;