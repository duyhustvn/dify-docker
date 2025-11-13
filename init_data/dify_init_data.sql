--
-- PostgreSQL database dump
--

\restrict GosiRzAaXS6mo8uIEaaM18fxO6S4HRYdo6lLh7ov3JWEUWdJpUkJUBN2zC7UlAZ

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Debian 16.10-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_integrates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_integrates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    provider character varying(16) NOT NULL,
    open_id character varying(255) NOT NULL,
    encrypted_token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.account_integrates OWNER TO postgres;

--
-- Name: account_plugin_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_plugin_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    install_permission character varying(16) DEFAULT 'everyone'::character varying NOT NULL,
    debug_permission character varying(16) DEFAULT 'noone'::character varying NOT NULL
);


ALTER TABLE public.account_plugin_permissions OWNER TO postgres;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    password_salt character varying(255),
    avatar character varying(255),
    interface_language character varying(255),
    interface_theme character varying(255),
    timezone character varying(255),
    last_login_at timestamp without time zone,
    last_login_ip character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    initialized_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: api_based_extensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_based_extensions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    api_endpoint character varying(255) NOT NULL,
    api_key text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.api_based_extensions OWNER TO postgres;

--
-- Name: api_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_requests (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    api_token_id uuid NOT NULL,
    path character varying(255) NOT NULL,
    request text,
    response text,
    ip character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.api_requests OWNER TO postgres;

--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid,
    type character varying(16) NOT NULL,
    token character varying(255) NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.api_tokens OWNER TO postgres;

--
-- Name: app_annotation_hit_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_annotation_hit_histories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    annotation_id uuid NOT NULL,
    source text NOT NULL,
    question text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    score double precision DEFAULT 0 NOT NULL,
    message_id uuid NOT NULL,
    annotation_question text NOT NULL,
    annotation_content text NOT NULL
);


ALTER TABLE public.app_annotation_hit_histories OWNER TO postgres;

--
-- Name: app_annotation_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_annotation_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    score_threshold double precision DEFAULT 0 NOT NULL,
    collection_binding_id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_user_id uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.app_annotation_settings OWNER TO postgres;

--
-- Name: app_dataset_joins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_dataset_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.app_dataset_joins OWNER TO postgres;

--
-- Name: app_mcp_servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_mcp_servers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    server_code character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    parameters text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.app_mcp_servers OWNER TO postgres;

--
-- Name: app_model_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    provider character varying(255),
    model_id character varying(255),
    configs json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    opening_statement text,
    suggested_questions text,
    suggested_questions_after_answer text,
    more_like_this text,
    model text,
    user_input_form text,
    pre_prompt text,
    agent_mode text,
    speech_to_text text,
    sensitive_word_avoidance text,
    retriever_resource text,
    dataset_query_variable character varying(255),
    prompt_type character varying(255) DEFAULT 'simple'::character varying NOT NULL,
    chat_prompt_config text,
    completion_prompt_config text,
    dataset_configs text,
    external_data_tools text,
    file_upload text,
    text_to_speech text,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.app_model_configs OWNER TO postgres;

--
-- Name: apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    mode character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    app_model_config_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    enable_site boolean NOT NULL,
    enable_api boolean NOT NULL,
    api_rpm integer DEFAULT 0 NOT NULL,
    api_rph integer DEFAULT 0 NOT NULL,
    is_demo boolean DEFAULT false NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_universal boolean DEFAULT false NOT NULL,
    workflow_id uuid,
    description text DEFAULT ''::character varying NOT NULL,
    tracing text,
    max_active_requests integer,
    icon_type character varying(255),
    created_by uuid,
    updated_by uuid,
    use_icon_as_answer_icon boolean DEFAULT false NOT NULL
);


ALTER TABLE public.apps OWNER TO postgres;

--
-- Name: task_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_id_sequence OWNER TO postgres;

--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_taskmeta (
    id integer DEFAULT nextval('public.task_id_sequence'::regclass) NOT NULL,
    task_id character varying(155),
    status character varying(50),
    result bytea,
    date_done timestamp without time zone,
    traceback text,
    name character varying(155),
    args bytea,
    kwargs bytea,
    worker character varying(155),
    retries integer,
    queue character varying(155)
);


ALTER TABLE public.celery_taskmeta OWNER TO postgres;

--
-- Name: taskset_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taskset_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taskset_id_sequence OWNER TO postgres;

--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_tasksetmeta (
    id integer DEFAULT nextval('public.taskset_id_sequence'::regclass) NOT NULL,
    taskset_id character varying(155),
    result bytea,
    date_done timestamp without time zone
);


ALTER TABLE public.celery_tasksetmeta OWNER TO postgres;

--
-- Name: child_chunks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.child_chunks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    segment_id uuid NOT NULL,
    "position" integer NOT NULL,
    content text NOT NULL,
    word_count integer NOT NULL,
    index_node_id character varying(255),
    index_node_hash character varying(255),
    type character varying(255) DEFAULT 'automatic'::character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    indexing_at timestamp without time zone,
    completed_at timestamp without time zone,
    error text
);


ALTER TABLE public.child_chunks OWNER TO postgres;

--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    app_model_config_id uuid,
    model_provider character varying(255),
    override_model_configs text,
    model_id character varying(255),
    mode character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    summary text,
    inputs json NOT NULL,
    introduction text,
    system_instruction text,
    system_instruction_tokens integer DEFAULT 0 NOT NULL,
    status character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    read_at timestamp without time zone,
    read_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    invoke_from character varying(255),
    dialogue_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: data_source_api_key_auth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_source_api_key_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    category character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);


ALTER TABLE public.data_source_api_key_auth_bindings OWNER TO postgres;

--
-- Name: data_source_oauth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_source_oauth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    access_token character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    source_info jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);


ALTER TABLE public.data_source_oauth_bindings OWNER TO postgres;

--
-- Name: dataset_auto_disable_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_auto_disable_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    notified boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dataset_auto_disable_logs OWNER TO postgres;

--
-- Name: dataset_collection_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_collection_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    collection_name character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    type character varying(40) DEFAULT 'dataset'::character varying NOT NULL
);


ALTER TABLE public.dataset_collection_bindings OWNER TO postgres;

--
-- Name: dataset_keyword_tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_keyword_tables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    keyword_table text NOT NULL,
    data_source_type character varying(255) DEFAULT 'database'::character varying NOT NULL
);


ALTER TABLE public.dataset_keyword_tables OWNER TO postgres;

--
-- Name: dataset_metadata_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_metadata_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    metadata_id uuid NOT NULL,
    document_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by uuid NOT NULL
);


ALTER TABLE public.dataset_metadata_bindings OWNER TO postgres;

--
-- Name: dataset_metadatas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_metadatas (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid
);


ALTER TABLE public.dataset_metadatas OWNER TO postgres;

--
-- Name: dataset_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    account_id uuid NOT NULL,
    has_permission boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid NOT NULL
);


ALTER TABLE public.dataset_permissions OWNER TO postgres;

--
-- Name: dataset_process_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_process_rules (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    mode character varying(255) DEFAULT 'automatic'::character varying NOT NULL,
    rules text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dataset_process_rules OWNER TO postgres;

--
-- Name: dataset_queries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_queries (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    content text NOT NULL,
    source character varying(255) NOT NULL,
    source_app_id uuid,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dataset_queries OWNER TO postgres;

--
-- Name: dataset_retriever_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_retriever_resources (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    "position" integer NOT NULL,
    dataset_id uuid NOT NULL,
    dataset_name text NOT NULL,
    document_id uuid,
    document_name text NOT NULL,
    data_source_type text,
    segment_id uuid,
    score double precision,
    content text NOT NULL,
    hit_count integer,
    word_count integer,
    segment_position integer,
    index_node_hash text,
    retriever_from text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dataset_retriever_resources OWNER TO postgres;

--
-- Name: datasets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    provider character varying(255) DEFAULT 'vendor'::character varying NOT NULL,
    permission character varying(255) DEFAULT 'only_me'::character varying NOT NULL,
    data_source_type character varying(255),
    indexing_technique character varying(255),
    index_struct text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    embedding_model character varying(255) DEFAULT 'text-embedding-ada-002'::character varying,
    embedding_model_provider character varying(255) DEFAULT 'openai'::character varying,
    collection_binding_id uuid,
    retrieval_model jsonb,
    built_in_field_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.datasets OWNER TO postgres;

--
-- Name: dify_setups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dify_setups (
    version character varying(255) NOT NULL,
    setup_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dify_setups OWNER TO postgres;

--
-- Name: document_segments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_segments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    "position" integer NOT NULL,
    content text NOT NULL,
    word_count integer NOT NULL,
    tokens integer NOT NULL,
    keywords json,
    index_node_id character varying(255),
    index_node_hash character varying(255),
    hit_count integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    indexing_at timestamp without time zone,
    completed_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    answer text,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.document_segments OWNER TO postgres;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    "position" integer NOT NULL,
    data_source_type character varying(255) NOT NULL,
    data_source_info text,
    dataset_process_rule_id uuid,
    batch character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_api_request_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    processing_started_at timestamp without time zone,
    file_id text,
    word_count integer,
    parsing_completed_at timestamp without time zone,
    cleaning_completed_at timestamp without time zone,
    splitting_completed_at timestamp without time zone,
    tokens integer,
    indexing_latency double precision,
    completed_at timestamp without time zone,
    is_paused boolean DEFAULT false,
    paused_by uuid,
    paused_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    indexing_status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    archived boolean DEFAULT false NOT NULL,
    archived_reason character varying(255),
    archived_by uuid,
    archived_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    doc_type character varying(40),
    doc_metadata jsonb,
    doc_form character varying(255) DEFAULT 'text_model'::character varying NOT NULL,
    doc_language character varying(255)
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: embeddings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.embeddings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    hash character varying(64) NOT NULL,
    embedding bytea NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    model_name character varying(255) DEFAULT 'text-embedding-ada-002'::character varying NOT NULL,
    provider_name character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.embeddings OWNER TO postgres;

--
-- Name: end_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.end_users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid,
    type character varying(255) NOT NULL,
    external_user_id character varying(255),
    name character varying(255),
    is_anonymous boolean DEFAULT true NOT NULL,
    session_id character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.end_users OWNER TO postgres;

--
-- Name: external_knowledge_apis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_knowledge_apis (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    tenant_id uuid NOT NULL,
    settings text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.external_knowledge_apis OWNER TO postgres;

--
-- Name: external_knowledge_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_knowledge_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    external_knowledge_api_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    external_knowledge_id text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.external_knowledge_bindings OWNER TO postgres;

--
-- Name: installed_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installed_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    app_owner_tenant_id uuid NOT NULL,
    "position" integer NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.installed_apps OWNER TO postgres;

--
-- Name: invitation_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitation_codes (
    id integer NOT NULL,
    batch character varying(255) NOT NULL,
    code character varying(32) NOT NULL,
    status character varying(16) DEFAULT 'unused'::character varying NOT NULL,
    used_at timestamp without time zone,
    used_by_tenant_id uuid,
    used_by_account_id uuid,
    deprecated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.invitation_codes OWNER TO postgres;

--
-- Name: invitation_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invitation_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invitation_codes_id_seq OWNER TO postgres;

--
-- Name: invitation_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invitation_codes_id_seq OWNED BY public.invitation_codes.id;


--
-- Name: load_balancing_model_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.load_balancing_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    encrypted_config text,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.load_balancing_model_configs OWNER TO postgres;

--
-- Name: message_agent_thoughts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_agent_thoughts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    message_chain_id uuid,
    "position" integer NOT NULL,
    thought text,
    tool text,
    tool_input text,
    observation text,
    tool_process_data text,
    message text,
    message_token integer,
    message_unit_price numeric,
    answer text,
    answer_token integer,
    answer_unit_price numeric,
    tokens integer,
    total_price numeric,
    currency character varying,
    latency double precision,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    message_files text,
    tool_labels_str text DEFAULT '{}'::text NOT NULL,
    tool_meta_str text DEFAULT '{}'::text NOT NULL
);


ALTER TABLE public.message_agent_thoughts OWNER TO postgres;

--
-- Name: message_annotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_annotations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid,
    message_id uuid,
    content text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    question text,
    hit_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.message_annotations OWNER TO postgres;

--
-- Name: message_chains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_chains (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    input text,
    output text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.message_chains OWNER TO postgres;

--
-- Name: message_feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_feedbacks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    message_id uuid NOT NULL,
    rating character varying(255) NOT NULL,
    content text,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.message_feedbacks OWNER TO postgres;

--
-- Name: message_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    transfer_method character varying(255) NOT NULL,
    url text,
    upload_file_id uuid,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    belongs_to character varying(255)
);


ALTER TABLE public.message_files OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    model_provider character varying(255),
    model_id character varying(255),
    override_model_configs text,
    conversation_id uuid NOT NULL,
    inputs json NOT NULL,
    query text NOT NULL,
    message json NOT NULL,
    message_tokens integer DEFAULT 0 NOT NULL,
    message_unit_price numeric(10,4) NOT NULL,
    answer text NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    agent_based boolean DEFAULT false NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    workflow_run_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    error text,
    message_metadata text,
    invoke_from character varying(255),
    parent_message_id uuid
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: operation_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operation_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    action character varying(255) NOT NULL,
    content json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_ip character varying(255) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.operation_logs OWNER TO postgres;

--
-- Name: pinned_conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pinned_conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);


ALTER TABLE public.pinned_conversations OWNER TO postgres;

--
-- Name: provider_model_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_model_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    load_balancing_enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_model_settings OWNER TO postgres;

--
-- Name: provider_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_models OWNER TO postgres;

--
-- Name: provider_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    account_id uuid NOT NULL,
    payment_product_id character varying(191) NOT NULL,
    payment_id character varying(191),
    transaction_id character varying(191),
    quantity integer DEFAULT 1 NOT NULL,
    currency character varying(40),
    total_amount integer,
    payment_status character varying(40) DEFAULT 'wait_pay'::character varying NOT NULL,
    paid_at timestamp without time zone,
    pay_failed_at timestamp without time zone,
    refunded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_orders OWNER TO postgres;

--
-- Name: providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    provider_type character varying(40) DEFAULT 'custom'::character varying NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    last_used timestamp without time zone,
    quota_type character varying(40) DEFAULT ''::character varying,
    quota_limit bigint,
    quota_used bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.providers OWNER TO postgres;

--
-- Name: rate_limit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rate_limit_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    subscription_plan character varying(255) NOT NULL,
    operation character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.rate_limit_logs OWNER TO postgres;

--
-- Name: recommended_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommended_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    description json NOT NULL,
    copyright character varying(255) NOT NULL,
    privacy_policy character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    "position" integer NOT NULL,
    is_listed boolean NOT NULL,
    install_count integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_disclaimer text NOT NULL
);


ALTER TABLE public.recommended_apps OWNER TO postgres;

--
-- Name: saved_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    message_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);


ALTER TABLE public.saved_messages OWNER TO postgres;

--
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    description text,
    default_language character varying(255) NOT NULL,
    copyright character varying(255),
    privacy_policy character varying(255),
    customize_domain character varying(255),
    customize_token_strategy character varying(255) NOT NULL,
    prompt_public boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    code character varying(255),
    custom_disclaimer text NOT NULL,
    show_workflow_steps boolean DEFAULT true NOT NULL,
    chat_color_theme character varying(255),
    chat_color_theme_inverted boolean DEFAULT false NOT NULL,
    icon_type character varying(255),
    created_by uuid,
    updated_by uuid,
    use_icon_as_answer_icon boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- Name: tag_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    tag_id uuid,
    target_id uuid,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tag_bindings OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    type character varying(16) NOT NULL,
    name character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tenant_account_joins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_account_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    role character varying(16) DEFAULT 'normal'::character varying NOT NULL,
    invited_by uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    current boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tenant_account_joins OWNER TO postgres;

--
-- Name: tenant_default_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_default_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tenant_default_models OWNER TO postgres;

--
-- Name: tenant_preferred_model_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_preferred_model_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    preferred_provider_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tenant_preferred_model_providers OWNER TO postgres;

--
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    encrypt_public_key text,
    plan character varying(255) DEFAULT 'basic'::character varying NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    custom_config text
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- Name: tidb_auth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tidb_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    cluster_id character varying(255) NOT NULL,
    cluster_name character varying(255) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'CREATING'::character varying NOT NULL,
    account character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tidb_auth_bindings OWNER TO postgres;

--
-- Name: tool_api_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_api_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    schema text NOT NULL,
    schema_type_str character varying(40) NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    tools_str text NOT NULL,
    icon character varying(255) NOT NULL,
    credentials_str text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255),
    custom_disclaimer text NOT NULL
);


ALTER TABLE public.tool_api_providers OWNER TO postgres;

--
-- Name: tool_builtin_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_builtin_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL,
    provider character varying(256) NOT NULL,
    encrypted_credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_builtin_providers OWNER TO postgres;

--
-- Name: tool_conversation_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_conversation_variables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    variables_str text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_conversation_variables OWNER TO postgres;

--
-- Name: tool_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid,
    file_key character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL,
    original_url character varying(2048),
    name character varying NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.tool_files OWNER TO postgres;

--
-- Name: tool_label_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_label_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tool_id character varying(64) NOT NULL,
    tool_type character varying(40) NOT NULL,
    label_name character varying(40) NOT NULL
);


ALTER TABLE public.tool_label_bindings OWNER TO postgres;

--
-- Name: tool_mcp_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_mcp_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(40) NOT NULL,
    server_identifier character varying(24) NOT NULL,
    server_url text NOT NULL,
    server_url_hash character varying(64) NOT NULL,
    icon character varying(255),
    tenant_id uuid NOT NULL,
    user_id uuid NOT NULL,
    encrypted_credentials text,
    authed boolean NOT NULL,
    tools text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_mcp_providers OWNER TO postgres;

--
-- Name: tool_model_invokes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_model_invokes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    provider character varying(255) NOT NULL,
    tool_type character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    model_parameters text NOT NULL,
    prompt_messages text NOT NULL,
    model_response text NOT NULL,
    prompt_tokens integer DEFAULT 0 NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_model_invokes OWNER TO postgres;

--
-- Name: tool_published_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_published_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    description text NOT NULL,
    llm_description text NOT NULL,
    query_description text NOT NULL,
    query_name character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    author character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_published_apps OWNER TO postgres;

--
-- Name: tool_workflow_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_workflow_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(255) NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    description text NOT NULL,
    parameter_configuration text DEFAULT '[]'::text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255) DEFAULT ''::character varying,
    version character varying(255) DEFAULT ''::character varying NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tool_workflow_providers OWNER TO postgres;

--
-- Name: trace_app_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trace_app_config (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    tracing_provider character varying(255),
    tracing_config json,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.trace_app_config OWNER TO postgres;

--
-- Name: upload_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upload_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    storage_type character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    size integer NOT NULL,
    extension character varying(255) NOT NULL,
    mime_type character varying(255),
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    used_by uuid,
    used_at timestamp without time zone,
    hash character varying(255),
    created_by_role character varying(255) DEFAULT 'account'::character varying NOT NULL,
    source_url text DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.upload_files OWNER TO postgres;

--
-- Name: whitelists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.whitelists (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    category character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.whitelists OWNER TO postgres;

--
-- Name: workflow_app_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_app_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    workflow_run_id uuid NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.workflow_app_logs OWNER TO postgres;

--
-- Name: workflow_conversation_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_conversation_variables (
    id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    app_id uuid NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.workflow_conversation_variables OWNER TO postgres;

--
-- Name: workflow_draft_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_draft_variables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    app_id uuid NOT NULL,
    last_edited_at timestamp without time zone,
    node_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    selector character varying(255) NOT NULL,
    value_type character varying(20) NOT NULL,
    value text NOT NULL,
    visible boolean NOT NULL,
    editable boolean NOT NULL,
    node_execution_id uuid
);


ALTER TABLE public.workflow_draft_variables OWNER TO postgres;

--
-- Name: workflow_node_executions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_node_executions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    triggered_from character varying(255) NOT NULL,
    workflow_run_id uuid,
    index integer NOT NULL,
    predecessor_node_id character varying(255),
    node_id character varying(255) NOT NULL,
    node_type character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    inputs text,
    process_data text,
    outputs text,
    status character varying(255) NOT NULL,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    execution_metadata text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    finished_at timestamp without time zone,
    node_execution_id character varying(255)
);


ALTER TABLE public.workflow_node_executions OWNER TO postgres;

--
-- Name: workflow_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_runs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    triggered_from character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text,
    inputs text,
    status character varying(255) NOT NULL,
    outputs text,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    total_tokens bigint DEFAULT 0 NOT NULL,
    total_steps integer DEFAULT 0,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    finished_at timestamp without time zone,
    exceptions_count integer DEFAULT 0
);


ALTER TABLE public.workflow_runs OWNER TO postgres;

--
-- Name: workflows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflows (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text NOT NULL,
    features text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone NOT NULL,
    environment_variables text DEFAULT '{}'::text NOT NULL,
    conversation_variables text DEFAULT '{}'::text NOT NULL,
    marked_name character varying DEFAULT ''::character varying NOT NULL,
    marked_comment character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.workflows OWNER TO postgres;

--
-- Name: invitation_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes ALTER COLUMN id SET DEFAULT nextval('public.invitation_codes_id_seq'::regclass);


--
-- Data for Name: account_integrates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_integrates (id, account_id, provider, open_id, encrypted_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: account_plugin_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_plugin_permissions (id, tenant_id, install_permission, debug_permission) FROM stdin;
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, name, email, password, password_salt, avatar, interface_language, interface_theme, timezone, last_login_at, last_login_ip, status, initialized_at, created_at, updated_at, last_active_at) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
58eb7bdb93fe
\.


--
-- Data for Name: api_based_extensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_based_extensions (id, tenant_id, name, api_endpoint, api_key, created_at) FROM stdin;
\.


--
-- Data for Name: api_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_requests (id, tenant_id, api_token_id, path, request, response, ip, created_at) FROM stdin;
\.


--
-- Data for Name: api_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_tokens (id, app_id, type, token, last_used_at, created_at, tenant_id) FROM stdin;
\.


--
-- Data for Name: app_annotation_hit_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_annotation_hit_histories (id, app_id, annotation_id, source, question, account_id, created_at, score, message_id, annotation_question, annotation_content) FROM stdin;
\.


--
-- Data for Name: app_annotation_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_annotation_settings (id, app_id, score_threshold, collection_binding_id, created_user_id, created_at, updated_user_id, updated_at) FROM stdin;
\.


--
-- Data for Name: app_dataset_joins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_dataset_joins (id, app_id, dataset_id, created_at) FROM stdin;
\.


--
-- Data for Name: app_mcp_servers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_mcp_servers (id, tenant_id, app_id, name, description, server_code, status, parameters, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: app_model_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_model_configs (id, app_id, provider, model_id, configs, created_at, updated_at, opening_statement, suggested_questions, suggested_questions_after_answer, more_like_this, model, user_input_form, pre_prompt, agent_mode, speech_to_text, sensitive_word_avoidance, retriever_resource, dataset_query_variable, prompt_type, chat_prompt_config, completion_prompt_config, dataset_configs, external_data_tools, file_upload, text_to_speech, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps (id, tenant_id, name, mode, icon, icon_background, app_model_config_id, status, enable_site, enable_api, api_rpm, api_rph, is_demo, is_public, created_at, updated_at, is_universal, workflow_id, description, tracing, max_active_requests, icon_type, created_by, updated_by, use_icon_as_answer_icon) FROM stdin;
\.


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_taskmeta (id, task_id, status, result, date_done, traceback, name, args, kwargs, worker, retries, queue) FROM stdin;
\.


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_tasksetmeta (id, taskset_id, result, date_done) FROM stdin;
\.


--
-- Data for Name: child_chunks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.child_chunks (id, tenant_id, dataset_id, document_id, segment_id, "position", content, word_count, index_node_id, index_node_hash, type, created_by, created_at, updated_by, updated_at, indexing_at, completed_at, error) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, app_id, app_model_config_id, model_provider, override_model_configs, model_id, mode, name, summary, inputs, introduction, system_instruction, system_instruction_tokens, status, from_source, from_end_user_id, from_account_id, read_at, read_account_id, created_at, updated_at, is_deleted, invoke_from, dialogue_count) FROM stdin;
\.


--
-- Data for Name: data_source_api_key_auth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_source_api_key_auth_bindings (id, tenant_id, category, provider, credentials, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: data_source_oauth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_source_oauth_bindings (id, tenant_id, access_token, provider, source_info, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: dataset_auto_disable_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_auto_disable_logs (id, tenant_id, dataset_id, document_id, notified, created_at) FROM stdin;
\.


--
-- Data for Name: dataset_collection_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_collection_bindings (id, provider_name, model_name, collection_name, created_at, type) FROM stdin;
\.


--
-- Data for Name: dataset_keyword_tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_keyword_tables (id, dataset_id, keyword_table, data_source_type) FROM stdin;
\.


--
-- Data for Name: dataset_metadata_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_metadata_bindings (id, tenant_id, dataset_id, metadata_id, document_id, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: dataset_metadatas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_metadatas (id, tenant_id, dataset_id, type, name, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: dataset_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_permissions (id, dataset_id, account_id, has_permission, created_at, tenant_id) FROM stdin;
\.


--
-- Data for Name: dataset_process_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_process_rules (id, dataset_id, mode, rules, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: dataset_queries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_queries (id, dataset_id, content, source, source_app_id, created_by_role, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: dataset_retriever_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_retriever_resources (id, message_id, "position", dataset_id, dataset_name, document_id, document_name, data_source_type, segment_id, score, content, hit_count, word_count, segment_position, index_node_hash, retriever_from, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: datasets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasets (id, tenant_id, name, description, provider, permission, data_source_type, indexing_technique, index_struct, created_by, created_at, updated_by, updated_at, embedding_model, embedding_model_provider, collection_binding_id, retrieval_model, built_in_field_enabled) FROM stdin;
\.


--
-- Data for Name: dify_setups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dify_setups (version, setup_at) FROM stdin;
\.


--
-- Data for Name: document_segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_segments (id, tenant_id, dataset_id, document_id, "position", content, word_count, tokens, keywords, index_node_id, index_node_hash, hit_count, enabled, disabled_at, disabled_by, status, created_by, created_at, indexing_at, completed_at, error, stopped_at, answer, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, tenant_id, dataset_id, "position", data_source_type, data_source_info, dataset_process_rule_id, batch, name, created_from, created_by, created_api_request_id, created_at, processing_started_at, file_id, word_count, parsing_completed_at, cleaning_completed_at, splitting_completed_at, tokens, indexing_latency, completed_at, is_paused, paused_by, paused_at, error, stopped_at, indexing_status, enabled, disabled_at, disabled_by, archived, archived_reason, archived_by, archived_at, updated_at, doc_type, doc_metadata, doc_form, doc_language) FROM stdin;
\.


--
-- Data for Name: embeddings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.embeddings (id, hash, embedding, created_at, model_name, provider_name) FROM stdin;
\.


--
-- Data for Name: end_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.end_users (id, tenant_id, app_id, type, external_user_id, name, is_anonymous, session_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: external_knowledge_apis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_knowledge_apis (id, name, description, tenant_id, settings, created_by, created_at, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: external_knowledge_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_knowledge_bindings (id, tenant_id, external_knowledge_api_id, dataset_id, external_knowledge_id, created_by, created_at, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: installed_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installed_apps (id, tenant_id, app_id, app_owner_tenant_id, "position", is_pinned, last_used_at, created_at) FROM stdin;
\.


--
-- Data for Name: invitation_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitation_codes (id, batch, code, status, used_at, used_by_tenant_id, used_by_account_id, deprecated_at, created_at) FROM stdin;
\.


--
-- Data for Name: load_balancing_model_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.load_balancing_model_configs (id, tenant_id, provider_name, model_name, model_type, name, encrypted_config, enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: message_agent_thoughts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_agent_thoughts (id, message_id, message_chain_id, "position", thought, tool, tool_input, observation, tool_process_data, message, message_token, message_unit_price, answer, answer_token, answer_unit_price, tokens, total_price, currency, latency, created_by_role, created_by, created_at, message_price_unit, answer_price_unit, message_files, tool_labels_str, tool_meta_str) FROM stdin;
\.


--
-- Data for Name: message_annotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_annotations (id, app_id, conversation_id, message_id, content, account_id, created_at, updated_at, question, hit_count) FROM stdin;
\.


--
-- Data for Name: message_chains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_chains (id, message_id, type, input, output, created_at) FROM stdin;
\.


--
-- Data for Name: message_feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_feedbacks (id, app_id, conversation_id, message_id, rating, content, from_source, from_end_user_id, from_account_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: message_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_files (id, message_id, type, transfer_method, url, upload_file_id, created_by_role, created_by, created_at, belongs_to) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, app_id, model_provider, model_id, override_model_configs, conversation_id, inputs, query, message, message_tokens, message_unit_price, answer, answer_tokens, answer_unit_price, provider_response_latency, total_price, currency, from_source, from_end_user_id, from_account_id, created_at, updated_at, agent_based, message_price_unit, answer_price_unit, workflow_run_id, status, error, message_metadata, invoke_from, parent_message_id) FROM stdin;
\.


--
-- Data for Name: operation_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operation_logs (id, tenant_id, account_id, action, content, created_at, created_ip, updated_at) FROM stdin;
\.


--
-- Data for Name: pinned_conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pinned_conversations (id, app_id, conversation_id, created_by, created_at, created_by_role) FROM stdin;
\.


--
-- Data for Name: provider_model_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_model_settings (id, tenant_id, provider_name, model_name, model_type, enabled, load_balancing_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: provider_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_models (id, tenant_id, provider_name, model_name, model_type, encrypted_config, is_valid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: provider_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_orders (id, tenant_id, provider_name, account_id, payment_product_id, payment_id, transaction_id, quantity, currency, total_amount, payment_status, paid_at, pay_failed_at, refunded_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.providers (id, tenant_id, provider_name, provider_type, encrypted_config, is_valid, last_used, quota_type, quota_limit, quota_used, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rate_limit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rate_limit_logs (id, tenant_id, subscription_plan, operation, created_at) FROM stdin;
\.


--
-- Data for Name: recommended_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommended_apps (id, app_id, description, copyright, privacy_policy, category, "position", is_listed, install_count, created_at, updated_at, language, custom_disclaimer) FROM stdin;
\.


--
-- Data for Name: saved_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_messages (id, app_id, message_id, created_by, created_at, created_by_role) FROM stdin;
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (id, app_id, title, icon, icon_background, description, default_language, copyright, privacy_policy, customize_domain, customize_token_strategy, prompt_public, status, created_at, updated_at, code, custom_disclaimer, show_workflow_steps, chat_color_theme, chat_color_theme_inverted, icon_type, created_by, updated_by, use_icon_as_answer_icon) FROM stdin;
\.


--
-- Data for Name: tag_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag_bindings (id, tenant_id, tag_id, target_id, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, tenant_id, type, name, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: tenant_account_joins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_account_joins (id, tenant_id, account_id, role, invited_by, created_at, updated_at, current) FROM stdin;
\.


--
-- Data for Name: tenant_default_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_default_models (id, tenant_id, provider_name, model_name, model_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tenant_preferred_model_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_preferred_model_providers (id, tenant_id, provider_name, preferred_provider_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenants (id, name, encrypt_public_key, plan, status, created_at, updated_at, custom_config) FROM stdin;
\.


--
-- Data for Name: tidb_auth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tidb_auth_bindings (id, tenant_id, cluster_id, cluster_name, active, status, account, password, created_at) FROM stdin;
\.


--
-- Data for Name: tool_api_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_api_providers (id, name, schema, schema_type_str, user_id, tenant_id, tools_str, icon, credentials_str, description, created_at, updated_at, privacy_policy, custom_disclaimer) FROM stdin;
\.


--
-- Data for Name: tool_builtin_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_builtin_providers (id, tenant_id, user_id, provider, encrypted_credentials, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_conversation_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_conversation_variables (id, user_id, tenant_id, conversation_id, variables_str, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_files (id, user_id, tenant_id, conversation_id, file_key, mimetype, original_url, name, size) FROM stdin;
\.


--
-- Data for Name: tool_label_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_label_bindings (id, tool_id, tool_type, label_name) FROM stdin;
\.


--
-- Data for Name: tool_mcp_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_mcp_providers (id, name, server_identifier, server_url, server_url_hash, icon, tenant_id, user_id, encrypted_credentials, authed, tools, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_model_invokes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_model_invokes (id, user_id, tenant_id, provider, tool_type, tool_name, model_parameters, prompt_messages, model_response, prompt_tokens, answer_tokens, answer_unit_price, answer_price_unit, provider_response_latency, total_price, currency, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_published_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_published_apps (id, app_id, user_id, description, llm_description, query_description, query_name, tool_name, author, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_workflow_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_workflow_providers (id, name, icon, app_id, user_id, tenant_id, description, parameter_configuration, created_at, updated_at, privacy_policy, version, label) FROM stdin;
\.


--
-- Data for Name: trace_app_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trace_app_config (id, app_id, tracing_provider, tracing_config, created_at, updated_at, is_active) FROM stdin;
\.


--
-- Data for Name: upload_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.upload_files (id, tenant_id, storage_type, key, name, size, extension, mime_type, created_by, created_at, used, used_by, used_at, hash, created_by_role, source_url) FROM stdin;
\.


--
-- Data for Name: whitelists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.whitelists (id, tenant_id, category, created_at) FROM stdin;
\.


--
-- Data for Name: workflow_app_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_app_logs (id, tenant_id, app_id, workflow_id, workflow_run_id, created_from, created_by_role, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: workflow_conversation_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_conversation_variables (id, conversation_id, app_id, data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_draft_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_draft_variables (id, created_at, updated_at, app_id, last_edited_at, node_id, name, description, selector, value_type, value, visible, editable, node_execution_id) FROM stdin;
\.


--
-- Data for Name: workflow_node_executions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_node_executions (id, tenant_id, app_id, workflow_id, triggered_from, workflow_run_id, index, predecessor_node_id, node_id, node_type, title, inputs, process_data, outputs, status, error, elapsed_time, execution_metadata, created_at, created_by_role, created_by, finished_at, node_execution_id) FROM stdin;
\.


--
-- Data for Name: workflow_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_runs (id, tenant_id, app_id, workflow_id, type, triggered_from, version, graph, inputs, status, outputs, error, elapsed_time, total_tokens, total_steps, created_by_role, created_by, created_at, finished_at, exceptions_count) FROM stdin;
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflows (id, tenant_id, app_id, type, version, graph, features, created_by, created_at, updated_by, updated_at, environment_variables, conversation_variables, marked_name, marked_comment) FROM stdin;
\.


--
-- Name: invitation_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invitation_codes_id_seq', 1, false);


--
-- Name: task_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_sequence', 1, false);


--
-- Name: taskset_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taskset_id_sequence', 1, false);


--
-- Name: account_integrates account_integrate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT account_integrate_pkey PRIMARY KEY (id);


--
-- Name: accounts account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account_plugin_permissions account_plugin_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_plugin_permissions
    ADD CONSTRAINT account_plugin_permission_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: api_based_extensions api_based_extension_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_based_extensions
    ADD CONSTRAINT api_based_extension_pkey PRIMARY KEY (id);


--
-- Name: api_requests api_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_requests
    ADD CONSTRAINT api_request_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_token_pkey PRIMARY KEY (id);


--
-- Name: app_annotation_hit_histories app_annotation_hit_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_annotation_hit_histories
    ADD CONSTRAINT app_annotation_hit_histories_pkey PRIMARY KEY (id);


--
-- Name: app_annotation_settings app_annotation_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_annotation_settings
    ADD CONSTRAINT app_annotation_settings_pkey PRIMARY KEY (id);


--
-- Name: app_dataset_joins app_dataset_join_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_dataset_joins
    ADD CONSTRAINT app_dataset_join_pkey PRIMARY KEY (id);


--
-- Name: app_mcp_servers app_mcp_server_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_mcp_servers
    ADD CONSTRAINT app_mcp_server_pkey PRIMARY KEY (id);


--
-- Name: app_model_configs app_model_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_model_configs
    ADD CONSTRAINT app_model_config_pkey PRIMARY KEY (id);


--
-- Name: apps app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps
    ADD CONSTRAINT app_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: child_chunks child_chunk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.child_chunks
    ADD CONSTRAINT child_chunk_pkey PRIMARY KEY (id);


--
-- Name: conversations conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: data_source_api_key_auth_bindings data_source_api_key_auth_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_source_api_key_auth_bindings
    ADD CONSTRAINT data_source_api_key_auth_binding_pkey PRIMARY KEY (id);


--
-- Name: dataset_auto_disable_logs dataset_auto_disable_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_auto_disable_logs
    ADD CONSTRAINT dataset_auto_disable_log_pkey PRIMARY KEY (id);


--
-- Name: dataset_collection_bindings dataset_collection_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_collection_bindings
    ADD CONSTRAINT dataset_collection_bindings_pkey PRIMARY KEY (id);


--
-- Name: dataset_keyword_tables dataset_keyword_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_keyword_tables
    ADD CONSTRAINT dataset_keyword_table_pkey PRIMARY KEY (id);


--
-- Name: dataset_keyword_tables dataset_keyword_tables_dataset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_keyword_tables
    ADD CONSTRAINT dataset_keyword_tables_dataset_id_key UNIQUE (dataset_id);


--
-- Name: dataset_metadata_bindings dataset_metadata_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_metadata_bindings
    ADD CONSTRAINT dataset_metadata_binding_pkey PRIMARY KEY (id);


--
-- Name: dataset_metadatas dataset_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_metadatas
    ADD CONSTRAINT dataset_metadata_pkey PRIMARY KEY (id);


--
-- Name: dataset_permissions dataset_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_permissions
    ADD CONSTRAINT dataset_permission_pkey PRIMARY KEY (id);


--
-- Name: datasets dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasets
    ADD CONSTRAINT dataset_pkey PRIMARY KEY (id);


--
-- Name: dataset_process_rules dataset_process_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_process_rules
    ADD CONSTRAINT dataset_process_rule_pkey PRIMARY KEY (id);


--
-- Name: dataset_queries dataset_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_queries
    ADD CONSTRAINT dataset_query_pkey PRIMARY KEY (id);


--
-- Name: dataset_retriever_resources dataset_retriever_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_retriever_resources
    ADD CONSTRAINT dataset_retriever_resource_pkey PRIMARY KEY (id);


--
-- Name: dify_setups dify_setup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dify_setups
    ADD CONSTRAINT dify_setup_pkey PRIMARY KEY (version);


--
-- Name: documents document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- Name: document_segments document_segment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_segments
    ADD CONSTRAINT document_segment_pkey PRIMARY KEY (id);


--
-- Name: embeddings embedding_hash_idx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.embeddings
    ADD CONSTRAINT embedding_hash_idx UNIQUE (model_name, hash, provider_name);


--
-- Name: embeddings embedding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.embeddings
    ADD CONSTRAINT embedding_pkey PRIMARY KEY (id);


--
-- Name: end_users end_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.end_users
    ADD CONSTRAINT end_user_pkey PRIMARY KEY (id);


--
-- Name: external_knowledge_apis external_knowledge_apis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_knowledge_apis
    ADD CONSTRAINT external_knowledge_apis_pkey PRIMARY KEY (id);


--
-- Name: external_knowledge_bindings external_knowledge_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_knowledge_bindings
    ADD CONSTRAINT external_knowledge_bindings_pkey PRIMARY KEY (id);


--
-- Name: installed_apps installed_app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_apps
    ADD CONSTRAINT installed_app_pkey PRIMARY KEY (id);


--
-- Name: invitation_codes invitation_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT invitation_code_pkey PRIMARY KEY (id);


--
-- Name: load_balancing_model_configs load_balancing_model_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.load_balancing_model_configs
    ADD CONSTRAINT load_balancing_model_config_pkey PRIMARY KEY (id);


--
-- Name: message_agent_thoughts message_agent_thought_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_agent_thoughts
    ADD CONSTRAINT message_agent_thought_pkey PRIMARY KEY (id);


--
-- Name: message_annotations message_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_annotations
    ADD CONSTRAINT message_annotation_pkey PRIMARY KEY (id);


--
-- Name: message_chains message_chain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_chains
    ADD CONSTRAINT message_chain_pkey PRIMARY KEY (id);


--
-- Name: message_feedbacks message_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_feedbacks
    ADD CONSTRAINT message_feedback_pkey PRIMARY KEY (id);


--
-- Name: message_files message_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_files
    ADD CONSTRAINT message_file_pkey PRIMARY KEY (id);


--
-- Name: messages message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: operation_logs operation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operation_logs
    ADD CONSTRAINT operation_log_pkey PRIMARY KEY (id);


--
-- Name: pinned_conversations pinned_conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pinned_conversations
    ADD CONSTRAINT pinned_conversation_pkey PRIMARY KEY (id);


--
-- Name: provider_models provider_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_models
    ADD CONSTRAINT provider_model_pkey PRIMARY KEY (id);


--
-- Name: provider_model_settings provider_model_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_model_settings
    ADD CONSTRAINT provider_model_setting_pkey PRIMARY KEY (id);


--
-- Name: provider_orders provider_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_orders
    ADD CONSTRAINT provider_order_pkey PRIMARY KEY (id);


--
-- Name: providers provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);


--
-- Name: tool_published_apps published_app_tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT published_app_tool_pkey PRIMARY KEY (id);


--
-- Name: rate_limit_logs rate_limit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_limit_logs
    ADD CONSTRAINT rate_limit_log_pkey PRIMARY KEY (id);


--
-- Name: recommended_apps recommended_app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommended_apps
    ADD CONSTRAINT recommended_app_pkey PRIMARY KEY (id);


--
-- Name: saved_messages saved_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_messages
    ADD CONSTRAINT saved_message_pkey PRIMARY KEY (id);


--
-- Name: sites site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT site_pkey PRIMARY KEY (id);


--
-- Name: data_source_oauth_bindings source_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_source_oauth_bindings
    ADD CONSTRAINT source_binding_pkey PRIMARY KEY (id);


--
-- Name: tag_bindings tag_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_bindings
    ADD CONSTRAINT tag_binding_pkey PRIMARY KEY (id);


--
-- Name: tags tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tenant_account_joins tenant_account_join_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_account_joins
    ADD CONSTRAINT tenant_account_join_pkey PRIMARY KEY (id);


--
-- Name: tenant_default_models tenant_default_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_default_models
    ADD CONSTRAINT tenant_default_model_pkey PRIMARY KEY (id);


--
-- Name: tenants tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: tenant_preferred_model_providers tenant_preferred_model_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_preferred_model_providers
    ADD CONSTRAINT tenant_preferred_model_provider_pkey PRIMARY KEY (id);


--
-- Name: tidb_auth_bindings tidb_auth_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tidb_auth_bindings
    ADD CONSTRAINT tidb_auth_bindings_pkey PRIMARY KEY (id);


--
-- Name: tool_api_providers tool_api_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_api_providers
    ADD CONSTRAINT tool_api_provider_pkey PRIMARY KEY (id);


--
-- Name: tool_builtin_providers tool_builtin_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_builtin_providers
    ADD CONSTRAINT tool_builtin_provider_pkey PRIMARY KEY (id);


--
-- Name: tool_conversation_variables tool_conversation_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_conversation_variables
    ADD CONSTRAINT tool_conversation_variables_pkey PRIMARY KEY (id);


--
-- Name: tool_files tool_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_files
    ADD CONSTRAINT tool_file_pkey PRIMARY KEY (id);


--
-- Name: tool_label_bindings tool_label_bind_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_label_bindings
    ADD CONSTRAINT tool_label_bind_pkey PRIMARY KEY (id);


--
-- Name: tool_mcp_providers tool_mcp_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_mcp_providers
    ADD CONSTRAINT tool_mcp_provider_pkey PRIMARY KEY (id);


--
-- Name: tool_model_invokes tool_model_invoke_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_model_invokes
    ADD CONSTRAINT tool_model_invoke_pkey PRIMARY KEY (id);


--
-- Name: tool_workflow_providers tool_workflow_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT tool_workflow_provider_pkey PRIMARY KEY (id);


--
-- Name: trace_app_config trace_app_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace_app_config
    ADD CONSTRAINT trace_app_config_pkey PRIMARY KEY (id);


--
-- Name: account_integrates unique_account_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT unique_account_provider UNIQUE (account_id, provider);


--
-- Name: tool_api_providers unique_api_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_api_providers
    ADD CONSTRAINT unique_api_tool_provider UNIQUE (name, tenant_id);


--
-- Name: app_mcp_servers unique_app_mcp_server_server_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_mcp_servers
    ADD CONSTRAINT unique_app_mcp_server_server_code UNIQUE (server_code);


--
-- Name: app_mcp_servers unique_app_mcp_server_tenant_app_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_mcp_servers
    ADD CONSTRAINT unique_app_mcp_server_tenant_app_id UNIQUE (tenant_id, app_id);


--
-- Name: tool_builtin_providers unique_builtin_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_builtin_providers
    ADD CONSTRAINT unique_builtin_tool_provider UNIQUE (tenant_id, provider);


--
-- Name: tool_mcp_providers unique_mcp_provider_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_mcp_providers
    ADD CONSTRAINT unique_mcp_provider_name UNIQUE (tenant_id, name);


--
-- Name: tool_mcp_providers unique_mcp_provider_server_identifier; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_mcp_providers
    ADD CONSTRAINT unique_mcp_provider_server_identifier UNIQUE (tenant_id, server_identifier);


--
-- Name: tool_mcp_providers unique_mcp_provider_server_url; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_mcp_providers
    ADD CONSTRAINT unique_mcp_provider_server_url UNIQUE (tenant_id, server_url_hash);


--
-- Name: provider_models unique_provider_model_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_models
    ADD CONSTRAINT unique_provider_model_name UNIQUE (tenant_id, provider_name, model_name, model_type);


--
-- Name: providers unique_provider_name_type_quota; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT unique_provider_name_type_quota UNIQUE (tenant_id, provider_name, provider_type, quota_type);


--
-- Name: account_integrates unique_provider_open_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT unique_provider_open_id UNIQUE (provider, open_id);


--
-- Name: tool_published_apps unique_published_app_tool; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT unique_published_app_tool UNIQUE (app_id, user_id);


--
-- Name: tenant_account_joins unique_tenant_account_join; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_account_joins
    ADD CONSTRAINT unique_tenant_account_join UNIQUE (tenant_id, account_id);


--
-- Name: installed_apps unique_tenant_app; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_apps
    ADD CONSTRAINT unique_tenant_app UNIQUE (tenant_id, app_id);


--
-- Name: account_plugin_permissions unique_tenant_plugin; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_plugin_permissions
    ADD CONSTRAINT unique_tenant_plugin UNIQUE (tenant_id);


--
-- Name: tool_label_bindings unique_tool_label_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_label_bindings
    ADD CONSTRAINT unique_tool_label_bind UNIQUE (tool_id, label_name);


--
-- Name: tool_workflow_providers unique_workflow_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT unique_workflow_tool_provider UNIQUE (name, tenant_id);


--
-- Name: tool_workflow_providers unique_workflow_tool_provider_app_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT unique_workflow_tool_provider_app_id UNIQUE (tenant_id, app_id);


--
-- Name: upload_files upload_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_files
    ADD CONSTRAINT upload_file_pkey PRIMARY KEY (id);


--
-- Name: whitelists whitelists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whitelists
    ADD CONSTRAINT whitelists_pkey PRIMARY KEY (id);


--
-- Name: workflow_conversation_variables workflow__conversation_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_conversation_variables
    ADD CONSTRAINT workflow__conversation_variables_pkey PRIMARY KEY (id, conversation_id);


--
-- Name: workflow_app_logs workflow_app_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_app_logs
    ADD CONSTRAINT workflow_app_log_pkey PRIMARY KEY (id);


--
-- Name: workflow_draft_variables workflow_draft_variables_app_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_draft_variables
    ADD CONSTRAINT workflow_draft_variables_app_id_key UNIQUE (app_id, node_id, name);


--
-- Name: workflow_draft_variables workflow_draft_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_draft_variables
    ADD CONSTRAINT workflow_draft_variables_pkey PRIMARY KEY (id);


--
-- Name: workflow_node_executions workflow_node_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_node_executions
    ADD CONSTRAINT workflow_node_execution_pkey PRIMARY KEY (id);


--
-- Name: workflows workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- Name: workflow_runs workflow_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT workflow_run_pkey PRIMARY KEY (id);


--
-- Name: account_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_email_idx ON public.accounts USING btree (email);


--
-- Name: api_based_extension_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_based_extension_tenant_idx ON public.api_based_extensions USING btree (tenant_id);


--
-- Name: api_request_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_request_token_idx ON public.api_requests USING btree (tenant_id, api_token_id);


--
-- Name: api_token_app_id_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_app_id_type_idx ON public.api_tokens USING btree (app_id, type);


--
-- Name: api_token_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_tenant_idx ON public.api_tokens USING btree (tenant_id, type);


--
-- Name: api_token_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_token_idx ON public.api_tokens USING btree (token, type);


--
-- Name: app_annotation_hit_histories_account_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_account_idx ON public.app_annotation_hit_histories USING btree (account_id);


--
-- Name: app_annotation_hit_histories_annotation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_annotation_idx ON public.app_annotation_hit_histories USING btree (annotation_id);


--
-- Name: app_annotation_hit_histories_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_app_idx ON public.app_annotation_hit_histories USING btree (app_id);


--
-- Name: app_annotation_hit_histories_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_message_idx ON public.app_annotation_hit_histories USING btree (message_id);


--
-- Name: app_annotation_settings_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_settings_app_idx ON public.app_annotation_settings USING btree (app_id);


--
-- Name: app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_app_id_idx ON public.app_model_configs USING btree (app_id);


--
-- Name: app_dataset_join_app_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_dataset_join_app_dataset_idx ON public.app_dataset_joins USING btree (dataset_id, app_id);


--
-- Name: app_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_tenant_id_idx ON public.apps USING btree (tenant_id);


--
-- Name: child_chunk_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX child_chunk_dataset_id_idx ON public.child_chunks USING btree (tenant_id, dataset_id, document_id, segment_id, index_node_id);


--
-- Name: child_chunks_node_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX child_chunks_node_idx ON public.child_chunks USING btree (index_node_id, dataset_id);


--
-- Name: child_chunks_segment_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX child_chunks_segment_idx ON public.child_chunks USING btree (segment_id);


--
-- Name: conversation_app_from_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversation_app_from_user_idx ON public.conversations USING btree (app_id, from_source, from_end_user_id);


--
-- Name: conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversation_id_idx ON public.tool_conversation_variables USING btree (conversation_id);


--
-- Name: created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX created_at_idx ON public.embeddings USING btree (created_at);


--
-- Name: data_source_api_key_auth_binding_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_source_api_key_auth_binding_provider_idx ON public.data_source_api_key_auth_bindings USING btree (provider);


--
-- Name: data_source_api_key_auth_binding_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_source_api_key_auth_binding_tenant_id_idx ON public.data_source_api_key_auth_bindings USING btree (tenant_id);


--
-- Name: dataset_auto_disable_log_created_atx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_created_atx ON public.dataset_auto_disable_logs USING btree (created_at);


--
-- Name: dataset_auto_disable_log_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_dataset_idx ON public.dataset_auto_disable_logs USING btree (dataset_id);


--
-- Name: dataset_auto_disable_log_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_tenant_idx ON public.dataset_auto_disable_logs USING btree (tenant_id);


--
-- Name: dataset_keyword_table_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_keyword_table_dataset_id_idx ON public.dataset_keyword_tables USING btree (dataset_id);


--
-- Name: dataset_metadata_binding_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_dataset_idx ON public.dataset_metadata_bindings USING btree (dataset_id);


--
-- Name: dataset_metadata_binding_document_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_document_idx ON public.dataset_metadata_bindings USING btree (document_id);


--
-- Name: dataset_metadata_binding_metadata_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_metadata_idx ON public.dataset_metadata_bindings USING btree (metadata_id);


--
-- Name: dataset_metadata_binding_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_tenant_idx ON public.dataset_metadata_bindings USING btree (tenant_id);


--
-- Name: dataset_metadata_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_dataset_idx ON public.dataset_metadatas USING btree (dataset_id);


--
-- Name: dataset_metadata_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_tenant_idx ON public.dataset_metadatas USING btree (tenant_id);


--
-- Name: dataset_process_rule_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_process_rule_dataset_id_idx ON public.dataset_process_rules USING btree (dataset_id);


--
-- Name: dataset_query_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_query_dataset_id_idx ON public.dataset_queries USING btree (dataset_id);


--
-- Name: dataset_retriever_resource_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_retriever_resource_message_id_idx ON public.dataset_retriever_resources USING btree (message_id);


--
-- Name: dataset_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_tenant_idx ON public.datasets USING btree (tenant_id);


--
-- Name: document_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_dataset_id_idx ON public.documents USING btree (dataset_id);


--
-- Name: document_is_paused_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_is_paused_idx ON public.documents USING btree (is_paused);


--
-- Name: document_metadata_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_metadata_idx ON public.documents USING gin (doc_metadata);


--
-- Name: document_segment_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_dataset_id_idx ON public.document_segments USING btree (dataset_id);


--
-- Name: document_segment_document_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_document_id_idx ON public.document_segments USING btree (document_id);


--
-- Name: document_segment_node_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_node_dataset_idx ON public.document_segments USING btree (index_node_id, dataset_id);


--
-- Name: document_segment_tenant_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_dataset_idx ON public.document_segments USING btree (dataset_id, tenant_id);


--
-- Name: document_segment_tenant_document_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_document_idx ON public.document_segments USING btree (document_id, tenant_id);


--
-- Name: document_segment_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_idx ON public.document_segments USING btree (tenant_id);


--
-- Name: document_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_tenant_idx ON public.documents USING btree (tenant_id);


--
-- Name: end_user_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX end_user_session_id_idx ON public.end_users USING btree (session_id, type);


--
-- Name: end_user_tenant_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX end_user_tenant_session_id_idx ON public.end_users USING btree (tenant_id, session_id, type);


--
-- Name: external_knowledge_apis_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_apis_name_idx ON public.external_knowledge_apis USING btree (name);


--
-- Name: external_knowledge_apis_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_apis_tenant_idx ON public.external_knowledge_apis USING btree (tenant_id);


--
-- Name: external_knowledge_bindings_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_dataset_idx ON public.external_knowledge_bindings USING btree (dataset_id);


--
-- Name: external_knowledge_bindings_external_knowledge_api_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_external_knowledge_api_idx ON public.external_knowledge_bindings USING btree (external_knowledge_api_id);


--
-- Name: external_knowledge_bindings_external_knowledge_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_external_knowledge_idx ON public.external_knowledge_bindings USING btree (external_knowledge_id);


--
-- Name: external_knowledge_bindings_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_tenant_idx ON public.external_knowledge_bindings USING btree (tenant_id);


--
-- Name: idx_dataset_permissions_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_account_id ON public.dataset_permissions USING btree (account_id);


--
-- Name: idx_dataset_permissions_dataset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_dataset_id ON public.dataset_permissions USING btree (dataset_id);


--
-- Name: idx_dataset_permissions_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_tenant_id ON public.dataset_permissions USING btree (tenant_id);


--
-- Name: installed_app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX installed_app_app_id_idx ON public.installed_apps USING btree (app_id);


--
-- Name: installed_app_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX installed_app_tenant_id_idx ON public.installed_apps USING btree (tenant_id);


--
-- Name: invitation_codes_batch_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX invitation_codes_batch_idx ON public.invitation_codes USING btree (batch);


--
-- Name: invitation_codes_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX invitation_codes_code_idx ON public.invitation_codes USING btree (code, status);


--
-- Name: load_balancing_model_config_tenant_provider_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX load_balancing_model_config_tenant_provider_model_idx ON public.load_balancing_model_configs USING btree (tenant_id, provider_name, model_type);


--
-- Name: message_account_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_account_idx ON public.messages USING btree (app_id, from_source, from_account_id);


--
-- Name: message_agent_thought_message_chain_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_agent_thought_message_chain_id_idx ON public.message_agent_thoughts USING btree (message_chain_id);


--
-- Name: message_agent_thought_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_agent_thought_message_id_idx ON public.message_agent_thoughts USING btree (message_id);


--
-- Name: message_annotation_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_app_idx ON public.message_annotations USING btree (app_id);


--
-- Name: message_annotation_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_conversation_idx ON public.message_annotations USING btree (conversation_id);


--
-- Name: message_annotation_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_message_idx ON public.message_annotations USING btree (message_id);


--
-- Name: message_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_app_id_idx ON public.messages USING btree (app_id, created_at);


--
-- Name: message_chain_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_chain_message_id_idx ON public.message_chains USING btree (message_id);


--
-- Name: message_conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_conversation_id_idx ON public.messages USING btree (conversation_id);


--
-- Name: message_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_created_at_idx ON public.messages USING btree (created_at);


--
-- Name: message_end_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_end_user_idx ON public.messages USING btree (app_id, from_source, from_end_user_id);


--
-- Name: message_feedback_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_app_idx ON public.message_feedbacks USING btree (app_id);


--
-- Name: message_feedback_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_conversation_idx ON public.message_feedbacks USING btree (conversation_id, from_source, rating);


--
-- Name: message_feedback_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_message_idx ON public.message_feedbacks USING btree (message_id, from_source);


--
-- Name: message_file_created_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_file_created_by_idx ON public.message_files USING btree (created_by);


--
-- Name: message_file_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_file_message_idx ON public.message_files USING btree (message_id);


--
-- Name: message_workflow_run_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_workflow_run_id_idx ON public.messages USING btree (conversation_id, workflow_run_id);


--
-- Name: operation_log_account_action_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operation_log_account_action_idx ON public.operation_logs USING btree (tenant_id, account_id, action);


--
-- Name: pinned_conversation_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pinned_conversation_conversation_idx ON public.pinned_conversations USING btree (app_id, conversation_id, created_by_role, created_by);


--
-- Name: provider_model_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_name_idx ON public.dataset_collection_bindings USING btree (provider_name, model_name);


--
-- Name: provider_model_setting_tenant_provider_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_setting_tenant_provider_model_idx ON public.provider_model_settings USING btree (tenant_id, provider_name, model_type);


--
-- Name: provider_model_tenant_id_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_tenant_id_provider_idx ON public.provider_models USING btree (tenant_id, provider_name);


--
-- Name: provider_order_tenant_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_order_tenant_provider_idx ON public.provider_orders USING btree (tenant_id, provider_name);


--
-- Name: provider_tenant_id_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_tenant_id_provider_idx ON public.providers USING btree (tenant_id, provider_name);


--
-- Name: rate_limit_log_operation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rate_limit_log_operation_idx ON public.rate_limit_logs USING btree (operation);


--
-- Name: rate_limit_log_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rate_limit_log_tenant_idx ON public.rate_limit_logs USING btree (tenant_id);


--
-- Name: recommended_app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recommended_app_app_id_idx ON public.recommended_apps USING btree (app_id);


--
-- Name: recommended_app_is_listed_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recommended_app_is_listed_idx ON public.recommended_apps USING btree (is_listed, language);


--
-- Name: retrieval_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX retrieval_model_idx ON public.datasets USING gin (retrieval_model);


--
-- Name: saved_message_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX saved_message_message_idx ON public.saved_messages USING btree (app_id, message_id, created_by_role, created_by);


--
-- Name: site_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX site_app_id_idx ON public.sites USING btree (app_id);


--
-- Name: site_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX site_code_idx ON public.sites USING btree (code, status);


--
-- Name: source_binding_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX source_binding_tenant_id_idx ON public.data_source_oauth_bindings USING btree (tenant_id);


--
-- Name: source_info_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX source_info_idx ON public.data_source_oauth_bindings USING gin (source_info);


--
-- Name: tag_bind_tag_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_bind_tag_id_idx ON public.tag_bindings USING btree (tag_id);


--
-- Name: tag_bind_target_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_bind_target_id_idx ON public.tag_bindings USING btree (target_id);


--
-- Name: tag_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_name_idx ON public.tags USING btree (name);


--
-- Name: tag_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_type_idx ON public.tags USING btree (type);


--
-- Name: tenant_account_join_account_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_account_join_account_id_idx ON public.tenant_account_joins USING btree (account_id);


--
-- Name: tenant_account_join_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_account_join_tenant_id_idx ON public.tenant_account_joins USING btree (tenant_id);


--
-- Name: tenant_default_model_tenant_id_provider_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_default_model_tenant_id_provider_type_idx ON public.tenant_default_models USING btree (tenant_id, provider_name, model_type);


--
-- Name: tenant_preferred_model_provider_tenant_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_preferred_model_provider_tenant_provider_idx ON public.tenant_preferred_model_providers USING btree (tenant_id, provider_name);


--
-- Name: tidb_auth_bindings_active_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_active_idx ON public.tidb_auth_bindings USING btree (active);


--
-- Name: tidb_auth_bindings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_created_at_idx ON public.tidb_auth_bindings USING btree (created_at);


--
-- Name: tidb_auth_bindings_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_status_idx ON public.tidb_auth_bindings USING btree (status);


--
-- Name: tidb_auth_bindings_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_tenant_idx ON public.tidb_auth_bindings USING btree (tenant_id);


--
-- Name: tool_file_conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tool_file_conversation_id_idx ON public.tool_files USING btree (conversation_id);


--
-- Name: trace_app_config_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trace_app_config_app_id_idx ON public.trace_app_config USING btree (app_id);


--
-- Name: upload_file_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_file_tenant_idx ON public.upload_files USING btree (tenant_id);


--
-- Name: user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_id_idx ON public.tool_conversation_variables USING btree (user_id);


--
-- Name: whitelists_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX whitelists_tenant_idx ON public.whitelists USING btree (tenant_id);


--
-- Name: workflow_app_log_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_app_log_app_idx ON public.workflow_app_logs USING btree (tenant_id, app_id);


--
-- Name: workflow_conversation_variables_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_conversation_variables_app_id_idx ON public.workflow_conversation_variables USING btree (app_id);


--
-- Name: workflow_conversation_variables_conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_conversation_variables_conversation_id_idx ON public.workflow_conversation_variables USING btree (conversation_id);


--
-- Name: workflow_conversation_variables_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_conversation_variables_created_at_idx ON public.workflow_conversation_variables USING btree (created_at);


--
-- Name: workflow_node_execution_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_id_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, node_execution_id);


--
-- Name: workflow_node_execution_node_run_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_node_run_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, node_id);


--
-- Name: workflow_node_execution_workflow_run_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_workflow_run_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, workflow_run_id);


--
-- Name: workflow_node_executions_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_executions_tenant_id_idx ON public.workflow_node_executions USING btree (tenant_id, workflow_id, node_id, created_at DESC);


--
-- Name: workflow_run_triggerd_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_run_triggerd_from_idx ON public.workflow_runs USING btree (tenant_id, app_id, triggered_from);


--
-- Name: workflow_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_version_idx ON public.workflows USING btree (tenant_id, app_id, version);


--
-- Name: tool_published_apps tool_published_apps_app_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT tool_published_apps_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.apps(id);


--
-- PostgreSQL database dump complete
--

\unrestrict GosiRzAaXS6mo8uIEaaM18fxO6S4HRYdo6lLh7ov3JWEUWdJpUkJUBN2zC7UlAZ

