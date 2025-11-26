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

-- PAIS
INSERT INTO pais (codigo_pais, nombre) VALUES
('CO', 'Colombia');

-- DEPARTAMENTOS (referencian pais.id_pais = 1)
INSERT INTO departamento (id_pais, codigo, nombre) VALUES
(1, 'ANT', 'Antioquia'),
(1, 'CUN', 'Cundinamarca'),
(1, 'VAP', 'Valle del Cauca'),
(1, 'ATL', 'Atlántico');

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

-- ESTADO_EPS
INSERT INTO estado_eps (nombre) VALUES ('activa'), ('inactiva');

-- EPS (referencian estado_eps)
INSERT INTO eps (codigo_eps, nombre, id_estado_eps, telefono, direccion) VALUES
('EPS01','Salud Total',1,'6041234567','Calle 10 #20-30'),
('EPS02','Sura',1,'6047654321','Carrera 50 #40-20'),
('EPS03','Sanitas',1,'6049988776','Avenida 30 #10-15');

-- TIPO_CUARTO
INSERT INTO tipo_cuarto (nombre, capacidad) VALUES ('privado',1),('compartido',2);

-- ESTADO_CUARTO
INSERT INTO estado_cuarto (nombre) VALUES ('disponible'), ('ocupado');

-- TIPO_TELEFONO
INSERT INTO tipo_telefono (nombre) VALUES ('móvil'), ('fijo'), ('emergencia');

-- TIPO_PROCEDIMIENTO
INSERT INTO tipo_procedimiento (nombre) VALUES ('Cirugía'), ('Consulta'), ('Terapia');

-- ESTADO_TARJETA
INSERT INTO estado_tarjeta (nombre) VALUES ('activa'), ('inactiva');

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

-- MEDICAMENTOS (mínimo 10) -- usar columna 'nombre' (DDL original)
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

-- ======================
-- 2) HOSPITALES, PLANTAS, CUARTOS
-- ======================

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

-- Una planta por hospital
INSERT INTO planta (id_hospital, nombre, piso) VALUES
(1,'Planta A',1),(2,'Planta A',2),(3,'Planta A',1),(4,'Planta A',1),(5,'Planta A',2),
(6,'Planta A',1),(7,'Planta A',3),(8,'Planta A',1),(9,'Planta A',2),(10,'Planta A',1);

-- Cuartos (2 por planta)
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

-- ======================
-- 3) ENFERMEROS (10) -- respetar columnas originales 'nombres' 'apellidos'
-- ======================

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



-- ======================
-- duplicado intencional para provocar el error pedido (mismo numero_documento)
-- INSERT INTO enfermero (tipo_documento, numero_documento, nombres, apellidos, sexo, telefono, correo) VALUES ('CC','110000009','Carlos','Gómez','M','3001002009','cgomez_dup@example.com');
-- ======================





-- ======================
-- 4) MÉDICOS (30) -- usar columnas originales 'nombres' 'apellidos' y id_especialidad
-- ======================

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

-- duplicado intencional (mismo numero_documento que 210000010)
--INSERT INTO medico (tipo_documento, numero_documento, nombres, apellidos, id_especialidad, registro_profesional, telefono, correo) VALUES
--('CC','210000010','Andrés Felipe','Torres',10,'REG010D','3101009999','andresf.t.dup@example.com');

-- ======================
-- 5) PACIENTES (100) -- usar 'nombres' + 'apellidos' como en el DDL original
-- ======================

-- 1-10 años: 10 registros (5 M, 5 F)
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

-- 21-40 años: 20 registros
INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
('CC','300000026','Juan','Pérez','1990-05-10','M',3,2,'3102003026','juan.p@example.com'),
('CC','300000027','Andrés','Gómez','1995-07-14','M',3,2,'3102003027','andres.g@example.com'),
('CC','300000028','Sergio','Ramos','1992-09-18','M',3,2,'3102003028','sergio.r@example.com'),
('CC','300000029','Ricardo','Domínguez','1989-12-01','M',3,2,'3102003029','ricardo.d@example.com'),
('CC','300000030','Andrés Felipe','Lara','1998-03-03','M',3,2,'3102003030','andresf.l@example.com'),
('CC','300000031','María','Santos','1991-02-02','F',3,2,'3102003031','maria.s@example.com'),
('CC','300000032','Catalina','Pérez','1988-08-08','F',3,2,'3102003032','catalina.p@example.com'),
('CC','300000033','Alejandra','García','1993-06-06','F',3,2,'3102003033','alejandra.g@example.com'),
('CC','300000034','Lorena','Mendoza','1994-04-04','F',3,2,'3102003034','lorena.m@example.com'),
('CC','300000035','Daniela','Castro','1996-01-01','F',3,2,'3102003035','daniela.c@example.com'),
('CC','300000036','Fernando','Suárez','1987-11-11','M',3,2,'3102003036','fernando.s@example.com'),
('CC','300000037','Roberto','Vega','1990-10-10','M',3,2,'3102003037','roberto.v@example.com'),
('CC','300000038','Pablo','Rueda','1985-09-09','M',3,2,'3102003038','pablo.r@example.com'),
('CC','300000039','María Paula','Londoño','1992-12-12','F',3,2,'3102003039','mariap.l@example.com'),
('CC','300000040','Claudia','Gómez','1986-02-02','F',3,2,'3102003040','claudia.g@example.com'),
('CC','300000041','Andrés','Mesa','1997-03-03','M',3,2,'3102003041','andres.mesa@example.com'),
('CC','300000042','Jorge','León','1989-07-07','M',3,2,'3102003042','jorge.l@example.com'),
('CC','300000043','Mariana','Suárez','1988-05-05','F',3,2,'3102003043','mariana.su@example.com'),
('CC','300000044','Verónica','Paz','1991-09-09','F',3,2,'3102003044','veronica.p@example.com');

-- 41-60 años: 25 registros
INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
('CC','300000045','Hernán','Castro','1975-06-06','M',4,3,'3102003045','hernan.c@example.com'),
('CC','300000046','Gustavo','Ospina','1968-08-08','M',4,3,'3102003046','gustavo.o@example.com'),
('CC','300000047','Alberto','Molina','1965-01-01','M',4,3,'3102003047','alberto.m@example.com'),
('CC','300000048','Joaquín','Cárdenas','1970-02-02','M',4,3,'3102003048','joaquin.c@example.com'),
('CC','300000049','Óscar','Benítez','1962-03-03','M',4,3,'3102003049','oscar.b@example.com'),
('CC','300000050','Ricarda','Peña','1978-04-04','F',4,3,'3102003050','ricarda.p@example.com'),
('CC','300000051','Beatriz','Gil','1969-05-05','F',4,3,'3102003051','beatriz.g@example.com'),
('CC','300000052','Clara','Suárez','1974-06-06','F',4,3,'3102003052','clara.s@example.com'),
('CC','300000053','Martha','Ordoñez','1961-07-07','F',4,3,'3102003053','martha.o@example.com'),
('CC','300000054','Elsa','Montoya','1973-08-08','F',4,3,'3102003054','elsa.m@example.com'),
('CC','300000055','Fernando','Quesada','1960-09-09','M',4,3,'3102003055','fernando.q@example.com'),
('CC','300000056','Rafael','Suárez','1965-10-10','M',4,3,'3102003056','rafael.s@example.com'),
('CC','300000057','Marcos','Arias','1959-11-11','M',4,3,'3102003057','marcos.a@example.com'),
('CC','300000058','Lorena','Vélez','1967-12-12','F',4,3,'3102003058','lorena.v@example.com'),
('CC','300000059','Noemí','Delgado','1972-01-01','F',4,3,'3102003059','noemi.d@example.com'),
('CC','300000060','Silvia','Rincón','1966-02-02','F',4,3,'3102003060','silvia.r@example.com'),
('CC','300000061','Wilmer','Calderón','1963-03-03','M',4,3,'3102003061','wilmer.c@example.com'),
('CC','300000062','Germán','Patiño','1958-04-04','M',4,3,'3102003062','german.p@example.com'),
('CC','300000063','Andrés','Trujillo','1964-05-05','M',4,3,'3102003063','andres.t@example.com'),
('CC','300000064','Norma','Serrano','1971-06-06','F',4,3,'3102003064','norma.s@example.com'),
('CC','300000065','Gloria','Ruiz','1962-07-07','F',4,3,'3102003065','gloria.r@example.com'),
('CC','300000066','Patricia','Mora','1960-08-08','F',4,3,'3102003066','patricia.m@example.com'),
('CC','300000067','Hugo','Salazar','1957-09-09','M',4,3,'3102003067','hugo.s@example.com'),
('CC','300000068','Javier','Pinto','1961-10-10','M',4,3,'3102003068','javier.p@example.com');

-- 61+ años: 30 registros
INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
('CC','300000069','María del Carmen','Guzmán','1945-11-11','F',1,2,'3102003069','mariadc.g@example.com'),
('CC','300000070','Ramón','Vargas','1950-12-12','M',1,2,'3102003070','ramon.v@example.com'),
('CC','300000071','Benjamín','López','1948-01-01','M',1,2,'3102003071','benjamin.l@example.com'),
('CC','300000072','Evelyn','Herrera','1952-02-02','F',1,2,'3102003072','evelyn.h@example.com'),
('CC','300000073','Olga','Pérez','1939-03-03','F',1,2,'3102003073','olga.p@example.com'),
('CC','300000074','Ramona','Sosa','1955-04-04','F',1,2,'3102003074','ramona.s@example.com'),
('CC','300000075','Héctor','Molina','1954-05-05','M',1,2,'3102003075','hector.m@example.com'),
('CC','300000076','Carmen','Rojas','1958-06-06','F',1,2,'3102003076','carmen.r@example.com'),
('CC','300000077','Rosa','García','1946-07-07','F',1,2,'3102003077','rosa.g@example.com'),
('CC','300000078','Alfaro','Jiménez','1951-08-08','M',1,2,'3102003078','alfaro.j@example.com'),
('CC','300000079','Elda','Cárdenas','1949-09-09','F',1,2,'3102003079','elda.c@example.com'),
('CC','300000080','Marcos','Aguirre','1953-10-10','M',1,2,'3102003080','marcos.a@example.com'),
('CC','300000081','Gloria','Nava','1956-11-11','F',1,2,'3102003081','gloria.n@example.com'),
('CC','300000082','Estela','Parra','1947-12-12','F',1,2,'3102003082','estela.p@example.com'),
('CC','300000083','Federico','Salcedo','1952-01-05','M',1,2,'3102003083','federico.s@example.com'),
('CC','300000084','Mariano','Vélez','1944-02-06','M',1,2,'3102003084','mariano.v@example.com'),
('CC','300000085','Lina','Córdoba','1943-03-07','F',1,2,'3102003085','lina.c@example.com'),
('CC','300000086','Nora','Santos','1942-04-08','F',1,2,'3102003086','nora.s@example.com'),
('CC','300000087','Eugenio','Márquez','1950-05-09','M',1,2,'3102003087','eugenio.m@example.com'),
('CC','300000088','Mercedes','Toro','1938-06-10','F',1,2,'3102003088','mercedes.t@example.com'),
('CC','300000089','Ramiro','Orjuela','1951-07-11','M',1,2,'3102003089','ramiro.o@example.com'),
('CC','300000090','Elsa','Durán','1940-08-12','F',1,2,'3102003090','elsa.d@example.com'),
('CC','300000091','Octavio','Vargas','1946-09-13','M',1,2,'3102003091','octavio.v@example.com'),
('CC','300000092','Adela','Pineda','1945-10-14','F',1,2,'3102003092','adela.p@example.com'),
('CC','300000093','Santiago','Mora','1953-11-15','M',1,2,'3102003093','santiago.mora@example.com'),
('CC','300000094','Rita','Quintero','1949-12-16','F',1,2,'3102003094','rita.q@example.com'),
('CC','300000095','Lucía','Suárez','1957-01-17','F',1,2,'3102003095','lucia.su@example.com'),
('CC','300000096','Andrés','Córdoba','1941-02-18','M',1,2,'3102003096','andres.c@example.com'),
('CC','300000097','Bernarda','Henao','1947-03-19','F',1,2,'3102003097','bernarda.h@example.com'),
('CC','300000098','Elias','Fajardo','1954-04-20','M',1,2,'3102003098','elias.f@example.com');




-- ======================
-- paciente repetido intencional (mismo numero_documento que 300000030)
--INSERT INTO paciente (tipo_documento, numero_documento, nombres, apellidos, fecha_nacimiento, sexo, id_ciudad, id_eps, telefono, correo) VALUES
--('CC','300000030','Andrés Felipe','Lara','1998-03-03','M',3,2,'3102003999','andresf.l.dup@example.com');
-- ======================





-- ======================
-- 6) INGRESOS / HOSPITALIZACIONES (100 registros)
-- Distribución: 61 pacientes x1, 10 patients x2 (20), 5 patients x3 (15), 1 patient x4 (4) = 100
-- Use id_paciente values as inserted above (order preserved)
-- ======================

-- Primero 61 pacientes con 1 ingreso
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

-- 10 patients with 2 hospitalizations each (patients 62..71 -> 20 records)
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

-- 5 patients with 3 hospitalizations each (patients 72..76 -> 15 records)
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

-- 1 patient with 4 hospitalizations (patient 77 -> 4 records)
INSERT INTO ingreso_cuarto (id_paciente, id_cuarto, fecha_ingreso, fecha_salida, motivo_ingreso, id_medico_responsable) VALUES
(77,17,'2022-01-01 09:00','2022-01-05 10:00','Control prolongado',2),
(77,18,'2022-06-01 09:00','2022-06-05 09:00','Revisión',3),
(77,19,'2023-03-01 08:00','2023-03-10 09:00','Tratamiento',4),
(77,20,'2024-11-01 10:00',NULL,'Ingreso actual',5);

-- ======================
-- 7) VISITANTES y TARJETAS (mínimo 10)
-- ======================

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

-- ======================
-- 8) TELÉFONOS (usar columna 'numero' en DDL original)
-- ======================

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

-- ======================
-- 9) DIAGNÓSTICOS (10)
-- ======================

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

-- ======================
-- 10) VISITAS MÉDICAS (usar columnas originales: notas, diagnostico_id)
-- ======================

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

-- PRESCRIPCIONES (10)
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

-- ======================
-- 11) ESPECIALIDAD_MEDICO asignaciones
-- ======================

INSERT INTO especialidad_medico (id_medico, id_especialidad) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
(11,1),(12,2),(13,3),(14,4),(15,5),(16,6),(17,7),(18,8),(19,9),(20,10),
(21,1),(22,2),(23,3),(24,4),(25,5),(26,6),(27,7),(28,8),(29,9),(30,10);

-- ======================
-- FIN del script CORREGIDO (adaptado al DDL original)
-- ======================

-- Recomendación: ejecutar este archivo **antes** de correr el script de modificaciones (DDL-Modificacion.sql).
