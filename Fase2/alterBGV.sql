/* 
 * 		LABORATORIO DE BASES DE DATOS I - PROYECTO I
 *
 *		- Restricciones de integridad referencial
 *		- Restricciones de integridad de identidad de claves alternas
 *		- Restricciones de dominio de atributos
 *
 *		AUTORES
 *				- Augusto Hidalgo 13-10665
 *				- Jose Acevedo 13-10006
 *
 */
 
/*
 * Script que anade a la definicion de las tablas previamente creadas las restricciones correspondientes
 * a integridad referencial, unicidad de claves alternas y restricciones sobre el dominio de los atributos
 * que no fueron cubiertas con la declaracion del tipo de dato del atributo.
 *
 */
 
-- Claves foráneas
ALTER TABLE COMPONENTE ADD CONSTRAINT FK_COMPONENTE_TIPO FOREIGN KEY(codComp) REFERENCES TIPO ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PRODUCTO ADD CONSTRAINT FK_PRODUCTO_TIPO FOREIGN KEY(codProd) REFERENCES TIPO ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PIEZA ADD CONSTRAINT FK_PIEZA_COMPONENTE FOREIGN KEY(codComp) REFERENCES COMPONENTE ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE PIEZA ADD CONSTRAINT FK_PIEZA_PRODUCTO FOREIGN KEY(codProd) REFERENCES PRODUCTO ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ES_USADA ADD CONSTRAINT FK_ES_USADA_PRODUCTO FOREIGN KEY(codProd) REFERENCES PRODUCTO ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ES_USADA ADD CONSTRAINT FK_ES_USADA_PIEZA FOREIGN KEY(clavePieza) REFERENCES PIEZA ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TELEFONO ADD CONSTRAINT FK_TELEFONO_COMPANIA FOREIGN KEY(codCompania) REFERENCES COMPANIA ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FACTURA ADD CONSTRAINT FK_FACTURA_COMPANIA FOREIGN KEY(codCompania) REFERENCES COMPANIA ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE BOMBA_FISICA ADD CONSTRAINT FK_BOMBA_FISICA_FACTURA FOREIGN KEY(numFactura) REFERENCES FACTURA ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE BOMBA_FISICA ADD CONSTRAINT FK_BOMBA_FISICA_PRODUCTO FOREIGN KEY(codProd) REFERENCES PRODUCTO ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SE_VENDE_EN ADD CONSTRAINT FK_SE_VENDE_EN_COMPONENTE FOREIGN KEY(codComp) REFERENCES COMPONENTE ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE SE_VENDE_EN ADD CONSTRAINT FK_SE_VENDE_EN_FACTURA FOREIGN KEY(numFactura) REFERENCES FACTURA ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ORDEN_ENSAMBLAJE ADD CONSTRAINT FK_ORDEN_ENSAMBLAJE_PRODUCTO FOREIGN KEY(codProd) REFERENCES PRODUCTO ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ORDEN_TALLER ADD CONSTRAINT FK_ORDEN_TALLER_COMPONENTE FOREIGN KEY(codComp) REFERENCES COMPONENTE ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT FK_ORDEN_COMPRA_COMPONENTE FOREIGN KEY(codComp) REFERENCES COMPONENTE ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT FK_ORDEN_COMPRA_MATERIA_PRIMA FOREIGN KEY(codPrima) REFERENCES MATERIA_PRIMA ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT FK_ORDEN_COMPRA_COMPANIA FOREIGN KEY(codCompania) REFERENCES COMPANIA ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE COMPUESTA_POR ADD CONSTRAINT FK_COMPUESTA_POR_COMPONENTE FOREIGN KEY(codComp) REFERENCES COMPONENTE ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE COMPUESTA_POR ADD CONSTRAINT FK_COMPUESTA_POR_MATERIA_PRIMA FOREIGN KEY(codPrima) REFERENCES MATERIA_PRIMA ON DELETE CASCADE ON UPDATE CASCADE;

-- Claves alternas
ALTER TABLE COMPANIA ADD CONSTRAINT AK_COMPANIA UNIQUE(rif);

-- Dominio de atributos
ALTER TABLE TIPO ADD CONSTRAINT DOM_TIPO_codTipo 						check(codTipo >= 0);
ALTER TABLE TIPO ADD CONSTRAINT DOM_TIPO_precioVenta 					check(precioVenta > 0);
ALTER TABLE TIPO ADD CONSTRAINT DOM_TIPO_medida		 					check(medida > 0);

ALTER TABLE COMPONENTE ADD CONSTRAINT DOM_COMPONENTE_codTipo 			check(codComp >= 0);
ALTER TABLE COMPONENTE ADD CONSTRAINT DOM_COMPONENTE_cantBruto 			check(cantBruto >= 0);
ALTER TABLE COMPONENTE ADD CONSTRAINT DOM_COMPONENTE_cantProceso 		check(cantProceso >= 0);
ALTER TABLE COMPONENTE ADD CONSTRAINT DOM_COMPONENTE_cantElaborado 		check(cantElaborado >= 0);

ALTER TABLE PRODUCTO ADD CONSTRAINT DOM_PRODUCTO_codTipo 				check(codProd >= 0);
ALTER TABLE PRODUCTO ADD CONSTRAINT DOM_PRODUCTO_cantProceso 			check(cantProceso >= 0);
ALTER TABLE PRODUCTO ADD CONSTRAINT DOM_PRODUCTO_cantTerminado 			check(cantTerminado >= 0);

ALTER TABLE ES_USADA ADD CONSTRAINT DOM_ES_USADA_cantidad				check(cantidad > 0);

ALTER TABLE COMPANIA ADD CONSTRAINT DOM_COMPANIA_codCompania			check(codCompania > 0);
ALTER TABLE COMPANIA ADD CONSTRAINT DOM_COMPANIA_email 					check(email LIKE '_%@_%._%');
ALTER TABLE COMPANIA ADD CONSTRAINT DOM_COMPANIA_rif 					check(rif SIMILAR TO '[VEJPG][0-9]{9}');

ALTER TABLE FACTURA ADD CONSTRAINT DOM_FACTURA_numFactura				check(numFactura > 0);
ALTER TABLE FACTURA ADD CONSTRAINT DOM_FACTURA_impuesto					check(impuesto > 0);
ALTER TABLE FACTURA ADD CONSTRAINT DOM_FACTURA_montoTotal				check(montoTotal > 0);
ALTER TABLE FACTURA ADD CONSTRAINT DOM_FACTURA_montoGlobal				check(montoGlobal > 0);

ALTER TABLE BOMBA_FISICA ADD CONSTRAINT DOM_BOMBA_FISICA_serial			check(serial > 0);
ALTER TABLE BOMBA_FISICA ADD CONSTRAINT DOM_BOMBA_FISICA_durGarantia	check(durGarantia > 0);

ALTER TABLE SE_VENDE_EN ADD CONSTRAINT DOM_SE_VENDE_EN_cantidad			check(cantidad > 0);

ALTER TABLE MATERIA_PRIMA ADD CONSTRAINT DOM_MATERIA_PRIMA_codPrima 	check(codPrima >= 0);

ALTER TABLE ORDEN_ENSAMBLAJE ADD CONSTRAINT DOM_ORDEN_ENSAMBLAJE_nroCorrelativo	check(nroCorrelativo >= 0);
ALTER TABLE ORDEN_ENSAMBLAJE ADD CONSTRAINT DOM_ORDEN_ENSAMBLAJE_cantElaborar	check(cantElaborar > 0);
ALTER TABLE ORDEN_ENSAMBLAJE ADD CONSTRAINT DOM_ORDEN_ENSAMBLAJE_cantAprobada	check(cantAprobada > 0);

ALTER TABLE ORDEN_TALLER ADD CONSTRAINT DOM_ORDEN_TALLER_nroCorrelativo	check(nroCorrelativo >= 0);
ALTER TABLE ORDEN_TALLER ADD CONSTRAINT DOM_ORDEN_TALLER_cantElaborar	check(cantElaborar > 0);
ALTER TABLE ORDEN_TALLER ADD CONSTRAINT DOM_ORDEN_TALLER_cantAprobada	check(cantAprobada > 0);

ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT DOM_ORDEN_COMPRA_nroCorrelativo	check (nroCorrelativo >= 0);
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT DOM_ORDEN_COMPRA_cantSolicitada	check(cantSolicitada > 0);
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT DOM_ORDEN_COMPRA_cantRecibida	check(cantRecibida > 0);
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT DOM_ORDEN_COMPRA_costoPorUnidad check(costoPorUnidad > 0);

ALTER TABLE COMPUESTA_POR ADD CONSTRAINT DOM_COMPUESTA_POR_cantidad		check(cantidad > 0);
