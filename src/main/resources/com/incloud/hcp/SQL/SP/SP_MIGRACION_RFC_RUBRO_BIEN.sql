CREATE PROCEDURE SP_MIGRACION_RFC_RUBRO_BIEN()
LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE v_id INTEGER := 0;
    DECLARE CURSOR c_data FOR
         SELECT * FROM TEMP_RUBRO_BIEN;


    DECLARE CURSOR c_data_NUEVA FOR
        SELECT trb.id_rubro as "ID_RUBRO_TEMP",trb.codigo_sap,trb.descripcion,trb.nivel
        from temp_rubro_bien trb
        where not exists (select * from rubro_bien r
                          where trb.codigo_sap = r.codigo_sap);

    DECLARE CURSOR c_data_ACTUALIZADAS FOR
       SELECT (select rb.id_rubro from rubro_bien rb where rb.codigo_sap=trb.codigo_sap) as
        "ID_RUBRO",trb.codigo_sap,
        trb.descripcion,trb.nivel
        from temp_rubro_bien trb
        where  exists (select * from rubro_bien r
                          where trb.codigo_sap = r.codigo_sap and
                                trb.descripcion <> r.descripcion);


    SELECT count(*) into v_count from rubro_bien;

    IF(v_count=0) THEN
        FOR cur_r as c_data DO
        select rubro_bien_id_seq.nextval into v_id from dummy;
        insert into rubro_bien(id_rubro,codigo_sap,descripcion,nivel)
        values(v_id,cur_r.codigo_sap,cur_r.descripcion,1);
        END FOR;
        ELSE
                FOR cur_row as c_data_NUEVA DO
                select rubro_bien_id_seq.nextval into v_id from dummy;
                insert into rubro_bien(id_rubro,codigo_sap,descripcion,nivel)
                values(v_id,cur_row.codigo_sap,cur_row.descripcion,1);
                END FOR;



                FOR cur_row_ac as c_data_ACTUALIZADAS DO
                update rubro_bien set descripcion=cur_row_ac.descripcion where id_rubro=cur_row_ac.ID_RUBRO;
                END FOR;
    END IF;



END;