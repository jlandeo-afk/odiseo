# Plan · Gestión de Usuarios Administradores de Empresa

## Resumen ejecutivo

Se crea un nuevo sub-módulo `Client/Admin/` bajo la arquitectura hexagonal V2, desacoplado del flujo de creación de empresa. Expone 4 endpoints REST anidados bajo `/v2/client/{companyId}/admins` con autorización restringida al super admin de empresa base. Reutiliza el contrato `StoreUserContract` del módulo User para la creación de usuarios y empleados. La eliminación es en cascada (pivote + rol + empleado + usuario) dentro de una transacción atómica. El frontend agrega un sub-módulo con tabla y formulario dentro de la pantalla de empresa.

---

## 1. Enfoque técnico (alto nivel)

Nuevo módulo hexagonal `Client/Admin/` con cuatro Use Cases independientes: listar (paginado con búsqueda), crear (usuario + empleado + rol + pivote), actualizar (sin email) y eliminar (cascada atómica). Las operaciones de escritura se envuelven en `TransactionalUseCase`. Se reutiliza `StoreUserContract` del módulo `User` para evitar duplicar lógica de creación de usuarios. El frontend consume los endpoints mediante un nuevo servicio `admin.service.ts` y renderiza una tabla con diálogo de creación/edición.

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
| **Domain** | `Entities/AdminEntity.php` | Entidad inmutable con datos del admin (id, nombres, apellidos, email, documento, teléfono) |
| **Domain** | `Repositories/Read/AdminReadRepositoryInterface.php` | Contrato de lectura: listar por companyId con búsqueda y paginación |
| **Domain** | `Repositories/Write/AdminWriteRepositoryInterface.php` | Contrato de escritura: crear pivote, actualizar datos, eliminar cascada |
| **Domain** | `Validators/AdminValidatorInterface.php` | Contrato de validación: empresa existe, email único, mínimo 1 admin |
| **Application** | `UseCases/ListAdminsUseCase.php` | `final class`, método `execute(ListAdminsRequestDto): PaginatedAdminResponseDto` |
| **Application** | `UseCases/StoreAdminUseCase.php` | `final class`, orquesta creación de user + employee + rol + pivote |
| **Application** | `UseCases/UpdateAdminUseCase.php` | `final class`, actualiza datos del empleado subyacente (bloquea email) |
| **Application** | `UseCases/DeleteAdminUseCase.php` | `final class`, elimina cascada validando que no sea el último admin |
| **Application** | `Dtos/Requests/ListAdminsRequestDto.php` | `companyId`, `search`, `page`, `perPage` |
| **Application** | `Dtos/Requests/StoreAdminRequestDto.php` | `companyId`, `names`, `firstSurname`, `secondSurname`, `email`, `document`, `typeDocumentId`, `phone`, `password`, `createdBy` |
| **Application** | `Dtos/Requests/UpdateAdminRequestDto.php` | `names`, `firstSurname`, `secondSurname`, `document`, `typeDocumentId`, `phone`, `updatedBy` |
| **Application** | `Dtos/Responses/AdminResponseDto.php` | `id`, `names`, `firstSurname`, `secondSurname`, `email`, `document`, `phone` |
| **Application** | `Dtos/Responses/PaginatedAdminResponseDto.php` | `data: AdminResponseDto[]`, `total`, `page`, `perPage` |
| **Infrastructure** | `Http/Controllers/AdminController.php` | `index`, `store`, `update`, `destroy` — extiende `Src\Http\Controller` |
| **Infrastructure** | `Http/Mappers/AdminMapper.php` | Convierte Request de Laravel → RequestDto |
| **Infrastructure** | `Http/Validators/StoreAdminRequestValidator.php` | Reglas: `names`, `first_surname`, `second_surname`, `email`, `document`, `type_document_id`, `phone`, `password` |
| **Infrastructure** | `Http/Validators/UpdateAdminRequestValidator.php` | Reglas: `names`, `first_surname`, `second_surname`, `document`, `type_document_id`, `phone` (sin email ni password) |
| **Infrastructure** | `Http/Responses/AdminResponse.php` | Formatea `AdminResponseDto` → JSON |
| **Infrastructure** | `Http/Routes/RoutesAdmin.php` | Registro de rutas con middleware `auth:sanctum` |
| **Infrastructure** | `Persistences/QueryBuilder/Read/AdminReadQueryBuilder.php` | Query sobre `company_user_admin` JOIN `employees` JOIN `users` con paginación y búsqueda |
| **Infrastructure** | `Persistences/QueryBuilder/Write/AdminWriteQueryBuilder.php` | Inserciones/actualizaciones/eliminaciones en `company_user_admin`, `user_roles`, `employees`, `users` |

### Backend — Archivos existentes modificados

| Archivo | Cambio |
|---------|--------|
| `routes/api.php` o `RouteServiceProvider` | Registrar `RoutesAdmin.php` bajo prefijo `/v2/client` |

### Frontend — Nuevos archivos

| Archivo | Propósito |
|---------|-----------|
| `src/modules/company/services/admin.service.ts` | Singleton con métodos `list(companyId, params)`, `store(companyId, data)`, `update(companyId, id, data)`, `delete(companyId, id)` |
| `src/modules/company/components/AdminManagementTable.vue` | Tabla paginada con columna search, botones editar/eliminar |
| `src/modules/company/dialogs/AdminFormDialog.vue` | Diálogo de creación/edición con campos del formulario |
| `src/modules/company/models/Admin.ts` | Interfaz TypeScript `Admin` y `AdminFormData` |

### Frontend — Archivos existentes modificados

| Archivo | Cambio |
|---------|--------|
| `src/modules/company/pages/company.page.vue` | Agregar botón/sección "Administradores" que abre el sub-módulo |
| `src/modules/company/routes.ts` | Sin cambios (el sub-módulo se accede dentro de la página de empresa, no como ruta independiente) |

---

## 3. Decisiones de arquitectura (mini-ADR)

### DECISIÓN 1: Sub-módulo independiente `Client/Admin/`

**POR QUÉ**: La gestión de administradores es una responsabilidad distinta a la creación de empresa. Separarla en su propio módulo hexagonal evita inflar el `ClientController` y los repositorios existentes. Sigue el mismo patrón que `Client/Headquarters/`, que ya es un sub-módulo independiente.

**ALTERNATIVA DESCARTADA**: Agregar endpoints al `ClientController` existente y métodos al `ClientWriteRepository`. Se descartó porque el módulo `Client/Client/` ya gestiona empresa, representantes legales, sedes y universidades; añadir administradores lo convertiría en un "god module".

### DECISIÓN 2: Reutilizar `StoreUserContract` del módulo `User`

**POR QUÉ**: El `CreateClientUseCase` ya inyecta y usa `StoreUserContract` para crear el primer administrador. Reutilizar este contrato evita duplicar la lógica de creación de usuario + empleado y mantiene la coherencia con el flujo existente. El `StoreAdminUseCase` orquesta: valida → crea usuario/empleado vía contrato → asigna rol → inserta pivote.

**ALTERNATIVA DESCARTADA**: Implementar la creación de usuario y empleado directamente en el repositorio `AdminWriteQueryBuilder`. Se descartó porque duplicaría lógica ya probada del módulo `User`, violaría el principio de comunicación entre módulos (Art. IV 4.6 de la constitución), y generaría deuda de mantenimiento.

### DECISIÓN 3: Eliminación en cascada dentro de transacción atómica

**POR QUÉ**: Al eliminar un administrador se deben remover 4 registros relacionados: `company_user_admin`, `user_roles`, `employees`, `users`. Todos deben eliminarse o ninguno, para evitar datos huérfanos. Se usa `TransactionalUseCase` como wrapper (Art. IV 4.7).

**ALTERNATIVA DESCARTADA**: Soft-delete solo en `company_user_admin` preservando el usuario/empleado. Se descartó por decisión del PO: el usuario administrador se elimina completamente del sistema. Si en el futuro se requiere soft-delete, se puede agregar sin romper el contrato actual.

### DECISIÓN 4: Pivote `company_user_admin` como fuente de verdad para listado

**POR QUÉ**: Se consulta `company_user_admin` con JOIN a `employees` y `users` para obtener los datos completos. El `employee_id` en el pivote es la llave que vincula todo. La búsqueda por nombre/email se aplica sobre las columnas de `employees` y `users`.

**ALTERNATIVA DESCARTADA**: Usar la tabla `user_roles` filtrando por `role_id` del rol "Super Administrador". Se descartó porque un mismo rol podría (en el futuro) tener permisos distintos por empresa, y el pivote `company_user_admin` es el contrato explícito de "este empleado es admin de esta empresa".

---

## 4. Riesgos y dependencias

### Riesgos

| Riesgo | Mitigación |
|--------|-----------|
| **Datos huérfanos en eliminación**: si el `DELETE` falla a mitad de la cascada, quedan registros sueltos. | Envolver en `TransactionalUseCase` con rollback automático. |
| **Condición de carrera**: dos super admins base crean simultáneamente un admin con el mismo email. | Validación de unicidad de email a nivel de aplicación (validator) + constraint único en DB. |
| **Inconsistencia con CreateClientUseCase**: el flujo legacy crea el primer admin; el nuevo módulo gestiona los siguientes. Ambos deben coexistir. | El `CreateClientUseCase` no se modifica. El `AdminWriteQueryBuilder` usa las mismas tablas y contratos, garantizando compatibilidad. |
| **Rendimiento del listado**: JOIN de 3 tablas (`company_user_admin` + `employees` + `users`) con búsqueda LIKE. | Índices existentes en FK (`company_id`, `employee_id`). Agregar índice en `users.email` y `employees.first_name` si no existen. NFR-1 acota a < 200 ms. |

### Dependencias

| Dependencia | Tipo | Estado |
|-------------|------|--------|
| `StoreUserContract` (`User` module) | Contrato de creación de usuarios | Existente y probado |
| `UserWriteRepositoryInterface` | Implementación concreta del contrato | Existente |
| `TransactionalUseCase` (`Shared`) | Wrapper de transacciones | Existente |
| Tabla `company_user_admin` | Migración de base de datos | Existente |
| Tabla `roles` (rol "Super Administrador") | Creado por `CreateClientUseCase` | Existente |
| `odiseoApi` (Axios) | Cliente HTTP frontend | Existente |
| `useTableData` (composable) | Paginación unificada en frontend | Existente |

---

## 5. Trazabilidad: US → implementación

| Requisito | Componente(s) |
|-----------|---------------|
| **US-1 / AC-1.1** (listar con datos) | `ListAdminsUseCase` → `AdminReadQueryBuilder::listByCompany()` → JOIN `company_user_admin` + `employees` + `users` |
| **US-1 / AC-1.2** (lista vacía) | Mismo Use Case, retorna `data: []` cuando no hay registros |
| **US-1 / AC-1.3** (búsqueda) | `ListAdminsRequestDto.search` → `AdminReadQueryBuilder` aplica `WHERE LOWER(employees.first_name) LIKE` y `WHERE LOWER(users.email) LIKE` |
| **US-1 / AC-1.4** (403 forbidden) | Middleware en `RoutesAdmin.php` que verifica rol de super admin base |
| **US-2 / AC-2.1** (crear admin) | `StoreAdminUseCase` → `StoreUserContract::storeUser()` → `AdminWriteQueryBuilder::createCompanyUserAdmin()` |
| **US-2 / AC-2.2** (email duplicado) | `AdminValidatorInterface::validateUniqueEmail()` — lanza `DomainException` 409 |
| **US-2 / AC-2.3** (actualizar) | `UpdateAdminUseCase` → `AdminWriteQueryBuilder::updateAdmin()` — actualiza `employees` + `users` |
| **US-2 / AC-2.4** (bloquear email en PUT) | `UpdateAdminRequestValidator` no incluye `email` en reglas; `AdminMapper` no mapea email en PUT |
| **US-2 / AC-2.5** (eliminar) | `DeleteAdminUseCase` → `AdminWriteQueryBuilder::deleteCascade()` — elimina `company_user_admin` + `user_roles` + `employees` + `users` |
| **US-2 / AC-2.6** (último admin) | `AdminValidatorInterface::validateNotLastAdmin()` — cuenta registros activos en `company_user_admin` |
| **US-2 / AC-2.7** (empresa inexistente) | `AdminValidatorInterface::validateCompanyExists()` — lanza `NotFoundRecordException` 404 |
| **US-2 / AC-2.8** (403 forbidden escritura) | Mismo middleware que US-1 |

---

## 6. Notas adicionales

- **Convenciones**: todas las clases `final readonly`, DTOs con sufijos `RequestDto`/`ResponseDto`, Use Cases con único método `execute()`, validadores en `Domain/Validators/` con implementación en `Infrastructure`.
- **Paginación**: misma estructura que el módulo `Client`: `page`, `perPage` (default 10), respuesta con `data`, `total`, `current_page`, `last_page`.
- **Frontend — Vuetify**: tabla con `v-data-table`, diálogo con `v-dialog` + `v-form`, alerts con SweetAlert singleton.
- **Tests**: se detallan en `test-cases.md`. La estrategia sigue las 4 fases por módulo: Smoke → CRUD → Negativos → E2E (Art. VII 7.1).
