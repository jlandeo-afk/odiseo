# Arquitectura Base y Estructura de Datos del Sistema

Este documento detalla el mapa de datos y el diseño modular del ecosistema administrativo del software, estructurado por capas funcionales, responsabilidades de negocio y de infraestructura general/regional.

---

## Índice de Módulos
1. [Seguridad, Configuración y Sistema (Infraestructura Base)](#1-seguridad-configuraci%C3%B3n-y-sistema-infraestructura-base)
2. [Institucional, Comercial y Usuarios (Empresas y Sedes)](#2-institucional-comercial-y-usuarios-empresas-y-sedes)
3. [Planificación Académica y Sílabo](#3-planificaci%C3%B3n-acad%C3%A9mica-y-s%C3%ADlabo)
4. [Banco de Preguntas y Orígenes (Core)](#4-banco-de-preguntas-y-or%C3%ADgenes-core)
5. [Inteligencia Artificial (Módulo IA y NQ)](#5-inteligencia-artificial-m%C3%B3dulo-ia-y-nq)
6. [Generación de Materiales, Exámenes y Balotarios](#6-generaci%C3%B3n-de-materiales-ex%C3%A1menes-y-balotarios)
7. [Diagramación (DiDi), Empleados y Revisiones](#7-diagramaci%C3%B3n-didi-empleados-y-revisiones)
8. [Tablas Obsoletas, Temporales o Logs (Candidatas a Revisión)](#8-tablas-obsoletas-temporales-o-logs-candidatas-a-revisi%C3%B3n)

---

## 1. Seguridad, Configuración y Sistema (Infraestructura Base)
Todo el ecosistema administrativo que soporta el software a nivel general y regional.

### Autenticación, Sesiones y Permisos (Spatie)
* `users`: Credenciales principales de acceso al sistema.
* `roles` / `permissions`: Definición de roles y acciones permitidas.
* `users_roles` / `roles_permissions`: Tablas pivot para enlazar usuarios con roles y roles con permisos.
* `personal_access_tokens`: Emisión de tokens para consumo de API.
* `remembered_sessions`: Registro de sesiones activas, IPs y dispositivos.

### Geolocalización (Ubigeo)
* `region`, `provinces`, `districts`: Tablas jerárquicas estándar para ubicaciones físicas.

### Configuraciones Globales
* `advanced_settings`: Parámetros de negocio (límites de preguntas, tolerancias de fechas) funcionales actualmente para la empresa base.
* `configuration_alternative`: Definición de estilos, uso de imágenes y visualización por defecto de las alternativas.
* `institution_types` / `type_documents`: Catálogos de tipos de instituciones y documentos de identidad.

---

## 2. Institucional, Comercial y Usuarios (Empresas y Sedes)
Gestión multitenant (B2B). Aquí se define a quién se le vende el software y quiénes lo operan.

### Clientes y Negocios
* `companies` / `clientes_empresas`: Registro principal de los clientes B2B, sus dominios y datos de facturación.
* `plans`: Planes de suscripción, costos y límites (usuarios/preguntas) que limitan a las empresas.
* `company_legal_representatives`: Datos formales para contratos B2B.

### Infraestructura Física
* `headquarters` / `company_headquarters`: Sedes físicas asociadas a cada empresa.
* `classroom` / `headquarters_classroom`: Aulas específicas distribuidas dentro de las sedes.

### Objetivos y Prospección
* `universities` / `company_universities`: Catálogo de universidades a las que apunta preparar cada empresa.
* `option_university` / `origin_university`: Variantes o modalidades de ingreso por universidad.
* `prospect` / `code_prospect`: Registro de prospectos comerciales y sus códigos de validación.

### Personal Operativo y Docente
* `employees` / `company_user_admin`: Empleados y administradores ligados a las empresas.
* `teachers`: Extensión de empleados con parámetros de metas (`goal`), lotes (`lot`) y límites de asignación de preguntas.
* `charge`: Cargos jerárquicos del personal.
* `employee_course` / `employee_university`: Relación de qué docente dicta qué curso y para qué universidad.
* `level_rates`: Costos pagados al personal por pregunta, dependiendo del nivel.

---

## 3. Planificación Académica y Sílabo
El motor que cruza la malla curricular con el tiempo.

### Malla Curricular Base
* `course` / `pseudo_course` / `course_pseudo_course` / `course_pseudo_courses`: Catálogo de cursos reales y sus agrupadores/alias.
* `topic` / `subtopic`: Ramificación temática estándar.
* `level` / `course_level`: Niveles de dificultad jerarquizados por curso.
* `course_assigned_categories` / `course_assigned_subcategories` / `course_text_category_settings`: Configuraciones de categorización que aplican directamente a nivel del curso.
* `network_course_topic_subtopic`: Enlaces de red entre cursos y temas.

### Manejo del Tiempo y Ciclos
* `cycle` / `cycle_types`: Ciclos comerciales y su tipología (anual, semestral, repaso).
* `week` / `type_week` / `periodicity`: Catálogos de tiempo.
* `cycle_weeks`: Fechas exactas de las semanas del ciclo. Para mantener una alineación perfecta con el frontend visual, la lógica de negocio conserva aquí las semanas "inactivas" como registros existentes y válidos (con sus respectivos identificadores), permitiendo recorrerlas sin que rompan la interfaz.

### Estructura del Sílabo (Core de Planificación)
* `syllabus`: Cabecera principal del sílabo.
* `syllabus_template` / `syllabus_template_topic` / `syllabus_template_topic_subtopic`: Plantillas reutilizables para armar sílabos rápidos.
* `syllabus_topic` / `syllabus_topic_week` / `syllabus_detail_subtopic` / `syllabus_subtopic_type_material`: Asignación granular de subtemas y materiales específicos a semanas exactas.
* `syllabus_text_weeks` / `syllabus_text_distributions` / `syllabus_texts` / `syllabus_text_content` / `syllabus_text_detail` / `syllabus_type_text`: La variante del sílabo exclusiva para cursos basados en textos de comprensión lectora.
* `syllabus_week_titles`: Títulos personalizados para semanas específicas.
* `level_syllabus` / `level_syllabus_weeks` / `detail_level_syllabus_weeks` / `detail_level_syllabus_weeks_parents`: El sílabo independiente que rige por el nivel de dificultad.

---

## 4. Banco de Preguntas y Orígenes (Core)
El repositorio de reactivos, su taxonomía, archivos adjuntos y procedencia.

### Reactivos y Textos
* `parent_question` / `parent_question_correlative`: Preguntas padre o contextos largos (textos de RV, casos clínicos).
* `question` / `question_correlative` / `question_secondary`: Las preguntas individuales, hijas, o de soporte.
* `alternative`: Las opciones cerradas de las preguntas.

### Multimedia y Fórmulas
* `question_image` / `parent_image`: Imágenes estáticas incrustadas.
* `alternative_maths` / `question_maths`: Rutas de imágenes vectoriales o fórmulas generadas por herramientas de terceros (ej. Wiris).

### Taxonomía, Saberes y Atributos
* `type_text` / `type_text_templates` / `type_text_subcategories` / `type_text_to_subcategory` / `type_texts_subtopics` / `type_texts_topics` / `type_text_level`: Clasificación profunda exclusiva para textos.
* `question_attributes` / `question_attributes_type` / `question_attributes_type_course` / `question_attributes_types_values`: Sistema de metadatos llave-valor (dificultad, etiquetas).
* `essential_knowledges` / `essential_knowledge_image` / `essential_knowledge_questions`: Los saberes previos (teoría) que el alumno necesita dominar antes de resolver la pregunta.
* `modality` / `modality_options` / `option`: Modalidades bajo las cuales se clasifica la evaluación.
* `importance_rejected` / `category_rejected`: Tipificación para priorizar preguntas que rebotaron en QA.
* `question_refuzed` / `question_observation` / `parent_observation` / `question_status`: Control de estados, observaciones de auditoría y rechazos.
* `question_shares` / `question_subtopic`: Tablas pivot de compartición.

### Orígenes e Historial de Uso (Trazabilidad)
* `origin_question` / `origin_parent_question`: De qué examen de admisión, universidad, año y área se extrajo el ítem original.
* `question_history_cycle` / `question_history_course` / `question_history_usage_exam_parent_question`: Rastreo de en qué ciclo o examen ya se usó una pregunta, vital para evitar repeticiones en la generación automática.
* `frequent_university_subtopic`: Estadísticas de temas que más se repiten en ciertas universidades (frecuencia).

---

## 5. Inteligencia Artificial (Módulo IA y NQ)
Procesamiento de contenido en crudo o generación automatizada mediante prompts.

### Generación IA
* `question_teacher_ia`: Contenedor del prompt, base teórica, formato y respuesta procesada por IA a solicitud de un docente.
* `alternative_questions_ia`: Las opciones A, B, C, D inferidas o extraídas por la IA.

### Multimedia IA
* `question_ia_images` / `alternative_ia_images` / `solution_ia_images`: Recursos gráficos enlazados a flujos procesados por inteligencia artificial.

### Integración NQ
* `nq_user_request` / `nq_user_token` / `origin_question_nq` / `question_field_diagrammed_nq`: Sistema de tokens y colas de peticiones para herramientas externas de normalización o consultas.

---

## 6. Generación de Materiales, Exámenes y Balotarios
Ensamblaje final de las preguntas para crear los entregables que llegan a las aulas.

### Plantillas y Configuraciones Estructurales
* `type_material` / `type_material_bound` / `type_material_periodicity`: Reglas base (clase, examen, simulacro).
* `type_material_template` / `type_templates` / `type_archive` / `type_exams`: Plantillas maestras de documentos.
* `type_material_template_configuration_columns` / `material_column_configurations`: Cuántas columnas lleva el PDF final.
* `template_type_material_configurations` / `template_type_material_courses_order`: Orden visual de los cursos en el entregable.
* `material_configurations` / `material_configuration_details` / `material_configuration_detail_value`: Parámetros dinámicos para los encabezados.
* `type_material_area` / `type_material_course` / `type_material_area_courses` / `type_material_detail_template` / `type_material_detail_courses` / `type_material_detail_course_texts` / `type_material_detail_text_subquestions`: Definición de cantidad de textos y preguntas exactas por curso en un tipo de material.
* `type_text_exam_material_configuration` / `type_text_material_type_course` / `type_text_material_type_course_area`: Configuraciones específicas de límites cuando hay textos en los materiales.
* `exam_material_configurations` / `exam_material_config_area_courses` / `exam_material_config_area_course_levels`: Reglas para exámenes.

### Ensamblaje Físico y Empaquetado
* `material` / `detail_week_type_mat` / `separated_material_week` / `separated_material_exam_week` / `material_class_week`: Generación de la cabecera del material y su segregación por semanas para descarga final (con y sin solución).
* `exam_area` / `material_exam_area_week` / `material_exam_parent_question` / `material_exam_question`: Generación estricta de exámenes segmentados por áreas de admisión (Ej: Área A Ciencias, Área E Letras).
* `material_ballot_question` / `material_ballot_subquestions` / `material_distribution_ballot_questions`: Balotarios de donde los docentes pueden escoger preguntas.

### Periodos (Agrupaciones Analíticas)
* `material_per_period` / `material_per_period_ballot` / `material_per_period_ballot_class` / `material_per_period_ballot_url` / `material_per_period_course` / `material_per_period_exam` / `material_per_period_week_course` / `material_per_period_level_limit_config`: Estructuras para sacar un compilado masivo o corte de materiales (por ejemplo, "Libro del Bimestre").

### Estadísticas Analíticas
* `material_ballot_stats_global` / `material_ballot_stats_areas` / `material_ballot_stats_area_courses`: Conteo analítico de preguntas nuevas vs repetidas en balotarios.
* `material_exam_stats_global` / `material_exam_stats_areas` / `material_exam_stats_area_courses`: Conteo analítico de efectividad de los exámenes.
* `question_excluded_material`: Registro de preguntas que se forzaron a salir de un material.

---

## 7. Diagramación (DiDi), Empleados y Revisiones
Flujo de trabajo para los operarios: tipeo, escaneo, recorte de imágenes y auditoría (QA).

### Workflow de Diagramación (DiDi)
* `employee_didi_question` / `employee_didi_question_field`: Tarea madre de digitalización asignada a un empleado y los campos específicos (texto, imagen, respuesta) que debe transcribir o escanear.
* `employee_didi_question_field_image_active` / `employee_didi_question_field_image_inactive`: Particiones de PostgreSQL que separan físicamente las imágenes aprobadas y vigentes de las que ya no sirven, optimizando fuertelmente los `SELECT`.
* `employee_didi_question_image` / `didi_maths` / `employee_question_image` / `employee_question_maths`: Rutas de las digitalizaciones recortadas.
* `employee_question` / `employee_question_document`: Repositorio del material resuelto o documentación de soporte.
* `course_didi_assignment_state` / `setting_diagrammed_courses` / `field_diagrammed`: Reglas de qué cursos pasan por DiDi y qué campos son obligatorios.

### Control de Calidad (Revisiones)
* `material_revisions` / `material_revision_items` / `material_revision_courses`: Flujo de QA donde un coordinador revisa que todo el material generado esté impecable para el cliente.
* `material_question_change_reason`: Auditoría de por qué un revisor cambió la pregunta X por la Y.

### Flujo de Preguntas Faltantes (Tracking)
* `material_missing_question` / `material_missing_question_detail` / `material_missing_question_tracking`: Sistema interno de tickets. Si un material se generó pero le faltan 5 preguntas de geometría, aquí se detecta, se detalla y se audita qué empleado solucionó el faltante.

### Notificaciones y Procesos en Background
* `material_generation_notifications` / `material_generation_notification_types` / `individual_notifications`: Avisos push o webhooks de éxito/error al compilar el PDF.
* `question_pdf_jobs`: Control del worker que imprime el PDF de la pregunta.
* `image_gallery` / `image_galery_topic`: Banco general de imágenes globales reutilizables.

---

## 8. Tablas Obsoletas, Temporales o Logs (Candidatas a Revisión)
Tablas que no pertenecen al modelo de dominio vivo, sino que son volcados de migraciones, auditoría histórica pesada o control del framework de Laravel. Mantenerlas aisladas es vital para no ensuciar la lógica de consultas principales.

### Respaldos de Migraciones de Datos
* `_bkp_migration_tm_mapping`
* `_bkp_migration_tma_mapping`
* `_bkp_migration_tmc_mapping`

### Control del Framework y Colas
* `migrations`: Control de las clases de migración ejecutadas.
* `failed_jobs`: Registro de los jobs que crashearon (ej. un PDF que no se pudo armar).
* `job_batches`: Control de lotes de trabajos en background.

### Históricos y Temporales (Logs)
* `question_temporary`: Datos volátiles en la memoria transaccional.
* `history_digitalized_solution_question_pdf`: Log de las soluciones subidas en el pasado.
* `history_syllabus`: Log denso de todos los cambios de un sílabo.
* `subtopic_history`: Log de cambios en los subtemas.
* `material_revision_histories`: Auditoría de quién movió el estado de una revisión (quién lo aprobó o rechazó).
