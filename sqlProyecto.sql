CREATE DATABASE BINAES_DB;
GO
USE BINAES_DB;

CREATE TABLE PRESTAMO (
    id_Prestamo INT NOT NULL, 
    fh_Prestamo DATETIME NOT NULL,
    fh_Devolucion DATETIME NOT NULL,
    id_Estado INT NOT NULL,             -- fk
    id_UsuarioPresta INT NOT NULL,      -- fk
    id_Ejemplar INT NOT NULL            -- fk
);