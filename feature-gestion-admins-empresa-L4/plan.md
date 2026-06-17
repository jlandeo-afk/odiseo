# Plan · Gestión de Usuarios Administradores de Empresa

**Versión:** 1.1  
**Alineado con:** [Constitution v1.1](../../constitution.md) (2026-06-17)

## Resumen ejecutivo

Se crea un nuevo sub-módulo `Client/Admin/` bajo la arquitectura hexagonal V2, desacoplado del flujo de creación de empresa. Expone 4 endpoints REST anidados bajo `/v2/client/{companyId}/admins` con autorización restringida al super admin de empresa base vía middleware `EnsureSuperAdminBase`. Reutiliza el contrato `StoreUserContract` del módulo User para la creación de usuarios y empleados (Art. IV 4.6 — comunicación entre módulos vía contratos). La eliminación es soft delete en cascada (`company_user_admin` + `users_roles` + `employees` + `users`) dentro de una transacción atómica (Art. III 3.6, Art. IV 4.7). El frontend agrega un sub-módulo con tabla y formulario dentro de la pantalla de empresa.

---

## 1. Enfoque técnico (alto nivel)

Nuevo módulo hexagonal `Client/Admin/` con cuatro Use Cases independientes: listar (paginado con búsqueda), crear (usuario + empleado + rol + pivote), actualizar (sin email) y eliminar (soft delete cascada). Las operaciones de escritura se envuelven en `TransactionalUseCase` (Art. IV 4.7). Se reutiliza `StoreUserContract` del módulo `User` para evitar duplicar lógica de creación de usuarios (Art. IV 4.6). El frontend consume los endpoints mediante un nuevo servicio `admin.service.ts` — con método `list` de único parámetro para `useTableData` (Art. VII 7.1) — y renderiza una tabla con diálogo de creación/edición (Vuetify + VForm + lazy imports, Art. IV 4.10).

**Rutas:**
```
GET    /v2/client/{companyId}/admins       → ListAdminsUseCase
POST   /v2/client/{companyId}/admins       → StoreAdminUseCase
PUT    /v2/client/{companyId}/admins/{id}  → UpdateAdminUseCase
DELETE /v2/client/{companyId}/admins/{id}  → DeleteAdminUseCase
```

---

## 2. Componentes / archivos afectados

### Backend — Nuevo módulo `src/App/Modules/V2/Client/Admin/`

| Capa | Archivo | Propósito |
|------|---------|-----------|
| **Domain** | `Entities/AdminEntity.php` | Entidad inmutable con datos del admin (id, nombres, apellidos, email, documento, teléfono). Validación de invariantes en constructor (Art. IV 4.4). |
| **Domain** | `Repositories/Read/AdminReadRepositoryInterface.php` | Contrato de lectura: listar por companyId con búsqueda y paginación. Retorna `DataTableEntity` (Art. IV 4.5). |
| **Domain** | `Repositories/Write/AdminWriteRepositoryInterface.php` | Contrato de escritura: crear pivote, actualizar datos vía `employees`, soft delete cascada. Opera con Entities (Art. IV 4.5). |
| **Domain** | `Validators/AdminValidatorInterface.php` | Contrato de validación: empresa existe, email único, mínimo 1 admin, obtener roleId (Art. IV 4.9). |
| **Application** | `UseCases/ListAdminsUseCase.php` | `final class`, método `execute(ListAdminsRequestDto): PaginatedAdminResponseDto` (Art. IV 4.2). |
| **Application** | `UseCases/StoreAdminUseCase.php` | `final class`, orquesta creación de user + employee vía `StoreUserContract` + asigna rol vía pivote. |
| **Application** | `UseCases/UpdateAdminUseCase.php` | `final class`, actualiza datos del empleado subyacente (bloquea email). |
| **Application** | `UseCases/DeleteAdminUseCase.php` | `final class`, soft delete cascada validando que no sea el último admin (Art. III 3.6). |
| **Application** | `Dtos/Requests/ListAdminsRequestDto.php` | `companyId`, `search`, `page`, `perPage` — `final readonly` (Art. IV 4.3). |
| **Application** | `Dtos/Requests/StoreAdminRequestDto.php` | `companyId`, `names`, `firstSurname`, `secondSurname`, `email`, `document`, `typeDocumentId`, `phone`, `password`, `createdBy`. |
| **Application** | `Dtos/Requests/UpdateAdminRequestDto.php` | `id`, `companyId`, `names`, `firstSurname`, `secondSurname`, `document`, `typeDocumentId`, `phone`, `updatedBy`. |
| **Application** | `Dtos/Requests/DeleteAdminRequestDto.php` | `id`, `companyId`, `deletedBy`. |
| **Application** | `Dtos/Responses/AdminResponseDto.php` | `id`, `names`, `firstSurname`, `secondSurname`, `email`, `document`, `phone` — `final readonly`. |
| **Application** | `Dtos/Responses/PaginatedAdminResponseDto.php` | `data: AdminResponseDto[]`, `total`, `page`, `perPage`, `lastPage`. |
| **Infrastructure** | `Http/Controllers/AdminController.php` | `index`, `store`, `update`, `destroy` — extiende `Src\Http\Controller`. Usa `TransactionalUseCase` en escritura (Art. IV 4.7). |
| **Infrastructure** | `Http/Mappers/AdminMapper.php` | Convierte Request de Laravel → RequestDto (extrae `userId` de `system_data`). |
| **Infrastructure** | `Http/Validators/ListAdminsRequestValidator.php` | Extiende `DataTableRequestValidator`. Reglas: `company_id` desde ruta + params de paginación. |
| **Infrastructure** | `Http/Validators/StoreAdminRequestValidator.php` | Reglas: `names`, `first_surname`, `second_surname`, `email`, `document`, `type_document_id`, `phone`, `password`. |
| **Infrastructure** | `Http/Validators/UpdateAdminRequestValidator.php` | Reglas: `names`, `first_surname`, `second_surname`, `document`, `type_document_id`, `phone` — sin email ni password (AC-2.4). |
| **Infrastructure** | `Http/Responses/AdminResponse.php` | Formatea `AdminResponseDto` → JSON y `PaginatedAdminResponseDto` → JSON paginado (Art. IV 4.10). |
| **Infrastructure** | `Http/Routes/RoutesAdmin.php` | Registro de rutas con middleware `auth:sanctum` + `EnsureSuperAdminBase`. |
| **Infrastructure** | `Http/Routes/index.php` | Point de entrada para el grupo de rutas del módulo. |
| **Infrastructure** | `Http/Middleware/EnsureSuperAdminBase.php` | Verifica que el usuario autenticado tenga rol `fl_administrator = true` en empresa base (company_id = 1). Retorna 403 si no. |
| **Infrastructure** | `Persistences/QueryBuilder/Read/AdminReadQueryBuilder.php` | Query sobre `company_user_admin` JOIN `employees` JOIN `users` con paginación y búsqueda ILIKE. Filtra `deleted_at IS NULL` + `fl_active = true`. Retorna DTOs planos (Art. VII 7.1). |
| **Infrastructure** | `Persistences/QueryBuilder/Write/AdminWriteQueryBuilder.php` | Inserciones/actualizaciones en `company_user_admin` y `employees`. Soft delete en cascada: UPDATE `deleted_at`, `deleted_by`, `fl_active=false` / `fl_status=false` en las 4 tablas (Art. III 3.6). |
| **Infrastructure** | `Persistences/QueryBuilder/Validator/AdminValidatorQueryBuilder.php` | Implementa `AdminValidatorInterface`: consultas de existencia de empresa, unicidad de email, conteo de admins, búsqueda de `roleId`. |
| **Infrastructure** | `Providers/AdminServiceProvider.php` | Binding de interfaces → implementaciones (singleton). |
| **Infrastructure** | `Providers/index.php` | Retorna array con `AdminServiceProvider::class` para auto-discovery (Art. IV 4.5). |

### Backend — Archivos existentes modificados

| Archivo | Cambio |
|---------|--------|
| `src/Bootstrap/Routes.php` | Agregada línea: `Route::prefix('v2/client')→group(...Admin/...Routes/index.php')` bajo prefijo `/v2/client` con `whereNumber('companyId')`. |

### Frontend — Nuevos archivos

| Archivo | Propósito |
|---------|-----------|
| `src/modules/company/services/admin.service.ts` | Singleton. Método `list(parameters)` con único parámetro para `useTableData` (Art. VII 7.1). `store`, `update`, `delete` con rutas completas vía `VITE_API_URL`. |
| `src/modules/company/components/AdminManagementTable.vue` | Tabla paginada (`VDataTableServer` + `useTableData`) con botones editar/eliminar y diálogo de formulario lazy-loaded. |
| `src/modules/company/dialogs/AdminFormDialog.vue` | Diálogo de creación/edición (`VDialog` + `VForm`) con validación VFORM, campos condicionales (password solo en create, email disabled en edit). |
| `src/modules/company/models/Admin.ts` | Interfaces TypeScript `Admin` (datos de respuesta) y `AdminFormData` (payload de formulario). |

### Frontend — Archivos existentes modificados

| Archivo | Cambio |
|---------|--------|
| `src/modules/company/pages/company.page.vue` | Agregado botón "Administradores" (`ri-admin-line`) en columna de acciones + `VDialog` con `AdminManagementTable` lazy-loaded. |
| `src/modules/company/routes.ts` | Sin cambios (el sub-módulo se accede dentro de la página de empresa, no como ruta independiente). |

**Reglas de frontend aplicables (Art. IV 4.10):**
- TypeScript estricto: todos los componentes nuevos usan `<script setup lang="ts">`, sin `any` (Art. VII 7.1).
- VFORM: el formulario del diálogo usa `v-form` con reglas de validación explícitas (`isRequired`, `isLengthBetween`, `isEmail`).
- Diálogos: botón X de cerrar, botón "Cerrar" en actions, botón "Guardar" primary flat.
- Inputs: placeholder definido en cada campo, atributos `count`/`max` donde aplique validación de longitud.
- Lazy imports: componentes importados con `() => import(...)` (Art. VII 7.1).
- `useTableData`: servicio `list` con un solo parámetro (Art. VII 7.1). Parámetro `companyId` se pasa vía `additionalParameters` del composable.

---

## 3. Decisiones de arquitectura (mini-ADR)

### DECISIÓN 1: Sub-módulo independiente `Client/Admin/`

**POR QUÉ**: La gestión de administradores es una responsabilidad distinta a la creación de empresa. Separarla en su propio módulo hexagonal evita inflar el `ClientController` y los repositorios existentes. Sigue el mismo patrón que `Client/Headquarters/`, que ya es un sub-módulo independiente.

**ALTERNATIVA DESCARTADA**: Agregar endpoints al `ClientController` existente y métodos al `ClientWriteRepository`. Se descartó porque el módulo `Client/Client/` ya gestiona empresa, representantes legales, sedes y universidades; añadir administradores lo convertiría en un "god module".

### DECISIÓN 2: Reutilizar `StoreUserContract` del módulo `User`

**POR QUÉ**: El `CreateClientUseCase` ya inyecta y usa `StoreUserContract` para crear el primer administrador. Reutilizar este contrato evita duplicar la lógica de creación de usuario + empleado y mantiene la coherencia con el flujo existente (Art. IV 4.6 — comunicación entre módulos vía contratos). El `StoreAdminUseCase` orquesta: valida → crea usuario/empleado vía contrato → asigna rol → inserta pivote.

**ALTERNATIVA DESCARTADA**: Implementar la creación de usuario y empleado directamente en el repositorio `AdminWriteQueryBuilder`. Se descartó porque duplicaría lógica ya probada del módulo `User`, violaría el principio de comunicación entre módulos, y generaría deuda de mantenimiento.

### DECISIÓN 3: Soft delete en cascada dentro de transacción atómica

**POR QUÉ**: La constitución (Art. III 3.6) exige soft delete (`deleted_at`, `deleted_by`) en todas las tablas, con actualización de `fl_status`/`fl_active` a `false` donde aplique. La eliminación de un administrador afecta 4 tablas: `company_user_admin` (SET `deleted_at`, `deleted_by`, `fl_active=false`), `users_roles` (SET `fl_status=false`), `employees` (SET `deleted_at`, `deleted_by`, `fl_status=false`), `users` (SET `deleted_at`, `deleted_by`, `fl_status=false`). Todas las operaciones se envuelven en `TransactionalUseCase` (Art. IV 4.7), garantizando atomicidad y previniendo datos huérfanos.

**ALTERNATIVA DESCARTADA**: Hard delete físico de los 4 registros. Se descartó porque viola el Art. III 3.6 de la constitución, impide auditoría futura, y rompe la trazabilidad de datos. El soft delete preserva los registros para consultas administrativas y mantiene consistencia con el resto del sistema.

### DECISIÓN 4: Pivote `company_user_admin` como fuente de verdad para listado

**POR QUÉ**: Se consulta `company_user_admin` con JOIN a `employees` y `users` para obtener los datos completos. El `employee_id` en el pivote es la llave que vincula todo. La búsqueda por nombre/email se aplica sobre las columnas de `employees` y `users` usando ILIKE para case-insensitive (PostgreSQL). Se filtran registros con `deleted_at IS NULL` y `fl_active = true` para consistencia con soft delete (Art. III 3.6).

**ALTERNATIVA DESCARTADA**: Usar la tabla `users_roles` filtrando por `role_id` del rol "Super Administrador". Se descartó porque un mismo rol podría (en el futuro) tener permisos distintos por empresa, y el pivote `company_user_admin` es el contrato explícito de "este empleado es admin de esta empresa".

---

## 4. Riesgos y dependencias

### Riesgos

| Riesgo | Mitigación |
|--------|-----------|
| **Datos huérfanos en eliminación**: si el soft delete falla a mitad de la cascada, registros quedan inconsistentes. | Envolver en `TransactionalUseCase` con rollback automático (Art. IV 4.7). |
| **Condición de carrera**: dos super admins base crean simultáneamente un admin con el mismo email. | Validación de unicidad de email a nivel de aplicación (validator) + constraint único en DB (`users.email` UNIQUE). |
| **Inconsistencia con CreateClientUseCase**: el flujo legacy crea el primer admin; el nuevo módulo gestiona los siguientes. Ambos deben coexistir. | El `CreateClientUseCase` no se modifica. El `AdminWriteQueryBuilder` usa las mismas tablas y contratos, garantizando compatibilidad. |
| **Rendimiento del listado**: JOIN de 3 tablas (`company_user_admin` + `employees` + `users`) con búsqueda ILIKE. | Índices existentes en FK (`company_id`, `employee_id`). Agregar índice en `users.email` y `employees.first_name` si no existen. NFR-1 acota a < 200 ms (Art. III 3.5). |
| **Acumulación de datos por soft delete**: registros no se eliminan físicamente, crecen con el tiempo. | Los queries de lectura filtran `deleted_at IS NULL` y `fl_active/fl_status = true`. Plan de purga futura si es necesario. |
| **Middleware EnsureSuperAdminBase con company_id=1**: si la empresa base cambia de ID. | Extraer a configuración o variable de entorno en futura iteración. Por ahora, company_id=1 es la empresa base del sistema. |

### Dependencias

| Dependencia | Tipo | Estado |
|-------------|------|--------|
| `StoreUserContract` (`User` module) | Contrato de creación de usuarios (Art. IV 4.6) | Existente y probado |
| `TransactionalUseCase` (`Shared`) | Wrapper de transacciones (Art. IV 4.7) | Existente |
| `ExistsValidatorInterface` (`Shared`) | Validador genérico de existencia | Existente |
| `DataTableRequestValidator` (`Utils`) | Validador base para endpoints paginados | Existente |
| Tabla `company_user_admin` | Migración de base de datos | Existente |
| Tabla `roles` (rol "Super Administrador") | Creado por `CreateClientUseCase` | Existente |
| Tabla `users_roles` | Pivote usuario-rol | Existente |
| `odiseoApi` (Axios) | Cliente HTTP frontend | Existente |
| `useTableData` (composable) | Paginación unificada en frontend (Art. IV 4.10) | Existente |
| `JwtAuthenticate` middleware | Setea `system_data.userId` en request (Art. IV 4.10) | Existente |

---

## 5. Trazabilidad: US → implementación

| Requisito | Componente(s) |
|-----------|---------------|
| **US-1 / AC-1.1** (listar con datos) | `ListAdminsUseCase` → `AdminReadQueryBuilder::listByCompany()` → JOIN `company_user_admin` + `employees` + `users`, filtra `deleted_at IS NULL` + `fl_active = true`. |
| **US-1 / AC-1.2** (lista vacía) | Mismo Use Case, retorna `data: []` cuando no hay registros activos. |
| **US-1 / AC-1.3** (búsqueda) | `ListAdminsRequestDto.search` → `AdminReadQueryBuilder` aplica `WHERE (e.first_name ILIKE %s% OR u.email ILIKE %s%)`. |
| **US-1 / AC-1.4** (403 forbidden) | `EnsureSuperAdminBase` middleware: verifica `users_roles` JOIN `roles` donde `fl_administrator = true` y `company_id = 1`. |
| **US-2 / AC-2.1** (crear admin) | `StoreAdminUseCase` → `AdminValidatorInterface::validateCompanyExists()` + `validateUniqueEmail()` → `StoreUserContract::storeUser()` → `AdminWriteQueryBuilder::createCompanyUserAdmin()`. |
| **US-2 / AC-2.2** (email duplicado) | `AdminValidatorInterface::validateUniqueEmail()` — consulta `users.email`, lanza `DomainException` 409. |
| **US-2 / AC-2.3** (actualizar) | `UpdateAdminUseCase` → `AdminWriteQueryBuilder::updateAdmin()` — actualiza columnas en `employees` + `updated_by` en `company_user_admin`. |
| **US-2 / AC-2.4** (bloquear email en PUT) | `UpdateAdminRequestValidator` no incluye `email` en reglas; `AdminMapper` no mapea email en PUT; frontend deshabilita campo email en modo edición. |
| **US-2 / AC-2.5** (eliminar — soft delete) | `DeleteAdminUseCase` → `AdminWriteQueryBuilder::deleteCascade()` — UPDATE `deleted_at`, `deleted_by`, `fl_active=false`/`fl_status=false` en `company_user_admin` + `users_roles` + `employees` + `users` (Art. III 3.6). |
| **US-2 / AC-2.6** (último admin) | `AdminValidatorInterface::validateNotLastAdmin()` — cuenta registros activos en `company_user_admin` excluyendo el adminId a eliminar. |
| **US-2 / AC-2.7** (empresa inexistente) | `AdminValidatorInterface::validateCompanyExists()` — consulta `companies` con `deleted_at IS NULL`, lanza `NotFoundRecordException` 404. |
| **US-2 / AC-2.8** (403 forbidden escritura) | Mismo middleware `EnsureSuperAdminBase` que US-1. |

---

## 6. Notas adicionales

- **Convenciones**: todas las clases `final readonly`, DTOs con sufijos `RequestDto`/`ResponseDto`, Use Cases con único método `execute()`, validadores en `Domain/Validators/` con implementación en `Infrastructure` (Art. IV 4.1-4.9).
- **Paginación**: misma estructura que el módulo `Client`: `page`, `perPage` (default 10), respuesta con `data`, `total`, `current_page`, `last_page`.
- **Persistencia**: consultas simples con Query Builder de Laravel (`ConnectionBuilder::read()` / `ConnectionBuilder::write()`); no se crean funciones PL/pgSQL para queries de este módulo (Art. IV 4.12). Los repositorios de lectura retornan DTOs planos, nunca Entities (Art. VII 7.1).
- **Soft delete**: todas las eliminaciones usan UPDATE con `deleted_at`, `deleted_by`, y `fl_active=false`/`fl_status=false` según corresponda (Art. III 3.6). Los queries de lectura siempre filtran `deleted_at IS NULL` y `fl_status/fl_active = true`.
- **Verificación de esquema**: antes de escribir queries, se verificaron los nombres reales de columnas en las migraciones existentes (`company_user_admin`, `employees`, `users`, `users_roles`, `roles`). No se asumen nombres de columnas (Art. VII 7.3).
- **Frontend — Vuetify**: tabla con `v-data-table-server`, diálogo con `v-dialog` + `v-form` (validación VFORM obligatoria), alerts con SweetAlert singleton.
- **Frontend — Servicio**: `list` recibe un único parámetro `parameters: Record<string, any>` para cumplir con `useTableData` (Art. VII 7.1). `companyId` se pasa vía `additionalParameters` del composable.
- **Tests**: se detallan en `test-cases.md` con 41 casos (27 backend + 17 frontend + 14 BDD). La estrategia sigue las 4 fases: Smoke → CRUD → Negativos (Art. VII 7.1). Los tests de integración validan contra base de datos real (Art. VII 7.3).
- **NFR-5 (trazabilidad de escritura)**: `created_by`, `updated_by`, `deleted_by` registrados en toda operación. El middleware `JwtAuthenticate` inyecta `system_data.userId` en el request.
- **Constitution v1.1**: este plan cumple con las reglas introducidas en la actualización del 2026-06-17: soft delete obligatorio (Art. III 3.6), single-param para `useTableData` (Art. VII 7.1), y estructura dual de test-cases (Unit + BDD).
