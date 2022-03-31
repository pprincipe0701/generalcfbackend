CREATE PROCEDURE SP_MIGRACION_RFC_CENTRO_ALMACEN()
LANGUAGE SQLSCRIPT SQL SECURITY INVOKER AS
BEGIN
    DECLARE v_count INTEGER := 0;
    DECLARE v_id INTEGER := 0;
    DECLARE v_id_padre INTEGER := 0;
    DECLARE CURSOR c_data FOR
         SELECT * FROM TEMP_CENTRO_ALMACEN;

    FOR cur_r as c_data DO

        SELECT count(1) into v_count from centro_almacen r
        where r.codigo_sap = cur_r.centro and r.nivel = 1;

        if (v_count > 0) then

            SELECT id_centro_almacen into v_id_padre from centro_almacen r
            where r.codigo_sap = cur_r.centro and r.nivel = 1;

            SELECT count(1) into v_count from centro_almacen r
        	where r.id_padre = v_id_padre
        	  and r.codigo_sap = cur_r.codigo_almacen
        	  and r.nivel = 2;


		    if (v_count <= 0) then
                select centro_almacen_id_seq.nextval into v_id from dummy;

                insert into centro_almacen(
                    id_centro_almacen,
                    codigo_sap,
                    denominacion,
                    nivel,
                    id_padre,
                    poblacion,
                    distrito,
                    direccion
                    )
                values(
                    v_id,
                    cur_r.codigo_almacen,
                    cur_r.descripcion_almacen,
                    2,
                    v_id_padre,
                    cur_r.poblacion,
                    cur_r.distrito,
                    cur_r.direccion);
           else

              SELECT id_centro_almacen into v_id from centro_almacen r
	        	where r.id_padre = v_id_padre
	        	  and r.codigo_sap = cur_r.codigo_almacen
	        	  and r.nivel = 2;

              update centro_almacen
              set denominacion = cur_r.descripcion_almacen,
                    poblacion = cur_r.poblacion,
                    distrito = cur_r.distrito,
                    direccion = cur_r.direccion
              where id_centro_almacen = v_id;
           end if;
      end if;
    end for;

END;