# Spec · Gestión de Usuarios Administradores de Empresa

## Resumen ejecutivo

Actualmente, la creación del primer usuario administrador está acoplada al flujo de
creación y edición de empresa en `CreateClientUseCase` y `UpdateClientUseCase`, y solo
se soporta un administrador por empresa. Esta feature separa la gestión de usuarios
administradores en un módulo independiente dentro de la arquitectura V2, permitiendo
múltiples administradores por empresa mediante un CRUD completo. Solo usuarios con rol
de super administrador de la empresa base pueden operar este módulo.

---

## 1. Contexto de negocio

- **Problema que resuelve**: la gestión de administradores está acoplada al flujo
  principal de empresa, lo que incrementa la complejidad del formulario, impide tener
  múltiples administradores por institución y dificulta la administración de accesos.
- **Por qué ahora / a quién impacta**: impacta directamente a los super administradores
  de la empresa base, que necesitan gestionar accesos administrativos en las empresas
  cliente de forma ágil, escalable y desacoplada del alta/edición de la empresa.

---

## 2. User stories y criterios de aceptación

### US-1 (P1): Listar administradores de una empresa

> Como **super administrador de la empresa base**, quiero **ver la lista de usuarios
> administradores de una empresa cliente** para conocer quiénes tienen acceso
> administrativo en esa institución.

| ID | Criterio de aceptación |
|----|------------------------|
| **AC-1.1** | **Dado** que existe una empresa cliente con al menos un administrador asignado, **cuando** el super admin base consulta el endpoint `GET /v2/client/{companyId}/admins`, **entonces** recibe una lista paginada con los administradores de esa empresa, incluyendo `id`, `nombres`, `apellidos`, `email`, `documento` y `teléfono`. |
| **AC-1.2** | **Dado** que existe una empresa cliente sin administradores asignados, **cuando** el super admin base consulta el listado, **entonces** recibe una lista vacía con `data: []`. |
| **AC-1.3** | **Dado** que se envía el query param `search` con un término de búsqueda, **cuando** el super admin base consulta el listado, **entonces** recibe solo los administradores cuyo `nombre` o `email` contengan el término (búsqueda parcial, case-insensitive). |
| **AC-1.4** | **Dado** que un usuario sin rol de super administrador de la empresa base intenta consultar el listado, **cuando** hace la petición, **entonces** recibe `403 Forbidden`. |

### US-2 (P1): Gestionar administradores de una empresa (CRUD)

> Como **super administrador de la empresa base**, quiero **agregar, actualizar y
> remover administradores de una empresa cliente** para gestionar sus accesos de
> forma independiente al flujo de creación de empresa.

| ID | Criterio de aceptación |
|----|------------------------|
| **AC-2.1** (Crear nuevo admin) | **Dado** que existe una empresa cliente, **cuando** el super admin base envía `POST /v2/client/{companyId}/admins` con los datos de una persona que no existe en el sistema (`nombres`, `apellidos`, `email`, `documento`, `teléfono`, `tipo_documento_id`, `password`), **entonces** el sistema crea un nuevo usuario, un nuevo empleado asociado a la empresa, le asigna el rol "Super Administrador" de esa empresa, lo registra en `company_user_admin`, y retorna `201` con los datos del administrador creado. |
| **AC-2.2** (Promocionar empleado existente) | **Dado** que existe un empleado activo en la empresa que no es administrador de ninguna empresa, **cuando** el super admin base envía la misma petición con el `employee_id` del empleado existente, **entonces** el sistema le asigna el rol "Super Administrador" (si no lo tiene), lo registra en `company_user_admin`, y retorna `201`. |
| **AC-2.3** (Email duplicado) | **Dado** que el `email` enviado ya pertenece a un usuario existente en el sistema, **cuando** se intenta crear un nuevo administrador (AC-2.1), **entonces** el sistema retorna `409 Conflict` con mensaje "El email ya está registrado en el sistema". |
| **AC-2.4** (Admin duplicado en misma empresa) | **Dado** que el empleado a promocionar ya es administrador de esta empresa, **cuando** se envía la petición, **entonces** el sistema retorna `409 Conflict` con mensaje "El empleado ya es administrador de esta empresa". |
| **AC-2.5** (Admin no elegible) | **Dado** que el empleado a promocionar no cumple las condiciones para ser administrador, **cuando** se envía la petición, **entonces** el sistema retorna `409 Conflict` con un mensaje genérico que no revela información sobre otras empresas. |
| **AC-2.6** (Actualizar admin) | **Dado** que existe un administrador en una empresa, **cuando** el super admin base envía `PUT /v2/client/{companyId}/admins/{id}` con nuevos datos (nombres, apellidos, teléfono, documento, tipo_documento_id), **entonces** el sistema actualiza los datos del usuario/empleado subyacente y retorna `200` con los datos actualizados. |
| **AC-2.7** (Bloquear edición de email) | **Dado** que existe un administrador, **cuando** se envía `PUT` incluyendo el campo `email`, **entonces** el sistema ignora o rechaza ese campo, sin modificar el email existente. |
| **AC-2.8** (Eliminar admin — éxito) | **Dado** que una empresa tiene 2 o más administradores, **cuando** el super admin base envía `DELETE /v2/client/{companyId}/admins/{id}`, **entonces** el sistema elimina el registro en `company_user_admin`, el registro en `user_roles`, el empleado y el usuario asociado, y retorna `200` con mensaje de confirmación. |
| **AC-2.9** (Eliminar último admin — rechazo) | **Dado** que una empresa tiene exactamente 1 administrador, **cuando** el super admin base intenta eliminarlo, **entonces** el sistema retorna `409 Conflict` con mensaje "No se puede eliminar el único administrador de la empresa". |
| **AC-2.10** (Empresa inexistente) | **Dado** que el `companyId` no corresponde a una empresa activa, **cuando** se realiza cualquier operación, **entonces** el sistema retorna `404 Not Found`. |
| **AC-2.11** (Permiso denegado en escritura) | **Dado** que un usuario sin rol de super administrador de la empresa base intenta crear, actualizar o eliminar un administrador, **cuando** hace la petición, **entonces** recibe `403 Forbidden`. |

---

## 3. Requisitos no funcionales (NFR)

| ID | Requisito |
|----|-----------|
| **NFR-1** | `GET /v2/client/{companyId}/admins` debe responder en < 200 ms (p95) para empresas con hasta 50 administradores. |
| **NFR-2** | `POST` y `PUT` deben ser atómicos en caso de crear usuario + empleado + asignar rol + pivote; si alguna operación falla, se revierte toda la transacción. |
| **NFR-3** | `DELETE` debe ser idempotente: si los registros ya fueron eliminados, retornar `200` (no `404`). |
| **NFR-4** | Cobertura de tests >= 70% para el nuevo módulo (Domain >= 80%, Application >= 70%, HTTP Feature >= 60%). |
| **NFR-5** | Toda operación de escritura debe registrar `created_by`, `updated_by`, `deleted_by` según corresponda. |

---

## 4. Casos borde

- Crear admin sin enviar `password` ni `employee_id` -> error de validación `422`.
- Enviar `employee_id` de un empleado que pertenece a otra empresa -> `409` genérico (sin revelar información).
- Enviar `employee_id` de un empleado ya eliminado (soft-delete) -> `404`.
- Eliminar un admin que ya fue eliminado (operación repetida) -> `200` (idempotente, NFR-3).
- Intentar promocionar a un empleado que ya es admin de la misma empresa (race condition) -> `409`.
- `companyId` no numérico o negativo -> `422`.
- Campo `email` con formato inválido -> `422`.
- Campo `documento` excede longitud máxima -> `422`.

---

## 5. Assumptions

| # | Assumption | Si es falso |
|---|-----------|-------------|
| **A1** | La tabla `roles` y el rol "Super Administrador" (creado en `CreateClientUseCase`) se mantienen sin cambios. La deuda técnica sobre `fl_administrator` / `fl_admin` se aborda en otra HU. | Se requeriría rediseñar el modelo de roles como parte de esta feature. |
| **A2** | La tabla `company_user_admin` soporta N registros por empresa (la restricción actual en código de usar `->first()` es una limitación de implementación, no de esquema). | Habría que modificar la migración para agregar constraints. |
| **A3** | El `StoreUserContract` (contrato de creación de usuarios desde el módulo User) es reutilizable para crear nuevos administradores. | Habría que implementar lógica de creación de usuario duplicada en el módulo Admin. |
| **A4** | El frontend mantiene el campo de primer administrador en el diálogo de creación de empresa, y agrega un sub-módulo independiente para la gestión completa post-creación. | El diálogo de creación de empresa requeriría cambios adicionales de alcance. |

---

## 6. Scope

**DENTRO:**
- CRUD completo de administradores por empresa: listar (con búsqueda por nombre/email), crear (nuevo o promocionar empleado existente), actualizar (sin email), eliminar (cascada: pivote + user_roles + empleado + usuario).
- Validaciones de negocio: mínimo 1 admin, no duplicados, no admin multi-empresa, email único global.
- Endpoints REST bajo `/v2/client/{companyId}/admins`.
- Sub-módulo frontend en pantalla de empresa con tabla y formularios.
- Middleware de autorización (solo super admin de empresa base).

**FUERA (explícito):**
- Rediseño de la tabla `roles` o cambios en los flags `fl_administrator` / `fl_admin` (deuda técnica).
- Modificación del flujo de creación de empresa (`CreateClientUseCase`) — se mantiene intacto.
- Migración o sincronización con la tabla legacy `clientes_usuarios_administradores` (V1).
- Gestión de permisos granulares por administrador (todos tienen el mismo rol "Super Administrador").
- Endpoint para cambio de contraseña del administrador (se usan los endpoints existentes de User).
- Notificaciones por email al crear/eliminar administradores.
- Endpoint de detalle individual `GET .../admins/{id}`.
- Edición del `email` del administrador (bloqueado).
