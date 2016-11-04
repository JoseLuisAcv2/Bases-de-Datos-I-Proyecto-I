/* 
 * 		LABORATORIO DE BASES DE DATOS I - PROYECTO I
 *
 *		- Creación de tablas
 *		- Restricciones de clave primaria
 *		- Restricciones de no-nulidad
 *
 *		AUTORES
 *				- Augusto Hidalgo 13-10665
 *				- Jose Acevedo 13-10006
 *
 */

/*
 * Script que crea las tablas correspondientes a las relaciones
 * especificadas en el diseno logico. Especificando el tipo de cada
 * atributo y cuales atributos no pueden tomar el valor de null.
 */

CREATE TYPE generoTipoType AS ENUM ('Producto', 'Componente');
CREATE TYPE tipoComponenteType AS ENUM ('Comprada directamente', 'Manufacturada', 'Procesada');
CREATE TYPE familiaProductoType AS ENUM ('Sumergible', 'Centrífuga', 'Turbina', 'Autocebante');
CREATE TYPE tipoProductoType AS ENUM ('Bomba', 'Cuerpo de bomba');
CREATE TYPE tipoCompaniaType AS ENUM ('Proveedor', 'Distribuidor');
CREATE TYPE nacionalidadCompaniaType AS ENUM ('Nacional', 'Internacional');
CREATE TYPE modalidadPagoType AS ENUM ('Contado', 'Crédito 15 días', 'Crédito 30 días', 'Crédito 45 días', 'Credito 60 días');

CREATE TABLE TIPO (
	codTipo 				NUMERIC(10) 				NOT NULL,
	precioVenta				NUMERIC(10) 				NOT NULL,
	genero 					GENEROTIPOTYPE				NOT NULL,
	modelo					VARCHAR(40) 				NOT NULL,
	medida					NUMERIC(15,5),
	unidadMedida			VARCHAR(10),
	CONSTRAINT PK_TIPO PRIMARY KEY(codTipo)
);

CREATE TABLE COMPONENTE (
	codComp					NUMERIC(10)					NOT NULL,
	descripcion				TEXT						NOT NULL,
	cantBruto				NUMERIC(10)					NOT NULL,
	cantProceso				NUMERIC(10)					NOT NULL,
	cantElaborado			NUMERIC(10)					NOT NULL,
	tipo					TIPOCOMPONENTETYPE			NOT NULL,
	CONSTRAINT PK_COMPONENTE PRIMARY KEY(codComp)
);

CREATE TABLE PRODUCTO (
	codProd					NUMERIC(10)					NOT NULL,
	cantProceso				NUMERIC(10)					NOT NULL,
	cantTerminado			NUMERIC(10)					NOT NULL,
	tipo					TIPOPRODUCTOTYPE			NOT NULL,
	familia					FAMILIAPRODUCTOTYPE			NOT NULL,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY(codProd)
);

CREATE TABLE PIEZA (
	clavePieza				SERIAL						NOT NULL,
	codComp					NUMERIC(10),
	codProd					NUMERIC(10),
	CONSTRAINT PK_PIEZA PRIMARY KEY(clavePieza)
);

CREATE TABLE ES_USADA (
	codProd					NUMERIC(10) 				NOT NULL,
	clavePieza				INTEGER						NOT NULL,
	cantidad				NUMERIC(10)					NOT NULL,
	CONSTRAINT PK_ES_USADA PRIMARY KEY(codProd, clavePieza)
);

CREATE TABLE COMPANIA (
	codCompania				NUMERIC(20)					NOT NULL,
	nombre					VARCHAR(40)					NOT NULL,
	direccion				TEXT						NOT NULL,
	personaContacto			VARCHAR(40)					NOT NULL,
	tipo					TIPOCOMPANIATYPE			NOT NULL,
	nacionalidad			NACIONALIDADCOMPANIATYPE	NOT NULL,
	rif						VARCHAR(30),
	email					VARCHAR(30),
	CONSTRAINT PK_COMPANIA PRIMARY KEY(CodCompania)
);

CREATE TABLE TELEFONO (
	codCompania				NUMERIC(20)					NOT NULL,
	telefono				VARCHAR(12)					NOT NULL,
	CONSTRAINT PK_TELEFONO PRIMARY KEY(codCompania, telefono)
);

CREATE TABLE FACTURA (
	numFactura				NUMERIC(25)					NOT NULL,
	codCompania				NUMERIC(20)					NOT NULL,
	fechaVenta				DATE						NOT NULL,
	fechaVencimiento		DATE						NOT NULL,
	modalidadPago			MODALIDADPAGOTYPE			NOT NULL,
	impuesto				NUMERIC(20)					NOT NULL,
	montoTotal				NUMERIC(20)					NOT NULL,
	montoGlobal				NUMERIC(20)					NOT NULL,
	CONSTRAINT PK_FACTURA PRIMARY KEY(numFactura)
);

CREATE TABLE BOMBA_FISICA (
	serial					NUMERIC(20)					NOT NULL,
	durGarantia				NUMERIC(7)					NOT NULL,
	numFactura				NUMERIC(25)					NOT NULL,
	codProd					NUMERIC(10)					NOT NULL,
	CONSTRAINT PK_BOMBA_FISICA PRIMARY KEY(serial)
);

CREATE TABLE SE_VENDE_EN (
	codComp					NUMERIC(10)					NOT NULL,
	numFactura				NUMERIC(25)					NOT NULL,
	cantidad				NUMERIC(12)					NOT NULL,
	CONSTRAINT PK_SE_VENDE_EN PRIMARY KEY(codComp, numFactura)
);

CREATE TABLE MATERIA_PRIMA (
	codPrima				NUMERIC(10)					NOT NULL,
	descripcion				TEXT						NOT NULL,
	CONSTRAINT PK_MATERIA_PRIMIA PRIMARY KEY(codPrima)
);

CREATE TABLE ORDEN_ENSAMBLAJE (
	nroCorrelativo 			NUMERIC(20)					NOT NULL,
	codProd					NUMERIC(10)					NOT NULL,
	cantElaborar			NUMERIC(10)					NOT NULL,
	cantAprobada			NUMERIC(10)					NOT NULL,
	fecha					DATE						NOT NULL,
	CONSTRAINT PK_ORDEN_ENSAMBLAJE PRIMARY KEY(nroCorrelativo)
);

CREATE TABLE ORDEN_TALLER (
	nroCorrelativo 			NUMERIC(20)					NOT NULL,
	codComp					NUMERIC(10)					NOT NULL,
	cantElaborar			NUMERIC(10)					NOT NULL,
	cantAprobada			NUMERIC(10)					NOT NULL,
	fecha					DATE						NOT NULL,
	CONSTRAINT PK_ORDEN_TALLER PRIMARY KEY(nroCorrelativo)
);

CREATE TABLE ORDEN_COMPRA (
	nroCorrelativo 			NUMERIC(20)					NOT NULL,
	codComp					NUMERIC(10),
	codPrima				NUMERIC(10),
	codCompania				NUMERIC(20)					NOT NULL,
	cantSolicitada			NUMERIC(10)					NOT NULL,
	cantRecibida			NUMERIC(10)					NOT NULL,
	fechaElaboracion		DATE						NOT NULL,
	fechaEntrega			DATE						NOT NULL,
	costoPorUnidad			NUMERIC(10)					NOT NULL,
	CONSTRAINT PK_ORDEN_COMPRA PRIMARY KEY(nroCorrelativo)
);

CREATE TABLE COMPUESTA_POR (
	codComp					NUMERIC(10)					NOT NULL,
	codPrima				NUMERIC(10)					NOT NULL,
	cantidad				NUMERIC(10)					NOT NULL,
	CONSTRAINT PK_COMPUESTA_POR PRIMARY KEY(codComp, codPrima)
);
