delete from usuario_linea_comercial where id_usuario = 19
and id_linea_comercial in (29,30)

select * from usuario where id_usuario = 27


select * from usuario_linea_comercial where id_usuario = 20

insert into usuario(id_usuario, nombre, apellido, email, fecha_creacion, usuario_creacion, id_cargo)
select usuario_id_seq.nextval, 'Daniel', 'Borbor'	,'dborborn@san-fernando.com.pe'
, utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 1, 1 from dummy


insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_linea_comercial, id_usuario)
select seq_usuario_linea_comercial.nextval, '1', id_linea_comercial, 27 from linea_comercial x
where codigo_grupo_comercial in (
'190',
'290'
)

update usuario
set codigo_usuario_idp = 'P000253'
where email = 'dborborn@san-fernando.com.pe'


select * from linea_comercial x
where codigo_grupo_comercial in (
'305',
'335'
)
