--
-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE CREACIÓN DE LA BASE DE DATOS

CREATE DATABASE hce_antioquia
WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE   = 'en_US.UTF-8'
    TEMPLATE = template0;

--
-- Tablas en orden de creación
-- 1.- Tablas Independientes
-- 2.- Tablas Dependientes
--


--Tablas independientes
--------------------------------------------------------------

CREATE TABLE pais (
  id_pais INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo_pais VARCHAR(10) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE departamento (
  id_departamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_pais INTEGER NOT NULL,
  codigo VARCHAR(10),
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT fk_departamento_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE RESTRICT
);

CREATE TABLE ciudad (
  id_ciudad INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_departamento INTEGER NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  codigo_postal VARCHAR(20),
  CONSTRAINT fk_ciudad_departamento FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento) ON DELETE RESTRICT,
  CONSTRAINT uk_ciudad_departamento UNIQUE (id_departamento, nombre)
);

CREATE TABLE estado_eps (
  id_estado_eps INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE eps (
  id_eps INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo_eps VARCHAR(30) NOT NULL UNIQUE,
  nombre VARCHAR(200) NOT NULL,
  id_estado_eps INTEGER NOT NULL,
  telefono VARCHAR(20),
  direccion TEXT,
  CONSTRAINT fk_eps_estado FOREIGN KEY (id_estado_eps) REFERENCES estado_eps(id_estado_eps) ON DELETE RESTRICT
);

CREATE TABLE hospital (
  id_hospital INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nit VARCHAR(30) UNIQUE,
  nombre VARCHAR(200) NOT NULL,
  direccion TEXT,
  id_ciudad INTEGER,
  telefono VARCHAR(20),
  CONSTRAINT fk_hospital_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad) ON DELETE SET NULL,
  CONSTRAINT uk_hospital_nombre UNIQUE (nombre)
);

CREATE TABLE planta (
  id_planta INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_hospital INTEGER NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  piso INTEGER,
  CONSTRAINT fk_planta_hospital FOREIGN KEY (id_hospital) REFERENCES hospital(id_hospital) ON DELETE CASCADE
);

CREATE TABLE tipo_cuarto (
  id_tipo_cuarto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE estado_cuarto (
  id_estado_cuarto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tipo_telefono (
  id_tipo_telefono INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE especialidad (
  id_especialidad INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  descripcion TEXT
);

CREATE TABLE tipo_procedimiento (
  id_tipo_procedimiento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE medicamento (
  id_medicamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo VARCHAR(50) UNIQUE,
  nombre VARCHAR(200) NOT NULL,
  descripcion TEXT,
  dosis_sugerida VARCHAR(100)
);


--Tablas que dependen de las anteriores
--------------------------------------------------------------

CREATE TABLE cuarto (
  id_cuarto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_planta INTEGER NOT NULL,
  id_tipo_cuarto INTEGER NOT NULL,
  id_estado_cuarto INTEGER NOT NULL,
  numero VARCHAR(20) NOT NULL,
  capacidad INTEGER DEFAULT 1 CHECK (capacidad > 0),
  descripcion TEXT,
  CONSTRAINT fk_cuarto_planta FOREIGN KEY (id_planta) REFERENCES planta(id_planta) ON DELETE CASCADE,
  CONSTRAINT fk_cuarto_tipo FOREIGN KEY (id_tipo_cuarto) REFERENCES tipo_cuarto(id_tipo_cuarto) ON DELETE RESTRICT,
  CONSTRAINT fk_cuarto_estado FOREIGN KEY (id_estado_cuarto) REFERENCES estado_cuarto(id_estado_cuarto) ON DELETE RESTRICT,
  CONSTRAINT uk_cuarto_planta_numero UNIQUE (id_planta, numero)
);

CREATE TABLE visitante (
  id_visitante INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  apellido VARCHAR(150) NOT NULL,
  tipo_documento VARCHAR(30),
  numero_documento VARCHAR(50),
  relacion VARCHAR(100),
  telefono VARCHAR(30)
);

CREATE TABLE medico (
  id_medico INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo_documento VARCHAR(30),
  numero_documento VARCHAR(50) UNIQUE,
  nombres VARCHAR(150) NOT NULL,
  apellidos VARCHAR(150) NOT NULL,
  id_especialidad INTEGER,
  registro_profesional VARCHAR(50) UNIQUE,
  telefono VARCHAR(30),
  correo VARCHAR(150),
  CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad) ON DELETE SET NULL
);

CREATE TABLE especialidad_medico (
  id_especialidad_medico INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_medico INTEGER NOT NULL,
  id_especialidad INTEGER NOT NULL,
  CONSTRAINT fk_em_medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE,
  CONSTRAINT fk_em_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad) ON DELETE CASCADE,
  CONSTRAINT uk_especialidad_medico UNIQUE (id_medico, id_especialidad)
);

CREATE TABLE paciente (
  id_paciente INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo_documento VARCHAR(30),
  numero_documento VARCHAR(50) NOT NULL UNIQUE,
  nombres VARCHAR(150) NOT NULL,
  apellidos VARCHAR(150) NOT NULL,
  fecha_nacimiento DATE,
  sexo CHAR(1) CHECK (sexo IN ('M','F','O')),
  id_ciudad INTEGER,
  id_eps INTEGER,
  telefono VARCHAR(30),
  correo VARCHAR(150),
  CONSTRAINT fk_paciente_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad) ON DELETE SET NULL,
  CONSTRAINT fk_paciente_eps FOREIGN KEY (id_eps) REFERENCES eps(id_eps) ON DELETE SET NULL
);

CREATE TABLE tarjeta_visita (
  id_tarjeta_visita INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_visitante INTEGER NOT NULL,
  id_paciente INTEGER NOT NULL,
  fecha_emision TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
  fecha_expiracion TIMESTAMP WITHOUT TIME ZONE,
  id_estado_tarjeta INTEGER,
  observaciones TEXT,
  CONSTRAINT fk_tarjeta_visitante FOREIGN KEY (id_visitante) REFERENCES visitante(id_visitante) ON DELETE CASCADE,
  CONSTRAINT fk_tarjeta_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE
);

CREATE TABLE estado_tarjeta (
  id_estado_tarjeta INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE telefono (
  id_telefono INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_tipo_telefono INTEGER,
  id_paciente INTEGER,
  id_medico INTEGER,
  numero VARCHAR(30) NOT NULL,
  observacion VARCHAR(100),
  CONSTRAINT fk_telefono_tipo FOREIGN KEY (id_tipo_telefono) REFERENCES tipo_telefono(id_tipo_telefono) ON DELETE SET NULL,
  CONSTRAINT fk_telefono_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE,
  CONSTRAINT fk_telefono_medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE,
  CONSTRAINT chk_telefono_num CHECK (char_length(regexp_replace(numero, '\D','','g')) >= 6)
);

CREATE TABLE ingreso_cuarto (
  id_ingreso_cuarto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_paciente INTEGER NOT NULL,
  id_cuarto INTEGER NOT NULL,
  fecha_ingreso TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
  fecha_salida TIMESTAMP WITHOUT TIME ZONE,
  motivo_ingreso TEXT,
  id_medico_responsable INTEGER,
  CONSTRAINT fk_ingreso_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE,
  CONSTRAINT fk_ingreso_cuarto FOREIGN KEY (id_cuarto) REFERENCES cuarto(id_cuarto) ON DELETE RESTRICT,
  CONSTRAINT fk_ingreso_medico FOREIGN KEY (id_medico_responsable) REFERENCES medico(id_medico) ON DELETE SET NULL
);

CREATE TABLE visita (
  id_visita INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_paciente INTEGER NOT NULL,
  id_visitante INTEGER NOT NULL,
  fecha_visita TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
  relacion VARCHAR(100),
  observaciones TEXT,
  CONSTRAINT fk_visita_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE,
  CONSTRAINT fk_visita_visitante FOREIGN KEY (id_visitante) REFERENCES visitante(id_visitante) ON DELETE CASCADE
);

CREATE TABLE visita_medica (
  id_visita_medica INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_paciente INTEGER NOT NULL,
  id_medico INTEGER NOT NULL,
  fecha TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
  notas TEXT,
  diagnostico_id INTEGER,
  CONSTRAINT fk_visita_medica_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE,
  CONSTRAINT fk_visita_medica_medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE RESTRICT
);

CREATE TABLE diagnostico (
  id_diagnostico INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo VARCHAR(50) UNIQUE,
  descripcion TEXT NOT NULL
);

ALTER TABLE visita_medica
  ADD CONSTRAINT fk_visita_medica_diagnostico FOREIGN KEY (diagnostico_id) REFERENCES diagnostico(id_diagnostico) ON DELETE SET NULL;

CREATE TABLE procedimiento (
  id_procedimiento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_tipo_procedimiento INTEGER,
  nombre VARCHAR(200) NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_procedimiento_tipo FOREIGN KEY (id_tipo_procedimiento) REFERENCES tipo_procedimiento(id_tipo_procedimiento) ON DELETE SET NULL
);

CREATE TABLE prescripcion (
  id_prescripcion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_visita_medica INTEGER NOT NULL,
  fecha_prescripcion TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
  observaciones TEXT,
  CONSTRAINT fk_prescripcion_visita FOREIGN KEY (id_visita_medica) REFERENCES visita_medica(id_visita_medica) ON DELETE CASCADE
);

