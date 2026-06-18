# Odiseo Database Schema — Agent Guide

This repository contains the PostgreSQL schema (`odiseo.sql`, ~4800 lines) for the **Odiseo** educational assessment platform. It is a **database-only** repo — no application code, tests, or build tooling.

## Key Characteristics

- **Database**: PostgreSQL (uses `odiseo` schema)
- **Framework conventions**: Laravel (migrations table, Spatie RBAC, soft deletes, job queues)
- **Multi-tenant**: `companies` + `company_headquarters` + `classroom` hierarchy
- **Advanced PG features**: Table partitioning (`employee_didi_question_field_image`), triggers (`audit.fn_audit_trigger`, `fn_sync_employees_to_teachers`), custom type `email_citext`, JSON columns

## Common Operations

### Apply schema to a database
```bash
psql -d your_db -f odiseo.sql
```

### Inspect structure
```bash
# List tables
psql -d your_db -c "\dt odiseo.*"

# Describe a table
psql -d your_db -c "\d+ odiseo.questions"

# View partitions
psql -d your_db -c "\d+ odiseo.employee_didi_question_field_image"
```

### Key tables by domain
| Domain | Core Tables |
|--------|-------------|
| Auth/RBAC | `users`, `roles`, `permissions`, `users_roles`, `roles_permissions`, `personal_access_tokens` |
| Multi-tenant | `companies`, `company_headquarters`, `classroom`, `company_user_admin` |
| Academic | `course`, `topic`, `subtopic`, `level`, `cycle`, `cycle_weeks`, `syllabus*` |
| Questions | `question`, `parent_question`, `alternative`, `question_attributes*`, `origin_question` |
| AI | `question_teacher_ia`, `alternative_questions_ia`, `question_ia_images*`, `nq_*` |
| Materials/Exams | `material`, `detail_week_type_mat`, `exam_area`, `material_exam_*`, `material_ballot_*` |
| Diagramation (DiDi) | `employee_didi_question`, `employee_didi_question_field`, `employee_didi_question_field_image` (partitioned) |
| QA/Revisions | `material_revisions`, `material_revision_items`, `material_missing_question*` |

## Conventions & Gotchas

- **Soft deletes**: Most tables have `deleted_at` + `deleted_by` — filter `WHERE deleted_at IS NULL`
- **Partitioned table**: `employee_didi_question_field_image` splits by `fl_status` (active/inactive) — query the parent, inserts route automatically
- **Audit triggers**: `cycle`, `employees` have `audit.fn_audit_trigger()` — check `audit` schema for history
- **Sync trigger**: `employees` → `teachers` via `fn_sync_employees_to_teachers()`
- **Correlatives**: `question_correlative`, `parent_question_correlative` use per-course sequential IDs
- **JSON columns**: `properties` (math/images), `data_missing_text`, `board_json` — query with `->>` operators
- **Custom type**: `email_citext` (case-insensitive email) — requires `citext` extension

## Schema Documentation

See `structure-odiseo.md` for the full architectural breakdown (8 modules, 200+ tables categorized by functional layer).