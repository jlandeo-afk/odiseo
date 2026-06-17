# feature-gestion-admins-empresa-L4

## Equipo L4 — Three Amigos

| Rol | Integrante |
|-----|------------|
| Product (PO) | Jhon Landeo |
| Tech Lead | Junior Mayanga |
| QA | Yoemir De Oro |

## Artefactos

| Fase | Artefacto | Estado |
|------|-----------|:------:|
| 0 — Constitution | [constitution.md](../../constitution.md) | v1.1 (2026-06-17) |
| 1 — Spec (PO) | [spec.md](./spec.md) | v1 en revisión |
| 2 — Plan (Tech Lead) | [plan.md](./plan.md) | v1.1 — alineado a constitution v1.1 |
| 3 — Test Cases (QA) | [test-cases.md](./test-cases.md) | v1 — 41 casos (27 backend + 17 frontend + 14 BDD) |
| 4 — Implementation | [odiseo-backend](../../odiseo-backend/) + [odiseo-frontend](../../odiseo-frontend/) | Completado |

## Coverage Matrix

### Trazabilidad AC → Spec → Plan → Tests

| AC | Spec | Plan (Sección 5) | Backend Tests | Frontend Tests | BDD |
|----|:----:|:-----------------|:------------:|:-------------:|:---:|
| **AC-1.1** — listar con datos | US-1 | `ListAdminsUseCase` → `AdminReadQueryBuilder` | BTC-1, BTC-2, BTC-7, BTC-11 | FTC-1, FTC-7 | BDD-1 |
| **AC-1.2** — lista vacía | US-1 | Mismo Use Case, `data: []` | BTC-12 | FTC-8 | BDD-12 |
| **AC-1.3** — búsqueda | US-1 | `search` → ILIKE en `employees.first_name`, `users.email` | BTC-13, BTC-14 | FTC-9 | BDD-3, BDD-4 |
| **AC-1.4** — 403 listar | US-1 | `EnsureSuperAdminBase` middleware | BTC-22 | FTC-5 | BDD-9 |
| **AC-2.1** — crear admin | US-2 | `StoreAdminUseCase` → `StoreUserContract` → pivote | BTC-8, BTC-15 | FTC-2, FTC-10, FTC-12 | BDD-2 |
| **AC-2.2** — email duplicado | US-2 | `validateUniqueEmail()` → DomainException 409 | BTC-6, BTC-16 | FTC-6 | BDD-7 |
| **AC-2.3** — actualizar | US-2 | `UpdateAdminUseCase` → update `employees` + `company_user_admin` | BTC-9, BTC-17 | FTC-3, FTC-14 | BDD-5 |
| **AC-2.4** — bloquear email PUT | US-2 | Validator sin `email`; mapper ignora; frontend disabled | BTC-18 | FTC-15 | BDD-13 |
| **AC-2.5** — eliminar (soft delete) | US-2 | `DeleteAdminUseCase` → soft delete 4 tablas | BTC-10, BTC-19 | FTC-4, FTC-11 | BDD-6 |
| **AC-2.6** — último admin | US-2 | `validateNotLastAdmin()` → DomainException 409 | BTC-5, BTC-20 | — | BDD-8 |
| **AC-2.7** — empresa inexistente | US-2 | `validateCompanyExists()` → 404 | BTC-4, BTC-21 | — | BDD-10 |
| **AC-2.8** — 403 escritura | US-2 | Mismo middleware `EnsureSuperAdminBase` | BTC-23 | — | BDD-9 |
| **NFR-1** — <200 ms (p95) | Spec §3 | Índices FK + ILIKE optimizado | BTC-1 (smoke) | — | — |
| **NFR-2** — atomicidad POST/PUT | Spec §3 | `TransactionalUseCase` wrapper | BTC-8, BTC-9 | — | — |
| **NFR-3** — DELETE idempotente | Spec §3 | Soft delete: si ya eliminado, retorna 200 | BTC-27 | — | BDD-14 |
| **NFR-4** — cobertura ≥70% | Spec §3 | Domain≥80%, App≥70%, Feature≥60% | 27 tests | 17 tests | 14 BDD |
| **NFR-5** — `created_by`/`updated_by` | Spec §3 | `system_data.userId` en mappers + query builders | BTC-17, BTC-19 | — | — |
| **Borde: sin password** | Spec §4 | Validator `password: required` | BTC-24 | FTC-12 | — |
| **Borde: email inválido** | Spec §4 | Validator `email: email` | BTC-25 | FTC-13 | BDD-11 |
| **Borde: companyId inválido** | Spec §4 | `whereNumber('companyId')` | BTC-26 | — | — |
| **Borde: cerrar diálogo** | Spec §4 | Botón X + botón Cerrar (Art. IV 4.10) | — | FTC-16, FTC-17 | — |

### Resumen numérico

| Categoría | Cantidad | Archivo |
|-----------|:-------:|---------|
| Criterios de aceptación | 12 | [spec.md](./spec.md) |
| Requisitos no funcionales | 5 | [spec.md](./spec.md) |
| Casos borde | 6 | [spec.md](./spec.md) |
| Decisiones de arquitectura (ADR) | 4 | [plan.md](./plan.md) §3 |
| **Tests unit backend (Pest)** | **27** | [test-cases.md](./test-cases.md) §A.1 |
| **Tests unit frontend (Vitest)** | **17** | [test-cases.md](./test-cases.md) §A.2 |
| **Escenarios BDD (Gherkin)** | **14** | [test-cases.md](./test-cases.md) §B |
| **Total casos de prueba** | **41** | [test-cases.md](./test-cases.md) |
| Archivos backend creados | 28 | `src/App/Modules/V2/Client/Admin/` |
| Archivos backend modificados | 1 | `src/Bootstrap/Routes.php` |
| Archivos frontend creados | 4 | `src/modules/company/` |
| Archivos frontend modificados | 1 | `company.page.vue` |
| Endpoints REST | 4 | `GET/POST/PUT/DELETE /v2/client/{companyId}/admins` |
| Dependencias externas nuevas | 0 | — |

## Gate de claridad

| Criterio | Estado | Evidencia |
|----------|:------:|-----------|
| Todos los AC tienen trazabilidad en plan §5 | ✅ | 12 ACs mapeados a Use Cases y repositorios |
| Todos los AC tienen al menos 1 test case | ✅ | Cada AC cubierto por 1-4 tests (unit + BDD) |
| 4 ADRs documentados en plan §3 | ✅ | Decisiones 1-4 con POR QUÉ y ALTERNATIVA DESCARTADA |
| Plan alineado a constitution v1.1 | ✅ | Soft delete (Art. III 3.6), single-param service (Art. VII 7.1), test-cases dual (Unit+BDD) |
| Coverage matrix completa | ✅ | Tabla AC → Spec → Plan → Tests con 22 filas |
| Scope dentro/fuera definido | ✅ | [spec.md](./spec.md) §6 |
| Archivos nuevos vs modificados listados | ✅ | [plan.md](./plan.md) §2 |
| Riesgos identificados con mitigación | ✅ | [plan.md](./plan.md) §4 (6 riesgos) |
| Dependencias externas verificadas | ✅ | [plan.md](./plan.md) §4 (10 dependencias, 0 nuevas) |

**Gate status: READY para revisión por otro grupo**
