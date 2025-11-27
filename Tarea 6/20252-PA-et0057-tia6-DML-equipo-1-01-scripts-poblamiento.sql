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

ALTER SEQUENCE ingreso_cuarto_id_ingreso_cuarto_seq RESTART WITH 1;

-- Insertar 150 registros de ingresos distribuidos entre los 98 pacientes
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES

-- Pacientes 1-10 (3 hospitalizaciones cada uno)
(1, 1, '2024-01-10 08:30:00', '2024-01-15 14:00:00', 'Neumonía bacteriana', 1),
(1, 3, '2024-03-05 10:15:00', '2024-03-12 11:30:00', 'Bronquitis aguda', 5),
(1, 5, '2024-06-20 14:20:00', '2024-06-25 09:45:00', 'Control post-neumonía', 10),

(2, 2, '2024-01-12 09:45:00', '2024-01-18 16:20:00', 'Fractura de tibia', 2),
(2, 4, '2024-04-15 11:30:00', '2024-04-22 14:15:00', 'Rehabilitación post-fractura', 6),
(2, 6, '2024-07-10 08:25:00', '2024-07-17 15:40:00', 'Retiro de yeso', 11),

(3, 3, '2024-01-15 14:20:00', '2024-01-22 10:30:00', 'Apéndicitis aguda', 3),
(3, 6, '2024-03-18 16:00:00', '2024-03-25 12:15:00', 'Infección post-operatoria', 7),
(3, 8, '2024-07-10 08:45:00', '2024-07-15 15:20:00', 'Control quirúrgico', 12),

(4, 4, '2024-01-18 11:15:00', '2024-01-25 13:40:00', 'Infección urinaria complicada', 4),
(4, 7, '2024-05-22 13:30:00', '2024-05-29 10:25:00', 'Pielonefritis', 8),
(4, 9, '2024-08-15 09:35:00', '2024-08-22 14:50:00', 'Control urológico', 13),

(5, 5, '2024-01-20 09:30:00', '2024-01-27 16:20:00', 'Colecistitis', 5),
(5, 9, '2024-04-10 15:45:00', '2024-04-17 11:35:00', 'Litiasis biliar', 9),
(5, 11, '2024-08-05 10:20:00', '2024-08-12 14:50:00', 'Control digestivo', 14),

(6, 6, '2024-01-22 16:10:00', '2024-01-29 12:30:00', 'Diabetes descompensada', 6),
(6, 10, '2024-06-15 08:25:00', '2024-06-22 15:40:00', 'Retinopatía diabética', 10),
(6, 12, '2024-09-12 11:15:00', '2024-09-19 13:25:00', 'Control endocrino', 15),

(7, 7, '2024-01-25 13:15:00', '2024-02-01 09:45:00', 'Insuficiencia cardíaca', 7),
(7, 12, '2024-05-30 11:50:00', '2024-06-06 14:15:00', 'Edema pulmonar', 11),
(7, 14, '2024-08-25 16:30:00', '2024-09-01 10:55:00', 'Control cardiológico', 16),

(8, 8, '2024-01-28 10:30:00', '2024-02-04 14:20:00', 'Asma severa', 8),
(8, 13, '2024-03-25 14:45:00', '2024-04-01 10:10:00', 'Broncoespasmo', 12),
(8, 15, '2024-07-18 09:15:00', '2024-07-25 16:30:00', 'Neumonía asmática', 17),

(9, 9, '2024-02-01 08:00:00', '2024-02-08 12:00:00', 'Gastroenteritis aguda', 9),
(9, 14, '2024-06-08 12:20:00', '2024-06-15 08:45:00', 'Deshidratación severa', 13),
(9, 16, '2024-09-20 14:10:00', '2024-09-27 11:35:00', 'Control gastrointestinal', 18),

(10, 10, '2024-02-03 15:45:00', '2024-02-10 11:30:00', 'Hernia discal', 10),
(10, 16, '2024-04-12 07:30:00', '2024-04-19 13:15:00', 'Cirugía de columna', 14),
(10, 18, '2024-08-20 14:00:00', NULL, 'Rehabilitación post-cirugía', 19),

-- Pacientes 11-20 (2 hospitalizaciones cada uno)
(11, 11, '2024-02-05 12:30:00', '2024-02-12 11:15:00', 'Hipertensión arterial crisis', 1),
(11, 17, '2024-07-05 16:25:00', '2024-07-12 09:40:00', 'Accidente cerebrovascular', 5),

(12, 12, '2024-02-08 14:20:00', '2024-02-15 13:45:00', 'Artritis reumatoide aguda', 2),
(12, 19, '2024-05-15 10:35:00', '2024-05-22 15:20:00', 'Artroplastia de cadera', 6),

(13, 13, '2024-02-10 16:10:00', '2024-02-17 10:20:00', 'Anemia severa', 3),
(13, 20, '2024-04-18 08:50:00', '2024-04-25 14:35:00', 'Transfusión sanguínea', 7),

(14, 14, '2024-02-12 09:45:00', '2024-02-19 14:30:00', 'Bronquitis crónica', 4),
(14, 4, '2024-06-25 13:40:00', '2024-07-02 10:55:00', 'EPOC descompensado', 8),

(15, 15, '2024-02-15 11:30:00', '2024-02-22 16:45:00', 'Litiasis renal', 5),
(15, 6, '2024-05-05 15:20:00', '2024-05-12 12:10:00', 'Cólico nefrítico', 9),

(16, 16, '2024-02-18 13:15:00', '2024-02-25 09:30:00', 'Ulcera péptica', 6),
(16, 10, '2024-07-12 14:25:00', '2024-07-19 11:50:00', 'Hemorragia digestiva', 10),

(17, 17, '2024-02-20 15:40:00', '2024-02-27 12:15:00', 'Hepatitis viral', 7),
(17, 12, '2024-06-18 10:05:00', '2024-06-25 16:40:00', 'Cirrosis compensada', 11),

(18, 18, '2024-02-22 08:20:00', '2024-02-29 15:50:00', 'Osteomielitis', 8),
(18, 14, '2024-04-25 12:35:00', '2024-05-02 09:10:00', 'Artritis séptica', 12),

(19, 19, '2024-02-25 10:35:00', '2024-03-03 11:25:00', 'Meningitis bacteriana', 9),
(19, 1, '2024-07-20 13:50:00', '2024-07-27 08:35:00', 'Secuelas neurológicas', 13),

(20, 20, '2024-02-28 12:50:00', '2024-03-06 14:40:00', 'Pancreatitis aguda', 10),
(20, 3, '2024-05-28 09:15:00', '2024-06-04 15:30:00', 'Pseudoguis pancreático', 14),

-- Pacientes 21-30 (2 hospitalizaciones cada uno)
(21, 1, '2024-03-02 14:15:00', '2024-03-09 10:35:00', 'Trauma craneoencefálico leve', 1),
(21, 7, '2024-07-08 16:20:00', '2024-07-15 12:45:00', 'Cefalea post-traumática', 5),

(22, 2, '2024-03-05 16:25:00', '2024-03-12 13:20:00', 'Enfermedad pulmonar obstructiva', 2),
(22, 9, '2024-06-22 08:40:00', '2024-06-29 14:55:00', 'Fibrosis pulmonar', 6),

(23, 3, '2024-03-08 09:40:00', '2024-03-15 15:10:00', 'Diverticulitis', 3),
(23, 11, '2024-05-12 11:25:00', '2024-05-19 09:50:00', 'Absceso diverticular', 7),

(24, 4, '2024-03-11 11:55:00', '2024-03-18 08:45:00', 'Insuficiencia renal aguda', 4),
(24, 13, '2024-07-15 10:10:00', '2024-07-22 16:25:00', 'Diálisis peritoneal', 8),

(25, 5, '2024-03-14 13:30:00', '2024-03-21 12:30:00', 'Trombosis venosa profunda', 5),
(25, 15, '2024-06-10 15:45:00', '2024-06-17 11:20:00', 'Embolia pulmonar', 9),

(26, 6, '2024-03-17 15:45:00', '2024-03-24 14:15:00', 'Sepsis urinaria', 6),
(26, 17, '2024-08-08 12:30:00', '2024-08-15 09:45:00', 'Control infeccioso', 10),

(27, 7, '2024-03-20 08:10:00', '2024-03-27 16:40:00', 'Infarto agudo de miocardio', 7),
(27, 19, '2024-07-25 14:55:00', '2024-08-01 11:10:00', 'Rehabilitación cardíaca', 11),

(28, 8, '2024-03-23 10:25:00', '2024-03-30 09:55:00', 'Accidente cerebrovascular', 8),
(28, 2, '2024-09-05 16:15:00', '2024-09-12 13:40:00', 'Secuelas neurológicas', 12),

(29, 9, '2024-03-26 12:40:00', '2024-04-02 11:05:00', 'Enfermedad de Crohn', 9),
(29, 4, '2024-08-18 09:20:00', '2024-08-25 15:35:00', 'Control gastroenterológico', 13),

(30, 10, '2024-03-29 14:55:00', '2024-04-05 13:35:00', 'Artrosis severa', 10),
(30, 6, '2024-07-30 11:45:00', '2024-08-06 14:20:00', 'Artroplastia de rodilla', 14),

-- Pacientes 31-50 (1 hospitalización cada uno)
(31, 11, '2024-04-01 16:20:00', '2024-04-08 10:50:00', 'Neumonía atípica', 1),
(32, 12, '2024-04-04 08:35:00', '2024-04-11 15:25:00', 'Fractura de cadera', 2),
(33, 13, '2024-04-07 10:50:00', '2024-04-14 12:10:00', 'Colelitiasis sintomática', 3),
(34, 14, '2024-04-10 13:05:00', '2024-04-17 09:40:00', 'Descompensación diabética', 4),
(35, 15, '2024-04-13 15:20:00', '2024-04-20 14:00:00', 'Peritonitis', 5),
(36, 16, '2024-04-16 08:45:00', '2024-04-23 16:30:00', 'Embolia pulmonar', 6),
(37, 17, '2024-04-19 11:00:00', '2024-04-26 10:20:00', 'Cirrosis hepática', 7),
(38, 18, '2024-04-22 13:15:00', '2024-04-29 12:45:00', 'Osteoporosis con fractura', 8),
(39, 19, '2024-04-25 15:30:00', '2024-05-02 08:55:00', 'Esclerosis múltiple', 9),
(40, 20, '2024-04-28 09:55:00', '2024-05-05 15:15:00', 'Lupus eritematoso', 10),

(41, 1, '2024-05-02 12:10:00', '2024-05-09 11:40:00', 'Miastenia gravis', 11),
(42, 2, '2024-05-05 14:25:00', '2024-05-12 09:10:00', 'Poliartritis', 12),
(43, 3, '2024-05-08 16:40:00', '2024-05-15 14:50:00', 'Enfisema pulmonar', 13),
(44, 4, '2024-05-11 09:05:00', '2024-05-18 16:05:00', 'Insuficiencia suprarrenal', 14),
(45, 5, '2024-05-14 11:20:00', '2024-05-21 10:35:00', 'Tirotoxicosis', 15),
(46, 6, '2024-05-17 13:35:00', '2024-05-24 12:25:00', 'Enfermedad de Addison', 16),
(47, 7, '2024-05-20 15:50:00', '2024-05-27 08:15:00', 'Síndrome de Guillain-Barré', 17),
(48, 8, '2024-05-23 08:15:00', '2024-05-30 15:45:00', 'Poliomielitis', 18),
(49, 9, '2024-05-26 10:30:00', '2024-06-02 13:55:00', 'Distrofia muscular', 19),
(50, 10, '2024-05-29 12:45:00', '2024-06-05 11:15:00', 'Esclerodermia', 20),

-- Pacientes 51-70 (1 hospitalización cada uno - algunos actualmente hospitalizados)
(51, 11, '2024-06-01 14:00:00', NULL, 'Observación post-operatoria', 1),
(52, 12, '2024-06-03 16:15:00', NULL, 'Control de dolor crónico', 2),
(53, 13, '2024-06-05 09:30:00', NULL, 'Quimioterapia', 3),
(54, 14, '2024-06-07 11:45:00', NULL, 'Rehabilitación cardiaca', 4),
(55, 15, '2024-06-09 14:00:00', NULL, 'Terapia respiratoria', 5),
(56, 16, '2024-06-11 16:15:00', NULL, 'Desintoxicación', 6),
(57, 17, '2024-06-13 09:30:00', NULL, 'Cuidados paliativos', 7),
(58, 18, '2024-06-15 11:45:00', NULL, 'Nutrición parenteral', 8),
(59, 19, '2024-06-17 14:00:00', NULL, 'Aislamiento respiratorio', 9),
(60, 20, '2024-06-19 16:15:00', NULL, 'Control post-infarto', 10),

(61, 1, '2024-06-21 09:30:00', '2024-06-28 12:45:00', 'Amigdalitis aguda', 11),
(62, 2, '2024-06-23 11:45:00', '2024-06-30 14:20:00', 'Sinusitis crónica', 12),
(63, 3, '2024-06-25 14:00:00', '2024-07-02 10:35:00', 'Otitis media', 13),
(64, 4, '2024-06-27 16:15:00', '2024-07-04 13:50:00', 'Conjuntivitis bacteriana', 14),
(65, 5, '2024-06-29 08:30:00', '2024-07-06 15:05:00', 'Dermatitis de contacto', 15),
(66, 6, '2024-07-01 10:45:00', '2024-07-08 11:20:00', 'Urticaria aguda', 16),
(67, 7, '2024-07-03 13:00:00', '2024-07-10 09:35:00', 'Absceso cutáneo', 17),
(68, 8, '2024-07-05 15:15:00', '2024-07-12 14:50:00', 'Celulitis', 18),
(69, 9, '2024-07-07 08:40:00', '2024-07-14 16:25:00', 'Lumbalgia aguda', 19),
(70, 10, '2024-07-09 10:55:00', '2024-07-16 12:10:00', 'Cervicalgia', 20),

-- Pacientes 71-98 (1 hospitalización cada uno)
(71, 11, '2024-07-11 13:10:00', '2024-07-18 10:45:00', 'Esguince de tobillo', 1),
(72, 12, '2024-07-13 15:25:00', '2024-07-20 14:00:00', 'Luxación de hombro', 2),
(73, 13, '2024-07-15 08:50:00', '2024-07-22 16:35:00', 'Fractura de radio', 3),
(74, 14, '2024-07-17 11:05:00', '2024-07-24 09:20:00', 'Contractura muscular', 4),
(75, 15, '2024-07-19 13:20:00', '2024-07-26 15:55:00', 'Tendinitis', 5),
(76, 16, '2024-07-21 15:35:00', '2024-07-28 12:30:00', 'Bursitis', 6),
(77, 17, '2024-07-23 09:00:00', '2024-07-30 14:45:00', 'Síndrome del túnel carpiano', 7),
(78, 18, '2024-07-25 11:15:00', '2024-08-01 10:10:00', 'Fascitis plantar', 8),
(79, 19, '2024-07-27 13:30:00', '2024-08-03 16:25:00', 'Epicondilitis', 9),
(80, 20, '2024-07-29 15:45:00', '2024-08-05 08:40:00', 'Tenosinovitis', 10),

(81, 1, '2024-08-01 08:00:00', NULL, 'Post-operatorio cirugía mayor', 11),
(82, 2, '2024-08-02 10:30:00', NULL, 'Control de marcapasos', 12),
(83, 3, '2024-08-03 13:00:00', NULL, 'Monitorización cardiaca', 13),
(84, 4, '2024-08-04 15:30:00', NULL, 'Terapia intensiva', 14),
(85, 5, '2024-08-05 09:00:00', NULL, 'Ventilación mecánica', 15),
(86, 6, '2024-08-06 11:30:00', NULL, 'Hemodiálisis', 16),
(87, 7, '2024-08-07 14:00:00', NULL, 'Nutrición enteral', 17),
(88, 8, '2024-08-08 16:30:00', NULL, 'Rehabilitación neurológica', 18),
(89, 9, '2024-08-09 08:30:00', NULL, 'Cuidados intensivos neonatales', 19),
(90, 10, '2024-08-10 11:00:00', NULL, 'Aislamiento de contacto', 20),

(91, 11, '2024-08-11 13:30:00', '2024-08-18 10:15:00', 'Varicela complicada', 1),
(92, 12, '2024-08-12 16:00:00', '2024-08-19 14:45:00', 'Paperas con complicaciones', 2),
(93, 13, '2024-08-13 08:45:00', '2024-08-20 16:30:00', 'Rubéola en adulto', 3),
(94, 14, '2024-08-14 11:15:00', '2024-08-21 09:00:00', 'Sarampión importado', 4),
(95, 15, '2024-08-15 13:45:00', '2024-08-22 15:20:00', 'Dengue hemorrágico', 5),
(96, 16, '2024-08-16 16:15:00', '2024-08-23 12:50:00', 'Zika con complicaciones', 6),
(97, 17, '2024-08-17 09:30:00', '2024-08-24 14:15:00', 'Chikungunya severo', 7),
(98, 18, '2024-08-18 12:00:00', '2024-08-25 10:35:00', 'Fiebre tifoidea', 8);

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

TRUNCATE TABLE ingreso_cuarto CASCADE;
ALTER SEQUENCE ingreso_cuarto_id_ingreso_cuarto_seq RESTART WITH 1;

-- 61 pacientes con 1 ingreso (Pacientes 1-61)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(1,1,'2024-01-10 10:00','2024-01-15 12:00','Fiebre alta',1),
(2,2,'2024-02-01 09:00','2024-02-05 11:00','Trauma leve',2),
(3,3,'2024-03-05 08:30','2024-03-10 10:00','Observación pediátrica',11),
(4,4,'2024-04-12 14:00','2024-04-14 09:00','Deshidratación',12),
(5,5,'2024-05-20 16:00','2024-05-23 08:00','Cirugía ambulatoria',5),
(6,6,'2024-06-01 07:00','2024-06-05 10:00','Control',6),
(7,7,'2024-07-10 12:00','2024-07-12 09:00','Fractura',5),
(8,8,'2024-08-21 11:00','2024-08-27 13:00','Asma',7),
(9,9,'2024-09-11 09:20','2024-09-15 15:00','Infección',3),
(10,10,'2024-10-01 10:00','2024-10-05 18:00','Control',4),
(11,11,'2024-01-15 09:00','2024-01-20 12:00','Observación',8),
(12,12,'2024-02-10 10:30','2024-02-12 11:00','Dolor abdominal',9),
(13,13,'2024-03-20 13:00','2024-03-30 10:00','Cirugía mayor',10),
(14,14,'2024-04-05 08:00','2024-04-07 09:00','Control',2),
(15,15,'2024-05-12 09:30','2024-05-15 11:00','Infección',1),
(16,16,'2024-06-18 14:00','2024-06-22 10:00','Trauma',5),
(17,17,'2024-07-23 07:30','2024-07-28 12:00','Observación',6),
(18,18,'2024-08-01 11:00','2024-08-03 08:00','Control',7),
(19,19,'2024-09-09 12:00','2024-09-13 09:00','Pediatría',11),
(20,20,'2024-10-10 10:00','2024-10-12 10:00','Consulta',12),
(21,1,'2024-01-02 09:00','2024-01-04 10:00','Dolor',3),
(22,2,'2024-02-03 08:30','2024-02-06 11:00','Observación',4),
(23,3,'2024-03-07 09:00','2024-03-09 09:30','Asma',7),
(24,4,'2024-04-08 13:00','2024-04-10 12:00','Control',6),
(25,5,'2024-05-09 15:00','2024-05-12 09:00','Dolor abdominal',9),
(26,6,'2024-06-11 10:00','2024-06-15 08:00','Fractura',5),
(27,7,'2024-07-14 11:00','2024-07-16 07:00','Infección',3),
(28,8,'2024-08-17 12:00','2024-08-20 09:00','Observación',2),
(29,9,'2024-09-19 07:40','2024-09-21 10:00','Control',1),
(30,10,'2024-10-21 09:20','2024-10-25 14:00','Cirugía',10),
(31,11,'2024-01-25 08:00','2024-01-28 11:00','Observación',8),
(32,12,'2024-02-28 10:00','2024-03-02 09:00','Control',9),
(33,13,'2024-03-30 12:00','2024-04-02 09:00','Dolor',4),
(34,14,'2024-04-12 11:00','2024-04-15 10:00','Pediatría',11),
(35,15,'2024-05-18 09:00','2024-05-20 08:00','Infección',3),
(36,16,'2024-06-20 14:00','2024-06-24 12:00','Trauma',5),
(37,17,'2024-07-22 13:00','2024-07-26 09:00','Observación',6),
(38,18,'2024-08-24 10:00','2024-08-27 11:00','Control',7),
(39,19,'2024-09-26 09:00','2024-09-30 08:00','Cirugía',10),
(40,20,'2024-10-28 08:30','2024-11-02 10:00','Dolor',2),
(41,1,'2024-01-30 10:00','2024-02-03 09:00','Observación',1),
(42,2,'2024-02-14 09:00','2024-02-18 11:00','Infección',3),
(43,3,'2024-03-16 08:00','2024-03-19 09:00','Fractura',5),
(44,4,'2024-04-18 12:00','2024-04-20 10:00','Asma',7),
(45,5,'2024-05-20 07:00','2024-05-22 08:00','Control',6),
(46,6,'2024-06-22 11:00','2024-06-25 09:00','Dolor abdominal',9),
(47,7,'2024-07-24 09:30','2024-07-27 10:00','Observación',8),
(48,8,'2024-08-26 10:30','2024-08-29 12:00','Infección',3),
(49,9,'2024-09-28 13:00','2024-10-01 09:00','Cirugía',10),
(50,10,'2024-10-30 08:00','2024-11-03 07:00','Control',4),
(51,11,'2024-01-05 09:00','2024-01-07 09:00','Dolor',2),
(52,12,'2024-02-06 11:00','2024-02-09 08:00','Trauma',5),
(53,13,'2024-03-08 07:00','2024-03-12 10:00','Observación',6),
(54,14,'2024-04-09 09:00','2024-04-11 10:00','Asma',7),
(55,15,'2024-05-10 10:00','2024-05-13 09:00','Infección',3),
(56,16,'2024-06-11 08:00','2024-06-15 11:00','Fractura',5),
(57,17,'2024-07-12 12:00','2024-07-15 09:00','Control',6),
(58,18,'2024-08-13 09:00','2024-08-16 10:00','Observación',8),
(59,19,'2024-09-14 11:00','2024-09-17 09:00','Cirugía',10),
(60,20,'2024-10-15 08:00','2024-10-20 12:00','Dolor',1),
(61,1,'2024-11-01 09:00','2024-11-04 09:00','Control',2);

-- 10 pacientes con 2 hospitalizaciones cada uno (Pacientes 62-71)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(62,2,'2023-12-01 09:00','2023-12-05 10:00','Observación',3),
(62,3,'2024-02-01 08:00','2024-02-04 09:00','Control',4),
(63,4,'2024-01-10 10:00','2024-01-14 11:00','Fractura',5),
(63,5,'2024-03-20 09:00','2024-03-24 12:00','Control',6),
(64,6,'2024-04-01 09:30','2024-04-06 10:00','Cirugía',10),
(64,7,'2024-06-10 08:00','2024-06-14 09:00','Observación',8),
(65,8,'2024-05-05 11:00','2024-05-10 12:00','Infección',3),
(65,9,'2024-09-01 09:00','2024-09-05 10:00','Control',2),
(66,10,'2024-07-07 10:00','2024-07-11 11:00','Dolor',1),
(66,11,'2024-08-08 12:00','2024-08-12 09:00','Control',4),
(67,12,'2024-02-14 09:00','2024-02-18 10:00','Trauma',5),
(67,13,'2024-03-14 07:00','2024-03-18 09:00','Control',6),
(68,14,'2024-04-20 08:00','2024-04-25 10:00','Cirugía',10),
(68,15,'2024-06-22 09:00','2024-06-26 11:00','Observación',8),
(69,16,'2024-05-02 09:00','2024-05-06 09:00','Infección',3),
(69,17,'2024-07-02 10:00','2024-07-06 12:00','Control',2),
(70,18,'2024-08-03 08:00','2024-08-07 09:00','Asma',7),
(70,19,'2024-09-04 11:00','2024-09-08 10:00','Control',1),
(71,20,'2024-10-05 09:00','2024-10-09 09:00','Dolor',4),
(71,1,'2024-11-06 09:30','2024-11-10 10:30','Control',3);

-- 5 pacientes con 3 hospitalizaciones cada uno (Pacientes 72-76)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(72,2,'2023-11-01 09:00','2023-11-04 10:00','Observación',5),
(72,3,'2024-01-02 08:00','2024-01-05 09:00','Control',6),
(72,4,'2024-03-03 09:00','2024-03-06 10:00','Cirugía',10),
(73,5,'2023-12-10 10:00','2023-12-14 11:00','Fractura',5),
(73,6,'2024-02-12 09:00','2024-02-16 12:00','Control',2),
(73,7,'2024-04-14 08:00','2024-04-18 09:00','Observación',3),
(74,8,'2023-10-15 11:00','2023-10-20 12:00','Infección',4),
(74,9,'2024-01-20 09:00','2024-01-24 10:00','Control',6),
(74,10,'2024-03-22 10:00','2024-03-26 11:00','Cirugía',10),
(75,11,'2023-09-05 09:00','2023-09-07 09:00','Asma',7),
(75,12,'2024-02-08 08:00','2024-02-12 09:00','Control',1),
(75,13,'2024-05-10 10:00','2024-05-14 10:00','Observación',8),
(76,14,'2023-08-01 10:00','2023-08-04 10:00','Fractura',5),
(76,15,'2024-02-15 09:00','2024-02-19 09:00','Control',4),
(76,16,'2024-06-20 08:00','2024-06-24 09:00','Cirugía',10);

-- 1 paciente con 4 hospitalizaciones (Paciente 77)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(77,17,'2022-01-01 09:00','2022-01-05 10:00','Control prolongado',2),
(77,18,'2022-06-01 09:00','2022-06-05 09:00','Revisión',3),
(77,19,'2023-03-01 08:00','2023-03-10 09:00','Tratamiento',4),
(77,20,'2024-11-01 10:00',NULL,'Ingreso actual',5);

-- 21 pacientes restantes con 1 hospitalización cada uno (Pacientes 78-98)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(78,1,'2024-01-08 14:00','2024-01-12 11:00','Hipertensión',7),
(79,2,'2024-02-15 10:30','2024-02-20 09:00','Diabetes',8),
(80,3,'2024-03-22 08:45','2024-03-27 14:00','Artritis',9),
(81,4,'2024-04-10 11:20','2024-04-15 16:30','Migraña',10),
(82,5,'2024-05-05 13:15','2024-05-10 10:45','Alergia',11),
(83,6,'2024-06-18 09:30','2024-06-23 12:15','Ansiedad',12),
(84,7,'2024-07-25 16:00','2024-07-30 08:20','Depresión',13),
(85,8,'2024-08-12 07:45','2024-08-17 15:10','Insomnio',14),
(86,9,'2024-09-03 12:30','2024-09-08 11:25','Obesidad',15),
(87,10,'2024-10-20 14:45','2024-10-25 09:35','Anemia',16),
(88,11,'2024-11-07 10:10','2024-11-12 13:50','Asma',17),
(89,12,'2024-12-14 08:20','2024-12-19 16:40','Bronquitis',18),
(90,13,'2024-01-25 15:30','2024-01-30 10:15','Neumonía',19),
(91,14,'2024-02-28 11:40','2024-03-04 14:25','Sinusitis',20),
(92,15,'2024-03-15 09:55','2024-03-20 12:05','Rinitis',1),
(93,16,'2024-04-22 13:20','2024-04-27 08:45','Conjuntivitis',2),
(94,17,'2024-05-30 16:35','2024-06-04 11:30','Dermatitis',3),
(95,18,'2024-06-08 07:50','2024-06-13 15:55','Psoriasis',4),
(96,19,'2024-07-19 12:05','2024-07-24 09:40','Acné',5),
(97,20,'2024-08-26 14:50','2024-08-31 13:15','Urticaria',6),
(98,1,'2024-09-11 10:25','2024-09-16 16:20','Alopecia',7);

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

-- Telefono
TRUNCATE TABLE telefono CASCADE;
ALTER SEQUENCE telefono_id_telefono_seq RESTART WITH 1;

-- Insertar teléfonos para pacientes (usando IDs 1-10 que sabemos existen)
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(1,1,NULL,'3105001001','Teléfono principal'),
(1,2,NULL,'3105001002','Contacto directo'),
(1,3,NULL,'3105001003','Teléfono celular'),
(1,4,NULL,'3105001004','Número personal'),
(1,5,NULL,'3105001005','Comunicación preferida'),
(1,6,NULL,'3105001006','Teléfono de casa'),
(1,7,NULL,'3105001007','Contacto emergencia'),
(1,8,NULL,'3105001008','Número secundario'),
(1,9,NULL,'3105001009','Teléfono trabajo'),
(1,10,NULL,'3105001010','Comunicación familiar');

-- Insertar teléfonos para médicos (usando IDs 1-10 que sabemos existen)
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(1,NULL,1,'3106001001','Consultorio principal'),
(1,NULL,2,'3106001002','Urgencias'),
(2,NULL,3,'6046003001','Fijo consultorio'),
(1,NULL,4,'3106001004','Celular personal'),
(1,NULL,5,'3106001005','Contacto directo'),
(2,NULL,6,'6046003002','Fijo hospital'),
(1,NULL,7,'3106001007','Guardia médica'),
(1,NULL,8,'3106001008','Emergencias 24h'),
(2,NULL,9,'6046003003','Consultorio fijo'),
(1,NULL,10,'3106001010','Coordinación citas');

-- Insertar teléfonos de emergencia para pacientes
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(3,1,NULL,'3107001001','Contacto emergencia familiar'),
(3,2,NULL,'3107001002','Emergencias 24/7'),
(3,3,NULL,'3107001003','Familiar directo'),
(3,4,NULL,'3107001004','Contacto urgente'),
(3,5,NULL,'3107001005','Emergencia médica'),
(3,6,NULL,'3107001006','Familiar responsable'),
(3,7,NULL,'3107001007','Contacto prioritario'),
(3,8,NULL,'3107001008','Emergencia familiar'),
(3,9,NULL,'3107001009','Contacto inmediato'),
(3,10,NULL,'3107001010','Urgencias');

-- Insertar teléfonos fijos para pacientes
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(2,11,NULL,'6045002001','Teléfono fijo casa'),
(2,12,NULL,'6045002002','Línea residencial'),
(2,13,NULL,'6045002003','Fijo principal'),
(2,14,NULL,'6045002004','Casa familiar'),
(2,15,NULL,'6045002005','Teléfono hogar');

-- Insertar teléfonos para médicos especialistas
INSERT INTO telefono (id_tipo_telefono, id_paciente, id_medico, numero, observacion) VALUES
(1,NULL,11,'3106002011','Cardiología'),
(1,NULL,12,'3106002012','Pediatría'),
(2,NULL,13,'6046003013','Traumatología fijo'),
(1,NULL,14,'3106002014','Ginecología'),
(1,NULL,15,'3106002015','Neurología'),
(2,NULL,16,'6046003016','Dermatología fijo'),
(1,NULL,17,'3106002017','Oftalmología'),
(1,NULL,18,'3106002018','Ortopedia'),
(2,NULL,19,'6046003019','Psiquiatría fijo'),
(1,NULL,20,'3106002020','Oncología');

ALTER SEQUENCE prescripcion_id_prescripcion_seq RESTART WITH 1;

-- ESPECIALIDAD_MEDICO
INSERT INTO especialidad_medico (id_medico, id_especialidad) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
(11,1),(12,2),(13,3),(14,4),(15,5),(16,6),(17,7),(18,8),(19,9),(20,10),
(21,1),(22,2),(23,3),(24,4),(25,5),(26,6),(27,7),(28,8),(29,9),(30,10);

ALTER SEQUENCE especialidad_medico_id_especialidad_medico_seq RESTART WITH 1;

-- VISITAS
SELECT 
    (SELECT COUNT(*) FROM paciente) as total_pacientes,
    (SELECT COUNT(*) FROM visitante) as total_visitantes;

-- Insertar 10 registros de visitas
INSERT INTO visita (id_paciente, id_visitante, fecha_visita, relacion, observaciones) VALUES

-- Visita 1: Padre visitando a su hijo
(1, 1, '2024-01-11 10:30:00', 'Padre', 'Visita de control post-operatorio. Paciente estable.'),

-- Visita 2: Madre visitando a su hija
(3, 2, '2024-01-16 15:45:00', 'Madre', 'Trajo medicamentos y alimentos especiales. Paciente con buen ánimo.'),

-- Visita 3: Esposa visitando a su esposo
(5, 5, '2024-01-21 14:20:00', 'Esposa', 'Visita de acompañamiento. Paciente en recuperación favorable.'),

-- Visita 4: Hermana visitando a su hermano
(8, 3, '2024-02-02 11:15:00', 'Hermana', 'Control de evolución. Trajo ropa y artículos personales.'),

-- Visita 5: Amiga visitando a paciente
(12, 7, '2024-02-15 16:30:00', 'Amiga', 'Visita de apoyo emocional. Compañía durante terapia.'),

-- Visita 6: Hijo visitando a su padre
(15, 6, '2024-03-08 09:45:00', 'Hijo', 'Visita familiar. Coordinación de cuidados post-alta.'),

-- Visita 7: Primo visitando a familiar
(18, 8, '2024-04-20 13:10:00', 'Primo', 'Visita sorpresa. Paciente con buena evolución clínica.'),

-- Visita 8: Tía visitando a sobrino
(20, 9, '2024-05-12 10:00:00', 'Tía', 'Acompañamiento durante procedimiento médico.'),

-- Visita 9: Sobrino visitando a tío
(22, 10, '2024-06-25 15:20:00', 'Sobrino', 'Visita de cortesía. Revisión de estado general.'),

-- Visita 10: Hermano visitando a hermana
(25, 4, '2024-07-18 12:45:00', 'Hermano', 'Entrega de documentación médica. Coordinación con equipo tratante.');


-- Verificar que existen tipos de procedimiento
SELECT 
    (SELECT COUNT(*) FROM tipo_procedimiento) as total_tipos_procedimiento;

-- Insertar 15 registros de procedimientos médicos
INSERT INTO procedimiento (id_tipo_procedimiento, nombre, descripcion) VALUES

-- CIRUGÍAS (Tipo 1)
(1, 'Apéndicectomía laparoscópica', 'Extracción del apéndice vermicular mediante técnica mínimamente invasiva'),
(1, 'Colecistectomía abierta', 'Remoción de la vesícula biliar por incisión subcostal derecha'),
(1, 'Herniorrafia inguinal', 'Reparación quirúrgica de hernia en región inguinal con malla'),
(1, 'Artroplastia total de cadera', 'Reemplazo total de la articulación de la cadera con prótesis'),
(1, 'Cirugía de columna lumbar', 'Descompresión y estabilización de vértebras lumbares'),

-- CONSULTAS (Tipo 2)
(2, 'Consulta de medicina general', 'Evaluación integral del estado de salud y manejo de patologías comunes'),
(2, 'Consulta de seguimiento post-operatorio', 'Control evolutivo después de intervención quirúrgica'),
(2, 'Consulta de valoración pre-anestésica', 'Evaluación de riesgo anestésico previo a procedimiento'),
(2, 'Consulta de especialidad cardiológica', 'Valoración cardiovascular y manejo de enfermedades del corazón'),

-- TERAPIAS (Tipo 3)
(3, 'Fisioterapia respiratoria', 'Técnicas para mejorar la función pulmonar y capacidad respiratoria'),
(3, 'Rehabilitación neurológica', 'Terapia para recuperación de funciones tras daño neurológico'),
(3, 'Terapia de lenguaje y comunicación', 'Intervención para trastornos del habla y comunicación'),
(3, 'Hidroterapia', 'Uso terapéutico del agua para rehabilitación musculoesquelética'),
(3, 'Electroterapia analgésica', 'Aplicación de corrientes eléctricas para manejo del dolor'),
(3, 'Terapia ocupacional', 'Entrenamiento para recuperación de actividades de la vida diaria');


-- ======================
-- FIN del script CORREGIDO (adaptado al DDL original)
-- ======================

-- Recomendación: ejecutar este archivo **antes** de correr el script de modificaciones (DDL-Modificacion.sql).
