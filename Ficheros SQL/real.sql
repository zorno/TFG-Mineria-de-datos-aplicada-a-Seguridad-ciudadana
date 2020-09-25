DROP SEQUENCE VICTIMIZACION_SEXO_EDAD_seq;
DROP SEQUENCE VICTIMIZACION_VIOGEN_FAM_seq;
DROP SEQUENCE VICTIMIZACION_ODIO_seq;
DROP SEQUENCE VICTIMIZACION_SERIE_seq;
DROP SEQUENCE DELITO_TIPO_seq;
DROP SEQUENCE DELITO_PROV_seq;
DROP SEQUENCE DELITO_EXTR_TIPO_seq;
DROP SEQUENCE DELITO_EXTR_PROV_seq;
DROP SEQUENCE DELITO_EXTR_NACIONALIDAD_seq;
DROP SEQUENCE DELITO_EXTR_SERIE_seq;
DROP SEQUENCE DELITO_MENORES_seq;
DROP SEQUENCE DELITO_EDAD_SEXO_TIPO_seq;
DROP SEQUENCE DELITO_EDAD_SEXO_PROV_seq;
DROP SEQUENCE DELITO_EDAD_SERIE_seq;
DROP SEQUENCE REGISTRO_PROVINCIA_seq;
DROP SEQUENCE REGISTRO_COMUNIDAD_seq;
DROP SEQUENCE PAIS_seq;
DROP TABLE VICTIMIZACION_SEXO_EDAD;
DROP TABLE VICTIMIZACION_VIOGEN_FAM;
DROP TABLE VICTIMIZACION_ODIO;
DROP TABLE VICTIMIZACION_SERIE;
DROP TABLE DELITO_TIPO;
DROP TABLE DELITO_PROVINCIA;
DROP TABLE DELITO_EXTR_TIPO;
DROP TABLE DELITO_EXTR_PROVINCIA;
DROP TABLE DELITO_EXTR_NACIONALIDAD;
DROP TABLE DELITO_EXTR_SERIE;
DROP TABLE DELITO_MENORES;
DROP TABLE DELITO_EDAD_SEXO_TIPO;
DROP TABLE DELITO_EDAD_SEXO_PROVINCIA;
DROP TABLE DELITO_EDAD_SERIE;
DROP TABLE DELITO;
DROP TABLE REGISTRO_PROVINCIA;
DROP TABLE REGISTRO_COMUNIDAD;
DROP TABLE PROVINCIA;
DROP TABLE COMUNIDAD;
DROP TABLE PAIS;

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

CREATE TABLE DELITO (
	id_tipo_delito NUMBER,
	cod_tipo_delito VARCHAR(20),
	nombre CHAR(120) NOT NULL UNIQUE,
	tipo CHAR(80),
	PRIMARY KEY( id_tipo_delito ) 
);

CREATE TABLE DELITO_TIPO (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_PROVINCIA (
	id_delito NUMBER,
	cod_prov NUMBER NOT NULL,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EXTR_TIPO (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EXTR_PROVINCIA (
	id_delito NUMBER,
	cod_prov NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EXTR_NACIONALIDAD (
	id_delito NUMBER,
	cod_pais NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	FOREIGN KEY(cod_pais) REFERENCES PAIS(id_pais),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EXTR_SERIE (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_MENORES (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	extranjero CHAR(1) NOT NULL,
	sexo CHAR(1) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EDAD_SEXO_TIPO (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	edad CHAR(10) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EDAD_SEXO_PROVINCIA (
	id_delito NUMBER,
	cod_prov NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	edad CHAR(10) NOT NULL,
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	PRIMARY KEY( id_delito )
);

CREATE TABLE DELITO_EDAD_SERIE (
	id_delito NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	edad CHAR(10) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_delito )
);

CREATE TABLE VICTIMIZACION_SEXO_EDAD (
	id_victimizacion NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	edad CHAR(10) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_victimizacion )
);

CREATE TABLE VICTIMIZACION_VIOGEN_FAM (
	id_victimizacion NUMBER,
	cod_delito NUMBER NOT NULL,
	cod_prov NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	sexo CHAR(1) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	PRIMARY KEY( id_victimizacion )
);

CREATE TABLE VICTIMIZACION_ODIO (
	id_victimizacion NUMBER,
	cod_delito NUMBER NOT NULL,
	cod_prov NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	FOREIGN KEY(cod_prov) REFERENCES PROVINCIA(id_prov),
	PRIMARY KEY( id_victimizacion )
);

CREATE TABLE VICTIMIZACION_SERIE (
	id_victimizacion NUMBER,
	cod_delito NUMBER NOT NULL,
	año CHAR(4) NOT NULL,
	FOREIGN KEY(cod_delito) REFERENCES DELITO(id_tipo_delito),
	PRIMARY KEY( id_victimizacion )
);

CREATE SEQUENCE VICTIMIZACION_SEXO_EDAD_seq START WITH 1;
CREATE SEQUENCE VICTIMIZACION_VIOGEN_FAM_seq START WITH 1;
CREATE SEQUENCE VICTIMIZACION_ODIO_seq START WITH 1;
CREATE SEQUENCE VICTIMIZACION_SERIE_seq START WITH 1;
CREATE SEQUENCE DELITO_TIPO_seq START WITH 1;
CREATE SEQUENCE DELITO_PROV_seq START WITH 1;
CREATE SEQUENCE DELITO_EXTR_TIPO_seq START WITH 1;
CREATE SEQUENCE DELITO_EXTR_PROV_seq START WITH 1;
CREATE SEQUENCE DELITO_EXTR_NACIONALIDAD_seq START WITH 1;
CREATE SEQUENCE DELITO_EXTR_SERIE_seq START WITH 1;
CREATE SEQUENCE DELITO_MENORES_seq START WITH 1;
CREATE SEQUENCE DELITO_EDAD_SEXO_TIPO_seq START WITH 1;
CREATE SEQUENCE DELITO_EDAD_SEXO_PROV_seq START WITH 1;
CREATE SEQUENCE DELITO_EDAD_SERIE_seq START WITH 1;
CREATE SEQUENCE REGISTRO_PROVINCIA_seq START WITH 1;
CREATE SEQUENCE REGISTRO_COMUNIDAD_seq START WITH 1;
CREATE SEQUENCE PAIS_seq START WITH 1;