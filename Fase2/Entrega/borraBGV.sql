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
 * Sencillo script que borra toda la base de datos.
 * El orden de los DROP es el adecuado para que no presente problemas,
 * dicho orden no intenta borrar tablas que siguen siendo referenciadas
 * por otra tabla.
 *
 */

DROP TABLE IF EXISTS COMPUESTA_POR;
DROP TABLE IF EXISTS ORDEN_COMPRA;
DROP TABLE IF EXISTS ORDEN_TALLER;
DROP TABLE IF EXISTS ORDEN_ENSAMBLAJE;
DROP TABLE IF EXISTS MATERIA_PRIMA;
DROP TABLE IF EXISTS SE_VENDE_EN;
DROP TABLE IF EXISTS BOMBA_FISICA;
DROP TABLE IF EXISTS FACTURA;
DROP TABLE IF EXISTS TELEFONO;
DROP TABLE IF EXISTS COMPANIA;
DROP TABLE IF EXISTS ES_USADA;
DROP TABLE IF EXISTS PIEZA;
DROP TABLE IF EXISTS PRODUCTO;
DROP TABLE IF EXISTS COMPONENTE;
DROP TABLE IF EXISTS TIPO;
DROP TYPE IF EXISTS modalidadPagoType;
DROP TYPE IF EXISTS nacionalidadCompaniaType;
DROP TYPE IF EXISTS tipoCompaniaType;
DROP TYPE IF EXISTS tipoComponenteType;
DROP TYPE IF EXISTS generoTipoType;
DROP TYPE IF EXISTS familiaProductoType;
DROP TYPE IF EXISTS tipoProductoType;
