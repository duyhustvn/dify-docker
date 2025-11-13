--
-- PostgreSQL database dump
--

\restrict GgX5GPiWh4jojrbhpp6iPsHpbHYeqXHYaNVuYP1Wc8HmK7AsjisHhgLeBYbu46E

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
-- Name: agent_strategy_installations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agent_strategy_installations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    tenant_id uuid NOT NULL,
    provider character varying(127) NOT NULL,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255)
);


ALTER TABLE public.agent_strategy_installations OWNER TO postgres;

--
-- Name: ai_model_installations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_model_installations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    provider character varying(127) NOT NULL,
    tenant_id uuid NOT NULL,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255)
);


ALTER TABLE public.ai_model_installations OWNER TO postgres;

--
-- Name: datasource_installations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasource_installations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    tenant_id uuid NOT NULL,
    provider character varying(127) NOT NULL,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255)
);


ALTER TABLE public.datasource_installations OWNER TO postgres;

--
-- Name: endpoints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endpoints (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name character varying(127) DEFAULT 'default'::character varying,
    hook_id character varying(127),
    tenant_id character varying(64),
    user_id character varying(64),
    plugin_id character varying(64),
    expired_at timestamp with time zone,
    enabled boolean,
    settings text
);


ALTER TABLE public.endpoints OWNER TO postgres;

--
-- Name: install_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.install_tasks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    status text NOT NULL,
    tenant_id uuid NOT NULL,
    total_plugins bigint NOT NULL,
    completed_plugins bigint NOT NULL,
    plugins text
);


ALTER TABLE public.install_tasks OWNER TO postgres;

--
-- Name: plugin_declarations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plugin_declarations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255),
    declaration text
);


ALTER TABLE public.plugin_declarations OWNER TO postgres;

--
-- Name: plugin_installations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plugin_installations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    tenant_id uuid,
    plugin_id character varying(255),
    plugin_unique_identifier character varying(255),
    runtime_type character varying(127),
    endpoints_setups bigint,
    endpoints_active bigint,
    source character varying(63),
    meta text
);


ALTER TABLE public.plugin_installations OWNER TO postgres;

--
-- Name: plugins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plugins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255),
    refers bigint DEFAULT 0,
    install_type character varying(127),
    manifest_type character varying(127),
    remote_declaration text,
    source character varying(63) DEFAULT ''::character varying
);


ALTER TABLE public.plugins OWNER TO postgres;

--
-- Name: serverless_runtimes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serverless_runtimes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    plugin_unique_identifier character varying(255),
    function_url character varying(255),
    function_name character varying(127),
    type character varying(127),
    checksum character varying(127)
);


ALTER TABLE public.serverless_runtimes OWNER TO postgres;

--
-- Name: tenant_storages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_storages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    tenant_id character varying(255) NOT NULL,
    plugin_id character varying(255) NOT NULL,
    size bigint NOT NULL
);


ALTER TABLE public.tenant_storages OWNER TO postgres;

--
-- Name: tool_installations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_installations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    tenant_id uuid NOT NULL,
    provider character varying(127) NOT NULL,
    plugin_unique_identifier character varying(255),
    plugin_id character varying(255)
);


ALTER TABLE public.tool_installations OWNER TO postgres;

--
-- Data for Name: agent_strategy_installations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agent_strategy_installations (id, created_at, updated_at, tenant_id, provider, plugin_unique_identifier, plugin_id) FROM stdin;
\.


--
-- Data for Name: ai_model_installations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_model_installations (id, created_at, updated_at, provider, tenant_id, plugin_unique_identifier, plugin_id) FROM stdin;
\.


--
-- Data for Name: datasource_installations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasource_installations (id, created_at, updated_at, tenant_id, provider, plugin_unique_identifier, plugin_id) FROM stdin;
\.


--
-- Data for Name: endpoints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endpoints (id, created_at, updated_at, name, hook_id, tenant_id, user_id, plugin_id, expired_at, enabled, settings) FROM stdin;
\.


--
-- Data for Name: install_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.install_tasks (id, created_at, updated_at, status, tenant_id, total_plugins, completed_plugins, plugins) FROM stdin;
\.


--
-- Data for Name: plugin_declarations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plugin_declarations (id, created_at, updated_at, plugin_unique_identifier, plugin_id, declaration) FROM stdin;
\.


--
-- Data for Name: plugin_installations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plugin_installations (id, created_at, updated_at, tenant_id, plugin_id, plugin_unique_identifier, runtime_type, endpoints_setups, endpoints_active, source, meta) FROM stdin;
\.


--
-- Data for Name: plugins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plugins (id, created_at, updated_at, plugin_unique_identifier, plugin_id, refers, install_type, manifest_type, remote_declaration, source) FROM stdin;
\.


--
-- Data for Name: serverless_runtimes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serverless_runtimes (id, created_at, updated_at, plugin_unique_identifier, function_url, function_name, type, checksum) FROM stdin;
\.


--
-- Data for Name: tenant_storages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_storages (id, created_at, updated_at, tenant_id, plugin_id, size) FROM stdin;
\.


--
-- Data for Name: tool_installations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_installations (id, created_at, updated_at, tenant_id, provider, plugin_unique_identifier, plugin_id) FROM stdin;
\.


--
-- Name: agent_strategy_installations agent_strategy_installations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent_strategy_installations
    ADD CONSTRAINT agent_strategy_installations_pkey PRIMARY KEY (id);


--
-- Name: ai_model_installations ai_model_installations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_model_installations
    ADD CONSTRAINT ai_model_installations_pkey PRIMARY KEY (id);


--
-- Name: datasource_installations datasource_installations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasource_installations
    ADD CONSTRAINT datasource_installations_pkey PRIMARY KEY (id);


--
-- Name: endpoints endpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endpoints
    ADD CONSTRAINT endpoints_pkey PRIMARY KEY (id);


--
-- Name: install_tasks install_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.install_tasks
    ADD CONSTRAINT install_tasks_pkey PRIMARY KEY (id);


--
-- Name: plugin_declarations plugin_declarations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugin_declarations
    ADD CONSTRAINT plugin_declarations_pkey PRIMARY KEY (id);


--
-- Name: plugin_installations plugin_installations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugin_installations
    ADD CONSTRAINT plugin_installations_pkey PRIMARY KEY (id);


--
-- Name: plugins plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_pkey PRIMARY KEY (id);


--
-- Name: serverless_runtimes serverless_runtimes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverless_runtimes
    ADD CONSTRAINT serverless_runtimes_pkey PRIMARY KEY (id);


--
-- Name: tenant_storages tenant_storages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_storages
    ADD CONSTRAINT tenant_storages_pkey PRIMARY KEY (id);


--
-- Name: tool_installations tool_installations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_installations
    ADD CONSTRAINT tool_installations_pkey PRIMARY KEY (id);


--
-- Name: endpoints uni_endpoints_hook_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endpoints
    ADD CONSTRAINT uni_endpoints_hook_id UNIQUE (hook_id);


--
-- Name: plugin_declarations uni_plugin_declarations_plugin_unique_identifier; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plugin_declarations
    ADD CONSTRAINT uni_plugin_declarations_plugin_unique_identifier UNIQUE (plugin_unique_identifier);


--
-- Name: serverless_runtimes uni_serverless_runtimes_plugin_unique_identifier; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serverless_runtimes
    ADD CONSTRAINT uni_serverless_runtimes_plugin_unique_identifier UNIQUE (plugin_unique_identifier);


--
-- Name: idx_agent_strategy_installations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agent_strategy_installations_plugin_id ON public.agent_strategy_installations USING btree (plugin_id);


--
-- Name: idx_agent_strategy_installations_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agent_strategy_installations_plugin_unique_identifier ON public.agent_strategy_installations USING btree (plugin_unique_identifier);


--
-- Name: idx_agent_strategy_installations_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agent_strategy_installations_provider ON public.agent_strategy_installations USING btree (provider);


--
-- Name: idx_agent_strategy_installations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agent_strategy_installations_tenant_id ON public.agent_strategy_installations USING btree (tenant_id);


--
-- Name: idx_ai_model_installations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_model_installations_plugin_id ON public.ai_model_installations USING btree (plugin_id);


--
-- Name: idx_ai_model_installations_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_model_installations_plugin_unique_identifier ON public.ai_model_installations USING btree (plugin_unique_identifier);


--
-- Name: idx_ai_model_installations_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_model_installations_provider ON public.ai_model_installations USING btree (provider);


--
-- Name: idx_ai_model_installations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_model_installations_tenant_id ON public.ai_model_installations USING btree (tenant_id);


--
-- Name: idx_datasource_installations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_datasource_installations_plugin_id ON public.datasource_installations USING btree (plugin_id);


--
-- Name: idx_datasource_installations_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_datasource_installations_plugin_unique_identifier ON public.datasource_installations USING btree (plugin_unique_identifier);


--
-- Name: idx_datasource_installations_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_datasource_installations_provider ON public.datasource_installations USING btree (provider);


--
-- Name: idx_datasource_installations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_datasource_installations_tenant_id ON public.datasource_installations USING btree (tenant_id);


--
-- Name: idx_endpoints_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_endpoints_plugin_id ON public.endpoints USING btree (plugin_id);


--
-- Name: idx_endpoints_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_endpoints_tenant_id ON public.endpoints USING btree (tenant_id);


--
-- Name: idx_endpoints_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_endpoints_user_id ON public.endpoints USING btree (user_id);


--
-- Name: idx_plugin_declarations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugin_declarations_plugin_id ON public.plugin_declarations USING btree (plugin_id);


--
-- Name: idx_plugin_installations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugin_installations_plugin_id ON public.plugin_installations USING btree (plugin_id);


--
-- Name: idx_plugin_installations_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugin_installations_plugin_unique_identifier ON public.plugin_installations USING btree (plugin_unique_identifier);


--
-- Name: idx_plugin_installations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugin_installations_tenant_id ON public.plugin_installations USING btree (tenant_id);


--
-- Name: idx_plugins_install_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugins_install_type ON public.plugins USING btree (install_type);


--
-- Name: idx_plugins_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugins_plugin_id ON public.plugins USING btree (plugin_id);


--
-- Name: idx_plugins_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_plugins_plugin_unique_identifier ON public.plugins USING btree (plugin_unique_identifier);


--
-- Name: idx_serverless_runtimes_checksum; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_serverless_runtimes_checksum ON public.serverless_runtimes USING btree (checksum);


--
-- Name: idx_tenant_storages_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tenant_storages_plugin_id ON public.tenant_storages USING btree (plugin_id);


--
-- Name: idx_tenant_storages_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tenant_storages_tenant_id ON public.tenant_storages USING btree (tenant_id);


--
-- Name: idx_tool_installations_plugin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tool_installations_plugin_id ON public.tool_installations USING btree (plugin_id);


--
-- Name: idx_tool_installations_plugin_unique_identifier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tool_installations_plugin_unique_identifier ON public.tool_installations USING btree (plugin_unique_identifier);


--
-- Name: idx_tool_installations_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tool_installations_provider ON public.tool_installations USING btree (provider);


--
-- Name: idx_tool_installations_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tool_installations_tenant_id ON public.tool_installations USING btree (tenant_id);


--
-- PostgreSQL database dump complete
--

\unrestrict GgX5GPiWh4jojrbhpp6iPsHpbHYeqXHYaNVuYP1Wc8HmK7AsjisHhgLeBYbu46E

