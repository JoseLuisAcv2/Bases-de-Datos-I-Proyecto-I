/* 
 * 		LABORATORIO DE BASES DE DATOS I - PROYECTO I
 *
 *		- Restricciones explicitas restantes
 *
 *		AUTORES
 *				- Augusto Hidalgo 13-10665
 *				- Jose Acevedo 13-10006
 *
 */
 
/*
 * Segunda y ultima modificacion de las tablas creadas inicialmente.
 * En este script se anaden las restricciones explicitas representables con el dominio
 * actual de postgreSQL (como es detallado en el informe).
 */ 

--Para todo tipo, su medida es null si y solo si su unidad de medida es null.
ALTER TABLE TIPO ADD CONSTRAINT EXP_TIPO_R01 check((medida is null) = (unidadMedida is null));

--Una PIEZA es una COMPONENTE o un PRODUCTO, pero no ambas.
ALTER TABLE PIEZA ADD CONSTRAINT EXP_TIPO_R02 check((codComp is null) != (codProd is null));

--Todas las COMPANIAS nacionales tienen rif y las internacionales no.
ALTER TABLE COMPANIA ADD CONSTRAINT EXP_COMPANIA_R03 check((rif is null) = (nacionalidad = 'Internacional'));

--Sólo los proveedores tienen e-mail.
ALTER TABLE COMPANIA ADD CONSTRAINT EXP_COMPANIA_R04 check((email is null) = (tipo = 'Distribuidor'));

--Todos los distribuidores son nacionales.
ALTER TABLE COMPANIA ADD CONSTRAINT EXP_COMPANIA_R05 check((tipo = 'Proveedor') or (nacionalidad = 'Nacional'));

--Si una componente tiene cantidad en bruto distinto a 0 entonces es de tipo procesada.
ALTER TABLE COMPONENTE ADD CONSTRAINT EXP_COMPONENTE_R06 check((cantBruto = 0) or (tipo = 'Procesada'));

--Las componentes compradas directamente sólo tienen cantidad en estado elaborado.
ALTER TABLE COMPONENTE ADD CONSTRAINT EXP_COMPONENTE_R07 check(not(tipo = 'Comprada directamente') or (cantBruto = 0 and cantProceso = 0));

--En una orden de compra la cantidad recibida es menor o igual a cantidad solicitada.
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT EXP_ORDEN_COMPRA_R08 check(cantRecibida <= cantSolicitada);

--Para toda orden de compra la fecha de entrega es posterior a la fecha de elaboración.
ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT EXP_ORDEN_COMPRA_R09 check(fechaElaboracion <= fechaEntrega);

--En una orden de ensamblaje la cantidad aprobada es menor o igual a cantidad a elaborar.
ALTER TABLE ORDEN_ENSAMBLAJE ADD CONSTRAINT EXP_ORDEN_ENSAMBLAJE_R10 check(cantAprobada <= cantElaborar);

--En una orden de taller la cantidad aprobada es menor o igual a cantidad a elaborar.
ALTER TABLE ORDEN_TALLER ADD CONSTRAINT EXP_ORDEN_TALLER_R11 check(cantAprobada <= cantElaborar);

--Para toda factura la fecha de vencimiento es posterior a la fecha de venta.
ALTER TABLE FACTURA ADD CONSTRAINT EXP_FACTURA_R12 check(fechaVenta < fechaVencimiento);

--El monto global de una factura es la suma de su monto total y el impuesto.
ALTER TABLE FACTURA ADD CONSTRAINT EXP_FACTURA_R13 check(montoGlobal = montoTotal + impuesto);
