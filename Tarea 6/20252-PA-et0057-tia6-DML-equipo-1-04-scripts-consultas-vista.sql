--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE CREACIÓN y CONSULTAS DE UNA VISTA 
--
-- Miembros del grupo
--
--
--

--

--
--
-- CREACIÓN DE SUPER VISTA PARA HOSPITALIZACIÓN
--

CREATE OR REPLACE VIEW vista_hospitalizacion_completa AS
SELECT 
    -- Información del paciente
    p.id_paciente,
    p.nombres as paciente_nombres,
    p.apellidos as paciente_apellidos,
    p.fecha_nacimiento,
    p.sexo,
    EXTRACT(YEAR FROM age(p.fecha_nacimiento)) as edad,
    
    -- Información de la EPS
    e.id_eps,
    e.nombre as eps_nombre,
    e.telefono as eps_telefono,
    
    -- Información de la ciudad
    ciu.nombre as ciudad_paciente,
    dep.nombre as departamento_paciente,
    
    -- Información del ingreso/hospitalización
    ic.id_ingreso_cuarto,
    ic.fecha_ingreso,
    ic.fecha_salida,
    ic.motivo_ingreso,
    CASE 
        WHEN ic.fecha_salida IS NULL THEN 'HOSPITALIZADO'
        ELSE 'ALTA'
    END as estado_hospitalizacion,
    
    -- Información del cuarto
    c.id_cuarto,
    c.numero as numero_cuarto,
    c.capacidad,
    c.descripcion as descripcion_cuarto,
    
    -- Información del tipo de cuarto
    tc.nombre as tipo_cuarto,
    tc.capacidad as capacidad_tipo,
    
    -- Información del estado del cuarto
    ec.nombre as estado_cuarto,
    
    -- Información de la planta
    pl.id_planta,
    pl.nombre as nombre_planta,
    pl.piso,
    
    -- Información del hospital
    h.id_hospital,
    h.nombre as hospital_nombre,
    h.direccion as hospital_direccion,
    h.telefono as hospital_telefono,
    
    -- Información del médico responsable
    m.id_medico,
    m.nombres as medico_nombres,
    m.apellidos as medico_apellidos,
    m.registro_profesional,
    
    -- Información de la especialidad del médico
    esp.nombre as especialidad_medico,
    esp.descripcion as descripcion_especialidad,
    
    -- Cálculo de duración
    CASE 
        WHEN ic.fecha_salida IS NOT NULL THEN
            EXTRACT(EPOCH FROM (ic.fecha_salida - ic.fecha_ingreso))/86400
        ELSE
            EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - ic.fecha_ingreso))/86400
    END as duracion_dias

FROM ingreso_cuarto ic
JOIN paciente p ON ic.id_paciente = p.id_paciente
JOIN eps e ON p.id_eps = e.id_eps
JOIN ciudad ciu ON p.id_ciudad = ciu.id_ciudad
JOIN departamento dep ON ciu.id_departamento = dep.id_departamento
JOIN cuarto c ON ic.id_cuarto = c.id_cuarto
JOIN tipo_cuarto tc ON c.id_tipo_cuarto = tc.id_tipo_cuarto
JOIN estado_cuarto ec ON c.id_estado_cuarto = ec.id_estado_cuarto
JOIN planta pl ON c.id_planta = pl.id_planta
JOIN hospital h ON pl.id_hospital = h.id_hospital
JOIN medico m ON ic.id_medico_responsable = m.id_medico
JOIN especialidad esp ON m.id_especialidad = esp.id_especialidad;

--
-- CONSULTAS UTILIZANDO LA VISTA
--

-- 1. CONSULTA CON COUNT y GROUP BY: Cantidad de hospitalizaciones por hospital y especialidad
SELECT 
    hospital_nombre,
    especialidad_medico,
    COUNT(*) as total_hospitalizaciones,
    COUNT(CASE WHEN estado_hospitalizacion = 'HOSPITALIZADO' THEN 1 END) as hospitalizaciones_activas
FROM vista_hospitalizacion_completa
GROUP BY hospital_nombre, especialidad_medico
ORDER BY total_hospitalizaciones DESC, hospitalizaciones_activas DESC;

-- 2. CONSULTA CON SUM y GROUP BY: Total días de hospitalización por EPS y grupo etario
SELECT 
    eps_nombre,
    CASE 
        WHEN edad < 18 THEN 'Menor de edad (0-17)'
        WHEN edad BETWEEN 18 AND 30 THEN 'Joven (18-30)'
        WHEN edad BETWEEN 31 AND 50 THEN 'Adulto (31-50)'
        WHEN edad BETWEEN 51 AND 70 THEN 'Adulto mayor (51-70)'
        ELSE 'Tercera edad (71+)'
    END as grupo_etario,
    COUNT(*) as total_pacientes,
    SUM(duracion_dias) as total_dias_hospitalizacion,
    ROUND(AVG(duracion_dias), 2) as promedio_dias_hospitalizacion
FROM vista_hospitalizacion_completa
GROUP BY eps_nombre, 
    CASE 
        WHEN edad < 18 THEN 'Menor de edad (0-17)'
        WHEN edad BETWEEN 18 AND 30 THEN 'Joven (18-30)'
        WHEN edad BETWEEN 31 AND 50 THEN 'Adulto (31-50)'
        WHEN edad BETWEEN 51 AND 70 THEN 'Adulto mayor (51-70)'
        ELSE 'Tercera edad (71+)'
    END
ORDER BY eps_nombre, total_dias_hospitalizacion DESC;

-- 3. CONSULTA CON MAX y MIN: Estadísticas de duración por tipo de cuarto
SELECT 
    tipo_cuarto,
    COUNT(*) as total_utilizaciones,
    MIN(duracion_dias) as estancia_minima_dias,
    MAX(duracion_dias) as estancia_maxima_dias,
    ROUND(AVG(duracion_dias), 2) as estancia_promedio_dias,
    ROUND(MIN(duracion_dias), 2) || ' - ' || ROUND(MAX(duracion_dias), 2) as rango_estancia
FROM vista_hospitalizacion_completa
WHERE fecha_salida IS NOT NULL  -- Solo hospitalizaciones completadas
GROUP BY tipo_cuarto
ORDER BY estancia_promedio_dias DESC;

-- 4. CONSULTA CON COUNT y filtros: Ocupación actual por hospital y planta
SELECT 
    hospital_nombre,
    nombre_planta,
    piso,
    COUNT(*) as total_cuartos_ocupados,
    COUNT(DISTINCT id_paciente) as pacientes_actuales,
    ROUND(AVG(duracion_dias), 2) as duracion_promedio_actual
FROM vista_hospitalizacion_completa
WHERE estado_hospitalizacion = 'HOSPITALIZADO'
GROUP BY hospital_nombre, nombre_planta, piso
ORDER BY hospital_nombre, piso, total_cuartos_ocupados DESC;

-- 5. CONSULTA COMPLEJA con múltiples funciones: Eficiencia hospitalaria por médico
SELECT 
    medico_nombres || ' ' || medico_apellidos as medico_completo,
    especialidad_medico,
    hospital_nombre,
    COUNT(*) as total_pacientes_atendidos,
    COUNT(CASE WHEN estado_hospitalizacion = 'HOSPITALIZADO' THEN 1 END) as pacientes_actuales,
    SUM(duracion_dias) as total_dias_cuidado,
    ROUND(AVG(duracion_dias), 2) as promedio_dias_por_paciente,
    MIN(duracion_dias) as estancia_minima,
    MAX(duracion_dias) as estancia_maxima,
    ROUND(SUM(duracion_dias) / COUNT(*), 2) as eficiencia_estancia
FROM vista_hospitalizacion_completa
GROUP BY medico_nombres, medico_apellidos, especialidad_medico, hospital_nombre
HAVING COUNT(*) >= 2  -- Solo médicos con al menos 2 hospitalizaciones
ORDER BY total_pacientes_atendidos DESC, eficiencia_estancia ASC;

-- CONSULTA ADICIONAL: Top 10 pacientes con más hospitalizaciones
SELECT 
    paciente_nombres || ' ' || paciente_apellidos as paciente_completo,
    eps_nombre,
    COUNT(*) as total_hospitalizaciones,
    SUM(duracion_dias) as total_dias_hospitalizado,
    ROUND(AVG(duracion_dias), 2) as promedio_dias_por_hospitalizacion,
    MIN(fecha_ingreso) as primera_hospitalizacion,
    MAX(fecha_ingreso) as ultima_hospitalizacion
FROM vista_hospitalizacion_completa
GROUP BY paciente_nombres, paciente_apellidos, eps_nombre
ORDER BY total_hospitalizaciones DESC, total_dias_hospitalizado DESC
LIMIT 10;
