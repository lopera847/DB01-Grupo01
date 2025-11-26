--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE MODIFICACIÓN DE LA BASE DE DATOS (UPDATE, DELETES)
--

-- Miembros del grupo
-- 	Jhon Alejandro Montaño Ortiz
--	Juan Lopera
--	Pablo Agudelo

--
-- INSTRUCCIONES DE MODIFICACIÓN SOLICITADAS
--

--
-- Instrucciones UPDATE 
--

--
-- PACIENTES
--

-- 1. Actualizar teléfono (paciente 1)
UPDATE paciente
SET telefono = '6045551234'
WHERE id_paciente = 1;
-- Justificación: Nuevo número de contacto reportado por el paciente.

-- 2. Actualizar correo (paciente 2)
UPDATE paciente
SET correo = 'actualizacion2@correo.com'
WHERE id_paciente = 2;
-- Justificación: Corrección de correo mal registrado.

-- 3. Actualizar id_eps (paciente 3)
UPDATE paciente
SET id_eps = 2
WHERE id_paciente = 3;
-- Justificación: Paciente trasladó su afiliación a otra EPS.

-- 4. Actualizar id_ciudad (paciente 4)
UPDATE paciente
SET id_ciudad = 3
WHERE id_paciente = 4;
-- Justificación: Cambio de residencia a otra ciudad.

-- 5. Actualizar fecha_nacimiento (paciente 5)
UPDATE paciente
SET fecha_nacimiento = '1985-07-12'
WHERE id_paciente = 5;
-- Justificación: Corrección por error tipográfico detectado en la historia.

--
-- ACTUALIZACIONES EN TABLA MÉDICO
--

-- 1. Actualizar teléfono (médico 1)
UPDATE medico
SET telefono = '3001112233'
WHERE id_medico = 1;
-- Justificación: Reporta nuevo número de contacto profesional.

-- 2. Actualizar correo (médico 2)
UPDATE medico
SET correo = 'medico2@hospital.com'
WHERE id_medico = 2;
-- Justificación: Actualiza correo institucional.

-- 3. Actualizar id_especialidad (médico 3)
UPDATE medico
SET id_especialidad = 4
WHERE id_medico = 3;
-- Justificación: Finalizó una nueva especialidad.

-- 4. Actualizar registro_profesional (médico 4)
UPDATE medico
SET registro_profesional = 'RP-998877'
WHERE id_medico = 4;
-- Justificación: Corrección de número mal ingresado.

-- 5. Actualizar tipo_documento (médico 5)
UPDATE medico
SET tipo_documento = 'CE'
WHERE id_medico = 5;
-- Justificación: Migración de documento realizada por el profesional.

--
-- ACTUALIZACIONES EN TABLA ESPECIALIDAD
--

-- 1. Actualizar descripción (especialidad 1)
UPDATE especialidad
SET descripcion = 'Tratamiento avanzado de enfermedades cardiacas'
WHERE id_especialidad = 1;
-- Justificación: Mejorar la descripción formal del programa.

-- 2. Actualizar nombre (especialidad 2)
UPDATE especialidad
SET nombre = 'Neurología Pediátrica'
WHERE id_especialidad = 2;
-- Justificación: Alineación con clasificación oficial.

-- 3. Actualizar descripción (especialidad 3)
UPDATE especialidad
SET descripcion = 'Manejo integral de enfermedades pulmonares'
WHERE id_especialidad = 3;
-- Justificación: Ampliación del alcance clínico.

-- 4. Actualizar nombre (especialidad 4)
UPDATE especialidad
SET nombre = 'Oncología Clínica'
WHERE id_especialidad = 4;
-- Justificación: Ajuste a nomenclatura internacional.

-- 5. Actualizar descripcion (especialidad 5)
UPDATE especialidad
SET descripcion = 'Subespecialidad centrada en trastornos digestivos'
WHERE id_especialidad = 5;
-- Justificación: Precisión en el campo de estudio.

--
-- ACTUALIZACIONES EN TABLA ENFERMERO
--

-- 1. Actualizar telefono (enfermero 1)
UPDATE enfermero
SET telefono = '3214456677'
WHERE id_enfermero = 1;
-- Justificación: Nuevo número para contacto interno.

-- 2. Actualizar correo (enfermero 2)
UPDATE enfermero
SET correo = 'enf2@hospital.com'
WHERE id_enfermero = 2;
-- Justificación: Actualización a correo institucional.

-- 3. Actualizar tipo_documento (enfermero 3)
UPDATE enfermero
SET tipo_documento = 'CE'
WHERE id_enfermero = 3;
-- Justificación: Cambio de tipo de documento.

-- 4. Actualizar sexo (enfermero 4)
UPDATE enfermero
SET sexo = 'F'
WHERE id_enfermero = 4;
-- Justificación: Corrección de registro.

-- 5. Actualizar nombres (enfermero 5)
UPDATE enfermero
SET nombres = 'Laura Cristina'
WHERE id_enfermero = 5;
-- Justificación: Ajuste por nombre compuesto completo del profesional.

--
-- ACTUALIZACIONES EN TABLA HOSPITAL
--

-- 1. Actualizar telefono (hospital 1)
UPDATE hospital
SET telefono = '6047778899'
WHERE id_hospital = 1;
-- Justificación: Nuevo número de central telefónica.

-- 2. Actualizar direccion (hospital 2)
UPDATE hospital
SET direccion = 'Av. 33 # 45-102'
WHERE id_hospital = 2;
-- Justificación: Actualización por cambio de sede.

-- 3. Actualizar nombre (hospital 3)
UPDATE hospital
SET nombre = 'Hospital San Miguel'
WHERE id_hospital = 3;
-- Justificación: Cambio administrativo de razón social.

-- 4. Actualizar id_ciudad (hospital 4)
UPDATE hospital
SET id_ciudad = 4
WHERE id_hospital = 4;
-- Justificación: Corrección del dato geográfico.

-- 5. Actualizar nit (hospital 5)
UPDATE hospital
SET nit = '900123456-7'
WHERE id_hospital = 5;
-- Justificación: Corrección validada con DIAN.

--
-- ACTUALIZACIONES EN TABLA INGRESO_CUARTO
--

-- 1. Actualizar fecha_salida (ingreso 1)
UPDATE ingreso_cuarto
SET fecha_salida = '2025-01-10 14:00:00'
WHERE id_ingreso_cuarto = 1;
-- Justificación: Alta registrada por el médico responsable.

-- 2. Actualizar motivo_ingreso (ingreso 2)
UPDATE ingreso_cuarto
SET motivo_ingreso = 'Observación por dolor abdominal'
WHERE id_ingreso_cuarto = 2;
-- Justificación: Actualización del motivo real del ingreso.

-- 3. Actualizar id_medico_responsable (ingreso 3)
UPDATE ingreso_cuarto
SET id_medico_responsable = 2
WHERE id_ingreso_cuarto = 3;
-- Justificación: Cambio de médico asignado al paciente.

-- 4. Actualizar id_cuarto (ingreso 4)
UPDATE ingreso_cuarto
SET id_cuarto = 6
WHERE id_ingreso_cuarto = 4;
-- Justificación: Reubicación por disponibilidad.

-- 5. Actualizar fecha_ingreso (ingreso 5)
UPDATE ingreso_cuarto
SET fecha_ingreso = '2025-02-03 09:30:00'
WHERE id_ingreso_cuarto = 5;
-- Justificación: Corrección del registro inicial (error de digitación).

-- =====================================================
-- SECCIÓN 2: ACTUALIZACIONES POR ÁREA
-- =====================================================

--
-- ACTUALIZACIONES REALIZADAS POR ENFERMERÍA
--

UPDATE paciente SET telefono = '3001112233' WHERE id_paciente = 10;
-- Justificación: El paciente actualizó su número durante una llamada de seguimiento realizada por enfermería.

UPDATE paciente SET correo = 'pac10@correo.com' WHERE id_paciente = 10;
-- Justificación: Corrección del correo electrónico reportado incorrecto por el personal de enfermería.

UPDATE paciente SET id_eps = 3 WHERE id_paciente = 11;
-- Justificación: Enfermería verificó un cambio reciente de EPS en el sistema de referencia.

UPDATE paciente SET id_ciudad = 4 WHERE id_paciente = 12;
-- Justificación: Durante la visita de control, se confirmó que el paciente se mudó a otra ciudad.

UPDATE paciente SET tipo_documento = 'CE' WHERE id_paciente = 13;
-- Justificación: Enfermería detectó que el tipo de documento estaba mal registrado y lo actualizó.

UPDATE paciente SET fecha_nacimiento = '1991-07-11' WHERE id_paciente = 14;
-- Justificación: Se encontró inconsistencia en la fecha de nacimiento tras revisión de la historia.

UPDATE paciente SET nombres = 'Laura Patricia' WHERE id_paciente = 15;
-- Justificación: Corrección del nombre de pila según documento oficial validado por enfermería.

UPDATE paciente SET apellidos = 'Gómez Ramírez' WHERE id_paciente = 16;
-- Justificación: Ajuste del apellido completo tras verificación del registro civil.

UPDATE paciente SET sexo = 'F' WHERE id_paciente = 17;
-- Justificación: Actualización solicitada debido a error en el registro inicial del paciente.

UPDATE paciente SET telefono = '3002223344' WHERE id_paciente = 18;
-- Justificación: Enfermería registró el nuevo número de contacto en visita domiciliaria.

--
-- ACTUALIZACIONES REALIZADAS POR HOSPITAL
--

UPDATE paciente SET correo = 'pac19@correo.com' WHERE id_paciente = 19;
-- Justificación: El hospital reportó que el correo anterior no correspondía al paciente.

UPDATE paciente SET telefono = '3114567788' WHERE id_paciente = 20;
-- Justificación: El departamento de admisiones corrigió el contacto registrado.

UPDATE paciente SET id_eps = 2 WHERE id_paciente = 21;
-- Justificación: Ajuste debido al convenio activo entre el hospital y la EPS.

UPDATE paciente SET id_ciudad = 3 WHERE id_paciente = 22;
-- Justificación: Se actualizó la ciudad tras verificación en el proceso de admisión.

UPDATE paciente SET nombres = 'María Fernanda' WHERE id_paciente = 23;
-- Justificación: Rectificación del nombre conforme a la identificación presentada.

UPDATE paciente SET apellidos = 'Rojas Pérez' WHERE id_paciente = 24;
-- Justificación: El hospital detectó error en el apellido compuesto del paciente.

UPDATE paciente SET fecha_nacimiento = '1985-06-21' WHERE id_paciente = 25;
-- Justificación: Se corrigió la fecha tras revisar antecedentes médicos previos.

UPDATE paciente SET tipo_documento = 'CC' WHERE id_paciente = 26;
-- Justificación: El paciente actualizó su documento durante la admisión.

UPDATE paciente SET correo = 'pac27@correo.com' WHERE id_paciente = 27;
-- Justificación: El hospital registró el correo personal correcto del paciente.

UPDATE paciente SET telefono = '3025566678' WHERE id_paciente = 28;
-- Justificación: Actualización del teléfono tras contacto directo con el hospital.

--
-- ACTUALIZACIONES DURANTE HOSPITALIZACIÓN
--

UPDATE paciente SET id_ciudad = 6 WHERE id_paciente = 29;
-- Justificación: Durante la hospitalización, se registró nueva ciudad de residencia.

UPDATE paciente SET id_eps = 2 WHERE id_paciente = 30;
-- Justificación: La EPS confirmó cambio de cobertura durante el proceso de ingreso.

UPDATE paciente SET apellidos = 'Soto Ramírez' WHERE id_paciente = 31;
-- Justificación: Corrección realizada en el área de hospitalización tras verificar el documento.

UPDATE paciente SET nombres = 'Ana Lucía' WHERE id_paciente = 32;
-- Justificación: Se ajustó el nombre del paciente durante el registro de ingreso.

UPDATE paciente SET correo = 'analucia32@correo.com' WHERE id_paciente = 32;
-- Justificación: Nuevo correo reportado para envío de informes clínicos.

UPDATE paciente SET telefono = '3001102200' WHERE id_paciente = 33;
-- Justificación: Actualización del contacto para comunicaciones durante su estancia.

UPDATE paciente SET tipo_documento = 'CE' WHERE id_paciente = 34;
-- Justificación: Se corrigió el tipo de documento en el momento de su hospitalización.

UPDATE paciente SET fecha_nacimiento = '1977-11-22' WHERE id_paciente = 35;
-- Justificación: La fecha fue rectificada tras revisar registros previos del paciente.

UPDATE paciente SET sexo = 'O' WHERE id_paciente = 36;
-- Justificación: Actualización conforme a información proporcionada por el paciente.

UPDATE paciente SET correo = 'pac37@correo.com' WHERE id_paciente = 37;
-- Justificación: Contacto de correo actualizado para notificación de resultados clínicos.

-- =====================================================
-- SECCIÓN 3: INSERCIONES DE NUEVAS ESPECIALIDADES
-- =====================================================

-- En lugar de eliminar especialidades existentes, crear nuevas especialidades
INSERT INTO especialidad (nombre, descripcion) VALUES 
('Medicina Deportiva', 'Especialidad en tratamiento y prevención de lesiones deportivas'),
('Genética Médica', 'Diagnóstico y manejo de enfermedades hereditarias'),
('Medicina del Sueño', 'Especialidad en trastornos del sueño'),
('Medicina Paliativa', 'Cuidados para pacientes con enfermedades terminales'),
('Telemedicina', 'Atención médica a distancia mediante tecnologías de comunicación');

-- =====================================================
-- SECCIÓN 4: ELIMINACIONES (DELETE) CON VERIFICACIONES
-- =====================================================

--
-- ELIMINACIÓN SEGURA DE PACIENTES
--

DELETE FROM paciente
WHERE id_paciente IN (95,96,97,98,99)
AND id_paciente NOT IN (SELECT id_paciente FROM visita_medica WHERE id_paciente IS NOT NULL)
AND id_paciente NOT IN (SELECT id_paciente FROM tarjeta_visita WHERE id_paciente IS NOT NULL)
AND id_paciente NOT IN (SELECT id_paciente FROM ingreso_cuarto WHERE id_paciente IS NOT NULL)
AND id_paciente NOT IN (SELECT id_paciente FROM telefono WHERE id_paciente IS NOT NULL);
-- Justificación: Eliminación segura de pacientes sin historial clínico registrado

--
-- ELIMINACIÓN SEGURA DE MÉDICOS
--

DELETE FROM medico
WHERE id_medico IN (25,26,27,28,29)
AND id_medico NOT IN (SELECT id_medico FROM visita_medica WHERE id_medico IS NOT NULL)
AND id_medico NOT IN (SELECT id_medico_responsable FROM ingreso_cuarto WHERE id_medico_responsable IS NOT NULL)
AND id_medico NOT IN (SELECT id_medico FROM especialidad_medico WHERE id_medico IS NOT NULL)
AND id_medico NOT IN (SELECT id_medico FROM telefono WHERE id_medico IS NOT NULL);
-- Justificación: Médicos sin actividad clínica registrada ni asignaciones


