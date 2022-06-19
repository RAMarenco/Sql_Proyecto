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
    id_rolUsuario INT 
        NOT NULL
        DEFAULT 0,                     -- fk
    contrasena VARBINARY(256) NOT NULL
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
    responsable VARCHAR(8) 
        NOT NULL 
        DEFAULT '00000000',             -- fk
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
    aprobado BIT,
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
    id_autorEjemplar INT NOT NULL,      -- pk
    id_Autor INT NOT NULL,              -- fk
    id_Ejemplar INT NOT NULL            -- fk
);

CREATE TABLE AUTOR (
    id_Autor INT NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE P_CLAVExEJEMPLAR (
    id_p_Clave INT NOT NULL,            -- pk
    p_clave VARCHAR(30) NOT NULL,
    id_Ejemplar INT NOT NULL            -- fk
);

CREATE TABLE ETIQUETASxEJEMPLAR (
    id_etiquetaEjemplar INT NOT NULL,    -- pk
    id_tipoEtiqueta INT NOT NULL,        -- fk
    id_Ejemplar INT NOT NULL             -- fk
);

CREATE TABLE TIPOETIQUETA (
    id_tipoEtiqueta INT NOT NULL,         -- pk
    tipoEtiqueta VARCHAR(4) NOT NULL
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
    id_Coleccion INT NOT NULL,                  -- pk
    nombre VARCHAR(50) NOT NULL,
    id_tipoColeccion INT NOT NULL,              -- fk
    id_generoColeccion INT NOT NULL,            -- fk
    id_areaPertenece INT NOT NULL DEFAULT 0     -- fk
);

CREATE TABLE TIPOCOLECCION (
    id_tipoColeccion INT NOT NULL,       -- pk
    tipoColeccion VARCHAR(30)
);

CREATE TABLE GENEROCOLECCION (
    id_generoColeccion INT NOT NULL,     -- pk
    generoColeccion VARCHAR(30) NOT NULL
);

--AGREGANDO PKs y FKs TABLAS--

ALTER TABLE ROLUSUARIO ADD
    CONSTRAINT pk_rolUsuario
        PRIMARY KEY(id_rolUsuario);

ALTER TABLE USUARIO ADD 
    CONSTRAINT pk_usuario
        PRIMARY KEY (id_Usuario),
    CONSTRAINT fk_usuario_rolUsuario
        FOREIGN KEY (id_rolUsuario) 
        REFERENCES ROLUSUARIO (id_rolUsuario)
            ON DELETE SET DEFAULT
            ON UPDATE CASCADE;

ALTER TABLE TOKEN ADD 
    CONSTRAINT pk_token
        PRIMARY KEY (id_Token),
    CONSTRAINT fk_token_usuario
        FOREIGN KEY (id_Usuario)
        REFERENCES USUARIO (id_Usuario)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE TIPOAREA ADD
    CONSTRAINT pk_tipoArea
        PRIMARY KEY (id_tipoArea);

ALTER TABLE PISOAREA ADD
    CONSTRAINT pk_pisoArea
        PRIMARY KEY (id_pisoArea);

ALTER TABLE AREA ADD
    CONSTRAINT pk_area
        PRIMARY KEY (id_Area),
    CONSTRAINT fk_area_tipoArea
        FOREIGN KEY (id_tipoArea)
        REFERENCES TIPOAREA (id_tipoArea)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_area_responsable
        FOREIGN KEY (responsable)
        REFERENCES USUARIO (id_Usuario)
            ON DELETE SET DEFAULT
            ON UPDATE CASCADE,
    CONSTRAINT fk_area_pisoArea
        FOREIGN KEY (id_pisoArea)
        REFERENCES PISOAREA (id_pisoArea)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE HORARIOxAREA ADD
    CONSTRAINT pk_horarioxarea
        PRIMARY KEY (id_Horario),
    CONSTRAINT fk_horarioxarea_area
        FOREIGN KEY (id_Area)
        REFERENCES AREA (id_Area)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE VISITAS ADD
    CONSTRAINT pk_visitas
        PRIMARY KEY (id_Visita),
    CONSTRAINT fk_visitas_usuario
        FOREIGN KEY (id_Usuario)
        REFERENCES USUARIO (id_Usuario)
            ON DELETE NO ACTION
	        ON UPDATE CASCADE,
    CONSTRAINT fk_visitas_area
        FOREIGN KEY (id_Area)
        REFERENCES AREA (id_Area)
            ON DELETE NO ACTION
	        ON UPDATE NO ACTION;

ALTER TABLE EVENTO ADD
    CONSTRAINT pk_evento
        PRIMARY KEY (id_Evento),
    CONSTRAINT fk_evento_areaRealizacion
        FOREIGN KEY (id_areaRealizacion)
        REFERENCES AREA (id_Area)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE OBJETIVOSxEVENTO ADD
    CONSTRAINT pk_objetivosxarea
        PRIMARY KEY (id_Objetivo),
    CONSTRAINT fk_objetivosxarea_evento
        FOREIGN KEY (id_Evento)
        REFERENCES EVENTO (id_Evento)
            ON DELETE CASCADE
            ON UPDATE CASCADE;


ALTER TABLE TIPOCOLECCION ADD 
    CONSTRAINT pk_tipoColeccion
        PRIMARY KEY (id_tipoColeccion);
    
ALTER TABLE GENEROCOLECCION ADD
    CONSTRAINT pk_generoColeccion
        PRIMARY KEY (id_generoColeccion);

ALTER TABLE COLECCION ADD
    CONSTRAINT pk_Coleccion
        PRIMARY KEY (id_Coleccion),
    CONSTRAINT fk_coleccion_tipoColeccion
        FOREIGN KEY (id_tipoColeccion)
        REFERENCES TIPOCOLECCION (id_tipoColeccion)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_coleccion_generoColeccion
        FOREIGN KEY (id_generoColeccion)
        REFERENCES GENEROCOLECCION (id_generoColeccion)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_coleccion_area
        FOREIGN KEY (id_areaPertenece)
        REFERENCES AREA (id_Area)
            ON DELETE SET DEFAULT
            ON UPDATE CASCADE;

ALTER TABLE AUTOR ADD
    CONSTRAINT pk_Autor
        PRIMARY KEY (id_Autor);

ALTER TABLE TIPOETIQUETA ADD
    CONSTRAINT pk_tipoEtiqueta
        PRIMARY KEY (id_tipoEtiqueta);

ALTER TABLE EDITORIAL ADD
    CONSTRAINT pk_Editorial
        PRIMARY KEY (id_Editorial);

ALTER TABLE FORMATOEJEMPLAR ADD
    CONSTRAINT pk_formatoEjemplar
        PRIMARY KEY (id_formatoEjemplar);

ALTER TABLE IDIOMAEJEMPLAR ADD
    CONSTRAINT pk_idiomaEjemplar
        PRIMARY KEY (id_idiomaEjemplar);

ALTER TABLE EJEMPLAR ADD
    CONSTRAINT pk_Ejemplar
        PRIMARY KEY (id_Ejemplar),
    CONSTRAINT fk_ejemplar_editorial
        FOREIGN KEY (id_Editorial)
        REFERENCES EDITORIAL (id_Editorial)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplar_formato
        FOREIGN KEY (id_Formato)
        REFERENCES FORMATOEJEMPLAR (id_formatoEjemplar)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplar_idioma
        FOREIGN KEY (id_Idioma)
        REFERENCES IDIOMAEJEMPLAR (id_idiomaEjemplar)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplar_coleccion
        FOREIGN KEY (id_coleccionPertenece)
        REFERENCES COLECCION (id_Coleccion)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE AUTORxEJEMPLAR ADD
    CONSTRAINT pk_autorxejemplar
        PRIMARY KEY (id_autorEjemplar),
    CONSTRAINT fk_autorxejemplar_autor
        FOREIGN KEY (id_Autor)
        REFERENCES AUTOR (id_Autor)
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
    CONSTRAINT fk_autorxejemplar_ejemplar
        FOREIGN KEY (id_Ejemplar)
        REFERENCES EJEMPLAR (id_Ejemplar)
            ON DELETE NO ACTION
            ON UPDATE CASCADE;

ALTER TABLE P_CLAVExEJEMPLAR ADD
    CONSTRAINT pk_clavexejemplar
        PRIMARY KEY (id_p_Clave),
    CONSTRAINT fk_clavexejemplar_ejemplar
        FOREIGN KEY (id_Ejemplar)
        REFERENCES EJEMPLAR (id_Ejemplar)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE ESTADOS ADD
    CONSTRAINT pk_Estado
        PRIMARY KEY (id_Estado);

ALTER TABLE PRESTAMO ADD
    CONSTRAINT pk_Prestamo
        PRIMARY KEY (id_Prestamo),
    CONSTRAINT fk_prestamo_estado
        FOREIGN KEY (id_Estado)
        REFERENCES ESTADOS (id_Estado)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_prestamo_usuario
        FOREIGN KEY (id_usuarioPresta)
        REFERENCES USUARIO (id_Usuario)
            ON DELETE NO ACTION
            ON UPDATE CASCADE,
    CONSTRAINT fk_prestamo_ejemplar
        FOREIGN KEY (id_Ejemplar)
        REFERENCES EJEMPLAR (id_Ejemplar)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION;