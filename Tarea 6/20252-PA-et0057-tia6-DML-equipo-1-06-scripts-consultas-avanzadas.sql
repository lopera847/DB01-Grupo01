--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE CONSULTAS AVANZADAS (SELECT con JOIN)
--
-- Miembros del grupo
-- Jhon Alejandro Montaño Ortiz
-- Juan Lopera
-- Pablo Agudelo

--
--
-- CONSULTAS AVANZADAS - SUBSISTEMA DE HOSPITALIZACIÓN
--

-- 1. CONSULTA CON 1 JOIN + COUNT: Cantidad de ingresos por paciente con información básica
SELECT p.nombres, p.apellidos, p.fecha_nacimiento,
       COUNT(ic.id_ingreso_cuarto) as total_hospitalizaciones
FROM paciente p
JOIN ingreso_cuarto ic ON p.id_paciente = ic.id_paciente
GROUP BY p.id_paciente, p.nombres, p.apellidos, p.fecha_nacimiento
ORDER BY total_hospitalizaciones DESC;

-- 2. CONSULTA CON 1 JOIN + MAX: Hospitalización más reciente por paciente
SELECT p.nombres, p.apellidos,
       MAX(ic.fecha_ingreso) as ultima_hospitalizacion
FROM paciente p
JOIN ingreso_cuarto ic ON p.id_paciente = ic.id_paciente
GROUP BY p.id_paciente, p.nombres, p.apellidos
ORDER BY ultima_hospitalizacion DESC;

-- 3. CONSULTA CON 1 JOIN + AVG: Duración promedio de hospitalización por paciente
SELECT p.nombres, p.apellidos,
       AVG(EXTRACT(EPOCH FROM (COALESCE(ic.fecha_salida, CURRENT_TIMESTAMP) - ic.fecha_ingreso))/86400) as duracion_promedio_dias
FROM paciente p
JOIN ingreso_cuarto ic ON p.id_paciente = ic.id_paciente
WHERE ic.fecha_ingreso IS NOT NULL
GROUP BY p.id_paciente, p.nombres, p.apellidos
ORDER BY duracion_promedio_dias DESC;

-- 4. CONSULTA CON 2 JOIN: Pacientes hospitalizados con información de cuarto y planta
SELECT p.nombres, p.apellidos, 
       c.numero as numero_cuarto, 
       pl.nombre as planta,
       ic.fecha_ingreso, ic.motivo_ingreso
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
WHERE ic.fecha_salida IS NULL
ORDER BY ic.fecha_ingreso DESC;

-- 5. CONSULTA CON 2 JOIN + MIN: Primera hospitalización de cada paciente con médico responsable
SELECT p.nombres, p.apellidos,
       m.nombres as medico_responsable,
       MIN(ic.fecha_ingreso) as primera_hospitalizacion
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN medico m ON ic.id_medico_responsable = m.id_medico
GROUP BY p.id_paciente, p.nombres, p.apellidos, m.nombres
ORDER BY primera_hospitalizacion ASC;

-- 6. CONSULTA CON 2 JOIN + SUM: Total días hospitalizados por paciente con EPS
SELECT p.nombres, p.apellidos,
       e.nombre as eps,
       SUM(EXTRACT(EPOCH FROM (COALESCE(ic.fecha_salida, CURRENT_TIMESTAMP) - ic.fecha_ingreso))/86400) as total_dias_hospitalizado
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN eps e ON p.id_eps = e.id_eps
GROUP BY p.id_paciente, p.nombres, p.apellidos, e.nombre
ORDER BY total_dias_hospitalizado DESC;

-- 7. CONSULTA CON 3 JOIN: Información completa de hospitalización actual
SELECT p.nombres as paciente, p.apellidos as apellido_paciente,
       h.nombre as hospital, 
       c.numero as cuarto, tc.nombre as tipo_cuarto,
       m.nombres as medico, m.apellidos as apellido_medico,
       ic.fecha_ingreso, ic.motivo_ingreso
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN tipo_cuarto tc ON c.id_tipo_cuarto = tc.id_tipo_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
JOIN hospital h ON pl.id_hospital = h.id_hospital
JOIN medico m ON ic.id_medico_responsable = m.id_medico
WHERE ic.fecha_salida IS NULL
ORDER BY h.nombre, pl.nombre, c.numero;

-- 8. CONSULTA CON 3 JOIN: Historial de hospitalizaciones con diagnóstico
SELECT p.nombres, p.apellidos,
       h.nombre as hospital,
       ic.fecha_ingreso, ic.fecha_salida,
       vm.notas as diagnostico_visita,
       d.descripcion as diagnostico_oficial
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
JOIN hospital h ON pl.id_hospital = h.id_hospital
LEFT JOIN visita_medica vm ON p.id_paciente = vm.id_paciente AND vm.fecha BETWEEN ic.fecha_ingreso AND COALESCE(ic.fecha_salida, CURRENT_TIMESTAMP)
LEFT JOIN diagnostico d ON vm.diagnostico_id = d.id_diagnostico
ORDER BY ic.fecha_ingreso DESC;

-- 9. CONSULTA CON 4 JOIN: Estadísticas de ocupación por ciudad y tipo de cuarto
SELECT ciu.nombre as ciudad,
       h.nombre as hospital,
       tc.nombre as tipo_cuarto,
       COUNT(c.id_cuarto) as total_cuartos,
       COUNT(CASE WHEN ec.nombre = 'ocupado' THEN 1 END) as cuartos_ocupados,
       ROUND(COUNT(CASE WHEN ec.nombre = 'ocupado' THEN 1 END) * 100.0 / COUNT(c.id_cuarto), 2) as porcentaje_ocupacion
FROM ciudad ciu
JOIN hospital h ON ciu.id_ciudad = h.id_ciudad
JOIN planta pl ON h.id_hospital = pl.id_hospital
JOIN cuarto c ON pl.id_planta = c.id_planta
JOIN tipo_cuarto tc ON c.id_tipo_cuarto = tc.id_tipo_cuarto
JOIN estado_cuarto ec ON c.id_estado_cuarto = ec.id_estado_cuarto
GROUP BY ciu.nombre, h.nombre, tc.nombre
ORDER BY ciudad, porcentaje_ocupacion DESC;

-- 10. CONSULTA CON 5 JOIN: Información completa de pacientes con visitas médicas y prescripciones
SELECT p.nombres as paciente, p.apellidos as apellido_paciente,
       h.nombre as hospital,
       m_ingreso.nombres as medico_ingreso, m_ingreso.apellidos as apellido_medico_ingreso,
       m_visita.nombres as medico_visita, m_visita.apellidos as apellido_medico_visita,
       e_ingreso.nombre as especialidad_ingreso,
       vm.fecha as fecha_visita,
       d.descripcion as diagnostico,
       pr.observaciones as prescripcion,
       ic.fecha_ingreso, ic.fecha_salida
FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
JOIN hospital h ON pl.id_hospital = h.id_hospital
JOIN medico m_ingreso ON ic.id_medico_responsable = m_ingreso.id_medico
JOIN especialidad e_ingreso ON m_ingreso.id_especialidad = e_ingreso.id_especialidad
LEFT JOIN visita_medica vm ON p.id_paciente = vm.id_paciente AND vm.fecha BETWEEN ic.fecha_ingreso AND COALESCE(ic.fecha_salida, CURRENT_TIMESTAMP)
LEFT JOIN medico m_visita ON vm.id_medico = m_visita.id_medico
LEFT JOIN diagnostico d ON vm.diagnostico_id = d.id_diagnostico
LEFT JOIN prescripcion pr ON vm.id_visita_medica = pr.id_visita_medica
ORDER BY ic.fecha_ingreso DESC, vm.fecha DESC;
