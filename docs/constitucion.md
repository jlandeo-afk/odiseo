# CONSTITUCIÓN DEL PROYECTO ODISEO
## Principios Arquitectónicos, Estándares y Gobernanza

**Versión**: 1.0  
**Fecha**: 2026-06-15  
**Alcance**: Full-stack (backend Laravel 10 + frontend Vue 3)  
**Propósito**: Fuente única de verdad para decisiones técnicas, onboarding y code review

---

## Tabla de Contenidos

1. [Principios Fundamentales](#1-principios-fundamentales)
2. [Capa de Dominio](#2-capa-de-dominio)
3. [Capa de Aplicación](#3-capa-de-aplicación)
4. [Capa de Infraestructura](#4-capa-de-infraestructura)
5. [Manejo de Errores y Excepciones](#5-manejo-de-errores-y-excepciones)
6. [Validaciones de Dominio con Acceso a Persistencia](#6-validaciones-de-dominio-con-acceso-a-persistencia)
7. [Estándares de Testing](#7-estándares-de-testing)
8. [Base de Datos: PostgreSQL 16](#8-base-de-datos-postgresql-16)
9. [Frontend: Convenciones y Estándares](#9-frontend-convenciones-y-estándares)
10. [Pipeline GitLab CI/CD](#10-pipeline-gitlab-cicd)
11. [Convenciones Transversales](#11-convenciones-transversales)
12. [Gobernanza y Evolución](#12-gobernanza-y-evolución)
13. [Anexo: Trazabilidad ADR → Constitución](#13-anexo-trazabilidad-adr--constitución)

---

## 1. Principios Fundamentales

### 1.1 Arquitectura Hexagonal + Modular

El sistema sigue una **arquitectura hexagonal con organización modular**, implementada de forma progresiva dentro del mismo proyecto Laravel.

```
src/App/Modules/V2/
├── Auth/Authentication/       # Módulo de autenticación
├── User/                      # Módulo de usuarios
├── Client/                    # Módulo de clientes
│   ├── Client/
│   └── Headquarters/
├── Academic/                  # Módulo académico
│   └── Area/
└── Shared/                    # Kernel compartido
    ├── Application/           # Puertos, excepciones, seguridad
    ├── Domain/                # VOs, excepciones, enums, validators
    └── Infrastructure/        # Implementaciones concretas
```

Cada módulo contiene tres capas internas:

```
{Modulo}/
├── Domain/            # Entities, VOs, interfaces de puertos, DomainExceptions
├── Application/       # UseCases, DTOs de entrada/salida, contratos
└── Infrastructure/    # Adapters, Controllers, Validators, Persistence (Eloquent)
```

### 1.2 Evolución Incremental (No Reescritura)

- **Código legacy** (`app/`) convive temporalmente con la nueva arquitectura (`src/`).
- **Todo código nuevo** debe desarrollarse en `src/`.
- El código legacy solo se modifica cuando es estrictamente necesario.
- A largo plazo, `src/` será la base principal del sistema.

> 📎 ADR-001

### 1.3 Separación Estricta de Capas

```
┌──────────────────────────────────────────────────────┐
│                  INFRASTRUCTURE                       │
│  Controllers, Routes, Eloquent, Queue, Storage       │
├──────────────────────────────────────────────────────┤
│                  APPLICATION                          │
│  UseCases (orquestación), DTOs, Contratos             │
├──────────────────────────────────────────────────────┤
│                  DOMAIN                               │
│  Entities, ValueObjects, DomainExceptions, Puertos    │
│  (No depende de framework, ORM, ni transporte)        │
└──────────────────────────────────────────────────────┘
```

- El **dominio** no conoce HTTP, JSON, Eloquent ni Laravel.
- La **aplicación** orquesta flujos de negocio, no implementa detalles técnicos.
- La **infraestructura** implementa contratos definidos en capas superiores.

### 1.4 Shared Kernel

Código compartido entre módulos que no pertenece a un dominio específico:

| Carpeta | Contenido |
|---------|-----------|
| `Shared/Domain/Exceptions/` | `DomainException`, `InvalidArgumentException`, `ImmutableEntityException` |
| `Shared/Domain/ValueObjects/` | `DocumentNumberValueObject`, `FileReferenceValueObject`, `SmallIntValueObject` |
| `Shared/Domain/Validators/` | `ExistsValidatorInterface`, `UniqueValidatorInterface`, `ExistsByCompanyValidatorInterface` |
| `Shared/Domain/Enums/` | `DocumentType`, `Role`, `Permissions`, `InstitutionType`, `Plan`, `EducationLevel` |
| `Shared/Application/Exceptions/` | `ApplicationException`, `UnauthorizedException`, `ForbiddenException`, `NotFoundRecordException` |
| `Shared/Application/Ports/` | `TransactionManagerInterface`, `FileStorageInterface` |
| `Shared/Application/Security/` | `AuthUser`, `TokenValidatorInterface`, `CaptchaValidatorInterface`, `PasswordHasher` |
| `Shared/Application/UseCases/` | `TransactionalUseCase` |
| `Shared/Infrastructure/` | Implementaciones concretas de los contratos anteriores |

---

## 2. Capa de Dominio

### 2.1 Entidades

- **`final readonly class`** — no se extienden, no mutan después de creadas.
- La validación de invariantes ocurre en el **constructor**.
- No contienen lógica de persistencia ni referencias a ORM.
- Lanzan `DomainException` ante estados inválidos.

```php
// Ejemplo (src/App/Modules/V2/User/Domain/Entities/StoreUserEntity.php)
final readonly class StoreUserEntity
{
    public function __construct(
        private string $username,
        private string $email,
        private string $password,
        private int $companyId,
        private int $createdBy,
        private int $roleId,
        private ?int $id = null,
    ) {
        // Invariantes se validan aquí
        if (strlen($this->username) < 3) {
            throw new InvalidArgumentException('Username debe tener al menos 3 caracteres');
        }
    }

    public function getId(): ?int { return $this->id; }
    public function getUsername(): string { return $this->username; }
    public function getEmail(): string { return $this->email; }
    // ...
}
```

### 2.2 Value Objects

- **Inmutables**: `final readonly class`.
- Encapsulan validación y lógica de formato.
- Ubicados en `Shared/Domain/ValueObjects/` o en `{Modulo}/Domain/ValueObjects/`.

```php
// Ejemplo (src/Shared/Domain/ValueObjects/DocumentNumberValueObject.php)
final readonly class DocumentNumberValueObject
{
    public function __construct(public string $value)
    {
        if (!preg_match('/^[0-9]{8,11}$/', $this->value)) {
            throw new InvalidArgumentException('Número de documento inválido');
        }
    }
}
```

### 2.3 Domain Services

- Solo para lógica de negocio que **no pertenece a una entidad individual**.
- Sin estado, sin efectos secundarios, sin IO.
- Ejemplo: `CycleWeekPeriodCalculator`, `UsernameGenerator`.

### 2.4 Excepciones de Dominio

- Extienden `Src\Shared\Domain\Exceptions\DomainException`.
- Expresan **violaciones de reglas de negocio**.
- No conocen HTTP, JSON ni transporte.
- Se lanzan desde entidades, value objects y validators.

```php
// Ejemplo (src/Shared/Domain/Exceptions/DomainException.php)
class DomainException extends \RuntimeException
{
    public function __construct(string $message = '', int $code = 0, ?\Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);
    }
}
```

> 📎 ADR-003, ADR-007, ADR-009

---

## 3. Capa de Aplicación

### 3.1 Use Cases

**Regla principal**: todo Use Case debe cumplir TODOS estos requisitos:

| Regla | Obligatorio |
|-------|:-----------:|
| Clase `final` | ✅ |
| Única responsabilidad (una acción de negocio) | ✅ |
| Un único método público `execute()` | ✅ |
| Recibe un **DTO de entrada** (`RequestDto`) | ✅ |
| Retorna un **DTO de salida** (`ResponseDto`) o tipo primitivo simple | ✅ |
| No recibe `Request` de Laravel, Modelos Eloquent ni arrays | ❌ prohibido |
| No extiende clases base de UseCase | ❌ prohibido |
| No gestiona transacciones directamente | ❌ prohibido |

```php
// Ejemplo (src/App/Modules/V2/User/Application/UseCases/StoreUserUsecase.php)
final class StoreUserUsecase
{
    public function __construct(
        private UserReadRepositoryInterface $userReadRepositoryInterface,
        private UserWriteRepositoryInterface $userWriteRepositoryInterface,
        private ExistsValidatorInterface $existsValidatorInterface,
        private StoreEmployeeContract $storeEmployeeContract,
    ) {}

    public function execute(StoreUserRequestDto $storeUserRequestDto): StoreUserResponseDto
    {
        // 1. Generar username
        $storeUserRequestDto->username = $this->generateUsername(/* ... */);

        // 2. Crear usuario
        $storeUserEntity = $this->storeUser($storeUserRequestDto);

        // 3. Crear empleado
        $storeEmployeeEntity = $this->storeEmployee($storeUserRequestDto, $storeUserEntity->getId());

        return new StoreUserResponseDto(
            id: $storeUserEntity->getId(),
            username: $storeUserEntity->getUsername(),
            email: $storeUserEntity->getEmail(),
            employeeId: $storeEmployeeEntity->getId(),
        );
    }

    // Métodos privados para delegar pasos del flujo
    private function validator(StoreUserEntity $entity): void { /* ... */ }
    private function generateUsername(/* ... */): string { /* ... */ }
    private function storeUser(StoreUserRequestDto $dto): StoreUserEntity { /* ... */ }
    private function storeEmployee(StoreUserRequestDto $dto, int $userId): StoreEmployeeEntity { /* ... */ }
}
```

> 📎 ADR-002

### 3.2 DTOs (Data Transfer Objects)

**Entrada (`RequestDto`)**:
- `final readonly class`
- Propiedades tipadas
- Sin lógica de negocio
- Sin dependencias de infraestructura
- Nombrados con sufijo `RequestDto`

**Salida (`ResponseDto`)**:
- `final readonly class`
- Sin lógica de negocio
- No exponer Entities del dominio
- Nombrados con sufijo `ResponseDto`

```php
// Ejemplo DTO de entrada
final readonly class StoreUserRequestDto
{
    public function __construct(
        public string $names,
        public string $firstSurname,
        public string $secondSurname,
        public string $document,
        public ?string $username = null,
        public ?string $password = null,
        // ...
    ) {}
}

// Ejemplo DTO de salida
final readonly class StoreUserResponseDto
{
    public function __construct(
        public int $id,
        public string $username,
        public string $email,
        public int $employeeId,
        public bool $flStatus,
    ) {}
}
```

**Tipos primitivos permitidos como retorno**: solo `bool`, `int` en casos simples (conteos, validaciones puntuales).

> 📎 ADR-003

### 3.3 Transacciones

Los **Use Cases NO gestionan transacciones**. Se usa el wrapper `TransactionalUseCase`:

```php
// src/Shared/Application/UseCases/TransactionalUseCase.php
final class TransactionalUseCase
{
    public function __construct(
        private TransactionManagerInterface $txManager,
        private \Closure $useCase
    ) {}

    public function execute(mixed $dto): mixed
    {
        try {
            $this->txManager->begin();
            $result = ($this->useCase)($dto);
            $this->txManager->commit();
            return $result;
        } catch (\Throwable $e) {
            $this->txManager->rollback();
            throw $e;
        }
    }
}
```

> 📎 ADR-006

### 3.4 Responses y Serialización

- Los **Use Cases retornan DTOs de salida**, nunca Entities.
- Los **Controllers reciben DTOs** y los delegan a clases `Response` en Infra.
- Las **clases Response serializan DTOs → JSON** y no contienen lógica de negocio.
- Las **Entities nunca llegan a Controllers ni a Responses**.

```
Controller → RequestDto → UseCase → ResponseDto → Response → JSON
```

> 📎 ADR-010

---

## 4. Capa de Infraestructura

### 4.1 Puertos de Salida (Output Ports)

Toda interacción con persistencia usa **interfaces (puertos)** definidas en Domain o Application:

```php
// Interfaz en Domain (src/App/Modules/V2/User/Domain/Repositories/UserWriteRepositoryInterface.php)
interface UserWriteRepositoryInterface
{
    public function create(StoreUserEntity $entity): ?StoreUserEntity;
    public function update(UpdateUserEntity $entity): ?UpdateUserEntity;
    public function delete(int $id): bool;
    public function storeRol(int $userId, int $roleId, int $createdBy): void;
}
```

**Implementaciones** en Infraestructura:

```php
// src/App/Modules/V2/User/Infrastructure/Persistences/QueryBuilder/Write/UserWriteQueryBuilder.php
class UserWriteQueryBuilder implements UserWriteRepositoryInterface
{
    public function create(StoreUserEntity $entity): ?StoreUserEntity
    {
        $id = DB::table('users')->insertGetId([...]);
        return new StoreUserEntity(/* ... */, id: $id);
    }
}
```

**Binding** via ServiceProvider:

```php
// src/App/Modules/V2/User/Infrastructure/Providers/UserProvider.php
$this->app->singleton(UserWriteRepositoryInterface::class, UserWriteQueryBuilder::class);
$this->app->singleton(UserReadRepositoryInterface::class, UserReadQueryBuilder::class);
```

> 📎 ADR-004

### 4.2 CQRS en Capa de Persistencia

Separación explícita de **lectura** y **escritura** a nivel de repositorios:

| Repositorio | Opera con | Retorna | Modifica estado |
|-------------|-----------|---------|:---------------:|
| **Write** | Entities (Domain) | Entities o void | ✅ |
| **Read** | Proyecciones/DTOs | DTOs de consulta, colecciones | ❌ |
| **Validator** | Datos de validación | bool, IDs | ❌ |

```
{Modulo}/Domain/Repositories/
├── Read/{Modulo}ReadRepositoryInterface.php
├── Write/{Modulo}WriteRepositoryInterface.php
└── Validator/{Modulo}ValidatorRepository.php
```

**NO se adopta CQRS completo** (sin eventos, comandos ni modelos de lectura separados). Solo separación de responsabilidades en persistencia.

> 📎 ADR-008

### 4.3 Comunicación Entre Módulos

- **Prohibida** la dependencia directa entre dominios de distintos módulos.
- La comunicación se realiza mediante **contratos (interfaces)** ubicados en `Infrastructure` del módulo consumidor.
- Los **adaptadores** implementan el contrato y traducen datos entre módulos.
- Solo se cruzan **DTOs específicos** y valores primitivos.

```
Módulo A (Infrastructure)                    Módulo B (Infrastructure)
┌─────────────────────────────┐             ┌─────────────────────────────┐
│ Employee/Application/       │             │                             │
│   Contracts/                │  implements │ StoreEmployeeAdapter        │
│   StoreEmployeeContract ◄───┼─────────────┤ (llama al UseCase de B)     │
└─────────────────────────────┘             └─────────────────────────────┘
```

```php
// src/App/Modules/V2/Employee/Application/Contracts/StoreEmployeeContract.php
interface StoreEmployeeContract
{
    public function storeEmployee(StoreEmployeeRequestDto $dto): StoreEmployeeEntity;
}
```

- **No permitido**: Entities de otro módulo, repositorios de otro módulo, servicios de dominio de otro módulo.

> 📎 ADR-005

---

## 5. Manejo de Errores y Excepciones

### 5.1 Clasificación de Errores

| Capa | Excepción Base | Significado | Ejemplos |
|------|---------------|-------------|----------|
| **Domain** | `DomainException` | Violación de regla de negocio | Usuario duplicado, entidad inmutable, estado inválido |
| **Application** | `ApplicationException` | Fallo en orquestación del caso de uso | Recurso no encontrado, sin permisos, sin autenticación |
| **Infrastructure** | `DatabaseException`, `QueryException` | Fallo técnico | Error de BD, red, servicio externo |

### 5.2 Reglas de Uso

- Use Cases **lanzan excepciones**, nunca retornan `null` ni códigos de error.
- El manejo y traducción a HTTP ocurre en el **Exception Handler**:

```php
// src/Http/Exceptions/Handler.php
```

### 5.3 Mapeo HTTP

| Excepción | HTTP | Uso |
|-----------|------|-----|
| `DomainException` | **409 Conflict** | Reglas de negocio violadas |
| `RequestValidationException` | **422 Unprocessable Entity** | Datos de entrada inválidos |
| `UnauthorizedException` | **401 Unauthorized** | No autenticado |
| `ForbiddenException` | **403 Forbidden** | Autenticado pero sin permisos |
| `NotFoundRecordException` | **404 Not Found** | Recurso no existe |
| `ApplicationException` | **400 Bad Request** | Error genérico de aplicación |
| `Exception` (fallback) | **500 Internal Server Error** | Error no controlado |

> 📎 ADR-007

---

## 6. Validaciones de Dominio con Acceso a Persistencia

### 6.1 Domain Validators

Para reglas de negocio que requieren consultar la base de datos:

- Se definen **interfaces** en el dominio (`Validators/`).
- La implementación concreta está en infraestructura (`Persistences/QueryBuilder/Validators/`).
- Se invocan desde el **Use Case** antes de persistir.
- Lanzan `DomainException` ante fallos.

```php
// src/Shared/Domain/Validators/ExistsValidatorInterface.php
interface ExistsValidatorInterface
{
    public function exists(string $table, string $value, string $column = 'id'): bool;
}

// src/App/Modules/V2/Client/Headquarters/Domain/Repositories/Validator/HeadquarterValidatorRepository.php
interface HeadquarterValidatorRepository
{
    public function existsByCompanyId(int $id, int $companyId): bool;
}

// Implementación en Infra:
// src/Shared/Infrastructure/Persistences/QueryBuilder/Validators/ExistsValidatorQueryBuilder.php
// src/App/Modules/V2/Client/Headquarters/Infrastructure/Persistences/QueryBuilder/Validator/HeadquarterValidatorQueryBuilder.php
```

**Uso en Use Case:**

```php
public function execute(StoreUserRequestDto $dto): StoreUserResponseDto
{
    $entity = new StoreUserEntity(/* ... */);

    // Validación de negocio con acceso a persistencia
    if ($this->existsValidator->exists('users', $entity->getUsername(), 'user')) {
        throw new DomainException('El username ya existe.');
    }

    return $this->repository->create($entity);
}
```

> 📎 ADR-009

---

## 7. Estándares de Testing

### 7.1 Estructura de Directorios

```
tests/
├── Builders/                              # Builders transcontextuales (persisten en DB)
│   ├── BaseBuilder.php                    # Abstract: makeData() + insert() + fluent API
│   └── Context/
│       ├── Admin/                         # DB Builders contexto Admin
│       └── Client/                        # DB Builders contexto Client
├── Context/
│   ├── Admin/
│   │   └── {Modulo}/
│   │       ├── Builders/                  # Payload/Entity/DTO Builders (in-memory)
│   │       │   ├── {Modulo}PayloadBuilder.php
│   │       │   ├── {Modulo}EntityBuilder.php
│   │       │   └── {Modulo}RequestDtoBuilder.php
│   │       ├── Feature/Http/             # Tests de Controller (HTTP real)
│   │       └── Unit/
│   │           ├── Application/          # Tests de Use Cases (con mocks)
│   │           └── Domain/               # Tests de entidades (sin mocks)
│   └── Client/
│       └── {Modulo}/
│           └── (misma estructura)
├── Pest.php                               # Helpers globales (apiCallWithCookie, etc.)
└── TestCase.php
```

### 7.2 Configuración PHPUnit

```xml
<!-- phpunit.xml -->
<testsuites>
    <testsuite name="Context Admin">
        <directory>tests/Context/Admin</directory>
    </testsuite>
    <testsuite name="Partners Test Suite">
        <directory suffix="Test.php">src/App/Partners</directory>
    </testsuite>
</testsuites>
<php>
    <env name="APP_ENV" value="testing"/>
    <env name="BCRYPT_ROUNDS" value="4"/>
    <env name="CACHE_DRIVER" value="array"/>
    <env name="MAIL_MAILER" value="array"/>
    <env name="QUEUE_CONNECTION" value="sync"/>
    <env name="SESSION_DRIVER" value="array"/>
    <env name="TELESCOPE_ENABLED" value="false"/>
</php>
```

### 7.3 Patrones por Tipo de Test

#### A. Tests de Entidad (Domain) — Sin Mocks

```php
declare(strict_types=1);

describe('UpdateCycleEntity', function () {
    function updateEntity(array $overrides = []): UpdateCycleEntity
    {
        return new UpdateCycleEntity(
            code:        $overrides['code']        ?? 'ABCD',
            description: $overrides['description'] ?? 'Ciclo A',
        );
    }

    it('se crea correctamente con datos válidos', function () {
        $entity = updateEntity();
        expect($entity->getCode())->toBe('ABCD');
    });

    it('rechaza código demasiado corto', function () {
        updateEntity(['code' => 'AB']);
    })->throws(InvalidArgumentException::class);
});
```

#### B. Tests de Use Case (Application) — Con Mocks

```php
declare(strict_types=1);

describe('UpdateCycleUseCase', function () {
    function makeDto(array $overrides = []): UpdateCycleRequestDto { /* ... */ }

    beforeEach(function () {
        $this->repository = Mockery::mock(CycleWriteRepository::class);
        $this->validator  = Mockery::mock(CycleValidatorRepository::class);
        $this->useCase = new UpdateCycleUseCase($this->repository, $this->validator);
    });

    it('actualiza el ciclo cuando todo es válido', function () {
        $dto = makeDto();
        $this->validator->shouldReceive('isSameRecord')->once()->andReturn(false);

        $this->repository
            ->shouldReceive('update')
            ->once()
            ->withArgs(function (UpdateCycleEntity $entity) {
                expect($entity->getCode())->toBe('ABCD');
                return true;
            });

        $this->useCase->execute($dto);
    });

    it('lanza excepción cuando el nombre ya existe', function () {
        $dto = makeDto();
        $this->validator->shouldReceive('isSameRecord')->once()->andReturn(true);

        $this->useCase->execute($dto);
    })->throws(DomainException::class);
});
```

#### C. Tests de Controller (Feature/Http)

```php
declare(strict_types=1);

describe('StoreRoleController', function () {
    it('crea un rol correctamente', function () {
        [$user, $token] = (new UserBuilder())
            ->create()
            ->withPermissions(['rol.crear'])
            ->build();

        $response = apiCallWithCookie($this, 'POST', '/api/v2/auth/role/', [
            'name' => 'Rol de prueba',
        ], $token);

        $response->assertStatus(200);
        $response->assertJson([
            'success' => true,
            'data' => ['name' => 'Rol de prueba'],
        ]);
    });
});
```

### 7.4 Reglas Obligatorias para Tests

| Regla | Por qué |
|-------|---------|
| `declare(strict_types=1)` en todos los tests | PHPStan nivel máximo exige consistencia |
| Nombres en español, minúscula, describir comportamiento | Legible, predecible para agents |
| `Mockery::mock(Interface::class)`, nunca clases concretas | Aísla el test |
| Especificar count en `shouldReceive` (`->once()`, `->twice()`, `->never()`) | Documenta expectativas |
| Usar `beforeEach` para mocks, no repetirlos en cada test | Evita errores por mocks faltantes |
| No usar `ordered()` por defecto | Tests frágiles que se rompen sin cambiar comportamiento |
| `assertJson()` para flujo feliz (valores exactos) | Verifica respuesta completa |
| `assertJsonStructure()` para estructura sin importar valores | Listas, colecciones |

### 7.5 Builders (ADR-013)

**BaseBuilder** (persiste en DB):

```php
abstract class BaseBuilder
{
    protected int $count = 1;
    protected array $overrides = [];
    protected array $records = [];

    public function count(int $count): static
    public function with(array $overrides): static
    public function create(): static
    public function get(): array
    public function first(): ?object

    abstract protected function makeData(): array;
    abstract protected function insert(array $data): int;
}
```

**PayloadBuilder** (in-memory, para HTTP/DTOs): `static buildStore(array $overrides = []): array`

**EntityBuilder** (in-memory, para Unit tests): `static buildEntity(array $overrides = []): {Entity}`

**Regla**: `tests/Pest.php` solo contiene helpers de utilidad general (`apiCallWithCookie()`). Nada específico de módulo.

### 7.6 Cobertura y Ejecución

| Tipo | Cobertura mínima | Falla pipeline si < umbral |
|------|:----------------:|:--------------------------:|
| Domain (Unit) | **80%** | ✅ Sí |
| Application (Unit) | **70%** | ✅ Sí |
| Feature (HTTP) | **60%** | ✅ Sí |

```bash
# Ejecución local
php vendor/bin/pest --parallel

# Ejecución con cobertura
php vendor/bin/pest --parallel --coverage --min=70

# Por suite específica
php vendor/bin/pest --testsuite="Context Admin"
```

> 📎 ADR-011, ADR-012, ADR-013

---

## 8. Base de Datos: PostgreSQL 16

### 8.1 Versión y Entorno

- **Versión obligatoria**: PostgreSQL **16** (LTS hasta 2028-11-09).
- En CI/CD se usa la imagen `postgres:16-alpine` como service container.
- Driver PHP: `pgsql` (incluido en `php8.1-pgsql`).

### 8.2 Arquitectura de Conexiones

El sistema usa **dos conexiones PostgreSQL**: una para escritura (master) y otra para lectura (standby).

```php
// config/database.php
'default' => env('DB_CONNECTION_MASTER', 'pgsql_stand_by'),

'connections' => [
    'pgsql_master' => [
        'driver'      => 'pgsql',
        'host'        => env('DB_HOST_MASTER', '127.0.0.1'),
        'port'        => env('DB_PORT_MASTER', '5432'),
        'database'    => env('DB_DATABASE_MASTER', 'master_db'),
        'username'    => env('DB_USERNAME_MASTER', 'postgres'),
        'password'    => env('DB_PASSWORD_MASTER', 'postgres'),
        'charset'     => 'utf8',
        'schema'      => 'odiseo',
        'search_path' => 'odiseo',
    ],
    'pgsql_stand_by' => [
        'driver'      => 'pgsql',
        'host'        => env('DB_HOST_STAND_BY', '127.0.0.1'),
        'port'        => env('DB_PORT_STAND_BY', '5432'),
        'database'    => env('DB_DATABASE_STAND_BY', 'stand_by_db'),
        'username'    => env('DB_USERNAME_STAND_BY', 'postgres'),
        'password'    => env('DB_PASSWORD_STAND_BY', 'postgres'),
        'charset'     => 'utf8',
        'schema'      => 'odiseo',
        'search_path' => 'odiseo',
    ],
],
```

### 8.3 Esquema

- **Esquema único**: `odiseo` (todas las tablas dentro de este schema).
- Configurado en `search_path` para que las queries no necesiten prefijo.
- Evita colisiones con tablas de sistema o extensiones en `public`.

### 8.4 Migraciones

- **Versionadas**: `yyyy_mm_dd_hhmmss_descripcion.php`.
- **Reversibles**: todo `up()` debe tener `down()` funcional.
- **1 migración por PR** (agrupar cambios relacionados).
- **Probar en CI**: `php artisan migrate:fresh` + seeders de test antes de `pest`.
- **No usar `DB::statement()` directamente** en migraciones sin revisión.
- Schema explícito: `Schema::connection('pgsql_master')`.

### 8.5 Índices

| Tipo | Cuándo usarlo |
|------|---------------|
| **B-tree** (default) | Foreign keys, columnas de búsqueda frecuente, ordenamiento |
| **GIN** | Columnas JSONB, búsquedas full-text, arrays |
| **Partial index** | Filtrar por condición común (`WHERE deleted_at IS NULL`) |
| **Composite index** | Queries que filtran por múltiples columnas juntas |

```sql
-- Ejemplo: índice GIN para JSONB
CREATE INDEX idx_questions_metadata ON odiseo.questions USING GIN (metadata jsonb_path_ops);

-- Ejemplo: partial index para soft deletes
CREATE INDEX idx_users_active ON odiseo.users (email) WHERE deleted_at IS NULL;
```

### 8.6 Particionado

Tablas con proyección de >100 millones de registros deben considerar **particionado nativo de PostgreSQL 16**:

```sql
-- Particionado por RANGE (ej: partición anual)
CREATE TABLE odiseo.audit_logs (
    id BIGSERIAL,
    user_id INT,
    action TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
) PARTITION BY RANGE (created_at);

CREATE TABLE odiseo.audit_logs_2026 PARTITION OF odiseo.audit_logs
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
```

### 8.7 Extensiones Permitidas

| Extensión | Uso |
|-----------|-----|
| `uuid-ossp` | Generación de UUIDs (`uuid_generate_v4()`) |
| `pg_trgm` | Búsqueda de texto con trigramas (`ILIKE` optimizado) |
| `btree_gin` | Índices GIN con operadores B-tree |
| `citext` | Columnas de texto case-insensitive (ej: emails) |

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA odiseo;
CREATE EXTENSION IF NOT EXISTS "pg_trgm" SCHEMA odiseo;
CREATE EXTENSION IF NOT EXISTS "citext" SCHEMA odiseo;
```

### 8.8 Convenciones de Naming

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| Base de datos | `snake_case` en inglés | `odiseo_production` |
| Esquema | Fijo: `odiseo` | `odiseo` |
| Tablas | `snake_case`, plural en inglés | `users`, `exam_questions` |
| Columnas | `snake_case`, singular en inglés | `created_at`, `user_id`, `fl_status` |
| Foreign keys | `{tabla_singular}_id` | `user_id`, `company_id`, `charge_id` |
| Índices | `idx_{tabla}_{columna(s)}` | `idx_users_email`, `idx_questions_status_created` |
| Constraints FK | `fk_{tabla_origen}_{tabla_destino}` | `fk_employees_user_id` |
| Triggers | `trg_{tabla}_{accion}_{evento}` | `trg_users_set_updated_at` |
| Secuencias | Dejar el default de PostgreSQL | `users_id_seq` |

### 8.9 Soft Deletes

- Usar **`deleted_at TIMESTAMPTZ NULL`** (no boolean `fl_status` para eliminación).
- `deleted_at IS NULL` = registro activo.
- `fl_status` se usa para activación/desactivación funcional, no para borrado lógico.

```php
// Migración
$table->softDeletes(); // Crea deleted_at TIMESTAMPTZ NULL

// Índice parcial recomendado
// CREATE INDEX idx_users_active ON odiseo.users (id) WHERE deleted_at IS NULL;
```

### 8.10 Auditoría

Tablas críticas deben tener **triggers de auditoría** que registren cambios en `odiseo.audit_logs`:

```sql
CREATE TABLE odiseo.audit_logs (
    id BIGSERIAL PRIMARY KEY,
    table_name TEXT NOT NULL,
    record_id INT NOT NULL,
    action TEXT NOT NULL,        -- 'INSERT', 'UPDATE', 'DELETE'
    old_data JSONB,
    new_data JSONB,
    changed_by INT,
    changed_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_audit_logs_table_record ON odiseo.audit_logs (table_name, record_id);
```

---

## 9. Frontend: Convenciones y Estándares

### 9.1 Stack Tecnológico

| Componente | Tecnología | Versión |
|------------|-----------|---------|
| Framework | Vue 3 (Composition API) | ^3.4 |
| Build | Vite | ^5.4 |
| UI Framework | Vuetify 3 | ^3.6 |
| State Management | Pinia | ^2.1 |
| Router | Vue Router (lazy-loaded, file-based) | ^4.4 |
| HTTP Client | Axios (con interceptors centralizados) | ^1.12 |
| Package Manager | **pnpm** | ^8.6 |
| TypeScript | Strict mode (en módulos nuevos) | — |
| Testing | Vitest | ^2.1 |

### 9.2 Estructura del Proyecto

```
odiseo-frontend/src/
├── @core/                  # Utilidades del template base
│   └── utils/plugins.js    # Registro automático de plugins
├── assets/                 # Estilos, imágenes, sonidos estáticos
├── components/             # Componentes compartidos globales
├── composables/            # Lógica reactiva reutilizable (use*)
├── directives/             # Directivas Vue globales
├── layouts/                # Layouts (DefaultLayoutWithVerticalNav)
├── modules/                # Módulos feature-based
│   ├── question-tracking/  # Ejemplo de módulo
│   │   ├── models/         # Tipos, interfaces, parámetros
│   │   ├── pages/          # Componentes de página (.page.vue)
│   │   ├── services/       # Clase de servicio API
│   │   ├── dialogs/        # Componentes de diálogo
│   │   ├── enums/          # Constantes y enumeraciones
│   │   ├── data/           # Headers de tabla, config estática
│   │   └── routes.ts       # Definición de rutas del módulo
│   └── courses-areas/      # Otro módulo
├── plugins/                # Plugins Vue (vuetify, router, pinia, iconify)
├── services/
│   └── axios.js            # Cliente HTTP centralizado
├── App.vue                 # Componente raíz
└── main.js                 # Entry point
```

### 9.3 Servicios API

Cada módulo expone **una clase de servicio** que encapsula las llamadas HTTP:

```ts
// src/modules/courses-areas/services/courses-areas.service.ts
import { odiseoApi } from '@/services/axios';
import { SearchParams } from '../models/search-params.model';

class CoursesAreasService {
    async getAreasList(parameters: SearchParams) {
        const url = objectToUrlSearchParams("academic/area", parameters)
        const { data } = await odiseoApi.get(`${import.meta.env.VITE_API_URL}/v2${url}`)
        return data
    }

    async createArea(parameters) {
        const { data } = await odiseoApi.post(`${import.meta.env.VITE_API_URL}/v2/academic/area`, parameters)
        return data
    }

    async deleteArea(areaId: number) {
        const { data } = await odiseoApi.delete(`${import.meta.env.VITE_API_URL}/v2/academic/area/${areaId}`)
        return data
    }
}

export default new CoursesAreasService()
```

**Reglas**:
- 1 archivo de servicio por módulo.
- Exportar instancia singleton (`export default new ...`).
- No exponer lógica de negocio, solo transporte HTTP.
- Tipar parámetros con modelos/ interfaces del módulo.

### 9.4 Cliente HTTP (Axios)

```js
// src/services/axios.js
export const odiseoApi = axios.create({
    baseURL: `${import.meta.env.VITE_API_URL}/v1`,
    withCredentials: true,
})

odiseoApi.interceptors.response.use(response => response, error => {
    if (error.response?.status === 401) {
        localStorage.removeItem('user')
        localStorage.removeItem('userAbilityRules')
        location.reload()
    }
    if (error.response?.status === 413) {
        window.dispatchEvent(new CustomEvent('too-large-response', { detail: error.response.data }))
    }
    if (error.response?.status === 504) {
        window.dispatchEvent(new CustomEvent('gateway-time-out', { detail: 'Tiempo de espera agotado' }))
    }
    return Promise.reject(error)
})
```

**Reglas**:
- No crear instancias de axios adicionales por módulo. Usar `odiseoApi`.
- No hacer redirects manuales — usar eventos globales.
- Interceptors centralizados en `@/services/axios.js`.

### 9.5 Routing

- **Lazy-loaded** por módulo: `() => import('@/modules/{modulo}/pages/{Page}.vue')`.
- **File-based routing** gestionado por `unplugin-vue-router`.
- Cada módulo define sus rutas en `{modulo}/routes.ts`.

```ts
// src/modules/question-tracking/routes.ts
export default [
    {
        path: '/question-tracking',
        component: () => import('./pages/QuestionsTracking.page.vue'),
        meta: { requiresAuth: true },
    },
]
```

### 9.6 State Management (Pinia)

- 1 store por funcionalidad o dominio compartido.
- Composición API style (`defineStore` con setup function).
- No almacenar datos de formulario en stores (usar estado local del componente).

### 9.7 Composables

- Prefijo `use*` (ej: `useSwalAlert`, `useCKEditor5`, `useImgCompress`).
- Lógica reactiva, reutilizable entre componentes.
- Ubicados en `src/composables/`.

### 9.8 Monitoreo y Errores (Sentry)

```js
// src/main.js
Sentry.init({
    app,
    dsn: import.meta.env.VITE_SENTRY_DSN || '',
    environment: import.meta.env.VITE_SENTRY_ENVIRONMENT || 'local',
    release: __APP_VERSION__,
    integrations: [Sentry.browserTracingIntegration(), Sentry.replayIntegration()],
    tracesSampleRate: isProduction ? 0.1 : 1.0,
    profilesSampleRate: isProduction ? 0.1 : 1.0,
    replaysSessionSampleRate: isProduction ? 0.01 : 1.0,
    replaysOnErrorSampleRate: 1.0,
})
```

- Ignorar `ChunkLoadError` (versión desactualizada del bundle).
- Filtrar errores de terceros (sin frames `in_app`).
- Setear usuario (`Sentry.setUser()`) tras login.

### 9.9 Docker y Despliegue

**Desarrollo** (`dev.Dockerfile`):
- Base `node:lts`, pnpm install, `pnpm dev --host`.
- Hot reload via volumen montado.

**Producción** (`prod.Dockerfile`):
- **Multi-stage build**: `node:18` builder → `nginx:stable-alpine`.
- pnpm install → pnpm build → copiar `dist/` a `/usr/share/nginx/html`.
- Configuración nginx personalizada en `nginx.conf`.
- Puerto 80.

---

## 10. Pipeline GitLab CI/CD

### 10.1 Stages

```yaml
stages:
  - lint
  - test
  - build
  - security
  - deploy
```

```
lint ──► test ──► build ──► security ──► deploy
                          (manual: staging)
                          (manual: production + approval)
```

### 10.2 Jobs del Pipeline

#### Stage: `lint`

```yaml
backend:lint:
  stage: lint
  image: php:8.1-cli
  before_script:
    - apt-get update && apt-get install -y libpq-dev libzip-dev
    - docker-php-ext-install pdo_pgsql zip
    - php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    - php composer-setup.php
    - php composer.phar install --no-interaction --prefer-dist
  script:
    - php vendor/bin/phpstan analyse --configuration=phpstan.neon --level=max
  only:
    - merge_requests
    - develop

frontend:lint:
  stage: lint
  image: node:18-alpine
  before_script:
    - corepack enable && corepack prepare pnpm@8.6.2 --activate
    - pnpm install --frozen-lockfile
  script:
    - pnpm run lint
    - pnpm run typecheck  # si existe script typecheck
  only:
    - merge_requests
    - develop
```

#### Stage: `test`

```yaml
backend:test:
  stage: test
  image: php:8.1-cli
  services:
    - name: postgres:16-alpine
      alias: postgres
  variables:
    DB_CONNECTION_MASTER: pgsql
    DB_HOST_MASTER: postgres
    DB_PORT_MASTER: "5432"
    DB_DATABASE_MASTER: odiseo_test
    DB_USERNAME_MASTER: postgres
    DB_PASSWORD_MASTER: postgres
    APP_ENV: testing
  before_script:
    - apt-get update && apt-get install -y libpq-dev libzip-dev
    - docker-php-ext-install pdo_pgsql zip
    - php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    - php composer-setup.php
    - php composer.phar install --no-interaction --prefer-dist
    - php artisan migrate:fresh
    - php artisan db:seed --class=TestSeeder
  script:
    - php vendor/bin/pest --parallel --coverage --min=70
    # Tests legacy (phpunit)
    - php vendor/bin/phpunit --testsuite="Partners Test Suite"
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
  only:
    - merge_requests
    - develop

frontend:test:
  stage: test
  image: node:18-alpine
  before_script:
    - corepack enable && corepack prepare pnpm@8.6.2 --activate
    - pnpm install --frozen-lockfile
  script:
    - pnpm run test -- --coverage
  only:
    - merge_requests
    - develop
```

#### Stage: `build`

```yaml
backend:build:
  stage: build
  image: docker:24-dind
  services:
    - docker:24-dind
  variables:
    DOCKER_HOST: tcp://docker:2375
    DOCKER_TLS_CERTDIR: ""
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - docker build -f Dockerfile.prod -t $CI_REGISTRY_IMAGE/backend:$CI_COMMIT_SHORT_SHA .
    - docker push $CI_REGISTRY_IMAGE/backend:$CI_COMMIT_SHORT_SHA
    - docker tag $CI_REGISTRY_IMAGE/backend:$CI_COMMIT_SHORT_SHA $CI_REGISTRY_IMAGE/backend:latest
    - docker push $CI_REGISTRY_IMAGE/backend:latest
  only:
    - develop
    - staging
    - main

frontend:build:
  stage: build
  image: docker:24-dind
  services:
    - docker:24-dind
  variables:
    DOCKER_HOST: tcp://docker:2375
    DOCKER_TLS_CERTDIR: ""
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - cd odiseo-frontend
    - docker build -f prod.Dockerfile -t $CI_REGISTRY_IMAGE/frontend:$CI_COMMIT_SHORT_SHA .
    - docker push $CI_REGISTRY_IMAGE/frontend:$CI_COMMIT_SHORT_SHA
    - docker tag $CI_REGISTRY_IMAGE/frontend:$CI_COMMIT_SHORT_SHA $CI_REGISTRY_IMAGE/frontend:latest
    - docker push $CI_REGISTRY_IMAGE/frontend:latest
  only:
    - develop
    - staging
    - main
```

#### Stage: `security`

```yaml
security:scan:
  stage: security
  image: aquasec/trivy:latest
  script:
    - trivy image --severity HIGH,CRITICAL --exit-code 1 $CI_REGISTRY_IMAGE/backend:$CI_COMMIT_SHORT_SHA
    - trivy image --severity HIGH,CRITICAL --exit-code 1 $CI_REGISTRY_IMAGE/frontend:$CI_COMMIT_SHORT_SHA
  only:
    - develop
    - staging
    - main
```

#### Stage: `deploy`

```yaml
deploy:develop:
  stage: deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache openssh-client
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan -H $DEV_HOST >> ~/.ssh/known_hosts
  script:
    - ssh $DEV_USER@$DEV_HOST "cd /opt/odiseo && docker-compose -f docker-compose.dev.yml pull && docker-compose -f docker-compose.dev.yml up -d"
  environment:
    name: develop
    url: https://dev.odiseo.app
  only:
    - develop

deploy:staging:
  stage: deploy
  image: alpine:latest
  when: manual
  before_script:
    - apk add --no-cache openssh-client
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan -H $STAGING_HOST >> ~/.ssh/known_hosts
  script:
    - ssh $STAGING_USER@$STAGING_HOST "cd /opt/odiseo && docker-compose -f docker-compose.prod.yml pull && docker-compose -f docker-compose.prod.yml up -d"
  environment:
    name: staging
    url: https://staging.odiseo.app
  only:
    - staging

deploy:production:
  stage: deploy
  image: alpine:latest
  when: manual
  before_script:
    - apk add --no-cache openssh-client
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan -H $PROD_HOST >> ~/.ssh/known_hosts
  script:
    - ssh $PROD_USER@$PROD_HOST "cd /opt/odiseo && docker-compose -f docker-compose.prod.yml pull && docker-compose -f docker-compose.prod.yml up -d"
  environment:
    name: production
    url: https://odiseo.app
  rules:
    - if: $CI_COMMIT_TAG =~ /^v\d+\.\d+\.\d+$/
      when: manual
```

### 10.3 Variables CI/CD (protegidas por environment)

| Variable | Scope | Descripción |
|----------|-------|-------------|
| `DB_HOST_MASTER` | develop, staging, production | Host de la BD master |
| `DB_PASSWORD_MASTER` | develop, staging, production | Password BD master |
| `SSH_PRIVATE_KEY` | develop, staging, production | Clave SSH para deploy |
| `DEV_HOST` / `STAGING_HOST` / `PROD_HOST` | Por environment | IP/hostname del server |
| `VITE_SENTRY_DSN` | production | DSN de Sentry |
| `SENTRY_LARAVEL_DSN` | production | DSN backend |

### 10.4 Estrategia de Rollback

- **Tag-based rollback**: al detectar un fallo en deploy, crear tag `rollback-<YYYYMMDD-HHMMSS>`.
- Esto dispara un pipeline manual que hace deploy de la imagen anterior (`latest-1` o tag específico).
- Las migraciones deben ser **reversibles** para permitir `migrate:rollback`.

```yaml
rollback:
  stage: deploy
  when: manual
  script:
    - ssh $TARGET_USER@$TARGET_HOST "docker-compose -f docker-compose.prod.yml up -d --force-recreate"
```

### 10.5 Notificaciones

- **Slack/Teams** en fallo de pipeline (integración nativa de GitLab).
- **MR comments** con reporte de cobertura y resultados de lint.
- **Sentry release tracking**: `SENTRY_AUTH_TOKEN` + `sentry-cli releases new`.

---

## 11. Convenciones Transversales

### 11.1 Naming

| Contexto | Idioma | Ejemplo |
|----------|--------|---------|
| Dominio / Negocio | **Español** | `Usuario`, `Pregunta`, `Curso`, `Sede` |
| Patrones arquitectónicos | **Inglés** | `UseCase`, `Repository`, `Adapter`, `Entity`, `DTO` |
| Clases / Métodos PHP | **Inglés** (PascalCase/camelCase) | `StoreUserUseCase`, `getUsername()` |
| Tablas / Columnas DB | **Inglés** (snake_case) | `users`, `created_at` |
| Tests | **Español** (descripciones) | `it('crea un usuario correctamente')` |
| Commits | **Inglés** (Conventional Commits) | `feat(user): add username generation` |
| Branches | **Inglés** (kebab-case) | `feat/add-user-search`, `fix/login-timeout` |

### 11.2 Tipado Estricto

**PHP**:
- Todo archivo `.php` debe comenzar con `declare(strict_types=1);`
- PHPStan nivel máximo (`phpstan.neon` + `phpstan.src.neon`).
- No suprimir warnings de tipo sin justificación documentada.

**TypeScript**:
- `strict: true` en `tsconfig.json` para nuevos módulos.
- Evitar `any` — usar `unknown` o tipos genéricos.

### 11.3 Linting y Formateo

| Herramienta | Contexto | Configuración |
|-------------|----------|---------------|
| PHPStan | Backend | `phpstan.neon` (nivel max) + `phpstan.src.neon` |
| Laravel Pint | Backend | `laravel/pint` (PSR-12 + Laravel) |
| ESLint | Frontend | `.eslintrc.cjs` (config extendida) |
| Prettier | Frontend | Formato automático (`pnpm format`) |
| Stylelint | Frontend | CSS/SCSS linting |

### 11.4 Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

| Type | Uso |
|------|-----|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `refactor` | Refactor sin cambio de comportamiento |
| `test` | Tests nuevos o modificados |
| `docs` | Documentación |
| `chore` | Tareas de build, CI, dependencias |
| `perf` | Mejora de rendimiento |

Ejemplos:
```
feat(user): add username auto-generation
fix(material): correct PDF margin calculation
refactor(question): extract validator to domain
```

### 11.5 Branches

| Rama | Propósito |
|------|-----------|
| `main` | Producción. Solo merge vía MR aprobado + tag |
| `staging` | Pre-producción. Deploy manual a entorno staging |
| `develop` | Integración. Deploy automático a entorno dev |
| `feat/*` | Nuevas funcionalidades |
| `fix/*` | Correcciones de bugs |
| `refactor/*` | Refactors |

### 11.6 Merge Requests

Usar template `.gitlab/merge_request_templates/WithCodeReview.md` que incluye checklist de:

- Backend (endpoints, DTOs, errores)
- Base de Datos (migraciones, índices)
- Diseño y arquitectura (capas, dependencias)
- Seguridad y rendimiento
- Testing

---

## 12. Gobernanza y Evolución

### 12.1 ADRs (Architecture Decision Records)

- Toda decisión arquitectónica significativa debe documentarse como ADR en `docs/adr/`.
- Plantilla: Título, Estado, Fecha, Contexto, Opciones, Decisión, Justificación, Consecuencias.
- Los ADRs son **historial**, la Constitución es **referencia activa**.

### 12.2 Revisión de la Constitución

- **Trimestral**: revisar vigencia de reglas, actualizar con nuevos ADRs.
- **Al crear un nuevo módulo**: verificar que cumple todas las secciones aplicables.
- **Post-incidente**: documentar lecciones aprendidas y ajustar si es necesario.

### 12.3 Excepciones

- Toda violación a esta Constitución debe documentarse como excepción temporal con:
  - Justificación
  - Fecha de revisión
  - Issue/ticket asociado

---

## 13. Anexo: Trazabilidad ADR → Constitución

| ADR | Título | Sección(es) Constitución |
|-----|--------|-------------------------|
| 001 | Implementación nueva arquitectura en `src/` | [1](#1-principios-fundamentales) |
| 002 | Definición y reglas de Use Cases | [3.1](#31-use-cases) |
| 003 | Uso de DTOs | [3.2](#32-dtos-data-transfer-objects) |
| 004 | Puertos de salida para persistencia | [4.1](#41-puertos-de-salida-output-ports) |
| 005 | Comunicación entre módulos | [4.3](#43-comunicación-entre-módulos) |
| 006 | Manejo de transacciones | [3.3](#33-transacciones) |
| 007 | Manejo de errores y excepciones | [5](#5-manejo-de-errores-y-excepciones) |
| 008 | CQRS en capa de persistencia | [4.2](#42-cqrs-en-capa-de-persistencia) |
| 009 | Validators de dominio con acceso a persistencia | [6](#6-validaciones-de-dominio-con-acceso-a-persistencia) |
| 010 | Manejo de responses y serialización | [3.4](#34-responses-y-serialización) |
| 011 | Organización de tests por módulo | [7.1](#71-estructura-de-directorios) |
| 012 | Estandarización de pruebas con Pest | [7.3](#73-patrones-por-tipo-de-test), [7.4](#74-reglas-obligatorias-para-tests) |
| 013 | Patrón Builder para tests | [7.5](#75-builders-adr-013) |
| — | PostgreSQL 16 | [8](#8-base-de-datos-postgresql-16) |
| — | Frontend convenciones | [9](#9-frontend-convenciones-y-estándares) |
| — | GitLab CI/CD pipeline | [10](#10-pipeline-gitlab-cicd) |
| — | Convenciones transversales | [11](#11-convenciones-transversales) |
| — | Gobernanza | [12](#12-gobernanza-y-evolución) |
