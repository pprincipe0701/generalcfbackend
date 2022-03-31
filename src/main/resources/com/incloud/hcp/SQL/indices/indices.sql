--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      Usuario de Windows
-- Project :      modelo.dm1
-- Author :       Usuario de Windows
--
-- Date Created : Thursday, November 23, 2017 13:59:47
-- Target DBMS : IBM DB2 AS/400 4.x
--

-- 
-- INDEX: UX_BANCO_01 
--

CREATE UNIQUE INDEX UX_BANCO_01 ON banco(descripcion)
;
-- 
-- INDEX: UX_BIEN_SERVICIO_01 
--

CREATE UNIQUE INDEX UX_BIEN_SERVICIO_01 ON bien_servicio(codigo_sap)
;
-- 
-- INDEX: UX_CARGO_01 
--

CREATE UNIQUE INDEX UX_CARGO_01 ON cargo(cargo_nombre)
;
-- 
-- INDEX: IX_CCOMPARATIVO_01 
--

CREATE INDEX IX_CCOMPARATIVO_01 ON ccomparativo(id_licitacion)
;
-- 
-- INDEX: IX_CCOMPARATIVO_ADJUDICADO_01 
--

CREATE INDEX IX_CCOMPARATIVO_ADJUDICADO_01 ON ccomparativo_adjudicado(id_proveedor)
;
-- 
-- INDEX: IX_CCOMPARATIVO_ADJUDICADO_02 
--

CREATE INDEX IX_CCOMPARATIVO_ADJUDICADO_02 ON ccomparativo_adjudicado(id_ccomparativo)
;
-- 
-- INDEX: IX_CONDICION_LIC_RESPUESTA_01 
--

CREATE INDEX IX_CONDICION_LIC_RESPUESTA_01 ON condicion_lic_respuesta(id_condicion)
;
-- 
-- INDEX: UX_CONDICION_PAGO_01 
--

CREATE UNIQUE INDEX UX_CONDICION_PAGO_01 ON condicion_pago(codigo_sap)
;
-- 
-- INDEX: UX_CONDICION_PAGO_02 
--

CREATE UNIQUE INDEX UX_CONDICION_PAGO_02 ON condicion_pago(descripcion)
;
-- 
-- INDEX: IX_COTIZACION_01 
--

CREATE INDEX IX_COTIZACION_01 ON cotizacion(id_proveedor)
;
-- 
-- INDEX: IX_COTIZACION_02 
--

CREATE INDEX IX_COTIZACION_02 ON cotizacion(id_licitacion)
;
-- 
-- INDEX: IX_COTIZACION_ADJUNTO_01 
--

CREATE INDEX IX_COTIZACION_ADJUNTO_01 ON cotizacion_adjunto(id_cotizacion)
;
-- 
-- INDEX: IX_COTIZACION_DETALLE_01 
--

CREATE INDEX IX_COTIZACION_DETALLE_01 ON cotizacion_detalle(id_cotizacion)
;
-- 
-- INDEX: IX_HOMOLOGACION_01 
--

CREATE INDEX IX_HOMOLOGACION_01 ON homologacion(id_linea_comercial)
;
-- 
-- INDEX: PK24 
--

CREATE UNIQUE INDEX PK24 ON licitacion(nro_licitacion)
;
-- 
-- INDEX: IX_LICITACION_01 
--

CREATE INDEX IX_LICITACION_01 ON licitacion(estado_licitacion)
;
-- 
-- INDEX: IX_LICITACION_ADJUNTO_01 
--

CREATE INDEX IX_LICITACION_ADJUNTO_01 ON licitacion_adjunto(id_licitacion)
;
-- 
-- INDEX: IX_LICITACION_DETALLE_01 
--

CREATE INDEX IX_LICITACION_DETALLE_01 ON licitacion_detalle(id_licitacion)
;
-- 
-- INDEX: IX_LICITACION_DETALLE_02 
--

CREATE INDEX IX_LICITACION_DETALLE_02 ON licitacion_detalle(solicitud_pedido)
;
-- 
-- INDEX: IX_LICITACION_GRUPO_CONDICION_LIC_01 
--

CREATE INDEX IX_LICITACION_GRUPO_CONDICION_LIC_01 ON licitacion_grupo_condicion_lic(id_licitacion)
;
-- 
-- INDEX: UX_PROVEEDOR_01 
--

CREATE UNIQUE INDEX UX_PROVEEDOR_01 ON proveedor(ruc)
;
-- 
-- INDEX: UX_PROVEEDOR_02 
--

CREATE UNIQUE INDEX UX_PROVEEDOR_02 ON proveedor(razon_social)
;
-- 
-- INDEX: UX_PROVEEDOR_03 
--

CREATE UNIQUE INDEX UX_PROVEEDOR_03 ON proveedor(email);

CREATE INDEX IX_PROVEEDOR_04 ON proveedor(fecha_creacion)
;
-- 
-- INDEX: IX_PROVEEDOR_CANAL_CONTACTO_01 
--

CREATE INDEX IX_PROVEEDOR_CANAL_CONTACTO_01 ON proveedor_canal_contacto(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_CATALOGO_01 
--

CREATE INDEX IX_PROVEEDOR_CATALOGO_01 ON proveedor_catalogo(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_CANAL_BANCARIA_01 
--

CREATE INDEX IX_PROVEEDOR_CANAL_BANCARIA_01 ON proveedor_cuenta_bancaria(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_EVALUACION_01 
--

CREATE INDEX IX_PROVEEDOR_EVALUACION_01 ON proveedor_evaluacion(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_HOMOLOGACION_01 
--

CREATE INDEX IX_PROVEEDOR_HOMOLOGACION_01 ON proveedor_homologacion(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_LINEA_COMERCIAL_01 
--

CREATE INDEX IX_PROVEEDOR_LINEA_COMERCIAL_01 ON proveedor_linea_comercial(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_PRODUCTO_01 
--

CREATE INDEX IX_PROVEEDOR_PRODUCTO_01 ON proveedor_producto(id_proveedor)
;
-- 
-- INDEX: IX_PROVEEDOR_TIPO_RETENCION_01 
--

CREATE INDEX IX_PROVEEDOR_TIPO_RETENCION_01 ON proveedor_tipo_retencion(id_proveedor)
;
-- 
-- INDEX: UX_RUBRO_BIEN_01 
--

CREATE UNIQUE INDEX UX_RUBRO_BIEN_01 ON rubro_bien(codigo_sap)
;
-- 
-- INDEX: UX_SECTOR_TRABAJO_01 
--

CREATE UNIQUE INDEX UX_SECTOR_TRABAJO_01 ON sector_trabajo(descripcion)
;
-- 
-- INDEX: IX_SOLICITUD_ADJUNTO_BLACKLIST_01 
--

CREATE INDEX IX_SOLICITUD_ADJUNTO_BLACKLIST_01 ON solicitud_adjunto_blacklist(id_solicitud)
;
-- 
-- INDEX: IX_SOLICITUD_BLACKLIST_01 
--

CREATE INDEX IX_SOLICITUD_BLACKLIST_01 ON solicitud_blacklist(id_proveedor)
;
-- 
-- INDEX: UX_TIPO_COMPROBANTE_01 
--

CREATE INDEX UX_TIPO_COMPROBANTE_01 ON tipo_comprobante(descripcion)
;
-- 
-- INDEX: IX_TIPO_INFORMACION_NOTICIA_01 
--

CREATE INDEX IX_TIPO_INFORMACION_NOTICIA_01 ON tipo_informacion_noticia(descripcion)
;
-- 
-- INDEX: IX_TIPO_LICITACION_01 
--

CREATE INDEX IX_TIPO_LICITACION_01 ON tipo_licitacion(descripcion)
;
-- 
-- INDEX: UX_TIPO_PROVEEDOR_01 
--

CREATE UNIQUE INDEX UX_TIPO_PROVEEDOR_01 ON tipo_proveedor(codigo_sap)
;
-- 
-- INDEX: UX_UBIGEO_01 
--

CREATE UNIQUE INDEX UX_UBIGEO_01 ON ubigeo(codigo_ubigeo_sap)
;
-- 
-- INDEX: UX_UBIGEO_02 
--

CREATE UNIQUE INDEX UX_UBIGEO_02 ON ubigeo(descripcion)
;
-- 
-- INDEX: UX_UNIDAD_MEDIDA_01 
--

CREATE UNIQUE INDEX UX_UNIDAD_MEDIDA_01 ON unidad_medida(codigo_sap)
;
-- 
-- INDEX: UX_USUARIO_01 
--

CREATE UNIQUE INDEX UX_USUARIO_01 ON usuario(codigo_sap)
;
