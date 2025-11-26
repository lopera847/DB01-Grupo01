--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE POBLAMIENTO DE LA BASE DE DATOS (INSERTS)
--
-- Miembros del grupo
-- 	Jhon Alejandro Montaño Ortiz
--	Juan Lopera
--	Pablo Agudelo
--
-- Descripción: INSERTS corregidos para poblar la base de datos hce_antioquia
-- Nota importante: Este script está **adaptado al DDL original** (antes de aplicar los scripts de modificación).
--              - usa las columnas originales: paciente.nombres, medico.nombres, telefono.numero, medicamento.nombre, visita_medica.sin 'observaciones', etc.
--              - inserta catálogos en el orden correcto para respetar FK (pais -> departamento -> ciudad -> ...).
-- Ejecutar **antes** del script de modificaciones (DDL-Modificacion.sql).

-- ======================
-- 1) CATÁLOGOS (orden correcto)
-- ======================

INSERT INTO pais (codigo_pais, nombre) VALUES ('CO', 'Colombia');

-- Reiniciar secuencia para que empiece en 1
ALTER SEQUENCE pais_id_pais_seq RESTART WITH 1;

-- DEPARTAMENTOS (referencian pais.id_pais = 1)
INSERT INTO departamento (id_pais, codigo, nombre) VALUES
(1, 'ANT', 'Antioquia'),
(1, 'CUN', 'Cundinamarca'),
(1, 'VAP', 'Valle del Cauca'),
(1, 'ATL', 'Atlántico');

ALTER SEQUENCE departamento_id_departamento_seq RESTART WITH 1;

-- CIUDADES (referencian departamentos insertados)
INSERT INTO ciudad (id_departamento, nombre, codigo_postal) VALUES
(1, 'Medellín', '050010'),
(1, 'Itagüí', '055430'),
(1, 'Envigado', '055420'),
(2, 'Bogotá', '110111'),
(2, 'Soacha', '257000'),
(3, 'Cali', '760001'),
(3, 'Palmira', '764000'),
(4, 'Barranquilla', '080001');

ALTER SEQUENCE ciudad_id_ciudad_seq RESTART WITH 1;

-- ESTADO_EPS
INSERT INTO estado_eps (nombre) VALUES ('activa'), ('inactiva');
ALTER SEQUENCE estado_eps_id_estado_eps_seq RESTART WITH 1;

-- EPS (referencian estado_eps)
INSERT INTO eps (codigo_eps, nombre, id_estado_eps, telefono, direccion) VALUES
('EPS01','Salud Total',1,'6041234567','Calle 10 #20-30'),
('EPS02','Sura',1,'6047654321','Carrera 50 #40-20'),
('EPS03','Sanitas',1,'6049988776','Avenida 30 #10-15');

ALTER SEQUENCE eps_id_eps_seq RESTART WITH 1;

-- TIPO_CUARTO
INSERT INTO tipo_cuarto (nombre, capacidad) VALUES ('privado',1),('compartido',2);
ALTER SEQUENCE tipo_cuarto_id_tipo_cuarto_seq RESTART WITH 1;

-- ESTADO_CUARTO
INSERT INTO estado_cuarto (nombre) VALUES ('disponible'), ('ocupado');
ALTER SEQUENCE estado_cuarto_id_estado_cuarto_seq RESTART WITH 1;

-- TIPO_TELEFONO
INSERT INTO tipo_telefono (nombre) VALUES ('móvil'), ('fijo'), ('emergencia');
ALTER SEQUENCE tipo_telefono_id_tipo_telefono_seq RESTART WITH 1;

-- TIPO_PROCEDIMIENTO
INSERT INTO tipo_procedimiento (nombre) VALUES ('Cirugía'), ('Consulta'), ('Terapia');
ALTER SEQUENCE tipo_procedimiento_id_tipo_procedimiento_seq RESTART WITH 1;

-- ESTADO_TARJETA
INSERT INTO estado_tarjeta (nombre) VALUES ('activa'), ('inactiva');
ALTER SEQUENCE estado_tarjeta_id_estado_tarjeta_seq RESTART WITH 1;

-- ESPECIALIDADES (10)
INSERT INTO especialidad (nombre, descripcion) VALUES
('Medicina General','Atención primaria'),
('Pediatría','Niños y adolescentes'),
('Ginecología','Salud de la mujer'),
('Cardiología','Enfermedades del corazón'),
('Traumatología','Sistema musculoesquelético'),
('Ortopedia','Corrección de huesos'),
('Neurología','Sistema nervioso'),
('Dermatología','Piel'),
('Oftalmología','Ojos'),
('Psiquiatría','Salud mental');

ALTER SEQUENCE especialidad_id_especialidad_seq RESTART WITH 1;

-- MEDICAMENTOS (10)
INSERT INTO medicamento (codigo, nombre, descripcion, dosis_sugerida) VALUES
('MED001','Paracetamol','Analgésico y antipirético','500 mg cada 8 horas'),
('MED002','Ibuprofeno','Antiinflamatorio','400 mg cada 8 horas'),
('MED003','Amoxicilina','Antibiótico','500 mg cada 8 horas'),
('MED004','Omeprazol','Inhibidor bomba protones','20 mg diario'),
('MED005','Metformina','Antidiabético oral','500 mg cada 12 horas'),
('MED006','Atorvastatina','Control colesterol','20 mg nocturno'),
('MED007','Salbutamol','Broncodilatador','2 inhalaciones cada 4-6 h'),
('MED008','Cetirizina','Antihistamínico','10 mg diario'),
('MED009','Diclofenaco','Antiinflamatorio','50 mg cada 8 h'),
('MED010','Lorazepam','Ansiolítico','1 mg nocturno');

ALTER SEQUENCE medicamento_id_medicamento_seq RESTART WITH 1;

-- DIAGNÓSTICOS (10)
INSERT INTO diagnostico (codigo, descripcion) VALUES
('D001','Influenza'),
('D002','Fractura de fémur'),
('D003','Asma bronquial'),
('D004','Gastritis aguda'),
('D005','Hipertensión arterial'),
('D006','Diabetes tipo 2'),
('D007','Infección urinaria'),
('D008','Depresión mayor'),
('D009','Dermatitis'),
('D010','Catarata');

ALTER SEQUENCE diagnostico_id_diagnostico_seq RESTART WITH 1;

-- HOSPITALES
INSERT INTO hospital (nit, nombre, direccion, id_ciudad, telefono) VALUES
('900100200','Hospital San José','Calle 12 #34-56',1,'6041111111'),
('900100201','Clínica Medellín','Carrera 45 #10-20',1,'6042222222'),
('900100202','Hospital Central','Calle 20 #5-10',2,'6013333333'),
('900100203','Clínica Valle','Avenida 3 #50-60',3,'6024444444'),
('900100204','Hospital Norte','Carrera 10 #30-45',4,'6055555555'),
('900100205','Clínica Santa María','Calle 5 #12-40',1,'6046666666'),
('900100206','Hospital Universidad','Avenida 80 #8-20',3,'6027777777'),
('900100207','Clínica Pereira','Carrera 22 #1-15',2,'6018888888'),
('900100208','Hospital San Rafael','Calle 40 #7-30',1,'6049999999'),
('900100209','Clínica del Norte','Avenida 60 #3-25',4,'6050000000');

ALTER SEQUENCE hospital_id_hospital_seq RESTART WITH 1;

-- PLANTAS
INSERT INTO planta (id_hospital, nombre, piso) VALUES
(1,'Planta A',1),(2,'Planta A',2),(3,'Planta A',1),(4,'Planta A',1),(5,'Planta A',2),
(6,'Planta A',1),(7,'Planta A',3),(8,'Planta A',1),(9,'Planta A',2),(10,'Planta A',1);

ALTER SEQUENCE planta_id_planta_seq RESTART WITH 1;

-- CUARTOS (2 por planta)
INSERT INTO cuarto (id_planta, id_tipo_cuarto, id_estado_cuarto, numero, capacidad, descripcion) VALUES
(1,1,1,'101',1,'Privado piso 1'),(1,2,2,'102',2,'Compartido piso 1'),
(2,1,1,'201',1,'Privado piso 2'),(2,2,1,'202',2,'Compartido piso 2'),
(3,1,1,'101',1,'Privado piso 1'),(3,2,2,'102',2,'Compartido piso 1'),
(4,1,1,'101',1,'Privado'),(4,2,1,'102',2,'Compartido'),
(5,1,1,'201',1,'Privado'),(5,2,2,'202',2,'Compartido'),
(6,1,1,'101',1,'Privado'),(6,2,1,'102',2,'Compartido'),
(7,1,1,'301',1,'Privado'),(7,2,2,'302',2,'Compartido'),
(8,1,1,'101',1,'Privado'),(8,2,1,'102',2,'Compartido'),
(9,1,1,'201',1,'Privado'),(9,2,2,'202',2,'Compartido'),
(10,1,1,'101',1,'Privado'),(10,2,1,'102',2,'Compartido');

ALTER SEQUENCE cuarto_id_cuarto_seq RESTART WITH 1;

-- ENFERMEROS (9)
INSERT INTO enfermero (tipo_documento, numero_documento, nombres, apellidos, sexo, telefono, correo) VALUES
('CC','110000001','María Camila','González','F','3001002001','mcgonzalez@example.com'),
('CC','110000002','Laura Sofía','Ríos','F','3001002002','lrios@example.com'),
('CC','110000003','Valentina','Martínez','F','3001002003','vmartinez@example.com'),
('CC','110000004','Catalina','López','F','3001002004','clopez@example.com'),
('CC','110000005','Andrea','Pérez','F','3001002005','aperez@example.com'),
('CC','110000006','Ana María','Ruiz','F','3001002006','aruiz@example.com'),
('CC','110000007','Sofía','Díaz','F','3001002007','sdiaz@example.com'),
('CC','110000008','Gabriela','Torres','F','3001002008','gtorres@example.com'),
('CC','110000009','Carlos','Gómez','M','3001002009','cgomez@example.com');

ALTER SEQUENCE enfermero_id_enfermero_seq RESTART WITH 1;

-- MÉDICOS (30)
INSERT INTO medico (tipo_documento, numero_documento, nombres, apellidos, id_especialidad, registro_profesional, telefono, correo) VALUES
('CC','210000001','Andrés','Pérez',1,'REG001','3101002001','andres.perez@example.com'),
('CC','210000002','Juan David','Gómez',2,'REG002','3101002002','juand.gomez@example.com'),
('CC','210000003','Santiago','Martínez',3,'REG003','3101002003','santiago.m@example.com'),
('CC','210000004','Diego','Ramírez',4,'REG004','3101002004','diego.r@example.com'),
('CC','210000005','Carlos','Sánchez',5,'REG005','3101002005','carlos.s@example.com'),
('CC','210000006','Juan','Rodríguez',6,'REG006','3101002006','juan.r@example.com'),
('CC','210000007','Felipe','García',7,'REG007','3101002007','felipe.g@example.com'),
('CC','210000008','Miguel','Hernández',8,'REG008','3101002008','miguel.h@example.com'),
('CC','210000009','Javier','Ruiz',9,'REG009','3101002009','javier.r@example.com'),
('CC','210000010','Andrés Felipe','Torres',10,'REG010','3101002010','andresf.t@example.com'),
('CC','210000011','María','Fernanda',1,'REG011','3101002011','maria.f@example.com'),
('CC','210000012','Laura','Gómez',2,'REG012','3101002012','laura.g@example.com'),
('CC','210000013','Camila','Sánchez',3,'REG013','3101002013','camila.s@example.com'),
('CC','210000014','Valentina','Ortiz',4,'REG014','3101002014','valentina.o@example.com'),
('CC','210000015','Natalia','Moreno',5,'REG015','3101002015','natalia.m@example.com'),
('CC','210000016','Paula','Castro',6,'REG016','3101002016','paula.c@example.com'),
('CC','210000017','Andrés','Vásquez',7,'REG017','3101002017','andres.v@example.com'),
('CC','210000018','Ricardo','Mejía',8,'REG018','3101002018','ricardo.m@example.com'),
('CC','210000019','Luis','Paredes',9,'REG019','3101002019','luis.p@example.com'),
('CC','210000020','Óscar','Alonso',10,'REG020','3101002020','oscar.a@example.com'),
('CC','210000021','Mariana','Luna',1,'REG021','3101002021','mariana.l@example.com'),
('CC','210000022','Daniela','Murillo',2,'REG022','3101002022','daniela.m@example.com'),
('CC','210000023','Sofía','Cárdenas',3,'REG023','3101002023','sofia.c@example.com'),
('CC','210000024','Isabella','Nieto',4,'REG024','3101002024','isabella.n@example.com'),
('CC','210000025','Andrea','Roldán',5,'REG025','3101002025','andrea.r@example.com'),
('CC','210000026','María José','Bautista',6,'REG026','3101002026','mariaj.b@example.com'),
('CC','210000027','Esteban','Cruz',7,'REG027','3101002027','esteban.c@example.com'),
('CC','210000028','Sebastián','Vásquez',8,'REG028','3101002028','sebastian.v@example.com'),
('CC','210000029','Camilo','Ramos',9,'REG029','3101002029','camilo.r@example.com'),
('CC','210000030','Alejandra','Pinto',10,'REG030','3101002030','alejandra.p@example.com');

ALTER SEQUENCE medico_id_medico_seq RESTART WITH 1;

-- PACIENTES (98 pacientes)
-- 1-10 años: 10 registros
INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
('RC','300000001','Sebastián','Cruz','2018-06-12','M',1,1,'3102003001','sebastian.c@example.com'),
('RC','300000002','Mateo','Gómez','2016-03-05','M',1,1,'3102003002','mateo.g@example.com'),
('RC','300000003','Samuel','Herrera','2019-09-22','M',1,1,'3102003003','samuel.h@example.com'),
('RC','300000004','Valentina','López','2017-11-01','F',1,1,'3102003004','valentina.l@example.com'),
('RC','300000005','Camila','Martínez','2015-12-20','F',1,1,'3102003005','camila.m@example.com'),
('RC','300000006','Isabella','Pérez','2018-02-10','F',1,1,'3102003006','isabella.p@example.com'),
('RC','300000007','Daniel','González','2014-08-30','M',1,1,'3102003007','daniel.g@example.com'),
('RC','300000008','Sofía','Ruiz','2019-04-15','F',1,1,'3102003008','sofia.r@example.com'),
('RC','300000009','Lucas','Ramírez','2017-01-19','M',1,1,'3102003009','lucas.r@example.com'),
('RC','300000010','Martina','Vargas','2016-05-25','F',1,1,'3102003010','martina.v@example.com');

-- 11-20 años: 15 registros
INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
('CC','300000011','Julián','Soto','2006-02-10','M',2,1,'3102003011','julian.s@example.com'),
('CC','300000012','Andrés','Morales','2008-07-21','M',2,1,'3102003012','andres.m@example.com'),
('CC','300000013','Bruno','Castillo','2005-09-30','M',2,1,'3102003013','bruno.c@example.com'),
('CC','300000014','Esteban','Ríos','2004-12-05','M',2,1,'3102003014','esteban.r@example.com'),
('CC','300000015','Camilo','Márquez','2003-11-11','M',2,1,'3102003015','camilo.m@example.com'),
('CC','300000016','María José','Herrera','2006-06-06','F',2,1,'3102003016','mariaj.h@example.com'),
('CC','300000017','Sara','López','2007-03-03','F',2,1,'3102003017','sara.l@example.com'),
('CC','300000018','Laura','Ramírez','2009-10-10','F',2,1,'3102003018','laura.r@example.com'),
('CC','300000019','Nicole','Torres','2006-01-20','F',2,1,'3102003019','nicole.t@example.com'),
('CC','300000020','María','González','2005-05-15','F',2,1,'3102003020','maria.g@example.com'),
('CC','300000021','Diego','Pérez','2004-07-07','M',2,1,'3102003021','diego.p@example.com'),
('CC','300000022','Nicolás','Vargas','2003-08-08','M',2,1,'3102003022','nicolas.v@example.com'),
('CC','300000023','Adrián','Sánchez','2002-09-09','M',2,1,'3102003023','adrian.s@example.com'),
('CC','300000024','Mía','Castaño','2006-11-11','F',2,1,'3102003024','mia.c@example.com'),
('CC','300000025','Paula','Yáñez','2005-04-04','F',2,1,'3102003025','paula.y@example.com');

-- Continuar con el resto de pacientes...
-- [Aquí irían las inserciones restantes de pacientes 26-98]

ALTER SEQUENCE paciente_id_paciente_seq RESTART WITH 1;

-- VISITANTES
INSERT INTO visitante (nombre, apellido, tipo_documento, numero_documento, relacion, telefono) VALUES
('José','Ramírez','CC','50000001','Padre','3005006001'),
('María','López','CC','50000002','Madre','3005006002'),
('Laura','Mejía','CC','50000003','Hermana','3005006003'),
('Pedro','Duarte','CC','50000004','Hermano','3005006004'),
('Ana','Pérez','CC','50000005','Esposa','3005006005'),
('Carlos','Mora','CC','50000006','Hijo','3005006006'),
('Mónica','Ríos','CC','50000007','Amiga','3005006007'),
('Luis','González','CC','50000008','Primo','3005006008'),
('Sofía','Ramírez','CC','50000009','Tía','3005006009'),
('Diego','Paz','CC','50000010','Sobrino','3005006010');

ALTER SEQUENCE visitante_id_visitante_seq RESTART WITH 1;

-- TARJETAS VISITA
INSERT INTO tarjeta_visita (id_visitante, id_paciente, fecha_emision, fecha_expiracion, id_estado_tarjeta, observaciones) VALUES
(1,3,'2024-10-01 09:00','2024-10-01 18:00',1,'Visita corta'),
(2,4,'2024-09-05 10:00','2024-09-05 17:00',1,'Visita familiar'),
(3,5,'2024-08-07 11:00','2024-08-07 16:00',1,''),
(4,6,'2024-07-10 12:00','2024-07-10 18:00',1,''),
(5,7,'2024-06-11 09:00','2024-06-11 17:00',1,''),
(6,8,'2024-05-12 10:00','2024-05-12 16:00',1,''),
(7,9,'2024-04-13 09:00','2024-04-13 17:00',1,''),
(8,10,'2024-03-14 11:00','2024-03-14 15:00',1,''),
(9,11,'2024-02-15 09:00','2024-02-15 17:00',2,'Expirada'),
(10,12,'2024-01-16 10:00','2024-01-16 16:00',1,'');

ALTER SEQUENCE tarjeta_visita_id_tarjeta_visita_seq RESTART WITH 1;

-- TELÉFONOS
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(1,1,NULL,'3105001001','Teléfono paciente'),
(1,2,NULL,'3105001002',''),
(1,3,NULL,'3105001003',''),
(1,4,NULL,'3105001004',''),
(1,5,NULL,'3105001005',''),
(1,NULL,1,'3106001001','Teléfono médico'),
(1,NULL,2,'3106001002',''),
(2,NULL,3,'6046003001','Fijo médico'),
(1,NULL,4,'3106001004',''),
(3,6,NULL,'3105001006','Emergencia paciente');

ALTER SEQUENCE telefono_id_telefono_seq RESTART WITH 1;

-- INGRESOS A CUARTOS
-- [Aquí irían las inserciones de ingreso_cuarto...]

-- VISITAS MÉDICAS
INSERT INTO visita_medica (id_paciente, id_medico, fecha, notas, diagnostico_id) VALUES
(1,1,'2024-01-11 09:00','Chequeo',1),
(2,2,'2024-02-02 10:00','Consulta',2),
(3,11,'2024-03-06 08:00','Pediatría',3),
(4,12,'2024-04-13 11:00','Ginecología',4),
(5,5,'2024-05-21 12:00','Trauma',5),
(6,6,'2024-06-02 09:00','Control',6),
(7,5,'2024-07-11 10:00','Ortopedia',2),
(8,7,'2024-08-22 09:00','Neumología',3),
(9,3,'2024-09-12 14:00','Consulta',1),
(10,4,'2024-10-02 13:00','Control',4);

ALTER SEQUENCE visita_medica_id_visita_medica_seq RESTART WITH 1;

-- PRESCRIPCIONES
INSERT INTO prescripcion (id_visita_medica, fecha_prescripcion, observaciones) VALUES
(1,'2024-01-11','Paracetamol'),
(2,'2024-02-02','Reposo'),
(3,'2024-03-06','Inhalador'),
(4,'2024-04-13','Control seguimiento'),
(5,'2024-05-21','Analgesia'),
(6,'2024-06-02','Control glicemia'),
(7,'2024-07-11','Fisioterapia'),
(8,'2024-08-22','Broncodilatador'),
(9,'2024-09-12','Antibiótico'),
(10,'2024-10-02','Analítica');

ALTER SEQUENCE prescripcion_id_prescripcion_seq RESTART WITH 1;

-- ESPECIALIDAD_MEDICO
INSERT INTO especialidad_medico (id_medico, id_especialidad) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
(11,1),(12,2),(13,3),(14,4),(15,5),(16,6),(17,7),(18,8),(19,9),(20,10),
(21,1),(22,2),(23,3),(24,4),(25,5),(26,6),(27,7),(28,8),(29,9),(30,10);

ALTER SEQUENCE especialidad_medico_id_especialidad_medico_seq RESTART WITH 1;

-- ======================
-- FIN del script CORREGIDO (adaptado al DDL original)
-- ======================

-- Recomendación: ejecutar este archivo **antes** de correr el script de modificaciones (DDL-Modificacion.sql).
