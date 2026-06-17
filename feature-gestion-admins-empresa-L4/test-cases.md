# Test Cases · Gestión de Usuarios Administradores de Empresa

## Resumen ejecutivo

Se diseñan 41 casos de prueba en dos secciones. La **Sección A (Unit Tests)** cubre backend
(Pest/PHPUnit) y frontend (Vitest) siguiendo la estrategia de 4 fases: Smoke → CRUD → Negativos.
La **Sección B (BDD Scenarios)** provee escenarios Gherkin Given/When/Then para QA manual y
automatización Playwright E2E en el repositorio `playqa`. Todos los casos son trazables a los
12 criterios de aceptación del spec, más casos borde y requisitos no funcionales. Se incluyen
17 casos backend, 12 frontend y 12 escenarios BDD. Total: 41.

---

## Sección A — Unit Tests

### A.1 Backend (Pest / PHPUnit)

#### A.1.1 Smoke tests — Verificación de estructura

**BTC-1 (Smoke) — Módulo Admin responde sin errores**

**Datos:**
- `companyId`: `5`

**Pasos:**
1. Autenticarse como super admin base (token JWT válido)
2. Enviar `GET /v2/client/5/admins`

**Esperado:**
- Status `200`
- Response JSON con estructura `{ success: true, type: "success", data: [...], total: number }`

---

#### A.1.2 CRUD tests — Domain

**BTC-2 (Domain / AC-1.1) — AdminEntity se construye con datos válidos**

**Datos:**
- `id: 12`, `names: "Carlos"`, `firstSurname: "Ruiz"`, `secondSurname: "Torres"`, `email: "cruiz@instituto.pe"`, `document: "87654321"`, `phone: "999888777"`

**Pasos:**
1. Instanciar `AdminEntity::fromArray()` con los datos

**Esperado:**
- La entidad se construye sin lanzar excepción
- `$entity->email()` retorna `"cruiz@instituto.pe"`

---

**BTC-3 (Domain / AC-2.1) — AdminEntity lanza DomainException con email vacío**

**Datos:**
- Mismos datos de BTC-2 pero `email: ""`

**Pasos:**
1. Instanciar `AdminEntity::fromArray()` con email vacío

**Esperado:**
- Lanza `DomainException`

---

**BTC-4 (Domain / AC-2.7) — Validator lanza NotFoundRecordException para empresa inexistente**

**Datos:**
- `companyId`: `999` (no existe en `companies`)

**Pasos:**
1. Invocar `AdminValidatorInterface::validateCompanyExists(999)`

**Esperado:**
- Lanza `NotFoundRecordException`

---

**BTC-5 (Domain / AC-2.6) — Validator lanza DomainException al validar último admin**

**Datos:**
- `companyId`: `8`, `adminId`: `20` (único admin de la empresa 8)

**Pasos:**
1. Invocar `AdminValidatorInterface::validateNotLastAdmin(8, 20)`

**Esperado:**
- Lanza `DomainException` con mensaje `"No se puede eliminar el único administrador de la empresa"`

---

**BTC-6 (Domain / AC-2.2) — Validator lanza DomainException para email duplicado**

**Datos:**
- `email`: `"mgarcia@instituto.pe"` (ya existe en el sistema)

**Pasos:**
1. Invocar `AdminValidatorInterface::validateUniqueEmail("mgarcia@instituto.pe")`

**Esperado:**
- Lanza `DomainException` con mensaje `"El email ya está registrado en el sistema"`

---

#### A.1.3 CRUD tests — Application (Use Cases)

**BTC-7 (Application / AC-1.1) — ListAdminsUseCase retorna lista paginada**

**Datos:**
- `companyId`: `5`
- Mock de `AdminReadRepositoryInterface` retorna 2 admins

**Pasos:**
1. Construir `ListAdminsRequestDto` con `companyId: 5`
2. Ejecutar `ListAdminsUseCase::execute()`

**Esperado:**
- Retorna `PaginatedAdminResponseDto` con `data`: array de 2 `AdminResponseDto`
- `total`: `2`

---

**BTC-8 (Application / AC-2.1) — StoreAdminUseCase orquesta creación completa**

**Datos:**
- `StoreAdminRequestDto` con: `names: "Luis Alberto"`, `firstSurname: "Mendoza"`, `email: "lmendoza@academianova.pe"`, `password: "Temp2026!"`, `companyId: 8`

**Pasos:**
1. Mock validators: `validateCompanyExists` pasa, `validateUniqueEmail` pasa
2. Mock `StoreUserContract::storeUser()` retorna usuario creado con ID `25`
3. Mock `AdminWriteRepositoryInterface::createCompanyUserAdmin()` retorna pivote ID `30`
4. Ejecutar `StoreAdminUseCase::execute()`

**Esperado:**
- `StoreUserContract::storeUser()` es llamado exactamente 1 vez
- `AdminWriteRepositoryInterface::createCompanyUserAdmin()` es llamado con `companyId: 8`, `employeeId` del usuario creado
- Retorna `AdminResponseDto` con `email: "lmendoza@academianova.pe"`

---

**BTC-9 (Application / AC-2.3) — UpdateAdminUseCase actualiza sin tocar email**

**Datos:**
- `UpdateAdminRequestDto`: `names: "Carlos Eduardo"`, `phone: "999888777"` (sin campo `email`)

**Pasos:**
1. Mock reader retorna admin existente con `email: "cruiz@instituto.pe"`
2. Ejecutar `UpdateAdminUseCase::execute()`

**Esperado:**
- `AdminWriteRepositoryInterface::updateAdmin()` es llamado
- El DTO de salida conserva `email: "cruiz@instituto.pe"`
- `updatedBy` registrado correctamente

---

**BTC-10 (Application / AC-2.5) — DeleteAdminUseCase elimina en cascada**

**Datos:**
- `companyId`: `5`, `adminId`: `12` (no es el último admin)

**Pasos:**
1. Mock `validateNotLastAdmin` pasa (hay 2 admins)
2. Ejecutar `DeleteAdminUseCase::execute()`

**Esperado:**
- `AdminWriteRepositoryInterface::deleteCascade()` es llamado exactamente 1 vez
- Retorna `true`

---

#### A.1.4 CRUD tests — Feature (HTTP)

**BTC-11 (Feature / AC-1.1) — GET /v2/client/5/admins retorna 200 con datos**

**Datos:**
- `companyId`: `5`, admins existentes: 2

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/5/admins`

**Esperado:**
- Status `200`
- `data`: array con 2 elementos (María García López, Carlos Ruiz Torres)
- Cada elemento contiene: `id`, `names`, `first_surname`, `second_surname`, `email`, `document`, `phone`
- `total`: `2`

---

**BTC-12 (Feature / AC-1.2) — GET /v2/client/8/admins retorna lista vacía**

**Datos:**
- `companyId`: `8` (sin administradores)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/8/admins`

**Esperado:**
- Status `200`
- `data`: `[]`
- `total`: `0`

---

**BTC-13 (Feature / AC-1.3) — GET con search por nombre**

**Datos:**
- `companyId`: `5`, query: `?search=María`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/5/admins?search=María`

**Esperado:**
- Status `200`
- `data`: 1 elemento (solo María García López)
- `total`: `1`

---

**BTC-14 (Feature / AC-1.3) — GET con search por email**

**Datos:**
- `companyId`: `5`, query: `?search=cruiz`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/5/admins?search=cruiz`

**Esperado:**
- Status `200`
- `data`: 1 elemento (solo Carlos Ruiz Torres)
- `total`: `1`

---

**BTC-15 (Feature / AC-2.1) — POST /v2/client/8/admins crea admin exitosamente**

**Datos:**
- `companyId`: `8`
- Body:
```json
{
  "names": "Luis Alberto",
  "first_surname": "Mendoza",
  "second_surname": "Quispe",
  "email": "lmendoza@academianova.pe",
  "phone": "987654321",
  "type_document_id": 1,
  "document": "12345678",
  "password": "Temp2026!"
}
```

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/8/admins` con el body

**Esperado:**
- Status `200`
- `success`: `true`
- `data.names`: `"Luis Alberto"`, `data.email`: `"lmendoza@academianova.pe"`
- BD: registro en `users`, `employees`, `user_roles` (rol Super Administrador de empresa 8), `company_user_admin`

---

**BTC-16 (Feature / AC-2.2) — POST con email duplicado retorna 409**

**Datos:**
- `companyId`: `8`
- Body con `"email": "mgarcia@instituto.pe"` (ya existe en empresa 5)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/8/admins` con email duplicado

**Esperado:**
- Status `409`
- `message`: `"El email ya está registrado en el sistema"`
- BD: sin cambios en `users`, `employees`, `user_roles`, `company_user_admin`

---

**BTC-17 (Feature / AC-2.3) — PUT /v2/client/5/admins/12 actualiza datos**

**Datos:**
- `companyId`: `5`, admin ID: `12` (Carlos Ruiz Torres)
- Body:
```json
{
  "names": "Carlos Eduardo",
  "first_surname": "Ruiz",
  "second_surname": "Torres",
  "phone": "999888777",
  "type_document_id": 1,
  "document": "87654321"
}
```

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `PUT /v2/client/5/admins/12` con el body

**Esperado:**
- Status `200`
- `data.names`: `"Carlos Eduardo"`, `data.phone`: `"999888777"`
- `data.email`: `"cruiz@instituto.pe"` (sin cambios)
- `updated_by` registrado

---

**BTC-18 (Feature / AC-2.4) — PUT ignora campo email**

**Datos:**
- `companyId`: `5`, admin ID: `12`
- Body incluye `"email": "nuevoemail@instituto.pe"`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `PUT /v2/client/5/admins/12` con body que incluye `email`

**Esperado:**
- Status `200` (resto de campos se actualizan)
- `data.email` conserva `"cruiz@instituto.pe"` (sin cambios)
- O alternativamente: Status `422` si el validador rechaza explícitamente `email`

---

**BTC-19 (Feature / AC-2.5) — DELETE /v2/client/5/admins/12 elimina cascada**

**Datos:**
- `companyId`: `5` (2 administradores: ID 12 Carlos, ID 15 María)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/5/admins/12`

**Esperado:**
- Status `200`
- `message`: `"Registro eliminado correctamente."`
- BD: registros eliminados en `company_user_admin`, `user_roles`, `employees`, `users` para ID 12
- María García (ID 15) sigue existiendo

---

**BTC-20 (Feature / AC-2.6) — DELETE del último admin retorna 409**

**Datos:**
- `companyId`: `8` (1 solo admin), admin ID: `20`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/8/admins/20`

**Esperado:**
- Status `409`
- `message`: `"No se puede eliminar el único administrador de la empresa"`
- BD: sin cambios

---

**BTC-21 (Feature / AC-2.7) — Empresa inexistente retorna 404**

**Datos:**
- `companyId`: `999`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/999/admins`

**Esperado:**
- Status `404`
- `message` indicando empresa no encontrada

---

#### A.1.5 Negativos — Feature (HTTP)

**BTC-22 (Feature / AC-1.4) — GET con rol docente retorna 403**

**Datos:**
- Token de usuario con rol `docente`

**Pasos:**
1. Autenticarse como docente
2. Enviar `GET /v2/client/5/admins`

**Esperado:**
- Status `403`
- `success`: `false`

---

**BTC-23 (Feature / AC-2.8) — POST con rol docente retorna 403**

**Datos:**
- Token de usuario con rol `docente`

**Pasos:**
1. Autenticarse como docente
2. Enviar `POST /v2/client/5/admins` con datos válidos

**Esperado:**
- Status `403`

---

**BTC-24 (Negativo / Borde) — POST sin password retorna 422**

**Datos:**
- Body sin campo `password`:
```json
{
  "names": "Ana",
  "first_surname": "Vega",
  "second_surname": "Rios",
  "email": "avega@test.pe",
  "phone": "987111222",
  "type_document_id": 1,
  "document": "11223344"
}
```

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/8/admins` sin `password`

**Esperado:**
- Status `422`
- `messageList` contiene error de validación en campo `password`

---

**BTC-25 (Negativo / Borde) — POST con email inválido retorna 422**

**Datos:**
- Body con `"email": "esto-no-es-email"`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/5/admins` con email inválido

**Esperado:**
- Status `422`
- Error de validación en campo `email`

---

**BTC-26 (Negativo / Borde) — companyId no numérico**

**Datos:**
- URL: `GET /v2/client/abc/admins`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/abc/admins`

**Esperado:**
- Status `422` o `404` (según enrutamiento de Laravel)

---

**BTC-27 (NFR-3 / Borde) — DELETE idempotente sobre admin ya eliminado**

**Datos:**
- `companyId`: `5`, admin ID: `12` (ya eliminado)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/5/admins/12` por segunda vez

**Esperado:**
- Status `200`
- `success`: `true`
- No lanza error ni `404`

---

### A.2 Frontend (Vitest)

#### A.2.1 Service layer — `admin.service.ts`

**FTC-1 (Service / AC-1.1) — `list()` llama al endpoint correcto**

**Datos:**
- `companyId`: `5`, params: `{ search: "María", page: 1, perPage: 10 }`

**Pasos:**
1. Mock `odiseoApi.get` con `mockResolvedValue({ data: { data: [...], total: 2 } })`
2. Invocar `adminService.list(5, { search: "María", page: 1, perPage: 10 })`

**Esperado:**
- `odiseoApi.get` es llamado con `"/v2/client/5/admins"`
- Parámetros de query: `{ search: "María", page: 1, per_page: 10 }`

---

**FTC-2 (Service / AC-2.1) — `store()` envía POST con body correcto**

**Datos:**
- `companyId`: `8`, formData con todos los campos

**Pasos:**
1. Mock `odiseoApi.post` con `mockResolvedValue({ data: { data: { id: 30, ... } } })`
2. Invocar `adminService.store(8, { names: "Luis", email: "lmendoza@academianova.pe", password: "Temp2026!", ... })`

**Esperado:**
- `odiseoApi.post` es llamado con `"/v2/client/8/admins"` y el body completo
- El body incluye `password`

---

**FTC-3 (Service / AC-2.3) — `update()` envía PUT sin campo email**

**Datos:**
- `companyId`: `5`, `adminId`: `12`, formData con `names: "Carlos Eduardo"`, sin `email`

**Pasos:**
1. Mock `odiseoApi.put` con `mockResolvedValue({ data: { data: { ... } } })`
2. Invocar `adminService.update(5, 12, { names: "Carlos Eduardo", phone: "999888777" })`

**Esperado:**
- `odiseoApi.put` es llamado con `"/v2/client/5/admins/12"`
- El body NO incluye campo `email`
- El body incluye `names` y `phone`

---

**FTC-4 (Service / AC-2.5) — `delete()` envía DELETE al endpoint correcto**

**Datos:**
- `companyId`: `5`, `adminId`: `12`

**Pasos:**
1. Mock `odiseoApi.delete` con `mockResolvedValue({ data: { success: true } })`
2. Invocar `adminService.delete(5, 12)`

**Esperado:**
- `odiseoApi.delete` es llamado con `"/v2/client/5/admins/12"`

---

**FTC-5 (Service / AC-1.4) — `list()` maneja error 403**

**Datos:**
- `companyId`: `5`

**Pasos:**
1. Mock `odiseoApi.get` con `mockRejectedValue({ response: { status: 403 } })`
2. Invocar `adminService.list(5)` con try/catch

**Esperado:**
- El error es capturado y propagado con status `403`
- No se retorna datos

---

**FTC-6 (Service / AC-2.2) — `store()` maneja error 409 por email duplicado**

**Datos:**
- `companyId`: `8`, body con email ya existente

**Pasos:**
1. Mock `odiseoApi.post` con `mockRejectedValue({ response: { status: 409, data: { message: "El email ya está registrado en el sistema" } } })`
2. Invocar `adminService.store(8, { email: "mgarcia@instituto.pe", ... })` con try/catch

**Esperado:**
- El error se propaga con `status: 409` y mensaje del backend
- `odiseoApi.post` fue llamado exactamente 1 vez

---

#### A.2.2 Componente tabla — `AdminManagementTable.vue`

**FTC-7 (Componente / AC-1.1) — Renderiza filas con datos de administradores**

**Datos:**
- `props.items`: array con 2 `Admin` (María García, Carlos Ruiz)
- `props.total`: `2`
- `props.loading`: `false`

**Pasos:**
1. Montar componente con los props dados
2. Buscar filas en la tabla renderizada

**Esperado:**
- La tabla muestra 2 filas
- Cada fila contiene: `names`, `firstSurname`, `secondSurname`, `email`, `document`, `phone`
- El texto `"Total: 2"` o equivalente es visible

---

**FTC-8 (Componente / AC-1.2) — Muestra estado vacío sin administradores**

**Datos:**
- `props.items`: `[]`
- `props.total`: `0`
- `props.loading`: `false`

**Pasos:**
1. Montar componente con props de lista vacía

**Esperado:**
- La tabla no muestra filas de datos
- Se muestra un mensaje de estado vacío (ej. "No se encontraron administradores")

---

**FTC-9 (Componente / AC-1.3) — Emite evento search al escribir en el buscador**

**Datos:**
- Componente montado con datos

**Pasos:**
1. Escribir `"María"` en el campo de búsqueda
2. Disparar evento `input` o equivalente

**Esperado:**
- El componente emite evento `search` con valor `"María"`
- O se actualiza el store/composable de búsqueda con `"María"`

---

**FTC-10 (Componente / AC-2.1) — Emite evento create al hacer clic en botón "Nuevo"**

**Datos:**
- Componente montado

**Pasos:**
1. Hacer clic en botón "Agregar administrador" o "+"

**Esperado:**
- El componente emite evento `create` o abre el diálogo de formulario

---

**FTC-11 (Componente / AC-2.5) — Emite evento delete con confirmación**

**Datos:**
- Componente montado con 2 administradores (ID 12 y 15)

**Pasos:**
1. Hacer clic en el botón de eliminar del admin ID 12
2. Confirmar en el diálogo de SweetAlert

**Esperado:**
- Se muestra diálogo de confirmación
- Al confirmar, el componente emite evento `delete` con `adminId: 12`

---

#### A.2.3 Diálogo de formulario — `AdminFormDialog.vue`

**FTC-12 (Diálogo / AC-2.1) — Valida campos requeridos en creación**

**Datos:**
- Modo creación (`isEditing: false`), formulario vacío

**Pasos:**
1. Abrir diálogo en modo creación
2. Hacer clic en "Guardar" sin llenar campos

**Esperado:**
- Aparecen mensajes de validación en campos requeridos: `names`, `firstSurname`, `email`, `password`
- No se emite evento `save`

---

**FTC-13 (Diálogo / AC-2.1) — Valida formato de email**

**Datos:**
- Modo creación, campo email: `"esto-no-es-email"`

**Pasos:**
1. Llenar formulario con email inválido
2. Hacer clic en "Guardar"

**Esperado:**
- Aparece error de validación en campo `email` indicando formato inválido
- No se emite evento `save`

---

**FTC-14 (Diálogo / AC-2.3) — En modo edición no muestra ni requiere campo password**

**Datos:**
- Modo edición (`isEditing: true`), admin existente con datos previos

**Pasos:**
1. Abrir diálogo en modo edición con datos de Carlos Ruiz

**Esperado:**
- El campo `password` NO está visible en el formulario
- El campo `email` se muestra pero como solo lectura o deshabilitado
- Los campos `names`, `firstSurname`, `secondSurname`, `phone`, `document` muestran los datos actuales
- Se puede editar `names`, `phone`, etc. y emitir `save` sin requerir `password`

---

**FTC-15 (Diálogo / AC-2.4) — No incluye email en payload de actualización**

**Datos:**
- Modo edición, se modifica `names` a `"Carlos Eduardo"`

**Pasos:**
1. Abrir diálogo en modo edición
2. Cambiar `names` a `"Carlos Eduardo"`
3. Hacer clic en "Guardar"

**Esperado:**
- El evento `save` emite un payload SIN el campo `email`
- El payload incluye `names: "Carlos Eduardo"` y los demás campos editables

---

**FTC-16 (Diálogo / Borde) — Botón X de cerrar cierra sin emitir save**

**Datos:**
- Diálogo abierto en modo creación con campos llenos

**Pasos:**
1. Llenar formulario con datos válidos
2. Hacer clic en el botón X de cerrar

**Esperado:**
- El diálogo se cierra
- NO se emite evento `save`

---

**FTC-17 (Diálogo / Borde) — Botón "Cancelar" cierra sin emitir save**

**Datos:**
- Diálogo abierto con datos

**Pasos:**
1. Hacer clic en el botón "Cancelar"

**Esperado:**
- El diálogo se cierra
- NO se emite evento `save`

---

## Sección B — BDD Scenarios (Gherkin para QA manual y Playwright E2E)

### B.1 Happy path

**BDD-1 (AC-1.1) — Listar administradores con datos**

```gherkin
Feature: Listar administradores de una empresa

  Scenario: Ver la lista de administradores de una empresa con administradores asignados
    Given un super admin base autenticado en el sistema
    And la empresa "Instituto del Sur SAC" (ID 5) existe y tiene 2 administradores:
      | Nombres            | Apellidos        | Email                  |
      | María García       | López            | mgarcia@instituto.pe   |
      | Carlos Ruiz        | Torres           | cruiz@instituto.pe     |
    When navega a la pantalla de empresa 5 y abre la sección "Administradores"
    Then la tabla de administradores muestra 2 filas
    And cada fila contiene nombres, apellidos, email, documento y teléfono
    And el total de registros es "2"
```

---

**BDD-2 (AC-2.1) — Crear un nuevo administrador**

```gherkin
Feature: Gestionar administradores de una empresa

  Scenario: Crear un nuevo administrador para una empresa existente
    Given un super admin base autenticado
    And la empresa "Academia Nova EIRL" (ID 8) no tiene administradores
    When navega a la sección "Administradores" de la empresa 8
    And hace clic en "Agregar administrador"
    And llena el formulario con:
      | Campo            | Valor                     |
      | Nombres          | Luis Alberto              |
      | Primer apellido  | Mendoza                   |
      | Segundo apellido | Quispe                    |
      | Email            | lmendoza@academianova.pe  |
      | Teléfono         | 987654321                 |
      | Tipo documento   | DNI                       |
      | Documento        | 12345678                  |
      | Contraseña       | Temp2026!                 |
    And hace clic en "Guardar"
    Then aparece una notificación de éxito: "Administrador creado correctamente"
    And el nuevo administrador "Luis Alberto Mendoza Quispe" aparece en la tabla
    And la tabla muestra 1 administrador
```

---

**BDD-3 (AC-1.3) — Buscar administrador por nombre**

```gherkin
Feature: Buscar administradores

  Scenario: Filtrar administradores por nombre parcial
    Given un super admin base autenticado
    And la empresa 5 tiene los administradores María García y Carlos Ruiz
    When navega a la sección "Administradores" de la empresa 5
    And escribe "María" en el campo de búsqueda
    Then la tabla muestra 1 sola fila
    And la fila corresponde a "María García López"
    And el total de registros es "1"
```

---

**BDD-4 (AC-1.3) — Buscar administrador por email**

```gherkin
  Scenario: Filtrar administradores por email parcial
    Given un super admin base autenticado
    And la empresa 5 tiene los administradores María García y Carlos Ruiz
    When navega a la sección "Administradores" de la empresa 5
    And escribe "cruiz" en el campo de búsqueda
    Then la tabla muestra 1 sola fila
    And la fila corresponde a "Carlos Ruiz Torres"
    And el total de registros es "1"
```

---

**BDD-5 (AC-2.3) — Actualizar datos de un administrador**

```gherkin
Feature: Gestionar administradores de una empresa

  Scenario: Editar los datos de un administrador existente
    Given un super admin base autenticado
    And la empresa 5 tiene al administrador "Carlos Ruiz Torres"
    When navega a la sección "Administradores" de la empresa 5
    And hace clic en el botón de editar de "Carlos Ruiz Torres"
    And modifica "Nombres" a "Carlos Eduardo"
    And modifica "Teléfono" a "999888777"
    And hace clic en "Guardar"
    Then aparece una notificación de éxito
    And la tabla muestra el nombre actualizado: "Carlos Eduardo"
    And el email "cruiz@instituto.pe" NO cambió
```

---

**BDD-6 (AC-2.5) — Eliminar un administrador**

```gherkin
  Scenario: Eliminar un administrador cuando la empresa tiene más de uno
    Given un super admin base autenticado
    And la empresa 5 tiene 2 administradores: Carlos Ruiz (ID 12) y María García (ID 15)
    When navega a la sección "Administradores" de la empresa 5
    And hace clic en el botón de eliminar de "Carlos Ruiz Torres"
    And confirma la eliminación en el diálogo de confirmación
    Then aparece una notificación: "Registro eliminado correctamente."
    And la tabla muestra 1 solo administrador: "María García López"
    And Carlos Ruiz ya no aparece en la tabla
```

---

### B.2 Error scenarios

**BDD-7 (AC-2.2) — Email duplicado al crear**

```gherkin
Feature: Validaciones de negocio en gestión de administradores

  Scenario: Intentar crear un administrador con un email que ya existe en el sistema
    Given un super admin base autenticado
    And el email "mgarcia@instituto.pe" ya pertenece a un usuario en otra empresa
    When navega a la sección "Administradores" de la empresa 8
    And abre el formulario de nuevo administrador
    And llena el formulario con el email "mgarcia@instituto.pe"
    And hace clic en "Guardar"
    Then el sistema muestra un mensaje de error: "El email ya está registrado en el sistema"
    And el formulario NO se cierra
    And no se crea ningún registro nuevo en la tabla
```

---

**BDD-8 (AC-2.6) — Eliminar el único administrador**

```gherkin
  Scenario: Intentar eliminar el único administrador de una empresa
    Given un super admin base autenticado
    And la empresa 8 tiene exactamente 1 administrador
    When navega a la sección "Administradores" de la empresa 8
    And hace clic en el botón de eliminar del único administrador
    And confirma en el diálogo de confirmación
    Then el sistema muestra un mensaje: "No se puede eliminar el único administrador de la empresa"
    And el administrador sigue apareciendo en la tabla
```

---

**BDD-9 (AC-1.4 / AC-2.8) — Usuario sin permisos no accede al módulo**

```gherkin
Feature: Control de acceso al módulo de administradores

  Scenario: Un usuario docente no puede ver ni gestionar administradores
    Given un usuario con rol "docente" está autenticado
    When intenta acceder a la sección "Administradores" de cualquier empresa
    Then la sección no es visible en la interfaz
    And si intenta acceder directamente por URL recibe un error 403
```

---

**BDD-10 (AC-2.7) — Empresa inexistente**

```gherkin
Feature: Validaciones de negocio en gestión de administradores

  Scenario: Intentar acceder a administradores de una empresa que no existe
    Given un super admin base autenticado
    When intenta navegar a la sección "Administradores" de la empresa 999
    Then el sistema muestra un mensaje de error indicando que la empresa no fue encontrada
    And no se muestra ninguna tabla de administradores
```

---

**BDD-11 (Borde) — Validación de formulario: email con formato inválido**

```gherkin
Feature: Validaciones de formulario de administrador

  Scenario: El formulario rechaza un email con formato inválido
    Given un super admin base autenticado
    When abre el formulario de nuevo administrador en la empresa 5
    And escribe "esto-no-es-email" en el campo Email
    And hace clic en "Guardar"
    Then aparece un mensaje de error debajo del campo Email indicando formato inválido
    And el formulario NO se envía
```

---

### B.3 Edge case scenarios

**BDD-12 (AC-1.2) — Lista vacía de administradores**

```gherkin
Feature: Listar administradores de una empresa

  Scenario: Ver lista vacía cuando la empresa no tiene administradores
    Given un super admin base autenticado
    And la empresa "Academia Nova EIRL" (ID 8) existe pero no tiene administradores asignados
    When navega a la sección "Administradores" de la empresa 8
    Then se muestra un mensaje de estado vacío: "No se encontraron administradores"
    And la tabla no muestra filas
    And el total de registros es "0"
```

---

**BDD-13 (AC-2.4) — El campo email no se puede editar**

```gherkin
Feature: Gestionar administradores de una empresa

  Scenario: El formulario de edición muestra el email como solo lectura
    Given un super admin base autenticado
    And la empresa 5 tiene al administrador "Carlos Ruiz Torres" con email "cruiz@instituto.pe"
    When abre el formulario de edición del administrador "Carlos Ruiz Torres"
    Then el campo Email muestra "cruiz@instituto.pe" pero está deshabilitado
    And el usuario no puede modificar el valor del email
```

---

**BDD-14 (NFR-3 / Borde) — Eliminar dos veces el mismo administrador**

```gherkin
Feature: Idempotencia en eliminación de administradores

  Scenario: Intentar eliminar un administrador que ya fue eliminado previamente
    Given un super admin base autenticado
    And el administrador Carlos Ruiz (ID 12) de la empresa 5 ya fue eliminado
    When se envía una segunda solicitud de eliminación para el ID 12
    Then el sistema retorna éxito sin lanzar error
    And no se muestra mensaje de "no encontrado"
```

---

## Resumen de cobertura

### Sección A — Unit Tests

| Tipo | Backend (BTC) | Frontend (FTC) |
|------|:------------:|:-------------:|
| Smoke | 1 | — |
| CRUD (Domain) | 5 | — |
| CRUD (Application) | 4 | — |
| CRUD (Feature HTTP) | 11 | — |
| Service | — | 6 |
| Componente tabla | — | 5 |
| Diálogo formulario | — | 6 |
| **Subtotal** | **27** | **17** |

### Sección B — BDD Scenarios

| Tipo | Cantidad |
|------|:-------:|
| Happy path | 6 |
| Error | 5 |
| Edge case | 3 |
| **Subtotal** | **14** |

### Trazabilidad AC → Tests

| AC / NFR / Borde | Backend unit | Frontend unit | BDD scenario |
|---|---|---|---|
| AC-1.1 (listar con datos) | BTC-1, BTC-2, BTC-7, BTC-11 | FTC-1, FTC-7 | BDD-1 |
| AC-1.2 (lista vacía) | BTC-12 | FTC-8 | BDD-12 |
| AC-1.3 (búsqueda) | BTC-13, BTC-14 | FTC-9 | BDD-3, BDD-4 |
| AC-1.4 (403 listar) | BTC-22 | FTC-5 | BDD-9 |
| AC-2.1 (crear) | BTC-8, BTC-15 | FTC-2, FTC-10, FTC-12 | BDD-2 |
| AC-2.2 (email duplicado) | BTC-6, BTC-16 | FTC-6 | BDD-7 |
| AC-2.3 (actualizar) | BTC-9, BTC-17 | FTC-3, FTC-14 | BDD-5 |
| AC-2.4 (bloquear email PUT) | BTC-18 | FTC-15 | BDD-13 |
| AC-2.5 (eliminar) | BTC-10, BTC-19 | FTC-4, FTC-11 | BDD-6 |
| AC-2.6 (último admin) | BTC-5, BTC-20 | — | BDD-8 |
| AC-2.7 (empresa inexistente) | BTC-4, BTC-21 | — | BDD-10 |
| AC-2.8 (403 escritura) | BTC-23 | — | BDD-9 |
| NFR-3 (idempotencia DELETE) | BTC-27 | — | BDD-14 |
| Borde: sin password | BTC-24 | FTC-12 | — |
| Borde: email inválido | BTC-25 | FTC-13 | BDD-11 |
| Borde: companyId inválido | BTC-26 | — | — |
| Borde: cerrar diálogo | — | FTC-16, FTC-17 | — |
| **TOTAL: 41** | **27** | **17** | **14** |

> Nota: BDD-9 cubre dos ACs (AC-1.4 y AC-2.8) porque ambos verifican el mismo control de acceso desde la perspectiva del usuario.

Ningún criterio de aceptación queda sin cobertura en ambas secciones del test-cases.md.
