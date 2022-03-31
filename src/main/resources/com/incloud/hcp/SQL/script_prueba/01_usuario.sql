DEV
===

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion,codigo_usuario_idp)
values
(1, 'cbazalar@csticorp.biz', 'Carlos','Bazalar', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 1, 1, 'P000064');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(2, 'pprincipe.cons@gmail.com', 'Pavel','Principe', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 1, 1, 'P000065');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(3, 'gespinoza@csticorp.biz', 'Gustavo','Espinoza CSTI', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 1, 1, 'P000081');



select * from linea_comercial x
where x.nivel = 2


insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(1, 1, 1, 1847);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(2, 1, 1, 1848);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(3, 1, 1, 1849);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(4, 1, 1, 1850);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(5, 1, 2, 1850);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(6, 1, 2, 1860);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(7, 1, 2, 1861);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(8, 1, 2, 1848);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(9, 1, 3, 1847);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(10, 1, 3, 1848);



QAS
===
insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion,codigo_usuario_idp)
values
(1, 'cbazalar@csticorp.biz', 'Carlos','Bazalar', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000064');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(2, 'pprincipe.cons@gmail.com', 'Pavel','Principe', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000065');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(3, 'gespinoza@csticorp.biz', 'Gustavo','Espinoza CSTI', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000081');


insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(4, 'comprador1@yopmail.com', 'Comprador1','Comprador1', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000096');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(5, 'comprador2@yopmail.com', 'Comprador2','Comprador2', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000097');

insert into usuario (id_usuario, email, nombre, apellido, fecha_creacion, id_cargo, usuario_creacion, codigo_usuario_idp)
values
(6, 'comprador3@yopmail.com', 'Comprador3','Comprador3', utctolocal(CURRENT_TIMESTAMP, 'UTC-5'), 437, 1, 'P000098');



insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(1, 1, 1, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(2, 1, 1, 240);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(3, 1, 1, 245);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(4, 1, 1, 360);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(5, 1, 2, 240);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(6, 1, 2, 360);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(7, 1, 2, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(8, 1, 2, 245);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(9, 1, 3, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(10, 1, 3, 245);

insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(11, 1, 4, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(12, 1, 4, 245);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(13, 1, 5, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(14, 1, 5, 245);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(15, 1, 6, 205);
insert into usuario_linea_comercial(id_usuario_linea_comercial, activo, id_usuario, id_linea_comercial)
values(16, 1, 6, 245);

update usuario_linea_comercial
set id_linea_comercial = 4
where id_linea_comercial = 205;

update usuario_linea_comercial
set id_linea_comercial = 5
where id_linea_comercial = 245;

update usuario_linea_comercial
set id_linea_comercial = 6
where id_linea_comercial = 240;

update usuario_linea_comercial
set id_linea_comercial = 7
where id_linea_comercial = 360;