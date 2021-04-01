﻿/*CREAR TABLA DE ADMINISTRADOR*/
CREATE TABLE ADMINISTRADOR(
 ADMI_ID INTEGER PRIMARY KEY,
 ADMI_CEDULA INTEGER,
 ADMI_NOMBRE VARCHAR (20),
 ADMI_APELLIDO VARCHAR(20),
 ADMI_CELULAR INTEGER
);
/*INSERTAR DATOS DE ADMINISTRADOR*/
insert into ADMINISTRADOR (ADMI_ID, ADMI_CEDULA, ADMI_NOMBRE, ADMI_APELLIDO, ADMI_CELULAR) VALUES
 (001,1315698526 ,'STEFANY', 'PICO', 0988682451);

/*CREAR TABLA DE BINGO*/
CREATE TABLE BINGO(
BIN_NUMERO INTEGER PRIMARY KEY,
BIN_DATE DATE,
ADMI_ID INTEGER NULL, 
CONSTRAINT ADMI_ID foreign key (ADMI_ID)
REFERENCES ADMINISTRADOR(ADMI_ID) ON UPDATE CASCADE
);

/*INSERTAR DATOS DE BINGO*/
insert into BINGO (BIN_NUMERO, BIN_DATE, ADMI_ID) VALUES
 (0001,'17/11/2020', 001);

/*CREAR TABLA DE USUARIO*/
CREATE TABLE USUARIO(
 CLI_CODIGO INT PRIMARY KEY,
 CLI_NOMBRE VARCHAR(20),
 CLI_APELLIDO VARCHAR(20),
 CLI_CEDULA INTEGER,
 CLI_DIRECCION VARCHAR(30),
 CLI_FECHA_NACIMIENTO DATE,
 BIN_NUMERO INTEGER NULL,
 CONSTRAINT BIN_NUMERO foreign key (BIN_NUMERO)
 REFERENCES BINGO(BIN_NUMERO) ON UPDATE CASCADE
);

/*INSERTAR DATOS DE USUARIO*/
insert into USUARIO (CLI_CODIGO, CLI_NOMBRE, CLI_APELLIDO, CLI_CEDULA, CLI_DIRECCION, CLI_FECHA_NACIMIENTO, BIN_NUMERO) VALUES
 (001, 'JOSSELYN', 'MACIAS', 1350696397, 'ALTAMIRA FRENTE A LA ESCUELA', '20/08/2000', 0001);

/*CREAR TABLA DE INSCRIPCION*/
CREATE TABLE INSCRIPCION(
INC_CODIGO INTEGER PRIMARY KEY,
INC_MESES INTEGER,
INC_DESCUENTO FLOAT,
ADMI_ID INTEGER NULL,
CLI_CODIGO INT NULL, 
CONSTRAINT ADMI_ID foreign key (ADMI_ID)
REFERENCES ADMINISTRADOR(ADMI_ID) ON UPDATE CASCADE,
CONSTRAINT CLI_CODIGO  foreign key (CLI_CODIGO )
REFERENCES USUARIO(CLI_CODIGO ) ON UPDATE CASCADE
);

 /*INSERTAR DATOS DE INSCRIPCION*/
insert into INSCRIPCION (INC_CODIGO , INC_MESES, INC_DESCUENTO, ADMI_ID, CLI_CODIGO ) VALUES
 (0001,5 ,0.12, 001, 001);

/*CREAR TABLA DE PAGO*/
CREATE TABLE PAGO(
PAG_CODIGO INTEGER PRIMARY KEY,
INC_CODIGO INTEGER NULL,
CONSTRAINT INC_CODIGO  foreign key (INC_CODIGO )
REFERENCES INSCRIPCION(INC_CODIGO ) ON UPDATE CASCADE
);

 /*INSERTAR DATOS DE PAGO*/
insert into PAGO (PAG_CODIGO, INC_CODIGO) VALUES
 (0001, 0001);

 /*MOSTRAR LOS DATOS DEL ADMINISTRADOR*/
select * FROM ADMINISTRADOR

 /*MOSTRAR LOS DATOS DEL BINGO*/
select * FROM BINGO

/*MOSTRAR LOS DATOS DEL USUARIO*/
select * FROM USUARIO

 /*MOSTRAR LOS DATOS DE LA INSCRIPCION*/
select * FROM INSCRIPCION


/*MOSTRAR LOS DATOS DEL PAGO*/
select * FROM PAGO





SELECT 
  inscripcion.inc_codigo, 
  pago.pag_codigo, 
  inscripcion.inc_meses, 
  inscripcion.admi_id, 
  administrador.admi_nombre, 
  usuario.cli_nombre, 
  usuario.cli_cedula, 
  bingo.bin_date
FROM 
  public.pago, 
  public.inscripcion, 
  public.usuario, 
  public.bingo, 
  public.administrador
WHERE 
  inscripcion.inc_codigo = pago.inc_codigo AND
  inscripcion.admi_id = administrador.admi_id AND
  usuario.bin_numero = bingo.bin_numero AND
  administrador.admi_id = bingo.admi_id;
