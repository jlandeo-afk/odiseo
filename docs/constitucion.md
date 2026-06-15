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
├── components/     # Componentes que no llegaron a ser page/dialogs por ejemplo: Menu - Secciones del dialogo | Secciones de Page
├── composables/    # Abstracción de logica de componentes, separacion Typescript y Html
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
| **Cliente HTTP único** | `odiseoApi` desde `@/services/axios.js`, no crear instancias adicionales, Base URL: `VITE_API_URL/v1` |
| **Interceptors centralizados** | Manejo global de 401, 413, 504 sin redirects manuales |
| **1 store Pinia por dominio** | Composition API style, no almacenar datos de formulario en stores |
| **Composables** | Prefijo `use*`, lógica reactiva reutilizable |
| **Routing lazy-loaded** | `() => import(...)`, file-based via `unplugin-vue-router` Layouts asignados por `meta.layout` (default: vertical nav, blank: auth/error) |
| **1 manejo de useTableData para información de tablas** | Clase que controla la paginación (items, isLoading, total, perPage), exporta singleton (`export default new ...`) |
| **Uso de SweetAlert** | Para mostrar alertas, clase singletón  |
| **Íconos** | Solo Remix Icons |
| **Migración V1 → V2 incompleta** | Dos capas conviviendo |
| **Migración uso estricto JS a TS** | Dos capas conviviendo, recomendado uso TS |

### Monitoreo (Sentry)

- Inicializar en `main.js`, setear usuario post-login
- Ignorar `ChunkLoadError`, filtrar errores sin frames `in_app`

---

## Base de Datos (PostgreSQL 16)

### Versión y Conexiones

- **PostgreSQL 16** obligatorio (LTS hasta 2028-11-09)
- **Dos conexiones**: `pgsql_master` (escritura) + `pgsql_stand_by` (lectura)
- Esquema único: `odiseo` (configurado en `search_path`)

### Convenciones

| Elemento | Formato | Ejemplo |
|----------|---------|---------|
| Tablas | `snake_case`, plural inglés | `users`, `exam_questions` |
| Columnas | `snake_case`, singular inglés | `user_id`, `fl_status` |
| FKs | `{tabla_singular}_id` | `company_id` |
| Índices | `idx_{tabla}_{cols}` | `idx_users_email` |
| Constraints FK | `fk_{origen}_{destino}` | `fk_employees_user_id` |

### Reglas

| Regla | Detalle |
|-------|---------|
| **Migraciones versionadas** | `yyyy_mm_dd_hhmmss_descripcion.php`, reversibles (`down()` funcional) |
| **1 migración por PR** | Agrupar cambios relacionados |
| **Soft deletes** | `deleted_at TIMESTAMPTZ NULL` (no boolean). `fl_status` = activación funcional |
| **Índices parciales** | `WHERE deleted_at IS NULL` para tablas con soft deletes |
| **Particionado** | Tablas >100M registros: particionado nativo por RANGE |
| **Auditoría** | Tablas críticas con triggers → `odiseo.audit_logs` |

### Extensiones Permitidas

`uuid-ossp`, `pg_trgm`, `btree_gin`, `citext`

### Índices por Tipo

| Tipo | Uso |
|------|-----|
| B-tree (default) | FKs, búsqueda frecuente, ordenamiento |
| GIN | JSONB, full-text, arrays |
| Partial | Filtrar por condición común |
| Composite | Queries multi-columna |

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

```
lint → test → build → security → deploy
                              (manual: staging, production + approval)
```

### Jobs

| Stage | Backend | Frontend |
|-------|---------|----------|
| **lint** | PHPStan nivel max | ESLint + typecheck |
| **test** | Pest + PHPUnit (PostgreSQL 16 service), cobertura ≥70% | Vitest + coverage |
| **build** | Docker build + push a registry | Docker build + push a registry |
| **security** | Trivy scan (HIGH, CRITICAL) | Trivy scan (HIGH, CRITICAL) |
| **deploy** | SSH → docker-compose pull + up (dev: auto; staging/prod: manual) | Igual |

### Docker

- Backend: `Dockerfile.prod`
- Frontend: `prod.Dockerfile` (multi-stage: node:18 → nginx:stable-alpine)
- Dev: `dev.Dockerfile` con hot reload

### Rollback

- Tag-based: crear tag `rollback-<YYYYMMDD-HHMMSS>` → pipeline manual con imagen anterior
- Migraciones deben ser reversibles (`migrate:rollback`)

### Entornos

| Rama | Entorno | Deploy |
|------|---------|--------|
| `develop` | dev.odiseo.app | Automático |
| `staging` | staging.odiseo.app | Manual |
| `main` (tag `v*.*.*`) | odiseo.app | Manual + aprobación |

### Notificaciones

- Slack/Teams en fallo de pipeline
- MR comments con cobertura y lint
- Sentry release tracking

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
