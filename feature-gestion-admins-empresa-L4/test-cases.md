# Test Cases · Gestión de Usuarios Administradores de Empresa

## Resumen ejecutivo

Se diseñan 17 casos de prueba que cubren los 12 criterios de aceptación del spec más
los casos borde y requisitos no funcionales. Se incluyen 6 casos felices, 7 casos de
error y 4 casos borde. Los datos son concretos y trazables a cada AC. Las pruebas se
implementarán con Pest/PHPUnit para backend y Vitest para frontend, siguiendo la
estrategia de 4 fases: Smoke → CRUD → Negativos → E2E.

---

## US-1: Listar administradores de una empresa

### TC-1 (AC-1.1, caso feliz) — Listar administradores con datos

**Datos:**
- `companyId`: `5` (empresa "Instituto del Sur SAC", activa)
- Admins existentes: 2 registros en `company_user_admin`
  - Admin 1: María García López, `mgarcia@instituto.pe`
  - Admin 2: Carlos Ruiz Torres, `cruiz@instituto.pe`

**Pasos:**
1. Autenticarse como super admin base (token JWT válido)
2. Enviar `GET /v2/client/5/admins`

**Esperado:**
- Status `200`
- `data`: array con 2 elementos
- Cada elemento contiene: `id`, `names`, `first_surname`, `second_surname`, `email`, `document`, `phone`
- `total`: `2`

---

### TC-2 (AC-1.2, caso borde) — Listar empresa sin administradores

**Datos:**
- `companyId`: `8` (empresa "Academia Nova EIRL", activa, recién creada sin admins adicionales)
- `company_user_admin` para company 8: 0 registros

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/8/admins`

**Esperado:**
- Status `200`
- `data`: `[]`
- `total`: `0`

---

### TC-3 (AC-1.3, caso feliz) — Búsqueda por nombre

**Datos:**
- `companyId`: `5`
- Query: `GET /v2/client/5/admins?search=María`
- Admins: María García López, Carlos Ruiz Torres

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/5/admins?search=María`

**Esperado:**
- Status `200`
- `data`: 1 elemento (solo María García López)
- `total`: `1`

---

### TC-4 (AC-1.3, caso feliz) — Búsqueda por email

**Datos:**
- `companyId`: `5`
- Query: `GET /v2/client/5/admins?search=cruiz`
- Admins: María García López (`mgarcia@instituto.pe`), Carlos Ruiz Torres (`cruiz@instituto.pe`)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/5/admins?search=cruiz`

**Esperado:**
- Status `200`
- `data`: 1 elemento (solo Carlos Ruiz Torres)
- `total`: `1`

---

### TC-5 (AC-1.4, caso de error) — Usuario sin permisos

**Datos:**
- Token JWT de un usuario con rol `docente` (sin rol super admin base)

**Pasos:**
1. Autenticarse como docente
2. Enviar `GET /v2/client/5/admins`

**Esperado:**
- Status `403`
- `success`: `false`
- `type`: `error`

---

## US-2: Gestionar administradores (CRUD)

### TC-6 (AC-2.1, caso feliz) — Crear nuevo administrador

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
- `data`: objeto con `id`, `names: "Luis Alberto"`, `first_surname: "Mendoza"`, `second_surname: "Quispe"`, `email: "lmendoza@academianova.pe"`, `document: "12345678"`, `phone: "987654321"`
- Se crea registro en `users` con `email = "lmendoza@academianova.pe"`
- Se crea registro en `employees` con `company_id = 8`
- Se crea registro en `user_roles` con el `role_id` del rol "Super Administrador" de la empresa 8
- Se crea registro en `company_user_admin` con `company_id = 8` y `fl_active = true`

---

### TC-7 (AC-2.2, caso de error) — Email ya registrado

**Datos:**
- `companyId`: `8`
- Email `mgarcia@instituto.pe` ya pertenece al usuario María García López (admin de empresa 5)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/8/admins` con body que incluye `"email": "mgarcia@instituto.pe"`

**Esperado:**
- Status `409`
- `message`: `"El email ya está registrado en el sistema"`
- No se crea ningún registro en `users`, `employees`, `user_roles`, ni `company_user_admin`

---

### TC-8 (AC-2.3, caso feliz) — Actualizar datos del administrador

**Datos:**
- `companyId`: `5`
- Admin ID (pivote `company_user_admin`): `12` (corresponde a Carlos Ruiz Torres)
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
- `success`: `true`
- `data`: `names: "Carlos Eduardo"`, `phone: "999888777"`, `document: "87654321"`
- `email` permanece sin cambios: `"cruiz@instituto.pe"`
- Registro en `employees` actualizado con los nuevos valores
- `updated_by` registrado con el ID del super admin base

---

### TC-9 (AC-2.4, caso borde) — Intentar cambiar email en PUT

**Datos:**
- `companyId`: `5`
- Admin ID: `12`
- Body incluye `"email": "nuevoemail@instituto.pe"`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `PUT /v2/client/5/admins/12` con body que incluye `email`

**Esperado:**
- Status `200` (el resto de campos se actualizan normalmente)
- El campo `email` en la respuesta conserva el valor original `"cruiz@instituto.pe"`
- O, alternativamente: Status `422` si el validador rechaza explícitamente el campo `email`

---

### TC-10 (AC-2.5, caso feliz) — Eliminar administrador

**Datos:**
- `companyId`: `5` (tiene 2 administradores: ID 12 Carlos Ruiz, ID 15 María García)
- Admin ID a eliminar: `12`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/5/admins/12`

**Esperado:**
- Status `200`
- `success`: `true`
- `message`: `"Registro eliminado correctamente."`
- El registro en `company_user_admin` con `id = 12` es eliminado
- El registro en `user_roles` vinculado al `employee_id` de Carlos Ruiz es eliminado
- El registro en `employees` de Carlos Ruiz es eliminado
- El registro en `users` de Carlos Ruiz es eliminado
- María García (ID 15) sigue existiendo como admin de la empresa 5

---

### TC-11 (AC-2.6, caso de error) — Eliminar el único administrador

**Datos:**
- `companyId`: `8` (tiene 1 solo administrador)
- Admin ID: `20`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/8/admins/20`

**Esperado:**
- Status `409`
- `message`: `"No se puede eliminar el único administrador de la empresa"`
- Ningún registro es eliminado en `company_user_admin`, `user_roles`, `employees`, ni `users`

---

### TC-12 (AC-2.7, caso de error) — Empresa inexistente

**Datos:**
- `companyId`: `999` (no existe en la tabla `companies`)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/999/admins` o `POST /v2/client/999/admins`

**Esperado:**
- Status `404`
- `message` que indica que la empresa no fue encontrada

---

### TC-13 (AC-2.8, caso de error) — Sin permisos para escritura

**Datos:**
- Token JWT de usuario con rol `docente`

**Pasos:**
1. Autenticarse como docente
2. Enviar `POST /v2/client/5/admins` con datos válidos

**Esperado:**
- Status `403`
- `success`: `false`

---

## Casos borde adicionales

### TC-14 (NFR-3, caso borde) — Eliminar admin ya eliminado (idempotencia)

**Datos:**
- `companyId`: `5`
- Admin ID: `12` (ya fue eliminado en TC-10)

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `DELETE /v2/client/5/admins/12` por segunda vez

**Esperado:**
- Status `200`
- `success`: `true`
- No se lanza error ni `404`

---

### TC-15 (Caso borde, error de validación) — Crear admin sin password

**Datos:**
- `companyId`: `8`
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
2. Enviar `POST /v2/client/8/admins` con body sin `password`

**Esperado:**
- Status `422`
- `messageList` contiene error de validación para el campo `password`

---

### TC-16 (Caso borde, error de validación) — Email con formato inválido

**Datos:**
- Body con `"email": "esto-no-es-email"`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `POST /v2/client/5/admins` con email inválido

**Esperado:**
- Status `422`
- Error de validación en campo `email`

---

### TC-17 (Caso borde, error de validación) — companyId no numérico

**Datos:**
- URL: `GET /v2/client/abc/admins`

**Pasos:**
1. Autenticarse como super admin base
2. Enviar `GET /v2/client/abc/admins`

**Esperado:**
- Status `422` o `404` (dependiendo de si Laravel enruta o rechaza antes)

---

## Resumen de cobertura

| AC / NFR / Borde | Caso feliz | Caso error | Caso borde |
|-------------------|:----------:|:----------:|:----------:|
| AC-1.1 (listar con datos) | TC-1 | — | — |
| AC-1.2 (lista vacía) | — | — | TC-2 |
| AC-1.3 (búsqueda) | TC-3, TC-4 | — | — |
| AC-1.4 (403 listar) | — | TC-5 | — |
| AC-2.1 (crear admin) | TC-6 | — | — |
| AC-2.2 (email duplicado) | — | TC-7 | — |
| AC-2.3 (actualizar) | TC-8 | — | — |
| AC-2.4 (bloquear email en PUT) | — | — | TC-9 |
| AC-2.5 (eliminar admin) | TC-10 | — | — |
| AC-2.6 (último admin) | — | TC-11 | — |
| AC-2.7 (empresa inexistente) | — | TC-12 | — |
| AC-2.8 (403 escritura) | — | TC-13 | — |
| NFR-3 (idempotencia DELETE) | — | — | TC-14 |
| Borde: sin password | — | TC-15 | — |
| Borde: email inválido | — | TC-16 | — |
| Borde: companyId inválido | — | TC-17 | — |
| **TOTAL: 17** | **6** | **7** | **4** |
