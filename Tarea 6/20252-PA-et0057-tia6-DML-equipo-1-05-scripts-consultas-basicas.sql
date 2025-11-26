--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE CONSULTAS BÁSICAS (SELECT sin JOIN)
--
-- Miembros del grupo
--
--
--

-- CONSULTAS BÁSICAS - SUBSISTEMA DE HOSPITALIZACIÓN
--

-- 1. CONSULTA CON COUNT: Cantidad de ingresos por paciente
SELECT p.nombres, p.apellidos, 
       COUNT(ic.id_ingreso_cuarto) as total_ingresos
FROM paciente p
JOIN ingreso_cuarto ic ON p.id_paciente = ic.id_paciente
GROUP BY p.id_paciente, p.nombres, p.apellidos
ORDER BY total_ingresos DESC;

-- 2. CONSULTA CON MAX: Paciente con la hospitalización más larga
SELECT p.nombres, p.apellidos, 
       ic.fecha_ingreso, ic.fecha_salida,
       MAX(ic.fecha_salida - ic.fecha_ingreso) as duracion_maxima
FROM paciente p
JOIN ingreso_cuarto ic ON p.id_paciente = ic.id_paciente
WHERE ic.fecha_salida IS NOT NULL
GROUP BY p.id_paciente, p.nombres, p.apellidos, ic.fecha_ingreso, ic.fecha_salida
ORDER BY duracion_maxima DESC
LIMIT 1;

-- 3. CONSULTA CON MIN: Hospitalización más corta por hospital
SELECT h.nombre as hospital,
       p.nombres, p.apellidos,
       MIN(ic.fecha_salida - ic.fecha_ingreso) as duracion_minima
FROM hospital h
JOIN planta pl ON h.id_hospital = pl.id_hospital
JOIN cuarto c ON pl.id_planta = c.id_planta
JOIN ingreso_cuarto ic ON c.id_cuarto = ic.id_cuarto
JOIN paciente p ON ic.id_paciente = p.id_paciente
WHERE ic.fecha_salida IS NOT NULL
GROUP BY h.nombre, p.nombres, p.apellidos
ORDER BY duracion_minima ASC;

-- 4. CONSULTA CON AVG: Duración promedio de hospitalización por especialidad médica
SELECT e.nombre as especialidad,
       AVG(EXTRACT(EPOCH FROM (ic.fecha_salida - ic.fecha_ingreso))/86400) as duracion_promedio_dias
FROM ingreso_cuarto ic
JOIN medico m ON ic.id_medico_responsable = m.id_medico
JOIN especialidad e ON m.id_especialidad = e.id_especialidad
WHERE ic.fecha_salida IS NOT NULL
GROUP BY e.nombre
ORDER BY duracion_promedio_dias DESC;

-- 5. CONSULTA CON SUM: Total de días de hospitalización por mes
SELECT DATE_TRUNC('month', ic.fecha_ingreso) as mes,
       SUM(EXTRACT(EPOCH FROM (COALESCE(ic.fecha_salida, CURRENT_TIMESTAMP) - ic.fecha_ingreso))/86400) as total_dias_hospitalizacion
FROM ingreso_cuarto ic
GROUP BY DATE_TRUNC('month', ic.fecha_ingreso)
ORDER BY mes DESC;

-- 6. Listado de pacientes actualmente hospitalizados
SELECT p.nombres, p.apellidos, 
       h.nombre as hospital, 
       c.numero as cuarto,
       ic.fecha_ingreso,
       m.nombres as medico_responsable
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
JOIN hospital h ON pl.id_hospital = h.id_hospital
LEFT JOIN medico m ON ic.id_medico_responsable = m.id_medico
WHERE ic.fecha_salida IS NULL
ORDER BY ic.fecha_ingreso DESC;

-- 7. Ingresos por motivo más común
SELECT ic.motivo_ingreso,
       COUNT(*) as cantidad_ingresos
FROM ingreso_cuarto ic
WHERE ic.motivo_ingreso IS NOT NULL
GROUP BY ic.motivo_ingreso
ORDER BY cantidad_ingresos DESC;

-- 8. Ocupación de cuartos por hospital
SELECT h.nombre as hospital,
       COUNT(c.id_cuarto) as total_cuartos,
       COUNT(CASE WHEN ec.nombre = 'ocupado' THEN 1 END) as cuartos_ocupados,
       COUNT(CASE WHEN ec.nombre = 'disponible' THEN 1 END) as cuartos_disponibles
FROM hospital h
JOIN planta pl ON h.id_hospital = pl.id_hospital
JOIN cuarto c ON pl.id_planta = c.id_planta
JOIN estado_cuarto ec ON c.id_estado_cuarto = ec.id_estado_cuarto
GROUP BY h.nombre
ORDER BY cuartos_ocupados DESC;

-- 9. Médicos con más pacientes hospitalizados
SELECT m.nombres, m.apellidos,
       e.nombre as especialidad,
       COUNT(DISTINCT ic.id_paciente) as total_pacientes_atendidos
FROM medico m
JOIN especialidad e ON m.id_especialidad = e.id_especialidad
JOIN ingreso_cuarto ic ON m.id_medico = ic.id_medico_responsable
GROUP BY m.id_medico, m.nombres, m.apellidos, e.nombre
ORDER BY total_pacientes_atendidos DESC;

-- 10. Distribución de pacientes por tipo de cuarto
SELECT tc.nombre as tipo_cuarto,
       COUNT(ic.id_ingreso_cuarto) as total_ingresos
FROM tipo_cuarto tc
JOIN cuarto c ON tc.id_tipo_cuarto = c.id_tipo_cuarto
JOIN ingreso_cuarto ic ON c.id_cuarto = ic.id_cuarto
GROUP BY tc.nombre
ORDER BY total_ingresos DESC;

