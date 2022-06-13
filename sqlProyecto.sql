CREATE DATABASE BINAES_DB;
GO
USE BINAES_DB;

--CREACION TABLAS--

CREATE TABLE USUARIO(
    id_Usuario VARCHAR(8) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(50) 
        NOT NULL 
		UNIQUE
		CHECK(email LIKE '%@%'),
    telefono CHAR(12) 
		NOT NULL 
		UNIQUE
		CHECK(telefono LIKE '+503[2|6|7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    ocupacion VARCHAR(15) NOT NULL,
    direccion VARCHAR(100) NOT NULL 
		DEFAULT 'Dirección no disponible',
    fotografia VARBINARY(MAX) NOT NULL,
    institucion VARCHAR(50) NOT NULL,
    id_RolUsuario INT NOT NULL          -- fk
);

CREATE TABLE ROLUSUARIO(
    id_RolUsuario INT,
    rol VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE VISITAS(
    id_Usuario INT NOT NULL,            -- fk
    id_Area INT NOT NULL                -- fk
);

CREATE TABLE AREA(
    id_Area INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL,
    id_TipoArea INT NOT NULL,           -- fk
    responsable INT NOT NULL,           -- fk
    id_PisoArea INT NOT NULL,           -- fk
);

CREATE TABLE PRESTAMO (
    id_Prestamo INT NOT NULL, 
    fh_Prestamo DATETIME NOT NULL,
    fh_Devolucion DATETIME NOT NULL,
    id_Estado INT NOT NULL,             -- fk
    id_UsuarioPresta INT NOT NULL,      -- fk
    id_Ejemplar INT NOT NULL            -- fk
);

CREATE TABLE RESERVA (
    id_Reserva INT NOT NULL,
    fh_Reserva DATETIME NOT NULL,
    id_Prestamo INT NOT NULL            -- fk
);