
CREATE USER 'alumno'@'%' IDENTIFIED BY PASSWORD '*E85846554D9113AACE826B57690C7B1041121FEF';

CREATE DATABASE IF NOT EXISTS trabajos;
USE trabajos;

CREATE TABLE trabajos (id VARCHAR(5) PRIMARY KEY, titulo TEXT, spec TEXT)
  CHARSET 'utf8' COLLATE 'utf8_unicode_ci';

CREATE TABLE asignacion_trabajos (
	dni_alumno VARCHAR(10),
	nombre_alumno VARCHAR(60),
	id_trabajo VARCHAR(5),
       FOREIGN KEY (id_trabajo) REFERENCES trabajos(id),
       PRIMARY KEY (dni_alumno, id_trabajo)
       ) CHARSET 'utf8' COLLATE 'utf8_unicode_ci';

CREATE VIEW asignados AS
   SELECT id, titulo, COUNT(DISTINCT dni_alumno) AS nasignados
   FROM trabajos LEFT OUTER JOIN asignacion_trabajos ON id = id_trabajo
   GROUP BY id;

GRANT INSERT ON trabajos.asignacion_trabajos TO 'alumno'@'%';
GRANT SELECT ON trabajos.trabajos TO 'alumno'@'%';
GRANT SELECT ON trabajos.asignados TO 'alumno'@'%';

FLUSH PRIVILEGES;

DELIMITER $$
CREATE TRIGGER comprueba_asignacion BEFORE INSERT ON asignacion_trabajos
FOR EACH ROW
BEGIN
  SELECT NEW.dni_alumno REGEXP '^[0-9]{7,}-?[a-zA-Z]$' INTO @cnt;
  IF @cnt <> 1 THEN
    SIGNAL SQLSTATE '23000'
      SET MESSAGE_TEXT = 'El DNI no es correcto. Formato 01234567L.';
  END IF;

  SELECT count(*) INTO @cnt FROM asignacion_trabajos
     WHERE id_trabajo = NEW.id_trabajo;
  IF @cnt > 1 THEN
    set @message_text = CONCAT('Ya hay asignadas dos personas al trabajo ', NEW.id_trabajo, '.');
    SIGNAL SQLSTATE '23000'
      SET MESSAGE_TEXT = @message_text;
  END IF;

  SELECT count(*) INTO @cnt FROM asignacion_trabajos
     WHERE dni_alumno = NEW.dni_alumno;
  IF @cnt > 0 THEN
    set @message_text = CONCAT('¡Ese DNI (', NEW.dni_alumno, ') ya está asignado a un trabajo! Hable con el profesor para cambiarlo.');
    SIGNAL SQLSTATE '23000'
      SET MESSAGE_TEXT = @message_text;
  END IF;
END
$$
DELIMITER ;

insert into trabajos values ('T01','Apache CouchDB',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación siguiendo el modelo de documentos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T02','Apache Cassandra',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, lenguaje de consultas CQL, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación siguiendo el modelo de documentos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');





insert into trabajos values ('T03','OrientDB',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, lenguaje de consultas, grafos vs. documentos, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación y grafos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T04','Redis',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, {\em framework} de procesamiento map/reduce, replicación multiservidor, lenguaje de consultas, uso de varias estructuras de datos (listas, mapas), etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de diferentes estructuras de datos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T05','Elasticsearch',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, organización en etiquetas, búsquedas complejas, replicación multiservidor, lenguaje de consultas, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (organización de etiquetas); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T06','CouchBase \& N1QL',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, organización en etiquetas, búsquedas complejas, replicación multiservidor, lenguaje de consultas N1QL, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (documentos y consultas); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T07','Riak',
'Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación siguiendo el modelo de documentos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T08','RethinkDB',
'{https://rethinkdb.com/}. Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación donde sea posible); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T09','InfluxDB',
'{https://www.influxdata.com/time-series-platform/influxdb/}. Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, tratamiento de series temporales, uso del API HTTP, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación donde sea posible); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T10','Accumulo',
'{http://accumulo.apache.org/}. Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, tratamiento de columnas, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de columnas); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T11','ArangoDB',
'{https://www.arangodb.com/}. Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, framework de procesamiento map/reduce, replicación multiservidor, lenguaje de consultas AQL, grafos vs. documentos, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de agregación y grafos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');



insert into trabajos values ('T12','SciDB',
'{http://www.paradigm4.com/try_scidb/}. Pasos de instalación de la base de datos (a ser posible en la máquina virtual); Descripción de la base de datos, modo de funcionamiento, posibilidades de modelado de datos y características (si permite transacciones, tratamiento de arrays, replicación multiservidor, etc.); Mostrar cómo importar los datos de Stackoverflow; Mostrar cómo redistribuir los datos de Stackoverflow de forma óptima (uso de arrays para cálculos); Mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');




insert into trabajos values ('T13','Apache Sqoop',
'{http://sqoop.apache.org/}. Pasos de instalación de la herramienta (a ser posible en la máquina virtual); Descripción de la herramienta, posibilidades de transformación y carga de datos, modos de funcionamiento, posibilidades de cambio de formato de datos, etc.); Mostrar cómo importar los datos de Stackoverflow (de CSV a MySQL, de CSV a HBase, viendo cómo organizar la base de datos); API de creación de trabajos {\em batch}; Generar código de importación con {\tt sqoop-codegen}');

insert into trabajos values ('T14','Apache Pig',
'(Pig está instalado en la máquina virtual); Descripción de la herramienta, posibilidades de transformación y carga de datos, modos de funcionamiento, posibilidades de proceso de datos, etc.; Mostrar cómo trabajar con los datos CSV de Stackoverflow y mostrar cómo se realizarían las consultas RQ1 a RQ4 de los artículos vistos en la sesión 2; Realizar pruebas de eficiencia comparada con alguna de las bases de datos vistas en la asignatura');
