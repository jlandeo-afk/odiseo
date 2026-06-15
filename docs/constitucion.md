# CONSTITUCIÓN DEL PROYECTO ODISEO
## Principios Arquitectónicos, Estándares y Gobernanza

**Versión**: 1.0 | **Fecha**: 2026-06-15 | **Stack**: Laravel 10 + Vue 3 + PostgreSQL 16

---

## Para Todos los Roles

| Regla | Detalle |
|-------|---------|
| **Naming** | Dominio en español, patrones/clases/métodos en inglés, tablas inglés snake_case, tests español, commits inglés Conventional Commits, branches inglés kebab-case |
| **Tipado estricto** | `declare(strict_types=1)` en todo PHP; `strict: true` en TypeScript nuevos |
| **Linting** | PHPStan nivel max, Laravel Pint (PSR-12), ESLint + Prettier frontend |
| **Commits** | `type(scope): description` — `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf` |
| **Branches** | `main` (prod), `staging`, `develop`, `feat/*`, `fix/*`, `refactor/*` |
| **Evolución legacy** | Código nuevo en `src/`; legacy (`app/`) solo se modifica si es estrictamente necesario |

---

## Backend (PHP / Laravel)

### Arquitectura Hexagonal Modular

```
src/App/Modules/V2/{Modulo}/
├── Domain/            # Entities, VOs, interfaces de puertos, DomainExceptions
├── Application/       # UseCases, DTOs entrada/salida, contratos
└── Infrastructure/    # Controllers, Eloquent, Validators, Adapters
src/App/Modules/V2/Shared/   # Kernel compartido (VOs, excepciones, enums, puertos)
```

**Separación estricta**: Dominio no conoce HTTP, JSON, Eloquent ni Laravel. Aplicación orquesta, no implementa detalles técnicos. Infraestructura implementa contratos.

### Use Cases — Reglas Críticas

| Obligatorio | Prohibido |
|-------------|-----------|
| Clase `final` | Extender clases base |
| Único método `execute()` | Recibir `Request` de Laravel, Modelos Eloquent o arrays |
| Recibe un `RequestDto` | Gestionar transacciones directamente |
| Retorna un `ResponseDto` o tipo primitivo (`bool`, `int`) | — |

```php
final class StoreUserUsecase
{
    public function __construct(
        private UserReadRepositoryInterface $reader,
        private UserWriteRepositoryInterface $writer,
        private ExistsValidatorInterface $validator,
    ) {}
    public function execute(StoreUserRequestDto $dto): StoreUserResponseDto { /* ... */ }
}
```

### DTOs

- Entrada: `final readonly class`, propiedades tipadas, sin lógica de negocio, sufijo `RequestDto`
- Salida: `final readonly class`, sin exponer Entities, sufijo `ResponseDto`
- Flujo: `Controller → RequestDto → UseCase → ResponseDto → Response → JSON`

### Entidades y Value Objects

- `final readonly class` — inmutables
- Validación de invariantes en el **constructor**
- Lanzan `DomainException` ante estados inválidos
- Sin lógica de persistencia ni referencias a ORM

### Persistencia (CQRS parcial)

| Repositorio | Opera con | Modifica estado |
|-------------|-----------|:---:|
| **Write** | Entities | ✅ |
| **Read** | Proyecciones/DTOs | ❌ |
| **Validator** | Datos de validación | ❌ |

- Interfaces en Domain, implementaciones (QueryBuilder) en Infrastructure
- Binding vía ServiceProvider

### Comunicación Entre Módulos

- Prohibida la dependencia directa entre dominios de módulos distintos
- Se usan **contratos** (interfaces) + **adaptadores** en Infrastructure
- Solo se cruzan DTOs específicos y primitivos

### Transacciones

Los Use Cases **NO** gestionan transacciones. Se usa `TransactionalUseCase` como wrapper.

### Manejo de Errores

| Excepción | HTTP | Cuándo |
|-----------|------|--------|
| `DomainException` | 409 Conflict | Reglas de negocio violadas |
| `RequestValidationException` | 422 Unprocessable | Datos de entrada inválidos |
| `UnauthorizedException` | 401 | No autenticado |
| `ForbiddenException` | 403 | Sin permisos |
| `NotFoundRecordException` | 404 | Recurso no existe |
| `ApplicationException` | 400 | Error genérico de aplicación |
| `Exception` (fallback) | 500 | Error no controlado |

- Use Cases lanzan excepciones, nunca retornan `null` ni códigos de error
- El Exception Handler traduce a HTTP

### Validaciones de Dominio con Persistencia

- Interfaces de validación en `Domain/Validators/`
- Implementaciones en `Infrastructure/Persistences/QueryBuilder/Validators/`
- Se invocan desde el Use Case, lanzan `DomainException`

### PHP Estricto

- `declare(strict_types=1)` en TODO archivo `.php`
- PHPStan nivel máximo (`phpstan.neon` + `phpstan.src.neon`)

> 📎 ADR-001 a ADR-010

---

## Frontend (Vue 3 / TypeScript)

### Stack

| Componente | Tecnología |
|------------|-----------|
| Framework | Vue 3 (Composition API) ^3.4 |
| UI | Vuetify 3 ^3.6 |
| State | Pinia ^2.1 |
| Router | Vue Router ^4.4 (lazy-loaded, file-based) |
| HTTP | Axios ^1.12 (cliente único `odiseoApi`) |
| Package manager | **pnpm** ^8.6 |
| Testing | Vitest ^2.1 |

### Estructura

```
src/modules/{modulo}/
├── models/         # Tipos, interfaces, parámetros
├── pages/          # Componentes de página (.page.vue)
├── services/       # Clase de servicio API (singleton)
├── dialogs/        # Componentes de diálogo
├── enums/          # Constantes y enumeraciones
├── data/           # Headers de tabla, config estática
└── routes.ts       # Definición de rutas del módulo
```

### Reglas Clave

| Regla | Detalle |
|-------|---------|
| **1 archivo de servicio por módulo** | Clase con métodos HTTP, exporta singleton (`export default new ...`) |
| **Cliente HTTP único** | `odiseoApi` desde `@/services/axios.js`, no crear instancias adicionales |
| **Interceptors centralizados** | Manejo global de 401, 413, 504 sin redirects manuales |
| **1 store Pinia por dominio** | Composition API style, no almacenar datos de formulario en stores |
| **Composables** | Prefijo `use*`, lógica reactiva reutilizable |
| **Routing lazy-loaded** | `() => import(...)`, file-based via `unplugin-vue-router` |

### Monitoreo (Sentry)

- Inicializar en `main.js`, setear usuario post-login
- Ignorar `ChunkLoadError`, filtrar errores sin frames `in_app`

### Docker

- Dev: `node:lts` + pnpm install + `pnpm dev --host`
- Prod: Multi-stage (`node:18` builder → `nginx:stable-alpine`)

---

## Base de Datos (PostgreSQL 16)

### Versión y Conexiones

- **PostgreSQL 16** obligatorio (LTS hasta 2028-11-09)
- **Dos conexiones**: `pgsql_master` (escritura) + `pgsql_stand_by` (lectura)
- ORM: Laravel Eloquent
- **Esquemas** (`search_path`): `odiseo`, `extension`, `audit`

| Esquema | Propósito |
|---------|-----------|
| `odiseo` | Datos de negocio (tablas, funciones, vistas) |
| `extension` | Extensiones PostgreSQL (`citext`, `unaccent`, `pg_trgm`) |
| `audit` | Auditoría (`audit_logs`, `function_log` para rollback de funciones) |

### Naming & Structure

| Elemento | Formato | Ejemplo |
|----------|---------|---------|
| Tablas | `snake_case`, plural | `clients`, `course_user` |
| PK | `id` (UUID preferido) | `id` |
| FK | `{tabla_singular}_id` (con índice obligatorio) | `company_id` |
| Columnas | `snake_case`, singular. `created_at`, `updated_at`, `created_by` siempre | `user_id`, `company_id` |
| Funciones | `fn_` + parámetros `p_` + vars `v_` | `fn_get_user_by_id` |
| Triggers | `trg_` | `trg_audit_users` |
| Vistas | `v_` (estándar), `vm_` (materializada) | `v_active_users`, `vm_question_images` |
| Índices | `idx_{tabla}_{cols}` | `idx_users_email` |
| Constraints FK | `fk_{origen}_{destino}` | `fk_employees_user_id` |

### Funciones (PL/pgSQL)

**Verbos estrictos:**

| Categoría | Verbos | Volatilidad |
|-----------|--------|:-----------:|
| Read (1 fila) | `get` | `STABLE` |
| Read (N filas) | `list`, `paginate`, `search` | `STABLE` |
| Read (agregado) | `count`, `exists`/`is`/`has`/`can` | `STABLE` |
| Write | `create`, `update`, `delete` (hard), `archive` (soft), `restore`, `upsert` | `VOLATILE` |
| Lógica | `calculate` (`IMMUTABLE` si es matemática pura), `process`, `sync`, `approve`, `reject`, `assign` | `VOLATILE` |

**Returns:** NUNCA `SETOF record`. Usar `TABLE(col1 type, col2 type)`.

**Volatilidad (crítica):**
- `IMMUTABLE`: Lógica pura, sin acceso a tablas. Cacheable.
- `STABLE`: Solo lectura. Ejecuta una vez por transacción.
- `VOLATILE`: Escritura/aleatorio. Re-ejecuta por cada fila.

### Data Types

| Dato | Tipo | Prohibido |
|------|------|-----------|
| Dinero | `DECIMAL(10,2)` | `money`, `FLOAT` |
| Timestamps | `TIMESTAMPTZ` | `timestamp` sin TZ |
| Fechas sin hora | `DATE` | — |
| Texto | `TEXT` (límite solo si la lógica de negocio lo exige) | `VARCHAR` sin razón |
| JSON | `JSONB` | `json` |

### Query Rules

| Regla | Detalle |
|-------|---------|
| `SELECT` | Columnas explícitas. **NUNCA `SELECT *`** |
| Filtrado | `WHERE` antes de `GROUP BY`. `HAVING` solo tras agregados |
| Fechas | Usar rangos (`>=` y `<`). NUNCA funciones en `WHERE` (matan índices). NUNCA `BETWEEN` para timestamps |
| Sets | Preferir `UNION ALL` sobre `UNION` (sin deduplicación, más rápido) |
| N+1 | Usar Eloquent Eager Loading (`with()`) o CTEs/LATERAL JOINs en SQL |

### DML & Safety

| Regla | Detalle |
|-------|---------|
| Soft delete | `deleted_at TIMESTAMPTZ NULL`. `deleted_by` FK a `users` |
| `ON DELETE` | `RESTRICT` por defecto. `CASCADE` solo si es lógicamente requerido (ej: order → order_items) y documentado |
| Parameter binding | Siempre usar binding (`?` o arrays) o Eloquent. **NUNCA** interpolar strings en SQL raw |
| Transacciones | Writes multi-paso en `DB::transaction()` |

### Migraciones

**Estructura por tipo:**

| Tipo | Carpeta | Estructura | Ejemplo |
|------|---------|------------|---------|
| Tablas | `tables/{table_}<nombre>/` | N archivos `.php` (creación + cambios) | `tables/table_course/` → `2025_06_10_000000_create.php` |
| Funciones | `functions/fn_<nombre>/` | 1 `.php` + 1 `.sql` | `functions/fn_get_questions_ia/` → `2026_04_28_115315_fn_get_questions_ia.php` + `fn_get_questions_ia.sql` |
| Vistas | `views/v_<nombre>/` o `views/vm_<nombre>/` | 1 `.php` | `views/vm_question_images/` |
| Triggers | `triggers/` | Archivos planos | `triggers/2025_..._trg_xxx.php` |
| Extensiones | `extensions/ex_<nombre>/` | 1 `.php` | `extensions/ex_unnacent/` |
| Schema | `schema/sch_<nombre>/` | 1 `.php` | `schema/sch_odiseo/` |

**Patrón para funciones (obligatorio):**
```php
// functions/fn_get_user_by_id/YYYY_MM_DD_HHMMSS_fn_get_user_by_id.php
public function up(): void
{
    $this->down();                                    // Idempotente: drop antes de recrear
    $sql = file_get_contents(__DIR__ . '/fn_get_user_by_id.sql');
    DB::unprepared($sql);
}
public function down(): void
{
    rollbackFunctionPostgres('fn_get_user_by_id');    // Helper: restaura versión anterior desde audit.function_log
}
```

**Reglas:**

| Regla | Detalle |
|-------|---------|
| Formato timestamp | `YYYY_MM_DD_HHMMSS_<descripcion>.php` |
| `down()` | **Debe ser reversible** siempre (tablas: `Schema::dropIfExists`, funciones: `rollbackFunctionPostgres()`) |
| Funciones | `up()` llama a `down()` primero (idempotencia). SQL en archivo `.sql` separado, leído con `file_get_contents()` |
| 1 carpeta = 1 artefacto | Cada función/tabla/vista tiene su carpeta dedicada |
| 1 PR = 1 migración | Agrupar cambios relacionados |
| Tablas grandes | **NUNCA `ALTER TYPE`** en tablas >1M filas (crear columna nueva → backfill → swap) |

### Índices

| Tipo | Uso |
|------|-----|
| B-tree (default) | FKs, búsqueda frecuente, ordenamiento |
| GIN | JSONB, full-text, arrays |
| Partial | `WHERE deleted_at IS NULL` para tablas con soft deletes |
| Composite | Queries multi-columna |

### Particionado y Auditoría

- **Particionado nativo** por RANGE para tablas >100M registros
- **Auditoría**: triggers en tablas críticas → `audit.audit_logs`. Rollback de funciones via `audit.function_log`

### Extensiones

`uuid-ossp`, `pg_trgm`, `btree_gin`, `citext`, `unaccent` — instaladas en esquema `extension`

---

## QA / Testing

### Estructura

```
tests/Context/{Admin|Client}/{Modulo}/
├── Builders/                  # Payload/Entity/DTO Builders (in-memory)
│   ├── {Modulo}PayloadBuilder.php
│   ├── {Modulo}EntityBuilder.php
│   └── {Modulo}RequestDtoBuilder.php
├── Feature/Http/              # Tests de Controller (HTTP real)
└── Unit/
    ├── Application/           # Tests de Use Cases (con mocks)
    └── Domain/                # Tests de entidades (sin mocks)
```

### Reglas Obligatorias

| Regla | Motivo |
|-------|--------|
| `declare(strict_types=1)` en todos los tests | PHPStan nivel máximo |
| Nombres en español, minúscula | `it('crea un usuario correctamente')` |
| `Mockery::mock(Interface::class)`, nunca clases concretas | Aísla el test |
| Especificar count en `shouldReceive` (`->once()`, `->never()`) | Documenta expectativas |
| `beforeEach` para mocks compartidos | Evita errores por mocks faltantes |
| No usar `ordered()` por defecto | Tests frágiles |
| `assertJson()` para flujo feliz, `assertJsonStructure()` para listas | Precisión |

### Cobertura Mínima (pipeline falla si no se alcanza)

| Tipo | Cobertura |
|------|:---------:|
| Domain (Unit) | **80%** |
| Application (Unit) | **70%** |
| Feature (HTTP) | **60%** |

### Builders

- `BaseBuilder` (persiste en DB): `makeData()` + `insert()` + fluent API
- `PayloadBuilder` (in-memory): `static buildStore(array $overrides = []): array`
- `EntityBuilder` (in-memory): `static buildEntity(array $overrides = []): {Entity}`

### Ejecución

```bash
php vendor/bin/pest --parallel
php vendor/bin/pest --parallel --coverage --min=70
php vendor/bin/pest --testsuite="Context Admin"
```

> 📎 ADR-011, ADR-012, ADR-013

---

## DevOps / CI/CD

### Pipeline Stages

**Backend**: `backup → build → deploy → PlayQA`
**Frontend**: `versioning → build → deploy → PlayQA`

### Jobs por Stage

| Stage | Backend | Frontend |
|-------|---------|----------|
| **backup** | `pg_dump` cifrado + retención 20 backups + sync GDrive (solo `main`) | — |
| **versioning** | — | `pnpm version` semántico vía `#major` / `#minor` en commit (solo `main`) |
| **build** | `composer install`, `npm install`, PHPStan (no en prod), `artisan migrate`, cache | `pnpm install --frozen-lockfile`, `pnpm build` |
| **deploy** | `rsync` bare-metal → `/var/www/odiseo-backend/`, permisos, `supervisorctl restart` | `cp -r dist/` → `/var/www/odiseo-frontend/`, permisos |
| **PlayQA** | Tests E2E con Playwright (ver abajo) | Tests E2E con Playwright (ver abajo) |

### Despliegue (rsync bare-metal)

- **Sin Docker**: despliegue directo vía rsync desde path de preprod al web root
- **Backend — 2 servidores**: server 1 ejecuta migraciones, server 2 no (evita locking por migraciones concurrentes)
- **Frontend — 1 servidor por entorno** (2 servidores en `main`)
- **Producción**: `--force` en migraciones; PHPStan deshabilitado en build
- **Supervisorctl**: restart automático post-deploy backend

### PlayQA (E2E con Playwright)

Repositorio separado (`playqa`), clonado en el job. Imagen `mcr.microsoft.com/playwright:noble`. Reportes Allure + JUnit como artifacts.

| Modo | Disparo | Ramas |
|------|---------|-------|
| **smoke** | Automático en push | `develop`, `testing` |
| **full** | Manual: `#test` en commit message | `develop`, `testing` |
| **api-only** | Manual: `#api` en commit message | `develop`, `testing` |
| **ui-only** | Manual: `#ui` en commit message | `develop`, `testing` |
| **nightly** | Schedule (3 AM) | `testing` |

Retención de artifacts: 7 días (smoke/full), 30 días (nightly).

### Backup de Base de Datos

- **Disparo**: automático en push a `main`. Se omite con tag `#no-backup` en commit
- **Herramienta**: `pg_dump -Fc` comprimido con gzip + zip con contraseña
- **Retención**: últimos 20 backups locales
- **Sync externo**: rsync a carpeta montada de Google Drive (rclone)

### Versionado (Frontend)

- Job `bump-version` en stage `versioning`, solo en `main`
- Detecta tags en commit message:
  - `#major` → major release
  - `#minor` → sprint release
  - default → patch/hotfix
- Ejecuta `pnpm version` + `git push --follow-tags origin main`

### Entornos

| Rama | Entorno | Backend URL | Frontend URL | Deploy |
|------|---------|-------------|-------------|--------|
| `develop` | dev | `apidev.odiseo.pe` | `dev.odiseo.pe` | Automático |
| `testing` | testing | `apitest.odiseo.pe` | `test.odiseo.pe` | Automático |
| `demo` | demo (B2B) | `apidemo.odiseo.pe` | `demo.odiseo.pe` | Automático |
| `main` | producción | `api.odiseo.pe` | `vonex.odiseo.pe` | Automático |

---

## Tech Lead / Arquitecto

### ADRs

- Toda decisión arquitectónica significativa → `docs/adr/`
- Plantilla: Título, Estado, Fecha, Contexto, Opciones, Decisión, Justificación, Consecuencias
- Los ADRs son **historial**, la Constitución es **referencia activa**

### Gobernanza

- **Revisión trimestral** de la constitución
- **Nuevo módulo**: verificar cumplimiento de todas las secciones
- **Post-incidente**: documentar lecciones y ajustar
- **Excepciones**: toda violación debe documentarse con justificación, fecha de revisión e issue asociado

### Trazabilidad ADR → Sección

| ADR | Título | Sección |
|-----|--------|---------|
| 001 | Nueva arquitectura en `src/` | Backend — Arquitectura |
| 002 | Definición de Use Cases | Backend — Use Cases |
| 003 | Uso de DTOs | Backend — DTOs |
| 004 | Puertos de salida | Backend — Persistencia |
| 005 | Comunicación entre módulos | Backend — Comunicación |
| 006 | Manejo de transacciones | Backend — Transacciones |
| 007 | Manejo de errores | Backend — Errores |
| 008 | CQRS en persistencia | Backend — Persistencia |
| 009 | Validators con persistencia | Backend — Validaciones |
| 010 | Responses y serialización | Backend — DTOs |
| 011 | Organización de tests | QA / Testing |
| 012 | Estandarización Pest | QA / Testing |
| 013 | Patrón Builder | QA / Testing |
