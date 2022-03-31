CREATE PROCEDURE sp_insert_documento_aceptacion_detalle (
	p_cantidad_aceptada_cliente					DECIMAL(14,4),
	p_codigo_sap_bien_servicio					NVARCHAR(20),
	p_id_estado_documento_aceptacion_detalle	INTEGER,
	p_movimiento								NVARCHAR(3),
	p_numero_documento_aceptacion				NVARCHAR(10),
	p_numero_item								INTEGER,
	p_kardex									INTEGER,
	p_descripcion_unidad_medida					NVARCHAR(50),
	p_observacion								NVARCHAR(255),
	p_op_guia_compra							INTEGER,
	p_id_amarre									INTEGER,
	p_id_amarre_oc								INTEGER,
	p_id_empresa								INTEGER
) AS
BEGIN

	declare v_id_documento_aceptacion	integer;
	declare v_found           			integer := 0;
	declare v_found_ocdet				integer := 0;
	declare v_found_bien_servicio		integer := 0;

	DECLARE v_found_ocdet_precio_unitario	DECIMAL(14,4) := 0;
	declare v_found_bien_servicio_desc		NVARCHAR(150) := '';
	DECLARE v_found_numero_orden_compra		NVARCHAR(10) := '';
	DECLARE v_current_estado		integer := 0;

	SELECT count(1) INTO v_found_ocdet FROM ORDEN_COMPRA_DETALLE ocd WHERE ocd.ID_AMARRE = p_id_amarre_oc;
	SELECT COUNT(1) INTO v_found_bien_servicio FROM BIEN_SERVICIO bs WHERE LOWER(bs.CODIGO_SAP) = LOWER(p_codigo_sap_bien_servicio) AND bs.KARDEX = p_kardex AND bs.ID_EMPRESA = p_id_empresa;


	if :v_found_ocdet != 0 then
		/* MONEDA */
		UPDATE DOCUMENTO_ACEPTACION a SET a.CODIGO_MONEDA = (
				SELECT oc.CODIGO_MONEDA FROM ORDEN_COMPRA_DETALLE ocdet
					INNER JOIN ORDEN_COMPRA oc ON oc.ID_ORDEN_COMPRA = OCDET.ID_ORDEN_COMPRA
					WHERE oc.IS_ACTIVE = '1' AND oc.ESTADO_SAP = 'L' AND oc.ID_EMPRESA = p_id_empresa AND ocdet.ID_AMARRE =P_ID_AMARRE_OC)
			WHERE a.OP_GUIA_COMPRA = p_op_guia_compra;

		/* PRECIO_UNITARIO */
		SELECT ocdet.PRECIO_UNITARIO INTO v_found_ocdet_precio_unitario
			FROM ORDEN_COMPRA_DETALLE ocdet
			INNER JOIN ORDEN_COMPRA oc ON oc.ID_ORDEN_COMPRA = ocdet.ID_ORDEN_COMPRA
			WHERE oc.IS_ACTIVE = '1' AND oc.ESTADO_SAP = 'L' AND oc.ID_EMPRESA = p_id_empresa AND ocdet.ID_AMARRE =p_id_amarre_oc;
		/*UPDATE DOCUMENTO_ACEPTACION_DETALLE b SET b.PRECIO_UNITARIO = (
				SELECT ocdet.PRECIO_UNITARIO FROM ORDEN_COMPRA_DETALLE ocdet WHERE ocdet.ID_AMARRE =P_ID_AMARRE_OC)
			WHERE b.ID_AMARRE = P_ID_AMARRE AND b.ID_AMARRE_OC = P_ID_AMARRE_OC;*/

		/* NUMERO ORDEN COMPRA (OP) y ID_ORDEN_COMPRA */
		UPDATE DOCUMENTO_ACEPTACION b SET b.NUMERO_ORDEN_COMPRA = (
				SELECT oc.NUMERO_ORDEN_COMPRA FROM ORDEN_COMPRA_DETALLE ocdet
					INNER JOIN ORDEN_COMPRA oc ON oc.ID_ORDEN_COMPRA = OCDET.ID_ORDEN_COMPRA
					WHERE oc.IS_ACTIVE = '1' AND oc.ESTADO_SAP = 'L' AND oc.ID_EMPRESA = p_id_empresa and ocdet.ID_AMARRE =P_ID_AMARRE_OC), b.ID_ORDEN_COMPRA = (
				SELECT oc.ID_ORDEN_COMPRA FROM ORDEN_COMPRA_DETALLE ocdet
					INNER JOIN ORDEN_COMPRA oc ON oc.ID_ORDEN_COMPRA = OCDET.ID_ORDEN_COMPRA
					WHERE oc.IS_ACTIVE = '1' AND oc.ESTADO_SAP = 'L' AND oc.ID_EMPRESA = p_id_empresa AND ocdet.ID_AMARRE =P_ID_AMARRE_OC)
			WHERE b.OP_GUIA_COMPRA = p_op_guia_compra;

		/* Obtener NUMERO ORDEN COMPRA */
		SELECT oc.NUMERO_ORDEN_COMPRA INTO v_found_numero_orden_compra FROM ORDEN_COMPRA_DETALLE ocdet
					INNER JOIN ORDEN_COMPRA oc ON oc.ID_ORDEN_COMPRA = OCDET.ID_ORDEN_COMPRA
					WHERE oc.IS_ACTIVE = '1' AND oc.ESTADO_SAP = 'L' AND oc.ID_EMPRESA = p_id_empresa and ocdet.ID_AMARRE =P_ID_AMARRE_OC;

	END IF;

	IF :v_found_bien_servicio != 0 THEN
		/* DESCRIPCION BIEN SERVICIO */
		SELECT bs.DESCRIPCION INTO v_found_bien_servicio_desc FROM BIEN_SERVICIO bs WHERE LOWER(bs.CODIGO_SAP) = LOWER(p_codigo_sap_bien_servicio) AND bs.KARDEX = p_kardex AND bs.ID_EMPRESA = p_id_empresa;
		/*UPDATE DOCUMENTO_ACEPTACION_DETALLE d SET d.DESCRIPCION_BIEN_SERVICIO = (
				SELECT bs.DESCRIPCION FROM BIEN_SERVICIO bs WHERE bs.CODIGO_SAP = P_CODIGO_PRODUCTO AND bs.KARDEX = P_KARDEX)
			WHERE d.ID_AMARRE = P_ID_AMARRE AND d.ID_AMARRE_OC = P_ID_AMARRE_OC;*/
	END IF;

	-- buscar id_documento_aceptacion
	select id_documento_aceptacion into v_id_documento_aceptacion from DOCUMENTO_ACEPTACION where OP_GUIA_COMPRA = p_op_guia_compra;

	-- valida existencia de documento-aceptacion-detalle
	select count(1) into v_found
		from DOCUMENTO_ACEPTACION_DETALLE
		where ID_DOCUMENTO_ACEPTACION = v_id_documento_aceptacion
		AND ID_AMARRE = p_id_amarre;

	IF :v_found = 0 THEN

		INSERT INTO DOCUMENTO_ACEPTACION_DETALLE (ID_DOCUMENTO_ACEPTACION_DETALLE,
			CANTIDAD_ACEPTADA_CLIENTE,
			CANTIDAD_PENDIENTE,
			CODIGO_SAP_BIEN_SERVICIO,
			DESCRIPCION_BIEN_SERVICIO,
			ID_DOCUMENTO_ACEPTACION,
			ID_ESTADO_DOCUMENTO_ACEPTACION_DETALLE,
			INDICADOR_IMPUESTO,
			MOVIMIENTO,
			NUM_DOC_ACEPTACION_RELACIONADO,
			NUM_ITEM_RELACIONADO,
			NUMERO_DOCUMENTO_ACEPTACION,
			NUMERO_ITEM,
			NUMERO_ORDEN_COMPRA,
			POSICION_ORDEN_COMPRA,
			PRECIO_UNITARIO,
			UNIDAD_MEDIDA,
			VALOR_RECIBIDO,
			VALOR_RECIBIDO_MLOCAL,
			KARDEX,
			DESCRIPCION_UNIDAD_MEDIDA,
			OBSERVACION,
			OP_GUIA_COMPRA,
			ID_AMARRE,
			ID_AMARRE_OC)
		VALUES (DOCUMENTO_ACEPTACION_DETALLE_ID_SEQ.nextval,
			p_cantidad_aceptada_cliente,
			0, -- cantidad pendiente
			p_codigo_sap_bien_servicio,
			v_found_bien_servicio_desc,
			v_id_documento_aceptacion,
			p_id_estado_documento_aceptacion_detalle,
			null, -- indicador impuesto
			p_movimiento,
			null, -- NUM_DOC_ACEPTACION_RELACIONADO
			null, -- NUM_ITEM_RELACIONADO
			p_numero_documento_aceptacion,
			p_numero_item,
			v_found_numero_orden_compra, -- NUMERO_ORDEN_COMPRA
			'', -- POSICION_ORDEN_COMPRA
			v_found_ocdet_precio_unitario,
			'', -- unidad medida
			0, -- valor recibido
			0, -- valor recibido MLOCAL
			p_kardex,
			p_descripcion_unidad_medida,
			p_observacion,
			p_op_guia_compra,
			p_id_amarre,
			p_id_amarre_oc);

	ELSE
		SELECT ID_ESTADO_DOCUMENTO_ACEPTACION_DETALLE into v_current_estado FROM DOCUMENTO_ACEPTACION_DETALLE WHERE ID_DOCUMENTO_ACEPTACION = v_id_documento_aceptacion AND ID_AMARRE = p_id_amarre;

		IF :v_current_estado != 5 OR :v_current_estado != 6 THEN

			UPDATE DOCUMENTO_ACEPTACION_DETALLE SET
				CANTIDAD_ACEPTADA_CLIENTE=p_cantidad_aceptada_cliente,
				CANTIDAD_PENDIENTE=0,
				CODIGO_SAP_BIEN_SERVICIO=p_codigo_sap_bien_servicio,
				DESCRIPCION_BIEN_SERVICIO=v_found_bien_servicio_desc,
				ID_DOCUMENTO_ACEPTACION=v_id_documento_aceptacion,
				--ID_ESTADO_DOCUMENTO_ACEPTACION_DETALLE=p_id_estado_documento_aceptacion_detalle,
				--INDICADOR_IMPUESTO='', -- indicador impuesto
				MOVIMIENTO=p_movimiento,
				--NUM_DOC_ACEPTACION_RELACIONADO='',
				--NUM_ITEM_RELACIONADO=0,
				NUMERO_DOCUMENTO_ACEPTACION=p_numero_documento_aceptacion,
				NUMERO_ITEM=p_numero_item,
				NUMERO_ORDEN_COMPRA=v_found_numero_orden_compra,
				POSICION_ORDEN_COMPRA='',
				PRECIO_UNITARIO=v_found_ocdet_precio_unitario,
				UNIDAD_MEDIDA='',
				--VALOR_RECIBIDO=0,
				--VALOR_RECIBIDO_MLOCAL=0,
				KARDEX=p_kardex,
				DESCRIPCION_UNIDAD_MEDIDA=p_descripcion_unidad_medida,
				OBSERVACION=p_observacion,
				OP_GUIA_COMPRA=p_op_guia_compra
				--ID_AMARRE=p_id_amarre,
				--ID_AMARRE_OC=p_id_amarre_oc
			WHERE ID_AMARRE = p_id_amarre AND ID_AMARRE_OC = p_id_amarre_oc;

		END IF;

	END IF;

	/* VALOR_RECIBIDO (precio x cantidad) */
	UPDATE DOCUMENTO_ACEPTACION_DETALLE c SET c.VALOR_RECIBIDO = CANTIDAD_ACEPTADA_CLIENTE * PRECIO_UNITARIO
		WHERE c.ID_AMARRE = P_ID_AMARRE AND c.ID_AMARRE_OC = P_ID_AMARRE_OC;

END;