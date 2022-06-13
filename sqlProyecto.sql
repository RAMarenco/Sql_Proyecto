CREATE DATABASE BINAES_DB;
GO
USE BINAES_DB;

CREATE TABLE USUARIO(
    id_Usuario VARCHAR(8),
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
    id_RolUsuario INT NOT NULL      --fk
);

CREATE TABLE PRESTAMO (
    id_Prestamo INT NOT NULL, 
    fh_Prestamo DATETIME NOT NULL,
    fh_Devolucion DATETIME NOT NULL,
    id_Estado INT NOT NULL,             -- fk
    id_UsuarioPresta INT NOT NULL,      -- fk
    id_Ejemplar INT NOT NULL            -- fk
);
