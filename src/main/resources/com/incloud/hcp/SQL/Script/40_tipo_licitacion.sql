update tipo_licitacion
set
peso_moneda = 80,
peso_condicion = 20,
peso_evaluacion_tecnica = 0,
ind_evaluacion_auto = '1'
where id_tipo_licitacion = 3;

update tipo_licitacion
set
peso_moneda = 30,
peso_condicion = 28,
peso_evaluacion_tecnica = 42,
ind_evaluacion_auto = '0'
where id_tipo_licitacion = 4;

update tipo_licitacion
set
peso_moneda = 50,
peso_condicion = 20,
peso_evaluacion_tecnica = 30,
ind_evaluacion_auto = '0'
where id_tipo_licitacion = 5;

update tipo_licitacion
set
peso_moneda = 30,
peso_condicion = 28,
peso_evaluacion_tecnica = 42,
ind_evaluacion_auto = '0'
where id_tipo_licitacion = 6;

update tipo_licitacion
set
peso_moneda = 30,
peso_condicion = 0,
peso_evaluacion_tecnica = 70,
ind_evaluacion_auto = '0'
where id_tipo_licitacion = 7;

update tipo_licitacion
set
peso_moneda = 100,
peso_condicion = 0,
peso_evaluacion_tecnica = 0,
ind_evaluacion_auto = '1'
where id_tipo_licitacion = 8;

commit;