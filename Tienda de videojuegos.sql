CREATE DATABASE TiendaVideoJuegosITM
GO

USE TiendaVideoJuegosITM

--Crear la tabla TIPODOCUMENTO
CREATE TABLE TipoDocumento(
	Id int IDENTITY NOT NULL,
	Nombre varchar(100) NOT NULL,
	Sigla varchar(5) NOT NULL
)

ALTER TABLE TipoDocumento
	ADD CONSTRAINT pk_TipoDocumento_Id PRIMARY KEY(Id)

--Crear los índices de la tabla TIPODOCUMENTO
CREATE UNIQUE INDEX ix_TipoDocumento_Nombre
	ON TipoDocumento(Nombre)

CREATE UNIQUE INDEX ix_TipoDocumento_Sigla
	ON TipoDocumento(Sigla)

--Crear la tabla FORMATO
CREATE TABLE Formato(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Formato_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL
)

ALTER TABLE Formato
	ADD Descripcion varchar(200) NOT NULL

--Crear los índices de la tabla FORMATO
CREATE UNIQUE INDEX ix_Formato_Nombre
	ON Formato(Nombre)

--Crear la tabla CATEGORIA
CREATE TABLE Categoria(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Categoria_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL
)

ALTER TABLE Categoria
	ADD Descripcion varchar(200) NOT NULL

--Crear los índices de la tabla Categoria
CREATE UNIQUE INDEX ix_Categoria_Nombre
	ON Categoria(Nombre)

--Crear la tabla PLATAFORMA
CREATE TABLE Plataforma(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Plataforma_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	Año int NULL,
	Portable bit NOT NULL
)

--Crear los índices de la tabla PLATAFORMA
CREATE UNIQUE INDEX ix_Plataforma_Nombre
	ON Plataforma(Nombre)

--Crear la tabla FORMATO
CREATE TABLE Pais(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Pais_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	CodigoAlfa VARCHAR(5) NOT NULL,
	Indicativo INT NULL
)

--Crear los índices de la tabla FORMATO
CREATE UNIQUE INDEX ix_Pais_Nombre
	ON Pais(Nombre)

CREATE UNIQUE INDEX ix_Pais_CodigoAlfa
	ON Pais(CodigoAlfa)

--Crear la tabla REGION
CREATE TABLE Region(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Region_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	Codigo varchar(5) NOT NULL,
	IdPais int NOT NULL,
	CONSTRAINT fk_Region_IdPais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)

--Crear los índices de la tabla REGION
CREATE UNIQUE INDEX ix_Region_Nombre
	ON Region(IdPais, Nombre)

--Crear tabla DESARROLLADOR
CREATE TABLE Desarrollador(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Desarrolador_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT fk_Desarrollador_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

--Crear indice de la tabla DESARROLLADOR
CREATE UNIQUE INDEX ix_Desarrollador_Nombre
	ON Desarrollador(Nombre)

--Crear tabla TITULO
CREATE TABLE Titulo(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Titulo_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	Año INT NULL,
	Version VARCHAR(20) NOT NULL DEFAULT '1',
	PrecioActual FLOAT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL,
	CONSTRAINT fk_Titulo_IdDesarrollador FOREIGN KEY (IdDesarrollador) REFERENCES Desarrollador(Id)
)

--Crear indice de la tabla TITULO
CREATE UNIQUE INDEX ix_Titulo_Nombre
	ON Titulo(Nombre, Version)

--Crear tabla TITULOFORMATO
CREATE TABLE TituloFormato(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdTitulo 
		FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdFormato INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdFormato 
		FOREIGN KEY (IdFormato) REFERENCES Formato(Id),
	CONSTRAINT pk_TituloFormato
		PRIMARY KEY(IdTitulo, IdFormato)
)

--Crear tabla TITULOPLATAFORMA
CREATE TABLE TituloPlataforma(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloPlataforma_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdPlataforma INT NOT NULL,
	CONSTRAINT fk_TituloPlataforma_IdPlataforma FOREIGN KEY (IdPlataforma) REFERENCES Plataforma(Id),
	CONSTRAINT pk_TituloPlataforma PRIMARY KEY (IdTitulo, IdPlataforma)
)

--Crear tabla TITULOCATEGORIA
CREATE TABLE TituloCategoria(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloCategoria_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdCategoria INT NOT NULL,
	CONSTRAINT fk_TituloCategoria_IdCategoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
	CONSTRAINT pk_TituloCategoria PRIMARY KEY (IdTitulo, IdCategoria)
)

--Crear tabla CIUDAD
CREATE TABLE Ciudad(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Ciudad_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdRegion INT NOT NULL,
	CONSTRAINT fk_Ciudad_IdRegion FOREIGN KEY (IdRegion) REFERENCES Region(Id)
)

--Crear indice de la tabla CIUDAD
CREATE UNIQUE INDEX ix_Ciudad_Nombre
	ON Ciudad(IdRegion, Nombre)

--Crear tabla CLIENTE
CREATE TABLE Cliente(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Cliente_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdTipoDocumento INT NOT NULL,
	CONSTRAINT fk_Cliente_IdTipoDocumento FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento(Id),
	NumeroIdentificacion VARCHAR(20) NOT NULL,
	CodigoPostal VARCHAR(10) NULL,
	FechaNacimiento DATE NULL,
	Direccion VARCHAR(100) NOT NULL,
	IdCiudad INT NOT NULL,
	CONSTRAINT fk_Cliente_IdCiudad FOREIGN KEY (IdCiudad) REFERENCES Ciudad(Id),
	Correo VARCHAR(100) NOT NULL,
	Movil VARCHAR(20) NOT NULL,
	Clave VARCHAR(50) NULL
)

--Crear indices de la tabla CLIENTE
CREATE INDEX ix_Cliente_Nombre
	ON Cliente(Nombre)

CREATE UNIQUE INDEX ix_Cliente_Identificacion
	ON Cliente(IdTipoDocumento, NumeroIdentificacion)

--Crear tabla EMPLEADO
CREATE TABLE Empleado(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Empleado_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdTipoDocumento INT NOT NULL,
	CONSTRAINT fk_Empleado_IdTipoDocumento FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento(Id),
	NumeroIdentificacion VARCHAR(20) NOT NULL,
	Clave VARCHAR(20) NOT NULL
)

--Crear indices de la tabla EMPLEADO
CREATE INDEX ix_Empleado_Nombre
	ON Empleado(Nombre)

CREATE UNIQUE INDEX ix_Empleado_Identificacion
	ON Empleado(IdTipoDocumento, NumeroIdentificacion)

--Crear tabla ESTADOVENTA
CREATE TABLE EstadoVenta(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_EstadoVenta_Id PRIMARY KEY (Id),
	Nombre VARCHAR(50) NOT NULL
)

