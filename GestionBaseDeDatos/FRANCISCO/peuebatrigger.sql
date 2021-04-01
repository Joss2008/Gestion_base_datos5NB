CREATE TABLE numeros(
 numero bigint NOT NULL,
 cuadrado bigint,
 cubo bigint,
 raiz2 real,
 raiz3 real,
 PRIMARY KEY (numero)
);

CREATE OR REPLACE FUNCTION proteger_datos() RETURNS TRIGGER AS
$proteger_datos$
 DECLARE
 BEGIN

 --
 -- Esta funcion es usada para proteger datos en un tabla
 -- No se permitira el borrado de filas si la usamos
 -- en un disparador de tipo BEFORE / row-level
 --
 RETURN NULL;
 END;
$proteger_datos$ LANGUAGE plpgsql;

CREATE TRIGGER proteger_datos BEFORE DELETE
 ON numeros FOR EACH ROW
 EXECUTE PROCEDURE proteger_datos();


CREATE OR REPLACE FUNCTION rellenar_datos() RETURNS TRIGGER AS $rellenar_datos$
 DECLARE
 BEGIN

 NEW.cuadrado := power(NEW.numero,2);
 NEW.cubo := power(NEW.numero,3);
 NEW.raiz2 := sqrt(NEW.numero);
 NEW.raiz3 := cbrt(NEW.numero);
 RETURN NEW;
 END;
$rellenar_datos$ LANGUAGE plpgsql;


CREATE TRIGGER rellenar_datos BEFORE INSERT OR UPDATE
ON numeros FOR EACH ROW
EXECUTE PROCEDURE rellenar_datos();

INSERT INTO numeros (numero) VALUES (2);
INSERT INTO numeros (numero) VALUES (3);

SELECT * from numeros;

UPDATE numeros SET numero = 4 WHERE numero = 3;


