CREATE PROCEDURE SP_MIGRACION_RFC_MATERIAL_SERVICIO()
LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE v_id INTEGER := 0;

    DECLARE v_actualizar integer := 0;
    DECLARE v_id_rubro INTEGER := 0;
    DECLARE v_id_unidad INTEGER := 0;
    DECLARE CURSOR c_data FOR
         SELECT * FROM TEMP_BIEN_SERVICIO x
         where x.descripcion is not null
           and x.codigo_rubro_sap is not null
           and x.codigo_unidad_medida_sap is not null;

    FOR cur_r as c_data DO
    	v_actualizar := 0;
        select count(1) into v_count from rubro_bien where codigo_sap = cur_r.codigo_rubro_sap ;

        if (v_count > 0) then
            select id_rubro into v_id_rubro from rubro_bien where codigo_sap = cur_r.codigo_rubro_sap ;
        	select count(1) into v_count from unidad_medida where codigo_sap = cur_r.codigo_unidad_medida_sap ;

            if (v_count > 0) then

               select id_unidad_medida into v_id_unidad from unidad_medida where codigo_sap = cur_r.codigo_unidad_medida_sap ;
               select count(1) into v_count from bien_servicio x where codigo_sap = cur_r.codigo_sap and tipo_item = cur_r.tipo_item;

               if (v_count > 0) then

               	   select id_bien_servicio into v_id from bien_servicio x where codigo_sap = cur_r.codigo_sap and tipo_item = cur_r.tipo_item;
               	   update bien_servicio
                        set descripcion=cur_r.descripcion,
                            id_rubro = v_id_rubro,
                            id_unidad_medida = v_id_unidad,
                            tipo_item = cur_r.tipo_item,
                            descripcion_larga = cur_r.descripcion
                    where id_bien_servicio =v_id;
               else
                   select bien_servicio_id_seq.nextval into v_id from dummy;
                    insert into bien_servicio(id_bien_servicio, codigo_sap, descripcion, tipo_item, id_rubro, id_unidad_medida, descripcion_larga)
                    values(
                        v_id,
                        cur_r.codigo_sap,
                        cur_r.descripcion,
                        cur_r.tipo_item,
                        v_id_rubro,
                        v_id_unidad,
                        cur_r.descripcion
                        );

               end if;

            end if;


        end if;

    end for;




END;