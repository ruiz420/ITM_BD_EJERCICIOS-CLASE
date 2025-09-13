CREATE DATABASE TiendaVideojuegos


USE TiendaVideojuegos

-- crear la  tabla
CREATE TABLE TipoDocumento(
		Id int IDENTITY NOT NULL,
		Nombre varchar (100) NOT NULL,
		Sigla varchar (5) NOT NULL,
	)

alter table TipoDocumento
	ADD CONSTRAINT PK_TipoDocumento_Id PRIMARY KEY (Id)

-- crear los indices de la tabla tipodocumento
CREATE UNIQUE INDEX Ix_TipoDocumento_Nombre
	ON TipoDocumento(Nombre)

CREATE UNIQUE INDEX Ix_TipoDocumento_Sigla
	ON TipoDocumento(Sigla)

-- crear la  tabla FORMATO
CREATE TABLE Formato(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Formato_Id PRIMARY KEY (Id),
	Nombre varchar (50) NOT NULL,
	)
	
-- crear los indices de la tabla FORMATO
CREATE UNIQUE INDEX Ix_Formato_Nombre
	ON Formato(Nombre)

-- crear la  tabla CATEGORIA
CREATE TABLE Categoria(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Categoria_Id PRIMARY KEY (Id),
	Nombre varchar (50) NOT NULL,
)

-- crear los indices de la tabla CATEGORIA
CREATE UNIQUE INDEX Ix_Categoria_Nombre
	ON Categoria(Nombre)



-- crear la  tabla PLATAFORMA
CREATE TABLE Plataforma(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Plataforma_Id PRIMARY KEY (Id),
	Nombre varchar (50) NOT NULL,
	Año int NULL,
	Portable int NOT NULL,
)

-- crear los indices de la tabla PLATAFORMA
CREATE UNIQUE INDEX Ix_Plataforma_Nombre
	ON Plataforma(Nombre)



-- crear la  tabla PAIS
CREATE TABLE Pais(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Pais_Id PRIMARY KEY (Id),
	Nombre varchar (50) NOT NULL,
	CodigoAlfa varchar (5) NOT NULL, 
	Indicativo int NULL

	)
	
-- crear los indices de la tabla PAIS
CREATE UNIQUE INDEX Ix_Pais_Nombre
	ON Pais(Nombre)

CREATE UNIQUE INDEX Ix_Pais_CodigoAlfa
	ON Pais(CodigoAlfa)

CREATE UNIQUE INDEX Ix_Pais_Indicativo
	ON Pais(Indicativo)


-- crear la  tabla Region
CREATE TABLE Region(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Region_Id PRIMARY KEY (Id),
	Nombre varchar (50) NOT NULL,
	Codigo varchar (5) NOT NULL,
	IdPais int NOT NULL,
	CONSTRAINT fK_Region_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)

)

-- crear los indices de la tabla Region
CREATE UNIQUE INDEX Ix_Region_Nombre
	ON Region(IdPais, Nombre)


-- crear la  tabla DESARROLLADOR
CREATE TABLE Desarrollador(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Desarrollador_Id PRIMARY KEY (Id),
	Nombre varchar (100) NOT NULL,
	Codigo varchar (5) NOT NULL,
	IdPais int NOT NULL,
	CONSTRAINT fK_Desarrollador_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- crear los indices de la tabla DESARROLLADOR
CREATE UNIQUE INDEX Ix_Desarrollador_Nombre
	ON Desarrollador(Nombre)


-- crear la  tabla TITULO (dos indices)
CREATE TABLE Titulo(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Titulo_Id PRIMARY KEY (Id),
	Nombre varchar (100) NOT NULL,
	Año int NULL,
	Version varchar (20) NOT NULL DEFAULT '1',
	PrecioActual FLOAT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL, 
	CONSTRAINT fK_Titulo_IdDesarrollador FOREIGN KEY (IdDesarrollador) REFERENCES Desarrollador(Id), 

)

-- crear los indices de la tabla Titulo
CREATE UNIQUE INDEX Ix_Titulo_Nombre
	ON Titulo(Nombre, Version)


--CREAR LA TABLA TITULOFORMATO
CREATE TABLE TituloFormato(
	IdTitulo int NOT NULL,
		CONSTRAINT fK_TituloFormato_IdTitulo 
			FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id), 
	IdFormato int NOT NULL,
		CONSTRAINT fK_TituloFormato_IdFormato
			FOREIGN KEY (IdFormato) REFERENCES Formato(Id), 
		CONSTRAINT pK_TituloFormato
			PRIMARY KEY (IdTitulo, IdFormato)
)

-- CREAR LA TABLA

----psjnhsdsfhskjfshdkfhdskjfshfksjhdk
	