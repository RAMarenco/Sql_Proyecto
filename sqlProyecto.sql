CREATE DATABASE BINAES_DB;
GO
USE BINAES_DB;

--CREACION TABLAS--

CREATE TABLE USUARIO(
    id_Usuario VARCHAR(8) NOT NULL,     -- pk
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
    id_rolUsuario INT NOT NULL,         -- fk
    contrasena BINARY(256) NOT NULL
);

CREATE TABLE TOKEN(
    id_Token INT NOT NULL,
    TOKEN BINARY(64) NOT NULL,
    id_Usuario VARCHAR(8) NOT NULL,     --fk
    fh_Expiracion DATETIME NOT NULL
);

CREATE TABLE ROLUSUARIO(
    id_rolUsuario INT NOT NULL,         -- pk
    rol VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE VISITAS(
    id_Visita INT NOT NULL,             -- pk
    id_Usuario VARCHAR(8) NOT NULL,     -- fk
    id_Area INT NOT NULL,               -- fk
    fh_entrada DATETIME NOT NULL,
    fh_salida DATETIME NOT NULL
);

CREATE TABLE AREA(
    id_Area INT NOT NULL,               -- pk
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL,
    id_tipoArea INT NOT NULL,           -- fk
    responsable VARCHAR(8) NOT NULL,    -- fk
    id_pisoArea INT NOT NULL,           -- fk
);

CREATE TABLE HORARIOxAREA(
    id_Horario INT NOT NULL,            -- pk
    horaAbierto TIME NOT NULL,
    horaCierre  TIME NOT NULL,
    id_Area INT NOT NULL                -- fk
);

CREATE TABLE TIPOAREA(
    id_tipoArea INT NOT NULL,           -- pk
    tipoArea VARCHAR(30)                -- fk
);

CREATE TABLE PISOAREA(
    id_pisoArea INT NOT NULL,           -- pk
    pisoArea VARCHAR(10)
);

CREATE TABLE EVENTO(
    id_Evento INT NOT NULL,             -- pk
    titulo VARCHAR(100) NOT NULL,
    imagen VARBINARY(MAX) NOT NULL,
    capacidad INT NOT NULL,
    id_areaRealizacion INT NOT NULL,    -- fk
    fh_Inicio DATETIME NOT NULL,
    fh_Finalizacion DATETIME NOT NULL
);

CREATE TABLE OBJETIVOSxEVENTO(
    id_Objetivo INT NOT NULL,           -- pk
    Objetivo TEXT NOT NULL,
    id_Evento INT NOT NULL              -- fk
);

CREATE TABLE PRESTAMO (
    id_Prestamo INT NOT NULL,           -- pk
    fh_Prestamo DATETIME NOT NULL,
    fh_Devolucion DATETIME NOT NULL,
    id_Estado INT NOT NULL,              -- fk
    id_usuarioPresta VARCHAR(8) NOT NULL,-- fk
    id_Ejemplar INT NOT NULL             -- fk
);

CREATE TABLE RESERVA (
    id_Reserva INT NOT NULL,            -- pk
    fh_Reserva DATETIME NOT NULL,
    id_Prestamo INT NOT NULL            -- fk
);

CREATE TABLE ESTADOS (
    id_Estado INT NOT NULL,
    estado VARCHAR(20) NOT NULL,
);

CREATE TABLE EJEMPLAR (
    id_Ejemplar INT NOT NULL,           -- pk
    nombre VARCHAR(100) NOT NULL,
    imagen VARBINARY(MAX) NOT NULL,
    id_Editorial INT NOT NULL,          -- fk
    id_Formato INT NOT NULL,            -- fk
    id_Idioma INT NOT NULL,             -- fk
    f_publicacion DATE NOT NULL,
    id_coleccionPertenece INT NOT NULL  -- fk
);

CREATE TABLE AUTORxEJEMPLAR (
    id_Autor INT NOT NULL,              -- pk
    nombre VARCHAR(50) NOT NULL,
    id_Ejemplar INT NOT NULL            -- fk
);

CREATE TABLE P_CLAVExEJEMPLAR (
    id_p_Clave INT NOT NULL,            -- pk
    p_clave VARCHAR(30) NOT NULL,
    id_Ejemplar INT NOT NULL            -- fk
);

CREATE TABLE ETIQUETASxEJEMPLAR (
    id_etiquetaEjemplar INT NOT NULL,    -- pk
    id_Etiqueta INT NOT NULL,            -- fk
    id_Ejemplar INT NOT NULL             -- fk
);

CREATE TABLE ETIQUETA (
    id_Etiqueta INT NOT NULL,            -- pk
    etiqueta VARCHAR(30) NOT NULL
);

CREATE TABLE EDITORIAL (
    id_Editorial INT NOT NULL,           -- pk
    editorial VARCHAR(60) NOT NULL
);

CREATE TABLE FORMATOEJEMPLAR (
    id_formatoEjemplar INT NOT NULL,     -- pk
    formato VARCHAR(30) NOT NULL  
);

CREATE TABLE IDIOMAEJEMPLAR (
    id_idiomaEjemplar INT NOT NULL,      -- pk
    idioma VARCHAR(30) NOT NULL
);

CREATE TABLE COLECCION (
    id_Coleccion INT NOT NULL,           -- pk
    nombre VARCHAR(50) NOT NULL,
    id_tipoColeccion INT NOT NULL,       -- fk
    id_Genero INT NOT NULL,              -- fk
    id_areaPertenece INT NOT NULL        -- fk
);

CREATE TABLE TIPOCOLECCION (
    id_tipoColeccion INT NOT NULL,       -- pk
    tipoColeccion VARCHAR(30)
);

CREATE TABLE GENEROCOLECCION (
    id_generoColeccion INT NOT NULL,     -- pk
    generoColeccion VARCHAR(30) NOT NULL
);

