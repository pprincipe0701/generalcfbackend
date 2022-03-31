CREATE PROCEDURE SP_HOMOLOGACION_AUX ( ) LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN


 DECLARE v_linea INTEGER := 0;
 DECLARE v_count_id_preg INTEGER := 0;
 DECLARE v_count_id_resp INTEGER := 0;
 DECLARE v_count_orden INTEGER :=0;
 DECLARE v_count_aux INTEGER := 0;
 Declare current_d timestamp;



 DECLARE CURSOR c_homologacion_aux FOR
 SELECT * FROM HOMOLOGACION_AUX order by LINEA asc , PREGUNTA asc, NRO_ORDEN asc;

 DECLARE EXIT HANDLER FOR SQL_ERROR_CODE 1299
 BEGIN
    v_linea := 0;
 END;

 delete from HOMOLOGACION_RESPUESTA ;
 delete from HOMOLOGACION;

 FOR cur_row as c_homologacion_aux DO

    v_count_id_resp := v_count_id_resp + 1;

    SELECT CURRENT_DATE into current_d from dummy;

    SELECT DISTINCT plc.id_linea_comercial into v_linea
      FROM LINEA_COMERCIAL plc where plc.DESCRIPCION = cur_row.linea;

    SELECT count(*) into v_count_aux
          FROM HOMOLOGACION h where h.id_linea_comercial = v_linea and h.pregunta = cur_row.pregunta;

    IF v_count_aux = 0 THEN
      v_count_orden = 1;
      v_count_id_preg := v_count_id_preg + 1;
      insert into HOMOLOGACION(
         id_homologacion,
         estado,
         fecha_creacion,
         fecha_modificacion,
         ind_adjunto,
         peso,
         pregunta,
         usuario_creacion,
         usuario_modificacion,
         id_linea_comercial)
         values(v_count_id_preg,'1',current_d,current_d,cur_row.ind_adjunto,cur_row.peso,cur_row.pregunta,0,0,v_linea);
      /*insert into HOMOLOGACION values(v_count_id_preg,'1','2019.08.20','2019.08.20','1',cur_row.peso,cur_row.pregunta,0,0,v_linea); */
    else
      v_count_orden := v_count_orden + 1;
    end if;
    insert into HOMOLOGACION_RESPUESTA values(v_count_id_resp,current_d,current_d,cur_row.nro_orden,cur_row.puntaje,cur_row.respuesta,0,0,v_count_id_preg);

 END FOR;
 END;