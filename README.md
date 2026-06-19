# Proyecto Odiseo - Talleres

Este repositorio contiene los entregables y el trabajo desarrollado durante los talleres para el proyecto Odiseo.

## Taller 1: Construcción de un Agente

El primer taller consistió en la **construcción de un agente disciplinado**. Se sentaron las bases para que el agente pudiera interactuar y operar con el modelo de datos de Odiseo, definiendo esquemas, contexto del proyecto y herramientas (incluyendo el diseño inicial de la base de datos y directrices para los agentes).

**Directorio asociado:** `taller-1/`

---

## Taller 2: Spec, Plan y Pruebas en modo "Three Amigos"

El segundo taller introduce la metodología **Non-Deterministic Spec-Driven Development: Enterprise Edition (SDD)**. El objetivo central de este taller es "darle intención de verdad" al agente creado en el Taller 1. Un agente sin una especificación clara que lo guíe solo amplifica la confusión a escala; por lo tanto, el enfoque aquí es el *shift-left*: invertir minutos en definir bien la intención para ahorrar horas de retrabajo.

Este taller corresponde a la **Parte 1** del ciclo, donde todo el trabajo se realiza "en papel" (sin escribir código de producto todavía) a través de las primeras 4 fases de SDD. Se trabaja bajo la dinámica ágil de **Three Amigos** (Product Owner, Tech Lead, y QA), donde cada rol lidera una fase y produce un artefacto clave:

- **Fase 0 (Constitution)** - Liderada por el equipo completo:
  - **Artefacto:** `constitution.md`
  - Define los principios no negociables y las reglas base del proyecto.
  
- **Fase 1 (Specify)** - Liderada por el Product Owner (PO):
  - **Artefacto:** `spec.md`
  - Define el *qué* y el *por qué* de la funcionalidad (User Stories).
  - Pasa por un **Gate de Claridad** para asegurar que no hay ambigüedades.

- **Fase 2 (Plan)** - Liderada por el Tech Lead:
  - **Artefacto:** `plan.md`
  - Define el *cómo* a alto nivel.

- **Fase 3 (Test Design)** - Liderada por QA:
  - **Artefacto:** `test-cases.md`
  - Define *cómo se prueba* la funcionalidad.
  - Pasa por un **Gate de Consistencia** para validar que la spec, el plan y los tests están perfectamente alineados.

Los artefactos son validados con "Gates de revisión humana" (personas usando checklists), asegurando que el diseño es robusto antes de pasar a la siguiente etapa en donde el agente implementará esta funcionalidad.

**Directorio asociado:** `taller-2/`
