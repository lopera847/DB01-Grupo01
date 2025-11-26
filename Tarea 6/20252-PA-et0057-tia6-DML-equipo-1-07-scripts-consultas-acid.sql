--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE CREACIÓN y CONSULTAS DE UNA VISTA 
--
-- Miembros del grupo
-- 	Jhon Alejandro Montaño Ortiz
--	Juan Lopera
--	Pablo Agudelo

--

--
--
-- VALIDACIÓN ACID - BASE DE DATOS HCE_ANTIOQUIA
--

-- =============================================
-- 1. OPERACIONES INSERT CON VALIDACIÓN ACID
-- =============================================

-- INSERT 1: Nuevo paciente con información completa
BEGIN TRANSACTION;

INSERT INTO paciente (
    tipo_documento, numero_documento, nombres, apellidos, 
    fecha_nacimiento, sexo, id_ciudad, id_eps, 
    telefono, correo, direccion
) VALUES (
    'CC', '990000001', 'Ana María', 'Restrepo García',
    '1985-08-15', 'F', 1, 1,
    '3105550101', 'ana.restrepo@email.com', 'Calle 123 #45-67'
);

-- VALIDACIÓN ACID para este INSERT:
--  ATOMICIDAD: La transacción se completa completamente o no se ejecuta
--  CONSISTENCIA: Se respetan todas las constraints (FK a ciudad y EPS válidas)
--  AISLAMIENTO: Otros usuarios no ven este registro hasta que se haga COMMIT
-- DURABILIDAD: Una vez confirmado, el registro persiste incluso en fallos del sistema

COMMIT;

-- INSERT 2: Nuevo ingreso hospitalario con validación de integridad referencial
BEGIN TRANSACTION;

-- Verificar que el paciente y cuarto existen antes de insertar
DO $$
DECLARE
    paciente_exists BOOLEAN;
    cuarto_exists BOOLEAN;
    medico_exists BOOLEAN;
BEGIN
    -- Validar existencia de referencias (Consistencia)
    SELECT EXISTS(SELECT 1 FROM paciente WHERE id_paciente = 1) INTO paciente_exists;
    SELECT EXISTS(SELECT 1 FROM cuarto WHERE id_cuarto = 1 AND id_estado_cuarto = 1) INTO cuarto_exists;
    SELECT EXISTS(SELECT 1 FROM medico WHERE id_medico = 1) INTO medico_exists;
    
    IF NOT paciente_exists THEN
        RAISE EXCEPTION 'Paciente no existe';
    END IF;
    
    IF NOT cuarto_exists THEN
        RAISE EXCEPTION 'Cuarto no disponible o no existe';
    END IF;
    
    IF NOT medico_exists THEN
        RAISE EXCEPTION 'Médico no existe';
    END IF;
    
    -- Insertar el ingreso
    INSERT INTO ingreso_cuarto (
        id_paciente, id_cuarto, fecha_ingreso, 
        motivo_ingreso, id_medico_responsable
    ) VALUES (
        1, 1, CURRENT_TIMESTAMP,
        'Control post-operatorio', 1
    );
    
    -- Actualizar estado del cuarto a ocupado
    UPDATE cuarto SET id_estado_cuarto = 2 WHERE id_cuarto = 1;
    
END $$;

-- VALIDACIÓN ACID para este INSERT:
--  ATOMICIDAD: Si alguna validación falla, toda la transacción se revierte
--  CONSISTENCIA: Se mantienen las reglas de negocio (cuarto debe estar disponible)
--  AISLAMIENTO: Otros usuarios no ven los cambios hasta el COMMIT
-- DURABILIDAD: Los cambios persisten después del COMMIT

COMMIT;

-- INSERT 3: Nueva visita médica con prescripción (operación en cascada)
BEGIN TRANSACTION;

INSERT INTO visita_medica (
    id_paciente, id_medico, fecha, notas, diagnostico_id, observaciones
) VALUES (
    1, 1, CURRENT_TIMESTAMP, 
    'Control de evolución favorable', 1,
    'Paciente estable, continuar tratamiento'
) RETURNING id_visita_medica;

-- Insertar prescripción relacionada usando el ID retornado
INSERT INTO prescripcion (
    id_visita_medica, fecha_prescripcion, observaciones
) VALUES (
    currval('visita_medica_id_visita_medica_seq'), CURRENT_TIMESTAMP,
    'Paracetamol 500mg cada 8 horas por 5 días'
);

-- VALIDACIÓN ACID para este INSERT:
--  ATOMICIDAD: Ambas inserciones se ejecutan como una unidad atómica
--  CONSISTENCIA: Se mantiene la integridad referencial entre visita y prescripción
--  AISLAMIENTO: La secuencia de IDs se maneja correctamente en transacciones concurrentes
--  DURABILIDAD: Ambas tablas se actualizan permanentemente

COMMIT;

-- =============================================
-- 2. OPERACIONES UPDATE CON VALIDACIÓN ACID
-- =============================================

-- UPDATE 1: Actualizar estado de cuarto con verificación
BEGIN TRANSACTION;

-- Verificar que el cuarto existe y está ocupado antes de liberarlo
UPDATE cuarto 
SET id_estado_cuarto = 1  -- disponible
WHERE id_cuarto = 1 
AND id_estado_cuarto = 2  -- ocupado
AND EXISTS (
    SELECT 1 FROM ingreso_cuarto 
    WHERE id_cuarto = 1 AND fecha_salida IS NOT NULL
);

-- Validar que se actualizó exactamente un registro
GET DIAGNOSTICS update_count = ROW_COUNT;

IF update_count != 1 THEN
    RAISE EXCEPTION 'No se pudo actualizar el estado del cuarto. Verifique condiciones.';
END IF;

-- VALIDACIÓN ACID para este UPDATE:
--  ATOMICIDAD: La actualización se realiza completamente o se revierte
--  CONSISTENCIA: Solo se liberan cuartos que realmente estaban ocupados
--  AISLAMIENTO: Previene condiciones de carrera en actualizaciones concurrentes
--  DURABILIDAD: El cambio de estado persiste después del COMMIT

COMMIT;

-- UPDATE 2: Actualizar información de paciente manteniendo historial
BEGIN TRANSACTION;

-- Crear backup del estado anterior (para auditoría)
CREATE TEMPORARY TABLE paciente_backup AS 
SELECT * FROM paciente WHERE id_paciente = 1;

-- Actualizar información del paciente
UPDATE paciente 
SET telefono = '3105559999',
    direccion = 'Nueva dirección: Carrera 80 #25-30',
    correo = 'nuevo.correo@email.com'
WHERE id_paciente = 1
RETURNING *;

-- Verificar que solo se actualizó un registro
GET DIAGNOSTICS update_count = ROW_COUNT;

IF update_count != 1 THEN
    ROLLBACK;
    RAISE EXCEPTION 'Paciente no encontrado para actualización';
END IF;

-- VALIDACIÓN ACID para este UPDATE:
--  ATOMICIDAD: Backup + Update se ejecutan como una unidad
--  CONSISTENCIA: Se mantienen todas las constraints del paciente
--  AISLAMIENTO: Otros usuarios ven la versión anterior hasta COMMIT
--  DURABILIDAD: Los cambios son permanentes una vez confirmados

COMMIT;

-- UPDATE 3: Actualizar fecha de salida de ingreso hospitalario
BEGIN TRANSACTION;

-- Actualizar ingreso y liberar cuarto simultáneamente
UPDATE ingreso_cuarto 
SET fecha_salida = CURRENT_TIMESTAMP
WHERE id_ingreso_cuarto = 1 
AND fecha_salida IS NULL;

-- Si se actualizó un ingreso, liberar el cuarto
GET DIAGNOSTICS update_count = ROW_COUNT;

IF update_count > 0 THEN
    UPDATE cuarto 
    SET id_estado_cuarto = 1  -- disponible
    WHERE id_cuarto = (SELECT id_cuarto FROM ingreso_cuarto WHERE id_ingreso_cuarto = 1);
END IF;

-- VALIDACIÓN ACID para este UPDATE:
--  ATOMICIDAD: Ambas actualizaciones (ingreso + cuarto) son atómicas
--  CONSISTENCIA: El cuarto solo se libera si el ingreso se cierra
--  AISLAMIENTO: Previene que otro proceso reserve el cuarto simultáneamente
--  DURABILIDAD: Ambos cambios persisten en la base de datos

COMMIT;

-- =============================================
-- 3. OPERACIONES DELETE CON VALIDACIÓN ACID
-- =============================================

-- DELETE 1: Eliminar prescripción con verificación de integridad
BEGIN TRANSACTION;

-- Verificar que la prescripción existe antes de eliminar
DO $$
DECLARE
    prescripcion_exists BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM prescripcion WHERE id_prescripcion = 1) 
    INTO prescripcion_exists;
    
    IF NOT prescripcion_exists THEN
        RAISE EXCEPTION 'Prescripción no existe';
    END IF;
    
    -- Eliminar la prescripción
    DELETE FROM prescripcion WHERE id_prescripcion = 1;
    
    -- Verificar que se eliminó exactamente un registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se pudo eliminar la prescripción';
    END IF;
END $$;

-- VALIDACIÓN ACID para este DELETE:
-- ATOMICIDAD: La eliminación se completa completamente o se revierte
-- CONSISTENCIA: Se respeta la constraint de FK con visita_medica (ON DELETE CASCADE)
-- AISLAMIENTO: Otros usuarios no ven la eliminación hasta COMMIT
-- DURABILIDAD: La eliminación es permanente después del COMMIT

COMMIT;

-- DELETE 2: Eliminar tarjeta de visita expirada
BEGIN TRANSACTION;

-- Eliminar tarjetas de visita expiradas (más de 30 días)
DELETE FROM tarjeta_visita 
WHERE fecha_expiracion < CURRENT_TIMESTAMP - INTERVAL '30 days'
AND id_estado_tarjeta = 2  -- inactiva
RETURNING id_tarjeta_visita, id_visitante, id_paciente;

-- Registrar en log la cantidad eliminada (para auditoría)
GET DIAGNOSTICS delete_count = ROW_COUNT;

-- VALIDACIÓN ACID para este DELETE:
--  ATOMICIDAD: Todas las eliminaciones se ejecutan como una unidad
--  CONSISTENCIA: Solo se eliminan registros que cumplen las condiciones
--  AISLAMIENTO: Previene interferencia con otras operaciones de tarjetas
--  DURABILIDAD: Las eliminaciones son permanentes y auditables

COMMIT;

-- DELETE 3: Eliminar paciente con todas sus relaciones (operación crítica)
BEGIN TRANSACTION;

-- Verificar que el paciente no tiene hospitalizaciones activas
DO $$
DECLARE
    tiene_ingresos_activos BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 FROM ingreso_cuarto 
        WHERE id_paciente = 1 AND fecha_salida IS NULL
    ) INTO tiene_ingresos_activos;
    
    IF tiene_ingresos_activos THEN
        RAISE EXCEPTION 'No se puede eliminar paciente con hospitalizaciones activas';
    END IF;
    
    -- Crear backup de datos importantes para auditoría
    CREATE TEMPORARY TABLE paciente_eliminado_backup AS 
    SELECT *, CURRENT_TIMESTAMP as fecha_eliminacion 
    FROM paciente WHERE id_paciente = 1;
    
    -- Eliminar paciente (las FK con CASCADE eliminarán registros relacionados)
    DELETE FROM paciente WHERE id_paciente = 1;
    
    -- Verificar eliminación
    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'No se pudo eliminar el paciente';
    END IF;
    
END $$;

-- VALIDACIÓN ACID para este DELETE:
--  ATOMICIDAD: Backup + verificación + eliminación como transacción única
--  CONSISTENCIA: Previene eliminación de pacientes con relaciones activas
--  AISLAMIENTO: Aísla la operación crítica de eliminación
--  DURABILIDAD: La eliminación es permanente pero con backup para auditoría

COMMIT;

-- =============================================
-- VERIFICACIÓN FINAL DE INTEGRIDAD
-- =============================================

-- Consulta para verificar la integridad de la base de datos después de las operaciones
SELECT 
    'Pacientes' as tabla,
    COUNT(*) as total_registros
FROM paciente
UNION ALL
SELECT 
    'Ingresos activos',
    COUNT(*)
FROM ingreso_cuarto 
WHERE fecha_salida IS NULL
UNION ALL
SELECT 
    'Cuartos disponibles',
    COUNT(*)
FROM cuarto 
WHERE id_estado_cuarto = 1
ORDER BY tabla;
