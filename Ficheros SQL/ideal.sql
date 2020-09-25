DROP SEQUENCE FECHA_seq;
DROP SEQUENCE HORA_seq;
DROP SEQUENCE PAIS_seq;
DROP SEQUENCE LUGAR_seq;
DROP SEQUENCE REGISTRO_COMUNIDAD_seq;
DROP SEQUENCE REGISTRO_PROVINCIA_seq;
DROP SEQUENCE DELITO_seq;
DROP TABLE DELITO;
DROP TABLE CARACTERISTICA_ECONOMICO;
DROP TABLE CARACTERISTICA_VIOGEN;
DROP TABLE CARACTERISTICA_MA;
DROP TABLE CARACTERISTICA_CIBER;
DROP TABLE CARACTERISTICA_DELITO;
DROP TABLE LUGAR;
DROP TABLE HISTORIAL_COMISARIA;
DROP TABLE COMISARIA;
DROP TABLE REGISTRO_PROVINCIA;
DROP TABLE REGISTRO_COMUNIDAD;
DROP TABLE PROVINCIA;
DROP TABLE COMUNIDAD;
DROP TABLE PAIS;
DROP TABLE FECHA;
DROP TABLE HORA;

CREATE TABLE FECHA (
	id_fecha NUMBER,
	dia CHAR(2) NOT NULL,
	mes CHAR(10) NOT NULL,
	año CHAR(4) NOT NULL,
	dia_semana CHAR(10),
	festivo_nacional CHAR(4),
	PRIMARY KEY( id_fecha )
);

CREATE TABLE HORA (
	id_hora NUMBER,
	hora CHAR(2) NOT NULL,
	minuto CHAR(2) NOT NULL,
	verano CHAR(1) NOT NULL,
	PRIMARY KEY( id_hora )
);

CREATE TABLE PAIS (
	id_pais NUMBER,
	nombre CHAR(100),
	iso3 CHAR(3) UNIQUE,
	otan CHAR(1),
	ue CHAR(1),
	hispano CHAR(1),
	PRIMARY KEY( id_pais ) 
);

CREATE TABLE COMUNIDAD (
	id_ccaa NUMBER,
	nombre CHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY( id_ccaa )
);

CREATE TABLE REGISTRO_COMUNIDAD (
	id_registro_ccaa NUMBER,
	cod_ccaa NUMBER NOT NULL,
	año NUMBER NOT NULL,
	uso_pc_menores NUMBER,
	uso_internet_menores NUMBER,
	uso_movil_menores NUMBER,
	uso_pc NUMBER,
	conexion_internet NUMBER,
	conexion_adsl NUMBER,
	uso_tlffijo NUMBER,
	uso_tlfmovil NUMBER,
	gasto_total_hogar NUMBER,
	distr_porc_gasto NUMBER,
	gasto_medio_hogar NUMBER,
	gasto_medio_persona NUMBER,
	gasto_medio_uniconsum NUMBER,
	indice_media_gmp NUMBER,
	no_vacaciones NUMBER,
	carencia_alimentos NUMBER,
	no_temperatura NUMBER,
	no_imprevistos NUMBER,
	retraso_vivienda NUMBER,
	no_automovil NUMBER,
	no_ordenador NUMBER,
	hogar_muchadificultad CHAR(10),
	hogar_dificultad CHAR(10),
	hogar_ciertadificultad CHAR(10),
	hogar_ciertafacilidad CHAR(10),
	hogar_facilidad CHAR(10),
	hogar_muchafacilidad CHAR(10),
	hogar_propiedad NUMBER,
	hogar_alquilermerc NUMBER,
	hogar_alquilerdebmerc NUMBER,
	hogar_cesion NUMBER,
	hogar_sinluznatural NUMBER,
	hogar_contaminacion NUMBER,
	hogar_ruidos NUMBER,
	hogar_delincuencia NUMBER,
	hogar_sinproblema NUMBER,
	renta_media_hog NUMBER,
	renta_media_pers NUMBER,
	renta_media_uniconsum NUMBER,
	riesgo_pobreza NUMBER,
	pib NUMBER,
	pib_capita NUMBER,
	idh CHAR(10),
	desempleo NUMBER,
	analfabetos NUMBER,
	estudios_primaria_inc NUMBER,
	estudios_primaria NUMBER,
	estudios_secundaria NUMBER,
	estudios_fp_general NUMBER,
	estudios_fp_especifico NUMBER,
	estudios_superior NUMBER,
	PRIMARY KEY( id_registro_ccaa ),
	FOREIGN KEY(cod_ccaa) REFERENCES Comunidad(id_ccaa)
);

CREATE TABLE PROVINCIA (
	id_prov NUMBER,
	cod_ccaa NUMBER NOT NULL,
	nombre CHAR(80) NOT NULL UNIQUE,
	PRIMARY KEY( id_prov ),
	FOREIGN KEY(cod_ccaa) REFERENCES Comunidad(id_ccaa)
);

CREATE TABLE REGISTRO_PROVINCIA (
	id_registro_prov NUMBER,
	cod_prov NUMBER NOT NULL,
	año NUMBER NOT NULL,
	poblacion_total NUMBER,
	poblacion_hombres NUMBER,
	poblacion_mujeres NUMBER,
	fecundidad NUMBER,
	mortalidad NUMBER,
	natalidad NUMBER,
	PRIMARY KEY( id_registro_prov ),
	FOREIGN KEY(cod_prov) REFERENCES Provincia(id_prov)
);

CREATE TABLE COMISARIA (
	id_comisaria NUMBER,
	direccion CHAR(50),
	nombre CHAR(120),
	cod_prov NUMBER,
	PRIMARY KEY( id_comisaria ),
	FOREIGN KEY(cod_prov) REFERENCES Provincia(id_prov)
);

CREATE TABLE HISTORIAL_COMISARIA (
	id_his_comisaria NUMBER,
	cod_comisaria NUMBER,
	gasto_material NUMBER,
	gasto_vehiculos NUMBER,
	gasto_informatica NUMBER,
	gasto_mantenimiento NUMBER,
	gasto_total NUMBER,
	n_personal NUMBER,
	n_vehiculos NUMBER,
	n_operaciones NUMBER,
	avisos_recibidos NUMBER,
	año NUMBER,
	PRIMARY KEY( id_his_comisaria ),
	FOREIGN KEY(cod_comisaria) REFERENCES Comisaria(id_comisaria)
);

CREATE TABLE LUGAR (
	id_lugar NUMBER,
	via CHAR(20),
	luminosidad CHAR(20),
	tipoLugar CHAR(30),
	climatologia CHAR(40),
	PRIMARY KEY( id_lugar )
);

CREATE TABLE CARACTERISTICA_DELITO (
	id_tipo_delito NUMBER,
	nombre CHAR(120),
	tipo CHAR(80),
	codigo CHAR(20),
	PRIMARY KEY( id_tipo_delito ) 
);

CREATE TABLE CARACTERISTICA_VIOGEN (
	id_tipo_delito NUMBER,
	relacion CHAR(20),
	historial CHAR(20),
	persona_cargo CHAR(20),
	con_proteccion CHAR(20),
	aviso_anterior CHAR(20),
	PRIMARY KEY( id_tipo_delito ),
	FOREIGN KEY(id_tipo_delito) REFERENCES CARACTERISTICA_DELITO(id_tipo_delito)
);

CREATE TABLE CARACTERISTICA_MA (
	id_tipo_delito NUMBER,
	bien CHAR(60),
	lugar_detalle CHAR(80),
	PRIMARY KEY( id_tipo_delito ),
	FOREIGN KEY(id_tipo_delito) REFERENCES CARACTERISTICA_DELITO(id_tipo_delito)
);

CREATE TABLE CARACTERISTICA_CIBER (
	id_tipo_delito NUMBER,
	formacion_delicuente CHAR(20),
	medio CHAR(20),
	objetivo CHAR(20),
	PRIMARY KEY( id_tipo_delito ),
	FOREIGN KEY(id_tipo_delito) REFERENCES CARACTERISTICA_DELITO(id_tipo_delito)
);

CREATE TABLE CARACTERISTICA_ECONOMICO (
	id_tipo_delito NUMBER,
	victima CHAR(50),
	bien CHAR(50),
	cuantia CHAR(50),
	PRIMARY KEY( id_tipo_delito ),
	FOREIGN KEY(id_tipo_delito) REFERENCES CARACTERISTICA_DELITO(id_tipo_delito)
);

CREATE TABLE DELITO (
	id_delito NUMBER NOT NULL,
	cod_delito NUMBER,
	cod_fecha NUMBER,
	cod_hora NUMBER,
	cod_comisaria NUMBER,
	cod_prov NUMBER,
	cod_lugar NUMBER,
	nacionalidad_agr NUMBER,
	nacionalidad_vic NUMBER,
	edad_agr NUMBER,
	edad_vic NUMBER,
	FOREIGN KEY(cod_delito) REFERENCES CARACTERISTICA_DELITO(id_tipo_delito),
	FOREIGN KEY(cod_fecha) REFERENCES FECHA(id_fecha),
	FOREIGN KEY(cod_hora) REFERENCES HORA(id_hora),
	FOREIGN KEY(cod_comisaria) REFERENCES COMISARIA(id_comisaria),
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	FOREIGN KEY(nacionalidad_agr) REFERENCES PAIS(id_pais),
	FOREIGN KEY(nacionalidad_vic) REFERENCES PAIS(id_pais),
	FOREIGN KEY(cod_lugar) REFERENCES LUGAR(id_lugar),
	PRIMARY KEY( id_delito )
);

CREATE SEQUENCE DELITO_seq START WITH 1;
CREATE SEQUENCE FECHA_seq START WITH 1;
CREATE SEQUENCE HORA_seq START WITH 1;
CREATE SEQUENCE PAIS_seq START WITH 1;
CREATE SEQUENCE REGISTRO_COMUNIDAD_seq START WITH 1;
CREATE SEQUENCE HISTORIAL_COMISARIA_seq START WITH 1;
CREATE SEQUENCE LUGAR_seq START WITH 1;

CREATE OR REPLACE TRIGGER DELITO_incr
BEFORE INSERT ON DELITO
FOR EACH ROW
BEGIN
  SELECT DELITO_seq.NEXTVAL
  INTO   :new.id_delito
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER FECHA_incr
BEFORE INSERT ON FECHA
FOR EACH ROW
BEGIN
  SELECT FECHA_seq.NEXTVAL
  INTO   :new.id_fecha
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER HORA_incr
BEFORE INSERT ON HORA
FOR EACH ROW
BEGIN
  SELECT HORA_seq.NEXTVAL
  INTO   :new.id_hora
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER PAIS_incr
BEFORE INSERT ON PAIS
FOR EACH ROW
BEGIN
  SELECT PAIS_seq.NEXTVAL
  INTO   :new.id_pais
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER REGISTRO_COMUNIDAD_incr
BEFORE INSERT ON REGISTRO_COMUNIDAD
FOR EACH ROW
BEGIN
  SELECT REGISTRO_COMUNIDAD_seq.NEXTVAL
  INTO   :new.id_registro_ccaa
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER REGISTRO_PROVINCIA_incr
BEFORE INSERT ON REGISTRO_PROVINCIA
FOR EACH ROW
BEGIN
  SELECT REGISTRO_PROVINCIA_seq.NEXTVAL
  INTO   :new.id_registro_prov
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER LUGAR_incr
BEFORE INSERT ON LUGAR
FOR EACH ROW
BEGIN
  SELECT LUGAR_seq.NEXTVAL
  INTO   :new.id_lugar
  FROM   dual;
END;
/