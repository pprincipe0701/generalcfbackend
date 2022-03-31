drop PROCEDURE SP_PROC_INS_SOLICITUD_BLACKLIST;

CREATE PROCEDURE SP_PROC_INS_SOLICITUD_BLACKLIST (
	pSede                VARCHAR(250),
    pMotivo              CLOB,
    pIdCriterio          INTEGER,
    pRuc                 VARCHAR(11),
    pEstadoSolicitud     CHAR(2),
    pUsuarioCreacion     VARCHAR(30),
    pUsuarioCreacionName VARCHAR(50),
    pUsuarioEmail        VARCHAR(50),
	OUT pIdSolicitud     INTEGER,
    OUT pCodigoSolicitud VARCHAR(13)
) LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE vIdProveedor INTEGER := 0;
    DECLARE vIndBlackList CHAR(1) := '0';
    DECLARE vIdTipoSolicitud INTEGER := 0;
    DECLARE hr_still_exist_1 CONDITION FOR sql_error_code 10001;
    DECLARE hr_still_exist_2 CONDITION FOR sql_error_code 10002;
    DECLARE hr_still_exist_3 CONDITION FOR sql_error_code 10003;
    DECLARE hr_still_exist_4 CONDITION FOR sql_error_code 10004;
    DECLARE hr_still_exist_5 CONDITION FOR sql_error_code 10005;
    DECLARE EXIT HANDLER FOR hr_still_exist_1 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_2 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_3 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_4 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_5 resignal;

    -- Busqueda del proveedor
    SELECT COUNT(1) INTO v_count FROM PROVEEDOR p WHERE p.ruc = pRuc;

    IF v_count = 0 THEN
        SIGNAL hr_still_exist_1 SET MESSAGE_TEXT = 'El proveedor con ruc no existe.';
    END IF;

    SELECT p.id_proveedor, p.ind_black_list  INTO vIdProveedor, vIndBlackList FROM PROVEEDOR p WHERE p.ruc = pRuc;

    SELECT c.id_tipo_solicitud INTO vIdTipoSolicitud FROM CRITERIOS_BLACKLIST c WHERE c.id_criterio = pIdCriterio;

    SELECT COUNT(1) INTO v_count FROM SOLICITUD_BLACKLIST bl
    WHERE bl.id_proveedor = vIdProveedor AND bl.estado_solicitud IN ('GE', 'PE');

    -- Registro Observado
    IF vIdTipoSolicitud = 1 THEN
        IF v_count > 0 THEN
            SIGNAL hr_still_exist_2 SET MESSAGE_TEXT = 'Existe una solicitud pendiente de aprobación';
        END IF;

        IF vIndBlackList = '1' THEN
            SIGNAL hr_still_exist_3 SET MESSAGE_TEXT = 'El proveedor ya fue observado';
        END IF;
    END IF;

    -- Retiro proveedor Observado
    IF vIdTipoSolicitud = 2  THEN
        IF v_count > 0 THEN
            SIGNAL hr_still_exist_4 SET MESSAGE_TEXT = 'Existe una solicitud pendiente de aprobación';
        END IF;

        IF COALESCE(vIndBlackList, 0) = 0 THEN
            SIGNAL hr_still_exist_5 SET MESSAGE_TEXT = 'El proveedor no está observado';
        END IF;
    END IF;

    SELECT p.valor + 1 INTO v_count FROM PARAMETROS p WHERE p.MODULO = 'BLACKLIST' AND p.TIPO = 'CONTADOR_SOLICITUD';

    SELECT SOLICITUD_BLACKLIST_ID_SEQ.NEXTVAL,
          'PO-'||YEAR(CURRENT_DATE)|| CONCAT(LEFT('000000', LENGTH('000000') - LENGTH(v_count)), v_count)
    INTO pIdSolicitud, pCodigoSolicitud FROM dummy;

    INSERT INTO SOLICITUD_BLACKLIST(
            ID_SOLICITUD,
            CODIGO_SOLICITUD,
            SEDE,
            MOTIVO,
            ID_CRITERIO,
            ID_PROVEEDOR,
            ESTADO_SOLICITUD,
            FECHA_CREACION,
            USUARIO_CREACION,
            USUARIO_CREACION_NAME,
            USUARIO_CREACION_EMAIL)
            VALUES (
                pIdSolicitud,
                pCodigoSolicitud,
                pSede,
                pMotivo,
                pIdCriterio,
                vIdProveedor,
                pEstadoSolicitud,
                utctolocal(CURRENT_TIMESTAMP, 'UTC-5'),
                pUsuarioCreacion,
                pUsuarioCreacionName,
                pUsuarioEmail
            );

        UPDATE PARAMETROS SET valor = v_count WHERE MODULO = 'BLACKLIST' AND TIPO = 'CONTADOR_SOLICITUD';
END;

