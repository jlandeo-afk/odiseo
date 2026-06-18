
-- odiseo._bkp_migration_tm_mapping definition

-- Drop table

-- DROP TABLE odiseo._bkp_migration_tm_mapping;

CREATE TABLE odiseo._bkp_migration_tm_mapping ( old_tm_id int2 NULL, new_tm_id int4 NULL, cycle_id int8 NULL, rn int8 NULL);

-- Permissions

ALTER TABLE odiseo._bkp_migration_tm_mapping OWNER TO postgres;
GRANT ALL ON TABLE odiseo._bkp_migration_tm_mapping TO postgres;


-- odiseo._bkp_migration_tma_mapping definition

-- Drop table

-- DROP TABLE odiseo._bkp_migration_tma_mapping;

CREATE TABLE odiseo._bkp_migration_tma_mapping ( old_tma_id int8 NULL, new_tma_id int8 NULL, new_tm_id int4 NULL);

-- Permissions

ALTER TABLE odiseo._bkp_migration_tma_mapping OWNER TO postgres;
GRANT ALL ON TABLE odiseo._bkp_migration_tma_mapping TO postgres;


-- odiseo._bkp_migration_tmc_mapping definition

-- Drop table

-- DROP TABLE odiseo._bkp_migration_tmc_mapping;

CREATE TABLE odiseo._bkp_migration_tmc_mapping ( old_tmc_id int8 NULL, new_tmc_id int8 NULL, new_tm_id int4 NULL);

-- Permissions

ALTER TABLE odiseo._bkp_migration_tmc_mapping OWNER TO postgres;
GRANT ALL ON TABLE odiseo._bkp_migration_tmc_mapping TO postgres;


-- odiseo.course_didi_assignment_state definition

-- Drop table

-- DROP TABLE odiseo.course_didi_assignment_state;

CREATE TABLE odiseo.course_didi_assignment_state ( course_id int4 NOT NULL, last_assigned_didi_index int4 DEFAULT 0 NOT NULL, created_at timestamp(0) NOT NULL, updated_at timestamp(0) NOT NULL, CONSTRAINT course_didi_assignment_state_pkey PRIMARY KEY (course_id));

-- Permissions

ALTER TABLE odiseo.course_didi_assignment_state OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_didi_assignment_state TO postgres;


-- odiseo.failed_jobs definition

-- Drop table

-- DROP TABLE odiseo.failed_jobs;

CREATE TABLE odiseo.failed_jobs ( id bigserial NOT NULL, "uuid" varchar(255) NOT NULL, "connection" text NOT NULL, queue text NOT NULL, payload text NOT NULL, "exception" text NOT NULL, failed_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT failed_jobs_pkey PRIMARY KEY (id), CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid));

-- Permissions

ALTER TABLE odiseo.failed_jobs OWNER TO postgres;
GRANT ALL ON TABLE odiseo.failed_jobs TO postgres;


-- odiseo.field_diagrammed definition

-- Drop table

-- DROP TABLE odiseo.field_diagrammed;

CREATE TABLE odiseo.field_diagrammed ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, name_nq varchar(255) NULL, CONSTRAINT field_diagrammed_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.field_diagrammed OWNER TO postgres;
GRANT ALL ON TABLE odiseo.field_diagrammed TO postgres;


-- odiseo.institution_types definition

-- Drop table

-- DROP TABLE odiseo.institution_types;

CREATE TABLE odiseo.institution_types ( id smallserial NOT NULL, code varchar(30) NOT NULL, "name" varchar(100) NOT NULL, fl_active bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT institution_types_code_unique UNIQUE (code), CONSTRAINT institution_types_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.institution_types OWNER TO postgres;
GRANT ALL ON TABLE odiseo.institution_types TO postgres;


-- odiseo.job_batches definition

-- Drop table

-- DROP TABLE odiseo.job_batches;

CREATE TABLE odiseo.job_batches ( id varchar(255) NOT NULL, "name" varchar(255) NOT NULL, total_jobs int4 NOT NULL, pending_jobs int4 NOT NULL, failed_jobs int4 NOT NULL, failed_job_ids text NOT NULL, "options" text NULL, cancelled_at int4 NULL, created_at int4 NOT NULL, finished_at int4 NULL, CONSTRAINT job_batches_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.job_batches OWNER TO postgres;
GRANT ALL ON TABLE odiseo.job_batches TO postgres;


-- odiseo.material_generation_notification_types definition

-- Drop table

-- DROP TABLE odiseo.material_generation_notification_types;

CREATE TABLE odiseo.material_generation_notification_types ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, slug varchar(255) NOT NULL, created_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT material_generation_notification_types_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_generation_notification_types OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_generation_notification_types TO postgres;


-- odiseo.migrations definition

-- Drop table

-- DROP TABLE odiseo.migrations;

CREATE TABLE odiseo.migrations ( id serial4 NOT NULL, migration varchar(255) NOT NULL, batch int4 NOT NULL, CONSTRAINT migrations_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.migrations OWNER TO postgres;
GRANT ALL ON TABLE odiseo.migrations TO postgres;


-- odiseo.personal_access_tokens definition

-- Drop table

-- DROP TABLE odiseo.personal_access_tokens;

CREATE TABLE odiseo.personal_access_tokens ( id bigserial NOT NULL, tokenable_type varchar(255) NOT NULL, tokenable_id int8 NOT NULL, "name" varchar(255) NOT NULL, "token" text NOT NULL, abilities text NULL, last_used_at timestamp(0) NULL, expires_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, revoked bool DEFAULT false NOT NULL, CONSTRAINT odiseo_personal_access_tokens_token_unique UNIQUE (token), CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id));
CREATE INDEX odiseo_personal_access_tokens_tokenable_type_tokenable_id_index ON odiseo.personal_access_tokens USING btree (tokenable_type, tokenable_id);

-- Permissions

ALTER TABLE odiseo.personal_access_tokens OWNER TO postgres;
GRANT ALL ON TABLE odiseo.personal_access_tokens TO postgres;


-- odiseo.question_attributes_type definition

-- Drop table

-- DROP TABLE odiseo.question_attributes_type;

CREATE TABLE odiseo.question_attributes_type ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT question_attributes_type_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_attributes_type OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_attributes_type TO postgres;


-- odiseo.question_correlative definition

-- Drop table

-- DROP TABLE odiseo.question_correlative;

CREATE TABLE odiseo.question_correlative ( id bigserial NOT NULL, course_id int4 NOT NULL, correlative int4 NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, apply_text bool DEFAULT false NOT NULL, CONSTRAINT question_correlative_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_correlative OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_correlative TO postgres;


-- odiseo.type_documents definition

-- Drop table

-- DROP TABLE odiseo.type_documents;

CREATE TABLE odiseo.type_documents ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, description varchar(255) NOT NULL, created_by int4 NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_documents_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_documents OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_documents TO postgres;


-- odiseo.type_exams definition

-- Drop table

-- DROP TABLE odiseo.type_exams;

CREATE TABLE odiseo.type_exams ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_exams_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_exams OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_exams TO postgres;


-- odiseo.type_text_templates definition

-- Drop table

-- DROP TABLE odiseo.type_text_templates;

CREATE TABLE odiseo.type_text_templates ( id smallserial NOT NULL, "name" varchar(255) NOT NULL, description_text varchar(255) NULL, description_subquestion varchar(255) NULL, text_attributes varchar(255) NOT NULL, subquestion_attributes varchar(255) NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_text_templates_pkey PRIMARY KEY (id), CONSTRAINT type_text_templates_subquestion_attributes_check CHECK (((subquestion_attributes)::text = ANY (ARRAY[('none'::character varying)::text, ('category'::character varying)::text, ('topic'::character varying)::text]))), CONSTRAINT type_text_templates_text_attributes_check CHECK (((text_attributes)::text = ANY (ARRAY[('none'::character varying)::text, ('category'::character varying)::text, ('topic'::character varying)::text]))));

-- Permissions

ALTER TABLE odiseo.type_text_templates OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_templates TO postgres;


-- odiseo.question_attributes_types_values definition

-- Drop table

-- DROP TABLE odiseo.question_attributes_types_values;

CREATE TABLE odiseo.question_attributes_types_values ( id bigserial NOT NULL, question_attributes_type_id int4 NOT NULL, value varchar(255) NOT NULL, "label" varchar(255) NOT NULL, description varchar(255) NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT question_attributes_types_values_pkey PRIMARY KEY (id), CONSTRAINT question_attributes_types_values_question_attributes_type_id_fo FOREIGN KEY (question_attributes_type_id) REFERENCES odiseo.question_attributes_type(id) ON DELETE CASCADE);

-- Permissions

ALTER TABLE odiseo.question_attributes_types_values OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_attributes_types_values TO postgres;


-- odiseo.advanced_settings definition

-- Drop table

-- DROP TABLE odiseo.advanced_settings;

CREATE TABLE odiseo.advanced_settings ( id serial4 NOT NULL, company_id int4 NOT NULL, similarity_percentage numeric(4, 2) NOT NULL, days_deadline int2 NOT NULL, hour_deadline time(0) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, block_assigned_questions int2 DEFAULT '0'::smallint NOT NULL, block_assigned_questions_didi int2 DEFAULT '0'::smallint NOT NULL, limit_lower_question int2 DEFAULT '1'::smallint NOT NULL, limit_upper_question int2 DEFAULT '1'::smallint NOT NULL, cut_off_date int4 DEFAULT 24 NOT NULL, limit_assigned_questions_didi int4 DEFAULT 20 NOT NULL, limit_months_questions int4 DEFAULT 12 NOT NULL, fl_include_numbering bool DEFAULT true NOT NULL, number_years_to_consider_question_repeated int2 DEFAULT '2'::smallint NOT NULL, fl_show_cycle_code_in_course_name_in_ballot bool DEFAULT false NOT NULL, amount_questions_alternatives int2 DEFAULT '3'::smallint NULL, limit_questions_to_change int2 DEFAULT '5'::smallint NULL, CONSTRAINT advanced_settings_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.advanced_settings OWNER TO postgres;
GRANT ALL ON TABLE odiseo.advanced_settings TO postgres;


-- odiseo.alternative definition

-- Drop table

-- DROP TABLE odiseo.alternative;

CREATE TABLE odiseo.alternative ( id bigserial NOT NULL, description text NOT NULL, question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, math_migration_status varchar(255) DEFAULT 'NOT_MIGRATED'::character varying NOT NULL, migrated_updated_at timestamp(0) NULL, is_migrated bool DEFAULT false NOT NULL, CONSTRAINT alternative_math_migration_status_check CHECK (((math_migration_status)::text = ANY (ARRAY[('NOT_MIGRATED'::character varying)::text, ('MIGRATING'::character varying)::text, ('MIGRATED'::character varying)::text, ('NOT_MIGRATABLE'::character varying)::text, ('MIGRATION_FAILURE'::character varying)::text]))), CONSTRAINT alternative_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.alternative OWNER TO postgres;
GRANT ALL ON TABLE odiseo.alternative TO postgres;


-- odiseo.alternative_ia_images definition

-- Drop table

-- DROP TABLE odiseo.alternative_ia_images;

CREATE TABLE odiseo.alternative_ia_images ( id bigserial NOT NULL, code varchar(50) NOT NULL, "extension" varchar(15) NOT NULL, image text NOT NULL, alternative_ia_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT alternative_ia_images_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.alternative_ia_images OWNER TO postgres;
GRANT ALL ON TABLE odiseo.alternative_ia_images TO postgres;


-- odiseo.alternative_maths definition

-- Drop table

-- DROP TABLE odiseo.alternative_maths;

CREATE TABLE odiseo.alternative_maths ( id bigserial NOT NULL, code varchar(50) NOT NULL, "path" varchar(255) NOT NULL, alternative_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, properties json NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT alternative_maths_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.alternative_maths OWNER TO postgres;
GRANT ALL ON TABLE odiseo.alternative_maths TO postgres;


-- odiseo.alternative_questions_ia definition

-- Drop table

-- DROP TABLE odiseo.alternative_questions_ia;

CREATE TABLE odiseo.alternative_questions_ia ( id bigserial NOT NULL, description text NOT NULL, "option" varchar(255) NOT NULL, question_ia_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT alternative_questions_ia_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.alternative_questions_ia OWNER TO postgres;
GRANT ALL ON TABLE odiseo.alternative_questions_ia TO postgres;


-- odiseo.area definition

-- Drop table

-- DROP TABLE odiseo.area;

CREATE TABLE odiseo.area ( id bigserial NOT NULL, code varchar(255) NOT NULL, slug varchar(5) NULL, description varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, agreement_url varchar(255) NULL, agreement_file_name varchar(255) NULL, CONSTRAINT area_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.area OWNER TO postgres;
GRANT ALL ON TABLE odiseo.area TO postgres;


-- odiseo.category_rejected definition

-- Drop table

-- DROP TABLE odiseo.category_rejected;

CREATE TABLE odiseo.category_rejected ( id smallserial NOT NULL, "name" varchar(100) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT category_rejected_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.category_rejected OWNER TO postgres;
GRANT ALL ON TABLE odiseo.category_rejected TO postgres;


-- odiseo.charge definition

-- Drop table

-- DROP TABLE odiseo.charge;

CREATE TABLE odiseo.charge ( id smallserial NOT NULL, "uuid" uuid NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT charge_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.charge OWNER TO postgres;
GRANT ALL ON TABLE odiseo.charge TO postgres;


-- odiseo.classroom definition

-- Drop table

-- DROP TABLE odiseo.classroom;

CREATE TABLE odiseo.classroom ( id smallserial NOT NULL, code varchar(4) NOT NULL, "number" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT classroom_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.classroom OWNER TO postgres;
GRANT ALL ON TABLE odiseo.classroom TO postgres;


-- odiseo.clientes_empresas definition

-- Drop table

-- DROP TABLE odiseo.clientes_empresas;

CREATE TABLE odiseo.clientes_empresas ( id bigserial NOT NULL, ruc varchar(255) NOT NULL, razon_social varchar(255) NOT NULL, tipo varchar(255) NOT NULL, nombre_comercial varchar(255) NOT NULL, direccion varchar(255) NOT NULL, departamento_id int8 NOT NULL, provincia_id int8 NOT NULL, distrito_id int8 NOT NULL, numero_estudiantes int4 NULL, numero_colaboradores int4 NULL, nivel_educativo varchar(255) NULL, correo_contacto_principal varchar(255) NOT NULL, correo_facturacion varchar(255) NULL, telefono varchar(255) NULL, pagina_web varchar(255) NULL, facebook varchar(255) NULL, instagram varchar(255) NULL, tiktok varchar(255) NULL, plan_contratado varchar(255) DEFAULT 'Free'::character varying NOT NULL, fecha_inicio date NOT NULL, modalidad_pago varchar(255) NULL, subdominio varchar(255) NOT NULL, estado varchar(255) NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int4 NULL, CONSTRAINT clientes_empresas_pkey PRIMARY KEY (id), CONSTRAINT clientes_empresas_ruc_unique UNIQUE (ruc), CONSTRAINT clientes_empresas_subdominio_unique UNIQUE (subdominio));

-- Permissions

ALTER TABLE odiseo.clientes_empresas OWNER TO postgres;
GRANT ALL ON TABLE odiseo.clientes_empresas TO postgres;


-- odiseo.code_prospect definition

-- Drop table

-- DROP TABLE odiseo.code_prospect;

CREATE TABLE odiseo.code_prospect ( id bigserial NOT NULL, code varchar(10) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT code_prospect_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.code_prospect OWNER TO postgres;
GRANT ALL ON TABLE odiseo.code_prospect TO postgres;


-- odiseo.companies definition

-- Drop table

-- DROP TABLE odiseo.companies;

CREATE TABLE odiseo.companies ( id bigserial NOT NULL, "uuid" uuid NOT NULL, social_reason varchar(255) NOT NULL, commercial_name varchar(255) NOT NULL, document_number varchar(20) NOT NULL, "schema" varchar(255) NOT NULL, address varchar(255) NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, type_institution_id int2 NOT NULL, region_id int8 NOT NULL, province_id int8 NOT NULL, district_id int8 NOT NULL, contact_email odiseo.email_citext NOT NULL, billing_email odiseo.email_citext NULL, main_phone varchar(12) NOT NULL, webpage varchar(100) NULL, facebook varchar(100) NULL, instagram varchar(100) NULL, tiktok varchar(100) NULL, number_students int4 NULL, number_collaborators int4 NULL, education_level varchar(50) NULL, plan varchar(50) NULL, plan_start_date date NULL, modality_payment varchar(50) NULL, fl_active bool DEFAULT true NOT NULL, CONSTRAINT companies_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.companies OWNER TO postgres;
GRANT ALL ON TABLE odiseo.companies TO postgres;


-- odiseo.company_headquarters definition

-- Drop table

-- DROP TABLE odiseo.company_headquarters;

CREATE TABLE odiseo.company_headquarters ( id serial4 NOT NULL, headquarter_id int8 NOT NULL, company_id int8 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT company_headquarters_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.company_headquarters OWNER TO postgres;
GRANT ALL ON TABLE odiseo.company_headquarters TO postgres;


-- odiseo.company_legal_representatives definition

-- Drop table

-- DROP TABLE odiseo.company_legal_representatives;

CREATE TABLE odiseo.company_legal_representatives ( id serial4 NOT NULL, company_id int8 NOT NULL, names varchar(60) NOT NULL, first_surname varchar(45) NOT NULL, second_surname varchar(45) NOT NULL, type_document_id int8 NOT NULL, document_number varchar(15) NOT NULL, email odiseo.email_citext NOT NULL, phone varchar(15) NULL, fl_active bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT company_legal_representatives_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.company_legal_representatives OWNER TO postgres;
GRANT ALL ON TABLE odiseo.company_legal_representatives TO postgres;


-- odiseo.company_universities definition

-- Drop table

-- DROP TABLE odiseo.company_universities;

CREATE TABLE odiseo.company_universities ( id serial4 NOT NULL, company_id int8 NOT NULL, university_id int8 NOT NULL, fl_active bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT company_universities_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.company_universities OWNER TO postgres;
GRANT ALL ON TABLE odiseo.company_universities TO postgres;


-- odiseo.company_user_admin definition

-- Drop table

-- DROP TABLE odiseo.company_user_admin;

CREATE TABLE odiseo.company_user_admin ( id serial4 NOT NULL, company_id int8 NOT NULL, employee_id int8 NOT NULL, fl_active bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT company_user_admin_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.company_user_admin OWNER TO postgres;
GRANT ALL ON TABLE odiseo.company_user_admin TO postgres;


-- odiseo.configuration_alternative definition

-- Drop table

-- DROP TABLE odiseo.configuration_alternative;

CREATE TABLE odiseo.configuration_alternative ( id bigserial NOT NULL, "name" varchar(100) NOT NULL, "columns" int2 DEFAULT '3'::smallint NOT NULL, styles text DEFAULT '{}'::text NOT NULL, fl_image bool DEFAULT false NOT NULL, fl_default bool DEFAULT false NOT NULL, fl_status bool DEFAULT true NOT NULL, company_id int8 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT configuration_alternative_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.configuration_alternative OWNER TO postgres;
GRANT ALL ON TABLE odiseo.configuration_alternative TO postgres;


-- odiseo.course definition

-- Drop table

-- DROP TABLE odiseo.course;

CREATE TABLE odiseo.course ( id smallserial NOT NULL, code varchar(3) NOT NULL, "name" varchar(30) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, area_id int8 NULL, fl_pseudo_course bool DEFAULT false NOT NULL, apply_text bool DEFAULT false NOT NULL, alias_nq varchar(255) NULL, agreement_url varchar(255) NULL, agreement_file_name varchar(255) NULL, type_text_template_id int2 NULL, show_context_nq bool DEFAULT true NOT NULL, CONSTRAINT course_pkey PRIMARY KEY (id), CONSTRAINT odiseo_course_code_unique UNIQUE (code));

-- Permissions

ALTER TABLE odiseo.course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course TO postgres;


-- odiseo.course_assigned_categories definition

-- Drop table

-- DROP TABLE odiseo.course_assigned_categories;

CREATE TABLE odiseo.course_assigned_categories ( id bigserial NOT NULL, course_id int8 NOT NULL, type_text_id int4 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT course_assigned_categories_course_id_type_text_id_unique UNIQUE (course_id, type_text_id), CONSTRAINT course_assigned_categories_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.course_assigned_categories OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_assigned_categories TO postgres;


-- odiseo.course_assigned_subcategories definition

-- Drop table

-- DROP TABLE odiseo.course_assigned_subcategories;

CREATE TABLE odiseo.course_assigned_subcategories ( id bigserial NOT NULL, course_assigned_category_id int8 NOT NULL, subcategory_id int4 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT course_assigned_subcategories_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX unique_active_assigned_subcategory ON odiseo.course_assigned_subcategories USING btree (course_assigned_category_id, subcategory_id) WHERE (deleted_at IS NULL);

-- Permissions

ALTER TABLE odiseo.course_assigned_subcategories OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_assigned_subcategories TO postgres;


-- odiseo.course_level definition

-- Drop table

-- DROP TABLE odiseo.course_level;

CREATE TABLE odiseo.course_level ( id bigserial NOT NULL, code varchar(20) NOT NULL, level_id int8 NULL, course_id int2 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, course_level_nq bool DEFAULT false NOT NULL, CONSTRAINT course_level_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.course_level OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_level TO postgres;


-- odiseo.course_pseudo_course definition

-- Drop table

-- DROP TABLE odiseo.course_pseudo_course;

CREATE TABLE odiseo.course_pseudo_course ( id bigserial NOT NULL, course_id int8 NULL, pseudo_course_id int8 NULL, "order" int4 DEFAULT 1 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT course_pseudo_course_pkey PRIMARY KEY (id), CONSTRAINT unique_course_pseudo UNIQUE (course_id, pseudo_course_id, fl_status));

-- Permissions

ALTER TABLE odiseo.course_pseudo_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_pseudo_course TO postgres;


-- odiseo.course_pseudo_courses definition

-- Drop table

-- DROP TABLE odiseo.course_pseudo_courses;

CREATE TABLE odiseo.course_pseudo_courses ( id bigserial NOT NULL, pseudo_course_id int2 NOT NULL, course_id int2 NOT NULL, "order" int4 DEFAULT 1 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT course_pseudo_courses_pkey PRIMARY KEY (id), CONSTRAINT unique_pseudo_courses UNIQUE (pseudo_course_id, course_id, fl_status));

-- Permissions

ALTER TABLE odiseo.course_pseudo_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_pseudo_courses TO postgres;


-- odiseo.course_text_category_settings definition

-- Drop table

-- DROP TABLE odiseo.course_text_category_settings;

CREATE TABLE odiseo.course_text_category_settings ( id bigserial NOT NULL, course_id int2 NOT NULL, type_text_id int2 NOT NULL, fl_show_in_material_without_solution bool DEFAULT false NOT NULL, fl_show_in_material_with_solution bool DEFAULT false NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT course_text_category_settings_pkey PRIMARY KEY (id), CONSTRAINT course_type_text_unique UNIQUE (course_id, type_text_id));

-- Permissions

ALTER TABLE odiseo.course_text_category_settings OWNER TO postgres;
GRANT ALL ON TABLE odiseo.course_text_category_settings TO postgres;


-- odiseo."cycle" definition

-- Drop table

-- DROP TABLE odiseo."cycle";

CREATE TABLE odiseo."cycle" ( id bigserial NOT NULL, code varchar(10) NOT NULL, description varchar(100) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "month" int2 NULL, "year" int2 NULL, weeks int2 NULL, start_date date NULL, end_date date NULL, active bool DEFAULT true NULL, days int2 DEFAULT '5'::smallint NOT NULL, cycle_type_id int8 NULL, company_id int4 NULL, type_template_id int8 NULL, CONSTRAINT cycle_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX idx_cycle_unique_active ON odiseo.cycle USING btree (code, description, company_id) WHERE ((fl_status IS TRUE) AND (deleted_at IS NULL));

-- Table Triggers

create trigger trg_audit_cycle after
delete
    or
update
    on
    odiseo.cycle for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo."cycle" OWNER TO postgres;
GRANT ALL ON TABLE odiseo."cycle" TO postgres;


-- odiseo.cycle_types definition

-- Drop table

-- DROP TABLE odiseo.cycle_types;

CREATE TABLE odiseo.cycle_types ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT cycle_types_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.cycle_types OWNER TO postgres;
GRANT ALL ON TABLE odiseo.cycle_types TO postgres;


-- odiseo.cycle_weeks definition

-- Drop table

-- DROP TABLE odiseo.cycle_weeks;

CREATE TABLE odiseo.cycle_weeks ( id bigserial NOT NULL, week int2 NULL, type_week_id int8 NOT NULL, cycle_id int8 NOT NULL, start_date date NOT NULL, end_date date NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT cycle_weeks_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX idx_cycle_weeks_unique_date ON odiseo.cycle_weeks USING btree (cycle_id, start_date) WHERE (fl_status IS TRUE);

-- Permissions

ALTER TABLE odiseo.cycle_weeks OWNER TO postgres;
GRANT ALL ON TABLE odiseo.cycle_weeks TO postgres;


-- odiseo.detail_level_syllabus_weeks definition

-- Drop table

-- DROP TABLE odiseo.detail_level_syllabus_weeks;

CREATE TABLE odiseo.detail_level_syllabus_weeks ( id bigserial NOT NULL, level_syllabus_weeks_id int8 NOT NULL, type_material_id int8 NOT NULL, level_id int8 NOT NULL, type_question varchar(255) NOT NULL, number_questions int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT detail_level_syllabus_weeks_pkey PRIMARY KEY (id));
CREATE INDEX idx_dtl_lvl_syl_wks_id ON odiseo.detail_level_syllabus_weeks USING btree (level_syllabus_weeks_id);

-- Permissions

ALTER TABLE odiseo.detail_level_syllabus_weeks OWNER TO postgres;
GRANT ALL ON TABLE odiseo.detail_level_syllabus_weeks TO postgres;


-- odiseo.detail_level_syllabus_weeks_parents definition

-- Drop table

-- DROP TABLE odiseo.detail_level_syllabus_weeks_parents;

CREATE TABLE odiseo.detail_level_syllabus_weeks_parents ( id bigserial NOT NULL, level_syllabus_weeks_id int8 NOT NULL, level_id int8 NOT NULL, number_of_passages int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_material_id int8 NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT detail_level_syllabus_weeks_parents_pkey PRIMARY KEY (id));
CREATE INDEX idx_dtl_lvl_syl_wks_parents_id ON odiseo.detail_level_syllabus_weeks_parents USING btree (level_syllabus_weeks_id);

-- Permissions

ALTER TABLE odiseo.detail_level_syllabus_weeks_parents OWNER TO postgres;
GRANT ALL ON TABLE odiseo.detail_level_syllabus_weeks_parents TO postgres;


-- odiseo.detail_week_type_mat definition

-- Drop table

-- DROP TABLE odiseo.detail_week_type_mat;

CREATE TABLE odiseo.detail_week_type_mat ( id bigserial NOT NULL, material_id int8 NOT NULL, week int2 NOT NULL, type_material_id int2 NOT NULL, url_solution varchar(255) NULL, url_without_solution varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, parent_type_material_id int2 NULL, fl_process_status int2 DEFAULT '1'::smallint NOT NULL, fl_process_status_without int2 DEFAULT '1'::smallint NOT NULL, job_solution_id varchar(255) NULL, job_without_solution_id varchar(255) NULL, fl_process_class_mat int2 DEFAULT '0'::smallint NOT NULL, url_zip_class_mat varchar(255) NULL, fl_config_level bool DEFAULT true NOT NULL, fl_process_quality int2 DEFAULT '1'::smallint NOT NULL, url_quality varchar(255) NULL, job_quality_id varchar(255) NULL, fl_process_without_quality int2 DEFAULT '1'::smallint NOT NULL, url_without_quality varchar(255) NULL, job_without_quality_id varchar(255) NULL, fl_complete_questions bool DEFAULT true NOT NULL, data_incomplete_questions varchar(255) NULL, fl_config_type bool DEFAULT false NOT NULL, limit_lower_question int2 NULL, limit_upper_question int2 NULL, missing_config_message varchar(255) NULL, data_missing_course_config varchar(255) NULL, "locked" bool DEFAULT false NOT NULL, locked_by int8 NULL, locked_at timestamp(0) NULL, questions_generation_process varchar(255) DEFAULT 'not_started'::character varying NOT NULL, data_missing_text json NULL, "uuid" uuid DEFAULT gen_random_uuid() NULL, CONSTRAINT detail_week_type_mat_pkey PRIMARY KEY (id), CONSTRAINT detail_week_type_mat_questions_generation_process_check CHECK (((questions_generation_process)::text = ANY (ARRAY[('not_started'::character varying)::text, ('in_progress'::character varying)::text, ('canceled'::character varying)::text, ('done'::character varying)::text, ('failed'::character varying)::text]))), CONSTRAINT ux_detail_week_type_mat UNIQUE (material_id, week, type_material_id));
CREATE INDEX idx_dwtm_material_id_id ON odiseo.detail_week_type_mat USING btree (material_id, id);

-- Column comments

COMMENT ON COLUMN odiseo.detail_week_type_mat.url_solution IS 'url del material con solucionario';
COMMENT ON COLUMN odiseo.detail_week_type_mat.url_without_solution IS 'url del material sin solucionario';

-- Permissions

ALTER TABLE odiseo.detail_week_type_mat OWNER TO postgres;
GRANT ALL ON TABLE odiseo.detail_week_type_mat TO postgres;


-- odiseo.didi_maths definition

-- Drop table

-- DROP TABLE odiseo.didi_maths;

CREATE TABLE odiseo.didi_maths ( id bigserial NOT NULL, code varchar(50) NOT NULL, "path" varchar(255) NOT NULL, didi_question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, properties json NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT didi_maths_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.didi_maths OWNER TO postgres;
GRANT ALL ON TABLE odiseo.didi_maths TO postgres;


-- odiseo.districts definition

-- Drop table

-- DROP TABLE odiseo.districts;

CREATE TABLE odiseo.districts ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, region_id int8 NOT NULL, province_id int8 NOT NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT districts_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.districts OWNER TO postgres;
GRANT ALL ON TABLE odiseo.districts TO postgres;


-- odiseo.employee_course definition

-- Drop table

-- DROP TABLE odiseo.employee_course;

CREATE TABLE odiseo.employee_course ( id bigserial NOT NULL, teacher_id int8 NULL, course_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT employee_course_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_course TO postgres;


-- odiseo.employee_didi_question definition

-- Drop table

-- DROP TABLE odiseo.employee_didi_question;

CREATE TABLE odiseo.employee_didi_question ( id bigserial NOT NULL, employee_id int8 NULL, question_id int8 NULL, week int2 NULL, "year" int2 NULL, diagrammed bool DEFAULT false NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, theory_base text NULL, data_unknown text NULL, "development " text NULL, answer text NULL, url_file varchar(255) NULL, url_file_digitalized_solution varchar(255) NULL, url_file_digitalized_images text NULL, url_file_digitalized_solution_updated_at timestamp(0) NULL, "version" int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT employee_didi_question_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX employee_didi_question_question_id_unique_active ON odiseo.employee_didi_question USING btree (question_id) WHERE (fl_status = true);
CREATE INDEX idx_didi_question_active ON odiseo.employee_didi_question USING btree (question_id) WHERE (fl_status = true);
CREATE INDEX idx_employee_didi_question_fl_status ON odiseo.employee_didi_question USING btree (fl_status);
CREATE INDEX idx_employee_didi_question_question_id ON odiseo.employee_didi_question USING btree (question_id);

-- Column comments

COMMENT ON COLUMN odiseo.employee_didi_question.employee_id IS 'DiDi';

-- Permissions

ALTER TABLE odiseo.employee_didi_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_didi_question TO postgres;


-- odiseo.employee_didi_question_field definition

-- Drop table

-- DROP TABLE odiseo.employee_didi_question_field;

CREATE TABLE odiseo.employee_didi_question_field ( id bigserial NOT NULL, employee_didi_question_id int8 NOT NULL, setting_diagrammed_course_id int8 NOT NULL, value text NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, migrated_updated_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NULL, math_migration_status varchar(255) DEFAULT 'NOT_MIGRATED'::character varying NOT NULL, is_migrated bool DEFAULT false NOT NULL, CONSTRAINT employee_didi_question_field_math_migration_status_new_check CHECK (((math_migration_status)::text = ANY (ARRAY[('NOT_MIGRATED'::character varying)::text, ('TO_BE_MIGRATED'::character varying)::text, ('MIGRATING'::character varying)::text, ('MIGRATED'::character varying)::text, ('NOT_MIGRATABLE'::character varying)::text, ('MIGRATION_FAILURE'::character varying)::text]))), CONSTRAINT employee_didi_question_field_pkey PRIMARY KEY (id));
CREATE INDEX idx_employee_didi_question_field_employee_didi_question_id ON odiseo.employee_didi_question_field USING btree (employee_didi_question_id);

-- Permissions

ALTER TABLE odiseo.employee_didi_question_field OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_didi_question_field TO postgres;


-- odiseo.employee_didi_question_field_image definition

-- Drop table

-- DROP TABLE odiseo.employee_didi_question_field_image;

CREATE TABLE odiseo.employee_didi_question_field_image ( id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL, employee_didi_question_id int8 NOT NULL, code varchar NOT NULL, image varchar NOT NULL, "extension" varchar NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT employee_didi_question_field_image_pkey1 PRIMARY KEY (id, fl_status)) PARTITION BY LIST (fl_status);

-- Permissions

ALTER TABLE odiseo.employee_didi_question_field_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_didi_question_field_image TO postgres;


-- odiseo.employee_didi_question_field_image_active definition

CREATE TABLE odiseo.employee_didi_question_field_image_active PARTITION OF odiseo.employee_didi_question_field_image  FOR VALUES IN (true);


-- odiseo.employee_didi_question_field_image_inactive definition

CREATE TABLE odiseo.employee_didi_question_field_image_inactive PARTITION OF odiseo.employee_didi_question_field_image  FOR VALUES IN (false);


-- odiseo.employee_didi_question_image definition

-- Drop table

-- DROP TABLE odiseo.employee_didi_question_image;

CREATE TABLE odiseo.employee_didi_question_image ( id bigserial NOT NULL, employee_didi_question_id int8 NOT NULL, code varchar(50) NOT NULL, "extension" varchar(10) NULL, image text NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT employee_didi_question_image_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_didi_question_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_didi_question_image TO postgres;


-- odiseo.employee_question definition

-- Drop table

-- DROP TABLE odiseo.employee_question;

CREATE TABLE odiseo.employee_question ( id bigserial NOT NULL, teacher_id int8 NULL, question_id int8 NULL, alternative_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "type" varchar(255) DEFAULT 'MANUAL'::character varying NOT NULL, document_solution text NULL, week int4 NULL, "year" int4 NULL, solved bool DEFAULT false NOT NULL, url_pdf_question_solution varchar(255) NULL, board_json text NULL, board_refuzed text NULL, fl_refuzed bool DEFAULT false NOT NULL, editor_content text NULL, url_pdf_question_solution_updated_at timestamp(0) NULL, CONSTRAINT employee_question_pkey PRIMARY KEY (id));
CREATE INDEX idx_employee_question_active ON odiseo.employee_question USING btree (question_id) WHERE (fl_status = true);

-- Permissions

ALTER TABLE odiseo.employee_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_question TO postgres;


-- odiseo.employee_question_document definition

-- Drop table

-- DROP TABLE odiseo.employee_question_document;

CREATE TABLE odiseo.employee_question_document ( id bigserial NOT NULL, employee_question_id int8 NOT NULL, type_archive_id int2 NOT NULL, "document" text NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, document_refuzed text NULL, fl_refuzed bool DEFAULT false NOT NULL, CONSTRAINT employee_question_document_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_question_document OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_question_document TO postgres;


-- odiseo.employee_question_image definition

-- Drop table

-- DROP TABLE odiseo.employee_question_image;

CREATE TABLE odiseo.employee_question_image ( id bigserial NOT NULL, employee_question_id int8 NOT NULL, code varchar(50) NOT NULL, "extension" varchar(6) NOT NULL, image text NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT employee_question_image_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_question_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_question_image TO postgres;


-- odiseo.employee_question_maths definition

-- Drop table

-- DROP TABLE odiseo.employee_question_maths;

CREATE TABLE odiseo.employee_question_maths ( id bigserial NOT NULL, code varchar(50) NOT NULL, "path" varchar(255) NOT NULL, employee_question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, properties json NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT employee_question_maths_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_question_maths OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_question_maths TO postgres;


-- odiseo.employee_university definition

-- Drop table

-- DROP TABLE odiseo.employee_university;

CREATE TABLE odiseo.employee_university ( employee_id int8 NOT NULL, university_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, id bigserial NOT NULL, CONSTRAINT employee_university_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.employee_university OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employee_university TO postgres;


-- odiseo.employees definition

-- Drop table

-- DROP TABLE odiseo.employees;

CREATE TABLE odiseo.employees ( id bigserial NOT NULL, "uuid" uuid NOT NULL, user_id int8 NULL, first_name varchar(60) NOT NULL, first_surname varchar(45) NOT NULL, second_surname varchar(45) NOT NULL, type_document_id int8 NOT NULL, "document" varchar(30) NULL, email odiseo.email_citext NULL, phone varchar(12) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, code varchar(255) NULL, limit_assigned_questions int2 DEFAULT 0 NOT NULL, limit_assigned_questions_initial int2 DEFAULT '0'::smallint NULL, fl_unlimit_questions bool DEFAULT false NOT NULL, charge_id int8 NULL, gpt bool DEFAULT false NOT NULL, level_id int8 NULL, goal int4 NULL, lot int2 NULL, company_id int4 NULL, limit_missing_questions int4 DEFAULT 15 NULL, fl_resolve_missing_questions bool DEFAULT false NULL, CONSTRAINT character_limit_document_chk CHECK (((length((document)::text) >= 8) AND (length((document)::text) <= 15))) NOT VALID, CONSTRAINT employees_pkey PRIMARY KEY (id), CONSTRAINT limit_goal_chk CHECK (((goal >= 0) AND (goal <= 300))), CONSTRAINT limit_lot_chk CHECK (((lot >= 0) AND (lot <= 100))));
CREATE INDEX idx_employees_user_id ON odiseo.employees USING btree (user_id);

-- Table Triggers

create trigger trg_sync_employees_to_teachers after
insert
    or
update
    on
    odiseo.employees for each row execute function odiseo.fn_sync_employees_to_teachers();

-- Permissions

ALTER TABLE odiseo.employees OWNER TO postgres;
GRANT ALL ON TABLE odiseo.employees TO postgres;


-- odiseo.essential_knowledge_image definition

-- Drop table

-- DROP TABLE odiseo.essential_knowledge_image;

CREATE TABLE odiseo.essential_knowledge_image ( id bigserial NOT NULL, essential_knowledge_id int8 NOT NULL, image text NOT NULL, "extension" text NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT essential_knowledge_image_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.essential_knowledge_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.essential_knowledge_image TO postgres;


-- odiseo.essential_knowledge_questions definition

-- Drop table

-- DROP TABLE odiseo.essential_knowledge_questions;

CREATE TABLE odiseo.essential_knowledge_questions ( id bigserial NOT NULL, essential_knowledge_id int4 NOT NULL, question_id int4 NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT essential_knowledge_questions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.essential_knowledge_questions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.essential_knowledge_questions TO postgres;


-- odiseo.essential_knowledges definition

-- Drop table

-- DROP TABLE odiseo.essential_knowledges;

CREATE TABLE odiseo.essential_knowledges ( id bigserial NOT NULL, code varchar(255) NOT NULL, "name" varchar(255) NOT NULL, course_id int8 NOT NULL, topic_id int8 NOT NULL, is_active bool DEFAULT true NOT NULL, editor_content text NOT NULL, thumbnail text NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT essential_knowledges_code_unique UNIQUE (code), CONSTRAINT essential_knowledges_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.essential_knowledges OWNER TO postgres;
GRANT ALL ON TABLE odiseo.essential_knowledges TO postgres;


-- odiseo.exam_area definition

-- Drop table

-- DROP TABLE odiseo.exam_area;

CREATE TABLE odiseo.exam_area ( id smallserial NOT NULL, description varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, short_description varchar(255) NULL, CONSTRAINT exam_area_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.exam_area OWNER TO postgres;
GRANT ALL ON TABLE odiseo.exam_area TO postgres;


-- odiseo.exam_material_config_area_course_levels definition

-- Drop table

-- DROP TABLE odiseo.exam_material_config_area_course_levels;

CREATE TABLE odiseo.exam_material_config_area_course_levels ( id smallserial NOT NULL, exam_material_config_area_course_id int8 NOT NULL, level_id int8 NOT NULL, amount_question int4 DEFAULT 0 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT exam_material_config_area_course_levels_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.exam_material_config_area_course_levels OWNER TO postgres;
GRANT ALL ON TABLE odiseo.exam_material_config_area_course_levels TO postgres;


-- odiseo.exam_material_config_area_courses definition

-- Drop table

-- DROP TABLE odiseo.exam_material_config_area_courses;

CREATE TABLE odiseo.exam_material_config_area_courses ( id smallserial NOT NULL, exam_material_config_id int8 NOT NULL, course_id int8 NOT NULL, exam_area_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, amount_type_d int4 NULL, CONSTRAINT exam_material_config_area_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.exam_material_config_area_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.exam_material_config_area_courses TO postgres;


-- odiseo.exam_material_configurations definition

-- Drop table

-- DROP TABLE odiseo.exam_material_configurations;

CREATE TABLE odiseo.exam_material_configurations ( id smallserial NOT NULL, type_material_id int8 NOT NULL, cycle_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT exam_material_configurations_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.exam_material_configurations OWNER TO postgres;
GRANT ALL ON TABLE odiseo.exam_material_configurations TO postgres;


-- odiseo.frequent_university_subtopic definition

-- Drop table

-- DROP TABLE odiseo.frequent_university_subtopic;

CREATE TABLE odiseo.frequent_university_subtopic ( id bigserial NOT NULL, university_id int8 NOT NULL, subtopic_id int8 NOT NULL, updated_by int8 NULL, is_frequent bool DEFAULT true NOT NULL, "method" varchar(255) DEFAULT 'system'::character varying NOT NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT frequent_university_subtopic_method_check CHECK (((method)::text = ANY (ARRAY[('manual'::character varying)::text, ('system'::character varying)::text]))), CONSTRAINT frequent_university_subtopic_pkey PRIMARY KEY (id), CONSTRAINT uq_university_subtopic UNIQUE (university_id, subtopic_id));

-- Permissions

ALTER TABLE odiseo.frequent_university_subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.frequent_university_subtopic TO postgres;


-- odiseo.headquarters definition

-- Drop table

-- DROP TABLE odiseo.headquarters;

CREATE TABLE odiseo.headquarters ( id smallserial NOT NULL, code varchar(255) NULL, "name" varchar(255) NOT NULL, slug varchar(7) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, address varchar(150) NULL, CONSTRAINT headquarters_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.headquarters OWNER TO postgres;
GRANT ALL ON TABLE odiseo.headquarters TO postgres;


-- odiseo.headquarters_classroom definition

-- Drop table

-- DROP TABLE odiseo.headquarters_classroom;

CREATE TABLE odiseo.headquarters_classroom ( id smallserial NOT NULL, headquarters_id int2 NOT NULL, classroom_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT headquarters_classroom_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.headquarters_classroom OWNER TO postgres;
GRANT ALL ON TABLE odiseo.headquarters_classroom TO postgres;


-- odiseo.history_digitalized_solution_question_pdf definition

-- Drop table

-- DROP TABLE odiseo.history_digitalized_solution_question_pdf;

CREATE TABLE odiseo.history_digitalized_solution_question_pdf ( id bigserial NOT NULL, question_id int8 NOT NULL, status varchar(5) NOT NULL, url varchar(255) NULL, original_created_at timestamp(0) NULL, created_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NULL, CONSTRAINT history_digitalized_solution_question_pdf_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.history_digitalized_solution_question_pdf OWNER TO postgres;
GRANT ALL ON TABLE odiseo.history_digitalized_solution_question_pdf TO postgres;


-- odiseo.history_syllabus definition

-- Drop table

-- DROP TABLE odiseo.history_syllabus;

CREATE TABLE odiseo.history_syllabus ( id bigserial NOT NULL, syllabus_id int8 NOT NULL, user_id int8 NOT NULL, role_id int8 NOT NULL, correlative int4 NULL, description text NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, "token" varchar(255) NULL, weeks json NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT history_syllabus_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.history_syllabus OWNER TO postgres;
GRANT ALL ON TABLE odiseo.history_syllabus TO postgres;


-- odiseo.image_galery_topic definition

-- Drop table

-- DROP TABLE odiseo.image_galery_topic;

CREATE TABLE odiseo.image_galery_topic ( id bigserial NOT NULL, image_gallery_id int8 NOT NULL, topic_id int8 NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, fl_status bool DEFAULT true NOT NULL, CONSTRAINT image_galery_topic_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.image_galery_topic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.image_galery_topic TO postgres;


-- odiseo.image_gallery definition

-- Drop table

-- DROP TABLE odiseo.image_gallery;

CREATE TABLE odiseo.image_gallery ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, image varchar(255) NOT NULL, width int4 NULL, height int4 NULL, "extension" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, path_full_version varchar(255) NULL, path_short_version varchar(255) NULL, CONSTRAINT image_gallery_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.image_gallery OWNER TO postgres;
GRANT ALL ON TABLE odiseo.image_gallery TO postgres;


-- odiseo.importance_rejected definition

-- Drop table

-- DROP TABLE odiseo.importance_rejected;

CREATE TABLE odiseo.importance_rejected ( id smallserial NOT NULL, "level" int2 NOT NULL, "name" varchar(100) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT importance_rejected_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.importance_rejected OWNER TO postgres;
GRANT ALL ON TABLE odiseo.importance_rejected TO postgres;


-- odiseo.individual_notifications definition

-- Drop table

-- DROP TABLE odiseo.individual_notifications;

CREATE TABLE odiseo.individual_notifications ( id bigserial NOT NULL, title varchar(255) NOT NULL, message varchar(255) NOT NULL, url_internal varchar(255) NULL, user_id int8 NOT NULL, "type" int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, fl_read bool DEFAULT false NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT individual_notifications_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.individual_notifications OWNER TO postgres;
GRANT ALL ON TABLE odiseo.individual_notifications TO postgres;


-- odiseo."level" definition

-- Drop table

-- DROP TABLE odiseo."level";

CREATE TABLE odiseo."level" ( id bigserial NOT NULL, description varchar(20) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "name" varchar(20) NULL, alias_nq varchar(20) NULL, CONSTRAINT level_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo."level" OWNER TO postgres;
GRANT ALL ON TABLE odiseo."level" TO postgres;


-- odiseo.level_rates definition

-- Drop table

-- DROP TABLE odiseo.level_rates;

CREATE TABLE odiseo.level_rates ( id bigserial NOT NULL, level_name varchar(255) NOT NULL, cost_per_question numeric(10, 2) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT level_rates_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.level_rates OWNER TO postgres;
GRANT ALL ON TABLE odiseo.level_rates TO postgres;


-- odiseo.level_syllabus definition

-- Drop table

-- DROP TABLE odiseo.level_syllabus;

CREATE TABLE odiseo.level_syllabus ( id bigserial NOT NULL, headquarter_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, course_id int8 NULL, cycle_id int8 NULL, university_id int8 NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT level_syllabus_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.level_syllabus OWNER TO postgres;
GRANT ALL ON TABLE odiseo.level_syllabus TO postgres;


-- odiseo.level_syllabus_weeks definition

-- Drop table

-- DROP TABLE odiseo.level_syllabus_weeks;

CREATE TABLE odiseo.level_syllabus_weeks ( id bigserial NOT NULL, level_syllabus_id int8 NOT NULL, week int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT level_syllabus_weeks_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.level_syllabus_weeks OWNER TO postgres;
GRANT ALL ON TABLE odiseo.level_syllabus_weeks TO postgres;


-- odiseo.material definition

-- Drop table

-- DROP TABLE odiseo.material;

CREATE TABLE odiseo.material ( id bigserial NOT NULL, cycle_id int8 NOT NULL, university_id int2 NOT NULL, headquarte_id int2 NOT NULL, headquarters_classroom_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_verified_material_without_altern_code bool DEFAULT false NOT NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT material_pkey PRIMARY KEY (id));
CREATE INDEX material_university_id_index ON odiseo.material USING btree (university_id);

-- Permissions

ALTER TABLE odiseo.material OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material TO postgres;


-- odiseo.material_ballot_question definition

-- Drop table

-- DROP TABLE odiseo.material_ballot_question;

CREATE TABLE odiseo.material_ballot_question ( id bigserial NOT NULL, week_type_material_id int8 NOT NULL, course_id int2 NOT NULL, topic_id int2 NULL, subtopic_id int2 NULL, level_id int8 NOT NULL, "type" varchar(2) NULL, question_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NOT NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, question_history_id int8 NULL, "position" int2 NULL, random bool NULL, fl_is_manual bool DEFAULT false NOT NULL, parent_question_id int8 NULL, type_text_id int8 NULL, type_text_subcategory_id int8 NULL, usage_topic_id int8 NULL, usage_subtopic_id int8 NULL, material_id int8 NOT NULL, week int2 NOT NULL, type_material_id int2 NOT NULL, position_initial int2 NOT NULL, absolute_position int2 NULL, usage_level_id int8 NULL, usage_status bool DEFAULT true NULL, added_in_completion bool DEFAULT false NULL, removed_in_completion bool DEFAULT false NULL, state varchar(30) DEFAULT 'MISSING'::character varying NULL, completed_subquestion bool DEFAULT false NULL, expected_type bpchar(2) NULL, entity_type varchar(10) GENERATED ALWAYS AS (
CASE
    WHEN type_text_id IS NOT NULL THEN 'TEXT'::text
    ELSE 'QUESTION'::text
END) STORED NULL, CONSTRAINT chk_mbq_entity_purity CHECK ((((type_text_id IS NOT NULL) AND (question_id IS NULL)) OR ((type_text_id IS NULL) AND (type_text_subcategory_id IS NULL) AND (parent_question_id IS NULL)))), CONSTRAINT chk_mbq_expected_type CHECK (((expected_type = ANY (ARRAY['D'::bpchar, 'T'::bpchar])) OR ((expected_type IS NULL) AND (type_text_id IS NOT NULL)))), CONSTRAINT chk_mbq_state_consistency CHECK (((((state)::text = 'MISSING'::text) AND (question_id IS NULL) AND (parent_question_id IS NULL) AND (removed_in_completion = false)) OR (((state)::text = 'MANUAL_REMOVED'::text) AND (question_id IS NULL) AND (parent_question_id IS NULL) AND (removed_in_completion = true)) OR (((state)::text = 'GENERATED'::text) AND ((question_id IS NOT NULL) OR (parent_question_id IS NOT NULL)) AND (added_in_completion = false)) OR (((state)::text = 'AUTO_COMPLETED'::text) AND ((question_id IS NOT NULL) OR (parent_question_id IS NOT NULL)) AND (added_in_completion = true) AND (fl_is_manual = false)) OR (((state)::text = 'MANUAL_COMPLETED'::text) AND ((question_id IS NOT NULL) OR (parent_question_id IS NOT NULL)) AND (added_in_completion = true) AND (fl_is_manual = true)))), CONSTRAINT chk_mbq_type CHECK ((((type)::text = ANY ((ARRAY['D'::character varying, 'T'::character varying])::text[])) OR ((type IS NULL) AND (type_text_id IS NOT NULL)))), CONSTRAINT material_ballot_question_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX idx_mbq_unique_active_legacy ON odiseo.material_ballot_question USING btree (week_type_material_id, COALESCE(question_id, (0)::bigint), COALESCE(parent_question_id, (0)::bigint)) WHERE ((fl_status = true) AND (deleted_at IS NULL) AND ((question_id IS NOT NULL) OR (parent_question_id IS NOT NULL)));
CREATE INDEX idx_mbq_week_type_material_id ON odiseo.material_ballot_question USING btree (week_type_material_id);

-- Permissions

ALTER TABLE odiseo.material_ballot_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_ballot_question TO postgres;


-- odiseo.material_ballot_stats_area_courses definition

-- Drop table

-- DROP TABLE odiseo.material_ballot_stats_area_courses;

CREATE TABLE odiseo.material_ballot_stats_area_courses ( id bigserial NOT NULL, area_stats_id int8 NOT NULL, course_name varchar(100) NOT NULL, total_questions int2 DEFAULT 0 NULL, new_questions int2 DEFAULT 0 NULL, repeated_year int2 DEFAULT 0 NULL, repeated_history int2 DEFAULT 0 NULL, deleted_at timestamp NULL, created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, CONSTRAINT material_ballot_stats_area_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_ballot_stats_area_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_ballot_stats_area_courses TO postgres;


-- odiseo.material_ballot_stats_areas definition

-- Drop table

-- DROP TABLE odiseo.material_ballot_stats_areas;

CREATE TABLE odiseo.material_ballot_stats_areas ( id bigserial NOT NULL, global_stats_id int8 NOT NULL, area_name varchar(100) NOT NULL, total_questions int2 DEFAULT 0 NULL, new_questions int2 DEFAULT 0 NULL, repeated_year int2 DEFAULT 0 NULL, repeated_history int2 DEFAULT 0 NULL, deleted_at timestamp NULL, created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, CONSTRAINT material_ballot_stats_areas_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_ballot_stats_areas OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_ballot_stats_areas TO postgres;


-- odiseo.material_ballot_stats_global definition

-- Drop table

-- DROP TABLE odiseo.material_ballot_stats_global;

CREATE TABLE odiseo.material_ballot_stats_global ( id bigserial NOT NULL, material_per_period_ballot_id int8 NOT NULL, number_pages int2 DEFAULT 0 NULL, total_questions int2 DEFAULT 0 NULL, new_questions int2 DEFAULT 0 NULL, repeated_year int2 DEFAULT 0 NULL, repeated_history int2 DEFAULT 0 NULL, created_by int4 NOT NULL, updated_by int4 NOT NULL, deleted_by int4 NULL, deleted_at timestamp NULL, created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL, CONSTRAINT material_ballot_stats_global_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_ballot_stats_global OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_ballot_stats_global TO postgres;


-- odiseo.material_ballot_subquestions definition

-- Drop table

-- DROP TABLE odiseo.material_ballot_subquestions;

CREATE TABLE odiseo.material_ballot_subquestions ( id bigserial NOT NULL, material_ballot_question_id int8 NOT NULL, question_id int8 NULL, "position" int2 NOT NULL, state varchar(30) DEFAULT 'MISSING'::character varying NOT NULL, course_id int2 NULL, topic_id int2 NULL, subtopic_id int2 NULL, fl_status bool DEFAULT true NOT NULL, fl_is_manual bool NULL, added_in_completion bool NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT chk_mbs_state_consistency CHECK (((((state)::text = 'MISSING'::text) AND (question_id IS NULL)) OR (((state)::text = 'MANUAL_REMOVED'::text) AND (question_id IS NULL)) OR (((state)::text = 'GENERATED'::text) AND (question_id IS NOT NULL) AND (COALESCE(added_in_completion, false) = false)) OR (((state)::text = 'AUTO_COMPLETED'::text) AND (question_id IS NOT NULL) AND (COALESCE(added_in_completion, false) = true) AND (COALESCE(fl_is_manual, false) = false)) OR (((state)::text = 'MANUAL_COMPLETED'::text) AND (question_id IS NOT NULL) AND (COALESCE(added_in_completion, false) = true) AND (COALESCE(fl_is_manual, false) = true)))), CONSTRAINT material_ballot_subquestions_pkey PRIMARY KEY (id));
CREATE INDEX idx_mbs_parent_q ON odiseo.material_ballot_subquestions USING btree (material_ballot_question_id);

-- Permissions

ALTER TABLE odiseo.material_ballot_subquestions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_ballot_subquestions TO postgres;


-- odiseo.material_class_week definition

-- Drop table

-- DROP TABLE odiseo.material_class_week;

CREATE TABLE odiseo.material_class_week ( id bigserial NOT NULL, material_id int8 NOT NULL, type_material_id int2 NOT NULL, week_type_material_ids varchar(255) NULL, week int2 NOT NULL, course_id int2 NOT NULL, fl_process_status int2 DEFAULT '1'::smallint NOT NULL, url_material_class varchar(255) NULL, job_id varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, url_material_class_solution varchar(255) NULL, fl_course_active bool DEFAULT true NOT NULL, CONSTRAINT material_class_week_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_class_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_class_week TO postgres;


-- odiseo.material_column_configurations definition

-- Drop table

-- DROP TABLE odiseo.material_column_configurations;

CREATE TABLE odiseo.material_column_configurations ( id bigserial NOT NULL, material_configuration_id int8 NOT NULL, course_id int8 NULL, topic_id int8 NULL, column_count int8 DEFAULT '2'::bigint NOT NULL, column_width numeric(5, 2) DEFAULT '9'::numeric NOT NULL, column_spacing numeric(5, 2) DEFAULT '1'::numeric NOT NULL, layout_format varchar(255) NULL, number_format varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_column_configurations_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_column_configurations OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_column_configurations TO postgres;


-- odiseo.material_configuration_detail_value definition

-- Drop table

-- DROP TABLE odiseo.material_configuration_detail_value;

CREATE TABLE odiseo.material_configuration_detail_value ( id bigserial NOT NULL, material_configuration_detail_id int8 NOT NULL, template_type_material_configuration_id int8 NULL, value text NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_configuration_detail_value_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_configuration_detail_value OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_configuration_detail_value TO postgres;


-- odiseo.material_configuration_details definition

-- Drop table

-- DROP TABLE odiseo.material_configuration_details;

CREATE TABLE odiseo.material_configuration_details ( id bigserial NOT NULL, material_configuration_id int8 NOT NULL, "name" varchar(150) NOT NULL, value varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_configuration_details_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_configuration_details OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_configuration_details TO postgres;


-- odiseo.material_configurations definition

-- Drop table

-- DROP TABLE odiseo.material_configurations;

CREATE TABLE odiseo.material_configurations ( id bigserial NOT NULL, company_id int8 NOT NULL, category varchar(150) NOT NULL, "element" varchar(150) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, is_global bool DEFAULT true NOT NULL, CONSTRAINT material_configurations_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_configurations OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_configurations TO postgres;


-- odiseo.material_distribution_ballot_questions definition

-- Drop table

-- DROP TABLE odiseo.material_distribution_ballot_questions;

CREATE TABLE odiseo.material_distribution_ballot_questions ( id bigserial NOT NULL, material_id int8 NOT NULL, week int2 NOT NULL, type_material_id int2 NOT NULL, week_type_material_id int8 NOT NULL, course_id int2 NOT NULL, "position" int2 NOT NULL, position_initial int2 NOT NULL, subtopic_id int8 NULL, topic_id int2 NULL, level_id int8 NOT NULL, usage_level_id int8 NULL, question_id int8 NULL, "type" varchar(255) NULL, usage_status bool NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, absolute_position int2 NULL, added_in_completion bool DEFAULT false NOT NULL, removed_in_completion bool DEFAULT false NOT NULL, parent_question_id int4 NULL, subquestion jsonb NULL, type_text_id int8 NULL, type_text_subcategory_id int8 NULL, expected_type varchar(255) NULL, completed_subquestion bool DEFAULT false NOT NULL, usage_topic_id int8 NULL, usage_subtopic_id int8 NULL, CONSTRAINT material_distribution_ballot_questions_pkey PRIMARY KEY (id), CONSTRAINT material_distribution_ballot_questions_type_check CHECK (((type)::text = ANY (ARRAY[('T'::character varying)::text, ('D'::character varying)::text]))));
CREATE INDEX idx_mdbq_course_lookup_status ON odiseo.material_distribution_ballot_questions USING btree (material_id, week, week_type_material_id) WHERE (fl_status = true);
CREATE INDEX idx_mdbq_upsert_lookup ON odiseo.material_distribution_ballot_questions USING btree (material_id, week, course_id) WHERE ((fl_status = true) AND (question_id IS NULL) AND (type_text_id IS NULL) AND (deleted_at IS NULL));

-- Permissions

ALTER TABLE odiseo.material_distribution_ballot_questions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_distribution_ballot_questions TO postgres;


-- odiseo.material_exam_area_week definition

-- Drop table

-- DROP TABLE odiseo.material_exam_area_week;

CREATE TABLE odiseo.material_exam_area_week ( id bigserial NOT NULL, week_type_material_id int8 NOT NULL, area_id int2 NOT NULL, url_solution varchar(255) NULL, url_without_solution varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_process_status int2 DEFAULT '1'::smallint NOT NULL, fl_process_status_without int2 DEFAULT '1'::smallint NOT NULL, job_solution_id varchar(255) NULL, job_without_solution_id varchar(255) NULL, fl_process_quality int2 DEFAULT '1'::smallint NOT NULL, url_quality varchar(255) NULL, job_quality_id varchar(255) NULL, fl_process_without_quality int2 DEFAULT '1'::smallint NOT NULL, url_without_quality varchar(255) NULL, job_without_quality_id varchar(255) NULL, fl_complete_questions bool DEFAULT true NOT NULL, data_incomplete_questions varchar(255) NULL, fl_config_type bool DEFAULT false NOT NULL, limit_lower_question int2 NULL, limit_upper_question int2 NULL, missing_config_message varchar(255) NULL, data_missing_course_config varchar(255) NULL, filename varchar(255) NULL, number_pages int2 NULL, has_migrated bool DEFAULT false NOT NULL, CONSTRAINT material_exam_area_week_pkey PRIMARY KEY (id), CONSTRAINT uq_week_ty_mat_id_area_id UNIQUE (week_type_material_id, area_id));

-- Column comments

COMMENT ON COLUMN odiseo.material_exam_area_week.url_solution IS 'url del material con solucionario';
COMMENT ON COLUMN odiseo.material_exam_area_week.url_without_solution IS 'url del material sin solucionario';

-- Permissions

ALTER TABLE odiseo.material_exam_area_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_area_week TO postgres;


-- odiseo.material_exam_parent_question definition

-- Drop table

-- DROP TABLE odiseo.material_exam_parent_question;

CREATE TABLE odiseo.material_exam_parent_question ( id bigserial NOT NULL, material_exam_area_week_id int8 NOT NULL, course_id int2 NOT NULL, parent_question_id int8 NULL, subquestion jsonb NULL, question_history_id int8 NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "position" int2 NULL, random bool NULL, expected_level int2 NULL, current_level int2 NULL, CONSTRAINT material_exam_parent_question_pkey PRIMARY KEY (id), CONSTRAINT uq_parent_question_in_area UNIQUE (material_exam_area_week_id, course_id, parent_question_id));

-- Permissions

ALTER TABLE odiseo.material_exam_parent_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_parent_question TO postgres;


-- odiseo.material_exam_question definition

-- Drop table

-- DROP TABLE odiseo.material_exam_question;

CREATE TABLE odiseo.material_exam_question ( id bigserial NOT NULL, course_id int2 NOT NULL, topic_id int2 NULL, subtopic_id int2 NULL, level_id int8 NOT NULL, question_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, material_exam_area_week_id int8 NULL, question_history_id int8 NULL, "position" int2 NULL, fl_is_manual bool DEFAULT false NOT NULL, "type" varchar(20) NULL, CONSTRAINT material_exam_question_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_exam_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_question TO postgres;


-- odiseo.material_exam_stats_area_courses definition

-- Drop table

-- DROP TABLE odiseo.material_exam_stats_area_courses;

CREATE TABLE odiseo.material_exam_stats_area_courses ( id bigserial NOT NULL, area_stats_id int8 NOT NULL, course_name varchar(100) NOT NULL, total_questions int2 DEFAULT '0'::smallint NOT NULL, new_questions int2 DEFAULT '0'::smallint NOT NULL, repeated_year int2 DEFAULT '0'::smallint NOT NULL, repeated_history int2 DEFAULT '0'::smallint NOT NULL, repeated_area int2 DEFAULT '0'::smallint NOT NULL, question_details jsonb DEFAULT '{}'::jsonb NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, course_id int8 NOT NULL, CONSTRAINT material_exam_stats_area_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_exam_stats_area_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_stats_area_courses TO postgres;


-- odiseo.material_exam_stats_areas definition

-- Drop table

-- DROP TABLE odiseo.material_exam_stats_areas;

CREATE TABLE odiseo.material_exam_stats_areas ( id bigserial NOT NULL, material_exam_stats_global_id int8 NOT NULL, area_name varchar(100) NOT NULL, total_questions int2 DEFAULT '0'::smallint NOT NULL, new_questions int2 DEFAULT '0'::smallint NOT NULL, repeated_year int2 DEFAULT '0'::smallint NOT NULL, repeated_history int2 DEFAULT '0'::smallint NOT NULL, repeated_area int2 DEFAULT '0'::smallint NOT NULL, question_details jsonb DEFAULT '{}'::jsonb NOT NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, area_id int8 NOT NULL, CONSTRAINT material_exam_stats_areas_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_exam_stats_areas OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_stats_areas TO postgres;


-- odiseo.material_exam_stats_global definition

-- Drop table

-- DROP TABLE odiseo.material_exam_stats_global;

CREATE TABLE odiseo.material_exam_stats_global ( id bigserial NOT NULL, detail_week_type_mat_id int8 NOT NULL, number_pages int2 DEFAULT '0'::smallint NOT NULL, total_questions int2 DEFAULT '0'::smallint NOT NULL, new_questions int2 DEFAULT '0'::smallint NOT NULL, repeated_year int2 DEFAULT '0'::smallint NOT NULL, repeated_history int2 DEFAULT '0'::smallint NOT NULL, repeated_area int2 DEFAULT '0'::smallint NOT NULL, created_by int4 NOT NULL, updated_by int4 NOT NULL, deleted_by int4 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, pages_details jsonb DEFAULT '[]'::jsonb NOT NULL, CONSTRAINT material_exam_stats_global_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_exam_stats_global OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_exam_stats_global TO postgres;


-- odiseo.material_generation_notifications definition

-- Drop table

-- DROP TABLE odiseo.material_generation_notifications;

CREATE TABLE odiseo.material_generation_notifications ( id bigserial NOT NULL, title varchar(255) NOT NULL, message varchar(255) NOT NULL, url_internal varchar(255) NULL, request_status varchar(255) DEFAULT 'success'::character varying NOT NULL, user_id int8 NOT NULL, created_by int8 NULL, "type" int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, fl_read bool DEFAULT false NOT NULL, read_at timestamp(0) NULL, created_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT material_generation_notifications_pkey PRIMARY KEY (id), CONSTRAINT material_generation_notifications_request_status_check CHECK (((request_status)::text = ANY (ARRAY[('success'::character varying)::text, ('failure'::character varying)::text]))));

-- Permissions

ALTER TABLE odiseo.material_generation_notifications OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_generation_notifications TO postgres;


-- odiseo.material_missing_question definition

-- Drop table

-- DROP TABLE odiseo.material_missing_question;

CREATE TABLE odiseo.material_missing_question ( id bigserial NOT NULL, material_id int8 NOT NULL, type_material_id int2 NOT NULL, week int2 NOT NULL, request_date timestamp(0) NOT NULL, expiration_date timestamp(0) GENERATED ALWAYS AS ((request_date + '3 days'::interval)) STORED NOT NULL, course_id int2 NOT NULL, status varchar(20) DEFAULT 'pending'::character varying NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT chk_mmq_status CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('completed'::character varying)::text, ('completed_late'::character varying)::text, ('expired'::character varying)::text, ('canceled'::character varying)::text]))), CONSTRAINT material_missing_question_pkey PRIMARY KEY (id));
CREATE INDEX idx_mmq_active_lookup ON odiseo.material_missing_question USING btree (material_id, type_material_id, week, course_id, status) WHERE (deleted_at IS NULL);
CREATE UNIQUE INDEX uk_material_missing_question_pending_idx ON odiseo.material_missing_question USING btree (material_id, week, course_id, type_material_id) WHERE ((status)::text = 'pending'::text);

-- Permissions

ALTER TABLE odiseo.material_missing_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_missing_question TO postgres;


-- odiseo.material_missing_question_detail definition

-- Drop table

-- DROP TABLE odiseo.material_missing_question_detail;

CREATE TABLE odiseo.material_missing_question_detail ( id bigserial NOT NULL, material_missing_question_id int8 NOT NULL, material_ballot_question_id int8 NOT NULL, question_id int8 NULL, employee_id int8 NULL, status varchar(20) DEFAULT 'pending'::character varying NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, assignment_type varchar(20) NULL, deleted_at timestamp(0) NULL, CONSTRAINT chk_mmqd_assignment_type CHECK (((assignment_type)::text = ANY (ARRAY[('auto'::character varying)::text, ('manual'::character varying)::text]))), CONSTRAINT chk_mmqd_status CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('completed'::character varying)::text, ('canceled'::character varying)::text, ('assigned'::character varying)::text]))), CONSTRAINT material_missing_question_detail_pkey PRIMARY KEY (id));
CREATE INDEX idx_mmqd_parent_dist_lookup ON odiseo.material_missing_question_detail USING btree (material_missing_question_id, material_ballot_question_id) WHERE (deleted_at IS NULL);
CREATE INDEX idx_mmqd_parent_status_lookup ON odiseo.material_missing_question_detail USING btree (material_missing_question_id, status) WHERE (deleted_at IS NULL);

-- Permissions

ALTER TABLE odiseo.material_missing_question_detail OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_missing_question_detail TO postgres;


-- odiseo.material_missing_question_tracking definition

-- Drop table

-- DROP TABLE odiseo.material_missing_question_tracking;

CREATE TABLE odiseo.material_missing_question_tracking ( id bigserial NOT NULL, material_missing_question_detail_id int8 NOT NULL, employee_id int8 NULL, "action" varchar(20) NOT NULL, assignment_type varchar(20) NULL, created_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT chk_mmq_tracking_action CHECK (((action)::text = ANY (ARRAY[('assigned'::character varying)::text, ('unassigned'::character varying)::text, ('reassigned'::character varying)::text, ('completed'::character varying)::text]))), CONSTRAINT chk_mmq_tracking_assignment_type CHECK (((assignment_type)::text = ANY (ARRAY[('auto'::character varying)::text, ('manual'::character varying)::text]))), CONSTRAINT material_missing_question_tracking_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_missing_question_tracking OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_missing_question_tracking TO postgres;


-- odiseo.material_per_period definition

-- Drop table

-- DROP TABLE odiseo.material_per_period;

CREATE TABLE odiseo.material_per_period ( id bigserial NOT NULL, material_id int8 NOT NULL, type_material_id int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_per_period_pkey PRIMARY KEY (id), CONSTRAINT per_material_and_type_id UNIQUE (material_id, type_material_id));

-- Permissions

ALTER TABLE odiseo.material_per_period OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period TO postgres;


-- odiseo.material_per_period_ballot definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_ballot;

CREATE TABLE odiseo.material_per_period_ballot ( id bigserial NOT NULL, material_per_period_id int8 NOT NULL, start_week int2 NOT NULL, end_week int2 NOT NULL, fl_config_type bool DEFAULT true NOT NULL, lower_level_limit int2 DEFAULT '0'::smallint NOT NULL, upper_level_limit int2 DEFAULT '0'::smallint NOT NULL, questions_missing_url varchar(255) NULL, courses_missing_url varchar(255) NULL, text_missing_url varchar(255) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_missing_questions bool DEFAULT false NOT NULL, fl_missing_courses bool DEFAULT false NOT NULL, fl_missing_text bool DEFAULT false NOT NULL, date_completed timestamp(0) NULL, user_completed_id int8 NULL, order_date timestamp(0) NULL, order_by_user_id int8 NULL, fl_use_optional_subtopics bool DEFAULT true NOT NULL, CONSTRAINT material_per_period_ballot_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX per_material_ba_and_type_id ON odiseo.material_per_period_ballot USING btree (material_per_period_id, start_week, end_week) WHERE (deleted_at IS NULL);

-- Permissions

ALTER TABLE odiseo.material_per_period_ballot OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_ballot TO postgres;


-- odiseo.material_per_period_ballot_class definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_ballot_class;

CREATE TABLE odiseo.material_per_period_ballot_class ( id bigserial NOT NULL, material_per_period_ballot_url_id int8 NOT NULL, course_id int2 NOT NULL, file_name varchar(255) NULL, fl_job_process varchar(255) DEFAULT 'unprocessed'::character varying NOT NULL, job_url varchar(255) NULL, job_id varchar(255) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_per_period_ballot_class_fl_job_process_check CHECK (((fl_job_process)::text = ANY (ARRAY[('unprocessed'::character varying)::text, ('pending'::character varying)::text, ('processing'::character varying)::text, ('completed'::character varying)::text, ('failed'::character varying)::text, ('canceled'::character varying)::text]))), CONSTRAINT material_per_period_ballot_class_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_per_period_ballot_class OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_ballot_class TO postgres;


-- odiseo.material_per_period_ballot_url definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_ballot_url;

CREATE TABLE odiseo.material_per_period_ballot_url ( id bigserial NOT NULL, material_per_period_ballot_id int8 NOT NULL, type_url varchar(255) NOT NULL, job_url varchar(255) NULL, job_id varchar(255) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, file_name varchar(255) NULL, fl_job_process varchar(255) DEFAULT 'unprocessed'::character varying NOT NULL, retries int2 DEFAULT '0'::smallint NOT NULL, number_pages int2 NULL, CONSTRAINT material_per_period_ballot_url_fl_job_process_check CHECK (((fl_job_process)::text = ANY (ARRAY[('unprocessed'::character varying)::text, ('pending'::character varying)::text, ('processing'::character varying)::text, ('completed'::character varying)::text, ('failed'::character varying)::text, ('canceled'::character varying)::text]))), CONSTRAINT material_per_period_ballot_url_pkey PRIMARY KEY (id), CONSTRAINT material_per_period_ballot_url_type_url_check CHECK (((type_url)::text = ANY (ARRAY[('solution'::character varying)::text, ('without_solution'::character varying)::text, ('review_solution'::character varying)::text, ('review_without_solution'::character varying)::text, ('material_class'::character varying)::text]))));

-- Permissions

ALTER TABLE odiseo.material_per_period_ballot_url OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_ballot_url TO postgres;


-- odiseo.material_per_period_course definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_course;

CREATE TABLE odiseo.material_per_period_course ( id bigserial NOT NULL, material_per_period_ballot_id int8 NOT NULL, course_id int2 NOT NULL, "type" varchar(255) NOT NULL, url varchar(255) NULL, job_id varchar(255) NULL, job_status varchar(255) DEFAULT 'unprocessed'::character varying NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, pages int2 DEFAULT '0'::smallint NOT NULL, retries int2 DEFAULT '0'::smallint NOT NULL, CONSTRAINT material_per_period_course_job_status_check CHECK (((job_status)::text = ANY (ARRAY[('unprocessed'::character varying)::text, ('pending'::character varying)::text, ('processing'::character varying)::text, ('completed'::character varying)::text, ('failed'::character varying)::text, ('canceled'::character varying)::text]))), CONSTRAINT material_per_period_course_pkey PRIMARY KEY (id), CONSTRAINT material_per_period_course_type_check CHECK (((type)::text = ANY (ARRAY[('solution'::character varying)::text, ('without_solution'::character varying)::text, ('review_solution'::character varying)::text, ('review_without_solution'::character varying)::text, ('material_class'::character varying)::text]))), CONSTRAINT period_id_course_type UNIQUE (material_per_period_ballot_id, course_id, type));

-- Permissions

ALTER TABLE odiseo.material_per_period_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_course TO postgres;


-- odiseo.material_per_period_exam definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_exam;

CREATE TABLE odiseo.material_per_period_exam ( id bigserial NOT NULL, material_per_period_id int8 NOT NULL, exam_area_id int8 NOT NULL, start_week int2 NOT NULL, end_week int2 NOT NULL, questions_missing_url varchar(255) NULL, courses_missing_url varchar(255) NULL, text_missing_url varchar(255) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_per_period_exam_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_per_period_exam OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_exam TO postgres;


-- odiseo.material_per_period_level_limit_config definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_level_limit_config;

CREATE TABLE odiseo.material_per_period_level_limit_config ( id bigserial NOT NULL, material_per_period_id int8 NOT NULL, start_week int2 NOT NULL, end_week int2 NOT NULL, lower_level_limit int2 DEFAULT '1'::smallint NOT NULL, upper_level_limit int2 DEFAULT '1'::smallint NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, fl_use_question_type bool DEFAULT true NOT NULL, fl_use_optional_subtopics bool DEFAULT true NOT NULL, CONSTRAINT material_per_period_level_limit_config_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_per_period_level_limit_config OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_level_limit_config TO postgres;


-- odiseo.material_per_period_week_course definition

-- Drop table

-- DROP TABLE odiseo.material_per_period_week_course;

CREATE TABLE odiseo.material_per_period_week_course ( id bigserial NOT NULL, material_per_period_ballot_id int8 NOT NULL, course_id int2 NOT NULL, week int2 NOT NULL, "type" varchar(255) NOT NULL, url varchar(255) NULL, job_id varchar(255) NULL, job_status varchar(255) DEFAULT 'unprocessed'::character varying NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT material_per_period_week_course_job_status_check CHECK (((job_status)::text = ANY (ARRAY[('unprocessed'::character varying)::text, ('pending'::character varying)::text, ('processing'::character varying)::text, ('completed'::character varying)::text, ('failed'::character varying)::text, ('canceled'::character varying)::text]))), CONSTRAINT material_per_period_week_course_pkey PRIMARY KEY (id), CONSTRAINT material_per_period_week_course_type_check CHECK (((type)::text = ANY (ARRAY[('solution'::character varying)::text, ('without_solution'::character varying)::text, ('review_solution'::character varying)::text, ('review_without_solution'::character varying)::text, ('material_class'::character varying)::text]))), CONSTRAINT period_id_course_type_week UNIQUE (material_per_period_ballot_id, course_id, type, week));

-- Permissions

ALTER TABLE odiseo.material_per_period_week_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_per_period_week_course TO postgres;


-- odiseo.material_question_change_reason definition

-- Drop table

-- DROP TABLE odiseo.material_question_change_reason;

CREATE TABLE odiseo.material_question_change_reason ( id bigserial NOT NULL, material_revision_course_id int8 NOT NULL, material_ballot_question_id int8 NOT NULL, old_question_id int8 NOT NULL, new_question_id int8 NOT NULL, reason text NOT NULL, created_by int8 NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT material_question_change_reason_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_question_change_reason OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_question_change_reason TO postgres;


-- odiseo.material_revision_courses definition

-- Drop table

-- DROP TABLE odiseo.material_revision_courses;

CREATE TABLE odiseo.material_revision_courses ( id bigserial NOT NULL, material_revision_id int8 NOT NULL, course_id int2 NOT NULL, verify_date timestamp(0) NULL, verified_by int8 NULL, status varchar(50) DEFAULT 'pending_verification'::character varying NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, amount_questions_changed int2 DEFAULT '0'::smallint NOT NULL, CONSTRAINT chk_mat_rev_course_status CHECK (((status)::text = ANY (ARRAY[('pending_verification'::character varying)::text, ('verified'::character varying)::text]))), CONSTRAINT material_revision_courses_pkey PRIMARY KEY (id), CONSTRAINT uk_mat_rev_course UNIQUE (material_revision_id, course_id));

-- Permissions

ALTER TABLE odiseo.material_revision_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_revision_courses TO postgres;


-- odiseo.material_revision_histories definition

-- Drop table

-- DROP TABLE odiseo.material_revision_histories;

CREATE TABLE odiseo.material_revision_histories ( id bigserial NOT NULL, material_revision_id int8 NOT NULL, old_status varchar(50) NULL, new_status varchar(50) NOT NULL, changed_by int8 NOT NULL, changed_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT material_revision_histories_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_revision_histories OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_revision_histories TO postgres;


-- odiseo.material_revision_items definition

-- Drop table

-- DROP TABLE odiseo.material_revision_items;

CREATE TABLE odiseo.material_revision_items ( id bigserial NOT NULL, material_revision_id int8 NOT NULL, detail_week_type_mat_id int8 NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, CONSTRAINT material_revision_items_pkey PRIMARY KEY (id), CONSTRAINT uk_mat_rev_item UNIQUE (material_revision_id, detail_week_type_mat_id));

-- Permissions

ALTER TABLE odiseo.material_revision_items OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_revision_items TO postgres;


-- odiseo.material_revisions definition

-- Drop table

-- DROP TABLE odiseo.material_revisions;

CREATE TABLE odiseo.material_revisions ( id bigserial NOT NULL, material_id int8 NOT NULL, type_material_id int2 NOT NULL, start_week int2 NOT NULL, end_week int2 NOT NULL, delivery_date timestamp(0) NOT NULL, verify_date timestamp(0) NULL, verified_by int8 NULL, status varchar(50) DEFAULT 'queued'::character varying NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, CONSTRAINT chk_material_revision_status CHECK (((status)::text = ANY (ARRAY[('queued'::character varying)::text, ('generating'::character varying)::text, ('pdf_delivered'::character varying)::text, ('verified'::character varying)::text, ('material_delivered'::character varying)::text]))), CONSTRAINT material_revisions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.material_revisions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.material_revisions TO postgres;


-- odiseo.modality definition

-- Drop table

-- DROP TABLE odiseo.modality;

CREATE TABLE odiseo.modality ( id smallserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, option_ids _int4 DEFAULT ARRAY[]::integer[] NULL, university_ids _int4 DEFAULT ARRAY[]::integer[] NULL, fl_allows_mark_frequent_topic bool DEFAULT false NOT NULL, CONSTRAINT modality_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.modality OWNER TO postgres;
GRANT ALL ON TABLE odiseo.modality TO postgres;


-- odiseo.modality_options definition

-- Drop table

-- DROP TABLE odiseo.modality_options;

CREATE TABLE odiseo.modality_options ( id bigserial NOT NULL, "name" varchar(255) NULL, option_university_id int8 NOT NULL, fl_allows_mark_frequent_topic bool DEFAULT false NOT NULL, created_by int8 NOT NULL, created_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, updated_by int8 NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int8 NULL, CONSTRAINT modality_options_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.modality_options OWNER TO postgres;
GRANT ALL ON TABLE odiseo.modality_options TO postgres;


-- odiseo.network_course_topic_subtopic definition

-- Drop table

-- DROP TABLE odiseo.network_course_topic_subtopic;

CREATE TABLE odiseo.network_course_topic_subtopic ( id bigserial NOT NULL, "uuid" uuid NULL, course_id int4 NULL, topic_id int4 NULL, subtopic_id int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, created_by int4 NULL, updated_by int4 NULL, deleted_by int4 NULL, deleted_at timestamp(0) NULL, new_name_topic varchar(255) NOT NULL, last_name_topic varchar(255) NOT NULL, new_name_subtopic varchar(255) NOT NULL, last_name_subtopic varchar(255) NOT NULL, CONSTRAINT network_course_topic_subtopic_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX idx_unique_uuid_course_topic_subtopic ON odiseo.network_course_topic_subtopic USING btree (uuid, course_id, topic_id, subtopic_id) WHERE (deleted_at IS NULL);

-- Permissions

ALTER TABLE odiseo.network_course_topic_subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.network_course_topic_subtopic TO postgres;


-- odiseo.nq_user_request definition

-- Drop table

-- DROP TABLE odiseo.nq_user_request;

CREATE TABLE odiseo.nq_user_request ( id bigserial NOT NULL, user_id int8 NOT NULL, request_status varchar(255) DEFAULT 'to_be_requested'::character varying NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT nq_req_user_id UNIQUE (user_id), CONSTRAINT nq_user_id UNIQUE (user_id), CONSTRAINT nq_user_request_pkey PRIMARY KEY (id), CONSTRAINT nq_user_request_request_status_check CHECK (((request_status)::text = ANY (ARRAY[('to_be_requested'::character varying)::text, ('failed'::character varying)::text, ('requested'::character varying)::text, ('delivered'::character varying)::text]))));

-- Permissions

ALTER TABLE odiseo.nq_user_request OWNER TO postgres;
GRANT ALL ON TABLE odiseo.nq_user_request TO postgres;


-- odiseo.nq_user_token definition

-- Drop table

-- DROP TABLE odiseo.nq_user_token;

CREATE TABLE odiseo.nq_user_token ( id bigserial NOT NULL, user_id int8 NOT NULL, nq_user varchar(255) NOT NULL, nq_token varchar(255) NOT NULL, nq_expiration_date timestamp(0) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT nq_user_token_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.nq_user_token OWNER TO postgres;
GRANT ALL ON TABLE odiseo.nq_user_token TO postgres;


-- odiseo."option" definition

-- Drop table

-- DROP TABLE odiseo."option";

CREATE TABLE odiseo."option" ( id smallserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, university_ids _int4 DEFAULT ARRAY[]::integer[] NULL, CONSTRAINT option_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo."option" OWNER TO postgres;
GRANT ALL ON TABLE odiseo."option" TO postgres;


-- odiseo.option_university definition

-- Drop table

-- DROP TABLE odiseo.option_university;

CREATE TABLE odiseo.option_university ( id bigserial NOT NULL, "name" varchar(255) NULL, university_id int8 NULL, created_by int8 NOT NULL, created_at timestamp(0) DEFAULT CURRENT_TIMESTAMP NOT NULL, updated_by int8 NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int8 NULL, CONSTRAINT option_university_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.option_university OWNER TO postgres;
GRANT ALL ON TABLE odiseo.option_university TO postgres;


-- odiseo.origin_parent_question definition

-- Drop table

-- DROP TABLE odiseo.origin_parent_question;

CREATE TABLE odiseo.origin_parent_question ( id bigserial NOT NULL, parent_id int8 NOT NULL, "year" varchar(4) NOT NULL, region_id int8 NOT NULL, university_id int2 NULL, option_id int2 NULL, modality_id int2 NULL, areas varchar(255) NULL, "version" int2 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, modality_option_id int4 NULL, CONSTRAINT origin_parent_question_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.origin_parent_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.origin_parent_question TO postgres;


-- odiseo.origin_question definition

-- Drop table

-- DROP TABLE odiseo.origin_question;

CREATE TABLE odiseo.origin_question ( id bigserial NOT NULL, question_id int8 NOT NULL, "year" varchar(4) NOT NULL, region_id int8 NOT NULL, university_id int2 NULL, option_id int2 NULL, modality_id int2 NULL, areas varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "version" int2 NULL, modality_option_id int4 NULL, CONSTRAINT origin_question_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.origin_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.origin_question TO postgres;


-- odiseo.origin_question_nq definition

-- Drop table

-- DROP TABLE odiseo.origin_question_nq;

CREATE TABLE odiseo.origin_question_nq ( id bigserial NOT NULL, question_ia_id int8 NOT NULL, question_id int8 NOT NULL, date_revised timestamp(0) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT origin_question_nq_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.origin_question_nq OWNER TO postgres;
GRANT ALL ON TABLE odiseo.origin_question_nq TO postgres;


-- odiseo.origin_university definition

-- Drop table

-- DROP TABLE odiseo.origin_university;

CREATE TABLE odiseo.origin_university ( id smallserial NOT NULL, "name" varchar(255) NOT NULL, "type" int2 NOT NULL, fl_active bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, slug varchar(10) NULL, region_id int2 NULL, areas text DEFAULT '[]'::text NOT NULL, code varchar(255) NULL, versions text DEFAULT '[]'::text NOT NULL, CONSTRAINT origin_university_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.origin_university OWNER TO postgres;
GRANT ALL ON TABLE odiseo.origin_university TO postgres;


-- odiseo.parent_image definition

-- Drop table

-- DROP TABLE odiseo.parent_image;

CREATE TABLE odiseo.parent_image ( id bigserial NOT NULL, code varchar(50) NOT NULL, "extension" varchar(10) NULL, image text NOT NULL, parent_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT parent_image_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.parent_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.parent_image TO postgres;


-- odiseo.parent_observation definition

-- Drop table

-- DROP TABLE odiseo.parent_observation;

CREATE TABLE odiseo.parent_observation ( id bigserial NOT NULL, description text NOT NULL, similitaries text DEFAULT '[]'::text NOT NULL, parent_id int8 NOT NULL, "type" varchar(5) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT parent_observation_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.parent_observation OWNER TO postgres;
GRANT ALL ON TABLE odiseo.parent_observation TO postgres;


-- odiseo.parent_question definition

-- Drop table

-- DROP TABLE odiseo.parent_question;

CREATE TABLE odiseo.parent_question ( id bigserial NOT NULL, code varchar(25) NULL, description text NOT NULL, number_question varchar(255) NULL, "number" varchar(10) NULL, course_id int2 NOT NULL, status varchar(5) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, university_id int2 NULL, "year" varchar(4) NULL, option_id int2 NULL, modality_id int2 NULL, "version" varchar(2) NULL, authorship varchar(255) NULL, fl_diagrammed bool DEFAULT false NOT NULL, url_pdf varchar(255) NULL, region varchar(255) NULL, area varchar(255) NULL, short_description text NULL, code_parent_uniq text NULL, type_text_id int8 NULL, text_traduction text NULL, short_text_traduction text NULL, description_b text NULL, short_description_b text NULL, level_id int8 NULL, type_text_subcategory_id int8 NULL, "columns" int2 DEFAULT '1'::smallint NULL, search_text text NULL, priority int4 NULL, CONSTRAINT chk_parent_question_priority CHECK (((priority = ANY (ARRAY[1, 4, 7])) OR (priority IS NULL))), CONSTRAINT odiseo_parent_question_code_unique UNIQUE (code), CONSTRAINT parent_question_pkey PRIMARY KEY (id));

-- Table Triggers

create trigger trigger_parent_rebuild_after after
insert
    or
update
    on
    odiseo.parent_question for each row execute function odiseo.trg_update_parent_from_self();

-- Permissions

ALTER TABLE odiseo.parent_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.parent_question TO postgres;


-- odiseo.parent_question_correlative definition

-- Drop table

-- DROP TABLE odiseo.parent_question_correlative;

CREATE TABLE odiseo.parent_question_correlative ( id bigserial NOT NULL, course_id int4 NOT NULL, correlative int4 NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_by int4 NULL, deleted_at timestamp(0) NULL, CONSTRAINT parent_question_correlative_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.parent_question_correlative OWNER TO postgres;
GRANT ALL ON TABLE odiseo.parent_question_correlative TO postgres;


-- odiseo.periodicity definition

-- Drop table

-- DROP TABLE odiseo.periodicity;

CREATE TABLE odiseo.periodicity ( id smallserial NOT NULL, "name" varchar(20) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, quantity int2 NULL, CONSTRAINT periodicity_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.periodicity OWNER TO postgres;
GRANT ALL ON TABLE odiseo.periodicity TO postgres;


-- odiseo.permissions definition

-- Drop table

-- DROP TABLE odiseo.permissions;

CREATE TABLE odiseo.permissions ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "module" varchar(255) NULL, fl_administrator bool DEFAULT false NOT NULL, fl_to_use_client bool DEFAULT false NOT NULL, CONSTRAINT odiseo_permissions_name_unique UNIQUE (name), CONSTRAINT permissions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.permissions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.permissions TO postgres;


-- odiseo."plans" definition

-- Drop table

-- DROP TABLE odiseo."plans";

CREATE TABLE odiseo."plans" ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, description varchar(255) NOT NULL, "cost" numeric(20, 2) DEFAULT '0'::numeric NOT NULL, benefits varchar(255) NOT NULL, number_users int2 DEFAULT '0'::smallint NOT NULL, number_questions int2 DEFAULT '0'::smallint NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT plans_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo."plans" OWNER TO postgres;
GRANT ALL ON TABLE odiseo."plans" TO postgres;


-- odiseo.prospect definition

-- Drop table

-- DROP TABLE odiseo.prospect;

CREATE TABLE odiseo.prospect ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, charge varchar(255) NOT NULL, type_company varchar(255) NOT NULL, name_institute varchar(255) NOT NULL, document_number varchar(20) NOT NULL, code_id int8 NOT NULL, fl_validate bool DEFAULT false NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT prospect_pkey PRIMARY KEY (id), CONSTRAINT prospect_type_company_check CHECK (((type_company)::text = ANY (ARRAY[('Academia'::character varying)::text, ('Colegio'::character varying)::text]))));

-- Permissions

ALTER TABLE odiseo.prospect OWNER TO postgres;
GRANT ALL ON TABLE odiseo.prospect TO postgres;


-- odiseo.provinces definition

-- Drop table

-- DROP TABLE odiseo.provinces;

CREATE TABLE odiseo.provinces ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, region_id int8 NOT NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT provinces_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.provinces OWNER TO postgres;
GRANT ALL ON TABLE odiseo.provinces TO postgres;


-- odiseo.pseudo_course definition

-- Drop table

-- DROP TABLE odiseo.pseudo_course;

CREATE TABLE odiseo.pseudo_course ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, code varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT pseudo_course_pkey PRIMARY KEY (id), CONSTRAINT unique_code UNIQUE (code, fl_status), CONSTRAINT unique_name UNIQUE (name, fl_status));

-- Permissions

ALTER TABLE odiseo.pseudo_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.pseudo_course TO postgres;


-- odiseo.question definition

-- Drop table

-- DROP TABLE odiseo.question;

CREATE TABLE odiseo.question ( id bigserial NOT NULL, code varchar(25) NULL, description text NOT NULL, short_description text NOT NULL, number_question varchar(255) NULL, course_id int2 NOT NULL, topic_id int2 NULL, subtopic_id int2 NULL, level_id int2 NULL, teacher_id int8 NULL, answer_id int8 NULL, "type" varchar(255) NULL, ter numeric(10, 2) NULL, status varchar(5) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, "number" varchar(255) NULL, parent_id int8 NULL, "year" varchar(4) NULL, authorship varchar(255) NULL, fl_diagrammed bool DEFAULT false NOT NULL, url_pdf varchar(255) NULL, region varchar(255) NULL, area varchar(255) NULL, config_alternative_id int8 DEFAULT '1'::bigint NOT NULL, resv_to_veri_at timestamp(0) NULL, "columns" int2 DEFAULT '2'::smallint NOT NULL, math_migration_status varchar(255) DEFAULT 'NOT_MIGRATED'::character varying NOT NULL, migrated_updated_at timestamp(0) NULL, url_pdf_updated_at timestamp(0) NULL, status_changed_at timestamp(0) NULL, ia_generated bool DEFAULT false NOT NULL, priority int4 NULL, is_migrated bool DEFAULT false NOT NULL, search_text text GENERATED ALWAYS AS (lower(odiseo.fn_immutable_unaccent((COALESCE(code, ''::character varying)::text || ' '::text) || COALESCE(short_description, ''::text)))) STORED NULL, CONSTRAINT odiseo_question_code_unique UNIQUE (code), CONSTRAINT question_math_migration_status_check CHECK (((math_migration_status)::text = ANY (ARRAY[('NOT_MIGRATED'::character varying)::text, ('MIGRATING'::character varying)::text, ('MIGRATED'::character varying)::text, ('NOT_MIGRATABLE'::character varying)::text, ('MIGRATION_FAILURE'::character varying)::text]))), CONSTRAINT question_pkey PRIMARY KEY (id), CONSTRAINT question_type_check CHECK (((type)::text = ANY (ARRAY[('T'::character varying)::text, ('D'::character varying)::text]))));
CREATE INDEX idx_question_search_text_trgm ON odiseo.question USING gin (search_text extensions.gin_trgm_ops);
CREATE INDEX idx_question_short_description_trgm ON odiseo.question USING gin (lower(odiseo.fn_immutable_unaccent(short_description)) extensions.gin_trgm_ops);
CREATE INDEX question_parent_id_index ON odiseo.question USING btree (parent_id);

-- Table Triggers

create trigger trigger_update_parent_after after
insert
    or
delete
    or
update
    on
    odiseo.question for each row execute function odiseo.trg_update_parent_from_child();

-- Permissions

ALTER TABLE odiseo.question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question TO postgres;


-- odiseo.question_attributes definition

-- Drop table

-- DROP TABLE odiseo.question_attributes;

CREATE TABLE odiseo.question_attributes ( id bigserial NOT NULL, question_attributes_type_id int4 NOT NULL, question_id int4 NOT NULL, value varchar(255) NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT question_attributes_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_attributes OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_attributes TO postgres;


-- odiseo.question_attributes_type_course definition

-- Drop table

-- DROP TABLE odiseo.question_attributes_type_course;

CREATE TABLE odiseo.question_attributes_type_course ( id bigserial NOT NULL, question_attributes_type_id int4 NOT NULL, course_id int4 NOT NULL, types_questions varchar(255) NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT question_attributes_type_course_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_attributes_type_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_attributes_type_course TO postgres;


-- odiseo.question_excluded_material definition

-- Drop table

-- DROP TABLE odiseo.question_excluded_material;

CREATE TABLE odiseo.question_excluded_material ( id bigserial NOT NULL, material_id int8 NOT NULL, question_id int8 NOT NULL, excluded_at timestamp(0) NULL, created_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT question_excluded_material_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_excluded_material OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_excluded_material TO postgres;


-- odiseo.question_field_diagrammed_nq definition

-- Drop table

-- DROP TABLE odiseo.question_field_diagrammed_nq;

CREATE TABLE odiseo.question_field_diagrammed_nq ( id bigserial NOT NULL, question_teacher_ia_id int8 NOT NULL, field_diagrammed_id int8 NOT NULL, "content" text NULL, "position" int2 NULL, course_id int2 NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT question_field_diagrammed_nq_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_field_diagrammed_nq OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_field_diagrammed_nq TO postgres;


-- odiseo.question_history_course definition

-- Drop table

-- DROP TABLE odiseo.question_history_course;

CREATE TABLE odiseo.question_history_course ( id bigserial NOT NULL, question_id int8 NOT NULL, code varchar(25) NULL, "number" varchar(25) NULL, course_id int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT question_history_course_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_history_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_history_course TO postgres;


-- odiseo.question_history_cycle definition

-- Drop table

-- DROP TABLE odiseo.question_history_cycle;

CREATE TABLE odiseo.question_history_cycle ( id bigserial NOT NULL, question_id int8 NULL, cycle_id int8 NOT NULL, university_id int2 NOT NULL, headquarters_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, automatic bool DEFAULT true NOT NULL, parent_question_id int8 NULL, subquestion jsonb NULL, CONSTRAINT question_history_cycle_pkey PRIMARY KEY (id));
CREATE INDEX idx_qhc_covering_for_max_date ON odiseo.question_history_cycle USING btree (university_id, fl_status) INCLUDE (cycle_id, parent_question_id);
CREATE INDEX qhc_partial_active_idx ON odiseo.question_history_cycle USING btree (question_id, cycle_id, university_id, headquarters_id) WHERE (fl_status = true);

-- Permissions

ALTER TABLE odiseo.question_history_cycle OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_history_cycle TO postgres;


-- odiseo.question_history_usage_exam_parent_question definition

-- Drop table

-- DROP TABLE odiseo.question_history_usage_exam_parent_question;

CREATE TABLE odiseo.question_history_usage_exam_parent_question ( id bigserial NOT NULL, material_exam_area_week_id int8 NOT NULL, course_id int8 NOT NULL, parent_question_id int8 NULL, question_id int8 NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, automatic bool DEFAULT true NOT NULL, CONSTRAINT question_history_usage_exam_parent_question_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_history_usage_exam_parent_question OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_history_usage_exam_parent_question TO postgres;


-- odiseo.question_ia_images definition

-- Drop table

-- DROP TABLE odiseo.question_ia_images;

CREATE TABLE odiseo.question_ia_images ( id bigserial NOT NULL, code varchar(50) NOT NULL, "extension" varchar(15) NOT NULL, image text NOT NULL, question_ia_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT question_ia_images_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_ia_images OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_ia_images TO postgres;


-- odiseo.question_image definition

-- Drop table

-- DROP TABLE odiseo.question_image;

CREATE TABLE odiseo.question_image ( id bigserial NOT NULL, code varchar(50) NOT NULL, "extension" varchar(10) NULL, image text NOT NULL, question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT question_image_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_image OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_image TO postgres;


-- odiseo.question_maths definition

-- Drop table

-- DROP TABLE odiseo.question_maths;

CREATE TABLE odiseo.question_maths ( id bigserial NOT NULL, code varchar(50) NOT NULL, "path" varchar(255) NOT NULL, question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, properties json NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT question_maths_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_maths OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_maths TO postgres;


-- odiseo.question_observation definition

-- Drop table

-- DROP TABLE odiseo.question_observation;

CREATE TABLE odiseo.question_observation ( id bigserial NOT NULL, description text NOT NULL, similitaries text DEFAULT '[]'::text NOT NULL, question_id int8 NOT NULL, "type" varchar(5) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, boards_observation text DEFAULT '[]'::text NOT NULL, CONSTRAINT question_observation_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_observation OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_observation TO postgres;


-- odiseo.question_pdf_jobs definition

-- Drop table

-- DROP TABLE odiseo.question_pdf_jobs;

CREATE TABLE odiseo.question_pdf_jobs ( id bigserial NOT NULL, question_id int8 NOT NULL, process_type varchar(255) NOT NULL, status varchar(255) DEFAULT 'pending'::character varying NOT NULL, job_id varchar(255) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT question_pdf_jobs_pkey PRIMARY KEY (id));
CREATE INDEX idx_question_jobs_on_id_and_date ON odiseo.question_pdf_jobs USING btree (question_id, updated_at DESC);

-- Permissions

ALTER TABLE odiseo.question_pdf_jobs OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_pdf_jobs TO postgres;


-- odiseo.question_refuzed definition

-- Drop table

-- DROP TABLE odiseo.question_refuzed;

CREATE TABLE odiseo.question_refuzed ( id bigserial NOT NULL, category_rejected_id int2 NOT NULL, importance_rejected int2 NOT NULL, observation text NOT NULL, images text NULL, question_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_active bool DEFAULT true NOT NULL, CONSTRAINT question_refuzed_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_refuzed OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_refuzed TO postgres;


-- odiseo.question_secondary definition

-- Drop table

-- DROP TABLE odiseo.question_secondary;

CREATE TABLE odiseo.question_secondary ( id bigserial NOT NULL, code varchar(25) NOT NULL, question_id int4 NOT NULL, course_id int4 NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, updated_by int4 NULL, created_by int4 NULL, deleted_by int4 NULL, CONSTRAINT question_secondary_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_secondary OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_secondary TO postgres;


-- odiseo.question_shares definition

-- Drop table

-- DROP TABLE odiseo.question_shares;

CREATE TABLE odiseo.question_shares ( id bigserial NOT NULL, question_id int8 NOT NULL, code varchar(255) NOT NULL, topic_id int2 NOT NULL, subtopic_id int2 NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, course_id int4 NULL, CONSTRAINT question_shares_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_shares OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_shares TO postgres;


-- odiseo.question_status definition

-- Drop table

-- DROP TABLE odiseo.question_status;

CREATE TABLE odiseo.question_status ( id bigserial NOT NULL, question_id int8 NOT NULL, status varchar(5) NOT NULL, process varchar(255) NOT NULL, description varchar(255) NULL, created_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, fl_active bool DEFAULT true NOT NULL, CONSTRAINT question_status_pkey PRIMARY KEY (id));
CREATE INDEX idx_qs_qid_status_created_perf ON odiseo.question_status USING btree (question_id, status, created_at);
CREATE INDEX idx_qstatus_qid_status_active ON odiseo.question_status USING btree (question_id, status) WHERE (fl_active = true);

-- Table Triggers

create trigger trigger_update_status_date after
insert
    on
    odiseo.question_status for each row execute function odiseo.trg_update_question_status_date();

-- Permissions

ALTER TABLE odiseo.question_status OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_status TO postgres;


-- odiseo.question_subtopic definition

-- Drop table

-- DROP TABLE odiseo.question_subtopic;

CREATE TABLE odiseo.question_subtopic ( id bigserial NOT NULL, question_id int4 NOT NULL, subtopic_id int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT question_subtopic_pkey PRIMARY KEY (id));
CREATE INDEX idx_question_subtopic_question_id ON odiseo.question_subtopic USING btree (question_id);

-- Permissions

ALTER TABLE odiseo.question_subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_subtopic TO postgres;


-- odiseo.question_teacher_ia definition

-- Drop table

-- DROP TABLE odiseo.question_teacher_ia;

CREATE TABLE odiseo.question_teacher_ia ( id bigserial NOT NULL, description text NOT NULL, course_id int2 NOT NULL, topic_id int2 NOT NULL, subtopic_id int2 NOT NULL, microtopic varchar(250) NULL, level_id int8 NOT NULL, answer_id int8 NULL, theoretical_basis text NULL, argumentation text NULL, file varchar(255) NULL, format varchar(255) NULL, "type" varchar(50) NULL, category varchar(255) NULL, subcategory varchar(255) NULL, teacher_id int8 NULL, status_revised bool DEFAULT false NOT NULL, fl_parent bool DEFAULT false NOT NULL, question_ia_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, description_short text NULL, answer_description text NULL, "version" int2 DEFAULT '1'::smallint NOT NULL, chat_feedback_id int8 NULL, nq_question_key uuid NULL, level_old_id int8 NULL, level_description text NULL, "content" varchar(1000) NULL, verification_started_at timestamp(0) NULL, verification_finished_at timestamp(0) NULL, CONSTRAINT question_teacher_ia_pkey PRIMARY KEY (id));

-- Column comments

COMMENT ON COLUMN odiseo.question_teacher_ia.category IS 'Solo se registra cuando es pregunta padre';
COMMENT ON COLUMN odiseo.question_teacher_ia.subcategory IS 'Solo se registra cuando es pregunta padre';
COMMENT ON COLUMN odiseo.question_teacher_ia.fl_parent IS 'Indica si es pregunta padre o no';
COMMENT ON COLUMN odiseo.question_teacher_ia.question_ia_id IS 'Si es pregunta hija, guarda el id de la pregunta padre';

-- Permissions

ALTER TABLE odiseo.question_teacher_ia OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_teacher_ia TO postgres;


-- odiseo.question_temporary definition

-- Drop table

-- DROP TABLE odiseo.question_temporary;

CREATE TABLE odiseo.question_temporary ( id bigserial NOT NULL, question_id int4 NOT NULL, cycle_id int4 NULL, week_id int2 NULL, type_material_id int2 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_material_template_id int2 NULL, CONSTRAINT question_temporary_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.question_temporary OWNER TO postgres;
GRANT ALL ON TABLE odiseo.question_temporary TO postgres;


-- odiseo.region definition

-- Drop table

-- DROP TABLE odiseo.region;

CREATE TABLE odiseo.region ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT region_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.region OWNER TO postgres;
GRANT ALL ON TABLE odiseo.region TO postgres;


-- odiseo.remembered_sessions definition

-- Drop table

-- DROP TABLE odiseo.remembered_sessions;

CREATE TABLE odiseo.remembered_sessions ( id bigserial NOT NULL, user_id int4 NOT NULL, remember_token varchar(500) NOT NULL, expires_at timestamp(0) NOT NULL, device_info varchar(255) NULL, ip_address inet NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT remembered_sessions_pkey PRIMARY KEY (id), CONSTRAINT remembered_sessions_remember_token_unique UNIQUE (remember_token));
CREATE INDEX remembered_sessions_remember_token_index ON odiseo.remembered_sessions USING btree (remember_token);
CREATE INDEX remembered_sessions_user_id_expires_at_index ON odiseo.remembered_sessions USING btree (user_id, expires_at);

-- Permissions

ALTER TABLE odiseo.remembered_sessions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.remembered_sessions TO postgres;


-- odiseo.roles definition

-- Drop table

-- DROP TABLE odiseo.roles;

CREATE TABLE odiseo.roles ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, slug varchar(50) NULL, description text NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_admin bool DEFAULT false NOT NULL, fl_administrator bool DEFAULT false NOT NULL, company_id int4 DEFAULT 1 NOT NULL, CONSTRAINT roles_name_company_id_unique UNIQUE (name, company_id), CONSTRAINT roles_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX unique_active_role ON odiseo.roles USING btree (name, company_id) WHERE (fl_status = true);

-- Table Triggers

create trigger trg_audit_roles after
delete
    or
update
    on
    odiseo.roles for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo.roles OWNER TO postgres;
GRANT ALL ON TABLE odiseo.roles TO postgres;


-- odiseo.roles_permissions definition

-- Drop table

-- DROP TABLE odiseo.roles_permissions;

CREATE TABLE odiseo.roles_permissions ( id bigserial NOT NULL, rol_id int8 NOT NULL, permission_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int4 DEFAULT 1 NOT NULL, CONSTRAINT roles_permissions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.roles_permissions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.roles_permissions TO postgres;


-- odiseo.separated_material_exam_week definition

-- Drop table

-- DROP TABLE odiseo.separated_material_exam_week;

CREATE TABLE odiseo.separated_material_exam_week ( id bigserial NOT NULL, material_id int8 NOT NULL, material_exam_area_week_id int2 NOT NULL, week int2 NOT NULL, fl_solution bool NOT NULL, fl_quality bool NOT NULL, course_id int2 NOT NULL, fl_process_status int2 DEFAULT '1'::smallint NOT NULL, url_material varchar(255) NULL, job_id varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT separated_material_exam_week_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.separated_material_exam_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.separated_material_exam_week TO postgres;


-- odiseo.separated_material_week definition

-- Drop table

-- DROP TABLE odiseo.separated_material_week;

CREATE TABLE odiseo.separated_material_week ( id bigserial NOT NULL, material_id int8 NOT NULL, type_material_id int2 NOT NULL, week int2 NOT NULL, fl_solution bool NOT NULL, fl_quality bool NOT NULL, week_type_material_ids varchar(255) NULL, course_id int2 NOT NULL, fl_process_status int2 DEFAULT '1'::smallint NOT NULL, url_material varchar(255) NULL, job_id varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_course_active bool DEFAULT true NOT NULL, CONSTRAINT separated_material_week_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.separated_material_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.separated_material_week TO postgres;


-- odiseo.setting_diagrammed_courses definition

-- Drop table

-- DROP TABLE odiseo.setting_diagrammed_courses;

CREATE TABLE odiseo.setting_diagrammed_courses ( id bigserial NOT NULL, course_id int8 NOT NULL, "position" int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, field_diagram_id int8 NULL, category_text_id int8 NULL, fl_active bool DEFAULT true NOT NULL, fl_optional bool DEFAULT false NOT NULL, CONSTRAINT setting_diagrammed_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.setting_diagrammed_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.setting_diagrammed_courses TO postgres;


-- odiseo.solution_ia_images definition

-- Drop table

-- DROP TABLE odiseo.solution_ia_images;

CREATE TABLE odiseo.solution_ia_images ( id bigserial NOT NULL, code varchar(255) NOT NULL, "extension" varchar(15) NOT NULL, image varchar(255) NOT NULL, solution_ia_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_solution varchar(255) NULL, CONSTRAINT solution_ia_images_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.solution_ia_images OWNER TO postgres;
GRANT ALL ON TABLE odiseo.solution_ia_images TO postgres;


-- odiseo.subtopic definition

-- Drop table

-- DROP TABLE odiseo.subtopic;

CREATE TABLE odiseo.subtopic ( id smallserial NOT NULL, code varchar(3) NOT NULL, "name" varchar(300) NOT NULL, topic_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT subtopic_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.subtopic TO postgres;


-- odiseo.subtopic_history definition

-- Drop table

-- DROP TABLE odiseo.subtopic_history;

CREATE TABLE odiseo.subtopic_history ( id bigserial NOT NULL, subtopic_id int2 NOT NULL, topic_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT subtopic_history_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.subtopic_history OWNER TO postgres;
GRANT ALL ON TABLE odiseo.subtopic_history TO postgres;


-- odiseo.syllabus definition

-- Drop table

-- DROP TABLE odiseo.syllabus;

CREATE TABLE odiseo.syllabus ( id bigserial NOT NULL, university_id int2 NOT NULL, course_id int8 NULL, cycle_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, pseudo_course_id int8 NULL, is_disabled bool DEFAULT false NOT NULL, is_deleteable bool DEFAULT true NOT NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT chk_course_or_pseudo_syllabus CHECK ((((course_id IS NULL) AND (pseudo_course_id IS NOT NULL)) OR ((course_id IS NOT NULL) AND (pseudo_course_id IS NULL)))), CONSTRAINT syllabus_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus TO postgres;


-- odiseo.syllabus_detail_subtopic definition

-- Drop table

-- DROP TABLE odiseo.syllabus_detail_subtopic;

CREATE TABLE odiseo.syllabus_detail_subtopic ( id bigserial NOT NULL, syllabus_topic_week_id int8 NOT NULL, subtopic_id int2 NOT NULL, questions_amount int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, is_topic_modified bool DEFAULT false NOT NULL, is_subtopic_deleted bool DEFAULT false NOT NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_detail_subtopic_pkey PRIMARY KEY (id));
CREATE INDEX syllabus_detail_subtopic_syllabus_topic_week_id_fl_status_idx ON odiseo.syllabus_detail_subtopic USING btree (syllabus_topic_week_id, fl_status);
CREATE INDEX syllabus_detail_subtopic_syllabus_topic_week_id_fl_status_idx1 ON odiseo.syllabus_detail_subtopic USING btree (syllabus_topic_week_id, fl_status);

-- Permissions

ALTER TABLE odiseo.syllabus_detail_subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_detail_subtopic TO postgres;


-- odiseo.syllabus_subtopic_type_material definition

-- Drop table

-- DROP TABLE odiseo.syllabus_subtopic_type_material;

CREATE TABLE odiseo.syllabus_subtopic_type_material ( id bigserial NOT NULL, syllabus_detail_subtopic_id int8 NOT NULL, type_material_id int2 NOT NULL, questions_amount int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_subtopic_type_material_pkey PRIMARY KEY (id));
CREATE INDEX syllabus_subtopic_type_materi_syllabus_detail_subtopic_id__idx1 ON odiseo.syllabus_subtopic_type_material USING btree (syllabus_detail_subtopic_id, fl_status);
CREATE INDEX syllabus_subtopic_type_materi_syllabus_detail_subtopic_id_f_idx ON odiseo.syllabus_subtopic_type_material USING btree (syllabus_detail_subtopic_id, fl_status);

-- Permissions

ALTER TABLE odiseo.syllabus_subtopic_type_material OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_subtopic_type_material TO postgres;


-- odiseo.syllabus_template definition

-- Drop table

-- DROP TABLE odiseo.syllabus_template;

CREATE TABLE odiseo.syllabus_template ( id smallserial NOT NULL, university_id int2 NOT NULL, course_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, pseudo_course_id int8 NULL, company_id int4 NULL, CONSTRAINT chk_course_or_pseudo_syllabus_template CHECK ((((course_id IS NULL) AND (pseudo_course_id IS NOT NULL)) OR ((course_id IS NOT NULL) AND (pseudo_course_id IS NULL)))), CONSTRAINT syllabus_template_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX syllabus_tmpl_uni_course_co_unique ON odiseo.syllabus_template USING btree (university_id, course_id, company_id) WHERE ((fl_status = true) AND (deleted_at IS NULL));

-- Permissions

ALTER TABLE odiseo.syllabus_template OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_template TO postgres;


-- odiseo.syllabus_template_topic definition

-- Drop table

-- DROP TABLE odiseo.syllabus_template_topic;

CREATE TABLE odiseo.syllabus_template_topic ( id serial4 NOT NULL, syllabus_template_id int2 NOT NULL, topic_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int4 NULL, CONSTRAINT syllabus_template_topic_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX syllabus_tmpl_topic_tmpl_topic_co_unique ON odiseo.syllabus_template_topic USING btree (syllabus_template_id, topic_id, company_id) WHERE ((fl_status = true) AND (deleted_at IS NULL));

-- Permissions

ALTER TABLE odiseo.syllabus_template_topic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_template_topic TO postgres;


-- odiseo.syllabus_template_topic_subtopic definition

-- Drop table

-- DROP TABLE odiseo.syllabus_template_topic_subtopic;

CREATE TABLE odiseo.syllabus_template_topic_subtopic ( id bigserial NOT NULL, syllabus_template_topic_id int4 NOT NULL, subtopic_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int4 NULL, CONSTRAINT syllabus_template_topic_subtopic_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX syllabus_tmpl_sub_topic_sub_co_unique ON odiseo.syllabus_template_topic_subtopic USING btree (syllabus_template_topic_id, subtopic_id, company_id) WHERE ((fl_status = true) AND (deleted_at IS NULL));

-- Permissions

ALTER TABLE odiseo.syllabus_template_topic_subtopic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_template_topic_subtopic TO postgres;


-- odiseo.syllabus_text_content definition

-- Drop table

-- DROP TABLE odiseo.syllabus_text_content;

CREATE TABLE odiseo.syllabus_text_content ( id bigserial NOT NULL, syllabus_text_id int8 NOT NULL, subtopic_id int8 NOT NULL, quantity int2 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_text_content_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_text_content OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_text_content TO postgres;


-- odiseo.syllabus_text_detail definition

-- Drop table

-- DROP TABLE odiseo.syllabus_text_detail;

CREATE TABLE odiseo.syllabus_text_detail ( id bigserial NOT NULL, syllabus_text_id int4 NOT NULL, style_type varchar(3) NOT NULL, quantity int4 NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT syllabus_text_detail_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_text_detail OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_text_detail TO postgres;


-- odiseo.syllabus_text_distributions definition

-- Drop table

-- DROP TABLE odiseo.syllabus_text_distributions;

CREATE TABLE odiseo.syllabus_text_distributions ( id bigserial NOT NULL, syllabus_text_week_id int8 NOT NULL, type_material_id int8 NOT NULL, distribution_type varchar(255) DEFAULT 'TEXT'::character varying NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_text_distributions_distribution_type_check CHECK (((distribution_type)::text = ANY (ARRAY[('TEXT'::character varying)::text, ('QUESTION'::character varying)::text]))), CONSTRAINT syllabus_text_distributions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_text_distributions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_text_distributions TO postgres;


-- odiseo.syllabus_text_weeks definition

-- Drop table

-- DROP TABLE odiseo.syllabus_text_weeks;

CREATE TABLE odiseo.syllabus_text_weeks ( id bigserial NOT NULL, syllabus_id int8 NOT NULL, week int2 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_text_weeks_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_text_weeks OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_text_weeks TO postgres;


-- odiseo.syllabus_texts definition

-- Drop table

-- DROP TABLE odiseo.syllabus_texts;

CREATE TABLE odiseo.syllabus_texts ( id bigserial NOT NULL, syllabus_text_distribution_id int8 NOT NULL, type_text_id int8 NOT NULL, type_text_subcategory_id int8 NOT NULL, "position" int4 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_texts_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_texts OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_texts TO postgres;


-- odiseo.syllabus_topic definition

-- Drop table

-- DROP TABLE odiseo.syllabus_topic;

CREATE TABLE odiseo.syllabus_topic ( id bigserial NOT NULL, syllabus_id int8 NOT NULL, topic_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, is_topic_deleted bool DEFAULT false NOT NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_topic_pkey PRIMARY KEY (id));
CREATE INDEX idx_st_syllabus ON odiseo.syllabus_topic USING btree (syllabus_id);

-- Permissions

ALTER TABLE odiseo.syllabus_topic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_topic TO postgres;


-- odiseo.syllabus_topic_week definition

-- Drop table

-- DROP TABLE odiseo.syllabus_topic_week;

CREATE TABLE odiseo.syllabus_topic_week ( id bigserial NOT NULL, syllabus_topic_id int8 NOT NULL, week int2 NOT NULL, total_questions_amount int2 DEFAULT '0'::smallint NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_topic_week_pkey PRIMARY KEY (id));
CREATE INDEX idx_stw_topic_week_lookup ON odiseo.syllabus_topic_week USING btree (week, syllabus_topic_id) WHERE ((fl_status = true) AND (total_questions_amount > 0));
CREATE INDEX syllabus_topic_week_syllabus_topic_id_fl_status_idx ON odiseo.syllabus_topic_week USING btree (syllabus_topic_id, fl_status);
CREATE INDEX syllabus_topic_week_syllabus_topic_id_fl_status_idx1 ON odiseo.syllabus_topic_week USING btree (syllabus_topic_id, fl_status);

-- Permissions

ALTER TABLE odiseo.syllabus_topic_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_topic_week TO postgres;


-- odiseo.syllabus_type_text definition

-- Drop table

-- DROP TABLE odiseo.syllabus_type_text;

CREATE TABLE odiseo.syllabus_type_text ( id bigserial NOT NULL, type_text_id int8 NOT NULL, syllabus_id int8 NOT NULL, week int4 NOT NULL, quantity int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, deleted_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT syllabus_type_text_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.syllabus_type_text OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_type_text TO postgres;


-- odiseo.syllabus_week_titles definition

-- Drop table

-- DROP TABLE odiseo.syllabus_week_titles;

CREATE TABLE odiseo.syllabus_week_titles ( id bigserial NOT NULL, syllabus_id int8 NOT NULL, title varchar(255) NULL, week int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT syllabus_week_titles_pkey PRIMARY KEY (id));
CREATE UNIQUE INDEX idx_syllabus_week_titles_syllabus_id_week_active ON odiseo.syllabus_week_titles USING btree (syllabus_id, week) WHERE (fl_status IS TRUE);

-- Permissions

ALTER TABLE odiseo.syllabus_week_titles OWNER TO postgres;
GRANT ALL ON TABLE odiseo.syllabus_week_titles TO postgres;


-- odiseo.teachers definition

-- Drop table

-- DROP TABLE odiseo.teachers;

CREATE TABLE odiseo.teachers ( id bigserial NOT NULL, employee_id int8 NOT NULL, code varchar(20) NULL, limit_assigned_questions int2 DEFAULT '0'::smallint NOT NULL, limit_assigned_questions_initial int2 DEFAULT '0'::smallint NOT NULL, fl_unlimit_questions bool DEFAULT false NOT NULL, level_rate_id int8 NULL, goal int2 DEFAULT '0'::smallint NOT NULL, lot int2 DEFAULT '0'::smallint NOT NULL, fl_active bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 NOT NULL, limit_missing_questions int4 DEFAULT 15 NOT NULL, fl_resolve_missing_questions bool DEFAULT false NOT NULL, CONSTRAINT teachers_code_company_unique UNIQUE (code, company_id), CONSTRAINT teachers_employee_id_unique UNIQUE (employee_id), CONSTRAINT teachers_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.teachers OWNER TO postgres;
GRANT ALL ON TABLE odiseo.teachers TO postgres;


-- odiseo.template_type_material_configurations definition

-- Drop table

-- DROP TABLE odiseo.template_type_material_configurations;

CREATE TABLE odiseo.template_type_material_configurations ( id bigserial NOT NULL, type_material_template_id int8 NOT NULL, exam_area_id int8 NULL, company_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_template_id int8 NULL, CONSTRAINT template_type_material_configurations_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.template_type_material_configurations OWNER TO postgres;
GRANT ALL ON TABLE odiseo.template_type_material_configurations TO postgres;


-- odiseo.template_type_material_courses_order definition

-- Drop table

-- DROP TABLE odiseo.template_type_material_courses_order;

CREATE TABLE odiseo.template_type_material_courses_order ( id bigserial NOT NULL, template_type_material_id int8 NOT NULL, course_id int8 NOT NULL, "position" int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, university_id int4 NULL, CONSTRAINT template_type_material_courses_order_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.template_type_material_courses_order OWNER TO postgres;
GRANT ALL ON TABLE odiseo.template_type_material_courses_order TO postgres;


-- odiseo.topic definition

-- Drop table

-- DROP TABLE odiseo.topic;

CREATE TABLE odiseo.topic ( id smallserial NOT NULL, code varchar(3) NOT NULL, "name" varchar(100) NOT NULL, course_id int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT topic_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.topic OWNER TO postgres;
GRANT ALL ON TABLE odiseo.topic TO postgres;


-- odiseo.type_archive definition

-- Drop table

-- DROP TABLE odiseo.type_archive;

CREATE TABLE odiseo.type_archive ( id smallserial NOT NULL, "name" varchar(20) NOT NULL, "extension" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_archive_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_archive OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_archive TO postgres;


-- odiseo.type_material definition

-- Drop table

-- DROP TABLE odiseo.type_material;

CREATE TABLE odiseo.type_material ( id smallserial NOT NULL, description varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, code varchar(4) NULL, amount_question int4 DEFAULT 0 NOT NULL, fl_exam bool DEFAULT false NOT NULL, type_material_template_id int8 NULL, fl_class_material bool DEFAULT false NOT NULL, thread int2 DEFAULT '1'::smallint NOT NULL, percentage numeric(5, 2) DEFAULT '30'::numeric NOT NULL, parent_id int8 NULL, level_order bool DEFAULT false NOT NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, "position" int2 DEFAULT '0'::smallint NOT NULL, order_date timestamp(0) NULL, cycle_id int8 NULL, CONSTRAINT type_material_pkey PRIMARY KEY (id));

-- Table Triggers

create trigger trg_audit_type_material after
delete
    or
update
    on
    odiseo.type_material for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo.type_material OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material TO postgres;


-- odiseo.type_material_area definition

-- Drop table

-- DROP TABLE odiseo.type_material_area;

CREATE TABLE odiseo.type_material_area ( id bigserial NOT NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_material_id int2 NOT NULL, area_id int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, CONSTRAINT type_material_area_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_area OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_area TO postgres;


-- odiseo.type_material_area_courses definition

-- Drop table

-- DROP TABLE odiseo.type_material_area_courses;

CREATE TABLE odiseo.type_material_area_courses ( id bigserial NOT NULL, type_material_course_id int8 NOT NULL, type_material_area_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT type_material_area_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_area_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_area_courses TO postgres;


-- odiseo.type_material_bound definition

-- Drop table

-- DROP TABLE odiseo.type_material_bound;

CREATE TABLE odiseo.type_material_bound ( id bigserial NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, type_material_template_id int8 NULL, type_material_template_extra_id int8 NULL, CONSTRAINT type_material_bound_pkey PRIMARY KEY (id), CONSTRAINT type_material_bound_unique_pair UNIQUE (type_material_template_id, type_material_template_extra_id));

-- Permissions

ALTER TABLE odiseo.type_material_bound OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_bound TO postgres;


-- odiseo.type_material_course definition

-- Drop table

-- DROP TABLE odiseo.type_material_course;

CREATE TABLE odiseo.type_material_course ( id bigserial NOT NULL, course_id int2 NOT NULL, type_material_id int2 NOT NULL, amount_question int4 DEFAULT 0 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, amount_text int4 DEFAULT 0 NOT NULL, amount_subquestion int4 DEFAULT 0 NULL, is_generic bool DEFAULT true NOT NULL, is_generic_text bool DEFAULT true NOT NULL, CONSTRAINT type_material_course_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_course TO postgres;


-- odiseo.type_material_detail_course_texts definition

-- Drop table

-- DROP TABLE odiseo.type_material_detail_course_texts;

CREATE TABLE odiseo.type_material_detail_course_texts ( id bigserial NOT NULL, type_material_detail_template_id int8 NOT NULL, type_material_course_id int8 NOT NULL, course_id int8 NOT NULL, amount_text int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_material_detail_course_texts_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_detail_course_texts OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_detail_course_texts TO postgres;


-- odiseo.type_material_detail_courses definition

-- Drop table

-- DROP TABLE odiseo.type_material_detail_courses;

CREATE TABLE odiseo.type_material_detail_courses ( id bigserial NOT NULL, type_material_detail_template_id int8 NOT NULL, type_material_course_id int8 NOT NULL, course_id int8 NOT NULL, amount_question int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_material_detail_courses_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_detail_courses OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_detail_courses TO postgres;


-- odiseo.type_material_detail_template definition

-- Drop table

-- DROP TABLE odiseo.type_material_detail_template;

CREATE TABLE odiseo.type_material_detail_template ( id bigserial NOT NULL, type_material_id int2 NOT NULL, week int2 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT type_material_detail_template_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_detail_template OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_detail_template TO postgres;


-- odiseo.type_material_detail_text_subquestions definition

-- Drop table

-- DROP TABLE odiseo.type_material_detail_text_subquestions;

CREATE TABLE odiseo.type_material_detail_text_subquestions ( id bigserial NOT NULL, type_material_detail_course_text_id int8 NOT NULL, subquestion_amount int2 DEFAULT '0'::smallint NOT NULL, "position" int2 NOT NULL, created_by int8 NOT NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_material_detail_text_subquestions_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_detail_text_subquestions OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_detail_text_subquestions TO postgres;


-- odiseo.type_material_periodicity definition

-- Drop table

-- DROP TABLE odiseo.type_material_periodicity;

CREATE TABLE odiseo.type_material_periodicity ( id smallserial NOT NULL, type_material_id int2 NOT NULL, periodicity_id int2 NOT NULL, quantity_week int2 NULL, start_week int2 NOT NULL, group_previous_week bool DEFAULT false NOT NULL, group_remaining_week bool DEFAULT false NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT type_material_periodicity_pkey PRIMARY KEY (id));

-- Table Triggers

create trigger trg_audit_type_material_periodicity after
delete
    or
update
    on
    odiseo.type_material_periodicity for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo.type_material_periodicity OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_periodicity TO postgres;


-- odiseo.type_material_template definition

-- Drop table

-- DROP TABLE odiseo.type_material_template;

CREATE TABLE odiseo.type_material_template ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, fl_exam bool DEFAULT false NOT NULL, type_exam_id int8 NULL, fl_use_syllabus_exam bool DEFAULT true NOT NULL, fl_revision bool DEFAULT false NOT NULL, has_config_column bool DEFAULT false NOT NULL, CONSTRAINT type_material_template_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_template OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_template TO postgres;


-- odiseo.type_material_template_configuration_columns definition

-- Drop table

-- DROP TABLE odiseo.type_material_template_configuration_columns;

CREATE TABLE odiseo.type_material_template_configuration_columns ( id bigserial NOT NULL, type_material_template_id int4 NOT NULL, type_solution varchar(255) NOT NULL, number_columns int4 NOT NULL, created_by int4 NOT NULL, updated_by int4 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, deleted_by int4 NULL, CONSTRAINT type_material_template_configuration_columns_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_material_template_configuration_columns OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_material_template_configuration_columns TO postgres;


-- odiseo.type_templates definition

-- Drop table

-- DROP TABLE odiseo.type_templates;

CREATE TABLE odiseo.type_templates ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, "default" bool DEFAULT false NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int4 NULL, CONSTRAINT odiseo_type_templates_name_unique UNIQUE (name), CONSTRAINT type_templates_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_templates OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_templates TO postgres;


-- odiseo.type_text definition

-- Drop table

-- DROP TABLE odiseo.type_text;

CREATE TABLE odiseo.type_text ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, fl_status bool DEFAULT true NOT NULL, "position" int2 DEFAULT '0'::smallint NOT NULL, CONSTRAINT type_text_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_text OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text TO postgres;


-- odiseo.type_text_exam_material_configuration definition

-- Drop table

-- DROP TABLE odiseo.type_text_exam_material_configuration;

CREATE TABLE odiseo.type_text_exam_material_configuration ( id bigserial NOT NULL, exam_material_config_id int8 NOT NULL, course_id int8 NOT NULL, area_id int2 NULL, type_text_level_id int2 NOT NULL, text_amount int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT type_text_exam_material_configuration_pkey PRIMARY KEY (id), CONSTRAINT unique_exam_course_area_level UNIQUE (exam_material_config_id, course_id, area_id, type_text_level_id));

-- Permissions

ALTER TABLE odiseo.type_text_exam_material_configuration OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_exam_material_configuration TO postgres;


-- odiseo.type_text_level definition

-- Drop table

-- DROP TABLE odiseo.type_text_level;

CREATE TABLE odiseo.type_text_level ( id smallserial NOT NULL, "level" int2 NOT NULL, description varchar(10) NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT type_text_level_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_text_level OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_level TO postgres;


-- odiseo.type_text_material_type_course definition

-- Drop table

-- DROP TABLE odiseo.type_text_material_type_course;

CREATE TABLE odiseo.type_text_material_type_course ( id bigserial NOT NULL, type_material_id int2 NOT NULL, course_id int2 NOT NULL, subquestion_amount int2 DEFAULT '0'::smallint NOT NULL, "position" int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_text_material_type_course_pkey PRIMARY KEY (id), CONSTRAINT unique_type_material_course_pos UNIQUE (type_material_id, course_id, "position"));

-- Permissions

ALTER TABLE odiseo.type_text_material_type_course OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_material_type_course TO postgres;


-- odiseo.type_text_material_type_course_area definition

-- Drop table

-- DROP TABLE odiseo.type_text_material_type_course_area;

CREATE TABLE odiseo.type_text_material_type_course_area ( id bigserial NOT NULL, type_material_id int2 NOT NULL, course_id int2 NOT NULL, exam_area_id int2 NOT NULL, subquestion_amount int2 DEFAULT '0'::smallint NOT NULL, "position" int2 NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, deleted_at timestamp(0) NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_text_material_type_course_area_pkey PRIMARY KEY (id), CONSTRAINT unique_type_material_course_are_pos UNIQUE (type_material_id, course_id, exam_area_id, "position"));

-- Permissions

ALTER TABLE odiseo.type_text_material_type_course_area OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_material_type_course_area TO postgres;


-- odiseo.type_text_subcategories definition

-- Drop table

-- DROP TABLE odiseo.type_text_subcategories;

CREATE TABLE odiseo.type_text_subcategories ( id bigserial NOT NULL, "name" varchar(255) NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_text_subcategories_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_text_subcategories OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_subcategories TO postgres;


-- odiseo.type_text_to_subcategory definition

-- Drop table

-- DROP TABLE odiseo.type_text_to_subcategory;

CREATE TABLE odiseo.type_text_to_subcategory ( id bigserial NOT NULL, type_text_id int8 NOT NULL, type_text_subcategory_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_text_to_subcategory_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_text_to_subcategory OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_text_to_subcategory TO postgres;


-- odiseo.type_texts_subtopics definition

-- Drop table

-- DROP TABLE odiseo.type_texts_subtopics;

CREATE TABLE odiseo.type_texts_subtopics ( id bigserial NOT NULL, subtopic_id int8 NOT NULL, type_text_id int8 NOT NULL, probability_percentage int2 DEFAULT '0'::smallint NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, CONSTRAINT type_texts_subtopics_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_texts_subtopics OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_texts_subtopics TO postgres;


-- odiseo.type_texts_topics definition

-- Drop table

-- DROP TABLE odiseo.type_texts_topics;

CREATE TABLE odiseo.type_texts_topics ( id bigserial NOT NULL, topic_id int8 NOT NULL, type_text_id int8 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, probability_percentage int2 DEFAULT '0'::smallint NOT NULL, CONSTRAINT type_texts_topics_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_texts_topics OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_texts_topics TO postgres;


-- odiseo.type_week definition

-- Drop table

-- DROP TABLE odiseo.type_week;

CREATE TABLE odiseo.type_week ( id bigserial NOT NULL, description varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, color varchar(7) NULL, CONSTRAINT type_week_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.type_week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.type_week TO postgres;


-- odiseo.university_headquarters definition

-- Drop table

-- DROP TABLE odiseo.university_headquarters;

CREATE TABLE odiseo.university_headquarters ( id smallserial NOT NULL, university_id int2 NOT NULL, headquarters_id int2 NOT NULL, quantity_classroom int4 NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT university_headquarters_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.university_headquarters OWNER TO postgres;
GRANT ALL ON TABLE odiseo.university_headquarters TO postgres;


-- odiseo.users definition

-- Drop table

-- DROP TABLE odiseo.users;

CREATE TABLE odiseo.users ( id bigserial NOT NULL, "uuid" uuid NULL, "user" varchar(255) NULL, email odiseo.email_citext NULL, "password" varchar(255) NOT NULL, fl_password_confirmed bool DEFAULT false NOT NULL, email_verified_at timestamp(0) NULL, api_token varchar(255) NULL, fl_status bool DEFAULT true NOT NULL, status_session int2 NOT NULL, last_login timestamp(0) NULL, image varchar(255) NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, company_id int4 NULL, token_nq text NULL, fl_suspended bool DEFAULT false NOT NULL, CONSTRAINT odiseo_users_user_unique UNIQUE ("user"), CONSTRAINT users_pkey PRIMARY KEY (id));

-- Table Triggers

create trigger trg_audit_users after
delete
    or
update
    on
    odiseo.users for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo.users OWNER TO postgres;
GRANT ALL ON TABLE odiseo.users TO postgres;


-- odiseo.users_roles definition

-- Drop table

-- DROP TABLE odiseo.users_roles;

CREATE TABLE odiseo.users_roles ( id bigserial NOT NULL, user_id int8 NOT NULL, rol_id int8 NOT NULL, rol_parent_id int8 NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, company_id int8 DEFAULT '1'::bigint NOT NULL, CONSTRAINT users_roles_pkey PRIMARY KEY (id));

-- Table Triggers

create trigger trg_audit_users_roles after
delete
    or
update
    on
    odiseo.users_roles for each row execute function audit.fn_audit_trigger();

-- Permissions

ALTER TABLE odiseo.users_roles OWNER TO postgres;
GRANT ALL ON TABLE odiseo.users_roles TO postgres;


-- odiseo.week definition

-- Drop table

-- DROP TABLE odiseo.week;

CREATE TABLE odiseo.week ( id smallserial NOT NULL, description varchar(255) NOT NULL, fl_status bool DEFAULT true NOT NULL, created_by int8 NULL, updated_by int8 NULL, deleted_by int8 NULL, created_at timestamp(0) NULL, updated_at timestamp(0) NULL, deleted_at timestamp(0) NULL, CONSTRAINT week_pkey PRIMARY KEY (id));

-- Permissions

ALTER TABLE odiseo.week OWNER TO postgres;
GRANT ALL ON TABLE odiseo.week TO postgres;


-- odiseo.advanced_settings foreign keys

ALTER TABLE odiseo.advanced_settings ADD CONSTRAINT odiseo_advanced_settings_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.alternative foreign keys

ALTER TABLE odiseo.alternative ADD CONSTRAINT odiseo_alternative_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative ADD CONSTRAINT odiseo_alternative_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative ADD CONSTRAINT odiseo_alternative_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.alternative ADD CONSTRAINT odiseo_alternative_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.alternative_ia_images foreign keys

ALTER TABLE odiseo.alternative_ia_images ADD CONSTRAINT alternative_ia_images_alternative_ia_id_foreign FOREIGN KEY (alternative_ia_id) REFERENCES odiseo.alternative_questions_ia(id);
ALTER TABLE odiseo.alternative_ia_images ADD CONSTRAINT alternative_ia_images_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_ia_images ADD CONSTRAINT alternative_ia_images_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_ia_images ADD CONSTRAINT alternative_ia_images_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.alternative_maths foreign keys

ALTER TABLE odiseo.alternative_maths ADD CONSTRAINT odiseo_alternative_maths_alternative_id_foreign FOREIGN KEY (alternative_id) REFERENCES odiseo.alternative(id);
ALTER TABLE odiseo.alternative_maths ADD CONSTRAINT odiseo_alternative_maths_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_maths ADD CONSTRAINT odiseo_alternative_maths_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_maths ADD CONSTRAINT odiseo_alternative_maths_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.alternative_questions_ia foreign keys

ALTER TABLE odiseo.alternative_questions_ia ADD CONSTRAINT alternative_questions_ia_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_questions_ia ADD CONSTRAINT alternative_questions_ia_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.alternative_questions_ia ADD CONSTRAINT alternative_questions_ia_question_ia_id_foreign FOREIGN KEY (question_ia_id) REFERENCES odiseo.question_teacher_ia(id);
ALTER TABLE odiseo.alternative_questions_ia ADD CONSTRAINT alternative_questions_ia_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.area foreign keys

ALTER TABLE odiseo.area ADD CONSTRAINT odiseo_area_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.area ADD CONSTRAINT odiseo_area_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.area ADD CONSTRAINT odiseo_area_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.category_rejected foreign keys

ALTER TABLE odiseo.category_rejected ADD CONSTRAINT odiseo_category_rejected_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.category_rejected ADD CONSTRAINT odiseo_category_rejected_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.category_rejected ADD CONSTRAINT odiseo_category_rejected_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.charge foreign keys

ALTER TABLE odiseo.charge ADD CONSTRAINT odiseo_charge_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.charge ADD CONSTRAINT odiseo_charge_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.charge ADD CONSTRAINT odiseo_charge_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.classroom foreign keys

ALTER TABLE odiseo.classroom ADD CONSTRAINT odiseo_classroom_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.classroom ADD CONSTRAINT odiseo_classroom_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.classroom ADD CONSTRAINT odiseo_classroom_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.clientes_empresas foreign keys

ALTER TABLE odiseo.clientes_empresas ADD CONSTRAINT clientes_empresas_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.clientes_empresas ADD CONSTRAINT clientes_empresas_departamento_id_foreign FOREIGN KEY (departamento_id) REFERENCES odiseo.region(id) ON DELETE SET NULL;
ALTER TABLE odiseo.clientes_empresas ADD CONSTRAINT clientes_empresas_distrito_id_foreign FOREIGN KEY (distrito_id) REFERENCES odiseo.districts(id) ON DELETE SET NULL;
ALTER TABLE odiseo.clientes_empresas ADD CONSTRAINT clientes_empresas_provincia_id_foreign FOREIGN KEY (provincia_id) REFERENCES odiseo.provinces(id) ON DELETE SET NULL;


-- odiseo.code_prospect foreign keys

ALTER TABLE odiseo.code_prospect ADD CONSTRAINT odiseo_code_prospect_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.code_prospect ADD CONSTRAINT odiseo_code_prospect_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.code_prospect ADD CONSTRAINT odiseo_code_prospect_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.companies foreign keys

ALTER TABLE odiseo.companies ADD CONSTRAINT companies_district_id_foreign FOREIGN KEY (district_id) REFERENCES odiseo.districts(id);
ALTER TABLE odiseo.companies ADD CONSTRAINT companies_province_id_foreign FOREIGN KEY (province_id) REFERENCES odiseo.provinces(id);
ALTER TABLE odiseo.companies ADD CONSTRAINT companies_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);
ALTER TABLE odiseo.companies ADD CONSTRAINT companies_type_institution_id_foreign FOREIGN KEY (type_institution_id) REFERENCES odiseo.institution_types(id);
ALTER TABLE odiseo.companies ADD CONSTRAINT odiseo_companies_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);


-- odiseo.company_headquarters foreign keys

ALTER TABLE odiseo.company_headquarters ADD CONSTRAINT company_headquarters_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.company_headquarters ADD CONSTRAINT company_headquarters_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_headquarters ADD CONSTRAINT company_headquarters_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_headquarters ADD CONSTRAINT company_headquarters_headquarter_id_foreign FOREIGN KEY (headquarter_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.company_headquarters ADD CONSTRAINT company_headquarters_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.company_legal_representatives foreign keys

ALTER TABLE odiseo.company_legal_representatives ADD CONSTRAINT company_legal_representatives_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.company_legal_representatives ADD CONSTRAINT company_legal_representatives_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_legal_representatives ADD CONSTRAINT company_legal_representatives_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_legal_representatives ADD CONSTRAINT company_legal_representatives_type_document_id_foreign FOREIGN KEY (type_document_id) REFERENCES odiseo.type_documents(id);
ALTER TABLE odiseo.company_legal_representatives ADD CONSTRAINT company_legal_representatives_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.company_universities foreign keys

ALTER TABLE odiseo.company_universities ADD CONSTRAINT company_universities_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.company_universities ADD CONSTRAINT company_universities_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_universities ADD CONSTRAINT company_universities_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_universities ADD CONSTRAINT company_universities_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.company_universities ADD CONSTRAINT company_universities_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.company_user_admin foreign keys

ALTER TABLE odiseo.company_user_admin ADD CONSTRAINT company_user_admin_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.company_user_admin ADD CONSTRAINT company_user_admin_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_user_admin ADD CONSTRAINT company_user_admin_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.company_user_admin ADD CONSTRAINT company_user_admin_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.company_user_admin ADD CONSTRAINT company_user_admin_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.configuration_alternative foreign keys

ALTER TABLE odiseo.configuration_alternative ADD CONSTRAINT odiseo_configuration_alternative_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.configuration_alternative ADD CONSTRAINT odiseo_configuration_alternative_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.configuration_alternative ADD CONSTRAINT odiseo_configuration_alternative_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.configuration_alternative ADD CONSTRAINT odiseo_configuration_alternative_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course foreign keys

ALTER TABLE odiseo.course ADD CONSTRAINT course_type_text_template_id_foreign FOREIGN KEY (type_text_template_id) REFERENCES odiseo.type_text_templates(id);
ALTER TABLE odiseo.course ADD CONSTRAINT odiseo_course_area_id_foreign FOREIGN KEY (area_id) REFERENCES odiseo.area(id);
ALTER TABLE odiseo.course ADD CONSTRAINT odiseo_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course ADD CONSTRAINT odiseo_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course ADD CONSTRAINT odiseo_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course_assigned_categories foreign keys

ALTER TABLE odiseo.course_assigned_categories ADD CONSTRAINT course_assigned_categories_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id) ON DELETE CASCADE;
ALTER TABLE odiseo.course_assigned_categories ADD CONSTRAINT course_assigned_categories_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_assigned_categories ADD CONSTRAINT course_assigned_categories_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_assigned_categories ADD CONSTRAINT course_assigned_categories_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id) ON DELETE RESTRICT;
ALTER TABLE odiseo.course_assigned_categories ADD CONSTRAINT course_assigned_categories_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course_assigned_subcategories foreign keys

ALTER TABLE odiseo.course_assigned_subcategories ADD CONSTRAINT course_assigned_subcategories_course_assigned_category_id_forei FOREIGN KEY (course_assigned_category_id) REFERENCES odiseo.course_assigned_categories(id);
ALTER TABLE odiseo.course_assigned_subcategories ADD CONSTRAINT course_assigned_subcategories_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE RESTRICT;
ALTER TABLE odiseo.course_assigned_subcategories ADD CONSTRAINT course_assigned_subcategories_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE RESTRICT;
ALTER TABLE odiseo.course_assigned_subcategories ADD CONSTRAINT course_assigned_subcategories_subcategory_id_foreign FOREIGN KEY (subcategory_id) REFERENCES odiseo.type_text_subcategories(id) ON DELETE RESTRICT;
ALTER TABLE odiseo.course_assigned_subcategories ADD CONSTRAINT course_assigned_subcategories_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE RESTRICT;


-- odiseo.course_level foreign keys

ALTER TABLE odiseo.course_level ADD CONSTRAINT odiseo_course_level_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_level ADD CONSTRAINT odiseo_course_level_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_level ADD CONSTRAINT odiseo_course_level_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course_pseudo_course foreign keys

ALTER TABLE odiseo.course_pseudo_course ADD CONSTRAINT odiseo_course_pseudo_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.course_pseudo_course ADD CONSTRAINT odiseo_course_pseudo_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_pseudo_course ADD CONSTRAINT odiseo_course_pseudo_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_pseudo_course ADD CONSTRAINT odiseo_course_pseudo_course_pseudo_course_id_foreign FOREIGN KEY (pseudo_course_id) REFERENCES odiseo.pseudo_course(id);
ALTER TABLE odiseo.course_pseudo_course ADD CONSTRAINT odiseo_course_pseudo_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course_pseudo_courses foreign keys

ALTER TABLE odiseo.course_pseudo_courses ADD CONSTRAINT odiseo_course_pseudo_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.course_pseudo_courses ADD CONSTRAINT odiseo_course_pseudo_courses_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_pseudo_courses ADD CONSTRAINT odiseo_course_pseudo_courses_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_pseudo_courses ADD CONSTRAINT odiseo_course_pseudo_courses_pseudo_course_id_foreign FOREIGN KEY (pseudo_course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.course_pseudo_courses ADD CONSTRAINT odiseo_course_pseudo_courses_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.course_text_category_settings foreign keys

ALTER TABLE odiseo.course_text_category_settings ADD CONSTRAINT course_text_category_settings_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.course_text_category_settings ADD CONSTRAINT course_text_category_settings_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.course_text_category_settings ADD CONSTRAINT course_text_category_settings_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.course_text_category_settings ADD CONSTRAINT course_text_category_settings_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo."cycle" foreign keys

ALTER TABLE odiseo."cycle" ADD CONSTRAINT cycle_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo."cycle" ADD CONSTRAINT cycle_type_template_id_foreign FOREIGN KEY (type_template_id) REFERENCES odiseo.type_templates(id);
ALTER TABLE odiseo."cycle" ADD CONSTRAINT odiseo_cycle_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."cycle" ADD CONSTRAINT odiseo_cycle_cycle_type_id_foreign FOREIGN KEY (cycle_type_id) REFERENCES odiseo.cycle_types(id);
ALTER TABLE odiseo."cycle" ADD CONSTRAINT odiseo_cycle_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."cycle" ADD CONSTRAINT odiseo_cycle_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.cycle_types foreign keys

ALTER TABLE odiseo.cycle_types ADD CONSTRAINT odiseo_cycle_types_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.cycle_types ADD CONSTRAINT odiseo_cycle_types_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.cycle_types ADD CONSTRAINT odiseo_cycle_types_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.cycle_weeks foreign keys

ALTER TABLE odiseo.cycle_weeks ADD CONSTRAINT odiseo_cycle_weeks_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.cycle_weeks ADD CONSTRAINT odiseo_cycle_weeks_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.cycle_weeks ADD CONSTRAINT odiseo_cycle_weeks_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.cycle_weeks ADD CONSTRAINT odiseo_cycle_weeks_type_week_id_foreign FOREIGN KEY (type_week_id) REFERENCES odiseo.type_week(id);
ALTER TABLE odiseo.cycle_weeks ADD CONSTRAINT odiseo_cycle_weeks_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.detail_level_syllabus_weeks foreign keys

ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT detail_level_syllabus_weeks_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_level_syllabus_weeks_id_fore FOREIGN KEY (level_syllabus_weeks_id) REFERENCES odiseo.level_syllabus_weeks(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks ADD CONSTRAINT odiseo_detail_level_syllabus_weeks_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.detail_level_syllabus_weeks_parents foreign keys

ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_level_syllabus_weeks_id_for FOREIGN KEY (level_syllabus_weeks_id) REFERENCES odiseo.level_syllabus_weeks(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.detail_level_syllabus_weeks_parents ADD CONSTRAINT detail_level_syllabus_weeks_parents_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.detail_week_type_mat foreign keys

ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_locked_by_foreign FOREIGN KEY (locked_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_parent_type_material_id_foreign FOREIGN KEY (parent_type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.detail_week_type_mat ADD CONSTRAINT odiseo_detail_week_type_mat_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.didi_maths foreign keys

ALTER TABLE odiseo.didi_maths ADD CONSTRAINT odiseo_didi_maths_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.didi_maths ADD CONSTRAINT odiseo_didi_maths_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.didi_maths ADD CONSTRAINT odiseo_didi_maths_didi_question_id_foreign FOREIGN KEY (didi_question_id) REFERENCES odiseo.employee_didi_question_field(id);
ALTER TABLE odiseo.didi_maths ADD CONSTRAINT odiseo_didi_maths_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.districts foreign keys

ALTER TABLE odiseo.districts ADD CONSTRAINT districts_province_id_foreign FOREIGN KEY (province_id) REFERENCES odiseo.provinces(id);
ALTER TABLE odiseo.districts ADD CONSTRAINT districts_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);


-- odiseo.employee_course foreign keys

ALTER TABLE odiseo.employee_course ADD CONSTRAINT odiseo_employee_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.employee_course ADD CONSTRAINT odiseo_employee_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_course ADD CONSTRAINT odiseo_employee_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_course ADD CONSTRAINT odiseo_employee_course_teacher_id_foreign FOREIGN KEY (teacher_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.employee_course ADD CONSTRAINT odiseo_employee_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_didi_question foreign keys

ALTER TABLE odiseo.employee_didi_question ADD CONSTRAINT odiseo_employee_didi_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question ADD CONSTRAINT odiseo_employee_didi_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question ADD CONSTRAINT odiseo_employee_didi_question_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.employee_didi_question ADD CONSTRAINT odiseo_employee_didi_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.employee_didi_question ADD CONSTRAINT odiseo_employee_didi_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_didi_question_field foreign keys

ALTER TABLE odiseo.employee_didi_question_field ADD CONSTRAINT odiseo_employee_didi_question_field_employee_didi_question_id_f FOREIGN KEY (employee_didi_question_id) REFERENCES odiseo.employee_didi_question(id);
ALTER TABLE odiseo.employee_didi_question_field ADD CONSTRAINT odiseo_employee_didi_question_field_setting_diagrammed_course_i FOREIGN KEY (setting_diagrammed_course_id) REFERENCES odiseo.setting_diagrammed_courses(id);


-- odiseo.employee_didi_question_field_image foreign keys

ALTER TABLE odiseo.employee_didi_question_field_image ADD CONSTRAINT employee_didi_question_field_ima_employee_didi_question_id_fkey FOREIGN KEY (employee_didi_question_id) REFERENCES odiseo.employee_didi_question(id);
ALTER TABLE odiseo.employee_didi_question_field_image ADD CONSTRAINT employee_didi_question_field_image_created_by_fkey FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question_field_image ADD CONSTRAINT employee_didi_question_field_image_deleted_by_fkey FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question_field_image ADD CONSTRAINT employee_didi_question_field_image_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_didi_question_field_image_active foreign keys

-- odiseo.employee_didi_question_field_image_inactive foreign keys

-- odiseo.employee_didi_question_image foreign keys

ALTER TABLE odiseo.employee_didi_question_image ADD CONSTRAINT odiseo_employee_didi_question_image_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question_image ADD CONSTRAINT odiseo_employee_didi_question_image_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_didi_question_image ADD CONSTRAINT odiseo_employee_didi_question_image_employee_didi_question_id_f FOREIGN KEY (employee_didi_question_id) REFERENCES odiseo.employee_didi_question(id);
ALTER TABLE odiseo.employee_didi_question_image ADD CONSTRAINT odiseo_employee_didi_question_image_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_question foreign keys

ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_alternative_id_foreign FOREIGN KEY (alternative_id) REFERENCES odiseo.alternative(id);
ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_teacher_id_foreign FOREIGN KEY (teacher_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.employee_question ADD CONSTRAINT odiseo_employee_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_question_document foreign keys

ALTER TABLE odiseo.employee_question_document ADD CONSTRAINT odiseo_employee_question_document_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_document ADD CONSTRAINT odiseo_employee_question_document_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_document ADD CONSTRAINT odiseo_employee_question_document_employee_question_id_foreign FOREIGN KEY (employee_question_id) REFERENCES odiseo.employee_question(id);
ALTER TABLE odiseo.employee_question_document ADD CONSTRAINT odiseo_employee_question_document_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_question_image foreign keys

ALTER TABLE odiseo.employee_question_image ADD CONSTRAINT odiseo_employee_question_image_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_image ADD CONSTRAINT odiseo_employee_question_image_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_image ADD CONSTRAINT odiseo_employee_question_image_employee_question_id_foreign FOREIGN KEY (employee_question_id) REFERENCES odiseo.employee_question(id);
ALTER TABLE odiseo.employee_question_image ADD CONSTRAINT odiseo_employee_question_image_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_question_maths foreign keys

ALTER TABLE odiseo.employee_question_maths ADD CONSTRAINT odiseo_employee_question_maths_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_maths ADD CONSTRAINT odiseo_employee_question_maths_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_question_maths ADD CONSTRAINT odiseo_employee_question_maths_employee_question_id_foreign FOREIGN KEY (employee_question_id) REFERENCES odiseo.employee_question(id);
ALTER TABLE odiseo.employee_question_maths ADD CONSTRAINT odiseo_employee_question_maths_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employee_university foreign keys

ALTER TABLE odiseo.employee_university ADD CONSTRAINT odiseo_employee_university_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_university ADD CONSTRAINT odiseo_employee_university_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employee_university ADD CONSTRAINT odiseo_employee_university_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.employee_university ADD CONSTRAINT odiseo_employee_university_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.employee_university ADD CONSTRAINT odiseo_employee_university_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.employees foreign keys

ALTER TABLE odiseo.employees ADD CONSTRAINT employees_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.employees ADD CONSTRAINT odiseo_employees_charge_id_foreign FOREIGN KEY (charge_id) REFERENCES odiseo.charge(id);
ALTER TABLE odiseo.employees ADD CONSTRAINT odiseo_employees_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employees ADD CONSTRAINT odiseo_employees_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.employees ADD CONSTRAINT odiseo_employees_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo.level_rates(id);
ALTER TABLE odiseo.employees ADD CONSTRAINT odiseo_employees_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.essential_knowledge_image foreign keys

ALTER TABLE odiseo.essential_knowledge_image ADD CONSTRAINT essential_knowledge_image_essential_knowledge_id_foreign FOREIGN KEY (essential_knowledge_id) REFERENCES odiseo.essential_knowledges(id);


-- odiseo.essential_knowledge_questions foreign keys

ALTER TABLE odiseo.essential_knowledge_questions ADD CONSTRAINT essential_knowledge_questions_essential_knowledge_id_foreign FOREIGN KEY (essential_knowledge_id) REFERENCES odiseo.essential_knowledges(id);
ALTER TABLE odiseo.essential_knowledge_questions ADD CONSTRAINT essential_knowledge_questions_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.essential_knowledges foreign keys

ALTER TABLE odiseo.essential_knowledges ADD CONSTRAINT essential_knowledges_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.essential_knowledges ADD CONSTRAINT essential_knowledges_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);


-- odiseo.exam_area foreign keys

ALTER TABLE odiseo.exam_area ADD CONSTRAINT odiseo_exam_area_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.exam_area ADD CONSTRAINT odiseo_exam_area_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.exam_area ADD CONSTRAINT odiseo_exam_area_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.exam_material_config_area_course_levels foreign keys

ALTER TABLE odiseo.exam_material_config_area_course_levels ADD CONSTRAINT odiseo_exam_material_config_area_course_levels_created_by_forei FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_course_levels ADD CONSTRAINT odiseo_exam_material_config_area_course_levels_deleted_by_forei FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_course_levels ADD CONSTRAINT odiseo_exam_material_config_area_course_levels_exam_material_co FOREIGN KEY (exam_material_config_area_course_id) REFERENCES odiseo.exam_material_config_area_courses(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_course_levels ADD CONSTRAINT odiseo_exam_material_config_area_course_levels_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_course_levels ADD CONSTRAINT odiseo_exam_material_config_area_course_levels_updated_by_forei FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;


-- odiseo.exam_material_config_area_courses foreign keys

ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_exam_area_id_foreign FOREIGN KEY (exam_area_id) REFERENCES odiseo.exam_area(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_exam_material_config_i FOREIGN KEY (exam_material_config_id) REFERENCES odiseo.exam_material_configurations(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_config_area_courses ADD CONSTRAINT odiseo_exam_material_config_area_courses_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;


-- odiseo.exam_material_configurations foreign keys

ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT exam_material_configurations_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT odiseo_exam_material_configurations_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT odiseo_exam_material_configurations_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT odiseo_exam_material_configurations_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT odiseo_exam_material_configurations_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id) ON DELETE CASCADE;
ALTER TABLE odiseo.exam_material_configurations ADD CONSTRAINT odiseo_exam_material_configurations_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE CASCADE;


-- odiseo.frequent_university_subtopic foreign keys

ALTER TABLE odiseo.frequent_university_subtopic ADD CONSTRAINT odiseo_frequent_university_subtopic_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.frequent_university_subtopic ADD CONSTRAINT odiseo_frequent_university_subtopic_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.frequent_university_subtopic ADD CONSTRAINT odiseo_frequent_university_subtopic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.headquarters foreign keys

ALTER TABLE odiseo.headquarters ADD CONSTRAINT odiseo_headquarters_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.headquarters ADD CONSTRAINT odiseo_headquarters_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.headquarters ADD CONSTRAINT odiseo_headquarters_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.headquarters_classroom foreign keys

ALTER TABLE odiseo.headquarters_classroom ADD CONSTRAINT odiseo_headquarters_classroom_classroom_id_foreign FOREIGN KEY (classroom_id) REFERENCES odiseo.classroom(id);
ALTER TABLE odiseo.headquarters_classroom ADD CONSTRAINT odiseo_headquarters_classroom_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.headquarters_classroom ADD CONSTRAINT odiseo_headquarters_classroom_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.headquarters_classroom ADD CONSTRAINT odiseo_headquarters_classroom_headquarters_id_foreign FOREIGN KEY (headquarters_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.headquarters_classroom ADD CONSTRAINT odiseo_headquarters_classroom_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.history_digitalized_solution_question_pdf foreign keys

ALTER TABLE odiseo.history_digitalized_solution_question_pdf ADD CONSTRAINT odiseo_history_digitalized_solution_question_pdf_question_id_fo FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.history_syllabus foreign keys

ALTER TABLE odiseo.history_syllabus ADD CONSTRAINT history_syllabus_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;
ALTER TABLE odiseo.history_syllabus ADD CONSTRAINT history_syllabus_role_id_foreign FOREIGN KEY (role_id) REFERENCES odiseo.roles(id);
ALTER TABLE odiseo.history_syllabus ADD CONSTRAINT history_syllabus_syllabus_id_foreign FOREIGN KEY (syllabus_id) REFERENCES odiseo.syllabus(id);
ALTER TABLE odiseo.history_syllabus ADD CONSTRAINT history_syllabus_user_id_foreign FOREIGN KEY (user_id) REFERENCES odiseo.users(id);


-- odiseo.image_galery_topic foreign keys

ALTER TABLE odiseo.image_galery_topic ADD CONSTRAINT odiseo_image_galery_topic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.image_galery_topic ADD CONSTRAINT odiseo_image_galery_topic_image_gallery_id_foreign FOREIGN KEY (image_gallery_id) REFERENCES odiseo.image_gallery(id);
ALTER TABLE odiseo.image_galery_topic ADD CONSTRAINT odiseo_image_galery_topic_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.image_galery_topic ADD CONSTRAINT odiseo_image_galery_topic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.image_gallery foreign keys

ALTER TABLE odiseo.image_gallery ADD CONSTRAINT odiseo_image_gallery_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.image_gallery ADD CONSTRAINT odiseo_image_gallery_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.image_gallery ADD CONSTRAINT odiseo_image_gallery_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.importance_rejected foreign keys

ALTER TABLE odiseo.importance_rejected ADD CONSTRAINT odiseo_importance_rejected_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.importance_rejected ADD CONSTRAINT odiseo_importance_rejected_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.importance_rejected ADD CONSTRAINT odiseo_importance_rejected_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.individual_notifications foreign keys

ALTER TABLE odiseo.individual_notifications ADD CONSTRAINT odiseo_individual_notifications_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.individual_notifications ADD CONSTRAINT odiseo_individual_notifications_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.individual_notifications ADD CONSTRAINT odiseo_individual_notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES odiseo.users(id);


-- odiseo."level" foreign keys

ALTER TABLE odiseo."level" ADD CONSTRAINT odiseo_level_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."level" ADD CONSTRAINT odiseo_level_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."level" ADD CONSTRAINT odiseo_level_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.level_rates foreign keys

ALTER TABLE odiseo.level_rates ADD CONSTRAINT odiseo_level_rates_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_rates ADD CONSTRAINT odiseo_level_rates_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_rates ADD CONSTRAINT odiseo_level_rates_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.level_syllabus foreign keys

ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT level_syllabus_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_headquarter_id_foreign FOREIGN KEY (headquarter_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.level_syllabus ADD CONSTRAINT odiseo_level_syllabus_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.level_syllabus_weeks foreign keys

ALTER TABLE odiseo.level_syllabus_weeks ADD CONSTRAINT level_syllabus_weeks_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE odiseo.level_syllabus_weeks ADD CONSTRAINT odiseo_level_syllabus_weeks_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_syllabus_weeks ADD CONSTRAINT odiseo_level_syllabus_weeks_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.level_syllabus_weeks ADD CONSTRAINT odiseo_level_syllabus_weeks_level_syllabus_id_foreign FOREIGN KEY (level_syllabus_id) REFERENCES odiseo.level_syllabus(id);
ALTER TABLE odiseo.level_syllabus_weeks ADD CONSTRAINT odiseo_level_syllabus_weeks_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material foreign keys

ALTER TABLE odiseo.material ADD CONSTRAINT material_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_headquarte_id_foreign FOREIGN KEY (headquarte_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_headquarters_classroom_id_foreign FOREIGN KEY (headquarters_classroom_id) REFERENCES odiseo.headquarters_classroom(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.material ADD CONSTRAINT odiseo_material_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_ballot_question foreign keys

ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT fk_mbq_type_mat FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT fk_mbq_usage_level FOREIGN KEY (usage_level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT material_ballot_question_parent_question_id_foreign FOREIGN KEY (parent_question_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT material_ballot_question_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT material_ballot_question_type_text_subcategory_id_foreign FOREIGN KEY (type_text_subcategory_id) REFERENCES odiseo.type_text_subcategories(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT material_ballot_question_usage_subtopic_id_foreign FOREIGN KEY (usage_subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT material_ballot_question_usage_topic_id_foreign FOREIGN KEY (usage_topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_question_history_id_foreign FOREIGN KEY (question_history_id) REFERENCES odiseo.question_history_cycle(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_ballot_question ADD CONSTRAINT odiseo_material_ballot_question_week_type_material_id_foreign FOREIGN KEY (week_type_material_id) REFERENCES odiseo.detail_week_type_mat(id);


-- odiseo.material_ballot_stats_area_courses foreign keys

ALTER TABLE odiseo.material_ballot_stats_area_courses ADD CONSTRAINT fk_stats_courses_area FOREIGN KEY (area_stats_id) REFERENCES odiseo.material_ballot_stats_areas(id) ON DELETE CASCADE;


-- odiseo.material_ballot_stats_areas foreign keys

ALTER TABLE odiseo.material_ballot_stats_areas ADD CONSTRAINT fk_stats_areas_global FOREIGN KEY (global_stats_id) REFERENCES odiseo.material_ballot_stats_global(id) ON DELETE CASCADE;


-- odiseo.material_ballot_stats_global foreign keys

ALTER TABLE odiseo.material_ballot_stats_global ADD CONSTRAINT fk_stats_global_ballot FOREIGN KEY (material_per_period_ballot_id) REFERENCES odiseo.material_per_period_ballot(id) ON DELETE CASCADE;


-- odiseo.material_ballot_subquestions foreign keys

ALTER TABLE odiseo.material_ballot_subquestions ADD CONSTRAINT fk_mbs_ballot_q FOREIGN KEY (material_ballot_question_id) REFERENCES odiseo.material_ballot_question(id);
ALTER TABLE odiseo.material_ballot_subquestions ADD CONSTRAINT fk_mbs_question FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.material_class_week foreign keys

ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_class_week ADD CONSTRAINT odiseo_material_class_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_column_configurations foreign keys

ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_material_configuration_id FOREIGN KEY (material_configuration_id) REFERENCES odiseo.material_configurations(id);
ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_column_configurations ADD CONSTRAINT odiseo_material_column_configurations_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_configuration_detail_value foreign keys

ALTER TABLE odiseo.material_configuration_detail_value ADD CONSTRAINT odiseo_material_configuration_detail_value_material_configurati FOREIGN KEY (material_configuration_detail_id) REFERENCES odiseo.material_configuration_details(id);
ALTER TABLE odiseo.material_configuration_detail_value ADD CONSTRAINT odiseo_material_configuration_detail_value_template_type_materi FOREIGN KEY (template_type_material_configuration_id) REFERENCES odiseo.template_type_material_configurations(id);


-- odiseo.material_configuration_details foreign keys

ALTER TABLE odiseo.material_configuration_details ADD CONSTRAINT odiseo_material_configuration_details_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_configuration_details ADD CONSTRAINT odiseo_material_configuration_details_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_configuration_details ADD CONSTRAINT odiseo_material_configuration_details_material_configuration_id FOREIGN KEY (material_configuration_id) REFERENCES odiseo.material_configurations(id);
ALTER TABLE odiseo.material_configuration_details ADD CONSTRAINT odiseo_material_configuration_details_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_configurations foreign keys

ALTER TABLE odiseo.material_configurations ADD CONSTRAINT odiseo_material_configurations_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.material_configurations ADD CONSTRAINT odiseo_material_configurations_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_configurations ADD CONSTRAINT odiseo_material_configurations_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_configurations ADD CONSTRAINT odiseo_material_configurations_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_distribution_ballot_questions foreign keys

ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT material_distribution_ballot_questions_parent_question_id_forei FOREIGN KEY (parent_question_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT material_distribution_ballot_questions_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT material_distribution_ballot_questions_type_text_subcategory_id FOREIGN KEY (type_text_subcategory_id) REFERENCES odiseo.type_text_subcategories(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT material_distribution_ballot_questions_usage_subtopic_id_foreig FOREIGN KEY (usage_subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT material_distribution_ballot_questions_usage_topic_id_foreign FOREIGN KEY (usage_topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_created_by_foreig FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_deleted_by_foreig FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_material_id_forei FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_question_id_forei FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_subtopic_id_forei FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_type_material_id_ FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_updated_by_foreig FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_usage_level_id_fo FOREIGN KEY (usage_level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.material_distribution_ballot_questions ADD CONSTRAINT odiseo_material_distribution_ballot_questions_week_type_materia FOREIGN KEY (week_type_material_id) REFERENCES odiseo.detail_week_type_mat(id);


-- odiseo.material_exam_area_week foreign keys

ALTER TABLE odiseo.material_exam_area_week ADD CONSTRAINT odiseo_material_exam_area_week_area_id_foreign FOREIGN KEY (area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.material_exam_area_week ADD CONSTRAINT odiseo_material_exam_area_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_area_week ADD CONSTRAINT odiseo_material_exam_area_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_area_week ADD CONSTRAINT odiseo_material_exam_area_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_area_week ADD CONSTRAINT odiseo_material_exam_area_week_week_type_material_id_foreign FOREIGN KEY (week_type_material_id) REFERENCES odiseo.detail_week_type_mat(id);


-- odiseo.material_exam_parent_question foreign keys

ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_current_level_foreign FOREIGN KEY (current_level) REFERENCES odiseo.type_text_level(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_expected_level_foreign FOREIGN KEY (expected_level) REFERENCES odiseo.type_text_level(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_material_exam_area_week_id_foreig FOREIGN KEY (material_exam_area_week_id) REFERENCES odiseo.material_exam_area_week(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_parent_question_id_foreign FOREIGN KEY (parent_question_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_question_history_id_foreign FOREIGN KEY (question_history_id) REFERENCES odiseo.question_history_cycle(id);
ALTER TABLE odiseo.material_exam_parent_question ADD CONSTRAINT material_exam_parent_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_exam_question foreign keys

ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_material_exam_area_week_id_foreig FOREIGN KEY (material_exam_area_week_id) REFERENCES odiseo.material_exam_area_week(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_question_history_id_foreign FOREIGN KEY (question_history_id) REFERENCES odiseo.question_history_cycle(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.material_exam_question ADD CONSTRAINT odiseo_material_exam_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_exam_stats_area_courses foreign keys

ALTER TABLE odiseo.material_exam_stats_area_courses ADD CONSTRAINT material_exam_stats_area_courses_area_stats_id_foreign FOREIGN KEY (area_stats_id) REFERENCES odiseo.material_exam_stats_areas(id) ON DELETE CASCADE;
ALTER TABLE odiseo.material_exam_stats_area_courses ADD CONSTRAINT material_exam_stats_area_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);


-- odiseo.material_exam_stats_areas foreign keys

ALTER TABLE odiseo.material_exam_stats_areas ADD CONSTRAINT material_exam_stats_areas_area_id_foreign FOREIGN KEY (area_id) REFERENCES odiseo.area(id);
ALTER TABLE odiseo.material_exam_stats_areas ADD CONSTRAINT material_exam_stats_areas_material_exam_stats_global_id_foreign FOREIGN KEY (material_exam_stats_global_id) REFERENCES odiseo.material_exam_stats_global(id) ON DELETE CASCADE;


-- odiseo.material_exam_stats_global foreign keys

ALTER TABLE odiseo.material_exam_stats_global ADD CONSTRAINT material_exam_stats_global_detail_week_type_mat_id_foreign FOREIGN KEY (detail_week_type_mat_id) REFERENCES odiseo.detail_week_type_mat(id);


-- odiseo.material_generation_notifications foreign keys

ALTER TABLE odiseo.material_generation_notifications ADD CONSTRAINT odiseo_material_generation_notifications_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_generation_notifications ADD CONSTRAINT odiseo_material_generation_notifications_type_foreign FOREIGN KEY ("type") REFERENCES odiseo.material_generation_notification_types(id);
ALTER TABLE odiseo.material_generation_notifications ADD CONSTRAINT odiseo_material_generation_notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES odiseo.users(id);


-- odiseo.material_missing_question foreign keys

ALTER TABLE odiseo.material_missing_question ADD CONSTRAINT material_missing_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_missing_question ADD CONSTRAINT material_missing_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_missing_question ADD CONSTRAINT material_missing_question_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.material_missing_question ADD CONSTRAINT material_missing_question_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_missing_question ADD CONSTRAINT material_missing_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_missing_question_detail foreign keys

ALTER TABLE odiseo.material_missing_question_detail ADD CONSTRAINT material_missing_question_detail_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.material_missing_question_detail ADD CONSTRAINT material_missing_question_detail_material_ballot_q FOREIGN KEY (material_ballot_question_id) REFERENCES odiseo.material_ballot_question(id) ON DELETE CASCADE;
ALTER TABLE odiseo.material_missing_question_detail ADD CONSTRAINT material_missing_question_detail_material_missing_question_id_f FOREIGN KEY (material_missing_question_id) REFERENCES odiseo.material_missing_question(id);
ALTER TABLE odiseo.material_missing_question_detail ADD CONSTRAINT material_missing_question_detail_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.material_missing_question_tracking foreign keys

ALTER TABLE odiseo.material_missing_question_tracking ADD CONSTRAINT fk_mmq_tracking_created_by FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_missing_question_tracking ADD CONSTRAINT fk_mmq_tracking_detail_id FOREIGN KEY (material_missing_question_detail_id) REFERENCES odiseo.material_missing_question_detail(id);
ALTER TABLE odiseo.material_missing_question_tracking ADD CONSTRAINT fk_mmq_tracking_employee_id FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);


-- odiseo.material_per_period foreign keys

ALTER TABLE odiseo.material_per_period ADD CONSTRAINT material_per_period_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period ADD CONSTRAINT material_per_period_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period ADD CONSTRAINT material_per_period_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.material_per_period ADD CONSTRAINT material_per_period_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_per_period ADD CONSTRAINT material_per_period_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_ballot foreign keys

ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_material_per_period_id_foreign FOREIGN KEY (material_per_period_id) REFERENCES odiseo.material_per_period(id);
ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_order_by_user_id_foreign FOREIGN KEY (order_by_user_id) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot ADD CONSTRAINT material_per_period_ballot_user_completed_id_foreign FOREIGN KEY (user_completed_id) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_ballot_class foreign keys

ALTER TABLE odiseo.material_per_period_ballot_class ADD CONSTRAINT material_per_period_ballot_class_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_per_period_ballot_class ADD CONSTRAINT material_per_period_ballot_class_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot_class ADD CONSTRAINT material_per_period_ballot_class_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot_class ADD CONSTRAINT material_per_period_ballot_class_material_per_period_ballot_url FOREIGN KEY (material_per_period_ballot_url_id) REFERENCES odiseo.material_per_period_ballot_url(id);
ALTER TABLE odiseo.material_per_period_ballot_class ADD CONSTRAINT material_per_period_ballot_class_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_ballot_url foreign keys

ALTER TABLE odiseo.material_per_period_ballot_url ADD CONSTRAINT material_per_period_ballot_url_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot_url ADD CONSTRAINT material_per_period_ballot_url_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_ballot_url ADD CONSTRAINT material_per_period_ballot_url_material_per_period_ballot_id_fo FOREIGN KEY (material_per_period_ballot_id) REFERENCES odiseo.material_per_period_ballot(id);
ALTER TABLE odiseo.material_per_period_ballot_url ADD CONSTRAINT material_per_period_ballot_url_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_course foreign keys

ALTER TABLE odiseo.material_per_period_course ADD CONSTRAINT material_per_period_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_per_period_course ADD CONSTRAINT material_per_period_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_course ADD CONSTRAINT material_per_period_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_course ADD CONSTRAINT material_per_period_course_material_per_period_ballot_id_foreig FOREIGN KEY (material_per_period_ballot_id) REFERENCES odiseo.material_per_period_ballot(id);
ALTER TABLE odiseo.material_per_period_course ADD CONSTRAINT material_per_period_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_exam foreign keys

ALTER TABLE odiseo.material_per_period_exam ADD CONSTRAINT material_per_period_exam_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_exam ADD CONSTRAINT material_per_period_exam_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_exam ADD CONSTRAINT material_per_period_exam_exam_area_id_foreign FOREIGN KEY (exam_area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.material_per_period_exam ADD CONSTRAINT material_per_period_exam_material_per_period_id_foreign FOREIGN KEY (material_per_period_id) REFERENCES odiseo.material_per_period(id);
ALTER TABLE odiseo.material_per_period_exam ADD CONSTRAINT material_per_period_exam_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_per_period_level_limit_config foreign keys

ALTER TABLE odiseo.material_per_period_level_limit_config ADD CONSTRAINT material_per_period_level_limit_config_material_per_period_id_f FOREIGN KEY (material_per_period_id) REFERENCES odiseo.material_per_period(id);


-- odiseo.material_per_period_week_course foreign keys

ALTER TABLE odiseo.material_per_period_week_course ADD CONSTRAINT material_per_period_week_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_per_period_week_course ADD CONSTRAINT material_per_period_week_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_week_course ADD CONSTRAINT material_per_period_week_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_per_period_week_course ADD CONSTRAINT material_per_period_week_course_material_per_period_ballot_id_f FOREIGN KEY (material_per_period_ballot_id) REFERENCES odiseo.material_per_period_ballot(id);
ALTER TABLE odiseo.material_per_period_week_course ADD CONSTRAINT material_per_period_week_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_question_change_reason foreign keys

ALTER TABLE odiseo.material_question_change_reason ADD CONSTRAINT material_question_change_reason_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_question_change_reason ADD CONSTRAINT material_question_change_reason_material_ballot_question_id_for FOREIGN KEY (material_ballot_question_id) REFERENCES odiseo.material_ballot_question(id);
ALTER TABLE odiseo.material_question_change_reason ADD CONSTRAINT material_question_change_reason_material_revision_course_id_for FOREIGN KEY (material_revision_course_id) REFERENCES odiseo.material_revision_courses(id);


-- odiseo.material_revision_courses foreign keys

ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_course FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_cr_by FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_del_by FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_revision FOREIGN KEY (material_revision_id) REFERENCES odiseo.material_revisions(id);
ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_up_by FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_courses ADD CONSTRAINT fk_mat_rev_course_ver_by FOREIGN KEY (verified_by) REFERENCES odiseo.users(id);


-- odiseo.material_revision_histories foreign keys

ALTER TABLE odiseo.material_revision_histories ADD CONSTRAINT fk_mat_rev_history_chg_by FOREIGN KEY (changed_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_histories ADD CONSTRAINT fk_mat_rev_history_revision FOREIGN KEY (material_revision_id) REFERENCES odiseo.material_revisions(id);


-- odiseo.material_revision_items foreign keys

ALTER TABLE odiseo.material_revision_items ADD CONSTRAINT fk_mat_rev_item_cr_by FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_items ADD CONSTRAINT fk_mat_rev_item_del_by FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revision_items ADD CONSTRAINT fk_mat_rev_item_detail FOREIGN KEY (detail_week_type_mat_id) REFERENCES odiseo.detail_week_type_mat(id);
ALTER TABLE odiseo.material_revision_items ADD CONSTRAINT fk_mat_rev_item_revision FOREIGN KEY (material_revision_id) REFERENCES odiseo.material_revisions(id);
ALTER TABLE odiseo.material_revision_items ADD CONSTRAINT fk_mat_rev_item_up_by FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.material_revisions foreign keys

ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_created_by FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_deleted_by FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_material FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_type_material FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_updated_by FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.material_revisions ADD CONSTRAINT fk_mat_rev_verified_by FOREIGN KEY (verified_by) REFERENCES odiseo.users(id);


-- odiseo.modality foreign keys

ALTER TABLE odiseo.modality ADD CONSTRAINT odiseo_modality_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.modality ADD CONSTRAINT odiseo_modality_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.modality ADD CONSTRAINT odiseo_modality_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.modality_options foreign keys

ALTER TABLE odiseo.modality_options ADD CONSTRAINT modality_options_option_university_id_foreign FOREIGN KEY (option_university_id) REFERENCES odiseo.option_university(id);


-- odiseo.network_course_topic_subtopic foreign keys

ALTER TABLE odiseo.network_course_topic_subtopic ADD CONSTRAINT network_course_topic_subtopic_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.network_course_topic_subtopic ADD CONSTRAINT network_course_topic_subtopic_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.network_course_topic_subtopic ADD CONSTRAINT network_course_topic_subtopic_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);


-- odiseo.nq_user_request foreign keys

ALTER TABLE odiseo.nq_user_request ADD CONSTRAINT nq_user_request_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.nq_user_request ADD CONSTRAINT nq_user_request_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.nq_user_request ADD CONSTRAINT nq_user_request_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.nq_user_token foreign keys

ALTER TABLE odiseo.nq_user_token ADD CONSTRAINT nq_user_token_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.nq_user_token ADD CONSTRAINT nq_user_token_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.nq_user_token ADD CONSTRAINT nq_user_token_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.nq_user_token ADD CONSTRAINT nq_user_token_user_id_foreign FOREIGN KEY (user_id) REFERENCES odiseo.users(id);


-- odiseo."option" foreign keys

ALTER TABLE odiseo."option" ADD CONSTRAINT odiseo_option_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."option" ADD CONSTRAINT odiseo_option_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."option" ADD CONSTRAINT odiseo_option_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.option_university foreign keys

ALTER TABLE odiseo.option_university ADD CONSTRAINT option_university_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);


-- odiseo.origin_parent_question foreign keys

ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT fk_origin_parent_question_modality_option FOREIGN KEY (modality_option_id) REFERENCES odiseo.modality_options(id);
ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT origin_parent_question_modality_id_foreign FOREIGN KEY (modality_id) REFERENCES odiseo.modality(id);
ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT origin_parent_question_option_id_foreign FOREIGN KEY (option_id) REFERENCES odiseo."option"(id);
ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT origin_parent_question_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT origin_parent_question_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);
ALTER TABLE odiseo.origin_parent_question ADD CONSTRAINT origin_parent_question_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);


-- odiseo.origin_question foreign keys

ALTER TABLE odiseo.origin_question ADD CONSTRAINT fk_origin_question_modality_option FOREIGN KEY (modality_option_id) REFERENCES odiseo.modality_options(id);
ALTER TABLE odiseo.origin_question ADD CONSTRAINT origin_question_modality_id_foreign FOREIGN KEY (modality_id) REFERENCES odiseo.modality(id);
ALTER TABLE odiseo.origin_question ADD CONSTRAINT origin_question_option_id_foreign FOREIGN KEY (option_id) REFERENCES odiseo."option"(id);
ALTER TABLE odiseo.origin_question ADD CONSTRAINT origin_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.origin_question ADD CONSTRAINT origin_question_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);
ALTER TABLE odiseo.origin_question ADD CONSTRAINT origin_question_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);


-- odiseo.origin_question_nq foreign keys

ALTER TABLE odiseo.origin_question_nq ADD CONSTRAINT origin_question_nq_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.origin_question_nq ADD CONSTRAINT origin_question_nq_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.origin_question_nq ADD CONSTRAINT origin_question_nq_question_ia_id_foreign FOREIGN KEY (question_ia_id) REFERENCES odiseo.question_teacher_ia(id);
ALTER TABLE odiseo.origin_question_nq ADD CONSTRAINT origin_question_nq_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.origin_question_nq ADD CONSTRAINT origin_question_nq_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.origin_university foreign keys

ALTER TABLE odiseo.origin_university ADD CONSTRAINT odiseo_origin_university_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.origin_university ADD CONSTRAINT odiseo_origin_university_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.origin_university ADD CONSTRAINT odiseo_origin_university_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);
ALTER TABLE odiseo.origin_university ADD CONSTRAINT odiseo_origin_university_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.parent_image foreign keys

ALTER TABLE odiseo.parent_image ADD CONSTRAINT odiseo_parent_image_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_image ADD CONSTRAINT odiseo_parent_image_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_image ADD CONSTRAINT odiseo_parent_image_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.parent_image ADD CONSTRAINT odiseo_parent_image_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.parent_observation foreign keys

ALTER TABLE odiseo.parent_observation ADD CONSTRAINT odiseo_parent_observation_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_observation ADD CONSTRAINT odiseo_parent_observation_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_observation ADD CONSTRAINT odiseo_parent_observation_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.parent_observation ADD CONSTRAINT odiseo_parent_observation_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.parent_question foreign keys

ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_modality_id_foreign FOREIGN KEY (modality_id) REFERENCES odiseo.modality(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_option_id_foreign FOREIGN KEY (option_id) REFERENCES odiseo."option"(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT odiseo_parent_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT parent_question_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.parent_question ADD CONSTRAINT parent_question_type_text_subcategory_id_foreign FOREIGN KEY (type_text_subcategory_id) REFERENCES odiseo.type_text_subcategories(id);


-- odiseo.parent_question_correlative foreign keys

ALTER TABLE odiseo.parent_question_correlative ADD CONSTRAINT parent_question_correlative_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);


-- odiseo.periodicity foreign keys

ALTER TABLE odiseo.periodicity ADD CONSTRAINT periodicity_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.periodicity ADD CONSTRAINT periodicity_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.periodicity ADD CONSTRAINT periodicity_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.permissions foreign keys

ALTER TABLE odiseo.permissions ADD CONSTRAINT odiseo_permissions_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.permissions ADD CONSTRAINT odiseo_permissions_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.permissions ADD CONSTRAINT odiseo_permissions_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo."plans" foreign keys

ALTER TABLE odiseo."plans" ADD CONSTRAINT odiseo_plans_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."plans" ADD CONSTRAINT odiseo_plans_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo."plans" ADD CONSTRAINT odiseo_plans_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.prospect foreign keys

ALTER TABLE odiseo.prospect ADD CONSTRAINT odiseo_prospect_code_id_foreign FOREIGN KEY (code_id) REFERENCES odiseo.code_prospect(id);
ALTER TABLE odiseo.prospect ADD CONSTRAINT odiseo_prospect_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.prospect ADD CONSTRAINT odiseo_prospect_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.prospect ADD CONSTRAINT odiseo_prospect_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.provinces foreign keys

ALTER TABLE odiseo.provinces ADD CONSTRAINT provinces_region_id_foreign FOREIGN KEY (region_id) REFERENCES odiseo.region(id);


-- odiseo.pseudo_course foreign keys

ALTER TABLE odiseo.pseudo_course ADD CONSTRAINT odiseo_pseudo_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.pseudo_course ADD CONSTRAINT odiseo_pseudo_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.pseudo_course ADD CONSTRAINT odiseo_pseudo_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question foreign keys

ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_config_alternative_id_foreign FOREIGN KEY (config_alternative_id) REFERENCES odiseo.configuration_alternative(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_teacher_id_foreign FOREIGN KEY (teacher_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.question ADD CONSTRAINT odiseo_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_attributes foreign keys

ALTER TABLE odiseo.question_attributes ADD CONSTRAINT question_attributes_question_attributes_type_id_foreign FOREIGN KEY (question_attributes_type_id) REFERENCES odiseo.question_attributes_type(id);
ALTER TABLE odiseo.question_attributes ADD CONSTRAINT question_attributes_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.question_attributes_type_course foreign keys

ALTER TABLE odiseo.question_attributes_type_course ADD CONSTRAINT question_attributes_type_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_attributes_type_course ADD CONSTRAINT question_attributes_type_course_question_attributes_type_id_for FOREIGN KEY (question_attributes_type_id) REFERENCES odiseo.question_attributes_type(id);


-- odiseo.question_excluded_material foreign keys

ALTER TABLE odiseo.question_excluded_material ADD CONSTRAINT question_excluded_material_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_excluded_material ADD CONSTRAINT question_excluded_material_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_excluded_material ADD CONSTRAINT question_excluded_material_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.question_excluded_material ADD CONSTRAINT question_excluded_material_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.question_field_diagrammed_nq foreign keys

ALTER TABLE odiseo.question_field_diagrammed_nq ADD CONSTRAINT fk_qfdn_course FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_field_diagrammed_nq ADD CONSTRAINT fk_qfdn_created_by FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_field_diagrammed_nq ADD CONSTRAINT fk_qfdn_field FOREIGN KEY (field_diagrammed_id) REFERENCES odiseo.field_diagrammed(id);
ALTER TABLE odiseo.question_field_diagrammed_nq ADD CONSTRAINT fk_qfdn_question FOREIGN KEY (question_teacher_ia_id) REFERENCES odiseo.question_teacher_ia(id);


-- odiseo.question_history_course foreign keys

ALTER TABLE odiseo.question_history_course ADD CONSTRAINT odiseo_question_history_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_history_course ADD CONSTRAINT odiseo_question_history_course_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_history_course ADD CONSTRAINT odiseo_question_history_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_history_cycle foreign keys

ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_headquarters_id_foreign FOREIGN KEY (headquarters_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT odiseo_question_history_cycle_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_history_cycle ADD CONSTRAINT question_history_cycle_parent_question_id_foreign FOREIGN KEY (parent_question_id) REFERENCES odiseo.parent_question(id);


-- odiseo.question_history_usage_exam_parent_question foreign keys

ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_material_exam_area_ FOREIGN KEY (material_exam_area_week_id) REFERENCES odiseo.material_exam_area_week(id);
ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_parent_question_id_ FOREIGN KEY (parent_question_id) REFERENCES odiseo.parent_question(id);
ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_history_usage_exam_parent_question ADD CONSTRAINT question_history_usage_exam_parent_question_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_ia_images foreign keys

ALTER TABLE odiseo.question_ia_images ADD CONSTRAINT question_ia_images_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_ia_images ADD CONSTRAINT question_ia_images_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_ia_images ADD CONSTRAINT question_ia_images_question_ia_id_foreign FOREIGN KEY (question_ia_id) REFERENCES odiseo.question_teacher_ia(id);
ALTER TABLE odiseo.question_ia_images ADD CONSTRAINT question_ia_images_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_image foreign keys

ALTER TABLE odiseo.question_image ADD CONSTRAINT odiseo_question_image_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_image ADD CONSTRAINT odiseo_question_image_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_image ADD CONSTRAINT odiseo_question_image_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_image ADD CONSTRAINT odiseo_question_image_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_maths foreign keys

ALTER TABLE odiseo.question_maths ADD CONSTRAINT odiseo_question_maths_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_maths ADD CONSTRAINT odiseo_question_maths_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_maths ADD CONSTRAINT odiseo_question_maths_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_maths ADD CONSTRAINT odiseo_question_maths_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_observation foreign keys

ALTER TABLE odiseo.question_observation ADD CONSTRAINT odiseo_question_observation_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_observation ADD CONSTRAINT odiseo_question_observation_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_observation ADD CONSTRAINT odiseo_question_observation_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_observation ADD CONSTRAINT odiseo_question_observation_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_pdf_jobs foreign keys

ALTER TABLE odiseo.question_pdf_jobs ADD CONSTRAINT odiseo_question_pdf_jobs_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.question_refuzed foreign keys

ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_category_rejected_id_foreign FOREIGN KEY (category_rejected_id) REFERENCES odiseo.category_rejected(id);
ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_importance_rejected_foreign FOREIGN KEY (importance_rejected) REFERENCES odiseo.importance_rejected(id);
ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_refuzed ADD CONSTRAINT odiseo_question_refuzed_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_secondary foreign keys

ALTER TABLE odiseo.question_secondary ADD CONSTRAINT question_secondary_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_secondary ADD CONSTRAINT question_secondary_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.question_shares foreign keys

ALTER TABLE odiseo.question_shares ADD CONSTRAINT question_shares_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_shares ADD CONSTRAINT question_shares_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_shares ADD CONSTRAINT question_shares_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.question_shares ADD CONSTRAINT question_shares_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);


-- odiseo.question_status foreign keys

ALTER TABLE odiseo.question_status ADD CONSTRAINT odiseo_question_status_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_status ADD CONSTRAINT odiseo_question_status_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);


-- odiseo.question_subtopic foreign keys

ALTER TABLE odiseo.question_subtopic ADD CONSTRAINT odiseo_question_subtopic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_subtopic ADD CONSTRAINT odiseo_question_subtopic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_subtopic ADD CONSTRAINT odiseo_question_subtopic_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_subtopic ADD CONSTRAINT odiseo_question_subtopic_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.question_subtopic ADD CONSTRAINT odiseo_question_subtopic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_teacher_ia foreign keys

ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_level_id_foreign FOREIGN KEY (level_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_level_old_id_foreign FOREIGN KEY (level_old_id) REFERENCES odiseo."level"(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_teacher_id_foreign FOREIGN KEY (teacher_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.question_teacher_ia ADD CONSTRAINT question_teacher_ia_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.question_temporary foreign keys

ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_question_id_foreign FOREIGN KEY (question_id) REFERENCES odiseo.question(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_type_material_template_id_foreign FOREIGN KEY (type_material_template_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.question_temporary ADD CONSTRAINT odiseo_question_temporary_week_id_foreign FOREIGN KEY (week_id) REFERENCES odiseo.week(id);


-- odiseo.region foreign keys

ALTER TABLE odiseo.region ADD CONSTRAINT odiseo_region_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.region ADD CONSTRAINT odiseo_region_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.region ADD CONSTRAINT odiseo_region_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.remembered_sessions foreign keys

ALTER TABLE odiseo.remembered_sessions ADD CONSTRAINT remembered_sessions_user_id_foreign FOREIGN KEY (user_id) REFERENCES odiseo.users(id) ON DELETE RESTRICT;


-- odiseo.roles foreign keys

ALTER TABLE odiseo.roles ADD CONSTRAINT odiseo_roles_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.roles ADD CONSTRAINT odiseo_roles_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.roles ADD CONSTRAINT odiseo_roles_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.roles ADD CONSTRAINT roles_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.roles_permissions foreign keys

ALTER TABLE odiseo.roles_permissions ADD CONSTRAINT odiseo_roles_permissions_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.roles_permissions ADD CONSTRAINT odiseo_roles_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES odiseo.permissions(id);
ALTER TABLE odiseo.roles_permissions ADD CONSTRAINT odiseo_roles_permissions_rol_id_foreign FOREIGN KEY (rol_id) REFERENCES odiseo.roles(id);
ALTER TABLE odiseo.roles_permissions ADD CONSTRAINT odiseo_roles_permissions_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.roles_permissions ADD CONSTRAINT roles_permissions_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.separated_material_exam_week foreign keys

ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_material_exam_area_week_id_ FOREIGN KEY (material_exam_area_week_id) REFERENCES odiseo.material_exam_area_week(id);
ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.separated_material_exam_week ADD CONSTRAINT odiseo_separated_material_exam_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.separated_material_week foreign keys

ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_material_id_foreign FOREIGN KEY (material_id) REFERENCES odiseo.material(id);
ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.separated_material_week ADD CONSTRAINT odiseo_separated_material_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.setting_diagrammed_courses foreign keys

ALTER TABLE odiseo.setting_diagrammed_courses ADD CONSTRAINT odiseo_setting_diagrammed_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.setting_diagrammed_courses ADD CONSTRAINT odiseo_setting_diagrammed_courses_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.setting_diagrammed_courses ADD CONSTRAINT odiseo_setting_diagrammed_courses_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.setting_diagrammed_courses ADD CONSTRAINT odiseo_setting_diagrammed_courses_field_diagram_id_foreign FOREIGN KEY (field_diagram_id) REFERENCES odiseo.field_diagrammed(id);
ALTER TABLE odiseo.setting_diagrammed_courses ADD CONSTRAINT odiseo_setting_diagrammed_courses_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.solution_ia_images foreign keys

ALTER TABLE odiseo.solution_ia_images ADD CONSTRAINT solution_ia_images_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.solution_ia_images ADD CONSTRAINT solution_ia_images_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.solution_ia_images ADD CONSTRAINT solution_ia_images_solution_ia_id_foreign FOREIGN KEY (solution_ia_id) REFERENCES odiseo.question_teacher_ia(id);
ALTER TABLE odiseo.solution_ia_images ADD CONSTRAINT solution_ia_images_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.subtopic foreign keys

ALTER TABLE odiseo.subtopic ADD CONSTRAINT odiseo_subtopic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.subtopic ADD CONSTRAINT odiseo_subtopic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.subtopic ADD CONSTRAINT odiseo_subtopic_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.subtopic ADD CONSTRAINT odiseo_subtopic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.subtopic_history foreign keys

ALTER TABLE odiseo.subtopic_history ADD CONSTRAINT odiseo_subtopic_history_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.subtopic_history ADD CONSTRAINT odiseo_subtopic_history_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.subtopic_history ADD CONSTRAINT odiseo_subtopic_history_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.subtopic_history ADD CONSTRAINT odiseo_subtopic_history_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.subtopic_history ADD CONSTRAINT odiseo_subtopic_history_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus foreign keys

ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_pseudo_course_id_foreign FOREIGN KEY (pseudo_course_id) REFERENCES odiseo.pseudo_course(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT odiseo_syllabus_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus ADD CONSTRAINT syllabus_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.syllabus_detail_subtopic foreign keys

ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT odiseo_syllabus_detail_subtopic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT odiseo_syllabus_detail_subtopic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT odiseo_syllabus_detail_subtopic_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT odiseo_syllabus_detail_subtopic_syllabus_topic_week_id_foreign FOREIGN KEY (syllabus_topic_week_id) REFERENCES odiseo.syllabus_topic_week(id);
ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT odiseo_syllabus_detail_subtopic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_detail_subtopic ADD CONSTRAINT syllabus_detail_subtopic_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.syllabus_subtopic_type_material foreign keys

ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT odiseo_syllabus_subtopic_type_material_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT odiseo_syllabus_subtopic_type_material_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT odiseo_syllabus_subtopic_type_material_syllabus_detail_subtopic FOREIGN KEY (syllabus_detail_subtopic_id) REFERENCES odiseo.syllabus_detail_subtopic(id);
ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT odiseo_syllabus_subtopic_type_material_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT odiseo_syllabus_subtopic_type_material_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_subtopic_type_material ADD CONSTRAINT syllabus_subtopic_type_material_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.syllabus_template foreign keys

ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_pseudo_course_id_foreign FOREIGN KEY (pseudo_course_id) REFERENCES odiseo.pseudo_course(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT odiseo_syllabus_template_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template ADD CONSTRAINT syllabus_template_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.syllabus_template_topic foreign keys

ALTER TABLE odiseo.syllabus_template_topic ADD CONSTRAINT odiseo_syllabus_template_topic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic ADD CONSTRAINT odiseo_syllabus_template_topic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic ADD CONSTRAINT odiseo_syllabus_template_topic_syllabus_template_id_foreign FOREIGN KEY (syllabus_template_id) REFERENCES odiseo.syllabus_template(id);
ALTER TABLE odiseo.syllabus_template_topic ADD CONSTRAINT odiseo_syllabus_template_topic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic ADD CONSTRAINT syllabus_template_topic_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.syllabus_template_topic_subtopic foreign keys

ALTER TABLE odiseo.syllabus_template_topic_subtopic ADD CONSTRAINT odiseo_syllabus_template_topic_subtopic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic_subtopic ADD CONSTRAINT odiseo_syllabus_template_topic_subtopic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic_subtopic ADD CONSTRAINT odiseo_syllabus_template_topic_subtopic_syllabus_template_topic FOREIGN KEY (syllabus_template_topic_id) REFERENCES odiseo.syllabus_template_topic(id);
ALTER TABLE odiseo.syllabus_template_topic_subtopic ADD CONSTRAINT odiseo_syllabus_template_topic_subtopic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_template_topic_subtopic ADD CONSTRAINT syllabus_template_topic_subtopic_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.syllabus_text_content foreign keys

ALTER TABLE odiseo.syllabus_text_content ADD CONSTRAINT syllabus_text_content_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;
ALTER TABLE odiseo.syllabus_text_content ADD CONSTRAINT syllabus_text_content_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_text_content ADD CONSTRAINT syllabus_text_content_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.syllabus_text_content ADD CONSTRAINT syllabus_text_content_syllabus_text_id_foreign FOREIGN KEY (syllabus_text_id) REFERENCES odiseo.syllabus_texts(id);
ALTER TABLE odiseo.syllabus_text_content ADD CONSTRAINT syllabus_text_content_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus_text_detail foreign keys

ALTER TABLE odiseo.syllabus_text_detail ADD CONSTRAINT syllabus_text_detail_syllabus_text_id_foreign FOREIGN KEY (syllabus_text_id) REFERENCES odiseo.syllabus_texts(id);


-- odiseo.syllabus_text_distributions foreign keys

ALTER TABLE odiseo.syllabus_text_distributions ADD CONSTRAINT syllabus_text_distributions_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;
ALTER TABLE odiseo.syllabus_text_distributions ADD CONSTRAINT syllabus_text_distributions_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_text_distributions ADD CONSTRAINT syllabus_text_distributions_syllabus_text_week_id_foreign FOREIGN KEY (syllabus_text_week_id) REFERENCES odiseo.syllabus_text_weeks(id);
ALTER TABLE odiseo.syllabus_text_distributions ADD CONSTRAINT syllabus_text_distributions_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.syllabus_text_distributions ADD CONSTRAINT syllabus_text_distributions_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus_text_weeks foreign keys

ALTER TABLE odiseo.syllabus_text_weeks ADD CONSTRAINT syllabus_text_weeks_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;
ALTER TABLE odiseo.syllabus_text_weeks ADD CONSTRAINT syllabus_text_weeks_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_text_weeks ADD CONSTRAINT syllabus_text_weeks_syllabus_id_foreign FOREIGN KEY (syllabus_id) REFERENCES odiseo.syllabus(id);
ALTER TABLE odiseo.syllabus_text_weeks ADD CONSTRAINT syllabus_text_weeks_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus_texts foreign keys

ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;
ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_syllabus_text_distribution_id_foreign FOREIGN KEY (syllabus_text_distribution_id) REFERENCES odiseo.syllabus_text_distributions(id);
ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_type_text_subcategory_id_foreign FOREIGN KEY (type_text_subcategory_id) REFERENCES odiseo.type_text_subcategories(id);
ALTER TABLE odiseo.syllabus_texts ADD CONSTRAINT syllabus_texts_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus_topic foreign keys

ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT odiseo_syllabus_topic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT odiseo_syllabus_topic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT odiseo_syllabus_topic_syllabus_id_foreign FOREIGN KEY (syllabus_id) REFERENCES odiseo.syllabus(id);
ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT odiseo_syllabus_topic_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT odiseo_syllabus_topic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic ADD CONSTRAINT syllabus_topic_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.syllabus_topic_week foreign keys

ALTER TABLE odiseo.syllabus_topic_week ADD CONSTRAINT odiseo_syllabus_topic_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic_week ADD CONSTRAINT odiseo_syllabus_topic_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic_week ADD CONSTRAINT odiseo_syllabus_topic_week_syllabus_topic_id_foreign FOREIGN KEY (syllabus_topic_id) REFERENCES odiseo.syllabus_topic(id);
ALTER TABLE odiseo.syllabus_topic_week ADD CONSTRAINT odiseo_syllabus_topic_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_topic_week ADD CONSTRAINT syllabus_topic_week_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.syllabus_type_text foreign keys

ALTER TABLE odiseo.syllabus_type_text ADD CONSTRAINT odiseo_syllabus_type_text_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_type_text ADD CONSTRAINT odiseo_syllabus_type_text_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_type_text ADD CONSTRAINT odiseo_syllabus_type_text_syllabus_id_foreign FOREIGN KEY (syllabus_id) REFERENCES odiseo.syllabus(id);
ALTER TABLE odiseo.syllabus_type_text ADD CONSTRAINT odiseo_syllabus_type_text_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.syllabus_type_text ADD CONSTRAINT odiseo_syllabus_type_text_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.syllabus_week_titles foreign keys

ALTER TABLE odiseo.syllabus_week_titles ADD CONSTRAINT odiseo_syllabus_week_titles_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_week_titles ADD CONSTRAINT odiseo_syllabus_week_titles_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_week_titles ADD CONSTRAINT odiseo_syllabus_week_titles_syllabus_id_foreign FOREIGN KEY (syllabus_id) REFERENCES odiseo.syllabus(id);
ALTER TABLE odiseo.syllabus_week_titles ADD CONSTRAINT odiseo_syllabus_week_titles_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.syllabus_week_titles ADD CONSTRAINT syllabus_week_titles_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id) ON DELETE CASCADE;


-- odiseo.teachers foreign keys

ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES odiseo.employees(id);
ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_level_rate_id_foreign FOREIGN KEY (level_rate_id) REFERENCES odiseo.level_rates(id);
ALTER TABLE odiseo.teachers ADD CONSTRAINT teachers_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.template_type_material_configurations foreign keys

ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_exam_area_id_forei FOREIGN KEY (exam_area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_type_material_temp FOREIGN KEY (type_material_template_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_type_template_id_f FOREIGN KEY (type_template_id) REFERENCES odiseo.type_templates(id);
ALTER TABLE odiseo.template_type_material_configurations ADD CONSTRAINT odiseo_template_type_material_configurations_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.template_type_material_courses_order foreign keys

ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT odiseo_template_type_material_courses_order_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT odiseo_template_type_material_courses_order_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT odiseo_template_type_material_courses_order_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT odiseo_template_type_material_courses_order_template_type_mater FOREIGN KEY (template_type_material_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT odiseo_template_type_material_courses_order_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.template_type_material_courses_order ADD CONSTRAINT template_type_material_courses_order_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);


-- odiseo.topic foreign keys

ALTER TABLE odiseo.topic ADD CONSTRAINT odiseo_topic_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.topic ADD CONSTRAINT odiseo_topic_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.topic ADD CONSTRAINT odiseo_topic_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.topic ADD CONSTRAINT odiseo_topic_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_archive foreign keys

ALTER TABLE odiseo.type_archive ADD CONSTRAINT odiseo_type_archive_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);


-- odiseo.type_material foreign keys

ALTER TABLE odiseo.type_material ADD CONSTRAINT odiseo_type_material_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT odiseo_type_material_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT odiseo_type_material_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT odiseo_type_material_type_material_template_id_foreign FOREIGN KEY (type_material_template_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT odiseo_type_material_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT type_material_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.type_material ADD CONSTRAINT type_material_cycle_id_foreign FOREIGN KEY (cycle_id) REFERENCES odiseo."cycle"(id);


-- odiseo.type_material_area foreign keys

ALTER TABLE odiseo.type_material_area ADD CONSTRAINT odiseo_type_material_area_area_id_foreign FOREIGN KEY (area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.type_material_area ADD CONSTRAINT odiseo_type_material_area_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_area ADD CONSTRAINT odiseo_type_material_area_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_area ADD CONSTRAINT odiseo_type_material_area_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_material_area ADD CONSTRAINT odiseo_type_material_area_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_area_courses foreign keys

ALTER TABLE odiseo.type_material_area_courses ADD CONSTRAINT odiseo_type_material_area_courses_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_area_courses ADD CONSTRAINT odiseo_type_material_area_courses_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_area_courses ADD CONSTRAINT odiseo_type_material_area_courses_type_material_area_id_foreign FOREIGN KEY (type_material_area_id) REFERENCES odiseo.type_material_area(id);
ALTER TABLE odiseo.type_material_area_courses ADD CONSTRAINT odiseo_type_material_area_courses_type_material_course_id_forei FOREIGN KEY (type_material_course_id) REFERENCES odiseo.type_material_course(id);
ALTER TABLE odiseo.type_material_area_courses ADD CONSTRAINT odiseo_type_material_area_courses_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_bound foreign keys

ALTER TABLE odiseo.type_material_bound ADD CONSTRAINT odiseo_type_material_bound_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_bound ADD CONSTRAINT odiseo_type_material_bound_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_bound ADD CONSTRAINT odiseo_type_material_bound_type_material_template_extra_id_fore FOREIGN KEY (type_material_template_extra_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.type_material_bound ADD CONSTRAINT odiseo_type_material_bound_type_material_template_id_foreign FOREIGN KEY (type_material_template_id) REFERENCES odiseo.type_material_template(id);
ALTER TABLE odiseo.type_material_bound ADD CONSTRAINT odiseo_type_material_bound_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_course foreign keys

ALTER TABLE odiseo.type_material_course ADD CONSTRAINT odiseo_type_material_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_material_course ADD CONSTRAINT odiseo_type_material_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_course ADD CONSTRAINT odiseo_type_material_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_course ADD CONSTRAINT odiseo_type_material_course_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_material_course ADD CONSTRAINT odiseo_type_material_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_detail_course_texts foreign keys

ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_type_material_course_id_forei FOREIGN KEY (type_material_course_id) REFERENCES odiseo.type_material_course(id);
ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_type_material_detail_template FOREIGN KEY (type_material_detail_template_id) REFERENCES odiseo.type_material_detail_template(id);
ALTER TABLE odiseo.type_material_detail_course_texts ADD CONSTRAINT type_material_detail_course_texts_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_detail_courses foreign keys

ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_type_material_course_id_foreign FOREIGN KEY (type_material_course_id) REFERENCES odiseo.type_material_course(id);
ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_type_material_detail_template_id_f FOREIGN KEY (type_material_detail_template_id) REFERENCES odiseo.type_material_detail_template(id);
ALTER TABLE odiseo.type_material_detail_courses ADD CONSTRAINT type_material_detail_courses_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_detail_template foreign keys

ALTER TABLE odiseo.type_material_detail_template ADD CONSTRAINT odiseo_type_material_detail_template_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_template ADD CONSTRAINT odiseo_type_material_detail_template_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_template ADD CONSTRAINT odiseo_type_material_detail_template_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_material_detail_template ADD CONSTRAINT odiseo_type_material_detail_template_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_detail_text_subquestions foreign keys

ALTER TABLE odiseo.type_material_detail_text_subquestions ADD CONSTRAINT type_material_detail_text_subquestions_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_text_subquestions ADD CONSTRAINT type_material_detail_text_subquestions_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_detail_text_subquestions ADD CONSTRAINT type_material_detail_text_subquestions_type_material_detail_cou FOREIGN KEY (type_material_detail_course_text_id) REFERENCES odiseo.type_material_detail_course_texts(id);
ALTER TABLE odiseo.type_material_detail_text_subquestions ADD CONSTRAINT type_material_detail_text_subquestions_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_periodicity foreign keys

ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_periodicity_id_foreign FOREIGN KEY (periodicity_id) REFERENCES odiseo.periodicity(id);
ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_material_periodicity ADD CONSTRAINT type_material_periodicity_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_material_template foreign keys

ALTER TABLE odiseo.type_material_template ADD CONSTRAINT odiseo_type_material_template_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;
ALTER TABLE odiseo.type_material_template ADD CONSTRAINT odiseo_type_material_template_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;
ALTER TABLE odiseo.type_material_template ADD CONSTRAINT odiseo_type_material_template_type_exam_id_foreign FOREIGN KEY (type_exam_id) REFERENCES odiseo.type_exams(id);
ALTER TABLE odiseo.type_material_template ADD CONSTRAINT odiseo_type_material_template_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;


-- odiseo.type_material_template_configuration_columns foreign keys

ALTER TABLE odiseo.type_material_template_configuration_columns ADD CONSTRAINT type_material_template_configuration_columns_type_material_temp FOREIGN KEY (type_material_template_id) REFERENCES odiseo.type_material_template(id);


-- odiseo.type_templates foreign keys

ALTER TABLE odiseo.type_templates ADD CONSTRAINT type_templates_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.type_text foreign keys

ALTER TABLE odiseo.type_text ADD CONSTRAINT odiseo_type_text_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;
ALTER TABLE odiseo.type_text ADD CONSTRAINT odiseo_type_text_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;
ALTER TABLE odiseo.type_text ADD CONSTRAINT odiseo_type_text_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id) ON DELETE SET NULL;


-- odiseo.type_text_exam_material_configuration foreign keys

ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_area_id_foreign FOREIGN KEY (area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_exam_material_config_id_f FOREIGN KEY (exam_material_config_id) REFERENCES odiseo.exam_material_configurations(id) ON DELETE CASCADE;
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_type_text_level_id_foreig FOREIGN KEY (type_text_level_id) REFERENCES odiseo.type_text_level(id);
ALTER TABLE odiseo.type_text_exam_material_configuration ADD CONSTRAINT type_text_exam_material_configuration_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_text_level foreign keys

ALTER TABLE odiseo.type_text_level ADD CONSTRAINT type_text_level_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_level ADD CONSTRAINT type_text_level_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_level ADD CONSTRAINT type_text_level_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_text_material_type_course foreign keys

ALTER TABLE odiseo.type_text_material_type_course ADD CONSTRAINT type_text_material_type_course_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_text_material_type_course ADD CONSTRAINT type_text_material_type_course_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_material_type_course ADD CONSTRAINT type_text_material_type_course_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_material_type_course ADD CONSTRAINT type_text_material_type_course_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_text_material_type_course ADD CONSTRAINT type_text_material_type_course_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_text_material_type_course_area foreign keys

ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_course_id_foreign FOREIGN KEY (course_id) REFERENCES odiseo.course(id);
ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_exam_area_id_foreign FOREIGN KEY (exam_area_id) REFERENCES odiseo.exam_area(id);
ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_type_material_id_foreign FOREIGN KEY (type_material_id) REFERENCES odiseo.type_material(id);
ALTER TABLE odiseo.type_text_material_type_course_area ADD CONSTRAINT type_text_material_type_course_area_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_text_subcategories foreign keys

ALTER TABLE odiseo.type_text_subcategories ADD CONSTRAINT type_text_subcategories_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_subcategories ADD CONSTRAINT type_text_subcategories_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_text_subcategories ADD CONSTRAINT type_text_subcategories_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_text_to_subcategory foreign keys

ALTER TABLE odiseo.type_text_to_subcategory ADD CONSTRAINT type_text_to_subcategory_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.type_text_to_subcategory ADD CONSTRAINT type_text_to_subcategory_type_text_subcategory_id_foreign FOREIGN KEY (type_text_subcategory_id) REFERENCES odiseo.type_text_subcategories(id);


-- odiseo.type_texts_subtopics foreign keys

ALTER TABLE odiseo.type_texts_subtopics ADD CONSTRAINT type_texts_subtopics_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_texts_subtopics ADD CONSTRAINT type_texts_subtopics_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_texts_subtopics ADD CONSTRAINT type_texts_subtopics_subtopic_id_foreign FOREIGN KEY (subtopic_id) REFERENCES odiseo.subtopic(id);
ALTER TABLE odiseo.type_texts_subtopics ADD CONSTRAINT type_texts_subtopics_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.type_texts_subtopics ADD CONSTRAINT type_texts_subtopics_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_texts_topics foreign keys

ALTER TABLE odiseo.type_texts_topics ADD CONSTRAINT type_texts_topics_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_texts_topics ADD CONSTRAINT type_texts_topics_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_texts_topics ADD CONSTRAINT type_texts_topics_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES odiseo.topic(id);
ALTER TABLE odiseo.type_texts_topics ADD CONSTRAINT type_texts_topics_type_text_id_foreign FOREIGN KEY (type_text_id) REFERENCES odiseo.type_text(id);
ALTER TABLE odiseo.type_texts_topics ADD CONSTRAINT type_texts_topics_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.type_week foreign keys

ALTER TABLE odiseo.type_week ADD CONSTRAINT odiseo_type_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_week ADD CONSTRAINT odiseo_type_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.type_week ADD CONSTRAINT odiseo_type_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.university_headquarters foreign keys

ALTER TABLE odiseo.university_headquarters ADD CONSTRAINT odiseo_university_headquarters_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.university_headquarters ADD CONSTRAINT odiseo_university_headquarters_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.university_headquarters ADD CONSTRAINT odiseo_university_headquarters_headquarters_id_foreign FOREIGN KEY (headquarters_id) REFERENCES odiseo.headquarters(id);
ALTER TABLE odiseo.university_headquarters ADD CONSTRAINT odiseo_university_headquarters_university_id_foreign FOREIGN KEY (university_id) REFERENCES odiseo.origin_university(id);
ALTER TABLE odiseo.university_headquarters ADD CONSTRAINT odiseo_university_headquarters_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.users foreign keys

ALTER TABLE odiseo.users ADD CONSTRAINT odiseo_users_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);
ALTER TABLE odiseo.users ADD CONSTRAINT odiseo_users_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.users ADD CONSTRAINT odiseo_users_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.users ADD CONSTRAINT odiseo_users_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);


-- odiseo.users_roles foreign keys

ALTER TABLE odiseo.users_roles ADD CONSTRAINT odiseo_users_roles_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.users_roles ADD CONSTRAINT odiseo_users_roles_rol_id_foreign FOREIGN KEY (rol_id) REFERENCES odiseo.roles(id);
ALTER TABLE odiseo.users_roles ADD CONSTRAINT odiseo_users_roles_rol_parent_id_foreign FOREIGN KEY (rol_parent_id) REFERENCES odiseo.users_roles(id);
ALTER TABLE odiseo.users_roles ADD CONSTRAINT odiseo_users_roles_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.users_roles ADD CONSTRAINT users_roles_company_id_foreign FOREIGN KEY (company_id) REFERENCES odiseo.companies(id);


-- odiseo.week foreign keys

ALTER TABLE odiseo.week ADD CONSTRAINT odiseo_week_created_by_foreign FOREIGN KEY (created_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.week ADD CONSTRAINT odiseo_week_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES odiseo.users(id);
ALTER TABLE odiseo.week ADD CONSTRAINT odiseo_week_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES odiseo.users(id);

