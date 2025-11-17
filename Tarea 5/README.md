# 🏗️ Tarea 05 – Implementación Base de Datos (Modelo Físico – DDL)  
**Proyecto de Aula (PA) - 2025-2 | TIA5**

---

## 📚 Descripción

Esta tarea corresponde a la **Fase 4 del Proyecto de Aula (PA)** y tiene como objetivo construir el **Modelo Físico** de la base de datos **“hce_antioquia”**, asegurando que todas las tablas, claves y reglas coincidan con los resultados del proceso de normalización realizado en la TIA 3.

Durante esta etapa, los estudiantes deberán corregir y fortalecer el diseño previo (ER y normalización) para garantizar que el modelo físico sea coherente, robusto y aplicable en PostgreSQL.

---

## 🎯 Objetivos de la Tarea

### ✔️ Correcciones previas obligatorias
Antes de construir el Modelo Físico se deben:

- **Corregir el Diagrama Entidad–Relación (Chen)**  
- **Revisar el proceso de normalización (1FN, 2FN, 3FN)**  
- **Asegurar que todas las tablas resultantes de la normalización** aparezcan en el Diccionario de Datos Físico y en los scripts DDL.

---

## 🧩 Fase 4 – Construcción del Modelo Físico

### **1. Inventario de tablas definitivo**
- Listado final de todas las tablas que conforman el modelo físico.  
- Debe coincidir con:
  - El inventario de entidades (TIA2)
  - Las relaciones (TIA2)
  - El proceso de normalización (TIA3)

### **2. Diccionario de Datos Físico**
Debe incluir por cada tabla:

- Nombre de la tabla  
- Nombre del campo  
- Tipo de dato  
- Tamaño  
- Restricciones (PK, FK, NN, UQ, CHECK)  
- Relación con otras tablas  

Archivo entregable:  
**20252-PA-et0057-tia5-DDL-equipo-01-resultados.xlsx**

---

## 🛠️ 3. Scripts DDL

### **a) Script de creación (CREATE TABLE)**  
Debe contener:

- Creación de todas las tablas  
- Claves primarias (PK)  
- Claves foráneas (FK)  
- Restricciones NOT NULL, UNIQUE, CHECK  
- Índices  
- Orden correcto de creación:  
  1. Tablas independientes  
  2. Tablas dependientes  

Archivo entregable:  
**20252-PA-et0057-tia5-DDL-equipo-01-scripts-DDL-Creacion.sql**

---

### **b) Script de modificación (ALTER TABLE)**  
Incluye:

- Nuevas restricciones  
- Ajustes adicionales  
- Adición de claves foráneas (si aplica)  
- Cambios estructurales  
- Orden lógico de aplicación  

Archivo entregable:  
**20252-PA-et0057-tia5-DDL-equipo-01-scripts-DDL-Modificacion.sql**

---

## 📄 4. Informe de Resultados

El informe debe incluir:

- Descripción del proceso  
- Justificación de elecciones de tipos de datos  
- Explicación del diseño físico  
- Evidencias del DDL  
- Conclusiones del equipo  

Archivo entregable:  
**20252-PA-et0057-tia5-DDL-equipo-01-informe.docx**

---

## 🎥 5. Enlace del Video de Sustentación

- Debe explicar el modelo físico, los scripts y decisiones de diseño.  
- Todos los integrantes deben participar.  

Archivo entregable:  
**20252-PA-et0057-tia5-DDL-equipo-01-enlace-video.txt**  
*(Solo enlace, NO subir el video al repositorio)*

---

## 📂 Archivos incluidos en esta carpeta

- `20252-PA-et0057-tia5-DDL-equipo-01-informe.docx`  
- `20252-PA-et0057-tia5-DDL-equipo-01-resultados.xlsx`  
- `20252-PA-et0057-tia5-DDL-equipo-01-scripts-DDL-Creacion.sql`  
- `20252-PA-et0057-tia5-DDL-equipo-01-scripts-DDL-Modificacion.sql`  
- `20252-PA-et0057-tia5-DDL-equipo-01-enlace-video.txt`  
- `README.md`  

---

## 👥 Integrantes del Grupo

- **Jhon Alejandro Montaño Ortiz** (Líder)  
- Juan Manuel Lopera Betancur   
- Juan Pablo Agudelo Pérez  
- Edinson Stiben Sinitave Marín  

---

## 🏫 Información Académica

**Institución:** Institución Universitaria Pascual Bravo  
**Programa:** Tecnología en Desarrollo de Software  
**Asignatura:** Bases de Datos I (Código ET-0057)  
**Docente:** Jaime E. Soto U.  
**Periodo:** 2025-2  

---
