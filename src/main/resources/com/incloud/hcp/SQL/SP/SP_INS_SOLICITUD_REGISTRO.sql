DROP PROCEDURE SP_INS_SOLICITUD_REGISTRO;

CREATE PROCEDURE SP_INS_SOLICITUD_REGISTRO (
	  pRuc               VARCHAR(11),
	  pRazonSocial       VARCHAR(100),
    pContacto        VARCHAR(100),
    pTelefono        VARCHAR(30),
    pEmail           VARCHAR(50),
    pEstado          CHAR(2),
    pIdTipoProveedor INTEGER,
    pIdHcp           VARCHAR(60),
    pDatosPersonales nvarchar(1),
	OUT pIdRegistro    INTEGER
) LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count_hcp INTEGER := 0;
    DECLARE v_count_ruc INTEGER := 0;
    DECLARE v_estado VARCHAR(100) := '';
    DECLARE id INTEGER := 0;
    DECLARE hr_still_exist_6 CONDITION FOR sql_error_code 10006;
    DECLARE hr_still_exist_7 CONDITION FOR sql_error_code 10007;
    DECLARE hr_still_exist_8 CONDITION FOR sql_error_code 10008;
    DECLARE hr_still_exist_9 CONDITION FOR sql_error_code 10009;
    DECLARE hr_still_exist_10 CONDITION FOR sql_error_code 10010;

    DECLARE EXIT HANDLER FOR hr_still_exist_6 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_7 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_8 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_9 resignal;
    DECLARE EXIT HANDLER FOR hr_still_exist_10 resignal;


    SELECT COUNT(1) INTO v_count_hcp FROM PRE_REGISTRO_PROVEEDOR p WHERE p.hcp_id = pIdHcp;

    IF v_count_hcp > 0 THEN
    -- HCP_ID EXISTE
        SELECT COUNT(1) INTO v_count_ruc FROM PRE_REGISTRO_PROVEEDOR p WHERE p.ruc = pRuc AND p.hcp_id = pIdHcp;

        IF v_count_ruc > 0 THEN
            /* EL RUC */
            SELECT p.estado INTO v_estado FROM PRE_REGISTRO_PROVEEDOR p WHERE p.ruc = pRuc AND p.hcp_id = pIdHcp;

            IF v_estado = 'PE' THEN
                  SIGNAL hr_still_exist_6 SET MESSAGE_TEXT = 'UD, tiene una solicitud pendiente';
            END IF;

            IF v_estado = 'AP' THEN
                  SIGNAL hr_still_exist_7 SET MESSAGE_TEXT = 'UD, tiene una solicitud aprobada';
            END IF;

            UPDATE PRE_REGISTRO_PROVEEDOR SET
                  id_tipo_proveedor = pIdTipoProveedor,
                  ruc = pRuc,
                  razon_social = pRazonSocial,
                  contacto = pContacto,
                  telefono = pTelefono,
                  email = pEmail,
                  estado = pEstado
            WHERE hcp_id = pIdHcp AND ruc = pRuc;
        ELSE
            /* EL RUC A REGISTRAR NO EXISTE */
            SELECT p.estado INTO v_estado FROM PRE_REGISTRO_PROVEEDOR p WHERE p.hcp_id = pIdHcp;

            IF v_estado = 'PE' THEN
                  SIGNAL hr_still_exist_8 SET MESSAGE_TEXT = 'UD, tiene una solicitud pendiente con un RUC diferente';
            END IF;

            IF v_estado = 'AP' THEN
                  SIGNAL hr_still_exist_9 SET MESSAGE_TEXT = 'UD, tiene una solicitud aprobada con un RUC diferente';
            END IF;

            UPDATE PRE_REGISTRO_PROVEEDOR SET
                  id_tipo_proveedor = pIdTipoProveedor,
                  ruc = pRuc,
                  razon_social = pRazonSocial,
                  contacto = pContacto,
                  telefono = pTelefono,
                  email = pEmail,
                  estado = pEstado
            WHERE hcp_id = pIdHcp;

        END IF;

    ELSE
    -- HCP_ID NO EXISTE
        SELECT COUNT(1) INTO v_count_ruc FROM PRE_REGISTRO_PROVEEDOR p WHERE p.ruc = pRuc;

        IF v_count_ruc > 0 THEN
              /* RUC ESTA REGISTRADO. */
              SELECT p.estado INTO v_estado FROM PRE_REGISTRO_PROVEEDOR p WHERE p.ruc = pRuc;

              IF v_estado <> 'RE' THEN
                  SIGNAL hr_still_exist_10 SET MESSAGE_TEXT = 'El RUC fue registrado por otro proveedor';
              END IF;

              /* Se elimina la solicitud anterior y se inserta una una solicitud  */
              DELETE FROM PRE_REGISTRO_PROVEEDOR WHERE RUC = pRuc;

              SELECT PRE_REGISTRO_PROVEEDOR_ID_SEQ.NEXTVAL INTO pIdRegistro FROM DUMMY;
              INSERT INTO PRE_REGISTRO_PROVEEDOR(
                ID_REGISTRO, ID_TIPO_PROVEEDOR, RUC, RAZON_SOCIAL, CONTACTO, TELEFONO, EMAIL, ESTADO, HCP_ID, DATOSPERSONALES)
              VALUES (
                pIdRegistro, pIdTipoProveedor, pRuc, pRazonSocial, pContacto, pTelefono, pEmail, pEstado, pIdHcp, pDatosPersonales);
        ELSE
          /*
            RUC NO REGISTRADO. Se insertar la solicitud.
          */
        SELECT PRE_REGISTRO_PROVEEDOR_ID_SEQ.NEXTVAL INTO pIdRegistro FROM DUMMY;
        INSERT INTO PRE_REGISTRO_PROVEEDOR(
          ID_REGISTRO, ID_TIPO_PROVEEDOR, RUC, RAZON_SOCIAL, CONTACTO, TELEFONO, EMAIL, ESTADO, HCP_ID, DATOSPERSONALES)
        VALUES (
          pIdRegistro, pIdTipoProveedor, pRuc, pRazonSocial, pContacto, pTelefono, pEmail, pEstado, pIdHcp, pDatosPersonales);
        END IF;
    END IF;

END;

