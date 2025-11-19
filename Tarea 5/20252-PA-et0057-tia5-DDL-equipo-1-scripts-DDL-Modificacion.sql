--
-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE MODIFICACIÓN DE LA BASE DE DATOS
--
-- Miembros del grupo
--
--

--
-- INSTRUCCIONES DE MODIFICACIÓN SOLICITADAS
--

--
-- 5.1.- Agregar al menos 5 índices diferentes que considere importantes en 5 tablas diferentes. 
--

-- 5.1 Índices

-- 1. PACIENTE — ordenar por nombres
CREATE INDEX idx_paciente_nombres
ON paciente (nombres);

-- 2. HOSPITAL — ordenar por nombre
CREATE INDEX idx_hospital_nombre
ON hospital (nombre);

-- 3. CIUDAD — ordenar por nombre
CREATE INDEX idx_ciudad_nombre
ON ciudad (nombre);

-- 4. MEDICO — ordenar por nombres
CREATE INDEX idx_medico_nombres
ON medico (nombres);

-- 5. MEDICAMENTO — ordenar por nombre
CREATE INDEX idx_medicamento_nombre
ON medicamento (nombre);

--
-- 5.2.- Agregar 5 campos nuevos en 5 tablas diferentes de su preferencia. 
-- 

-- 5.2 Agregar campos

-- 1. PACIENTE → agregar direccion
ALTER TABLE paciente 
ADD COLUMN direccion VARCHAR(150);

-- 2. MEDICO → agregar direccion
ALTER TABLE medico 
ADD COLUMN direccion VARCHAR(150);

-- 3. VISITA_MEDICA → agregar observaciones
ALTER TABLE visita_medica 
ADD COLUMN observaciones TEXT;

-- 4. VISITANTE → agregar cedula
ALTER TABLE visitante 
ADD COLUMN cedula VARCHAR(50);

-- 5. MEDICAMENTO → agregar laboratorio
ALTER TABLE medicamento 
ADD COLUMN laboratorio VARCHAR(150);

--
-- 5.3.- Agregar 5 “CHECK” diferentes en 5 tablas diferentes  de su preferencia. 
--

-- 5.3 CHECKS

-- 1. TIPO_CUARTO — validar tipo (‘privado’, ‘compartido’)
ALTER TABLE tipo_cuarto
ADD CONSTRAINT chk_tipo_cuarto_nombre
CHECK (nombre IN ('privado', 'compartido'));

-- 2. ESTADO_CUARTO — validar estado (‘disponible’, ‘ocupado’)
ALTER TABLE estado_cuarto
ADD CONSTRAINT chk_estado_cuarto_nombre
CHECK (nombre IN ('disponible', 'ocupado'));

-- 3. ESTADO_TARJETA — validar estado ('activa', 'inactiva')
ALTER TABLE estado_tarjeta
ADD CONSTRAINT chk_estado_tarjeta_nombre
CHECK (nombre IN ('activa', 'inactiva'));

-- 4. ESTADO_EPS — validar estado ('activa', 'inactiva')
ALTER TABLE estado_eps
ADD CONSTRAINT chk_estado_eps_nombre
CHECK (nombre IN ('activa', 'inactiva'));

-- 5. EPS — validar que el teléfono tenga mínimo 7 dígitos
ALTER TABLE eps
ADD CONSTRAINT chk_eps_telefono
CHECK (char_length(regexp_replace(telefono, '\D','','g')) >= 7);

--
-- 5.4. Modificar los nombres de 5 campos diferentes en 5 tablas diferentes. 
--

-- 5.4 Renombrar campos

-- 1. PACIENTE — nombres → nombre
ALTER TABLE paciente
RENAME COLUMN nombres TO nombre;

-- 2. MEDICO — nombres → nombre
ALTER TABLE medico
RENAME COLUMN nombres TO nombre;

-- 3. TELEFONO — numero → telefono
ALTER TABLE telefono
RENAME COLUMN numero TO telefono;

-- 4. MEDICAMENTO — nombre → nombre_medicamento
ALTER TABLE medicamento
RENAME COLUMN nombre TO nombre_medicamento;

-- 5. PROCEDIMIENTO — descripcion → descripcion_procedimiento
ALTER TABLE procedimiento
RENAME COLUMN descripcion TO descripcion_procedimiento;