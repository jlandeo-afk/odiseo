# CONSTITUCIÓN DEL PROYECTO ODISEO

**Versión:** 1.0  
**Establecida:** 2026-06-15  
**Última modificación:** 2026-06-15

---

## Artículo I — Identidad del Proyecto

### 1.1 Propósito

Plataforma integral de gestión educativa (LMS) para instituciones de formación profesional. Odiseo administra el ciclo completo de enseñanza: matrícula, cursos, evaluaciones, certificaciones y seguimiento del alumnado.

### 1.2 Stakeholders

| Stakeholder | Interés |
|-------------|---------|
| Equipo Lumeria | Desarrollo y operación del producto |
| Instituciones educativas | Cliente final que consume la plataforma |
| Docentes y alumnos | Usuarios directos del sistema |
| Vonex | Infraestructura y despliegue |

### 1.3 Métricas de éxito

- Cobertura de tests ≥ 70% global
- PHPStan nivel 5 sin errores
- Playwright smoke tests verdes en cada push a develop/testing

---

## Artículo II — Pila Tecnológica

### 2.1 Backend

| Componente | Tecnología | Versión |
|------------|-----------|---------|
| Framework | Laravel | ^10 |
| Lenguaje | PHP | ^8.2 |
| Testing | Pest + PHPUnit | ^2 |
| Mocking | Mockery | ^1 |

### 2.2 Frontend

| Componente | Tecnología | Versión |
|------------|-----------|---------|
| Framework | Vue 3 (Composition API) | ^3.4 |
| UI | Vuetify | ^3.6 |
| State | Pinia | ^2.1 |
| Router | Vue Router (lazy-loaded) | ^4.4 |
| HTTP | Axios (cliente único `odiseoApi`) | ^1.12 |
| Package manager | **pnpm** | ^8.6 |
| Testing | Vitest | ^2.1 |
| Íconos | Remix Icons | — |
| Alertas | SweetAlert (singleton) | — |

### 2.3 Persistencia

| Componente | Tecnología | Versión |
|------------|-----------|---------|
| Base de datos | PostgreSQL | **16** (LTS hasta 2028-11-09) |
| Conexiones | `pgsql_master` (escritura) + `pgsql_stand_by` (lectura) |
| Replicación | Streaming Replication nativa |
| Esquemas | `odiseo` (negocio), `extension`, `audit` |

### 2.4 E2E

| Componente | Tecnología |
|------------|-----------|
| Framework | Playwright + TypeScript |
| Reportes | Allure + JUnit |
| Repositorio | Separado (`playqa`) |

### 2.5 Monitoreo

- **Frontend**: Sentry (inicializado en `main.js`, seteo de usuario post-login, ignorar `ChunkLoadError`)
- **Backend**: por definir

---

## Artículo III — Estándares de Calidad

### 3.1 Tipado estricto y análisis estático

| Regla | Detalle |
|-------|---------|
| PHP | `declare(strict_types=1)` en TODO archivo `.php` |
| PHPStan | Nivel 5 (`phpstan.neon` + `phpstan.src.neon`) |
| TypeScript | `strict: true` en archivos nuevos |
| Frontend | ESLint + Prettier + Typescript |

### 3.2 Cobertura de tests

| Capa | Cobertura mínima |
|------|:----------------:|
| Domain (Unit) | **80%** |
| Application (Unit) | **70%** |
| Feature (HTTP) | **60%** |
| Global (Pest) | **70%** |

### 3.3 Ejecución de tests

```bash
# Backend
php vendor/bin/pest --parallel
php vendor/bin/pest --parallel --coverage --min=70
php vendor/bin/pest --testsuite="Context Admin"

# Frontend (Playwright)
npx playwright test --project=api
npx playwright test --project=ui
npx playwright test --ui
```

### 3.4 Política de revisión

- **Nuevo módulo**: verificar cumplimiento de todas las secciones de esta constitución
- **PR**: al menos 1 review aprobatoria
- **Excepciones**: toda violación debe documentarse con justificación, fecha de revisión e issue asociado

### 3.5 Presupuesto de rendimiento

- **API**: respuestas < 200 ms (p95) para endpoints de lectura
- **Frontend**: LCP < 2.5s, TBT < 200ms
- **Base de datos**: índices obligatorios en toda FK; `EXPLAIN` en queries nuevos

### 3.6 Seguridad

- Parameter binding siempre (nunca interpolar strings en SQL)
- Soft delete (`deleted_at`) por defecto
- `ON DELETE RESTRICT` por defecto; `CASCADE` solo documentado y justificado
- Secrets fuera del repositorio (variables de entorno)

> 📎 ADR-007, ADR-011, ADR-012, ADR-013

---

## Artículo IV — Principios de Arquitectura

### 4.1 Backend — Arquitectura Hexagonal Modular

```
src/App/Modules/V2/{Modulo}/
├── Domain/            # Entities, VOs, interfaces de puertos, DomainExceptions
├── Application/       # UseCases, DTOs entrada/salida, contratos
└── Infrastructure/    # Controllers, Eloquent, Validators, Adapters
src/App/Modules/V2/Shared/   # Kernel compartido (VOs, excepciones, enums, puertos)
```

**Separación estricta de capas:**
- **Domain**: no conoce HTTP, JSON, Eloquent ni Laravel
- **Application**: orquesta, no implementa detalles técnicos
- **Infrastructure**: implementa los contratos definidos en capas superiores

### 4.2 Use Cases — Reglas

| Obligatorio | Prohibido |
|-------------|-----------|
| Clase `final` | Extender clases base |
| Único método `execute()` | Recibir `Request` de Laravel, Modelos Eloquent o arrays |
| Recibe un `RequestDto` | Gestionar transacciones directamente |
| Retorna un `ResponseDto` o tipo primitivo (`bool`, `int`) | Retornar `null` o códigos de error |

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

### 4.3 DTOs

- Entrada: `final readonly class`, propiedades tipadas, sin lógica de negocio, sufijo `RequestDto`
- Salida: `final readonly class`, sin exponer Entities, sufijo `ResponseDto`
- Flujo: `Controller → RequestDto → UseCase → ResponseDto → Response → JSON`

### 4.4 Entidades y Value Objects

- `final readonly class` — inmutables
- Validación de invariantes en el **constructor**
- Lanzan `DomainException` ante estados inválidos
- Sin lógica de persistencia ni referencias a ORM

### 4.5 Persistencia — CQRS parcial

| Repositorio | Opera con | Modifica estado |
|-------------|-----------|:---:|
| **Write** | Entities | ✅ |
| **Read** | Proyecciones/DTOs | ❌ |
| **Validator** | Datos de validación | ❌ |

- Interfaces en Domain, implementaciones (QueryBuilder) en Infrastructure
- Binding vía ServiceProvider

### 4.6 Comunicación entre módulos

- Prohibida la dependencia directa entre dominios de módulos distintos
- Se usan **contratos** (interfaces) + **adaptadores** en Infrastructure
- Solo se cruzan DTOs específicos y primitivos

### 4.7 Transacciones

Los Use Cases **NO** gestionan transacciones. Se usa `TransactionalUseCase` como wrapper.

### 4.8 Manejo de errores

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

### 4.9 Validaciones de dominio con persistencia

- Interfaces en `Domain/Validators/`
- Implementaciones en `Infrastructure/Persistences/QueryBuilder/Validators/`
- Se invocan desde el Use Case, lanzan `DomainException`

### 4.10 Frontend — Reglas de estructura

```
src/modules/{modulo}/
├── models/         # Tipos, interfaces, parámetros
├── pages/          # Componentes de página (.page.vue)
├── components/     # Componentes reutilizables (menú, secciones)
├── composables/    # Lógica reactiva (prefijo `use*`)
├── services/       # Clase de servicio API (singleton)
├── dialogs/        # Componentes de diálogo
├── enums/          # Constantes y enumeraciones
├── data/           # Headers de tabla, config estática
└── routes.ts       # Definición de rutas del módulo
```

| Regla | Detalle |
|-------|---------|
| 1 archivo de servicio por módulo | Singleton (`export default new ...`) |
| Cliente HTTP único | `odiseoApi` desde `@/services/axios.js` |
| Interceptors centralizados | Manejo global de 401, 413, 504 |
| 1 store Pinia por dominio | Composition API; no datos de formulario en stores |
| Routing lazy-loaded | `() => import(...)`, file-based via `unplugin-vue-router` |
| `useTableData` singleton | Paginación unificada (items, isLoading, total, perPage) |
| Selectores para tests | Elementos semánticos (Role, Label, Placeholder); NUNCA IDs de Vuetify |
| UI / UX | No debe existir inputs sin su placeholder bien definido y sus reglas de validación |
| UI / UX | Si hay inputs con validaciones como tamaño de caracteres minimos o maximo usar los atributos count, max |
| Uso de VFORM | Todo formulario debe estar correctamente validadó desde frontend con las reglas de negocio |
| Typescript | Uso estricto de typescript <setup lang="ts">....</setup> |

### 4.11 Base de datos — Naming y estructura

| Elemento | Formato | Ejemplo |
|----------|---------|---------|
| Tablas | `snake_case`, plural | `clients`, `course_user` |
| PK | `id` (UUID preferido) | `id` |
| FK | `{tabla_singular}_id` (con índice obligatorio) | `company_id` |
| Columnas | `snake_case`, singular. `created_at`, `updated_at`, `created_by` siempre | `user_id` |
| Funciones | `fn_` + parámetros `p_` + vars `v_` | `fn_get_user_by_id` |
| Triggers | `trg_` | `trg_audit_users` |
| Vistas | `v_` (estándar), `vm_` (materializada) | `v_active_users` |
| Índices | `idx_{tabla}_{cols}` | `idx_users_email` |
| Constraints FK | `fk_{origen}_{destino}` | `fk_employees_user_id` |

### 4.12 Funciones PL/pgSQL — Verbos estrictos

| Categoría | Verbos | Volatilidad |
|-----------|--------|:-----------:|
| Read (1 fila) | `get` | `STABLE` |
| Read (N filas) | `list`, `paginate`, `search` | `STABLE` |
| Read (agregado) | `count`, `exists`/`is`/`has`/`can` | `STABLE` |
| Write | `create`, `update`, `delete` (hard), `archive` (soft), `restore`, `upsert` | `VOLATILE` |
| Lógica | `calculate` (`IMMUTABLE` si es matemática pura), `process`, `sync`, `approve`, `reject`, `assign` | `VOLATILE` |

**Returns:**
- Read: `TABLE(col1 type, col2 type)` — **NUNCA `SETOF record`**
- Write: retorno `void` obligatorio — prohibido retornar registros modificados

### 4.13 Tipos de datos

| Dato | Tipo | Prohibido |
|------|------|-----------|
| Dinero | `DECIMAL(10,2)` | `money`, `FLOAT` |
| Timestamps | `TIMESTAMPTZ` | `timestamp` sin TZ |
| Fechas sin hora | `DATE` | — |
| Texto | `TEXT` (límite solo si negocio lo exige) | `VARCHAR` sin razón |
| JSON | `JSONB` | `json` |

### 4.14 Anti-patrones prohibidos

- ❌ Dependencia directa entre dominios de módulos distintos
- ❌ Usar `BETWEEN` para timestamps
- ❌ Funciones en `WHERE` (matan índices)
- ❌ `SELECT *` en cualquier contexto
- ❌ Interpolar strings en SQL raw
- ❌ `ALTER TYPE` en tablas >1M filas
- ❌ Extender clases base en Use Cases
- ❌ IDs de Vuetify o clases CSS internas en selectores de tests

> 📎 ADR-001 a ADR-006, ADR-008 a ADR-010

---

## Artículo V — Flujo de Trabajo de Desarrollo

### 5.1 Commits

- Formato: `type(scope): description`
- Tipos: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`
- Idioma: inglés (Conventional Commits)
- **Prohibido**: commits con secretos, `--no-verify`, force-push sin autorización

### 5.2 Estrategia de ramas

| Rama | Entorno | URL Backend | URL Frontend |
|------|---------|-------------|-------------|
| `main` | producción | `api.odiseo.pe` | `vonex.odiseo.pe` |
| `testing` | testing | `apitest.odiseo.pe` | `test.odiseo.pe` |
| `develop` | dev | `apidev.odiseo.pe` | `dev.odiseo.pe` |
| `demo` | demo (B2B) | `apidemo.odiseo.pe` | `demo.odiseo.pe` |
| `feat/*` | feature | — | — |
| `fix/*` | hotfix | — | — |
| `refactor/*` | refactor | — | — |

### 5.3 Pipeline CI/CD

**Backend:** `backup → build → deploy → PlayQA`  
**Frontend:** `versioning → build → deploy → PlayQA`

| Stage | Backend | Frontend |
|-------|---------|----------|
| **backup** | `pg_dump` cifrado (solo `main`) | — |
| **versioning** | — | `pnpm version` semántico vía `#major`/`#minor` (solo `main`) |
| **build** | `composer install`, PHPStan, `artisan migrate` | `pnpm install --frozen-lockfile`, `pnpm build` |
| **deploy** | `rsync` bare-metal, `supervisorctl restart` | `cp -r dist/` |
| **PlayQA** | Tests E2E con Playwright | Tests E2E con Playwright |

### 5.4 Migraciones

- Formato timestamp: `YYYY_MM_DD_HHMMSS_<descripcion>.php`
- `down()` **debe ser reversible** siempre
- Funciones: `up()` llama a `down()` primero (idempotencia); SQL en archivo `.sql` separado
- 1 carpeta = 1 artefacto (tabla, función, vista, trigger)
- 1 PR = 1 migración
- Tablas grandes: **NUNCA `ALTER TYPE`** en tablas >1M filas

### 5.5 Entornos y despliegue

- **Sin Docker**: despliegue directo vía rsync bare-metal
- **Backend — 2 servidores**: server 1 ejecuta migraciones, server 2 no
- **Frontend — 1 servidor por entorno** (2 en `main`)
- **Supervisorctl**: restart automático post-deploy backend

### 5.6 Respaldo de base de datos

- Disparo: automático en push a `main` (omitir con `#no-backup`)
- Herramienta: `pg_dump -Fc` comprimido con gzip + zip con contraseña
- Retención: últimos 20 backups locales + sync a Google Drive (rclone)

### 5.7 Migración V1 → V2

- Código nuevo en `src/`; legacy (`app/`) solo se modifica si es estrictamente necesario
- TypeScript recomendado para archivos nuevos; convivencia JS → TS

---

## Artículo VI — Configuración del Modelo

### 6.1 Proveedores y niveles

| Nivel | Uso | Contexto |
|-------|-----|----------|
| **razonamiento** | Fases 1-3 (especificar, planificar, diseñar pruebas) | Decisiones de arquitectura, specs, ADRs |
| **estándar** | Fase 4 (implementación) | Código guiado por spec validada |
| **ligero** | Tareas mecánicas, linting, formateo | Refactors simples, correcciones de estilo |

### 6.2 Asignación por agente (OpenCode)

| Actividad | Nivel mínimo |
|-----------|:------------:|
| Spec / Plan / Test design | razonamiento |
| Implementación de Use Cases, Entities, DTOs | estándar |
| Pest / PHPUnit tests | estándar |
| Correcciones de lint (PHPStan, ESLint) | ligero |
| Documentación (ADRs, README) | estándar |

### 6.3 Gobernanza del modelo

- El presupuesto de tokens por sesión lo define el Tech Lead según complejidad
- No delegar decisiones de arquitectura al nivel ligero
- La constitución se redacta con criterio humano, no con IA (§10.9 — value drift)

---

## Artículo VII — Límites

### 7.1 ALWAYS DO — Siempre

- ✅ `declare(strict_types=1)` en todo archivo PHP
- ✅ `SELECT` con columnas explícitas — nunca `SELECT *`
- ✅ Binding de parámetros para queries SQL (nunca interpolación)
- ✅ Tests nombrados en español con `it('descripción en minúscula')`
- ✅ Mockear interfaces, no clases concretas (`Mockery::mock(Interface::class)`)
- ✅ Especificar `->once()`, `->never()` en expectativas de mock
- ✅ `down()` reversible en toda migración
- ✅ Funciones: `up()` llama a `down()` primero (idempotencia de migraciones)
- ✅ Índices en toda Foreign Key
- ✅ `UNION ALL` sobre `UNION` cuando no se necesita deduplicación
- ✅ Rangos para fechas: `>=` y `<` (nunca `BETWEEN`)
- ✅ `WHERE` antes de `GROUP BY`; `HAVING` solo tras agregados
- ✅ Eager Loading (`with()`) para evitar N+1 en Eloquent
- ✅ `TIMESTAMPTZ` para timestamps; `DATE` para fechas sin hora
- ✅ `DECIMAL(10,2)` para dinero; `JSONB` para JSON; `TEXT` para strings
- ✅ Elementos HTML semánticos (Role, Label, Placeholder) como selectores de tests
- ✅ `story('CP_XXXX_0000')` para trazabilidad de tests (Allure)
- ✅ `beforeEach` para mocks compartidos en tests
- ✅ Estrategia de test en 4 fases por módulo: Smoke → CRUD → Negativos → E2E
- ✅ 1 archivo de servicio HTTP por módulo frontend (singleton)
- ✅ Uso estricto de Typescript en la medida no usar any a menos que sea requerido

### 7.2 ASK FIRST — Preguntar antes

- ⚠️ Modificar código legacy en `app/` (solo si es estrictamente necesario)
- ⚠️ Agregar nuevas dependencias (paquetes Composer, npm)
- ⚠️ Cambios en esquema de base de datos (nuevas tablas, columnas, índices)
- ⚠️ Modificar lógica de autenticación o autorización
- ⚠️ Cambiar configuraciones de CI/CD o despliegue
- ⚠️ Refactorizar utilidades compartidas del kernel (`src/App/Modules/V2/Shared/`)
- ⚠️ Usar `CASCADE` en FK (debe estar documentado y justificado)
- ⚠️ `ALTER TYPE` en tablas con datos existentes

### 7.3 NEVER DO — Nunca

- ❌ `SELECT *` en queries SQL
- ❌ Interpolar strings directamente en SQL raw
- ❌ Usar `BETWEEN` para timestamps
- ❌ Funciones sobre columnas en cláusula `WHERE`
- ❌ `money` o `FLOAT` para valores monetarios
- ❌ `timestamp` sin timezone (usar `TIMESTAMPTZ`)
- ❌ `VARCHAR` sin razón de negocio (usar `TEXT`)
- ❌ `json` (usar `JSONB`)
- ❌ `SETOF record` en returns de funciones PostgreSQL
- ❌ Retornar registros o IDs en funciones de escritura (retorno `void` obligatorio)
- ❌ Extender clases base en Use Cases
- ❌ Recibir `Request` de Laravel, Modelos Eloquent o arrays en Use Cases
- ❌ Dependencia directa entre dominios de módulos distintos
- ❌ IDs de Vuetify (`input-503`), clases internas (`.v-field__input`), o scoped CSS (`data-v-*`) como selectores de tests
- ❌ Usar `ordered()` en mocks (tests frágiles)
- ❌ Commits con secretos, API keys o credenciales
- ❌ Eliminar tests fallidos sin aprobación explícita
- ❌ Modificar archivos de configuración de producción sin revisión
- ❌ Generar o modificar esta constitución usando IA (§10.9)
- ❌ Enmendar la constitución desde una rama de feature
- ❌ Escribir código en `src/` sin una prueba que falle primero (TDD)

---

## Artículo VIII — Enmiendas

### 8.1 Proceso de modificación

1. Toda enmienda se propone como issue con prefijo `constitution/`
2. Requiere aprobación del Tech Lead + al menos un revisor del equipo
3. Se registra en el historial de revisiones con fecha, autor y justificación
4. Nunca desde una rama de feature: la constitución rige la feature, la feature no puede redefinir a su gobernante

### 8.2 Gobernanza

- **Revisión trimestral** de la constitución por el equipo completo
- **Post-incidente**: documentar lecciones y ajustar si corresponde
- **Excepciones**: toda violación debe documentarse con justificación, fecha de revisión e issue asociado
- **ADRs**: Toda decisión arquitectónica significativa → `docs/adr/`. Los ADRs son **historial**, la Constitución es **referencia activa**

### 8.3 Trazabilidad ADR → Artículo

| ADR | Título | Artículo |
|-----|--------|----------|
| 001 | Nueva arquitectura en `src/` | IV — Principios de Arquitectura |
| 002 | Definición de Use Cases | IV — Principios de Arquitectura |
| 003 | Uso de DTOs | IV — Principios de Arquitectura |
| 004 | Puertos de salida | IV — Principios de Arquitectura |
| 005 | Comunicación entre módulos | IV — Principios de Arquitectura |
| 006 | Manejo de transacciones | IV — Principios de Arquitectura |
| 007 | Manejo de errores | III — Estándares de Calidad |
| 008 | CQRS en persistencia | IV — Principios de Arquitectura |
| 009 | Validators con persistencia | IV — Principios de Arquitectura |
| 010 | Responses y serialización | IV — Principios de Arquitectura |
| 011 | Organización de tests | III — Estándares de Calidad |
| 012 | Estandarización Pest | III — Estándares de Calidad |
| 013 | Patrón Builder | III — Estándares de Calidad |

### 8.4 Historial de revisiones

| Fecha | Autor | Cambio | Justificación |
|-------|-------|--------|---------------|
| 2026-06-15 | Equipo Lumeria | Versión 1.0 | Constitución inicial basada en convenciones existentes del proyecto |

---

## Reglas de Comportamiento

> Estas reglas aplican a todo agente de IA y desarrollador trabajando en el proyecto.

1. **Anti-sycophancy**: nunca aceptar "la IA dijo que está bien" como evidencia. Todo output debe ser verificado.
2. **PROSE**: cada párrafo de especificación debe pasar el filtro Precisión · Razón · Outcome observable · Scope · Ejemplo (§1.2.5).
3. **Nadie commitea sin entender**: si no podés defender una línea, no va al repositorio.
4. **Fail-closed**: ante la duda en un gate, se bloquea. Falso positivo es más barato que falso negativo.
5. **El código legacy se respeta**: no se refactoriza `app/` sin issue y plan previo.
6. **La spec manda**: un cambio de requisito primero va a la spec, después al código. Nunca al revés.
