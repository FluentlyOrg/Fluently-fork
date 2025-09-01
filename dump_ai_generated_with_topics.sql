--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: chat_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_histories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    messages jsonb NOT NULL,
    created_at timestamp with time zone,
    finished_at timestamp with time zone
);


ALTER TABLE public.chat_histories OWNER TO postgres;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO postgres;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO postgres;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO postgres;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO postgres;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO postgres;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO postgres;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO postgres;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO postgres;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO postgres;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO postgres;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO postgres;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO postgres;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO postgres;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO postgres;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid
);


ALTER TABLE public.directus_settings OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO postgres;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO postgres;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO postgres;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO postgres;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: learned_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learned_words (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    word_id uuid NOT NULL,
    learned_at timestamp with time zone NOT NULL,
    last_reviewed timestamp with time zone,
    count_of_revisions bigint DEFAULT 0,
    confidence_score bigint DEFAULT 0
);


ALTER TABLE public.learned_words OWNER TO postgres;

--
-- Name: link_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.link_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    token text NOT NULL,
    telegram_id bigint NOT NULL,
    used boolean DEFAULT false,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone
);


ALTER TABLE public.link_tokens OWNER TO postgres;

--
-- Name: not_learned_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.not_learned_words (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    word_id uuid NOT NULL
);


ALTER TABLE public.not_learned_words OWNER TO postgres;

--
-- Name: pick_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pick_options (
    id uuid NOT NULL,
    word_id uuid,
    sentence_id uuid,
    option text[]
);


ALTER TABLE public.pick_options OWNER TO postgres;

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    token text NOT NULL,
    revoked boolean DEFAULT false,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- Name: sentences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sentences (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    word_id uuid NOT NULL,
    sentence text NOT NULL,
    translation text,
    audio_url text
);


ALTER TABLE public.sentences OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title character varying(100) NOT NULL,
    parent_id uuid,
    seed_words text
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    cefr_level character varying(2) NOT NULL,
    fact_everyday boolean DEFAULT false,
    notifications boolean DEFAULT false,
    notifications_at timestamp without time zone,
    words_per_day bigint DEFAULT 10,
    goal character varying(255),
    subscribed boolean DEFAULT false,
    avatar_image_url text
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    google_id character varying(100),
    provider character varying(50),
    name character varying(100) NOT NULL,
    role character varying(10) DEFAULT 'user'::character varying,
    email character varying(100),
    password_hash text,
    telegram_id bigint,
    last_login_at timestamp with time zone,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.words (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    word character varying(30) NOT NULL,
    translation character varying(255),
    part_of_speech character varying(30) NOT NULL,
    context character varying(100),
    cefr_level character varying(2),
    audio_url text,
    phonetic character varying(100),
    topic_id uuid
);


ALTER TABLE public.words OWNER TO postgres;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: chat_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_histories (id, user_id, messages, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
5798d850-8e77-4a06-9345-ac6a3f5838e3	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
02ebe8ae-77ba-45b2-9f64-695dd4cf9b44	e56afe07-f731-4852-bf2a-d4aec70d6107	\N	dbd40853-f01f-4f72-8e38-3148a67a9e77	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:08:40.837+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	directus_users	29881841-3f54-4524-b97d-ebd70771f447	http://localhost:8055
2	update	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:08:43.184+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
3	create	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:11:01.02+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	directus_collections	sentences	http://localhost:8055
4	create	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:30:37.815+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	directus_collections	words	http://localhost:8055
5	create	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:30:41.261+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	directus_collections	topics	http://localhost:8055
6	update	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 18:41:57.237+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	words	13805a71-acd7-432a-8937-a7132095e2f5	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
sentences	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
words	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
topics	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-08-05 18:06:42.888981+00
20201029A	Remove System Relations	2025-08-05 18:06:42.896486+00
20201029B	Remove System Collections	2025-08-05 18:06:42.902126+00
20201029C	Remove System Fields	2025-08-05 18:06:42.908906+00
20201105A	Add Cascade System Relations	2025-08-05 18:06:42.963859+00
20201105B	Change Webhook URL Type	2025-08-05 18:06:42.973293+00
20210225A	Add Relations Sort Field	2025-08-05 18:06:42.980172+00
20210304A	Remove Locked Fields	2025-08-05 18:06:42.985048+00
20210312A	Webhooks Collections Text	2025-08-05 18:06:42.993028+00
20210331A	Add Refresh Interval	2025-08-05 18:06:42.997029+00
20210415A	Make Filesize Nullable	2025-08-05 18:06:43.008157+00
20210416A	Add Collections Accountability	2025-08-05 18:06:43.013299+00
20210422A	Remove Files Interface	2025-08-05 18:06:43.024623+00
20210506A	Rename Interfaces	2025-08-05 18:06:43.03686+00
20210510A	Restructure Relations	2025-08-05 18:06:43.055816+00
20210518A	Add Foreign Key Constraints	2025-08-05 18:06:43.061777+00
20210519A	Add System Fk Triggers	2025-08-05 18:06:43.092148+00
20210521A	Add Collections Icon Color	2025-08-05 18:06:43.096688+00
20210525A	Add Insights	2025-08-05 18:06:43.111688+00
20210608A	Add Deep Clone Config	2025-08-05 18:06:43.116474+00
20210626A	Change Filesize Bigint	2025-08-05 18:06:43.128693+00
20210716A	Add Conditions to Fields	2025-08-05 18:06:43.133034+00
20210721A	Add Default Folder	2025-08-05 18:06:43.140015+00
20210802A	Replace Groups	2025-08-05 18:06:43.144206+00
20210803A	Add Required to Fields	2025-08-05 18:06:43.148493+00
20210805A	Update Groups	2025-08-05 18:06:43.152315+00
20210805B	Change Image Metadata Structure	2025-08-05 18:06:43.155935+00
20210811A	Add Geometry Config	2025-08-05 18:06:43.159934+00
20210831A	Remove Limit Column	2025-08-05 18:06:43.163646+00
20210903A	Add Auth Provider	2025-08-05 18:06:43.179491+00
20210907A	Webhooks Collections Not Null	2025-08-05 18:06:43.189126+00
20210910A	Move Module Setup	2025-08-05 18:06:43.195086+00
20210920A	Webhooks URL Not Null	2025-08-05 18:06:43.204578+00
20210924A	Add Collection Organization	2025-08-05 18:06:43.211743+00
20210927A	Replace Fields Group	2025-08-05 18:06:43.221134+00
20210927B	Replace M2M Interface	2025-08-05 18:06:43.224391+00
20210929A	Rename Login Action	2025-08-05 18:06:43.227306+00
20211007A	Update Presets	2025-08-05 18:06:43.234477+00
20211009A	Add Auth Data	2025-08-05 18:06:43.238841+00
20211016A	Add Webhook Headers	2025-08-05 18:06:43.242956+00
20211103A	Set Unique to User Token	2025-08-05 18:06:43.247364+00
20211103B	Update Special Geometry	2025-08-05 18:06:43.250378+00
20211104A	Remove Collections Listing	2025-08-05 18:06:43.254447+00
20211118A	Add Notifications	2025-08-05 18:06:43.266933+00
20211211A	Add Shares	2025-08-05 18:06:43.285738+00
20211230A	Add Project Descriptor	2025-08-05 18:06:43.2903+00
20220303A	Remove Default Project Color	2025-08-05 18:06:43.300076+00
20220308A	Add Bookmark Icon and Color	2025-08-05 18:06:43.304814+00
20220314A	Add Translation Strings	2025-08-05 18:06:43.309015+00
20220322A	Rename Field Typecast Flags	2025-08-05 18:06:43.313007+00
20220323A	Add Field Validation	2025-08-05 18:06:43.317008+00
20220325A	Fix Typecast Flags	2025-08-05 18:06:43.320974+00
20220325B	Add Default Language	2025-08-05 18:06:43.332182+00
20220402A	Remove Default Value Panel Icon	2025-08-05 18:06:43.341608+00
20220429A	Add Flows	2025-08-05 18:06:43.365756+00
20220429B	Add Color to Insights Icon	2025-08-05 18:06:43.369916+00
20220429C	Drop Non Null From IP of Activity	2025-08-05 18:06:43.374068+00
20220429D	Drop Non Null From Sender of Notifications	2025-08-05 18:06:43.377924+00
20220614A	Rename Hook Trigger to Event	2025-08-05 18:06:43.381053+00
20220801A	Update Notifications Timestamp Column	2025-08-05 18:06:43.39055+00
20220802A	Add Custom Aspect Ratios	2025-08-05 18:06:43.394682+00
20220826A	Add Origin to Accountability	2025-08-05 18:06:43.400219+00
20230401A	Update Material Icons	2025-08-05 18:06:43.409976+00
20230525A	Add Preview Settings	2025-08-05 18:06:43.413918+00
20230526A	Migrate Translation Strings	2025-08-05 18:06:43.421573+00
20230721A	Require Shares Fields	2025-08-05 18:06:43.428005+00
20230823A	Add Content Versioning	2025-08-05 18:06:43.4469+00
20230927A	Themes	2025-08-05 18:06:43.467837+00
20231009A	Update CSV Fields to Text	2025-08-05 18:06:43.472462+00
20231009B	Update Panel Options	2025-08-05 18:06:43.475488+00
20231010A	Add Extensions	2025-08-05 18:06:43.480869+00
20231215A	Add Focalpoints	2025-08-05 18:06:43.485856+00
20240122A	Add Report URL Fields	2025-08-05 18:06:43.490575+00
20240204A	Marketplace	2025-08-05 18:06:43.517213+00
20240305A	Change Useragent Type	2025-08-05 18:06:43.529441+00
20240311A	Deprecate Webhooks	2025-08-05 18:06:43.538178+00
20240422A	Public Registration	2025-08-05 18:06:43.544153+00
20240515A	Add Session Window	2025-08-05 18:06:43.548277+00
20240701A	Add Tus Data	2025-08-05 18:06:43.552196+00
20240716A	Update Files Date Fields	2025-08-05 18:06:43.558923+00
20240806A	Permissions Policies	2025-08-05 18:06:43.595943+00
20240817A	Update Icon Fields Length	2025-08-05 18:06:43.636695+00
20240909A	Separate Comments	2025-08-05 18:06:43.648612+00
20240909B	Consolidate Content Versioning	2025-08-05 18:06:43.652409+00
20240924A	Migrate Legacy Comments	2025-08-05 18:06:43.658207+00
20240924B	Populate Versioning Deltas	2025-08-05 18:06:43.662181+00
20250224A	Visual Editor	2025-08-05 18:06:43.666814+00
20250609A	License Banner	2025-08-05 18:06:43.672006+00
20250613A	Add Project ID	2025-08-05 18:06:43.683912+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
dbd40853-f01f-4f72-8e38-3148a67a9e77	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
2	\N	29881841-3f54-4524-b97d-ebd70771f447	\N	sentences	\N	\N	{"tabular":{"fields":["id","sentence","translation","word_id","audio_url"]}}	\N	\N	\N	bookmark	\N
3	\N	29881841-3f54-4524-b97d-ebd70771f447	\N	topics	0b92b4d3-9715-4267-a933-bbdf553b51b8	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
1	\N	29881841-3f54-4524-b97d-ebd70771f447	\N	words	\N	\N	{"tabular":{"fields":["id","part_of_speech","translation","word","context","audio_url","phonetic","cefr_level","topic_id"],"page":1,"sort":["word"]}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"01987b6a-09e1-719b-85fd-23bb60f91afe"}	{"accepted_terms":true}	\N	\N
2	3	directus_collections	sentences	{"collection":"sentences"}	{"collection":"sentences"}	\N	\N
3	4	directus_collections	words	{"collection":"words"}	{"collection":"words"}	\N	\N
4	5	directus_collections	topics	{"collection":"topics"}	{"collection":"topics"}	\N	\N
5	6	words	13805a71-acd7-432a-8937-a7132095e2f5	{"id":"13805a71-acd7-432a-8937-a7132095e2f5","word":"how long?","translation":"сколько времени займёт?","part_of_speech":"phrase","context":"How long will it take to get there?","cefr_level":"A1","audio_url":"audio/word_how_long?_8c97275b.mp3","phonetic":"haʊ lɔŋ?","topic_id":"b84e6ebe-e62e-4173-bb74-75b5285738cd"}	{"translation":"сколько времени займёт?"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
e56afe07-f731-4852-bf2a-d4aec70d6107	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
7EKtzE10po8wEDCej9welrWRidz9N0PEQzgmSW8UgjDrV2LJS7xugi4DFM621dqm	29881841-3f54-4524-b97d-ebd70771f447	2025-08-05 21:53:58.706+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	\N	http://localhost:8055	JY95Vf1u0o5Z3tr-uu_WbZ6Dk6m9_DlhGheffe-fsQjkkVzCpsmiAgDQFtT7oy2F
JY95Vf1u0o5Z3tr-uu_WbZ6Dk6m9_DlhGheffe-fsQjkkVzCpsmiAgDQFtT7oy2F	29881841-3f54-4524-b97d-ebd70771f447	2025-08-06 21:53:48.705+00	172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	01987b6a-09e1-719b-85fd-23bb60f91afe
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
29881841-3f54-4524-b97d-ebd70771f447	Admin	User	mastermigkc@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$C4apb+BzDVoC48hyeb5z7A$CIJjAZgMf6ohSSaIGb985glIl6OWsDo83qVRCYskifg	\N	\N	\N	\N	\N	\N	\N	active	e56afe07-f731-4852-bf2a-d4aec70d6107	\N	2025-08-05 21:53:48.711+00	/content/words	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: learned_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learned_words (id, user_id, word_id, learned_at, last_reviewed, count_of_revisions, confidence_score) FROM stdin;
\.


--
-- Data for Name: link_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.link_tokens (id, token, telegram_id, used, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: not_learned_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.not_learned_words (id, user_id, word_id) FROM stdin;
\.


--
-- Data for Name: pick_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pick_options (id, word_id, sentence_id, option) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token, revoked, expires_at, created_at, updated_at) FROM stdin;
fcaab054-9f78-4ef4-b861-92cf877a9fc7	154c7fe4-8368-440b-84fa-d90ab8c3a772	UEOFbXsrQbLtVC_qzylXmcCr_NuvLiUyloXdpuW7lQw=	f	2025-09-04 18:07:20.367604+00	2025-08-05 18:07:20.367694+00	2025-08-05 18:07:20.367694+00
4dae9ea5-fc80-4dfb-89d8-a368be7352a7	154c7fe4-8368-440b-84fa-d90ab8c3a772	_2YaP5X9gvMLYzQCmnomg0aAKMrg8qipQSdZMjcv46w=	f	2025-09-04 18:23:02.112626+00	2025-08-05 18:23:02.112797+00	2025-08-05 18:23:02.112797+00
921cece5-3d08-4a7e-93d6-bd5610049b0c	154c7fe4-8368-440b-84fa-d90ab8c3a772	4UQE9VLjreJRq9fO6pSrrdZbYu9sfucpgEyFog2RRWg=	f	2025-09-04 18:30:02.39431+00	2025-08-05 18:30:02.394636+00	2025-08-05 18:30:02.394636+00
460591a6-af54-417a-bd22-3b251f2d37f9	154c7fe4-8368-440b-84fa-d90ab8c3a772	Ryw6iyMocpv2RZoqdw976_akQs-nasEXXWmOuER3Hzc=	f	2025-09-04 20:16:05.407884+00	2025-08-05 20:16:05.40812+00	2025-08-05 20:16:05.40812+00
412028e9-cc8b-47cd-9a95-3b9f606000a7	154c7fe4-8368-440b-84fa-d90ab8c3a772	mWakIGsiYYmw1M22RD6PwXjErp783aEJmrcUZksdbDA=	f	2025-09-04 20:16:46.742593+00	2025-08-05 20:16:46.742929+00	2025-08-05 20:16:46.742929+00
\.


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sentences (id, word_id, sentence, translation, audio_url) FROM stdin;
9380ee88-554d-4a85-b124-275a867c4558	b80f08a3-9af3-454b-8d94-01307c160420	Please check in at the counter	Пожалуйста, зарегистрируйтесь на стойке регистрации	audio/sentence_please_check_cdaceb6e.mp3
cac7ca86-41fd-4b35-81c9-73c607596cd1	f33ed5ad-3fc6-4d60-97ea-9e9a5b06f290	Show me your boarding pass	Покажите ваш посадочный талон	audio/sentence_show_me_0044eb0f.mp3
925a7467-23a8-4670-9a13-fb3dcb51f029	e48b84b2-1454-4701-b95f-cb99a62d12ef	We have to go through passport control	Нам нужно пройти проверку паспортов	audio/sentence_we_have_282d23d2.mp3
c13ed603-560b-4550-937c-41ec554b58d0	152a3230-2236-43c3-8194-d7ca4be33ed2	There is a security check ahead	Впереди контроль безопасности	audio/sentence_there_is_846a518c.mp3
1df5acc5-70f7-4984-8b24-d9bdb5199b69	ce92caf8-2e26-4e99-814c-f2a3a912953a	Where is the luggage drop-off point?	Где пункт сдачи багажа?	audio/sentence_where_is_828bc7c2.mp3
3f7b39b7-692d-4150-8d96-025e58293075	62866357-aa05-4408-9b68-f0f71792e58d	Keep your carry-on with you	Держите свою ручную кладь при себе	audio/sentence_keep_your_8281986b.mp3
950fb108-7a35-447c-90e0-d23fe1cdb2be	63352a22-f975-4de8-a16b-6a8287f4e595	Walk through the metal detector	Пройдите через металлоискатель	audio/sentence_walk_through_dbb02263.mp3
a4fd6cac-ba01-474b-94e3-a956a67ed60c	d4dc7b2d-333b-48e7-958a-1dad7c7b899e	Please remove your shoes	Пожалуйста, снимите обувь	audio/sentence_please_remove_88a84c3e.mp3
6bf6d4e9-52ad-4414-948f-5d58a8c51c76	b240b5e4-57ce-4271-b324-5041701b134c	Place your laptop in the tray	Положите ваш ноутбук в лоток	audio/sentence_place_your_c6dc7248.mp3
a01ec89a-3558-4dcd-9bc3-e896ade01cf6	58b698bd-3c94-4801-81d3-337bfdbd6eda	Remember the liquids rule	Помните правило по жидкостям	audio/sentence_remember_the_399a50e9.mp3
8c42e8af-1055-46e9-9ac1-cf163fc8acb3	9988fb9b-3ec7-41cd-a279-b2a4ba1bf612	Find your boarding gate	Найдите свой выход на посадку	audio/sentence_find_your_973532f9.mp3
ffeabd37-362a-4136-8841-242705e311a6	0da9f583-06a5-4226-9671-2878e13949e1	Show your ID card	Покажите удостоверение личности	audio/sentence_show_your_01705461.mp3
78b01571-6d84-46cf-9087-5002788dd240	3ccdf515-2819-4108-8d73-1d5d277a5cba	They will check your bag	Они проверят ваш багаж	audio/sentence_they_will_8c513721.mp3
b32ce5b6-528e-421c-8ad1-0a5d84fbd15c	46c18eec-e452-4cef-b9a6-361219753ef4	You may have to pay an overflow charge	Вам, возможно, придется заплатить плату за перевес	audio/sentence_you_may_f15e9765.mp3
9cd32f0a-6194-40b7-a04b-c47c56066c17	5970bde5-1937-4a3e-a8a5-6791d2a03f1e	Place hand luggage under the seat	Положите ручную кладь под сиденье	audio/sentence_place_hand_629bfa63.mp3
f0f4aeb8-3733-4bc8-8f0b-fe11aff31c51	29ab0175-7d6e-4b6b-a099-61ce1fdecba3	Scan your boarding pass	Отсканируйте ваш посадочный талон	audio/sentence_scan_your_095b1216.mp3
c830d763-5242-4f5c-86f3-bb668634f282	2e01113e-0cec-4a85-be20-dc0d7558864e	I need to check in for my flight	Мне нужно зарегистрироваться на свой рейс	audio/sentence_i_need_2e12e49f.mp3
2b8c4158-9559-47b5-b1bd-b0577af922b9	90bb171b-5612-4aca-b613-5f5436ae9ef6	Show me your boarding pass, please	Покажите, пожалуйста, ваш посадочный талон	audio/sentence_show_me_56c120da.mp3
d77b8e8a-d1cf-4750-95a5-7d71b2a28ff5	805633bc-4388-487d-9c6d-27f893d87343	Go through security check	Пройдите контроль безопасности	audio/sentence_go_through_ebca8e73.mp3
f3b3e5db-f33d-471a-8508-c7a1951739c7	cd1b9ac5-0ffc-4cb1-b24f-603fe1944922	Passport control is over there	Паспортный контроль там	audio/sentence_passport_control_e24227ba.mp3
e4ef5f71-e4b0-4da8-8bf1-096abc3f3845	a4e382e7-c622-45f1-97e3-95696e036f9b	Do you have your ID card?	У вас есть удостоверение личности?	audio/sentence_do_you_400928b2.mp3
e04093ab-eb88-4f3b-9b3b-198872324fcd	e5e5131d-0f19-4a1f-ab47-99d49180c3e1	What is my boarding gate?	Какой у меня выход на посадку?	audio/sentence_what_is_64abdd44.mp3
1faea306-4cad-4988-afb8-9d28dd220ecc	b6a90edc-c731-493f-af31-1644ae077dda	What is your flight number?	Какой номер вашего рейса?	audio/sentence_what_is_f2e543d5.mp3
de4f9257-c30f-43d3-bbb3-be5b7cafc997	d07c320f-8765-41c6-81b3-34c1342a7401	This is my hand luggage	Это моя ручная кладь	audio/sentence_this_is_b4097edf.mp3
37277bd3-174b-4dbb-88d7-4071757b8f30	e9f66967-c7af-42c4-899e-d80f6a39d8bb	The check-in counter is over there	Стойка регистрации там	audio/sentence_the_check-in_eac00433.mp3
6ac66473-1856-4270-8cb3-ed410cccad1d	14130d63-d04a-47be-ae1f-52b467c9d93f	What is my baggage allowance?	Какова норма провоза багажа?	audio/sentence_what_is_f4159a38.mp3
7188a1f4-3d61-4039-ae0d-d2bce4538d6b	17e1b5c7-0d7e-45ca-bcda-deadcafd7cc5	I have some excess baggage	У меня есть сверхнормативный багаж	audio/sentence_i_have_4fa92685.mp3
4e5b05f2-49c3-4d5b-89f9-de425fb5f185	aa811dea-a204-4d7d-8fd3-a733a7d2db92	Please fill in this form	Пожалуйста, заполните эту форму	audio/sentence_please_fill_5650d752.mp3
8ca4c3ec-58e7-413b-984b-8003b20a1d12	19199535-55a3-49c1-9e39-6340bb3c2875	You need to go through security	Вам нужно пройти через охрану	audio/sentence_you_need_a6d1bc59.mp3
bfe63d02-0869-4f04-85a3-3387fea6cde6	bc61ecd5-93ef-467f-8f34-dea5c98afe50	When does the plane take off?	Когда самолет взлетает?	audio/sentence_when_does_45e9edd0.mp3
29b6baad-2679-47dd-84df-70ce9ab64895	52a17071-383c-4663-af4e-ca92cc293044	Get on the plane now	Садитесь в самолет сейчас	audio/sentence_get_on_ac74be9e.mp3
94cf0d2d-48a9-4266-8415-1609415edc0e	c2cab820-99d8-481c-a4e0-ec6f00627552	Hold on to your bags	Держитесь за свои сумки	audio/sentence_hold_on_387132c7.mp3
d8c4fcd7-eee9-4f4b-8159-eaecb30e5b62	c8355fdd-0bbb-42c4-a6d4-f7b5d94c33b3	We have to queue up for security	Мы должны встать в очередь на досмотр	audio/sentence_we_have_456fbf59.mp3
a649e903-25e6-4506-9f71-b1b043b6184c	7c3312e2-ac5a-4bb3-80fa-b046b8dca00c	What time is boarding?	Во сколько посадка?	audio/sentence_what_time_1e3b5e9a.mp3
1635afa9-2785-416d-8128-73e9e1dc277d	f1db223f-b5db-438a-9065-a10e4cf19e59	The flight is delayed	Рейс задержан	audio/sentence_the_flight_932274b9.mp3
dea3119b-19ec-49fa-9b4a-99e0d5ae81df	9ea6e329-24c7-49b4-b2d7-de67e5e51070	What is the gate number?	Какой номер выхода?	audio/sentence_what_is_a687f77c.mp3
8e62e307-2ff1-4e95-9d3a-fa320c7c5e2e	b1fe5398-6e47-4eff-b959-f8ccb2d50d39	Ask the security personnel	Спросите у персонала службы безопасности	audio/sentence_ask_the_12c840a2.mp3
478771e8-4dc9-479a-a314-ced30a8600c6	5015ae3f-7cbc-4ccf-a52a-a50ee56df1aa	These are prohibited items	Это запрещенные предметы	audio/sentence_these_are_5193eaa7.mp3
c3d0194a-4a46-45b9-8fcf-707a5bf3d4b2	5a0aabfc-b369-471d-b710-3a18c4050e42	Are there liquid restrictions?	Есть ли ограничения на жидкости?	audio/sentence_are_there_4f2246f8.mp3
00a40a00-ccc5-4f6d-aadc-a0f71f553c0b	670aec19-1e89-42c9-b76f-17c5603af03b	Go through the metal detector	Пройдите через металлодетектор	audio/sentence_go_through_184b05d3.mp3
c81f4274-4c36-4367-9971-5bdd6747cfc5	33a74ac2-5362-430d-b68e-7ba819bcf9ee	Put your bag on the X-ray machine	Положите свою сумку на рентгеновский аппарат	audio/sentence_put_your_ee4ce81b.mp3
5ad5c4b6-7217-48fa-bf9c-05bbad506658	ca105d2e-9c0d-48bf-a095-48bd33e626bf	They will scan your passport	Они просканируют ваш паспорт	audio/sentence_they_will_56c60b33.mp3
4bd3c41b-dca6-4a32-a8b6-551ca04d61c2	f79dbdd8-c605-44a1-ae4e-776b4dfe0999	Remove your shoes and belt	Снимите обувь и ремень	audio/sentence_remove_your_56c448c7.mp3
d981bb1d-4a08-4d1e-9e47-3ff01db24628	b2a62912-e24c-4ffe-9528-101e47d9742d	Do you have anything to declare?	У вас есть что-то для декларации?	audio/sentence_do_you_09386c27.mp3
c6df7a69-dff7-4b67-9786-f2fcfb987c45	5c55751e-4fa5-4578-bc5f-c077a2d3fa01	What time is my flight?	Во сколько мой рейс?	audio/sentence_what_time_e8623d13.mp3
7b769719-ab7a-4d26-9792-efc8ad15fb9f	7597e13c-8f5c-4b2e-8c10-dc3671e98a77	My flight is delayed	Мой рейс задержан	audio/sentence_my_flight_72532d24.mp3
2bc78d1e-8347-4944-bace-a8a0eadc8981	f47f4c8b-5460-40d6-9f06-c62193b556e2	Where is my boarding gate?	Где мой выход на посадку?	audio/sentence_where_is_8ab21afd.mp3
5b72871a-e616-4542-a206-097616361216	8b5726f2-f0db-4cbd-b898-8fbc6f3604e0	Which terminal is my flight from?	Из какого терминала мой рейс?	audio/sentence_which_terminal_7086e825.mp3
5c09650d-1d9d-4999-8c64-b098de66af6b	283e8217-b053-4f12-ad25-54ca9a69a2f8	Where is baggage claim?	Где выдача багажа?	audio/sentence_where_is_7ff1b4f4.mp3
35703e12-7b2a-4376-a612-bfc9ab0d7756	c28209d9-2f8d-4ec4-ad52-bb8ac81a38b3	Go to the check-in desk	Идите к стойке регистрации	audio/sentence_go_to_62b93eb2.mp3
979e890c-4df4-4ff9-9c4b-e0825551ff61	648eb7dd-72ee-4d57-8418-0e2c5edc4a6e	This is my hand luggage	Это моя ручная кладь	audio/sentence_this_is_9d34fe07.mp3
85a5c220-e0db-4176-83a5-4ddb4b409f88	a052f528-c2b5-48dc-b5b3-dad9fb703969	I have lost luggage	У меня утерянный багаж	audio/sentence_i_have_afc39317.mp3
e8981410-d9dc-4aa6-bd7a-890651ea440d	9145cc40-1271-44bd-8a91-c1c2f6e93930	I have a connecting flight	У меня стыковочный рейс	audio/sentence_i_have_39cb7bef.mp3
1275c447-d7a3-439e-998e-245b2b90450c	1d27f874-1a7e-46f2-914e-4e17684e2076	Can I change my flight?	Могу ли я изменить свой рейс?	audio/sentence_can_i_4001a1d2.mp3
9e8d8dba-0e26-45e6-b301-6ae25107a018	baa650e3-75e8-4b9d-8131-b50074a181e7	I don't want to miss my flight	Я не хочу пропустить свой рейс?	audio/sentence_i_don't_9845070c.mp3
c17f3bd6-596b-4282-969d-1e5e4c2be4e8	70f88a05-a658-4877-9d0b-c4261fe669d7	Boarding is now beginning	Посадка начинается	audio/sentence_boarding_is_7c939bce.mp3
36e07ef8-c061-4453-a24b-e53ebe334d52	c46249b2-9e49-484c-a0ba-3cb8e69623d3	Please confirm my flight	Пожалуйста, подтвердите мой рейс?	audio/sentence_please_confirm_edb2e259.mp3
21af7fec-60ab-4e6d-b3a6-2d05d8dacb1a	6999122f-e9cd-4d99-9276-7aa4069f7780	Is it possible to get an upgrade?	Возможно ли получить апгрейд?	audio/sentence_is_it_e1e26835.mp3
cfa2972a-0af0-432e-93f8-e5aedb76ad28	d20717fb-d023-4861-b2bd-992ef3bc4598	I need some assistance	Мне нужна помощь	audio/sentence_i_need_7c494ba5.mp3
d2478569-0599-4307-a936-98ac462979d1	63d9c324-7b64-458b-8ab4-2cc3f48b24e9	I need to rebook my flight	Мне нужно перебронировать свой рейс	audio/sentence_i_need_68b6849d.mp3
2e4a3701-de05-4711-a2dc-d6faa9cfd9de	709a44b5-9d03-44ca-b6a9-8171eb738544	Can you re-route me?	Можете ли вы меня перенаправить?	audio/sentence_can_you_7450e943.mp3
fa3313ca-8d42-4c75-878a-73bffd12cfdf	6f6968b4-a579-439c-84c7-a894dc6d9f15	I want to complain about my baggage	Я хочу пожаловаться на свой багаж	audio/sentence_i_want_bec0a9e1.mp3
89e7c9c6-7fe1-4dff-98bc-7f629e8d46b8	e018c7f3-9cee-4c44-a2c3-b4c72fe4d364	I have an inquiry	У меня есть запрос	audio/sentence_i_have_60ae5ca0.mp3
1ad9df31-3b96-4910-a173-a985de14e0c7	1aac3a60-e116-4788-84aa-33f17deb4a6e	Go through passport control	Пройдите паспортный контроль	audio/sentence_go_through_494604cb.mp3
df1f9074-c8cd-457c-91d5-96bb3f77f0f4	ab6470a7-52c4-4f65-befa-cfc777368f84	Go through customs	Пройдите таможню	audio/sentence_go_through_728cc839.mp3
af46d51c-76de-4843-88a6-bc125a4a5b5f	6c5d498c-297c-4a44-a419-65c1939b25c9	Go through the security check	Пройдите контроль безопасности	audio/sentence_go_through_7fc15203.mp3
1eb71feb-378a-4d6d-bba8-080fd06e9889	f88e6186-1f60-4596-8b0e-1ae82ff57b88	I have excess baggage	У меня сверхнормативный багаж	audio/sentence_i_have_8d2ad2aa.mp3
3e0ab229-a3ca-4784-8756-62384ecffd71	c3489adf-bc6f-4bb3-847c-af9c949f827d	What is your flight number?	Какой номер вашего рейса?	audio/sentence_what_is_b20b4c61.mp3
720ac904-9d12-4de7-ae44-01a249c07242	8aa1ff16-29aa-4aa3-99ac-2176cf39775b	I need to get through security	Мне нужно пройти через службу безопасности	audio/sentence_i_need_f806768a.mp3
70304899-b4db-47f1-abf7-3b63113a7153	30fc0bef-0621-40f1-ac8b-ddece6cd3fa2	Can you help me sort this out?	Можете ли вы мне помочь это решить?	audio/sentence_can_you_73965e84.mp3
9418af5f-85b3-4e32-8711-826beadfbda2	f128bda2-3d69-4fee-aa8f-e91236ec8342	Please hold on a moment	Пожалуйста, подождите минутку	audio/sentence_please_hold_cb8a1f9c.mp3
84ae4680-ee82-4381-841d-10a516195d10	338f320a-fe8f-4868-b83c-f0a05e8c9e40	I hope you can take care of it	Надеюсь, вы сможете этим заняться	audio/sentence_i_hope_c3f162b7.mp3
9c037c00-ca63-4d6e-8d2b-ba73d50377b8	ef88ff2b-55d6-4aa3-83c1-63fde389647b	Excuse me, I need help	Извините, мне нужна помощь	audio/sentence_excuse_me,_fe4d0d5f.mp3
6bc7dcf6-9027-46f9-a715-710a7949620d	6e0720e5-f44d-4929-83ae-19b2eaeb16ac	Thank you very much	Большое спасибо	audio/sentence_thank_you_12c53917.mp3
86f08502-d79a-4ea4-8adb-3e4939ca6a61	b33f5927-e95e-44e4-b957-908d593eae47	Please help me	Пожалуйста, помогите мне	audio/sentence_please_help_7da43b52.mp3
1a198d22-ff09-4ae0-ad7a-2ee0104b3a40	89015a68-6f2a-42d7-af30-66826f0a9122	Sorry, I didn't understand	Извините, я не понял	audio/sentence_sorry,_i_46798137.mp3
61749a99-7058-4f59-98da-9409dccd6ef6	a1afb737-3596-4ea5-8a3a-3d30fad9517b	Excuse me, could you help me?	Извините, вы могли бы мне помочь?	audio/sentence_excuse_me,_db170216.mp3
d3076697-02e8-4b27-b12d-33bd48723cd5	f178feca-e991-4ffa-88f9-77c35bf84a17	Where is gate 23?	Где находится выход № 23?	audio/sentence_where_is_f63a4548.mp3
7e53794a-f052-4e4c-a7cd-5cc15c9ba6c3	c57a44f3-df42-4ca3-a58a-67b57a9de6d2	Which terminal is my flight from?	Из какого терминала вылетает мой рейс?	audio/sentence_which_terminal_bdbc611b.mp3
974fd50f-6148-4239-8558-683e67710cca	6853e981-1dd3-49b0-a040-600c389a45f6	What gate is my flight?	Из какого выхода мой рейс?	audio/sentence_what_gate_361f4f86.mp3
f06b0781-3447-4d5c-b4fc-da181927ec6b	15655eb8-7808-419a-b6d4-2aa2a8b87576	What is your flight number?	Какой номер вашего рейса?	audio/sentence_what_is_4b0cf4af.mp3
07ad1848-1fa2-42f0-844f-500ebb3ac92d	02fe5743-3705-406a-85e7-5840cca56375	Can you give me directions?	Вы можете дать мне указания?	audio/sentence_can_you_f51858c7.mp3
bbd69a6f-cba4-4380-9cbc-b565285e0b6f	42535431-5ffe-4f0a-b7b9-b814c9dfc8fc	Go straight ahead and then turn left	Идите прямо, а затем поверните налево?	audio/sentence_go_straight_e6d1bb52.mp3
2443f9b6-a57e-45b9-8ecb-9041fb5d0c9c	d5e1b926-39af-47f7-b84f-9d174495e874	Turn left at the end of the corridor	Поверните налево в конце коридора	audio/sentence_turn_left_24281c4c.mp3
75f1ab8b-fd87-44a0-bb66-3ea2cf7f2f3e	c19aac4f-7bbd-4e54-83e5-c1d0800c418c	Turn right at the information desk	Поверните направо у информационной стойки	audio/sentence_turn_right_57e11852.mp3
3946609f-3ac2-4f03-9dc4-7f73069f70e6	4736b23d-9c63-4b6e-a25b-d6f26ad994f7	Follow the signs to gate 45	Следуйте указателям к выходу 45	audio/sentence_follow_the_31e2edfb.mp3
d0b7a728-f3da-43e8-8c09-876612772ca0	4ebd1e61-905e-4f2d-9cef-b75717d3efa3	The restrooms are over there	Туалеты там	audio/sentence_the_restrooms_e7b56a80.mp3
4245e2f8-1fe5-47c7-a33d-e159f424d871	d8266c9e-cd1a-4663-9f30-ebabf0f27f71	The cafe is near the gate	Кафе находится рядом с выходом	audio/sentence_the_cafe_ba025dbb.mp3
e2430fc3-e6ce-4701-a7d4-a9c250177291	c84659df-e35d-4308-94dc-710fd978a743	Is the gate far?	Выход далеко?	audio/sentence_is_the_47fc1451.mp3
1903c8ba-ba9c-4696-919c-cfdf1ac0c623	13ea4545-1dc1-4dae-a4b4-a4d950f7b3b0	How far is the gate?	Как далеко находится выход?	audio/sentence_how_far_a43487c5.mp3
2a24b1d7-dd3f-48a7-af00-c0bfdd4a05cb	13805a71-acd7-432a-8937-a7132095e2f5	How long will it take to get there?	Сколько времени займет дорога туда?	audio/sentence_how_long_71b7bddb.mp3
11a133af-c15e-471b-88fd-6934f741a320	7eee35d5-7599-46c2-80b4-182d98e23295	Take the elevator to the second floor	Возьмите лифт на второй этаж	audio/sentence_take_the_91ae732a.mp3
209a6c56-7eef-42e0-85b4-dfa699dcb51d	0d786e9d-f2be-408d-a141-aab276340ba0	Take the escalator up	Поднимитесь по эскалатору	audio/sentence_take_the_f997d99a.mp3
25146f0e-280f-4ac5-806b-e735499fd7c1	d7d95619-e506-40f6-ab0d-58aeb53cf825	Where is baggage claim?	Где находится выдача багажа?	audio/sentence_where_is_e4c40eb8.mp3
6cae9a5b-5434-4162-b59f-ad648eb26c46	5a17370c-b58a-415f-91db-18c9e05935fe	Go to customs	Идите на таможню	audio/sentence_go_to_d96e3cec.mp3
411fb089-bea3-4a63-94ee-2b9109d58a8b	f0a2e9cf-29d3-429d-b1d7-7e347e8081ef	Passport control is over there	Паспортный контроль там	audio/sentence_passport_control_7c12ae3e.mp3
02db5db7-9b6e-4c05-8680-4e6c27cc284a	4e979256-e6ab-4401-8680-d39f8c49ed39	Help me find my gate	Помогите мне найти мой выход	audio/sentence_help_me_080a2682.mp3
bf54448f-39ba-46a7-a1a5-0425b1dd7a54	ec2f127f-7eae-4e80-8ddc-f88229d28d79	Where is lost and found?	Где находится бюро находок?	audio/sentence_where_is_e7ecf954.mp3
3f80613d-0544-4365-ab3f-a7e36ec5f9e1	f0752755-fd17-48fd-9e58-f510d65fd64f	Could you please point me in the right direction?	Не могли бы вы указать мне правильное направление?	audio/sentence_could_you_c92f5fa8.mp3
5c16a39c-19fc-476e-842e-94ba2fef10ac	f631f60e-d1fb-4281-b80e-b5081f8188f9	I'm lost, can you help me?	Я заблудился, вы можете мне помочь?	audio/sentence_i'm_lost,_726d0329.mp3
128d2dad-e14f-45e8-894b-4c801a4225ee	a05be6be-a61b-42e2-8eeb-13d389d34705	It's approximately 10 minutes walk	Это примерно 10 минут ходьбы	audio/sentence_it's_approximately_da6f2de3.mp3
c06cea9d-a8ae-40a5-a2c1-4850e91cab4b	3c37b576-dfa0-4d6a-8d55-52c95b224001	The gate is a bit far, let me help you	Выход немного далеко, позвольте мне помочь вам	audio/sentence_the_gate_749f0d50.mp3
0954ca80-dc6d-45c3-8751-a98a38b68e5c	35d7a8cb-39a6-4e44-a49c-af1afe1dd996	I have lost luggage	У меня утерян багаж	audio/sentence_i_have_06e1242d.mp3
d5b3a205-ec14-42cf-afd8-6c029a3a7193	df6e0f0d-bd1c-4f7b-98d3-833e57b6b75e	My missing baggage is a suitcase	Мой пропавший багаж - это чемодан	audio/sentence_my_missing_2c3741e0.mp3
b38ca7b0-99ea-4ca9-9def-cdb485a75834	2ba18c77-d904-49ab-8c97-0f5fc8ec31dd	My baggage is delayed	Мой багаж задержан	audio/sentence_my_baggage_f59dbb33.mp3
00059eb2-8900-4363-a25d-c9f6bdc15541	2bca3b3e-6baa-45b9-802f-2eb00807d62e	You need to report lost luggage to the airline	Вам нужно сообщить об утерянном багаже авиакомпании	audio/sentence_you_need_453b9fc9.mp3
ce30fe36-13bd-4022-beb8-22fbc4a39024	ca15f219-c701-4680-adfc-87535db0dbac	Please fill out a form to report your lost luggage	Пожалуйста, заполните форму для сообщения об утерянном багаже	audio/sentence_please_fill_5ee022f7.mp3
b6a80e99-c5d9-437a-bf1a-ac22a40211a5	f1ad5ea1-3053-407c-8ce9-d8d71e5a2bc7	Where is the baggage claim?	Где выдача багажа?	audio/sentence_where_is_1c133a16.mp3
07e358b4-b106-4954-8c99-d94c4cc6885b	d8e43c5b-7d9e-4b50-a03d-7fd0801f414a	Keep your claim tag	Храните бирку на багаж	audio/sentence_keep_your_a0230a6f.mp3
9ceb6a07-9ed5-485b-9a7b-3af9cd997e76	69e58524-6b80-4731-aaa7-2f5b645e74df	I need my reference number	Мне нужен номер моей заявки	audio/sentence_i_need_52c4e4b2.mp3
220e0860-d98c-488f-915a-7216e4cf35a4	c6a06a8c-7a10-4ee4-8860-bc39830858dd	Go to the airline counter	Идите на стойку авиакомпании	audio/sentence_go_to_423f9506.mp3
d7e3fb04-f10f-48ac-ae63-39e10025ba4f	2fd51c1b-5a5a-4941-b71b-dbac036b7bc6	I need to file a claim for my lost luggage	Мне нужно подать заявление о пропавшем багаже	audio/sentence_i_need_0ea94a76.mp3
682a3ffb-8d69-4b8b-8378-2c4040f39e83	046c7b0b-5646-4ecd-81ea-250c4de30279	Get in touch with the airline	Свяжитесь с авиакомпанией	audio/sentence_get_in_aa776484.mp3
932b7a1d-ebd0-4a26-8fd1-cd4dffee38ce	ae1dbee6-4d9f-4cdb-855c-4ee29e67e5c2	I am looking for my suitcase	Я ищу свой чемодан	audio/sentence_i_am_fd9f633c.mp3
a6a99580-b69b-456e-a4d0-ed71b3dc2f4d	ca3e7b12-2bf3-4f4c-91c6-55fc12471d92	Let’s check the carousel	Давайте проверим ленту багажа	audio/sentence_let’s_check_5ac4ebe6.mp3
381fab79-86f0-48ef-8c38-7d278ddb8715	45ec31ba-fb06-4133-9c8e-116dfb2f76e9	Give a description of the bag	Дайте описание сумки	audio/sentence_give_a_d2f9bf99.mp3
78caac4f-d7d7-499b-b492-4fc5c420f9d1	27b2b16e-d8bf-4649-aeb2-c97a0ac7e080	Describe the contents of the bag	Опишите содержимое сумки	audio/sentence_describe_the_65e42333.mp3
44abd4f4-d337-4c2c-9cd3-db8ec20ab0d0	b63f038e-7aa1-4b5c-9392-b66b682312ee	My baggage is damaged	Мой багаж поврежден	audio/sentence_my_baggage_2b15ccc1.mp3
05d71697-212d-4eb8-bb8d-0b664b0dfd38	17895b1e-2baa-4651-aa5d-71e203f0dc55	I want compensation for my lost luggage	Я хочу компенсацию за свой утерянный багаж	audio/sentence_i_want_fec207d0.mp3
bc26f075-ce5b-46a0-9b97-3a2fb61f645d	426fef67-119e-487e-8990-7109f30a4df4	They will trace the baggage	Они будут отслеживать багаж	audio/sentence_they_will_820352eb.mp3
0d2e05b5-ade7-4dd3-a7c3-f298e5a22529	4d091b2d-b052-4143-8013-9e2ac2bf4f21	My bag, it's gone missing	Моя сумка, она пропала	audio/sentence_my_bag,_2dcc77dc.mp3
8722aae7-86a9-441b-bde6-d43256a7eaaa	74860cc2-4cc0-408a-932a-97d85fb0310b	I'm so frustrated, my bag is lost	Я так расстроен, мой чемодан потерялся	audio/sentence_i'm_so_ecc85906.mp3
2dba085b-7935-49e4-96be-b52661794a89	763e761b-fc7a-4576-b1ba-5bbefaf7a088	What a nightmare! My luggage is lost!	Какой кошмар! Мой багаж потерялся	audio/sentence_what_a_fa623320.mp3
7b216091-8906-46c0-9ae7-4d6bab77da18	7a48765b-cc0b-45ed-852b-2ec0b3bf69b7	Oh no! My bag is gone!	О нет! Моя сумка пропала	audio/sentence_oh_no!_56402fb7.mp3
496d17b2-4314-433e-bd99-b124a6f6bf5a	66dee369-4920-4f71-87d9-11a18b603660	That's terrible. Your bag is lost	Это ужасно. Ваш чемодан потерян	audio/sentence_that's_terrible._8ebcb73b.mp3
e8f73664-0e17-4a1d-9dd8-c37e92bb99f5	e2cdcd38-662f-4ef8-8ff0-edade5edf00c	Show me your passport, please.	Покажите ваш паспорт, пожалуйста	audio/sentence_show_me_48ed0610.mp3
9d52bd78-d448-4980-8e13-ec66e30005b5	c1a9249e-cd98-4c18-ae16-b4f31763518a	Do you have a visa?	У вас есть виза?	audio/sentence_do_you_42df9d9c.mp3
bd0c32c6-8575-4c99-9ad7-b3a993c53e1d	441b1b6b-7a1a-48cf-87a5-259b1dfd31a7	Show me your boarding pass.	Покажите ваш посадочный талон	audio/sentence_show_me_2acbaf91.mp3
44772cae-342a-43d2-a7ca-94d14d50eead	2b8a4669-e1ae-4be1-b654-436f144a9897	Where is your baggage?	Где ваш багаж?	audio/sentence_where_is_cc9d3ef8.mp3
9481d33d-243b-4761-9aba-af5246b94ad9	3024fbe0-c32d-42d9-a182-147883a2094f	You can take this as hand luggage.	Вы можете взять это как ручную кладь	audio/sentence_you_can_b812c8d3.mp3
7383ba94-575a-4181-af62-dcdd2ee6db95	4c4fce09-46d9-4f8e-947a-07ad84207f03	Fill out this customs declaration form.	Заполните эту таможенную декларацию	audio/sentence_fill_out_94ae2d38.mp3
7f0ca9d3-c7c2-4fb8-bb49-ce71ce6d15bd	502591fa-86ff-45e6-8dd9-6d1ac0a1d6af	The flight is delayed	Рейс задержан	audio/sentence_the_flight_8ec4fe31.mp3
428f4400-eaba-4a8b-ade7-a1a1db5e4456	1cad7238-3f61-4533-96d9-e8de3fc49737	I'd like to buy something duty-free.	Я хотел бы купить что-нибудь в дьюти-фри	audio/sentence_i'd_like_0a7eb107.mp3
02f7ebe7-2ea7-4c51-b6e9-63f492f7f84a	2d796b32-91ee-4124-8f33-9eb8ffa896ff	The immigration officer asked me some questions.	Пограничник задал мне несколько вопросов	audio/sentence_the_immigration_6011750b.mp3
674d2107-0316-45f8-acc4-89d5afde865b	ff40c9b2-d9b2-45be-b920-cf61c9816d76	Please fill out this form.	Пожалуйста, заполните эту форму	audio/sentence_please_fill_8d5245f9.mp3
b9908f05-9873-48bb-a6de-34b6c9673680	2c4d89b5-ae57-4687-bd7e-27e7b32c6a5c	Go through customs.	Пройдите таможенный контроль	audio/sentence_go_through_b6c110fe.mp3
449e89dd-cfee-456a-a18a-7d19d817066f	b5bd7364-afae-4e93-a12d-958e626aa0d1	Do you have anything to declare?	Вам что-нибудь нужно декларировать?	audio/sentence_do_you_c8b71592.mp3
35248c0b-ced4-4394-8317-540a40d86179	7784373e-33d2-468e-a757-8f226905abc3	They inspected my luggage.	Они проверили мой багаж	audio/sentence_they_inspected_18daf205.mp3
2f357ddb-b5be-49ac-85fa-349a15eab9d2	4cc37f79-c21c-462a-8536-10911672463b	They checked my passport.	Они проверили мой паспорт	audio/sentence_they_checked_df2756bf.mp3
29ca97a8-8e9f-4790-917c-5825485e046d	6282cd63-bd22-4ca4-a689-daca850e4604	There's a long queue at customs.	Длинная очередь на таможне	audio/sentence_there's_a_10f50424.mp3
0493684e-973d-41b1-9aef-e0b5a1d529c8	b92fef56-8722-4ea7-a6d4-e9ad9a15e479	You need to go through security check.	Вам нужно пройти контроль безопасности	audio/sentence_you_need_45688ab8.mp3
a9f55e81-26bb-46af-8eae-9d0aab522bac	f8ca2ec3-19a9-4bf5-b440-951a113ef481	Did you get through security quickly?	Вы быстро прошли проверку безопасности?	audio/sentence_did_you_8d188ff8.mp3
6c660ed6-b6b5-4e57-a4ab-50f8b2d414d0	c166461f-f6df-4176-8305-add202fc30dc	Check the list of prohibited items.	Проверьте список запрещённых предметов	audio/sentence_check_the_22c31ac5.mp3
1f7298d8-10dc-45e1-866d-f278917cfbad	a66c00cd-4780-410c-bdf5-411d75ce3e09	Be aware of liquid restrictions.	Обратите внимание на ограничения на жидкости	audio/sentence_be_aware_c2f40a3c.mp3
e71d3343-80f7-4a80-8833-928ea989df18	e21a3dc6-bb56-46e9-bdaf-95a36de9825b	You need to turn off your electronic devices.	Вам нужно выключить ваши электронные устройства	audio/sentence_you_need_463eabee.mp3
14e7d035-fa80-46a1-9b5b-32570838a906	77e194df-f928-4951-911b-db18a4eacdee	The customs officer stamped my passport.	Таможенник поставил штамп в мой паспорт	audio/sentence_the_customs_fdf097d8.mp3
f7fdb189-10c1-45d5-ba37-f780ab34d54e	75105b0c-58ab-47c5-bdc6-c355335df2a6	Make sure your luggage has a seal.	Убедитесь, что ваш багаж опломбирован	audio/sentence_make_sure_1645fd2b.mp3
243a991d-06f9-4333-bd8e-202e064497e9	b004f277-0314-4b76-839e-eddadf1b06ba	I need a taxi to the airport	Мне нужно такси в аэропорт	audio/sentence_i_need_67644623.mp3
669d57be-d3f8-454a-8210-d3d6e28274b5	4b5bc061-7f07-47c7-94f7-c5a4b6943b46	I'll use a ride-hailing app	Я воспользуюсь приложением для вызова такси	audio/sentence_i'll_use_71635cf5.mp3
5e36bd12-8521-4a05-8a99-810fad0a4140	4aa8e869-f5c4-4e30-a64d-956984ef5d59	We booked an airport transfer	Мы забронировали трансфер в аэропорт	audio/sentence_we_booked_076fbae8.mp3
b6f4980f-003d-4302-a243-e7690312984d	f1f9d58f-c431-4be3-a3c0-712c04acc9dc	Can you help me get a ride?	Можешь помочь мне поймать машину?	audio/sentence_can_you_a8e1d543.mp3
896cc92c-7dae-4699-8e96-05a9f2d3c33f	c491d4d2-a5d1-4cb6-9bff-6c21ebcc4d37	I hailed a cab outside the terminal	Я поймал такси у терминала	audio/sentence_i_hailed_88487e9b.mp3
3eb4db4e-b221-4999-b901-88c9de511268	79fabbdb-dc8f-4343-9b98-3615af6ce92b	I'll call a taxi	Я вызову такси	audio/sentence_i'll_call_ac963b23.mp3
3608b0c0-e929-49a8-ac71-480d1b4a1b47	c3377a11-da9a-4549-ade4-a48f813aed49	The taxi rank is over there	Стоянка такси там	audio/sentence_the_taxi_a6976490.mp3
ca7308d1-9061-4b03-a78d-41fa7373ad6a	58c726a7-6848-49ae-ac36-8c13015ed44c	A shared ride is cheaper	Общий проезд дешевле	audio/sentence_a_shared_5e151a58.mp3
ddd13543-f17c-4fd3-845d-88b19d5a2f15	5c007a27-eb9e-48de-9ef1-bc00b0aef59b	Can you estimate the fare to the city center?	Можете оценить стоимость проезда до центра города?	audio/sentence_can_you_7a3df05f.mp3
e60beefc-8335-46e3-ba00-45bedafb26e9	95771da5-0f20-4f91-b068-bb3a99be9c72	I tipped the driver generously	Я щедро дал чаевые водителю	audio/sentence_i_tipped_b0531c09.mp3
abc7b5b4-8dee-4b6b-b96b-e8ffbe2d91f8	5655c40d-38df-494a-b509-67fe04f8894e	Is the meter running?	Счетчик включен?	audio/sentence_is_the_e01b9d93.mp3
736b86bc-b078-4d2f-9903-560ed7e9e4bb	a7fa0010-d90c-487f-b2a5-55e9820ea1a4	How much will it cost to get to the hotel?	Сколько это будет стоить, чтобы добраться до отеля?	audio/sentence_how_much_cfb6eea7.mp3
cbe87c29-4cf0-4c98-8090-5d945d22ada8	7188f67d-51b3-4cba-b7ce-8ca08abfd2b1	The fare is too expensive	Тариф слишком дорогой	audio/sentence_the_fare_67bb286a.mp3
c1901fbe-068f-4953-8057-484de4ae1db4	787216c6-0b37-4205-9275-3fdd12c1cddd	That taxi fare is a rip-off!	Этот тариф на такси - грабеж!	audio/sentence_that_taxi_a27ff2c9.mp3
5b6d3e6b-8cc8-41cb-bf67-f57b47d928f5	3ebc9c64-655e-4c33-8c34-ca7ab7959c3d	I tried to bargain the fare down	Я пытался сторговаться о цене	audio/sentence_i_tried_e3cb58e4.mp3
db9d1cc7-91a7-4e2e-a9e6-2f00c749de20	590bcd0c-6f6a-4251-b47f-edef5a2ea99d	Please get in the taxi	Пожалуйста, сядьте в такси	audio/sentence_please_get_882fb9cc.mp3
1f66fc41-7013-4772-a680-90e9db71a656	bdc49bde-a163-47d0-a4f5-f1a8c46e9882	Where to?	Куда?	audio/sentence_where_to?_85e9a402.mp3
ba811bf9-2e76-4fcf-8c96-5ea106de0ebc	f5d7ebe0-8bc3-4270-bb3a-9822028b8f80	What's the airport code?	Какой код аэропорта?	audio/sentence_what's_the_76d02dd7.mp3
51ce1065-6edc-4a26-a9a3-acb53ddbc954	281d9563-394b-4abb-a6be-f62ad5494959	Which terminal are you going to?	В какой терминал вы направляетесь?	audio/sentence_which_terminal_77c3be5c.mp3
2928bc62-4896-4be8-a87f-0cfb9afa0ba3	49c49d9b-8b0f-44ca-9bc0-a7b06263527b	What's your flight number?	Какой номер вашего рейса?	audio/sentence_what's_your_2e9441e3.mp3
589f5848-55be-454c-80c9-de534cf239d5	f05c6648-5044-4640-a6d9-d4cd120cb3c9	Please drop me off here	Пожалуйста, высадите меня здесь	audio/sentence_please_drop_51deeda9.mp3
2cf1a54b-672b-4440-bfc1-27d62ffa3ae1	f5fc8f73-6d2b-4f98-a3cb-acb60ce10f1a	I'm going to the airport	Я еду в аэропорт	audio/sentence_i'm_going_0c64b357.mp3
6e6a4313-a592-4618-b15e-c8a45c7ddc84	afb54cec-bb83-4999-a3ac-e5ad31acad01	What's your flight number?	Какой номер вашего рейса?	audio/sentence_what's_your_558cd412.mp3
0e35f805-c37d-4a44-a76a-4f0662968c8c	2367914b-2011-45d1-a93d-beec50f3f95d	Which terminal is your flight from?	Из какого терминала ваш рейс?	audio/sentence_which_terminal_f7468850.mp3
2f90c678-bbe9-41e9-bb8b-1a28eaedc069	df3648b2-ddd1-48c2-a554-3a6ca49bf7dc	What gate is my flight?	Из каких ворот мой рейс?	audio/sentence_what_gate_95d7bfd1.mp3
c39636c3-9dc6-4d75-8675-93abb35bd484	2cab730f-b890-410b-84d7-6c569041d2fd	Boarding is now commencing	Сейчас начинается посадка	audio/sentence_boarding_is_230ea252.mp3
75cc7371-e9a4-4586-a86e-e829064aedab	1ac136b3-a08e-4574-828c-f23ca8deff59	What time is the departure?	Когда вылет?	audio/sentence_what_time_780b18b2.mp3
a834de5f-242e-4ccf-9e32-ec7225b6c6f8	783f7f25-dee2-4ee6-b00d-fb479f53704b	What time is the arrival?	Когда прибытие?	audio/sentence_what_time_adc0c294.mp3
38b4825a-769e-46ed-bae2-aa797f8df6cf	c5a3e6d0-904a-4b8e-9216-c8e0c22dd5ad	Where do I collect my baggage?	Где я могу забрать свой багаж?	audio/sentence_where_do_1f2c7155.mp3
13d31d0f-0393-4093-92cf-ac11257ed440	179a6193-1dff-443d-ae94-bf91afa367f7	Is this your luggage?	Это ваш багаж?	audio/sentence_is_this_31063eb3.mp3
0acd6a45-cd6e-4016-bd3e-b1f4139cc75f	d2964840-b86f-42de-a1b7-a759426ec9f6	You can take this as hand luggage	Это вы можете взять как ручную кладь	audio/sentence_you_can_2bbdd3da.mp3
420a92c4-6e5e-438c-aeae-e312f3ef25b0	be7f1efb-5839-47ea-add3-5fccab2f7021	Go to the check-in desk	Идите к стойке регистрации	audio/sentence_go_to_cf7d3a36.mp3
a31a05ba-3802-4a09-9338-d51c8ff4a357	c446f5e3-3c7a-40fd-8e8d-483cf9c0b047	We need to go through the security check	Нам нужно пройти контроль безопасности	audio/sentence_we_need_93a5e9c6.mp3
a1dd0d87-c189-482f-af02-d6308a5d8531	4aedc931-3312-4cd9-b9fc-8ce360b556dc	Passport control is over there	Паспортный контроль там	audio/sentence_passport_control_63e5d01e.mp3
c1757d3b-61d8-4fbc-8db5-f28d92d58df8	9b01b186-9cef-4115-a191-099e1952ff85	Go through customs	Пройдите таможню	audio/sentence_go_through_15ec7dc7.mp3
4c0df118-8f40-41d9-ad9a-4d0c40c5115b	8c8ead2d-52a2-4bc7-84d9-d335afc2f4f1	The flight is delayed	Рейс задерживается	audio/sentence_the_flight_145fc5a4.mp3
c30daf14-23d8-4136-bde1-d0fd6759ca7f	dbf22049-e1b7-41e2-9a15-53ee57028e7e	I missed my connecting flight	Я пропустил свой стыковочный рейс	audio/sentence_i_missed_3aab6805.mp3
91ba6c2c-5297-4036-8ddd-2574412a6ed4	88b2dc2a-5278-418a-ac29-096117c3e6e3	Get on the bus	Сядьте на автобус	audio/sentence_get_on_d3d0e153.mp3
5d2bca8b-0f17-46e8-abd0-cea5e986aa5b	01634846-ac28-4893-acc0-f46c425848d8	I need to check in	Мне нужно зарегистрироваться	audio/sentence_i_need_2a3cae4b.mp3
f3b87157-7eef-4943-b88e-6c6afb83b98c	a20c6866-3521-44e7-8103-c7b1d5c80f94	We'll board soon	Скоро будем садиться	audio/sentence_we'll_board_2eba9afa.mp3
6a90fd9e-2a5b-4bc2-a2a0-78c3520bb9f6	f95a51cd-f63e-4f65-af45-ff9204294a6c	The plane will take off soon	Самолет скоро взлетит	audio/sentence_the_plane_f3d33b1c.mp3
9e879807-029f-45db-b3f8-986800f87c78	ab8669ad-fd41-4aef-847e-2886f56cb827	The plane is about to land	Самолет вот-вот приземлится	audio/sentence_the_plane_d30a8914.mp3
2047cfc3-8d16-457b-b976-e9e3926014d9	6c977797-1576-4393-a801-4573f5508e3a	Do I need to transfer?	Мне нужно сделать пересадку?	audio/sentence_do_i_ad4e9cc3.mp3
4616e586-4fe1-4c4f-9419-ab0374a5ca96	73ff3df7-de98-4077-9eb4-c5450be720dd	What's the best public transport?	Какой лучший общественный транспорт?	audio/sentence_what's_the_12f56b7d.mp3
6a89178a-5b18-4ca8-9a7c-97a740b3522d	3155bc43-b665-49a7-9060-0dae1c1269c3	Take the bus to the airport	Возьмите автобус в аэропорт	audio/sentence_take_the_4a90380b.mp3
9509ffb1-fcdd-47c0-9a5a-632dcd99422e	b263576e-08c5-45c1-a02e-592a6d5c0448	Take a taxi	Возьмите такси	audio/sentence_take_a_c8d3e532.mp3
1dd79394-fc9f-4a31-b59f-4a6a559ada9c	60f76fed-7069-4ee8-aad7-91975bb3ac23	Take the train	Возьмите поезд	audio/sentence_take_the_4a0b8949.mp3
3a1e2461-2cac-4b8d-a3b1-b446e640b462	416da139-c74f-4950-afe0-db964bb14bfb	Take the metro	Возьмите метро	audio/sentence_take_the_285e044a.mp3
123062ca-ff90-4208-afb8-55dd91305ea6	708f1c16-9743-4edd-a5cc-e1995e5d73de	Take the tram	Возьмите трамвай	audio/sentence_take_the_110cce85.mp3
d115a060-21fa-4606-acf0-a3269e898155	a3bd7cd4-d706-46cb-bc2b-9796362ab940	Check the timetable	Проверьте расписание	audio/sentence_check_the_3a519c36.mp3
1ec9cafd-3748-4a3f-83b3-8ea77d3de60f	97359cd1-ed27-4ca3-864a-e9440cba1a65	What platform is the train at?	На какой платформе поезд?	audio/sentence_what_platform_3e5898b6.mp3
f00db7e2-d280-4be2-b2db-986d8e79fa1b	22b02094-bdf2-477f-9156-0d445a82080a	I need a ticket	Мне нужен билет	audio/sentence_i_need_7b6833b7.mp3
b5deb2da-3b7b-4a97-b5a9-3720ca735bb6	af339c50-093e-4011-bb30-fc87752a86d3	How much is the fare?	Сколько стоит проезд?	audio/sentence_how_much_4c196c76.mp3
d8db8666-004b-4cf9-b139-9892bb5d79c4	558fe118-a725-4287-ade5-2d9c3efc118a	I need a one-way ticket	Мне нужен билет в один конец	audio/sentence_i_need_69ed5a86.mp3
f080f274-8e72-49a6-96b4-e5e2b234de46	19c19acb-8771-4317-b8a2-a0e9d3fc3c86	I need a return ticket	Мне нужен билет туда и обратно	audio/sentence_i_need_b8e55809.mp3
642f9713-90bc-43ea-8e4d-1a8a982565fc	0cdc2ff1-5fd5-40fc-b550-e823f98acc75	Can I buy a ticket here?	Я могу купить билет здесь?	audio/sentence_can_i_3a5c5bc0.mp3
eb5c464b-4833-40e1-ae60-e20e21dd3bbf	89b38830-3c13-4dd5-bfff-106e53770444	I'm afraid I might get lost	Боюсь, я могу заблудиться	audio/sentence_i'm_afraid_2a6dee36.mp3
4ee17bac-134d-4dd4-8124-0d5d3a04b296	4a408c50-1a73-4192-9639-bc52e644c2d6	Go to lost and found	Идите в бюро находок	audio/sentence_go_to_78cae697.mp3
6e97be42-e3aa-4e3f-8464-33e821661d2b	76866ff4-8af0-4947-9754-a0b07dec2b1d	Don't hesitate to ask for help	Не стесняйтесь просить о помощи	audio/sentence_don't_hesitate_51bcac8e.mp3
399c2f4c-8a16-4cfe-b546-86d69d416df2	fa79894f-2549-4316-aae1-93586fe64545	Sorry, I don't understand	Извините, я не понимаю	audio/sentence_sorry,_i_6c28986e.mp3
116daa33-2d04-4926-9189-4a79eff89810	4d164071-be0d-46a4-8085-e7f876c0feb6	Thank you very much	Большое спасибо	audio/sentence_thank_you_a36268f2.mp3
8dec9304-ca1c-4bb6-a4a0-c3af6f80c9a9	d099e3ae-b46b-4ec9-b7a5-7f4c56c4ba02	Please help me	Пожалуйста, помогите мне	audio/sentence_please_help_188fb75c.mp3
986857cf-ddfd-40e0-bbb0-ba4bf6b9b529	36096dfb-8484-4564-95b0-5ca3189a1b6e	Help me please	Помогите мне, пожалуйста	audio/sentence_help_me_91500220.mp3
3903c6b6-c9d8-4d6b-92bb-524e35a553b5	11d24b9b-8f20-42e8-810b-7eb6573bf9f7	I need to pick up my rental car	Мне нужно забрать мой арендованный автомобиль	audio/sentence_i_need_159aa768.mp3
9b26be4c-a3d0-4cbe-9a81-96ae5da685e4	725fb9f6-6169-483e-b96e-3624c2d54537	I'll pick up the car at the airport	Я заберу машину в аэропорту	audio/sentence_i'll_pick_4c7e0af4.mp3
a37ae68c-9b6b-4fe0-bef6-544ee0e56bb0	d0a8156b-60e4-47c5-96ad-558c36fbb978	Where do I drop off the car?	Где я могу сдать машину?	audio/sentence_where_do_0eb3629d.mp3
62e52612-44d0-46fc-99b5-98bdd5200205	c9fd9563-6f0e-4418-8ead-3555ce69b79d	Car hire is expensive here	Прокат автомобилей здесь дорогой	audio/sentence_car_hire_f84b80e0.mp3
72e04051-ac57-46e3-b349-e1a51b8bb883	96a1be75-6131-41d9-b757-3f37fcd2cf18	Sign the rental agreement carefully	Внимательно подпишите договор аренды	audio/sentence_sign_the_ee32dcae.mp3
8db66ed8-8681-41ec-8a7e-4e2439abd600	69564b07-a89e-4f92-89e2-2adf1107eb52	Do you have full insurance?	У вас есть полная страховка?	audio/sentence_do_you_3bba9570.mp3
70fec4f8-7f2a-47f4-820b-4baf685126eb	77dbfc7c-207b-4150-adac-4a232360485c	Show me your driving licence	Покажите ваши водительские права	audio/sentence_show_me_6a993b40.mp3
3c549c78-48cb-42de-aed9-1bc3284527a3	28bb0128-4c3e-4961-bab7-809a24216c75	I'll pay with my credit card	Я заплачу кредитной картой	audio/sentence_i'll_pay_0a356b07.mp3
120087bb-3c58-4804-8695-b953a47b9d04	a7b6fe22-c967-47aa-82e5-bca218667be9	Can I pay with my debit card?	Могу ли я заплатить дебетовой картой?	audio/sentence_can_i_d5b37a3e.mp3
d6a62304-a728-448b-8048-55af6cb2ec0b	0b253b06-7d12-4f21-ae67-924c9a8c8bbc	I booked a car online	Я забронировал машину онлайн	audio/sentence_i_booked_8713c163.mp3
6c3be0de-55eb-4ec3-a994-431addcbb9e0	550999b1-8ca2-4707-8ee3-3c915acb04ae	Do you have your booking confirmation?	У вас есть подтверждение бронирования?	audio/sentence_do_you_3f8e49a7.mp3
d45e7442-3e42-420e-af4c-0afa645f6d74	3b06aab2-fd8a-4e95-b17a-e44a061d46be	Be aware of extra charges	Остерегайтесь дополнительных сборов	audio/sentence_be_aware_adaf17fd.mp3
5f22e374-48cf-491e-978f-82bb8d6c544d	8e2618c3-a3b9-438f-81d7-8cf6e73e1ad7	Unlimited mileage is included	Безлимитный пробег включен	audio/sentence_unlimited_mileage_7e428513.mp3
d688f649-f565-403b-b5bb-a29c14a48497	39f66452-0549-4790-bdf7-8a3a734cdc21	Does the car have GPS navigation?	В машине есть GPS-навигация?	audio/sentence_does_the_687adc80.mp3
3bc38d83-f277-43d3-a3e3-16e8da83135f	637915f6-18cc-40cd-b084-0297a70a2922	Fill up the car with fuel	Заправьте машину топливом	audio/sentence_fill_up_e90c0005.mp3
bfd0d621-bcfd-476a-bb5c-32331eaf36d2	24ee990a-d231-4dbb-8aaa-040b1b99973c	Return the car full-to-empty	Верните машину с полным баком	audio/sentence_return_the_d5038768.mp3
165fd27f-2e8d-4025-8fa8-7fdb1b8ec59b	fcce6770-e120-4d4f-98ef-73c805ca3ca8	In case of a breakdown, call this number	В случае поломки позвоните по этому номеру	audio/sentence_in_case_2095d23a.mp3
baf1579f-013e-4cb2-9772-1a492b44f83b	849b49e1-3f4a-4630-b5fc-2fd98f4c0437	I need to fill up the tank	Мне нужно заправить бак	audio/sentence_i_need_ca447c06.mp3
eaf6abe8-b415-4500-9d0a-22726e92a457	195139e2-326a-4715-8b0d-a8f3502aad88	Roadside assistance is included	Помощь на дороге включена	audio/sentence_roadside_assistance_b1d1dddb.mp3
dd0ea3f9-c41a-4e26-9d73-31f13dc2fc90	7c5848c6-f6ea-4207-8378-0a35e1a27e9c	I'm afraid I'll get lost	Боюсь, я заблужусь	audio/sentence_i'm_afraid_87d9c77a.mp3
1ba83410-7c9c-45ae-81e6-b8be241e6389	976a1447-ae6a-4486-901b-e783a217166e	Can you tell me the location?	Вы можете сказать мне местоположение?	audio/sentence_can_you_71051b15.mp3
925d2169-9e56-4129-bbe8-c29a46436af5	ce67ba62-c09b-4879-94c4-064220a0e67e	Can you give me directions?	Вы можете дать мне указания?	audio/sentence_can_you_b8277b75.mp3
990a4489-9cf4-435b-a0f7-19820b5c0927	42a7ccca-846b-4fa6-9549-f8f672f7fd0c	Is there a gas station nearby?	Есть ли поблизости заправка?	audio/sentence_is_there_9961b321.mp3
a2d7823f-9dbc-4209-b813-3a9983322e5b	65ff5f7d-827e-4502-b67d-e6096edbcb87	Is there a rental car office around here?	Есть ли поблизости офис по прокату автомобилей?	audio/sentence_is_there_d5cdef2e.mp3
5c698900-54d6-4a72-a33d-f8d33d984526	dfeb4978-d057-4564-9740-daca88db05b1	I need a ticket to London	Мне нужен билет в Лондон	audio/sentence_i_need_7980ead2.mp3
4776a805-ef0f-4379-9f55-9d80bfd581ad	83e7ff36-2edf-4b2f-82a0-a5c4c292665c	Show me your boarding pass	Покажите ваш посадочный талон	audio/sentence_show_me_ce5efd61.mp3
09f1fe8e-23ff-4012-8417-ead55a977e2a	a97d4f35-15f1-48fd-8205-c2daee5eecff	What time is my flight?	Во сколько мой рейс?	audio/sentence_what_time_1a67c703.mp3
99d1fea7-dcfb-46cc-bcd5-0ee465ebacd4	458ac133-7fc9-47ce-bd8e-7bbadfb640d0	What gate is my flight?	Из каких ворот мой рейс?	audio/sentence_what_gate_3795c192.mp3
7572df89-e7c8-4661-a6f8-ad69259aa8f0	618196d4-c5dd-4c88-bd5f-15fd3554fde7	What is the departure time?	Когда время вылета?	audio/sentence_what_is_da818b05.mp3
313a4f27-c3fa-4b5a-bb26-977e9c9b9d74	dfdbf764-93ee-4638-9052-23289ecef997	What time is the arrival?	Когда время прибытия?	audio/sentence_what_time_4b391ee7.mp3
9fbf61f1-95c9-4824-91a8-3a005eabcbb5	a36be055-5335-4291-a63a-d05ce2d1c43d	The flight is delayed	Рейс задерживается	audio/sentence_the_flight_ffe0579e.mp3
f4a9eb01-f4d3-4420-a9c2-c36bb9601f94	8333ba67-c2b4-4a36-a1bc-61fb94353af3	They cancelled my flight	Они отменили мой рейс	audio/sentence_they_cancelled_006fc827.mp3
6211220b-c458-4dfb-b9b3-e9f73b1e330b	4e7df774-2e43-4bfc-9c63-98d7d3391d1a	I booked my ticket online	Я забронировал свой билет онлайн	audio/sentence_i_booked_d3209aa2.mp3
593e3521-e163-4732-b6cb-a718c4accba8	17fdbb12-0600-4e37-bfb5-344cb3805a8f	I need to check in	Мне нужно зарегистрироваться	audio/sentence_i_need_3255e4e8.mp3
e05a2019-f4c5-4ad1-8df6-05f6554ccf1f	8ce025d0-c657-4ccf-ac1a-b5c86ddfffba	Where do I check my baggage?	Где я могу сдать свой багаж?	audio/sentence_where_do_e81563d9.mp3
006f2c9e-a8a4-4687-b244-706eeb403ac9	4aaa924f-ae9d-448e-a1a1-ab3e262e5b8b	This is my hand luggage	Это моя ручная кладь	audio/sentence_this_is_04ea8218.mp3
41122f1f-9826-4bb7-a014-2dcecf1a5687	f3ab30c4-6046-4d3e-aeb8-920a602dc657	Is this allowed as carry-on?	Можно ли это взять как ручную кладь?	audio/sentence_is_this_4362e4fa.mp3
7f65b20d-408b-46c9-b8d3-4ac576ef94fa	453851f6-602f-4d3a-aef5-be41f5ba0112	Show me your passport	Покажите ваш паспорт	audio/sentence_show_me_eeb732c9.mp3
0003b7b1-990c-454f-bff2-b0d186b1827c	c5111eb5-9414-43c9-8504-c2b1bdfd85b8	Go through customs	Пройдите таможню	audio/sentence_go_through_3f2779e6.mp3
dbbb12f5-982e-43dc-a235-654b093ec184	f809fdec-e67f-445a-bd86-eb26e6886b18	Go through security	Пройдите контроль безопасности	audio/sentence_go_through_e0eb07d5.mp3
0db23f49-8e10-4eb4-aadc-da0845c88e26	478654fe-dbc7-402c-8223-c61bf8f821b2	Go to immigration	Идите в миграционную службу	audio/sentence_go_to_0a361114.mp3
b3042df4-5f8b-430d-8c7d-484a330e666c	6c2fa8c1-78eb-40dd-ab58-228769d95628	What's my seat number?	Какой номер моего места?	audio/sentence_what's_my_16f3ce60.mp3
b1f514b9-3bc6-4507-8d26-0e6ae589cff0	a45eef93-c057-46ae-99cb-00ecfcfbe25d	I need a one-way ticket	Мне нужен билет в один конец	audio/sentence_i_need_6aea12e4.mp3
66d8719d-cc3d-40c6-a0f8-3b4d1f2cb4cf	8ae31896-be2b-45f5-90ca-326788855c74	I need a round-trip ticket	Мне нужен билет туда и обратно	audio/sentence_i_need_e311e187.mp3
f9931c92-5c98-4ea5-a378-aec6fe7e62df	efe9bfc6-7c3c-4a52-8bdb-fd7fb9923e74	Can you confirm my booking?	Можете ли вы подтвердить мою бронь?	audio/sentence_can_you_d7b2d89a.mp3
f586f748-7936-4b74-93f6-7db29c547df1	45cf68d2-2b1b-4ad1-b023-a467792db198	I need to rebook my flight	Мне нужно перебронировать свой рейс	audio/sentence_i_need_6d7eeba5.mp3
5faa9f29-b5b2-4b1f-80cc-02fba621b11c	4cec8021-69fb-4561-99f0-c13746cec92e	I need to get through security	Мне нужно пройти контроль безопасности	audio/sentence_i_need_b95355b6.mp3
9cf9fdd6-c0ba-420b-9796-cd755e0f8484	52298bbd-73f9-4016-9073-9d051eacf325	Let me look up your booking	Позвольте мне поискать вашу бронь	audio/sentence_let_me_7c0ef594.mp3
ae07f7fd-df35-416b-8bd2-afdbfe4ee80b	86eebb6b-bdda-4499-90e1-e1b7ad92e9ea	The plane is about to take off	Самолет вот-вот взлетит	audio/sentence_the_plane_f33a8a11.mp3
abbefd80-f586-454a-8bc2-8f9cbbfad045	8bf50f04-2a94-4a8e-a1bf-69922667ac8c	The plane is landing soon	Самолет скоро приземлится	audio/sentence_the_plane_46ff2436.mp3
f789c44b-8685-4bf4-b650-3818ba90ac2c	31ec4ca1-d48e-4669-a462-56735b873008	I have a transfer in Dubai	У меня пересадка в Дубае	audio/sentence_i_have_f81f1b9a.mp3
941b3661-a974-44ad-9fe5-eaf87416ca62	7b7c54bc-cc1e-4017-9297-35d34002058d	What's my connecting flight?	Какой мой стыковочный рейс?	audio/sentence_what's_my_95b83dd7.mp3
9c67f44d-7522-430a-a1a1-a5f2faadddcc	2fcb044d-ccad-462f-a733-f57e46b4928e	What's the flight number?	Какой номер рейса?	audio/sentence_what's_the_e36f7c6a.mp3
cd31939a-0a9c-4b4f-9d5d-41e4fbdeb60f	f30b2019-dec1-47ad-bc56-58587b36d26d	Where is baggage claim?	Где выдача багажа?	audio/sentence_where_is_bff0daba.mp3
eb083dde-f322-4286-877f-14b4352d6494	2c3a44de-c56c-445a-99da-f10337c83186	I have lost luggage	У меня утерянный багаж	audio/sentence_i_have_4720b1c3.mp3
78ee0195-5d95-45d4-b20c-9a66903f2a35	e3cf871c-eac2-4e3e-9021-f8f9d5b6eab6	The flight is on time	Рейс вовремя	audio/sentence_the_flight_1ae8e04e.mp3
3f3fea64-cc0d-495b-88cd-8fc771671816	ab1d055e-55d3-4a2f-b33e-0726a23a584c	The flight is overbooked	Рейс переполнен	audio/sentence_the_flight_77dd7184.mp3
464a2383-bf7d-4585-ac38-0dd5564e323e	96fd680a-247c-4d51-b41c-fd083a3e6d6f	I have excess baggage	У меня сверхнормативный багаж	audio/sentence_i_have_35325bf5.mp3
55ad680b-fa23-45ab-9f2a-83c8628159ad	2643431d-4df3-458a-9bf2-a4e306bfdeb4	Let's go to duty-free	Давайте пойдём в duty-free	audio/sentence_let's_go_25f81b32.mp3
dec6c103-db1a-4210-8579-f8cd8577009f	4d2a19b7-9bb5-4614-a49d-3f38c77f81f9	I did online check-in	Я прошел онлайн регистрацию	audio/sentence_i_did_bdf0e1da.mp3
031d09a5-e0c0-4e1f-89ed-ea6f1e000861	587f5df9-0789-4240-ad32-452229163f2e	I'll use a self-service kiosk	Я воспользуюсь киоском самообслуживания	audio/sentence_i'll_use_b351e113.mp3
ab89dcb0-f37e-4319-9127-f261763d857a	1f7185dc-2ee6-49c0-805b-60fa5d523274	I booked a hotel near the airport.	Я забронировал отель недалеко от аэропорта	audio/sentence_i_booked_f1fd662e.mp3
aadb1a47-c18d-4429-95d7-53a19f511439	66abf68c-51d2-4e9a-8e75-3e9c8b9251ed	We need a room for two.	Нам нужна комната на двоих	audio/sentence_we_need_5bc2ae67.mp3
1aa600f2-ad34-4103-becc-0b6d72c2bbb9	5439bc17-cc18-4a1d-8d6b-9ae57cc0af6c	My booking is confirmed.	Моё бронирование подтверждено	audio/sentence_my_booking_8ae5776e.mp3
2e4c7110-b58e-4af1-a384-68d62a4269c7	527d01c0-dacc-4eff-9e04-214abe10eb1e	I'd like to reserve a single room.	Я хотел бы забронировать одноместный номер	audio/sentence_i'd_like_0385b87c.mp3
c203038d-8acf-4de6-a8d9-07d90d5c2a0a	a9b0aaac-2cd8-4841-b23c-901083dfb183	Let's make a reservation for tonight.	Давайте сделаем бронирование на сегодня	audio/sentence_let's_make_f671578d.mp3
b95e575d-9a75-439a-a987-49022d5b2cda	02ef61e9-cea9-40d9-8fe3-233ecdfc463b	I've already booked a room.	Я уже забронировал номер	audio/sentence_i've_already_f00b94cb.mp3
7fd27c36-53d9-473e-81e7-88caafc2908a	d6d43230-e82c-4f9a-83bc-39eab9395f1f	Please confirm my booking.	Пожалуйста, подтвердите моё бронирование	audio/sentence_please_confirm_08641dc5.mp3
6478bde1-29a6-4cb5-8224-9975e0701f80	bf7b12e8-973a-4c8f-ac94-00ec1c519ca6	Could you check availability for next week?	Можете ли вы проверить наличие мест на следующей неделе?	audio/sentence_could_you_c6445a50.mp3
8c2a6e26-1a72-414c-b6cf-df20af5a6e5a	d6f53d70-92a5-42fa-bf79-e0751275175a	I need to cancel my reservation.	Мне нужно отменить бронирование	audio/sentence_i_need_5b947a50.mp3
2e6ee8d1-4116-4580-9083-85d877c43278	61ea78f8-9804-45c8-aaba-128718635f21	I need a single room.	Мне нужен одноместный номер	audio/sentence_i_need_a5266909.mp3
c5a1bcbb-40ca-4f00-97fc-3e5e4a9668c2	6d2835c3-8b0c-40c5-a5fa-17c7f1ca2211	We need a double room.	Нам нужен двухместный номер	audio/sentence_we_need_83cdefa9.mp3
960b8072-1ff6-4b0b-aefa-244baf5dc7e7	bf18dc4d-956f-490c-a56d-975016604f1a	We prefer a twin room.	Мы предпочитаем номер с двумя односпальными кроватями	audio/sentence_we_prefer_9994cd4c.mp3
1f63d964-5a23-4c8f-9967-3527f5b8ab2f	2d45ac97-6a17-4e26-a498-cfe878a5c2fa	They stayed in a luxury suite.	Они остановились в роскошном люксе	audio/sentence_they_stayed_f13b1286.mp3
e82f26b4-d211-4fdd-a366-4ca983e8a376	13a24f41-afee-4a70-9a40-257997d9d766	What's the nightly rate?	Какова цена за ночь?	audio/sentence_what's_the_0af09139.mp3
51489c30-d2e1-40f4-b983-f2afa87a1d9a	cb39782c-c93e-49a9-b2c7-0425088e337c	What's the price?	Какая цена?	audio/sentence_what's_the_a66c793d.mp3
b3e4bed6-e547-43d2-8eb6-9f253c6ceef7	3c05e570-03a9-4c17-924d-95ffc7a69cd9	The booking is non-refundable.	Бронирование невозвращаемое	audio/sentence_the_booking_b06a40eb.mp3
26d9b7eb-7ab3-4653-9675-f8282f19a5e7	6ef0aab8-ca9e-4d59-ab4b-dd0b8027ce59	This booking offers free cancellation.	Это бронирование позволяет бесплатную отмену	audio/sentence_this_booking_6da16162.mp3
58fd037b-0e45-4477-8e85-3efeb41a13cc	6e7aebf0-dacd-4a29-92b2-866967be687f	I'm looking for a cheap hotel.	Я ищу недорогой отель	audio/sentence_i'm_looking_c57df3a4.mp3
8bed2798-16b2-4cc0-ac02-839c21171d2e	3d5d854e-5e2e-4f35-8557-69406e9899c0	I'm searching for a hotel online.	Я ищу отель онлайн	audio/sentence_i'm_searching_a2948d84.mp3
4265dcec-07ae-489b-9318-1d52ca7f0344	8f89a4d8-bb76-4d14-9259-e00b9c1c6df2	I want to find the best price.	Я хочу найти лучшую цену	audio/sentence_i_want_323d42c3.mp3
2fe1c8bc-e0f4-4a91-9579-01c18a0ff75d	2e4371f4-af53-407d-8359-9b1249ccb402	Book in advance to get a better price.	Бронируйте заранее, чтобы получить лучшую цену	audio/sentence_book_in_42dc0f90.mp3
37eff45e-6fee-43d6-8a35-e23a45eecafc	803e5880-892a-4e6d-a970-6114c8c93014	I prefer online booking.	Я предпочитаю онлайн-бронирование	audio/sentence_i_prefer_d1de7726.mp3
b3125fe6-fba5-4cb9-9848-4ced78db22d9	8a16c8a8-adbe-4615-9972-f03ac73e0293	What payment methods do you accept?	Какие способы оплаты вы принимаете?	audio/sentence_what_payment_802ff0f2.mp3
97f88836-d021-41c5-997f-296a3f2bfc9c	c34149af-c0f3-4d5c-b35e-991465239efa	I'll pay by credit card.	Я заплачу кредитной картой	audio/sentence_i'll_pay_d2202e75.mp3
89dc825b-2c8e-4811-af1e-49738f118144	d7a1b645-7ba8-4c33-9277-865b12e9f882	The receptionist was very helpful.	Администратор был очень любезен	audio/sentence_the_receptionist_6da21ef6.mp3
af9d65e9-c018-49ef-993e-79b2169ec871	879163c5-cd91-4313-9dad-4b2a2a98f038	I booked a room at a hotel near the airport.	Я забронировал номер в гостинице недалеко от аэропорта	audio/sentence_i_booked_57a640a0.mp3
3ed1f006-24cc-4c36-9caa-d1255f216776	1a804bb7-faee-4fcf-82fd-a3090dce93f9	Check-in is at 2 pm.	Регистрация в 2 часа дня	audio/sentence_check-in_is_e4c77d73.mp3
385cf67b-6ff0-4266-9ab8-ffe4b2178a58	c96122d2-7b9d-463f-99b2-f151da24351c	Check-out time is 11 am.	Время выезда - 11 утра	audio/sentence_check-out_time_bdf6d067.mp3
12947b75-4d3f-408a-9148-05fa93c45320	924722d4-b6ee-4d82-877c-69c3d9beb2cd	Here's your room key.	Вот ваш ключ от номера	audio/sentence_here's_your_8214c108.mp3
b17016cc-c12d-4102-a2b5-94f0ddba95d1	0c940e44-25f2-4f5e-a361-d1086fb5801e	I have a reservation under the name Smith.	У меня есть бронь на имя Смит	audio/sentence_i_have_e20aa7b3.mp3
14f3eb6d-3128-4f88-a89a-0ca811cebe79	ed1d9a1a-1767-410f-bcaf-ed2a49de0afa	Can you confirm my reservation?	Можете ли вы подтвердить мою бронь?	audio/sentence_can_you_02c37f8c.mp3
9b82439a-baf4-4249-8064-b2e70b42c438	c46150e2-8bcd-4946-a7ef-204be999f367	I'd like to request a wake-up call.	Я хотел бы попросить будильник	audio/sentence_i'd_like_dd320862.mp3
693d50db-2320-41e7-befc-c4f177962a4e	48ff79ef-fc56-4951-92fc-3c1b4a1f5437	Could we have an extra bed in the room?	Можно ли нам добавить в номер дополнительную кровать?	audio/sentence_could_we_a33f2283.mp3
0acb2119-6391-4cba-a240-7cd8b5dc1d24	91b84348-bb8a-4f95-ae56-653dd458cddd	Leave your luggage here.	Оставьте свой багаж здесь	audio/sentence_leave_your_39e56665.mp3
465aa5ec-2eda-41a7-b292-6d4861b0ef74	7a1fe2c6-4a7c-4591-b768-c5a4935c2d09	The porter will help you with your luggage.	Носильщик поможет вам с багажом	audio/sentence_the_porter_b052d337.mp3
d0d21612-e45c-4a30-a64e-62bca31b457c	950d46c9-d471-46c8-9a2e-2f05013a05d5	A bellhop took my bags to my room.	Носильщик отнёс мои сумки в мой номер	audio/sentence_a_bellhop_98fa8bc7.mp3
ce2c55ec-0c84-410e-a292-e497b03d8465	1cb5cb97-3715-4665-902b-cb8ad6fe82cf	I'd like to order room service.	Я хотел бы заказать обслуживание в номер	audio/sentence_i'd_like_97d1e0d0.mp3
8ada31cb-38e2-4471-8f54-22ecbd3b8468	e95009f3-02c2-4634-959e-d55d8fee10b6	I have a complaint about the room.	У меня есть жалоба на номер	audio/sentence_i_have_ebaf61f7.mp3
050364fd-03c3-4edd-8b52-54cf7a5bec29	c84cdffb-e8fb-4da4-bc2b-e3dfa577565b	Is there wifi in the hotel?	Есть ли в отеле вай-фай?	audio/sentence_is_there_e42a1147.mp3
2fd90237-3d53-4d5f-af94-a1d5a3218d79	bac24924-54f2-4dfc-8201-8fa6d18ffd89	I need a single room.	Мне нужен одноместный номер	audio/sentence_i_need_4c0951a2.mp3
651291ac-f6e4-491a-afaa-c62fe6c96f56	4ae087ee-e5ea-487f-bd23-e5d4006d48c7	We need a double room.	Нам нужен двухместный номер	audio/sentence_we_need_a9c4492d.mp3
80bef04a-2630-4db3-9f8d-99a6249577a0	c84ed8ff-62a9-4dff-b33b-b6a338922187	We'd prefer a twin room.	Мы бы предпочли номер с двумя односпальными кроватями	audio/sentence_we'd_prefer_20958f94.mp3
92569460-f224-4802-8977-30c2b97457e8	f4f8ce2f-0e80-419b-9e0e-ffbd40e93336	We need a triple room.	Нам нужен номер на троих	audio/sentence_we_need_767f9338.mp3
adb28a3d-c024-4d81-b3dd-178bc1ffb15f	c208d4ab-1149-47db-bf87-06fd59d8764c	They booked a suite.	Они забронировали люкс	audio/sentence_they_booked_2e2203d2.mp3
b0909cc1-f20e-4239-8112-a86ba6f3c47d	45139954-2ff1-4d8d-9ae3-3d2f492726c9	Is there any possibility of a room upgrade?	Есть ли возможность улучшить номер?	audio/sentence_is_there_6705adc8.mp3
f3eacdcd-5411-4a34-a80a-b6014577ede9	eeb86c69-7596-4bf3-a277-aa0fa90e8b99	What are the hotel amenities?	Какие удобства есть в отеле?	audio/sentence_what_are_9b2da5bc.mp3
090e8210-6048-4b51-ae76-4356c42a33e5	5834fe69-65e7-43f4-84eb-13537cb8d89c	What facilities does the hotel offer?	Какие удобства предлагает отель?	audio/sentence_what_facilities_1a1f8a64.mp3
9896b335-42d8-496e-b45d-4ae8184cc6ca	3696176b-eebf-40ff-b71a-5c4971472d72	Go to the front desk to check in.	Идите на стойку регистрации, чтобы зарегистрироваться	audio/sentence_go_to_6ca9a642.mp3
6f4da6f4-9153-459a-a95b-670fde74d073	fb76bbe1-886a-4365-945f-1f725aa8126c	Could you look after my luggage for a moment?	Вы можете присмотреть за моим багажом на минутку?	audio/sentence_could_you_7e51ca5a.mp3
44f1b191-6056-4f0a-8331-45046feb4b9c	92f4dfb0-2e63-41c9-855f-ff399e82fa9b	Hold on, I'll check.	Подождите, я проверю.	audio/sentence_hold_on,_3a4fe86f.mp3
faf19064-c12a-4ccb-94de-dbc0a7dbb10e	b73375ed-ddfb-4295-9d71-3a732c559f8a	Please fill in this form.	Пожалуйста, заполните эту форму	audio/sentence_please_fill_fc61255a.mp3
771a8f16-5e63-4d92-a8df-e36d26cc632d	a6140ef4-bab4-455b-a2e8-2bf7100e8442	Hand in your key at check-out.	Сдайте ключ при выезде	audio/sentence_hand_in_d2d8615c.mp3
0df1b131-f6db-4200-95d1-91b7de648ef5	5cfb96f6-ea07-4a39-8c43-e090308b45f4	We need to sort out the problem with the room.	Нам нужно решить проблему с номером	audio/sentence_we_need_1c4da831.mp3
96e33eee-8774-4b2b-b26d-89962d9bb101	0eb9551b-e63f-4764-9982-ca8346c90c02	I need to find out about the airport shuttle.	Мне нужно узнать о трансфере в аэропорт	audio/sentence_i_need_1563b47e.mp3
cbb0aa15-3aad-4edb-bf3b-9f4372e12930	8bc6e00c-a61f-4bb4-b766-33e4c46af64d	Can you figure out how to use the TV?	Вы можете разобраться, как пользоваться телевизором?	audio/sentence_can_you_eba4f568.mp3
cb7bd8d4-9113-47da-9d37-c91200f93162	f3b5fe4b-c779-49d2-a295-558d9e6885e0	Someone will take care of your bags.	Кто-нибудь позаботится о ваших сумках	audio/sentence_someone_will_1c3ecc26.mp3
2de9fdec-611b-4a5e-b4e2-beee9fa0d66b	843e46bc-6d18-4bd1-92c0-07b6badc9534	Please get in touch if you have any problems.	Пожалуйста, свяжитесь с нами, если у вас возникнут проблемы	audio/sentence_please_get_e23c4050.mp3
72e4424a-55fc-45dd-8d6b-8c976bcb27fb	9206e9af-d2d1-4403-accc-bcedd2a4c17c	Go ahead and check in.	Идите и регистрируйтесь	audio/sentence_go_ahead_4de336ef.mp3
93e2dd91-c724-4019-a3af-ed27d7d10bb1	87fd0b4d-032f-436c-b9ba-dd1ea3c6ceb1	I'm afraid the room is not available.	Боюсь, номер занят	audio/sentence_i'm_afraid_00d2c993.mp3
8a7e8d37-0062-4d5a-b72d-4f489d75899d	789a44ed-c43b-4ada-9ba9-d6d6e5d9783f	Excuse me, is this the way to the reception?	Извините, это путь к стойке регистрации?	audio/sentence_excuse_me,_0a600425.mp3
422572f0-3a2e-4a5f-94ad-8d1c4c16e265	77182d62-064a-42fc-a266-395f6b3a7aec	Thank you very much.	Большое спасибо	audio/sentence_thank_you_4b829fb2.mp3
95e9a1d9-f157-4d57-8fa8-d3b2b3ea2090	92ceea79-5958-4930-ade7-50fb839d46c6	You're welcome.	Пожалуйста	audio/sentence_you're_welcome._a5e3b7b3.mp3
10e7fb42-f78f-4d2a-a1b3-444bbed5fb09	1904800d-f66f-48cc-9b43-84e11cb32719	No problem.	Нет проблем	audio/sentence_no_problem._b9c9203a.mp3
d8e18ee0-ad53-4e0a-ae0a-ccd84c550c17	eed75359-f04a-41eb-851c-187f22e1ec9b	Certainly, I'll help you.	Конечно, я вам помогу	audio/sentence_certainly,_i'll_b2b990de.mp3
5eb4fc3d-07f2-4a45-89ba-e689a96599f1	bb862046-f162-4360-9297-88e1f2ee2135	Absolutely, I can do that.	Абсолютно, я могу это сделать	audio/sentence_absolutely,_i_2793bc55.mp3
a1817706-4a1c-49cc-8c76-f9e90856d5ff	9389d79a-f9a1-42be-81f4-aa3a5e67a7a9	Definitely, let me assist you.	Точно, позвольте мне помочь вам	audio/sentence_definitely,_let_245f67c9.mp3
8b21ff6d-8630-46e3-8576-773684f3a898	e4d771e5-e6c8-4986-bea8-ab6c2e45969d	I need a room with a view.	Мне нужна комната с видом	audio/sentence_i_need_e761d31d.mp3
e814d25e-4c8f-47b6-97cb-41c7ddd19de3	3ba36ed0-38f1-4062-b253-b1def6a10e55	I booked a single room.	Я забронировал одноместный номер	audio/sentence_i_booked_ac10729b.mp3
f9f766e9-4937-4541-a18e-5035ea1e4318	3c2e04ab-89fd-4bd2-a3dd-3844f167f634	We need a double room.	Нам нужен двухместный номер	audio/sentence_we_need_76d8a901.mp3
872c5762-96e8-4a82-8792-4452823c913f	20d891e5-1f28-4f3b-a12a-9376072f3ecf	We requested a room with a king-size bed.	Мы попросили номер с кроватью размера "king-size"	audio/sentence_we_requested_7e48f246.mp3
fbfc645e-48e3-4af7-b2e4-af06e79589fb	e2aa4868-9f97-4457-bccc-eba695c7887f	The room has twin beds.	В номере две односпальные кровати	audio/sentence_the_room_1fbc1564.mp3
c8e0631f-e9da-4d33-b311-2cea6f4acd5e	5258f3eb-21fa-40ac-8cd6-d7b299f1eba3	Can we get an extra bed for our child?	Можем ли мы получить дополнительную кровать для нашего ребенка?	audio/sentence_can_we_7175f42b.mp3
211e6e62-f9e4-4e96-8b1f-bfde37de6593	9d3938a8-c45e-462a-92b4-8941e03ed74b	I need a non-smoking room.	Мне нужен номер для некурящих	audio/sentence_i_need_e175cdd6.mp3
45a7d897-a73d-4734-8d21-e15e9ebccf26	ea2d5cd7-712b-4948-bab7-73a5a77a1793	I'd prefer a room on a high floor.	Я бы предпочел номер на высоком этаже	audio/sentence_i'd_prefer_3a28f440.mp3
01c92d8c-998d-4d0a-b924-0d8743fbc8b5	6154bc03-2492-40cf-9d11-38bcae613f76	Could we have a quiet room, please?	Можно ли нам тихий номер, пожалуйста?	audio/sentence_could_we_da2a96b2.mp3
99938aee-462a-4292-b89c-2ca22b0a53d4	94182a2c-9c71-4e32-b913-c13c6ec1d823	What's the view from the room?	Какой вид из номера?	audio/sentence_what's_the_da09cd8e.mp3
bfa202a7-1b6a-4aff-bf7c-07292b54c70a	04a3f1f1-02fe-41f7-8321-043943a296d9	I'd like to make a room request.	Я хотел бы сделать запрос на номер	audio/sentence_i'd_like_077fef21.mp3
7e876aff-94a5-44ea-9d6f-a026c988f433	4e00f932-2a05-4499-8364-dfe9cb52118b	Can you confirm my room request?	Можете ли вы подтвердить мой запрос на номер?	audio/sentence_can_you_498c6586.mp3
4502ce4a-d25d-4a47-80bc-f2fe6dd0fe71	a5e69a7e-9eb6-4780-8c2a-935d606a5faf	Could you check the room availability?	Не могли бы вы проверить наличие номеров?	audio/sentence_could_you_b07dc2f1.mp3
2fc9e957-4981-4750-b389-98acd191e793	0b0f69b0-5e9e-4cab-a8f6-47f1e354a1d8	I've already booked the room.	Я уже забронировал номер	audio/sentence_i've_already_a7ac78e9.mp3
f6a92c34-f793-4a27-a2f8-f5fc480445bd	c649c215-abd6-490a-b8a5-d9258bf6a4b8	What amenities does the room have?	Какие удобства есть в номере?	audio/sentence_what_amenities_df42b341.mp3
6a963b6f-09f1-419f-a1da-25a2f213a9cf	85a3604f-29c0-4731-8fc3-e3acf2542ceb	We need an accessible room.	Нам нужен номер для людей с ограниченными возможностями	audio/sentence_we_need_6dd8065c.mp3
91f09a87-c917-4bae-a0a1-9616cbb32a6b	442fe4b6-a3b3-4216-9ac6-259b04e2a327	I have a preference for a room with a balcony.	У меня есть предпочтение номеру с балконом	audio/sentence_i_have_059e3876.mp3
d352fda6-83c3-4fee-a1f3-15e9cd921b7b	2b2f899e-f0e2-4ade-8d3a-6ff5ef6e712a	Is a room upgrade possible?	Возможно ли обновление номера?	audio/sentence_is_a_38392f58.mp3
a49abbaa-9acd-46d6-a06d-9b2433a9e834	75f3589c-02c5-42b9-b668-8af715965644	What's the room availability?	Какова доступность номеров?	audio/sentence_what's_the_833298d6.mp3
e85f2632-8129-44dd-aa48-ecf36e81790c	fa727e0a-d989-4be0-a137-413221dfc3df	I have a specific room request.	У меня есть специфический запрос на номер	audio/sentence_i_have_2602ffed.mp3
3c354d3c-a422-44fa-a015-34c2c55653ce	2786f209-adbb-48c2-a2f4-f28971caea01	We'll look into your room request.	Мы рассмотрим ваш запрос на номер	audio/sentence_we'll_look_38b74d58.mp3
4a0ab061-8656-43c3-9c95-df9c99506899	bafab221-03aa-48ba-a7a6-7dabf6793c78	We'll sort out your room request.	Мы разберемся с вашим запросом на номер	audio/sentence_we'll_sort_56268661.mp3
68e878a3-d363-411f-a628-001fe3255dfb	8b88af60-955d-44f5-97e9-9e97ad9a9a6d	They'll deal with your room request.	Они разберутся с вашим запросом на номер	audio/sentence_they'll_deal_c04dbbab.mp3
2cc4fce0-2426-4cd4-8209-9efa920eb21f	26e8d9c9-05e0-48df-ad2e-b8e4520a8864	I have a complaint about my room.	У меня есть жалоба на мой номер	audio/sentence_i_have_01fb311e.mp3
3dcb84ba-b797-4cfd-a740-1529023ad128	e3fbc1c9-16b9-4ebe-9022-9aa80ee68174	The room was too noisy.	Номер был слишком шумный	audio/sentence_the_room_c6bdbe04.mp3
e42a21c3-34b6-4be9-96e2-906e36d01ae5	2a531afb-97ba-4890-bed6-93f1062d299a	The bathroom was dirty.	Ванная комната была грязной	audio/sentence_the_bathroom_3ff30547.mp3
5d9f084e-0640-439d-9ef7-1216f760d627	99d9e25e-8072-4fbc-93f0-c57e28650650	The bed was uncomfortable.	Кровать была неудобная	audio/sentence_the_bed_c7fca497.mp3
923bd197-6094-4e8c-9654-aaed710fc28e	67e2a551-8b32-484c-826e-cbe5e21e887b	The air conditioning was broken.	Кондиционер был сломан	audio/sentence_the_air_6fea29b4.mp3
b59b3f29-11d3-4d4c-b905-66f47dc63d3d	523ffd3c-10c2-4ecd-bbea-f041640a84b4	The sheets were filthy.	Простыни были грязными	audio/sentence_the_sheets_9e625e64.mp3
ad307ede-0c35-4585-a261-3849b793c0c9	4e8ff706-ddcf-4aff-9f2d-e05717e42813	The toilet was faulty.	Туалет был неисправен	audio/sentence_the_toilet_f51a01d0.mp3
d5766c9f-ac3f-48c3-824b-87d883ffad9e	5a108fec-e149-4323-aa87-32126cdbe5b7	Can you sort out this problem?	Вы можете решить эту проблему?	audio/sentence_can_you_d8e152b6.mp3
86af4722-d03e-4bb2-9a61-46127a75ee1c	2ea3d65a-4250-4d46-aa15-8b49a40caf9b	I want to deal with this complaint.	Я хочу разобраться с этой жалобой	audio/sentence_i_want_164f2f27.mp3
e1d6fd69-f1e3-437e-9aa6-a8d790df8fcb	3dbc49b9-7632-45c0-ba52-c5b42056341f	Please get in touch with reception.	Пожалуйста, свяжитесь с рецепцией	audio/sentence_please_get_3be65d11.mp3
824a9285-68ef-47ae-94eb-6c9d787fc893	875b756d-339c-4cf7-9dae-f7d47127a647	Call the hotel manager.	Позвоните менеджеру отеля	audio/sentence_call_the_21e9f4d3.mp3
05f19945-a868-48f1-833d-02b771abe154	1c435b12-04f9-4b79-babc-496d206d3317	Go to reception and complain.	Идите на ресепшен и пожалуйтесь	audio/sentence_go_to_e3cef6a0.mp3
b1192d36-5306-4aca-8e6a-00299545a077	4e1b5182-e94a-4edf-9e62-7a86014da0a5	I want to speak to the manager.	Я хочу поговорить с менеджером	audio/sentence_i_want_c8417cd4.mp3
6d14df27-a2fb-4ecc-a214-f57dc73f91b2	9213bcf6-6827-43a7-8a1b-52417c062a32	The staff were unhelpful.	Персонал был нерасторопным	audio/sentence_the_staff_f13fd473.mp3
482ff1eb-1ab4-4938-99b9-6f50af12c55d	65352aa5-f193-42ff-97fd-0146f9a2172d	The staff were rude.	Персонал был грубым	audio/sentence_the_staff_67499245.mp3
c178c7f3-068e-43c8-b55c-0f6a1315d7da	0d5299f1-4cf2-4ba3-9be8-cf76972204f4	The staff were unhelpful.	Персонал был нерасторопным	audio/sentence_the_staff_babd01b9.mp3
96c96d51-5ae9-488e-ace0-7b59fe98074c	d9da3021-e085-48bd-b3a7-eb692cda7463	The service was terrible.	Обслуживание было ужасным	audio/sentence_the_service_d2f233b7.mp3
eb33f534-434b-49ea-a21a-3245188db2f2	d18f2169-fb78-449c-a79d-27900d2b4dab	It was an awful experience.	Это был ужасный опыт	audio/sentence_it_was_7b11beae.mp3
b866c1d6-1e23-4c36-b12d-13aa8dd76099	d81b4a6e-9dba-4b62-b6b6-8e01c4350420	I'd like a refund.	Я хотел бы получить возврат денег	audio/sentence_i'd_like_a8ee2cc2.mp3
03fdd1b8-d2a7-4784-acef-ae4f72ae67fc	3674ebea-f32f-4e8b-a1b0-e6389bdd4232	I'm asking for compensation.	Я прошу компенсацию	audio/sentence_i'm_asking_d7639d4c.mp3
035909aa-a570-4002-9135-6b8e658e6ec3	fedb3f05-be44-421e-a1f1-94f1d17f371e	They resolved the issue quickly.	Они быстро решили проблему	audio/sentence_they_resolved_cac0e321.mp3
2ccbce82-0209-4df0-aca3-4d53cb82c148	8f76c762-081b-444b-b1d8-f4afa91e07ba	Let's address your complaint.	Давайте решим вашу жалобу	audio/sentence_let's_address_4e1ebec7.mp3
2c9de84a-b31d-43ac-a629-b13e3140f5a4	565f9d41-f6bd-4f69-a319-6a85c69f16da	Can you fix this?	Вы можете это починить?	audio/sentence_can_you_019c9860.mp3
89f6fc68-92cd-42b2-8ce4-4f99de4e6101	3a4d33a5-3c31-4ee5-996c-ab616722b850	I have a request.	У меня есть запрос	audio/sentence_i_have_c9ce7941.mp3
e09886e3-ecc1-4cba-b2c4-4aef9427c86f	57ab3051-7881-4577-86bb-00152c83c572	I need this fixed immediately.	Мне нужно, чтобы это починили немедленно	audio/sentence_i_need_45e7574d.mp3
3bd1f1a4-39d0-4f20-a88c-138d54f2ee67	de25e7d8-ace3-4533-a806-ff507845d6ac	I need help right away!	Мне нужна помощь немедленно!	audio/sentence_i_need_870d442a.mp3
2060936e-ac79-4149-bc45-b103982466bc	4a00d8da-77a5-47a4-bcf0-12aa872b9cc3	Please deal with this as soon as possible.	Пожалуйста, решите это как можно скорее	audio/sentence_please_deal_115c6b50.mp3
22973c00-8bc7-4b59-a508-18751ad7f879	59a5c4c5-bdc4-4b79-bc8c-2fb1fba53822	I'd like them to look into this.	Я бы хотел, чтобы они разобрались с этим	audio/sentence_i'd_like_388b982e.mp3
2e822c63-c2c6-4fdb-a26b-e84bf03f5e32	40033134-0ddd-4ba0-98b2-1f68a8f884fd	I had a terrible experience.	У меня был ужасный опыт	audio/sentence_i_had_a098fee3.mp3
0e95a11d-a135-4fcf-9465-c5fb314fb364	fe2d2d13-f580-4fe3-9275-ffee82fdad9f	It was a complete nightmare.	Это был полный кошмар	audio/sentence_it_was_a559adba.mp3
e74c0d2d-8ed2-4915-bc50-b19993c4ed8b	aaf7c1f9-7040-4241-a3c4-824b966be601	Excuse me, could you help me?	Извините, вы могли бы мне помочь?	audio/sentence_excuse_me,_f3755807.mp3
cb94cb3b-44a8-4e8d-8f25-0f71c9f9a60d	f016062e-5c59-4391-8c94-db74d3fd4ab3	How to get to the train station?	Как добраться до вокзала?	audio/sentence_how_to_327cba84.mp3
b99644b2-b52d-45fd-a85a-e5cafae17650	07d189e3-041f-4701-89cd-adbd51eb6601	I need to go to the city center	Мне нужно идти в центр города	audio/sentence_i_need_671ec710.mp3
3a6059fc-3991-4342-bce8-27ce89bdd2df	6dbbd63e-ff99-4000-8cb7-9853bd180f77	Good afternoon, madam!	Добрый день, мадам!	audio/sentence_good_afternoon,_534aea00.mp3
b3b482c2-3d2d-4ddf-a83c-f950cfd34677	df4b9ac7-bbef-4de7-b4a2-a9632d749128	Go straight ahead and then turn left	Идите прямо, а затем поверните налево	audio/sentence_go_straight_07fba3ac.mp3
e916f944-3817-43d4-9845-56a8f2750411	d531357c-dcf3-461d-8b0b-297d5d4635f3	Turn left at the traffic lights	Поверните налево на светофоре	audio/sentence_turn_left_14fa8e6e.mp3
a1cc1aa4-b6a3-4fe3-a363-8f74d9e94f8f	d0241818-978d-4368-a19f-dd4b9976b00f	It's at the corner of Elm Street and Main Street	Это на углу улицы Элм и улицы Мэйн	audio/sentence_it's_at_4a1e6641.mp3
cc687d35-d5b9-4b83-93d4-3183df64dedf	9ddecba2-c929-4d54-9854-aa800f2c5e85	It's near the post office	Это рядом с почтой	audio/sentence_it's_near_0a0cd39a.mp3
85f0e4c3-75ec-4972-8f27-7ee4ad7cfbb9	9af1a74d-321f-4ba8-84bc-0cea0f4ed882	The hotel is across from the park	Отель находится напротив парка	audio/sentence_the_hotel_8abba4b5.mp3
532348b6-ef70-4596-9082-3bf83748f7f0	2b185063-2c8a-4a8a-b99e-e15bda388edf	The bank is next to the supermarket	Банк находится рядом с супермаркетом	audio/sentence_the_bank_8df3c0d7.mp3
b01d8e1f-ae14-4053-bf7f-9772f480ff37	bf71b9b0-d4c9-459c-bb3f-ddf1d5b6d85e	It's between the library and the museum	Это находится между библиотекой и музеем	audio/sentence_it's_between_fdf0d232.mp3
1e3aad1d-85a7-40c7-98d5-67b82e5c5328	5236d762-eec9-4229-97c2-0098d12186fd	The shop is on the right	Магазин справа	audio/sentence_the_shop_8c260c1f.mp3
3d73b0f0-4550-4331-b69c-2a4d5dd6ad83	e635d47d-f01e-4381-8a4c-910d3485836d	It's a few blocks from here	Это в нескольких кварталах отсюда	audio/sentence_it's_a_a34805fa.mp3
a8909d7a-ff36-4049-a74d-b564d6c5be5c	748fa6c6-62ab-4b24-b831-3039f1f655b3	Take a taxi to the airport	Возьмите такси в аэропорт	audio/sentence_take_a_e695377c.mp3
fc41d3d1-f965-4474-b4ca-b3bca2c66e5b	8f9d16ed-503e-4815-9733-45dd0028f626	Is it far from here?	Это далеко отсюда?	audio/sentence_is_it_91e4dc6e.mp3
df7f5da7-85a8-46b0-8314-525fbf89b0c6	6308bab2-91eb-473a-ad3a-9629d00e498c	How long does it take to get there?	Сколько времени займет дорога туда?	audio/sentence_how_long_806a0fdd.mp3
9b4147d4-5d88-4774-b2ce-b69b9d84d70a	4adb1fe6-d5b7-4c0e-8637-188107f2be3c	It takes about 20 minutes	Это займет около 20 минут	audio/sentence_it_takes_a10ae214.mp3
eecc34c7-566b-43a4-bbbf-8142fc822dd5	2a970f09-5875-4c88-8a59-63914910d695	Thank you for your help	Спасибо за вашу помощь	audio/sentence_thank_you_cae938f9.mp3
cd1d072a-33f8-4ce9-b9c4-2597b6ff77f4	88880130-b46c-4d9d-8ee1-49efb01a98ba	You're welcome	Пожалуйста	audio/sentence_you're_welcome_e53e3725.mp3
ccca86ef-f9d6-47f3-bab5-47ce4ef7db8c	92ea109b-14e5-4ef6-9a33-c6041173b84b	I am lost, can you help me?	Я потерялся, вы можете мне помочь?	audio/sentence_i_am_9438745a.mp3
17ae9fa9-2bdc-4e72-8875-19dc22eeda23	f306819c-9c6c-4c12-b9d4-2c8099261c5b	Could you show me the way?	Могли бы вы показать мне дорогу?	audio/sentence_could_you_1bb53143.mp3
2e236d14-9427-498e-b3ef-2d846f629ce9	89727584-b79c-4465-93ea-eda8d2f55561	Follow me, I'll show you	Идите за мной, я вам покажу	audio/sentence_follow_me,_5e00e14b.mp3
3c56b9dc-d2ee-40c1-b33a-b658611fd8c7	56ab5b1e-df0e-45f8-a458-0b7b101545ec	I don't understand, please speak slowly	Я не понимаю, пожалуйста, говорите медленнее	audio/sentence_i_don't_30323582.mp3
c537c883-ecb5-49b2-a294-d04861b13317	cd60c7a6-b4f8-4854-9790-ee1162fc1ff8	Please repeat that	Пожалуйста, повторите это	audio/sentence_please_repeat_29091bd1.mp3
75837758-37c1-490b-96ee-13e31208f684	80375e47-c7fe-4c00-a72f-301af92c1909	Do you have a map?	У вас есть карта?	audio/sentence_do_you_97c33284.mp3
ee962907-3489-4c94-92a2-414637cf254b	93b63562-34fa-44dc-8df7-bf57f772879f	Look at the signpost	Посмотрите на указатель	audio/sentence_look_at_852ece09.mp3
96092042-33f8-47b6-a1fc-caf6dfa94c7a	4c608701-aec0-48dd-b4d8-0e3c33c3f51d	I need a map to find my way.	Мне нужна карта, чтобы найти дорогу	audio/sentence_i_need_711c15d3.mp3
4e6d4b66-bc49-4ad7-97e8-b31a1bf44ba9	af6b5c6d-a88c-450b-99d6-59d772eb042b	My GPS is showing me the way.	Мой GPS-навигатор показывает мне дорогу	audio/sentence_my_gps_2e3c8283.mp3
e2a3edf7-e85b-4829-a651-279fa6a46832	40163eaa-9490-46ab-9be8-d4820d52b6f1	I don't want to get lost in this city.	Я не хочу заблудиться в этом городе	audio/sentence_i_don't_8226cadd.mp3
52704478-3681-416d-9af3-93ed22945e92	3aa42b0d-512d-4a66-9cfc-82e6679eb5b5	I need to figure out how to get to the hotel.	Мне нужно разобраться, как добраться до отеля	audio/sentence_i_need_e6bbe13e.mp3
7ad9089d-a819-4cb7-a003-6c9de3ff1e09	7ea5c1d8-5c98-42b5-a609-03ddf88f21ba	Just follow the signs to the terminal.	Просто следуйте указателям до терминала	audio/sentence_just_follow_c6856f40.mp3
e2e978a0-a408-4f67-81e8-be2803e241f1	72cf9afa-885a-4608-a200-4f2eca5cd2e6	How do I get there from the airport?	Как мне добраться туда из аэропорта?	audio/sentence_how_do_e02b3784.mp3
dc9a3ba6-b11a-4174-be2f-66a4d51faaa4	e835bf30-df42-426d-acf3-b93f3e0f23c0	What's the street name?	Как называется улица?	audio/sentence_what's_the_3caacdf3.mp3
1f565be1-5df6-4325-adaa-ffcc803e53b8	15f8cd2d-a8cd-48b0-99a6-252958d24e03	The Eiffel Tower is a good landmark.	Эйфелева башня — хороший ориентир	audio/sentence_the_eiffel_6dbab2b8.mp3
187b1920-d480-43ec-926d-6a34d0da2b8f	deb1b013-1897-4bea-b5ba-343cd803f250	Turn left at the crossroads.	Поверните налево на перекрестке	audio/sentence_turn_left_ebb166e7.mp3
8f632f2b-53a0-41fb-add0-c13aa33cd871	cf7895df-658c-4ff3-b173-f4d1c9d324af	The accident happened at the intersection.	Авария произошла на пересечении улиц	audio/sentence_the_accident_3700cf95.mp3
0f207b3b-583a-4f07-8b29-da8b743a3fb5	18764cdf-9e3c-4b9f-a072-de7630ffa567	What street is this?	Какая это улица?	audio/sentence_what_street_1ab446b6.mp3
7ea20280-e2e6-4202-8808-958482546f1c	39929d75-2692-4f12-b3cd-4db59863d5c1	What's the best route to take?	Какой лучший маршрут выбрать?	audio/sentence_what's_the_ba2f9607.mp3
e8ac3f43-dd10-4d46-a8ce-9138a834e5b6	dbd4d4f6-b227-4527-ac18-ac3b302ec8d9	What is your final destination?	Каково ваше конечное место назначения?	audio/sentence_what_is_379632c6.mp3
34b61ade-8e1b-4a21-9dd9-3e3386decf89	70855ac4-fead-46ec-8065-9b8d8e1b229e	Go straight ahead for 500 meters.	Идите прямо 500 метров	audio/sentence_go_straight_54e1e5f3.mp3
71e0d1d4-42fd-419d-a6c5-d59b8313f5f1	9887c70d-0c61-4fe7-9ae8-e2d250a49aec	Turn left at the next corner.	Поверните налево на следующем углу	audio/sentence_turn_left_54bcb0ff.mp3
ca9db014-8a95-40f8-abd8-81392f33b6d6	03b85f4d-1419-443c-8eaf-0059a3cfe235	The hotel is two blocks away.	Отель находится в двух кварталах.	audio/sentence_the_hotel_3ba4c49a.mp3
e3598f46-a310-449a-9158-247d0c0f5008	b211b1b9-61ce-4d62-bac9-bddfc7671bdb	That building is a famous landmark.	Это здание - известная достопримечательность	audio/sentence_that_building_8b7685f4.mp3
747c093d-b0ff-43db-b004-382fc4ee0df1	ffee281f-3ff8-4c74-9dc9-e8126f9ede02	The Eiffel Tower is an iconic landmark.	Эйфелева башня - знаковая достопримечательность	audio/sentence_the_eiffel_24e05d50.mp3
f94aad56-bc23-4c1e-beef-9c5e53bacdda	3cefb09a-dae8-417d-a179-4e759eea10ff	There are many points of interest in the old town.	В старом городе много мест, представляющих интерес	audio/sentence_there_are_340f1fed.mp3
0b73217e-94bf-49c5-ba60-2e72d29e52c7	448239be-cce4-4ad0-b397-3b6f668c1aa2	The museum is a popular tourist attraction.	Музей - популярная туристическая достопримечательность	audio/sentence_the_museum_2a132837.mp3
334c5224-d161-4679-b3e3-639d72cd1cf8	d5e42a85-20e7-46cb-a7b4-06565e7c95e1	The church is easily visible from the square.	Церковь хорошо видна с площади	audio/sentence_the_church_1da87ee0.mp3
5e757866-6cdd-4409-b397-e514fffbd37b	0d3cb936-dc5d-40fb-ac67-621111804774	We caught sight of the castle in the distance.	Мы заметили замок вдалеке	audio/sentence_we_caught_74e7b074.mp3
09ce3e86-e876-4c8d-8442-04f10542cd05	5fca4738-5c98-4f07-99ce-7a9cd22bf0f3	I spotted a familiar face in the crowd.	Я заметил знакомое лицо в толпе	audio/sentence_i_spotted_56359579.mp3
023e326b-bb9f-48cd-ada4-4238645b0dc9	85680b86-b029-4f9f-a232-b6db535857fc	Did you notice the clock tower?	Вы заметили часовую башню?	audio/sentence_did_you_0f3206a0.mp3
4f538e83-6e2f-4522-8ac2-a68d132d77be	b1f15961-aad4-460a-8230-aa68a3b5a5f4	Let's take a look at the map.	Давайте посмотрим на карту	audio/sentence_let's_take_faa14789.mp3
b31b9ab0-6853-4bfd-aa6f-5b4d24db3855	ea9a32c5-2b38-4887-9549-ca9dc618b6dd	Check the map to find your way.	Проверь карту, чтобы найти дорогу	audio/sentence_check_the_1531b4bb.mp3
2476ee30-0540-4abf-aaf3-eacfc0170d25	589718b8-3f3c-4895-85c5-56b526f89929	Refer to the map to find the location.	Обратитесь к карте, чтобы найти местоположение	audio/sentence_refer_to_8a2336f3.mp3
c3598eb1-17f2-40f9-8d5f-aa2af18be807	d4f4ac88-4461-49b0-8988-a7f0a50aceb0	The hotel is over there.	Отель там	audio/sentence_the_hotel_4c2d36dd.mp3
4314246e-49fe-4155-a2e4-b3888ef4e3d0	7afb0ad1-c1c0-4928-8dc4-ce3a4772bf74	Go straight ahead and then turn left.	Идите прямо, а затем поверните налево	audio/sentence_go_straight_693b2b93.mp3
6a0cdfc2-2e25-41f7-b84a-8c88487a739a	aa016926-cc46-404f-aad4-65640e004db3	The shop is on your right.	Магазин справа	audio/sentence_the_shop_f2f6b70f.mp3
e2ce4044-76af-4397-b189-4b9ac5111c58	350c7464-f347-41ab-98b1-df27a88b23ed	The cafe is next to the bank.	Кафе находится рядом с банком	audio/sentence_the_cafe_80e0112e.mp3
bf8adcb9-6b34-4fdf-8ab5-844563cf165a	1fbeab42-215e-49c6-950e-065916facd09	The post office is opposite the station.	Почта находится напротив вокзала	audio/sentence_the_post_d00b2414.mp3
f29d6a13-ba99-4ce0-91e4-f5783e161f91	b1549c3f-b4e0-450e-813f-471330cca797	The park is across from the library.	Парк находится напротив библиотеки	audio/sentence_the_park_8cb34f29.mp3
2cc80173-bce9-4455-837d-f543b4a609a6	3990a248-d295-461a-b5da-4d59d7bcf78d	There are several restaurants in the vicinity.	Вблизи есть несколько ресторанов	audio/sentence_there_are_b1c21124.mp3
5e37e075-edff-4c09-89a7-75d0dc516ee4	d48ca275-45ea-4b42-9c56-d4ca05eb4d81	There's a supermarket close by.	Рядом есть супермаркет	audio/sentence_there's_a_361d7699.mp3
0b45f0b0-a7e7-4aef-8f30-512929ea4085	5cf8fcd9-7a20-4a06-b77b-ce6cc29b0659	There's a hotel nearby.	Рядом есть отель	audio/sentence_there's_a_bd3cd69d.mp3
efb6b455-6e8f-4e7c-a557-539a38a174e1	c5ee244e-fd64-4217-8a95-fbf328f2f6fa	You'll see a signpost a little further on.	Вы увидите указатель чуть дальше	audio/sentence_you'll_see_0b3976fd.mp3
8c51ffa8-f4a1-477c-b7df-98afd335b0a2	bce03f39-095a-4b9f-9d06-709ebea0d713	The bakery is just around the corner.	Пекарня находится прямо за углом	audio/sentence_the_bakery_62b38966.mp3
66da9dd3-8946-48d2-bef1-63f2ec0fcdf7	8cf3d112-c4e5-423f-a362-810036b1d9ba	It's easy to find the station.	Вокзал легко найти	audio/sentence_it's_easy_7c7ab68a.mp3
5d10dab8-b5a3-4996-be87-b152638a1f58	e3062951-3e26-4533-819c-95a78a6096da	It's a bit hard to find the museum.	Музей немного сложно найти	audio/sentence_it's_a_491e5a25.mp3
81895c43-7b65-4048-8420-aa260192d846	7d9b4fa0-33fa-4d39-b5c1-8dcb79626e0b	Don't get lost!	Не заблудитесь!	audio/sentence_don't_get_4fd6269e.mp3
aa0d1497-d361-4f88-b4b4-9ec2fb2ac468	96466de0-da42-4f6a-b3a6-d74ef56d5700	Find your way to the main square.	Найдите дорогу до главной площади	audio/sentence_find_your_0ff23235.mp3
af8efd03-79d1-4a8e-847e-0f90ed30539a	92dae254-24bd-4ac3-a589-e0cbcb950380	Follow the signs to the airport.	Следуйте указателям до аэропорта	audio/sentence_follow_the_d8737e87.mp3
35d6c6eb-3849-4285-8bd9-a36cbe8388b3	94ff7ffb-43f9-461f-8a58-9d0701984940	Follow this path to the lake.	Следуйте этой тропой к озеру	audio/sentence_follow_this_b00a941d.mp3
3199a150-5d94-4f7d-85b0-85c1f90bbe25	aa645cd1-ab73-461c-9f4e-ea1266487ce1	How far is the train station from here?	Как далеко отсюда железнодорожный вокзал?	audio/sentence_how_far_2c88ec1b.mp3
7d4c3221-8353-46e8-b67d-add578129c75	ab6b64e5-9378-4767-832b-dde2e4e71451	How long does it take to get to the city centre?	Сколько времени занимает дорога до центра города?	audio/sentence_how_long_9aa87b4f.mp3
1ff2234e-8743-4e66-ade0-fadf7c941457	eed4bc79-435b-4772-95d8-235782f6757a	What's the distance to the airport?	Какое расстояние до аэропорта?	audio/sentence_what's_the_c247d6b6.mp3
a83a2a6f-f8d1-449c-9e20-68ed44d8c2b2	03f62d3a-1f03-4cc3-9a73-dae0b6db0987	It takes about 30 minutes by bus	Это занимает около 30 минут на автобусе	audio/sentence_it_takes_f87f4013.mp3
9bd1f8c8-8a26-4b5d-b550-abbb05758b39	ba5ba939-c7bd-4ec3-9d9a-9d5c8140ceaa	It's about 10 kilometers	Это примерно 10 километров	audio/sentence_it's_about_b34387d4.mp3
0f5d3a21-2af4-49b8-bff3-6825a1ec5274	1a32e139-a02a-4c3a-a5da-89fe59696a53	It takes 15 minutes by taxi	Это занимает 15 минут на такси	audio/sentence_it_takes_b010dfd2.mp3
a51769da-7469-4386-9bf6-b6153a69976e	9efae393-0a7c-4bbc-a12a-a32b107a7620	It's 5 kilometers from here	Отсюда 5 километров	audio/sentence_it's_5_7486ed0b.mp3
e7c81b0b-503d-465e-9cab-b44a12995967	bfc24771-4a1b-41a6-bb11-0dffbdde933f	The taxi ride was expensive	Поездка на такси была дорогой	audio/sentence_the_taxi_019ee8fe.mp3
7e66867d-b35c-4804-b199-30e3a1a5149e	424e9062-17ef-4e57-b731-65d212e67ebc	The bus ride was long	Поездка на автобусе была долгой	audio/sentence_the_bus_2f17a490.mp3
58998247-908d-4002-a909-31139310bdad	c515a55a-d004-4fe9-ae99-5247b28d828c	The train journey was comfortable	Поездка на поезде была комфортной	audio/sentence_the_train_befc8c78.mp3
73dea3d7-c8d5-431f-8c29-fcac575988b3	d665e18c-7c58-4c11-b79a-5edac13473a1	The hotel is within walking distance	Отель находится в пешей доступности	audio/sentence_the_hotel_cc437a53.mp3
a4207fd8-e17a-4668-867c-b25b508d2d0e	a3dbe089-45d4-4ec3-b3de-b1f968e85a38	It's a short walk from here	Это недалеко отсюда, можно дойти пешком	audio/sentence_it's_a_aae372f0.mp3
ee6da08c-6326-4671-9e07-fe9d03fcf145	fec2afac-9539-4845-8720-ef3725f48c25	It's a little far to walk	Немного далеко идти пешком	audio/sentence_it's_a_611f6df1.mp3
2e39e2d4-99fe-4232-ba4f-e8efd4488492	cbe10056-074e-4043-b152-a66c9da16d06	It's quite far from the airport	Довольно далеко от аэропорта	audio/sentence_it's_quite_37c5ec41.mp3
86d0b9b6-8a93-4b28-a945-8baf669a827c	8abddd54-5150-4325-b01c-6e134a59698d	Is there a pharmacy nearby?	Есть ли аптека рядом?	audio/sentence_is_there_ba413372.mp3
372c638e-c8d6-4609-9c6a-a085d0f2493e	4a79e000-9a51-4e27-9e21-afa53c48d2de	The hotel is close to the train station	Отель находится близко к железнодорожному вокзалу	audio/sentence_the_hotel_504d751d.mp3
f0e967b4-7874-4d6f-9c89-910c95d05cc3	9d9b684f-2da4-4004-b1db-753e0f6bdd99	The museum is far from the city center	Музей находится далеко от центра города	audio/sentence_the_museum_429d2c89.mp3
79bf210d-3561-44d6-aca1-3144bf08cb36	2f835197-a2fe-4ec2-b3bd-c532a6b5e2b1	Is there a direct route to the hotel?	Есть ли прямой маршрут до отеля?	audio/sentence_is_there_922a8f50.mp3
7070855d-8507-493e-8c4d-b6388f174690	a4a19323-2c95-4c7f-9d7d-d3dc44b64dfc	The city center is easy to get to	До центра города легко добраться	audio/sentence_the_city_c8b6bded.mp3
cfc5c60f-3a36-4f5b-af22-be28bb9bf829	1abd26cd-b5a9-4206-98b9-093fb33b2141	The museum is difficult to reach by public transport	До музея трудно добраться общественным транспортом	audio/sentence_the_museum_dac7b6aa.mp3
112924ea-7445-4034-9e08-38d804be9826	8f042be9-9571-49ed-875b-0ab7005732f3	How can I get there by bus?	Как я могу добраться туда на автобусе?	audio/sentence_how_can_c171b3c8.mp3
586233ef-8db2-4d21-9b9d-63ee5166b775	9852f08d-98b7-43fc-b12d-7eb2cf7351d9	Could you tell me how to get to the station?	Не могли бы вы сказать, как добраться до станции?	audio/sentence_could_you_f09df453.mp3
fe0f45a7-1616-414c-8416-db43421b16f1	8e3a1565-fbc7-4c7d-9d62-f8546ac63274	It will take approximately 20 minutes	Это займет приблизительно 20 минут	audio/sentence_it_will_00a6c583.mp3
1a196004-ab7e-43d7-8b2a-53b47b8e1923	2c8da61e-9987-4cbb-9030-ad28cc38180f	There are several hotels in the vicinity	В окрестностях есть несколько отелей	audio/sentence_there_are_0333d651.mp3
93746dc9-51d4-482c-b3e7-bf08ba84873b	5f240505-0484-4ffa-b872-32d89383ad6f	The hotel is conveniently located near the airport	Отель удобно расположен рядом с аэропортом	audio/sentence_the_hotel_e1254bb9.mp3
1a037c6a-d0dc-42eb-80a1-29d4c4780ba3	71f17b1a-60ec-4d6c-b1fe-5dfd8b544662	The supermarket is within easy reach	Супермаркет находится в пределах досягаемости	audio/sentence_the_supermarket_f4b5e9ed.mp3
3dc93b62-dd47-45a9-956f-028e4fc3d2b5	f9ae85d6-17a0-4b4f-bcbc-47641626f32d	The hotel's proximity to the beach is a plus	Близость отеля к пляжу - это плюс	audio/sentence_the_hotel's_02e030a7.mp3
8a509f1d-2b14-4d21-a244-8aa48d736690	f8cd7ce8-0aaf-4724-b80f-b5e16eddf571	The house is within commuting distance of my work	Дом находится в пределах досягаемости для ежедневных поездок на работу	audio/sentence_the_house_0bd94f6a.mp3
0d13270e-2968-4a2a-a1a2-c3b7177b0f35	8a4f4d61-21fe-4a82-b2d0-a01e7e9a5cf6	Can I see the menu, please?	Можете показать меню, пожалуйста?	audio/sentence_can_i_06274c2e.mp3
8c7a3492-5950-427b-8df1-08c42dda0fbb	64914d04-5a57-4d9d-bb57-3e925f32e9c7	I'd like to order the pasta	Я хотел бы заказать пасту	audio/sentence_i'd_like_a15ffbd8.mp3
ae3d0b7a-8cf1-49be-a07f-dce34322f42d	c8d6e100-2479-4816-844d-fe8e7c2931b1	What kind of food do you have?	Какая у вас еда?	audio/sentence_what_kind_9305a525.mp3
682c3511-5117-4fa1-98ba-8dedd694bda4	2665401a-5ee8-4e5c-a542-082a1d77b48c	What drinks do you have?	Какие у вас напитки?	audio/sentence_what_drinks_2839823c.mp3
e8eb6699-9dff-4bd2-a62a-bd5ade1c66be	0a16dbb0-bfdb-4522-bbda-a74e186e8f6d	Can we have the bill, please?	Можно нам счёт, пожалуйста?	audio/sentence_can_we_32ba17e8.mp3
52ef1ea8-6f03-4774-9500-a88caf5f8a6a	8041378a-1d6e-4ece-9735-299465e0e621	It's time to pay the bill	Время платить счёт	audio/sentence_it's_time_ac89a937.mp3
888f8811-821f-4395-a2a2-faf5244b983f	e379c1c8-a001-4249-becb-fcd1d65dec55	Excuse me, waiter?	Извините, официант?	audio/sentence_excuse_me,_18b8f241.mp3
65ec7282-ac69-47f3-9714-b5377a4b9c50	1c1b09d2-622f-44be-9871-1b53abadecf5	We need a table for two	Нам нужен столик на двоих	audio/sentence_we_need_1f2a6486.mp3
5fbf89b1-02bd-427d-b059-cbe2dd01415e	4fd401c3-f068-47cc-9480-c5d217e8779c	I'd like to take away this food	Я бы хотел взять эту еду с собой	audio/sentence_i'd_like_169cb435.mp3
8388e6fc-05af-4360-b479-a2d929eb05ef	19fe742e-5561-43cb-880a-58b2b982e3a5	Coffee to go, please	Кофе на вынос, пожалуйста	audio/sentence_coffee_to_220eb2a4.mp3
ceabc8b3-ccfe-4e14-85b9-40e6fa11f717	1418c76a-2ced-4063-8465-60937e5d497e	What is the daily special?	Какое блюдо дня?	audio/sentence_what_is_d83dbce3.mp3
8668cd99-4109-47dd-962d-571c9efb4db1	a3a38bfe-3c3e-4222-a5ad-ba4d391088ca	I'll start with an appetizer	Я начну с закуски	audio/sentence_i'll_start_ae1374a4.mp3
6e9eb5ec-e972-41ac-a3e9-09b225fa3dc7	1b165739-ad0d-4269-ab41-bce936cc5de4	What's your main course?	Что вы будете заказывать как главное блюдо?	audio/sentence_what's_your_836c570e.mp3
1f2943ff-f01d-476f-b0f0-4c94cadadf2c	a33570b0-0f35-4791-8a12-5aaa49dcba5e	I'll have the dessert menu, please	Пожалуйста, меню десертов	audio/sentence_i'll_have_60fca77a.mp3
ff145d99-3b81-412d-b7cf-f1928d447b86	c703a63e-9f7a-4c08-8f1b-5424a3d499ff	I can't decide, what to pick	Не могу решить, что выбрать	audio/sentence_i_can't_0845883d.mp3
efea34eb-2f8f-4854-81b5-5815aa130f9c	4bf2f6ef-c73e-4812-85f1-6e1bf7603b1b	The food was delicious!	Еда была вкусной!	audio/sentence_the_food_4f31c27c.mp3
21dda451-7c10-41bb-ae63-33724f7a2167	d84c39e1-50e8-432a-bd35-370d00c0e9e9	This cake is so tasty!	Этот торт такой вкусный!	audio/sentence_this_cake_129ae1c2.mp3
dcbc7041-c904-4716-8e4e-ed1b9f248894	b000f714-f6a8-4b65-8792-f18dadaed80b	Can I taste this?	Могу я это попробовать?	audio/sentence_can_i_96445014.mp3
ebac89f0-df3d-4e81-9691-56dc2bb7bf6d	40951d69-b587-4a1a-b600-e69f42ba78ce	I'm so hungry!	Я так голоден!	audio/sentence_i'm_so_eff3c067.mp3
6de36566-1978-41de-9fa1-4bf387278540	3e893bb2-71e1-4ddd-9720-3a96b329c8dd	I'm very thirsty	Я очень хочу пить	audio/sentence_i'm_very_1d4acc0c.mp3
f1281b11-827c-4e86-88b9-388ef8edb288	a6ab8a51-8b34-4539-b8f3-d2025ca1df62	Can you recommend something?	Можете что-нибудь посоветовать?	audio/sentence_can_you_69b24f4b.mp3
84485f67-5c24-40a7-9c56-d1a4c96d5107	da466f96-1830-426f-9554-b398194fa25d	Do you have a reservation?	У вас есть бронь?	audio/sentence_do_you_1086018b.mp3
f6262234-294e-4e50-a9da-3d84ca7493db	83568b0d-a1de-44dd-890a-c065395663d4	Here's your tip	Вот ваши чаевые	audio/sentence_here's_your_35786afa.mp3
3c11cca5-7439-408e-91ee-3eda2b5a905f	19c125c0-5954-4929-bfe2-320beeff383e	I'll pay by credit card	Я заплачу кредитной картой	audio/sentence_i'll_pay_f1975f72.mp3
0ebbd32e-b1c9-4369-a2b0-3ef53a31b180	18887aa0-fbe0-44c9-af76-4e0a323eb564	I'll pay cash	Я заплачу наличными	audio/sentence_i'll_pay_e0a90585.mp3
6da16d58-b76b-4d16-b083-0cbdd42fa83c	0e24910e-fd2f-4e1c-a1a1-4badac85091f	Can I see the menu, please?	Могу ли я посмотреть меню, пожалуйста?	audio/sentence_can_i_08d0fa9e.mp3
0e22df9b-c743-495f-a888-53fc688f4ca7	ce93ed16-15ff-4456-a8d0-0a8eb20605bf	What kind of food do you have?	Какую еду вы предлагаете?	audio/sentence_what_kind_ecd65e1e.mp3
67fe138e-a6b0-4c2e-9f0c-561fa0aa50db	2e88990d-ea1a-4f29-a57c-9adf32342af2	What are your special dishes?	Какие у вас фирменные блюда?	audio/sentence_what_are_4cf567a6.mp3
4e75ff48-a8f0-4e56-a46c-9270bf73c090	2e03f0f4-2acf-4dc0-b69d-0cd3b146c7e2	Do you have any appetizers?	У вас есть закуски?	audio/sentence_do_you_10cca859.mp3
d002760a-f6aa-49ed-a12d-4ed7abd90c70	c43d892a-f4ba-4759-9f99-24172dcef042	What are your main courses today?	Какие у вас сегодня основные блюда?	audio/sentence_what_are_45b52fd6.mp3
779d1f17-b1e2-4b49-bbfb-2db9923f0af8	d01a12b0-efc8-412f-b5ff-1a30a661f283	What do you recommend for dessert?	Что вы порекомендуете на десерт?	audio/sentence_what_do_19696bec.mp3
83791718-8172-4deb-b980-5f8af95e7e88	8c79c9cd-2ddf-490b-a49c-9f31427f27eb	What drinks do you have?	Какие у вас напитки?	audio/sentence_what_drinks_3e2dafd1.mp3
a3f4eb8b-43ec-4b6e-ac3a-5615deefaaa3	aceb2a7a-c2cf-497c-9ba4-d6e667216b46	May I see the wine list?	Могу ли я посмотреть винную карту?	audio/sentence_may_i_a487d1d9.mp3
e04a80bc-c945-4b0e-b167-f53323e76a11	641b227f-e566-483c-8945-bd2a4919cda4	Do you have any specials today?	У вас есть сегодня какие-нибудь специальные предложения?	audio/sentence_do_you_5e86c11f.mp3
c7a9849b-e365-44bd-af16-22d76dc7217e	0b6f21ce-e7e7-4ba8-8a7f-cdf935cca8c1	Do you have any vegetarian options?	У вас есть вегетарианские блюда?	audio/sentence_do_you_57e14b94.mp3
cbccd730-4c5a-4dc1-a53d-591cf6a8d92f	f8cbe5cd-1338-4a28-88c4-ecad37fe382b	Is this dish spicy?	Это блюдо острое?	audio/sentence_is_this_63afd097.mp3
554289fc-7370-47bd-9b85-9c131eb26e0b	decd45da-062a-46f7-ad09-11682c069b20	I have a seafood allergy	У меня аллергия на морепродукты	audio/sentence_i_have_33d13297.mp3
8841fb3a-2cfb-4cd1-9861-055ee1a1b010	f543e35e-f480-4f6e-8049-28ef8c087ab9	Can you recommend something?	Вы можете что-нибудь порекомендовать?	audio/sentence_can_you_f2c16472.mp3
ae5d8922-0f44-46a2-9050-d3aa53749bab	75b95c85-f24a-4504-953d-313c5eaf3ae6	I'd like to order the pasta	Я хотел бы заказать пасту	audio/sentence_i'd_like_a4417da6.mp3
e1a3168f-f0b9-4983-8d4e-b9315e32ef48	97022bfd-0268-40e9-80d2-b5c35e65c94d	I'll take the fish	Я возьму рыбу	audio/sentence_i'll_take_acf99ba9.mp3
92b4ccb0-1737-4c17-9455-422fd1efd4fa	05eb566f-b339-47b7-ac07-206b20552228	Can I have the bill, please?	Можно счёт, пожалуйста?	audio/sentence_can_i_94ac46e5.mp3
72543d7a-7f8d-403e-bbf5-fdeddcb6e916	4e12bc9d-4a91-4b5a-86a6-69d7c50c45ea	Here's your check	Вот ваш чек	audio/sentence_here's_your_933e4f70.mp3
8a3ce6e6-7c34-49c7-96f8-71f9999a586e	1909eb65-3790-47e4-a30c-cb5d0c8b5525	This is delicious!	Это очень вкусно!	audio/sentence_this_is_3268a509.mp3
beb8a99c-868d-42f0-8a01-85c316c62e90	6ec1dd7d-5fe1-404d-987b-3d568d4087d8	It's very tasty	Это очень вкусно!	audio/sentence_it's_very_47a3df4e.mp3
f0f44e99-8905-4aa7-af90-df6e0cb0e759	ffcda9eb-7a3f-4938-9395-82014f69cfee	This is quite expensive!	Это довольно дорого!	audio/sentence_this_is_05c038c5.mp3
a45df212-a47e-4297-a3b5-7ff4795184e6	52ab866d-4d25-4de5-be35-ba1084d161ad	The prices are reasonable	Цены приемлемые	audio/sentence_the_prices_86ad0358.mp3
60b4f7dd-eebe-45ee-859c-fe3f38ab66d8	2cb98cf0-ee80-4e13-92ca-0f70985bea47	How much is the pizza?	Сколько стоит пицца?	audio/sentence_how_much_eb0dfb6c.mp3
4b97526d-ac9a-442f-87a7-fd79cdc6dfd3	b9223024-e4a4-412b-bad5-3000af20f3d7	Excuse me, waiter?	Извините, официант?	audio/sentence_excuse_me,_f95d5ea8.mp3
e1db2ec8-69e4-4a89-9ad7-a088bcb0a5db	7d7a4244-5fe7-4930-a564-0a33b7f876e3	Waiter!	Официант!	audio/sentence_waiter!_e0a1c8b1.mp3
6288f68c-f061-4294-bf75-4d133945ee49	18866058-cfa9-4db7-811e-af49a47c4aa4	Could I have some water, please?	Могу ли я получить воды, пожалуйста?	audio/sentence_could_i_f4b3db47.mp3
57f61af3-2051-415f-8242-3231003e5711	b20170be-5405-47ce-a367-dc01ca94b488	I have a serious nut allergy	У меня серьёзная аллергия на орехи	audio/sentence_i_have_d8367215.mp3
2dac5fdb-3586-4cf2-911f-2f296f17d418	fe19b85e-4c9d-4d8a-8789-d1c4aec50f7d	Do you have any gluten-free options?	У вас есть какие-нибудь безглютеновые варианты?	audio/sentence_do_you_9beb3fc2.mp3
836801a4-462d-4e68-b64c-75f9ecd64fe3	72a455b7-1375-496e-9ac6-0524512beb89	I need a dairy-free dessert	Мне нужен десерт без молочных продуктов	audio/sentence_i_need_9653d77a.mp3
c204fb94-c9b9-4048-b8de-fe3cefbf9054	a7dcdd2f-d367-4088-a2cf-23d4b6308865	Where can I find halal food?	Где я могу найти халяльную еду?	audio/sentence_where_can_92a3fea4.mp3
4e59bae3-66f9-4496-aed8-73025d1dbe3a	ca059f23-6b89-44d5-887a-2e258f6f6006	Is there a kosher restaurant nearby?	Рядом есть кошерный ресторан?	audio/sentence_is_there_a7043666.mp3
848127dd-7187-45e7-a165-809bbda63223	c068c0d0-cd5c-4bca-99b0-58a30abb0717	I have a food intolerance to shellfish	У меня непереносимость морепродуктов	audio/sentence_i_have_68ab1572.mp3
b6240f94-8ca8-4610-b3ff-6c012273f23a	9216568f-fdd9-48c5-9d12-b79bd2a01fb6	I have some special dietary requirements	У меня есть особые диетические требования	audio/sentence_i_have_c531b5d2.mp3
f13bdfde-dc11-43b2-a066-323ecc3ead82	074f615f-05f7-4b02-8e47-571f8f68ecfe	Can you accommodate my dietary needs?	Вы можете учесть мои диетические потребности?	audio/sentence_can_you_22c648e8.mp3
cb83ff6e-c391-4249-8700-ae43bdf65a01	98807e01-1bb4-4b2d-a72d-a4c355d5fe02	What's the in-flight catering like?	Какое питание на борту?	audio/sentence_what's_the_b66a187d.mp3
ce305861-36df-48ae-8f66-295d812c7ccc	ab82dd0b-c70c-49c2-8fc9-5bef9001f870	Is there a restaurant in the airport?	В аэропорту есть ресторан?	audio/sentence_is_there_b755456a.mp3
009cf788-a68f-40a0-9db7-9f84b3a9cf61	14597bd2-be76-43ba-a90d-c4c5d19b4d5c	Can I see the menu, please?	Можно посмотреть меню, пожалуйста?	audio/sentence_can_i_19c606ab.mp3
a2c54bfe-23fa-48a5-ae36-9b2ea4ecad4c	07c5bf6b-2dfd-4e99-925f-bba5b403536e	I'd like to order a sandwich	Я хотел бы заказать бутерброд?	audio/sentence_i'd_like_b8bd0a1a.mp3
cb6d0751-e6a7-4e8f-b5d4-ddb3142ac9fd	7ea03ef9-503a-43d6-830d-4e09fdee09c6	Can I have the bill, please?	Можно счет, пожалуйста?	audio/sentence_can_i_0f0e6dbb.mp3
7fa88829-64d0-415b-8198-57d223ff3ac2	9f3b96a7-8894-44b7-a2fc-d926985e64e2	Should I leave a tip?	Стоит ли оставлять чаевые?	audio/sentence_should_i_99b29824.mp3
c6780c26-126f-4cd8-8e9d-7e7dfc8b82a5	753c90c7-ce2a-477c-b3c8-ec9c6ee907ee	I need to find out where the restaurants are	Мне нужно узнать, где находятся рестораны	audio/sentence_i_need_d9cd3331.mp3
a0c7d8ed-9d53-46b7-8c4e-fa31480e2191	86f13010-3e27-4f96-bf32-45a214ba3b13	I'm looking for a vegetarian restaurant	Я ищу вегетарианский ресторан	audio/sentence_i'm_looking_4f26e5e6.mp3
2ae2ab2d-92c5-40e2-b783-a418e85974eb	57b6bb69-a2db-46ae-aaae-db8fa3925474	Let me check the menu	Позвольте мне проверить меню	audio/sentence_let_me_eb0199d1.mp3
d0d795de-eceb-4b1a-bc4d-aac1129339ab	83beb652-5280-4360-a685-4436fcf75af2	Do you have any vegetarian options?	У вас есть вегетарианские варианты?	audio/sentence_do_you_e73d81bb.mp3
d26b4957-f505-40df-b1df-5567ab944228	948da67b-8e6a-47d3-b00c-aefecd6bfa97	I need a gluten-free meal	Мне нужна безглютеновая еда	audio/sentence_i_need_c6ed2996.mp3
4b3ae966-b63c-4160-9b32-b468249d7d42	dfdb0430-20cb-4616-90cc-1b35915f8cbc	I want something to eat	Я хочу что-нибудь поесть	audio/sentence_i_want_8ba248a7.mp3
9606194c-5fb1-4fa4-a29d-13e94d3f01a3	38add3a8-4eb9-4239-bf1f-c83519d04098	I like this restaurant	Мне нравится этот ресторан	audio/sentence_i_like_955aa157.mp3
b31895e9-97f9-4ccb-95ae-c88291716392	01e0de86-d792-4a1b-814d-792adfd8a5bd	I'm sorry, I don't understand	Извини, я не понимаю	audio/sentence_i'm_sorry,_a92c6f6c.mp3
d171996f-75c1-470f-a900-c8e8504530a3	e33298d4-f60d-413d-a3a2-8225bc5bec4d	Excuse me, where's the restaurant?	Извините, где находится ресторан?	audio/sentence_excuse_me,_da540123.mp3
020cd884-dbc4-4e3e-abde-fba4f1c455b8	08c18b13-3a8b-468a-b7a0-edb0e00ff88b	Please speak slowly	Пожалуйста, говорите помедленнее	audio/sentence_please_speak_12e30c5d.mp3
00ddbf66-42e5-4316-b580-db5151d3b5a6	202077a2-1d84-44e7-94ed-2b37708f5c81	Thank you for your help	Спасибо за помощь	audio/sentence_thank_you_f0f82423.mp3
a4e9c1d6-ad31-4bce-8aaf-4d1ec01f696e	a450d55f-b76a-4c3d-b045-38e4e88964b0	Can we see the bill, please?	Можно посмотреть счёт, пожалуйста?	audio/sentence_can_we_49634900.mp3
509eaecd-4e9f-47ef-8e7e-53b22dc4a7a1	5d6da8d0-bcca-4bde-8937-498230d994c3	We need to pay the bill before we leave	Нам нужно оплатить счёт, прежде чем мы уйдём	audio/sentence_we_need_a19c19e7.mp3
f66684ae-64da-40b1-913a-e94e28fbcf34	095cb51e-e256-4201-a36e-90ade3b6f54a	Let's split the bill equally	Давайте разделим счёт поровну	audio/sentence_let's_split_d31951cb.mp3
9e0d5646-fb8c-4c8d-ac16-7428f9d1c785	4f7d6aab-4333-4631-91d2-74bb2099e3b6	We decided to go Dutch on dinner	Мы решили разделиться поровну за ужин	audio/sentence_we_decided_b9466dbf.mp3
900c0891-b90d-479e-95d9-dd51a53717ff	9402b12d-2288-482c-9551-4bebdb2860a1	We should leave a tip for the waiter	Мы должны оставить чаевые официанту	audio/sentence_we_should_0b7893c5.mp3
7f317694-9594-4496-b946-0d8962741c6d	ae6c531a-d58d-4fc1-8553-5ed2b186b991	The service charge is included in the bill	Плата за обслуживание включена в счёт	audio/sentence_the_service_8c77acbb.mp3
4dbc5aaf-c2f7-44ad-ad76-d70554829a7e	0c5e3a1c-67f1-4af7-bbe3-a01b15473f66	Can you add up the bill, please?	Вы можете подсчитать счёт, пожалуйста?	audio/sentence_can_you_43fa8d3a.mp3
2ab322e3-e8e8-421c-8b0c-cd8aaaaef044	2f87f282-7f75-4637-a507-a40433e9aae7	What's the total?	Сколько всего?	audio/sentence_what's_the_abd5bde9.mp3
c93a7717-1b5c-4b19-b2d9-2d3f846906ba	056f9509-b636-4b7c-b323-9c210bc85914	I'll pay with my credit card	Я заплачу кредитной картой	audio/sentence_i'll_pay_8c82fdc8.mp3
f416b905-35c6-4b2e-8ebc-a927528e2594	966bce46-4e13-4fe6-b526-6179e7655619	Do you accept debit cards?	Вы принимаете дебетовые карты?	audio/sentence_do_you_bce03f2f.mp3
02c90eec-742e-4932-a625-92877b3eed41	f9ffb8c1-d497-4270-b845-3cb1891ded63	I'll pay in cash	Я заплачу наличными	audio/sentence_i'll_pay_42f90e4b.mp3
eb53e7ba-6485-40cf-94d2-7d12502f560f	1f414f5d-f137-4c5c-8a0a-05e36ac9c218	Could we have separate bills, please?	Можно нам отдельные счета, пожалуйста?	audio/sentence_could_we_4713fe0d.mp3
699cc2e4-b05f-4de4-b1b2-02982ae0854f	5451cbf4-0ae6-4b1c-9e3a-e627a148ec62	This restaurant is very expensive	Этот ресторан очень дорогой	audio/sentence_this_restaurant_2df1ef99.mp3
480e302b-a286-44fa-bed1-1741ecdf5c85	3ea2c79c-0e8a-490a-b519-4853a7ccc231	The prices were very reasonable	Цены были очень разумные	audio/sentence_the_prices_e3e4eb0c.mp3
75e23790-fed4-435d-9e5e-faf7f89ed27f	11fe0475-1235-4f0a-b0a8-dac3ab7aa573	I think this meal is overpriced	Я думаю, что эта еда слишком дорогая	audio/sentence_i_think_762758e3.mp3
761e9b1c-a1a3-44e4-8c4b-0e578068e34d	92ff759c-826a-41e1-aa1b-578d3e315992	The food was absolutely delicious	Еда была совершенно вкусной	audio/sentence_the_food_eefdbaa4.mp3
72e333f9-21e3-4a93-b4b5-7f7a2f6fd518	1b9e3ace-de08-4e02-87f7-555aa66545f5	The high price was worth it	Высокая цена стоила того	audio/sentence_the_high_91d928b5.mp3
58ae2099-9bc4-431c-a05a-6d3dceddcc92	c0c28b23-ec3d-4c49-91c8-d0247fe06a2b	We need to find an affordable restaurant	Нам нужно найти доступный ресторан	audio/sentence_we_need_ea304f14.mp3
b4a4ddb4-a9ed-4a58-8ba1-83a6beebb2f6	ff69412a-4dc7-4493-b378-8ca702b93a5a	The food was really tasty	Еда была очень вкусной	audio/sentence_the_food_63ac09ad.mp3
e042cef0-5254-45c5-a867-727f314d30ec	03efc9f0-1b9f-4df7-822a-41ea745ea24f	That cake looked scrumptious	Тот торт выглядел изысканным	audio/sentence_that_cake_99c505f8.mp3
240a5e7e-5fc3-4066-b739-3b6672c8323b	96432221-c225-43ce-b48f-550e1f77979f	The meal was good value for its reasonable price	Еда была хорошей ценностью за её разумную цену	audio/sentence_the_meal_996a647d.mp3
981a1680-8b62-4354-8e1d-a225b8ab503e	ba4ef72e-04a0-4f34-be81-82b7234c1532	This restaurant offers excellent value for money	Этот ресторан предлагает отличное соотношение цены и качества	audio/sentence_this_restaurant_41248cd1.mp3
557b3ca3-5142-4b86-8d27-090de1cec44d	d7b80514-3ec0-41d0-9cee-3a578e556cb6	The food was not bad	Еда была неплоха	audio/sentence_the_food_125c330a.mp3
bfeca373-5faf-4cb5-80a5-114ad1405be7	62ed7ac2-867f-41c2-bcb0-292d953637cd	Something is not quite right with my order.	Что-то не так с моим заказом	audio/sentence_something_is_9944cc62.mp3
645f164e-8c2a-464d-a3e6-eb4d3731876e	4dcaceb6-184f-4009-8717-c6d3a9effb29	Could you please replace this dish?	Не могли бы вы, пожалуйста, заменить это блюдо?	audio/sentence_could_you_e6a5bd3e.mp3
e09c72a4-6693-4329-8201-f6a82ae48b80	93eae01e-0ac5-4840-9e4d-6fd762a3c4dd	This is not what I ordered.	Это не то, что я заказывал	audio/sentence_this_is_5bd22402.mp3
3c543ab7-c801-49e9-af24-70901bd10882	a0c434b5-46cc-4299-9ea0-d897952371f8	This dish is wrong.	Это блюдо неправильное	audio/sentence_this_dish_433a2960.mp3
b772dea0-a706-41f9-8a76-09822367a666	c8278fde-4d54-4e72-9cf9-aa02d0ec3575	The fish is undercooked.	Рыба недоваренная	audio/sentence_the_fish_9dce915f.mp3
67fd1d6b-554d-4d39-977b-29cf4add6bbf	75d7a47d-e5e7-4b4d-b685-8690baf7561f	The vegetables are overcooked.	Овощи переварены	audio/sentence_the_vegetables_2c348662.mp3
ff93cf72-6e7a-4f02-949d-b45296c4d405	a6d045d3-2420-4adf-970f-1cce1d5c0b36	The soup is too salty.	Суп слишком солёный	audio/sentence_the_soup_09b1c182.mp3
00ffe175-f4ad-4fe4-9b85-291aa8091af4	b7ad989f-a70d-4307-bb85-83928d0449be	The curry is too spicy.	Карри слишком острое	audio/sentence_the_curry_46229fc1.mp3
0e6ac652-ddcc-474f-8f9a-0241e4cf8ce2	bcdc893d-7d58-4f9e-bcd7-36b18e99bf54	I'm not happy with the service.	Я недоволен обслуживанием	audio/sentence_i'm_not_a9ad3465.mp3
1f43ec60-fb0b-49e7-ba16-71b9f791e32a	d46a2abc-a1a8-4e29-97d4-854684a40dc8	I'm not satisfied with my meal.	Я не удовлетворён своим обедом	audio/sentence_i'm_not_057186a9.mp3
a7e2814d-a35e-45c4-a8da-0d20e5fb2d91	265afb2d-d92d-44a1-856c-f8c108679e01	I'm disappointed with the quality of the food.	Я разочарован качеством еды	audio/sentence_i'm_disappointed_7b16241f.mp3
f51727f2-4ee8-465b-872a-35728ece7a14	152dd15e-749f-4f2b-8531-6771e1722bf4	I would like a refund, please.	Я хотел бы получить возврат денег, пожалуйста	audio/sentence_i_would_03f56081.mp3
0b87b41b-fdcd-42a0-9bc7-f35bc6c02a01	57df382e-ff99-4811-8af2-f7ac972bdf3a	I'd like a replacement.	Я хотел бы замену	audio/sentence_i'd_like_8ab3747f.mp3
b68af160-1821-4843-94ac-56a7abb3472e	80da7cc9-c2c8-4c69-8258-8a66600c4e31	I'm sorry to bother you, but...	Извините, что беспокою вас, но...	audio/sentence_i'm_sorry_00a51137.mp3
73c0836b-9ac7-4435-b56d-e4b70e58baa9	7376d671-260c-4ee5-a65c-7dfc98976d29	Excuse me, waiter?	Извините, официант?	audio/sentence_excuse_me,_b6aa1525.mp3
d1beeee2-38fa-47cf-9d89-f43b87a42c5b	1f8f66c6-8953-4f2c-912f-05ee9f8bd562	Waiter!	Официант!	audio/sentence_waiter!_f4fd3f49.mp3
096b90d5-d377-435c-8066-6727b4792541	16f47cf7-203a-43a9-88f8-6535347014a5	I need to complain about the service.	Мне нужно пожаловаться на обслуживание	audio/sentence_i_need_4eec0727.mp3
cbb87d48-4209-424a-8716-b372bdbab7e9	ee7c63a7-5d15-431f-9870-a03aca5c2808	Could you sort it out?	Вы могли бы это уладить?	audio/sentence_could_you_c9b7eec8.mp3
6e6c5616-288a-431a-be16-8417f8444921	34f3e9bb-8075-4eab-929b-e882d734bf49	I want to make a complaint.	Я хочу подать жалобу	audio/sentence_i_want_58fe5221.mp3
2b3f0b94-e436-4581-a9ec-3b51933d4a74	03fc33bd-360f-4ba6-936e-4cccc187bc52	I apologize for the inconvenience.	Приношу извинения за неудобства	audio/sentence_i_apologize_34b5ceae.mp3
63868655-0787-45ab-b99e-b2aafaf8c734	853f802d-ab46-42a4-9820-1ce2431e2cfb	I appreciate your help.	Я ценю вашу помощь	audio/sentence_i_appreciate_48d3066d.mp3
b24e3da7-9e28-44d1-8f72-e0f5623a1025	27184eea-7ae9-4e74-8955-e921fa3516a8	Thank you.	Спасибо	audio/sentence_thank_you._a15c80ea.mp3
5f095eec-9a75-4801-9479-4e2b2a61d7b6	208a1a5f-9c0b-46d4-ac5e-042ffef875bd	Please.	Пожалуйста	audio/sentence_please._a0fca322.mp3
4fca0b01-be57-4209-87e4-6f861db5a688	21007b10-313a-4845-adcd-65beec3c3e91	Hello, how are you?	Привет, как дела?	audio/sentence_hello,_how_126e5c13.mp3
543c198c-99c2-4c7f-ae49-3d07a1545524	9635b0c3-5eb9-4b7a-9666-6b99271e481f	Hi there!	Привет!	audio/sentence_hi_there!_20294b41.mp3
1651ecc2-11e2-4a8d-b1d8-a68e0dfc5eb9	21dadc35-e71e-4135-aa52-9f93d8bbe6a7	Good morning, sir!	Доброе утро, сэр!	audio/sentence_good_morning,_da6e733b.mp3
61695c68-7cae-4ce6-a7d9-c16fd8669d5c	1f4b9e97-57a7-4160-a018-61be26edec78	Good evening!	Добрый вечер!	audio/sentence_good_evening!_89b0ce1d.mp3
a4dbf699-eec9-4fe9-aa02-67537f127e4d	6e03db33-ffc5-4d58-8e0b-a3b92e3ec136	Excuse me, do you speak English?	Извините, вы говорите по-английски?	audio/sentence_excuse_me,_e715c7fd.mp3
6e0a166a-5c4c-4cec-bb1c-c7755f0b51f5	50a726db-76cd-4695-b3c0-7d514778483c	Sorry, I didn't understand.	Извините, я не понял.	audio/sentence_sorry,_i_b97ad846.mp3
b74b48e4-3a4d-41e3-b72a-367808dc31f1	5a5a87fd-20a4-478f-a739-7eb6736ca96f	Please help me.	Пожалуйста, помогите мне.	audio/sentence_please_help_a54aea80.mp3
cc7b310f-036d-458e-ac8b-7afeeb1f2f00	31f43b8c-73fa-47b5-99f8-c230f516478b	Thank you very much!	Большое спасибо!	audio/sentence_thank_you_30120fdb.mp3
86fe25f4-4d2b-49d4-9bd9-bc4241cc21ae	bf3986f5-5cf2-4895-8410-4ca3321fb805	You're welcome!	Пожалуйста!	audio/sentence_you're_welcome!_238e29f3.mp3
57a3f1cd-e327-4190-abc9-a4672b66ac4c	576c3886-1859-4b7a-98bb-fdb9bc17b554	My name is John.	Меня зовут Джон.	audio/sentence_my_name_53f27251.mp3
dda2a821-3327-47ea-bcac-158b5d8597d3	ae056de5-431b-4c7c-b68b-e86266ca9d8e	I'm from America.	Я из Америки.	audio/sentence_i'm_from_0fca161e.mp3
34e6b9c8-1f31-478e-85de-5dc3e6f9fee6	7294aa5a-d751-47ab-98be-caf8410544c9	Where are you from?	Откуда вы?	audio/sentence_where_are_43b98655.mp3
57333d2c-c064-45cc-bbba-d800b5786d63	b02f7c98-a1c3-4df9-8336-42e3be06364d	Nice to meet you too!	Взаимно!	audio/sentence_nice_to_3b04b3a0.mp3
40791b05-208e-4a94-9e30-cea504531461	8b8008af-42de-4f39-a9d0-4cd965feda29	It's a pleasure to meet you.	Приятно познакомиться с вами.	audio/sentence_it's_a_3f838dbd.mp3
c37be436-34f6-42cf-af49-58ae82c28b3d	900b996b-c161-44b6-8c61-84022da725eb	How are you doing?	Как ваши дела?	audio/sentence_how_are_a7baa43c.mp3
f038b1cd-df8a-4f5a-b208-9386c8428604	961f8365-329e-42b7-ae1f-faadb2f5f28e	I'm fine, thank you.	Хорошо, спасибо.	audio/sentence_i'm_fine,_6dde2f0d.mp3
167cdc48-fb29-40fc-bd64-09546dbdfe1e	9824f4e1-8029-4c49-8fab-634d49f21682	And you?	А вы?	audio/sentence_and_you?_4343a0a1.mp3
08772bed-c996-43dd-af3a-79b87efde145	cd8020da-7dbb-4463-901b-72e5f41a4a01	Have a nice day!	Хорошего дня!	audio/sentence_have_a_f2ad5eb6.mp3
ac449aba-8f05-4e13-aa85-5acee8255bca	2362b91b-1c4b-4e75-9542-6c2b693858e0	Have a good flight!	Приятного полёта!	audio/sentence_have_a_e3c29a97.mp3
9a98a7c9-df77-4277-9cca-741d3bb1b0e4	e623a6da-7d47-4c2b-b956-20c7e8f91b37	See you later!	Увидимся позже!	audio/sentence_see_you_35df6901.mp3
4a3c9a7c-062c-44e9-9598-72a33a1b4ad8	1742ea74-0a87-4326-9d0a-caa888169bdd	Take care!	Берегите себя!	audio/sentence_take_care!_95223985.mp3
afa3c1dd-15a4-4bf4-9c0f-409249dde0a0	e013e45d-9226-47e1-8572-21853937517f	Could you help me with my bag?	Не могли бы вы мне помочь с моей сумкой?	audio/sentence_could_you_a712f7cb.mp3
fccd5edb-2dfc-4252-8153-df8f3ca70555	829d0226-7fb1-4f0d-b60c-ff5a31699a74	I need help with my luggage.	Мне нужна помощь с моим багажом	audio/sentence_i_need_1c7804be.mp3
2c6643b3-1b6f-4224-a8b4-17e877aa16ef	e708f8ee-e5fd-4ca0-9a80-d1a9a3cf077d	I don't understand what you're saying.	Я не понимаю, что вы говорите	audio/sentence_i_don't_32907907.mp3
a4940af9-90b3-4e59-ba3b-60600af02291	2f970c21-0567-4a71-b1f5-f5299b59d16b	What's your name?	Как вас зовут?	audio/sentence_what's_your_d967a79a.mp3
51d018f2-ae85-4028-8b0d-8d7670c742d3	7ec032d8-6fba-42ac-9443-108719ce86a9	Let me introduce myself, I'm John.	Разрешите представиться, меня зовут Джон	audio/sentence_let_me_ab20b024.mp3
309051d3-1786-49d6-bdac-cc0440ad6c55	46ea36b5-75cc-406a-90e9-b8b45fc5e2a9	Goodbye, it was nice meeting you!	До свидания, приятно было познакомиться	audio/sentence_goodbye,_it_34bb07ab.mp3
c5655925-d881-416a-8222-e69cb7a79ce4	b2116a43-2036-4ce4-b9b1-a3c2048abcec	Farewell, have a safe journey!	Прощай, счастливого пути	audio/sentence_farewell,_have_6d58c8a8.mp3
18231cdc-02a4-4cd6-879c-7b8b3324ea15	dcca3c6d-d6d8-4bc4-a1b6-374cce4f5e71	See you later, I'll miss you!	Увидимся позже, буду скучать по тебе	audio/sentence_see_you_2af88038.mp3
ec07ebc8-6db2-40fa-a7f1-40da703807ee	5949766a-f433-4a96-b734-a899bfa03bf4	See you soon, take care!	Увидимся скоро, береги себя	audio/sentence_see_you_e5e1d993.mp3
4b5d7d91-efba-4923-a97e-9d6e830ca5da	90b75259-8528-4c96-add6-c55f49a9ae5d	Take care, and have a good flight!	Береги себя и хорошего полёта	audio/sentence_take_care,_f2bc62f9.mp3
4ececa99-d050-47f7-bb48-c80c5eb4a1f1	739ad12c-9dae-4128-8638-c9bd20443665	Have a good flight and safe travels!	Хорошего полёта и счастливого пути	audio/sentence_have_a_d6c0e862.mp3
342b9410-b07a-425e-9ea9-4ecd09c165e7	611a7c11-b57c-4c79-a12f-41152a021b50	Safe travels, and I hope to see you again soon!	Счастливого пути, и надеюсь, скоро увидимся снова	audio/sentence_safe_travels,_5a1ffc27.mp3
e97d7e5a-1f95-4f8c-8c1d-d32dd7596bec	960f9f33-fc34-4be1-b33d-597c8c7261a9	All the best, and enjoy your trip!	Всего наилучшего, и приятной поездки	audio/sentence_all_the_67b99dd5.mp3
82f6058e-6850-4581-b0df-e685839c5f32	77b55a86-d753-4b90-bfd1-341475034d20	Best wishes for a wonderful vacation!	Всего хорошего для чудесного отдыха	audio/sentence_best_wishes_9e1210d2.mp3
a873f0a8-59f4-4a01-ab0e-29b1aa389782	77fc4789-6d56-4750-90bd-6c1110bea3ac	Catch you later, don't forget to call!	Увидимся позже, не забудь позвонить	audio/sentence_catch_you_1fa5321d.mp3
6d83a3d4-1048-4892-8b70-7fd51e120989	c883f9a4-577f-402f-9972-82079bd007fc	It was nice meeting you, I hope we'll meet again!	Приятно было познакомиться, надеюсь, мы снова встретимся	audio/sentence_it_was_571665f6.mp3
f0729ea4-9954-4655-a18b-58fbf39c8b22	fd7b2d12-85df-4d15-aa0c-9b31cb946840	It was a pleasure meeting you, I hope you have a great time!	Было приятно познакомиться, надеюсь, вы отлично проведёте время	audio/sentence_it_was_eeb99c11.mp3
5f9e6940-1bb9-4757-98ce-e1ff3c57f094	f39d0f53-d1a4-41d2-b0ce-dbe6a83f5f69	Have a great trip, and send us a postcard!	Хорошей поездки, и пришлите нам открытку	audio/sentence_have_a_310ab50f.mp3
0aeec295-da05-4bab-9e62-120d89dcbe96	73b235eb-785a-4e5c-b62e-605ef076b18b	Enjoy your flight, and have a safe arrival!	Приятного полёта, и безопасного приземления	audio/sentence_enjoy_your_a736fec1.mp3
de2b9f4e-b048-4cce-af2e-c2f5e7db8a48	dbc93b16-bf24-46ab-9087-28f337620f8b	Enjoy your journey and come back soon!	Приятного путешествия и возвращайтесь скорее	audio/sentence_enjoy_your_798c5a91.mp3
7710b6ab-bbfe-47a8-b0f8-f4be8248f2ff	67740bff-f902-4f49-b879-64911b58fa97	I hope to see you again, it's been a pleasure!	Надеюсь, мы снова увидимся, было очень приятно	audio/sentence_i_hope_27e4a259.mp3
9e680b9a-4313-4f55-a479-285f480e2d50	0116f31b-210e-41ca-874f-e4bff0b8de06	I'll miss you, but I'm happy for you!	Я буду скучать по тебе, но я рад за тебя	audio/sentence_i'll_miss_7061fb87.mp3
49cdafc0-a514-47cf-a8f9-18a1211bad24	3c939397-020b-4bc9-8a45-dfc9cb19cb1d	Hello, how are you today?	Привет, как у вас дела сегодня?	audio/sentence_hello,_how_ba958168.mp3
f451c15a-954a-4036-9fc3-c11c167c619e	886eb150-1b8e-49d9-a476-0f30f03eba35	Hi there!	Привет!	audio/sentence_hi_there!_20d03493.mp3
74b92685-a523-4b44-9a83-6a17b42357df	f0844c9b-5818-4203-9e25-9acd176d4e7b	Good morning, sir/madam!	Доброе утро, сэр/мадам!	audio/sentence_good_morning,_94f4ffc4.mp3
a6bcbc36-9d5b-4217-aaa6-a2bc5129b78a	2756062a-8db6-410d-9c38-0603e02d66c0	Good afternoon, I need some help.	Добрый день, мне нужна помощь	audio/sentence_good_afternoon,_cbe39bd2.mp3
81c348f8-908b-48ba-80e5-9fb9e25c547f	b52cf7ab-7c0e-4ca8-83fc-232b74e23f86	Good evening, have a nice flight!	Добрый вечер, хорошего полёта!	audio/sentence_good_evening,_6c916f93.mp3
6244b6c7-3bd7-4dfd-a36b-98cf1ec06f2a	7f44c6c2-777d-458a-a452-acaa93173a5c	Excuse me, could you help me?	Извините, вы могли бы мне помочь?	audio/sentence_excuse_me,_27f5005f.mp3
302767f2-90f3-448e-b129-31219648f9da	817a161b-1257-47bd-b32b-0653f2037db0	Sorry for the inconvenience.	Извините за неудобства	audio/sentence_sorry_for_1d43c5e3.mp3
5c6602f2-31b2-4859-b3b0-38f805133a95	7688f223-5ba9-4907-bdeb-5236a599e47c	Please, show me your passport.	Пожалуйста, покажите ваш паспорт	audio/sentence_please,_show_93518cfc.mp3
161efd3d-28c5-4a10-93e9-747f474126fb	f008bbc0-18e9-49bf-ab3e-0716134056f9	Thank you very much!	Большое спасибо!	audio/sentence_thank_you_9d149fc0.mp3
63efba93-0f7e-4bbd-a8ae-a84d209b8395	a6e36cfa-7a0d-4c3c-9852-b18097ffad1a	You're welcome!	Пожалуйста!	audio/sentence_you're_welcome!_f63c74ef.mp3
e2c81ad3-d491-4751-a4dc-4c8985d35d59	93edf865-14e1-4039-803c-08e18c23ca9e	Have a nice day!	Хорошего дня!	audio/sentence_have_a_c0683063.mp3
8b94e310-3666-4c12-97e3-145096df7eed	78710cab-3593-4bb3-b386-8363519c5546	Have a good flight!	Хорошего полёта!	audio/sentence_have_a_60b1622a.mp3
2721687f-54f5-453b-884d-5f96ca4de557	2deab0d2-2a39-477e-84a6-be373ce803ca	Have a nice trip!	Хорошей поездки!	audio/sentence_have_a_9c0d54b8.mp3
9e7c4c9d-f9d5-40e0-9157-4f31a5519380	e5a95261-c31c-42e6-85b7-fe9120910594	Nice to meet you too!	Взаимно, приятно познакомиться!	audio/sentence_nice_to_bf3d8924.mp3
840de0d1-de03-4fd2-93bf-fad1e71f3d15	b8675924-c6b2-4b4a-aa53-20fca3f0658d	How are you?	Как ваши дела?	audio/sentence_how_are_5efe7264.mp3
2894b2bb-69a0-474e-a010-0d0ddfa99570	f58ba7c4-cd5e-4a0e-9b5f-c8a3e484cdbb	I'm fine, thank you.	У меня всё хорошо, спасибо	audio/sentence_i'm_fine,_35b05b2e.mp3
8e8a6bd0-cfad-4f1a-acdd-2e6f2404e3ca	7bd093c5-7dea-4877-b6b8-82421793872e	And you?	А вы?	audio/sentence_and_you?_e15410ca.mp3
1b7ac97c-5d1a-40b6-9f4d-e28c70d9efbb	b6c2187e-4516-432f-9743-b1ef278d6825	What's your name?	Как вас зовут?	audio/sentence_what's_your_96e117a2.mp3
b5da11f4-c19e-4b73-ba6c-b24c5a69c3b8	481589df-b015-4030-95a9-33e70b4ff2f0	My name is John.	Меня зовут Джон	audio/sentence_my_name_0dcccb50.mp3
33b80504-fbed-4ed1-bf8e-3d5c483b1b3c	c3eddcc6-d470-42f2-9740-d91c0218d457	It's a pleasure to meet you.	Приятно познакомиться	audio/sentence_it's_a_98382dc9.mp3
9fea3235-90fd-4f8b-a20a-ce5e83b7cf66	1241ea51-4674-46c3-9ab4-c074dd0471ab	We made small talk while waiting for the flight.	Мы немного поговорили, ожидая полёта	audio/sentence_we_made_41d45e70.mp3
8ea2347a-14d3-44f4-b94d-e4d74bed5c21	d473cdf7-30c9-46a2-83fb-3355632a7d03	Could you check my flight details?	Могли бы вы проверить информацию о моём рейсе?	audio/sentence_could_you_6c36a7b2.mp3
1f9fbd7b-3666-4694-9bf6-fb9eaf76855d	cac56435-edb6-4dd0-ad21-4c845ccc756b	What's the gate number?	Какой номер выхода?	audio/sentence_what's_the_bde5cebb.mp3
7ba2a2ac-82e7-4d38-938a-3aeb3e4a2412	1adb04ec-0306-4b24-b064-6211e80155d7	What time is boarding?	Во сколько посадка?	audio/sentence_what_time_80ae3ad1.mp3
d7333450-7fb0-4d5d-b569-e695db0cd317	59d4b43c-d732-423c-9303-d323b931b871	My flight is delayed.	Мой рейс задержан	audio/sentence_my_flight_6e2f959f.mp3
be2ba20a-f8d2-49e5-b020-3cb9d49c74bb	c4e03f84-7913-46d5-8f53-a77e136daf1a	I have lost luggage.	У меня потерялся багаж	audio/sentence_i_have_5ec1bed4.mp3
174675f5-2f88-4753-91ec-5c688e81d962	c15c5d7a-b776-458f-8e8b-ee09ff2d2ce4	I need to check in.	Мне нужно зарегистрироваться	audio/sentence_i_need_e4845dbc.mp3
66283f24-b0f2-4f0b-acd6-2f37177db351	9eafca33-2bb1-4931-bfe8-7d37a7677ab0	I'm looking for the gate.	Я ищу выход на посадку	audio/sentence_i'm_looking_d90eabd4.mp3
35f6ee57-e05f-42f5-aa58-71bc6394a4c6	ecfaea8a-e0c9-474f-8224-9b408f69fe95	Could you look after my bags?	Могли бы вы присмотреть за моими сумками?	audio/sentence_could_you_21329418.mp3
63e1fbca-bb3a-436d-ad11-f918f60df55a	e25169e2-7537-4a73-9bb4-26e6e9299e52	Let me look up the flight schedule.	Позвольте мне найти расписание рейсов	audio/sentence_let_me_8b7e4dd9.mp3
0aded618-386c-4112-b6d1-a18914264092	c295cdef-05b6-4119-90e7-ccd76ec6163c	We're going to set off soon.	Мы скоро отправимся	audio/sentence_we're_going_ef267605.mp3
6e53e0f3-f3fb-4c1c-a9e5-7f880eae4f2a	775a0e63-74f1-49c8-b3f0-a6e77643c168	When does the plane take off?	Когда самолёт взлетает?	audio/sentence_when_does_44a146b6.mp3
1386ace2-52a3-48e6-8854-2797ea31b725	ca53b244-44e1-483f-8344-fbbda8989ec3	Let's get on the plane.	Давайте садимся в самолёт	audio/sentence_let's_get_929b55cc.mp3
040ca8e7-38fc-4574-b517-971117802ea5	eb1f44b9-13a0-4a69-bf49-95d77bc7acb4	When do we get off?	Когда мы выходим?	audio/sentence_when_do_fa3c5c09.mp3
f99cd61a-7654-4db6-8eae-571d7a04d1cc	e003cb98-12de-433e-a19f-8262538fd43f	I need to catch a flight.	Мне нужно сесть на самолёт	audio/sentence_i_need_fd5ce57b.mp3
e4c837f8-1b50-404d-94ca-798f25e7ba35	c05d6e43-4128-4986-9230-f3162eed7376	I don't want to miss my flight.	Я не хочу пропустить свой рейс	audio/sentence_i_don't_b7197580.mp3
8e841ec5-0b73-413c-bd2c-4f2301ecc347	3bffe0a3-2486-4de6-8c9b-3538b3b0fe3c	Go through security.	Пройдите через досмотр	audio/sentence_go_through_47257d92.mp3
f827b776-893f-466a-9912-587cb8aef56b	aa350fba-c9db-47bb-a918-7b31b9b27541	I came across an old friend at the airport.	Я встретил старого друга в аэропорту	audio/sentence_i_came_532e58f6.mp3
b8269368-1179-4929-b93e-8d30da770ebb	96102115-806b-4fed-add3-e18c8a6ef925	Excuse me, could you help me?	Извините, вы могли бы мне помочь?	audio/sentence_excuse_me,_ff79f91e.mp3
c3015133-9930-4994-b48a-5946635ee722	d320e71b-fd7e-49f2-b08a-760ee439755a	Could you help me find something?	Не могли бы вы мне помочь что-нибудь найти?	audio/sentence_could_you_fb7fc25b.mp3
7d597953-3f83-4928-9c6c-1aa6dc3f7f1b	5ce4dec0-2793-41d4-a556-57e09698ec0f	I need help finding a specific item	Мне нужна помощь в поиске конкретного товара	audio/sentence_i_need_affa9b45.mp3
7d08692a-3c7c-4949-b6ee-e585b1501199	e008037b-4a59-40bd-993d-25b454293d21	I'm looking for a red dress	Я ищу красное платье	audio/sentence_i'm_looking_59fd444d.mp3
79e5a68b-ed00-4df7-9b3d-93bcca456447	19994b46-61b2-4831-829d-b60098b4b9b1	Do you have this in a different size?	У вас есть это в другом размере?	audio/sentence_do_you_7b1c7b77.mp3
d47d33af-4890-4c9b-82b4-03117fae07ed	37c39247-3f0f-4942-939a-3ebc98781ec6	Where is the men's department?	Где находится мужской отдел?	audio/sentence_where_is_fb7e00b4.mp3
d17f6a6a-b187-49ee-a2c6-ed0d23afa5d6	828d7038-5596-40ac-827b-31a8b240d3c0	Can I see that shirt?	Могу ли я посмотреть эту рубашку?	audio/sentence_can_i_1b2bb58c.mp3
7cf58d84-8398-4d9b-82ab-045a0cbc9ce8	901dacbf-ed6b-43a1-bbdb-6d2b4419f379	Show me the blue shoes	Покажите мне синие туфли	audio/sentence_show_me_0b929eab.mp3
c6a31391-c55f-4a53-a357-adae2171b8cf	bd77a5af-32ec-4eb1-b8f8-22f4b07c3fb3	I'll take this one	Я возьму этот	audio/sentence_i'll_take_4df46678.mp3
4e8d07d5-45ae-4095-9caa-70b0ab270473	174be8e4-881d-4fc7-be13-e095b88ed538	I prefer that one	Я предпочитаю тот	audio/sentence_i_prefer_33d08006.mp3
31810bcc-0099-4ff9-aa86-bd96b6d1a4c6	5a23bfb9-08f2-4e6a-b40c-a1b67e86805c	The shoes are over there	Туфли там	audio/sentence_the_shoes_baeaa67e.mp3
384e97b5-d246-4fbf-94a5-734c45dcb378	d0e46dd5-a867-4ba2-9a5a-e1e98038dc84	The dress is right here	Платье прямо здесь	audio/sentence_the_dress_65d71793.mp3
e5a8d0d6-808f-4262-b036-3bfe3f6ace3b	ebd415df-9388-4d5c-9b36-5edd20bc815d	Come over here	Идите сюда	audio/sentence_come_over_07483667.mp3
13acfced-c72f-47e0-9ecc-f25c2ffef934	ff8fe13e-97f8-49ee-8d84-b60eea78e32b	Please go this way	Пожалуйста, идите сюда	audio/sentence_please_go_e07bf666.mp3
1c599651-eecd-470a-9c4b-cb1404645965	48572d28-d6a7-492f-a489-7f2d53850a1b	Help me find a gift for my wife	Помогите мне найти подарок для жены	audio/sentence_help_me_96881523.mp3
17e6e69f-dbfc-45ba-a89a-ee2f45a46746	20fffecb-4f62-4b43-ab93-93bbab6834ce	I can't find the fitting room	Я не могу найти примерочную	audio/sentence_i_can't_8f92ccaa.mp3
5ff99ac9-f72e-4fd4-9434-696d2f70b72c	86b069af-2582-461b-b2d5-7f23d34cae9c	Where is the fitting room?	Где примерочная?	audio/sentence_where_is_3286ffcd.mp3
50c0f5d1-3473-4e6a-815d-e8e217697d79	0369b024-46f0-40fe-9829-ca612a5f7a10	I need help with choosing a colour	Мне нужна помощь с выбором цвета	audio/sentence_i_need_64a92042.mp3
437e3324-3178-4b37-81de-bd7176fd2fff	77ae45a8-ff5f-4596-8505-62bb45d73313	What sizes do you have?	Какие у вас размеры?	audio/sentence_what_sizes_e16040f8.mp3
6919c9d0-6b60-421c-8f40-bdc5a703cc7f	a222f53b-c637-45ad-b16d-810d7b6b751f	What colours do you have?	Какие у вас цвета?	audio/sentence_what_colours_d70af1b6.mp3
296a3a79-009b-4227-8846-3bd76ce36419	8d961097-6d31-4e19-ac27-6dc6e1744383	What is the price?	Какая цена?	audio/sentence_what_is_2c9d4a07.mp3
a7767c3a-f822-4a65-994c-d51fd0d416b0	3d43a1d8-e3b3-43c4-8f39-5e03ed876964	How much is this?	Сколько это стоит?	audio/sentence_how_much_dcc0fa63.mp3
90c8254b-c8d9-41b1-8cd5-31bddc9662e4	5e2766a4-9984-488b-b818-bce627b2d1ab	It's too expensive for me	Это слишком дорого для меня	audio/sentence_it's_too_688cc725.mp3
8ab91a60-3903-4410-8ae4-3b1742b81c8d	2a9bf479-ff8e-4a15-ad03-55f621ac004f	That's fine, thank you	Всё в порядке, спасибо	audio/sentence_that's_fine,_d25dc308.mp3
2a45bf7e-30db-4463-baa3-73a0c39e6dc4	3e116fdb-c111-4969-9046-e2d44b7ae563	Thank you for your help	Спасибо за помощь	audio/sentence_thank_you_ddaa536a.mp3
6f7aa342-4c11-4f13-bc9f-857dda5a46ab	9a9ae259-2906-4ca7-ae47-d5ff40abf577	You're welcome	Пожалуйста	audio/sentence_you're_welcome_55477465.mp3
f26d1c6f-6699-4275-aacc-f034426cb185	729d2719-62cf-46ff-bcc1-dd3721f77ac6	No problem at all	Вообще нет проблем	audio/sentence_no_problem_168b64bf.mp3
1bb569b7-dda7-43fe-8c17-b9bfd9003e92	af2d4619-452b-4d81-9a10-c2f19ae450d1	Certainly, I'll help you	Конечно, я вам помогу	audio/sentence_certainly,_i'll_4f34df5f.mp3
fdc57f5f-655a-4c58-8011-95b23109c30e	367b2a41-1bd8-44b2-8521-c96471f6842f	Excuse me, could you help me?	Извините, вы могли бы мне помочь?	audio/sentence_excuse_me,_eadea3c6.mp3
a20edcf1-e4d1-4396-a43a-cea2e09f7e00	930ef1c3-23ae-49e0-8b31-28ffef6e9a70	I need help with my luggage	Мне нужна помощь с багажом	audio/sentence_i_need_edcfe501.mp3
34251466-f610-49e0-854d-cc3dda3ffe0c	cefce49d-87e0-47c3-b1fd-2b7eb5171aab	I'm lost	Я потерялся	audio/sentence_i'm_lost_f4021b28.mp3
6552221f-3f57-435d-b815-9a6b88ee753d	a4849aad-63f0-40eb-93de-4821555f8f3d	Can you give me directions?	Вы можете указать мне направление?	audio/sentence_can_you_40884c94.mp3
e6dacf3e-f1c1-4533-b061-429cce137b1b	11f3fb5a-a54a-43dd-88c7-27c68a238ac0	Which street is this?	Какая это улица?	audio/sentence_which_street_8a6c6b52.mp3
33e39809-9304-4ff5-87b8-3ace139949b4	dbbd0bca-3f67-4ab1-9799-17e678f28b0c	Is there a lost and found?	Здесь есть бюро находок?	audio/sentence_is_there_5725f542.mp3
2057286c-1ea1-4081-911d-f252981f9d42	a9bfa8a2-c0bc-442f-b6f7-0e3195f4ccdd	I need to ask for help	Мне нужно попросить о помощи	audio/sentence_i_need_595e8d56.mp3
7d5a3f98-ecbc-4fe5-bfd9-b12b79f6c5dc	6e387ab0-953b-4474-8613-7bd7858cc52c	I need help finding the train station	Мне нужна помощь в поиске железнодорожного вокзала	audio/sentence_i_need_e128ebb8.mp3
68d4d5bc-ce70-44b0-bd63-f6f8895ceacb	89353667-251c-465a-bb9b-d2c82bc06095	Can you help me with this?	Вы можете мне с этим помочь?	audio/sentence_can_you_a05e201b.mp3
26efd1e4-e6b1-4538-b9ce-098ed30180d9	2c244230-30b6-4585-81d6-6b1da921f193	Could you help me carry this?	Не могли бы вы мне помочь это перенести?	audio/sentence_could_you_9f7f2ff9.mp3
b37efb51-4f36-4fc0-a457-d1761f9a6739	210579c0-c36d-45fd-929c-5a22947d1013	Please help me, I'm lost	Пожалуйста, помогите мне, я потерялся	audio/sentence_please_help_7396d65b.mp3
b094f27b-2086-4c97-8bc4-61f43b940082	339308b1-24ca-460a-af30-a7fd68b5c681	Where is the nearest bus stop?	Где находится ближайшая автобусная остановка?	audio/sentence_where_is_b6edb873.mp3
7c8ec73c-d693-4b02-b0bf-991babc16bef	a03d08b1-9c38-4a9b-9ac2-5d8466ee5826	How to get to the airport?	Как добраться до аэропорта?	audio/sentence_how_to_d84ccbac.mp3
6ce833cc-07bb-41a4-afed-129462453e35	7890c057-c77e-4e4d-882f-7a358a4fe910	Could you point me the way?	Вы могли бы указать мне дорогу?	audio/sentence_could_you_d47b9a0f.mp3
20e6a062-ec69-47a7-ab33-ac8a9e5551cc	188ef08b-8619-4ac0-9f54-21fa6dd339ef	Show me the way, please.	Покажите мне дорогу, пожалуйста	audio/sentence_show_me_188fb1a2.mp3
79431b69-3425-440d-a1c9-7616659bf223	9347cde4-5bec-4998-9c03-a1aafd2aaf43	I can't find my way	Я не могу найти дорогу	audio/sentence_i_can't_1b942eb9.mp3
b7805d2e-3cc0-4bba-8f90-2aaa672c1787	6fb71aea-fad7-4051-a7d1-6c2528183b58	I got lost	Я заблудился	audio/sentence_i_got_e276a22d.mp3
2f61ee9f-c06e-4ba0-9827-0adb403b3f5a	53629cf1-2f27-409f-b37a-3f4d84759da1	I'm looking for the information desk	Я ищу информационную стойку	audio/sentence_i'm_looking_ccf7ca38.mp3
9f63be3a-c9c1-4f96-a92b-a1eae2f87bee	8d912dcb-2c3a-48f3-88d6-7117d2ac57e7	What's your address?	Какой у вас адрес?	audio/sentence_what's_your_877d4fcf.mp3
bf9aa9cf-4db7-4532-a74f-4c848372b58f	2f9b037e-fce7-4df9-906e-358da0a6f531	Tell me how to get there	Скажите мне, как туда добраться	audio/sentence_tell_me_601eb1b9.mp3
7f2012c8-f662-46c4-b966-849711ecb6d2	389fc381-2f09-483f-8c64-9935aeeb0eae	Is there a hotel nearby?	Рядом есть отель?	audio/sentence_is_there_e462de18.mp3
4e1dc0c6-c61d-491b-8b3f-2eb1d13e00eb	cd296cc3-ad63-409c-96ba-84d43ad20a0d	Go straight ahead	Идите прямо	audio/sentence_go_straight_131683e0.mp3
8c1c960b-b7cf-41e1-abae-3fa43fd5ffb6	2e8ff220-21c3-4594-9190-27f0bbb47ddd	Turn left at the corner	Поверните налево на углу	audio/sentence_turn_left_6e7f5c78.mp3
f3e38810-52c2-4fca-8914-92c0b089d3ad	bb3f0bba-f90a-4e09-b90d-4532bc10147a	Turn right at the traffic lights	Поверните направо на светофоре	audio/sentence_turn_right_df51e7b6.mp3
6f113eb6-e066-422b-be74-da07775ccba1	6f39527f-4097-498b-8ea4-f106a1bb8b90	Take a left at the next junction	Сверните налево на следующей развилке	audio/sentence_take_a_1995159b.mp3
859151d3-d8a3-42d9-b5b4-537539e5713b	a1b1fee6-0fb4-4ccd-b326-af52f5b413c6	Take a right at the next junction	Сверните направо на следующей развилке	audio/sentence_take_a_1b7cea22.mp3
69909267-08e0-4549-86c3-818734304c62	c690b418-9650-4634-bbe7-d68fcc9c1525	I'm sorry, I'm lost	Извините, я потерялся	audio/sentence_i'm_sorry,_bc507b8b.mp3
4865bc85-4c68-4be9-bc9a-ce81761127ae	7f23e80f-831a-4d6b-b057-f98af0fdd640	I don't understand	Я не понимаю	audio/sentence_i_don't_84b3cfb1.mp3
6748588d-504d-45d7-a912-4059d73d7f37	d2b504d8-5652-4450-b0b0-7bced1060995	Thank you very much	Большое спасибо	audio/sentence_thank_you_f0cc074c.mp3
66fd2a6b-0efa-440e-bc10-067e56d4c6d7	86c2bd51-f75d-4776-baa6-8e7ee01bca5c	You're welcome	Пожалуйста	audio/sentence_you're_welcome_a20ed5a1.mp3
32b3d221-ead3-4651-9c3d-0edf386a6bac	88057b6b-d5f8-44d8-982a-da862c54f8d7	I need help	Мне нужна помощь	audio/sentence_i_need_977573c5.mp3
b962c3c8-626b-4c19-9a71-fb38ec3843c4	183d121d-3f4c-4048-8327-474a50e46c4d	Can I get some assistance?	Могу ли я получить помощь?	audio/sentence_can_i_fdc4f019.mp3
afa207da-e031-4d7f-b1fe-636e4ddd902c	927f7a82-a310-4392-8ec8-6c78e99ec4b1	My passport is lost	Мой паспорт потерян	audio/sentence_my_passport_fe102cdd.mp3
c9e0739a-89b4-46eb-9091-e8a5189d8bab	6c6b5fbe-d4f7-4aec-b235-77519c2369d6	My wallet was stolen	Мой кошелёк был украден	audio/sentence_my_wallet_961ab63e.mp3
d7ed2359-e6a8-4d83-9d6e-0c7d10841f4e	be8c0960-203a-4fcf-b0bf-3b30df1a6c04	I need to report a crime	Мне нужно сообщить о преступлении	audio/sentence_i_need_525e0823.mp3
c581992e-b094-4ec4-9a14-fce41b86657a	008bec9c-502d-4260-a546-1d6b40366a55	Can I speak to a police officer?	Могу ли я поговорить с полицейским?	audio/sentence_can_i_ec8dde04.mp3
e9e8914d-43f6-4d88-acf1-7d4b6d185a40	9415176c-8627-4a6f-b07b-48d61f077f67	This is an emergency	Это чрезвычайная ситуация	audio/sentence_this_is_0c1a45d6.mp3
a0ae442d-45dd-4aee-8868-b73e9ea12cb9	2199d25e-a5ce-42d1-a56b-83f3bbae3a47	This is urgent	Это срочно	audio/sentence_this_is_25a709af.mp3
8537f5d1-4091-40be-b7f2-d481703c0ecb	d9d717dc-1655-4897-ab56-0ab0bcc6e400	Can you explain what happened?	Можете ли вы объяснить, что произошло?	audio/sentence_can_you_0e5a114f.mp3
17552a97-00c1-4aa3-a6ef-5a39a82e0912	909ce7f7-a383-4a12-812f-0cb691f28678	What happened?	Что случилось?	audio/sentence_what_happened?_16873321.mp3
55599cf9-e9ef-42b7-a1e8-7ee140c274e4	875393c2-4822-461c-8d3c-68c3ca28801e	Can you give me some details?	Можете ли вы дать мне некоторые подробности?	audio/sentence_can_you_cf71d628.mp3
08836456-f7e8-4954-9816-633079a3570b	8cf1d01a-6df8-4547-ba40-3fa406ac3cea	Can you describe the situation?	Можете ли вы описать ситуацию?	audio/sentence_can_you_6a2c107b.mp3
d1797df5-ac4c-49b3-89af-de8690eea9ae	f5afc6ee-cee2-4899-a590-9cab5189d42f	Were there any witnesses?	Были ли какие-нибудь свидетели?	audio/sentence_were_there_d1faa9b2.mp3
f5284895-eda6-479b-93a6-aaaeb5d27d44	b50ea320-eb29-413b-a357-227d135b097f	I have been the victim of a crime	Я стал жертвой преступления	audio/sentence_i_have_4a489f58.mp3
935eaf5d-6f18-4629-a3ef-714cbc3d181a	f3e4820c-04de-4d9b-aca5-e23625357dbb	I need some information	Мне нужна информация	audio/sentence_i_need_76f3a1de.mp3
5aea6c96-27b1-4320-a030-55abf73494e1	1b108346-b6f2-4aba-8bf2-f2a9393f7198	I need to make a statement	Мне нужно сделать заявление	audio/sentence_i_need_8c9f2de0.mp3
e407f71d-3762-4b71-bff2-df3dfc0705ae	36fb1173-4c2e-4edf-a605-3630ab2d41b6	I need to file a report	Мне нужно подать заявление	audio/sentence_i_need_77e5c6d6.mp3
43d9f79f-6b01-44cf-9475-e60ff7094e96	ce96915f-8e0b-4e92-b389-558018e7b74c	The police are conducting an investigation	Полиция проводит расследование	audio/sentence_the_police_9029d1e2.mp3
c7ab053a-9bd7-4410-b0c0-f23adf99159a	4e47505c-7f86-4e46-a0e7-5093e93fe88e	Do you have any evidence?	У вас есть какие-нибудь доказательства?	audio/sentence_do_you_cefe43b8.mp3
e103b391-7734-4e9e-bfb8-24cf31c96376	ce453f7f-32a0-48a1-983d-76a9a9190cf0	Do you know the suspect?	Вы знаете подозреваемого?	audio/sentence_do_you_1f3d4f36.mp3
97cf09f3-1b77-48af-af17-51717c16d9f0	0123a4c7-7830-451b-833a-37c8aa4748a5	Can I see your identification?	Могу ли я увидеть ваше удостоверение личности?	audio/sentence_can_i_3cf7aa54.mp3
f5680d04-b6d7-48bf-89cc-aeaf038cd583	33f81ea9-84a7-4195-97be-51774c62fd26	There's a medical emergency.	Произошла медицинская чрезвычайная ситуация	audio/sentence_there's_a_7fe07095.mp3
4ba220f4-8ddc-4e63-bd45-f35f1011edcc	b2f09c6c-662f-492c-96ba-bcc4f46c74cc	I need medical help.	Мне нужна медицинская помощь	audio/sentence_i_need_d3ea4fca.mp3
15b05d12-fcde-4fa1-b4d2-e009fc29abb9	d6d09b43-e00c-4fc1-bb21-6913240eadfb	Please call for help.	Пожалуйста, вызовите помощь	audio/sentence_please_call_5de6450b.mp3
9c0dda52-8d47-4911-a8b7-67eeb5a27499	83f5373b-b270-4946-a3ff-069aa637a2d1	Do you know first aid?	Вы знаете первую помощь?	audio/sentence_do_you_44b00fe2.mp3
b256599d-1695-44e6-9351-187ec888fe34	a4d28515-0853-4079-ae6d-e2ba34c32018	There's an injured person.	Там пострадавший	audio/sentence_there's_an_2dad5dd7.mp3
828c9aa4-028c-4153-9edd-f4c39dd4c54c	865b5d83-dda8-4de5-93fe-e47ab46ec45e	You should seek help immediately.	Вам следует немедленно обратиться за помощь	audio/sentence_you_should_838df0e9.mp3
45a4343e-4042-4dc5-ae76-740e98b52732	56b96015-fd81-498f-bcd0-406629e5f26e	I need to get help.	Мне нужно получить помощь	audio/sentence_i_need_0b71e213.mp3
1260b64d-2e83-4634-bd6d-5f42003343e6	c1846c1f-b549-49e8-aeba-234e0313b073	He needs urgent care.	Ему нужна срочная медицинская помощь	audio/sentence_he_needs_05e9e973.mp3
ff30985b-fe7f-4b7e-b643-fa74e5e13668	2f4de225-e80b-4f85-b4be-bdc06127fe75	I feel unwell.	Я чувствую себя плохо	audio/sentence_i_feel_f7a8933b.mp3
1da8fdcc-08cc-4d8b-b390-a51e9508d233	4a06def3-5945-454f-8982-a19d261917e0	Someone has had an accident.	Кто-то попал в аварию	audio/sentence_someone_has_b53a1e5f.mp3
cb816dd5-e322-4ac2-952c-aac41651dbb1	ef2d5a3c-684a-4277-8217-67a9290b3aec	I'm in severe pain.	У меня сильная боль	audio/sentence_i'm_in_9d0ff0cf.mp3
f0af26ba-9859-4579-b73f-8761a59feae9	080b181a-5e62-4182-a128-23693d75dc2a	It's a serious injury.	Это серьезное ранение	audio/sentence_it's_a_aabb2a36.mp3
4e662592-bd94-4c64-96a8-f0a255a41903	ba0562d9-20c4-41bd-b5d5-ccc38988f8d3	I have a deep cut.	У меня глубокий порез	audio/sentence_i_have_32fff169.mp3
5c5c00ca-97c0-4bb5-9f65-ee858ec1a355	999330c2-fde2-4e23-a5ee-1e9ced19f171	My arm is bleeding.	Моя рука кровоточит	audio/sentence_my_arm_8b232a1f.mp3
87b77b9b-3e9a-46a6-8f1c-dd36823465ac	a54b2c94-f91b-46a4-af7b-85b4bd308ee9	I think I'm going to faint.	Кажется, я сейчас упаду в обморок	audio/sentence_i_think_df14462c.mp3
388d9259-7ddb-4dff-8574-b9270ad74e81	9db50788-40bd-4699-a683-2a9b82a7e07c	I'm short of breath.	Я задыхаюсь	audio/sentence_i'm_short_76a33623.mp3
46b46967-cc58-4da8-8fd0-74841523a658	68d46896-8945-4c56-ab3b-df6dd88219a3	I'm having an allergic reaction.	У меня аллергическая реакция	audio/sentence_i'm_having_5d24788f.mp3
e4c6ce23-4df9-49bd-81de-4b9c9b4cf518	6fdc0d68-a3f1-4012-afde-4684a9bf7b1e	I'm having an asthma attack.	У меня приступ астмы	audio/sentence_i'm_having_e7668da0.mp3
de67cd7c-8a95-42c8-963b-02e9e22cc4fd	b9e11719-f1ee-4f66-a524-c1e982bf6f71	I have chest pain.	У меня боль в груди	audio/sentence_i_have_1bb1c70f.mp3
d6db66bc-0d5b-4700-9ea3-65f82c00b7f4	f31f9f89-3df2-4ef1-aa36-24de57af8acf	Help me, please!	Помогите мне, пожалуйста!	audio/sentence_help_me,_e512436d.mp3
efe302d6-f8a7-481b-9aed-dae95e77e1a9	af4ed353-b93e-4118-8141-74ba93258dd9	I need a doctor, please.	Мне нужен врач, пожалуйста!	audio/sentence_i_need_809604b5.mp3
e12102dc-085b-4dca-98b9-463c89363e59	97f01972-d21b-4e99-9c4b-0f62bb00707e	Call an ambulance!	Вызовите скорую помощь!	audio/sentence_call_an_f8d4c55a.mp3
5df4d7fa-c5b1-4943-967e-a1d95391d8b8	a35a7fba-6021-4d54-a117-9e9761444115	Dial emergency services.	Наберите номер экстренных служб	audio/sentence_dial_emergency_b329b95d.mp3
4ebac83b-1d4a-474a-89f0-b962b4e230f5	7061564f-4b62-42a6-bc4c-e1de0c0217c3	Please stay calm.	Пожалуйста, сохраняйте спокойствие	audio/sentence_please_stay_b2ac0bb5.mp3
aea78221-64c3-477b-b5a8-6cf7a9004bf8	44819475-1b7b-4a1e-9814-abcff4f0bbe8	What happened?	Что случилось?	audio/sentence_what_happened?_1c24ec66.mp3
3f1cf162-ad8b-4a29-ac23-feafd56c7306	91789b54-6405-47d5-b64f-913f97f6db9e	Where's the nearest hospital?	Где ближайшая больница?	audio/sentence_where's_the_b06a66cd.mp3
133d3554-66ef-435b-8aa3-e0ac209e397b	860b521d-39d9-4ce4-9ba4-fd81c5cea924	Call medical staff.	Позовите медицинский персонал	audio/sentence_call_medical_7a7d055e.mp3
53b35f28-6ea9-4378-bbec-404444195c31	8b6c4202-92cc-439e-8840-c24b09a12130	Where's the first-aid kit?	Где аптечка первой помощи?	audio/sentence_where's_the_04310822.mp3
e5c0750f-f1c2-4f1a-a187-4a5c3ca0ffec	63b9a276-733a-411f-b649-0c370297b0c9	My passport is lost.	Мой паспорт потерян	audio/sentence_my_passport_fcb253ea.mp3
4fd77d33-67c1-462a-884b-f35ed8a03fe4	9d3050b8-78dd-4b96-97b6-32b97bad6b2d	I need to find my passport.	Мне нужно найти свой паспорт	audio/sentence_i_need_df55ab85.mp3
d5f78117-0391-415a-ab15-1bcd482a7d95	1906da46-d066-43ed-ad53-737d2ebd276d	Can you help me?	Вы можете мне помочь?	audio/sentence_can_you_6bf2204b.mp3
e3425840-8df9-4654-a474-2776f6212290	0748a10a-dc0d-490d-ac5a-542b48c1e8d1	This is an emergency!	Это чрезвычайная ситуация!	audio/sentence_this_is_948225a9.mp3
456631db-603e-4786-83dd-c46885f35f9e	23db1dba-39c9-4a4c-b19f-a456460cbda4	I need to go to the police.	Мне нужно обратиться в полицию	audio/sentence_i_need_c41ce66d.mp3
46ead0b4-7702-4082-ba7e-de4b4723e4db	50814274-19c3-45e7-a3b5-b8a8a5ebfd05	Contact your country's ambassador.	Свяжитесь с послом вашей страны	audio/sentence_contact_your_292fb30f.mp3
b9e76c03-d570-4059-849b-64d69ec6f55c	b057b636-b168-478b-9631-889f39cd2b1f	Go to your embassy.	Идите в ваше посольство	audio/sentence_go_to_1f3e13a6.mp3
24309174-8b72-4d04-b05c-dc98afb962df	76dd5a33-3fa3-426a-bd13-088abe663216	Report the lost passport.	Сообщите о пропаже паспорта	audio/sentence_report_the_0c403788.mp3
9704fe19-8dc3-425d-abdd-f482abbb2e05	1f576400-37a7-4944-8e75-e43acaffb970	Fill out this form.	Заполните эту форму	audio/sentence_fill_out_984e6aba.mp3
2c6e5fd1-2c99-48b6-ad3c-9e0a6c5dbe26	57842462-de6a-4787-a2e9-f6c926189081	I need a form to report it.	Мне нужна форма, чтобы это сообщить	audio/sentence_i_need_824c4f52.mp3
f7b69c25-9765-4cd9-a162-45fcd482c7ca	5020944e-cf97-454d-ae2e-635d1e189eae	I need help immediately.	Мне нужна помощь немедленно	audio/sentence_i_need_7efd16f3.mp3
f2949e08-6edd-4258-a7c4-5c3fd4bf0ad3	d6011648-7fac-4999-9a36-f426a3dc777e	I need to do this right away.	Мне нужно сделать это сразу же	audio/sentence_i_need_99673302.mp3
6dc35851-1c7b-4238-8979-05bd92da3143	7b4be1de-3207-4d2f-80ce-a3177cfa35e8	Please help me as soon as possible.	Пожалуйста, помогите мне как можно скорее	audio/sentence_please_help_ae0dbfac.mp3
375d8529-2a63-4cf8-b8aa-6b12c1809a71	fbf54b7e-3530-42f0-a472-e621c817fdd6	Talk to an officer.	Поговорите с офицером	audio/sentence_talk_to_615ace4c.mp3
08f103c1-9bf4-4fa1-83fc-919d597a17cd	a9bd92f9-4f12-4dac-9f0f-0c499c87da03	Explain your situation.	Объясните вашу ситуацию	audio/sentence_explain_your_d6bbedee.mp3
0b61a421-0994-4d20-a1f6-a43cd93b89b5	8c6c78b2-6461-4d4b-bded-eefcde5fd2ae	Try to calm down.	Постарайтесь успокоиться	audio/sentence_try_to_4a11f592.mp3
aaffbbcc-4ff3-4756-9d7a-0943e46b0cc9	a6106bcc-cd36-4f74-abbf-ea68cebcbc94	Don't panic.	Не паникуйте	audio/sentence_don't_panic._e9c2c262.mp3
e0ff588a-836f-41ca-8d4e-612b40ec4eab	845df52a-8272-47d7-a27f-e9539bf01f49	Can you explain what happened?	Вы можете объяснить, что случилось?	audio/sentence_can_you_466c5495.mp3
441228e4-8ef4-4f83-9899-9fea40aef265	e8bb0bb0-89d0-444d-bdcb-8c3c813c8465	What happened?	Что случилось?	audio/sentence_what_happened?_cd2cdd69.mp3
ec7c7ad9-7dbe-424c-b401-3ff3778822a3	4b2a008d-aa7f-4fa3-93ed-a81382d651f4	I don't know what to do.	Я не знаю, что делать	audio/sentence_i_don't_98fd0b03.mp3
89a01ce7-4d2e-4514-8f9a-45325092f038	a431ab08-0ec6-4787-808a-f385e615ec54	I need to get through to the embassy.	Мне нужно связаться с посольством	audio/sentence_i_need_6b2a0ad8.mp3
168d555b-620f-4e3d-b652-099db9a7fed9	f80746b9-c8b1-469e-8bf0-21bdc7da8c51	Call the embassy.	Позвоните в посольство	audio/sentence_call_the_da6e6f2d.mp3
aa67911f-d89d-4702-bea2-dda1939374f2	40dfd210-0e02-4b64-abf0-93736960f925	Contact them immediately.	Свяжитесь с ними немедленно	audio/sentence_contact_them_2f4af20d.mp3
41190cdb-1d60-486e-8746-efe0c62a53c0	618a1a3f-0e9b-4728-8e43-0c0bf2ad5d1e	My flight is delayed.	Мой рейс задержан	audio/sentence_my_flight_6d908662.mp3
fa34a9fe-cff2-453b-b1be-0b481e5b96a4	a0275aca-8326-4a93-80c2-e57d38625bb4	Do you have any other identification?	У вас есть другие документы, удостоверяющие личность?	audio/sentence_do_you_11683444.mp3
c265363b-dd92-4ff8-8c9b-e22c37d2722f	bc21106b-d711-47b9-9fa2-fad062a03409	This is proof of my identity.	Это доказательство моей личности	audio/sentence_this_is_1eba6e89.mp3
bac8bb5e-9f51-4d2b-87aa-bc63dcc9c114	ac06fc98-8cfe-430f-9325-f1ee77fb6c25	My bag is stolen!	Моя сумка украдена	audio/sentence_my_bag_b97a9589.mp3
b0a3de0f-a550-4ba0-925f-a77b4f2a6f23	67639f43-35b1-46d6-afaa-9e159ad0c107	Report it to the police	Сообщите об этом в полицию	audio/sentence_report_it_76bcbbd5.mp3
cc405c3c-17df-4c45-90fd-f7fdfa1936a7	f8c29dc1-36e4-487b-a84f-756945063952	My passport is missing!	Мой паспорт пропал!	audio/sentence_my_passport_2353ee0d.mp3
913ddb53-9c31-4c02-8a63-29083c653c6a	f6616255-8693-486a-a766-5ad7eb7bc32b	I've lost my wallet!	Я потерял свой кошелек!	audio/sentence_i've_lost_3c9b01a4.mp3
3c22c880-8800-4d92-90bd-b3a55e2afa99	bdd5a455-e7ef-4938-ba56-bc8281fb71dc	Call the police immediately!	Немедленно позвоните в полицию	audio/sentence_call_the_36b95ff0.mp3
32a2c885-0a57-4cc4-90b8-495d964c40d7	3d213fe4-94a4-455f-97ac-ce3ad4355575	Ask a police officer for help	Попросите помощи у полицейского	audio/sentence_ask_a_ca86445a.mp3
2429f3bf-609f-4de1-817d-15b24ebd2d5b	1f8dabae-4b9e-4c6a-87b7-34c04264b396	Can you help me?	Вы можете мне помочь?	audio/sentence_can_you_19c8c219.mp3
748d8458-b1cb-4f83-b9d5-1b240921c7fa	0546aef7-2515-47e0-8b6b-a4d8ba5118aa	This is an emergency!	Это чрезвычайная ситуация!	audio/sentence_this_is_be44cd16.mp3
16aef225-1120-4a7c-bf0e-7189390818b9	d6f42ddd-3566-4b4a-8afd-5cec774bbb2a	It's urgent!	Это срочно!	audio/sentence_it's_urgent!_c65e5931.mp3
ca7e1639-f43d-4153-b992-f9ece0521a2c	f2365c33-3401-4e16-8d1d-3eb158d0c8a8	I need assistance!	Мне нужна помощь!	audio/sentence_i_need_89d7ec5f.mp3
558e6a8a-93bc-46b1-a734-8fd92226226c	11a78a9b-27ff-45b4-8c3c-315c776d2626	Go to security	Идите к службе безопасности	audio/sentence_go_to_cda1335f.mp3
bdb42c04-348c-4fa4-beb9-a4e63ba582e7	69162d08-ddbc-44c4-bcdd-8338d030e605	Can you help me find my bag?	Вы можете помочь мне найти мою сумку?	audio/sentence_can_you_cd1e9400.mp3
b3810ab4-0265-48f6-932a-040dea19b009	484eece2-fbc4-4b12-b64c-7e8343e8d5be	I'm looking for my passport	Я ищу свой паспорт	audio/sentence_i'm_looking_ef968d06.mp3
9ab9d238-7a6e-4b51-8a6c-1925c048bbd4	764cbeb1-4e37-4b9b-b0c9-ead68c9935c4	Call the airport security	Позвоните в службу безопасности аэропорта	audio/sentence_call_the_f99bc78a.mp3
677ae28f-3529-4d64-9bf5-3fcd8be73bd8	c43d7ef9-a4d1-40b2-ae1e-fb9a009770ae	Don't panic!	Не паникуйте!	audio/sentence_don't_panic!_9902cf1a.mp3
8d26ebf1-767f-45b8-b74e-003bcdf712d7	07f4b01a-d3d4-4015-bd9a-4c6b8b1a672a	Try to stay calm	Постарайтесь сохранять спокойствие	audio/sentence_try_to_2d74e6e4.mp3
3db43e3f-db88-4bd2-ae3c-a2db69cce3b9	6a071a4c-5975-485f-bcb3-461662836697	Describe the thief to the police	Опишите вора полиции	audio/sentence_describe_the_95d4075b.mp3
aaeac364-2358-4ad0-9152-860f93474881	5544dbf3-376a-447e-9db8-94a02b55cb56	Give them all the details	Дайте им все подробности	audio/sentence_give_them_101af365.mp3
f80170f1-5570-4106-b487-c8542272ae7f	cc7c6abb-2abb-424d-bfce-bba6acf2c532	I had valuable items in my bag	В моей сумке были ценные вещи	audio/sentence_i_had_57e136e0.mp3
a0582392-42f6-46ed-95e1-60a0e9692558	dee0ab30-1ffb-4f88-b3d4-ce5e9c272a40	Were there any witnesses?	Были ли свидетели?	audio/sentence_were_there_d3c5d8f2.mp3
2c67e70f-2c19-4cac-8f68-c193973a6c53	abe2c9fa-ad82-4003-a01a-5fbca5dbf71e	I need to make a statement	Мне нужно дать показания	audio/sentence_i_need_853f3e15.mp3
1cb712b1-5e59-4d74-ba7b-688bc1b19aa3	b58f47b7-eea1-4203-ac1f-06c0d1586b4d	The thief ran away	Вор убежал	audio/sentence_the_thief_a91efd7c.mp3
100ad7b6-eacd-4720-a397-f8d5456e3b6c	1ee87fba-9205-45bd-8633-38e5568f781d	This is a robbery!	Это ограбление!	audio/sentence_this_is_ea9cac2f.mp3
7c2b1dc7-143c-4117-a20a-29f4a1ea9c99	dc2b63c3-0787-4c61-a5df-9618b553df58	My property was stolen	Мое имущество было украдено	audio/sentence_my_property_99616376.mp3
1778ab32-5fa2-4f87-a2dd-45aedb279f6d	149b4a5d-8623-4c10-b168-c42c59b21ab8	Filing a report is essential	Подача заявления необходима	audio/sentence_filing_a_d800b2dd.mp3
39a46322-84ee-45c9-a304-411fd4b3505a	16e18283-a698-4762-801c-cc0f6666a077	The police will investigate	Полиция будет расследовать	audio/sentence_the_police_c4524309.mp3
61276576-427a-41ba-b76b-8c91884c6f87	fac763b9-49aa-43e9-804a-b3e8b39c54a8	What's the procedure?	Какая процедура?	audio/sentence_what's_the_a4ccc342.mp3
41e23a26-cddb-409b-94fe-5431066a81ef	d286208c-4146-44fe-bf44-873ca96b9a02	A thorough investigation is required	Требуется тщательное расследование	audio/sentence_a_thorough_b5abe7de.mp3
ee75d1bd-a7be-49b5-8c2d-8e3bcc126482	af5e6462-fdcb-4b5e-ab63-1cf0556673a0	The fire alarm went off	Сработал пожарный сигнал	audio/sentence_the_fire_9336a597.mp3
4e11339f-4011-4bdf-b844-f0645b665b97	cfeeabd2-15a8-419b-9f18-55ee1c4c7da7	We need to find the emergency exit	Нам нужно найти аварийный выход	audio/sentence_we_need_7daf69c7.mp3
16cbf6a5-e46f-409f-9342-10f582f0100e	5c7aacb7-7419-410c-84ec-f9bdcde41eb3	Follow the escape route	Следуйте по пути эвакуации	audio/sentence_follow_the_c9289ce9.mp3
1fcc10c5-f1f7-49b4-a477-a6e491587b34	8e37bf92-fdc5-4731-b8f7-e89e3e1fc8d6	Get out of the building quickly!	Выходите из здания быстро!	audio/sentence_get_out_1e392a18.mp3
01af4d18-1833-4710-9d82-ab4538f82550	66b37853-90e5-4bca-acd8-c6495b66bb56	The passengers were evacuated	Пассажиров эвакуировали	audio/sentence_the_passengers_73d6e589.mp3
783b1547-f5f5-4b0a-b129-f536a33c5e8d	3675b990-6e0f-4e25-b64f-9a72db333369	Stay calm and follow instructions	Сохраняйте спокойствие и следуйте инструкциям	audio/sentence_stay_calm_52602ab8.mp3
8493ee57-f9a4-4e96-9903-7f906dfcaef8	36044cdd-9d1e-48b0-bb8c-0205680e241a	Follow the instructions of the airport staff	Следуйте инструкциям персонала аэропорта	audio/sentence_follow_the_47928efb.mp3
deb51de9-cbdf-4fcb-b9bd-d0718090a773	c2465656-da63-40e5-b5f4-099eccac0564	Help someone who needs assistance	Помогите тому, кто нуждается в помощи	audio/sentence_help_someone_86b3eb28.mp3
91383a8c-7794-4d52-87c9-6a6d42e531e3	95f962c2-9760-486d-8287-2d512c33e6ff	Call for help immediately	Немедленно позовите на помощь	audio/sentence_call_for_092aa06c.mp3
67d48c4a-64fd-470d-a8e1-e1aa0a32783a	34cb030b-6a78-4761-b4f7-2264d01364ad	Do you know first aid?	Вы знаете первую помощь?	audio/sentence_do_you_654b749b.mp3
5aa8bf12-4103-45ae-8838-95ac8dccdad4	ac682d5d-6e41-4bc4-bb69-2dbc732a909f	There's an injured person over there	Там пострадавший	audio/sentence_there's_an_2cb65687.mp3
15edb7f8-d5ab-43c1-8c21-91d4a9d8c6fe	0c467e1c-40e8-4dfa-94a2-2f44b5105371	There's been an accident	Произошёл несчастный случай	audio/sentence_there's_been_5a8375d9.mp3
e303770f-2596-4e1e-a039-ed012db65b75	97480b73-838e-4d44-8db6-721ab19de251	Report the incident to the authorities	Сообщите о происшествии властям	audio/sentence_report_the_918874fb.mp3
72abf568-04e3-4713-86b9-3ea26e80f5ca	33f2f8fc-62da-4c39-a5d1-2dcb13d05a0d	Do you need assistance?	Вам нужна помощь?	audio/sentence_do_you_cfc81a35.mp3
a47e9aac-80df-4161-9c74-315dc051c10b	e37ca722-bbba-4f6c-8715-3b99d96144cc	Seek help from the airport staff	Обратитесь за помощью к персоналу аэропорта	audio/sentence_seek_help_9c83dd56.mp3
2ebc3056-e571-4731-b128-69b9e1319f41	b8a47cf7-933d-4ab8-bb85-7dddb51b60b7	Take cover immediately!	Немедленно укрывайтесь!	audio/sentence_take_cover_6d78b74f.mp3
7c07b81b-c730-413a-8bf2-ebf59504c742	b502b4da-4746-44e1-ac2e-68869cc28fc6	Run away from the smoke	Убегайте от дыма	audio/sentence_run_away_3603b0c8.mp3
623ad283-d1ac-451c-aade-71b76cec10f6	c10b8dcb-93a4-4ccf-a5af-b16923d57419	Be careful!	Будьте осторожны!	audio/sentence_be_careful!_8cfef855.mp3
c9b85876-f40a-4b02-8157-7ecd32304248	fdc08720-2766-4e7a-bcdb-38ce77f0171f	What happened?	Что случилось?	audio/sentence_what_happened?_606ef2ce.mp3
6a478114-c472-4925-8177-985c2422a2d8	fbd44310-9aad-49b5-8fcb-2a7067269721	I need help!	Мне нужна помощь!	audio/sentence_i_need_aa947598.mp3
5875e3d1-6817-43b2-bfb2-3a652039e537	4d2a9f19-8bda-49d9-88e9-733721d18c61	What is the weight of this bag?	Какой вес этой сумки?	audio/sentence_what_is_7aee1133.mp3
d217b78c-f63a-4ea4-b83c-5d656216104d	ecfd8933-6d77-47da-bc6a-5be59f1ce9c9	Can you measure the length of the counter?	Вы можете измерить длину стойки?	audio/sentence_can_you_b30b3e42.mp3
ae4cb5c3-85fa-4aa3-83d5-6f92dd646b3f	74680972-7ae7-461b-b05c-6aad19baaf3b	This weighs five pounds	Это весит пять фунтов	audio/sentence_this_weighs_5bc7f3e2.mp3
e58fea3e-35e7-4b16-a955-309ec4092888	59b2381c-2510-4982-9bfb-181c6f14e846	It weighs ten kilograms	Это весит десять килограммов	audio/sentence_it_weighs_f17eecd6.mp3
6dc4d9dc-b1ea-49f5-a9e0-856c1b119f79	1b678c19-56bc-4a8d-ada8-8e7546fac1cc	The package weighs six ounces	Пакет весит шесть унций	audio/sentence_the_package_2c2b5221.mp3
1a39ce1e-0879-4723-b42b-c262b78bd98b	3709341e-2344-40f9-9854-f46298e1a8db	This is 200 grams of cheese	Это 200 граммов сыра	audio/sentence_this_is_c5c3722b.mp3
30065dfe-ed09-47e5-bc34-b6b40c581bb4	0b99b19a-360a-40e9-9513-6e9baa2ed96c	Let's use the scale to weigh this	Давайте взвесим это на весах	audio/sentence_let's_use_20acfea2.mp3
4fdbe594-297b-4211-abd9-6a665ce48e1d	192bf663-1e01-464d-a5e9-b6201973739c	I need to weigh my luggage	Мне нужно взвесить мой багаж	audio/sentence_i_need_a63ece93.mp3
fa7829c7-85fe-45bc-a35b-7ee7dd1e31b9	96c659ca-89c4-4af2-9f2a-a28f8a8b7206	Please check the weight of your bags	Пожалуйста, проверьте вес ваших сумок	audio/sentence_please_check_3360d8e1.mp3
3e0f2141-8a79-47e5-9eb5-4b58fe1f5046	3fb777b1-33d7-44ba-b2d2-f1d08211f888	This bag is too heavy	Эта сумка слишком тяжёлая	audio/sentence_this_bag_84fdde30.mp3
018fb82d-64e8-4723-ace7-10042bf3c592	169b27a0-19ae-469d-b6d1-f1cd3d7e79c1	My luggage is overweight	Мой багаж сверхвеса	audio/sentence_my_luggage_e44ae9ed.mp3
96b3cb1b-e37c-4886-962b-4f9f664da27d	1f980f71-ee56-4c4b-b916-7f0981238f8d	The package is underweight	Пакет легче нормы	audio/sentence_the_package_1863308e.mp3
066f8d33-6b03-408c-a4f0-983b871e5961	68412f50-ba33-48aa-b90c-353f2205c71d	What's the price per kilogram?	Какая цена за килограмм?	audio/sentence_what's_the_5da76cdf.mp3
862beafa-0ff5-4f81-b8ba-f42d8e00dd3e	789ea806-fc1c-4305-81a8-574376e5f136	Can I see the unit price?	Могу ли я увидеть цену за единицу?	audio/sentence_can_i_b46d6830.mp3
a9c164f9-97f6-4c1a-b338-77bd43c8e4bf	f1cf7480-cab7-4649-a324-1f1b3109c939	I'm going grocery shopping	Я иду за продуктами	audio/sentence_i'm_going_f4e36339.mp3
5dc44cf5-0b24-4f4f-9bf7-1adb698f14c4	82b043eb-3756-4f57-82ea-941cf5423c5c	I have a shopping list	У меня есть список покупок	audio/sentence_i_have_401fc8c7.mp3
82fbd7e1-dab2-49da-9359-b12bffaff1e6	749d407e-69ba-49be-bb1a-8c2f061b9e37	Go to checkout number three	Идите на кассу номер три	audio/sentence_go_to_d4b33fa7.mp3
bc1ee58c-4212-4302-b059-bddccd38082f	c6b7d0d2-f574-4c7a-ae4a-8bfdd7d9a41b	It's a nice gift	Это хороший подарок	audio/sentence_it's_a_560c49e2.mp3
de7d79c3-cc52-4436-aa8d-18069d707fcd	f8b84c02-f10f-4787-b846-d17a69cd3602	There's a long queue at the checkout counter	Очередь на кассе длинная	audio/sentence_there's_a_1b06aa97.mp3
c611123a-6079-446a-9d80-c2e7279af680	c07a24e1-5cf3-48e0-a23e-61057d0d3784	They will scan your items	Они отсканируют ваши продукты	audio/sentence_they_will_6a14dd97.mp3
8606422f-a611-4e0b-80a6-5d8ff1e9827f	c1033c2e-7d72-46cf-93fc-300a8d2ba3ac	I'll meet you at the bagging area	Я встречу вас в зоне упаковки	audio/sentence_i'll_meet_e936cd93.mp3
58014d78-30dc-4ce2-ae80-a15369844875	c3a7b2da-2d67-4736-a01e-44eeb8852e4d	I prefer the self-checkout	Я предпочитаю самообслуживание	audio/sentence_i_prefer_2716107e.mp3
f222fa1c-7a4d-4fea-bb42-b386659724b2	0c2979c4-811a-4eb4-8d40-4cceadaead77	The till is broken	Касса сломана	audio/sentence_the_till_b25cb99e.mp3
b92175a3-008c-4aee-b987-5c871505f2ef	7692f01d-c036-42d0-8a8c-eb31ed0e43d1	Here's your receipt	Вот ваш чек	audio/sentence_here's_your_9616bf30.mp3
ab874441-3683-4937-bd05-0039f7b33999	70f73962-1faa-47ad-8f5b-25c3f0efdb60	How much is this apple?	Сколько стоит это яблоко?	audio/sentence_how_much_41007919.mp3
2df9b6c0-9a11-4127-938a-5acfbe386b43	c0f0f2eb-549b-4a3d-ba0d-5334033e2ef8	How much does it cost?	Сколько это стоит?	audio/sentence_how_much_b73f0b73.mp3
ccdbb7aa-02c8-416f-a711-e93af5d9ebd5	6c882398-3435-44b1-b6dc-120a30067412	What's the price of this bread?	Какая цена этого хлеба?	audio/sentence_what's_the_67bdfb69.mp3
e5471271-6bc2-41e4-81c4-cb7a9d0b9896	7f58a005-dc8b-4d80-8d94-5bee858c7d1b	What's the price?	Какая цена?	audio/sentence_what's_the_c99f0bac.mp3
127ac6bf-0919-47d1-a8a3-de1f72476f98	f675d0bd-a707-4a00-a559-17de192ce307	This is too expensive!	Это слишком дорого!	audio/sentence_this_is_b246133f.mp3
d29db4e0-7802-4933-8db7-2baa8acdccd3	a69f1cc5-9614-4f92-b4f0-cb96e01051de	This is very cheap!	Это очень дёшево!	audio/sentence_this_is_6bedbf0a.mp3
27035098-2ff6-47f2-bc16-0b792322da00	488a4a7f-65be-4d60-b47e-c016fce8ad36	It's a little bit expensive.	Это немного дороговато	audio/sentence_it's_a_f586829f.mp3
ea1700a1-6066-4460-a16e-81ab06605b70	c6935bd3-f123-49a2-ac28-9b6ea75ba810	That's a reasonable price.	Это разумная цена	audio/sentence_that's_a_40bdcb86.mp3
2211f328-ac2f-498b-8457-712a8f9b4fb2	690f2f41-174c-4aee-8f0e-2d06f97ac0ec	I got a good bargain.	Я совершила выгодную покупку	audio/sentence_i_got_22eb785a.mp3
cfda1afb-bf50-4a7e-b054-b30256c04cd6	f384d4e8-86c0-4869-9a66-bdfbecfdeefc	I think it's overpriced.	Я думаю, что это завышенная цена	audio/sentence_i_think_8bcc5e19.mp3
8ed28ccd-81a2-4ace-95ba-8dd9d0947617	8d4d31c9-40d9-414b-af41-81d04f97e5d2	Is this affordable?	Это доступно по цене?	audio/sentence_is_this_6827361d.mp3
233ee9f2-d99f-4140-83cb-d7fda9c41321	aa817426-daed-458b-b91f-24bbdf258cda	Can I pay by card?	Могу ли я заплатить картой?	audio/sentence_can_i_abd48165.mp3
3c1534eb-b431-4329-861a-c420172bb7e3	7d1fe5ef-a3e3-4543-a3ed-051ab44bcf95	Do you accept cash?	Вы принимаете наличные?	audio/sentence_do_you_d68b579f.mp3
aa06223a-5774-4fb6-aa04-aa00cd8c982b	846e881b-f1ad-4300-ab6d-502f3922357b	Do you have any discounts?	У вас есть скидки?	audio/sentence_do_you_1b44afa4.mp3
1e81c12f-08eb-4bd2-884b-fb4d14d4b0d2	6728dc4a-9c20-43d1-9397-2d62edfc79b0	It's on sale.	Это на распродаже	audio/sentence_it's_on_1d9498e4.mp3
b935a2cb-bc3a-4183-9850-fe45de6fc738	df120169-884c-4c70-a6f1-ba351582419c	What's the total?	Сколько всего?	audio/sentence_what's_the_efa49b39.mp3
0b7591f6-bb41-4d91-a5f2-31ca159f0c2a	0541b492-8241-4ead-af2b-8ebe0e01e7cf	Can I have a receipt, please?	Могу я получить чек, пожалуйста?	audio/sentence_can_i_83c29a15.mp3
059d26c3-7c2c-4da0-9d28-ff39010a8d58	9b9555ac-ff57-4868-8d48-1106377dad66	Can I look at the prices?	Могу ли я посмотреть цены?	audio/sentence_can_i_99b50384.mp3
9a26f9ab-1a3e-46b8-86db-1e16eb398c70	c0124f64-aa40-4979-9881-25a6976615f8	I'd like to buy some milk.	Я хотел бы купить немного молока	audio/sentence_i'd_like_744ac367.mp3
44f2b046-6d67-4c37-b929-fbf37b911b3c	ccdef437-eeb9-4346-8975-86a94b465459	I'll take these apples.	Я возьму эти яблоки	audio/sentence_i'll_take_34d8aed6.mp3
bf2e01d7-47cb-405f-9065-12d22efd0922	31fa15c7-621c-4f23-926e-eb69f9c2b13e	It's a bit pricey for me	Это немного дороговато для меня	audio/sentence_it's_a_275b2b1e.mp3
ef97ef44-60c3-497f-ae1c-13ded6444f54	cdbedd7f-d65e-46f4-a8b7-58a59f9fb00e	I need to go to the grocery store	Мне нужно сходить в продуктовый магазин	audio/sentence_i_need_3938ed4b.mp3
b24d5d2a-e2e8-4101-8440-4b80e24f116d	a032a9f4-696a-44f9-9072-c5a33c92b891	Do you have a shopping list?	У тебя есть список покупок?	audio/sentence_do_you_3b1d7f1c.mp3
1b4f872a-4cc7-447f-a4e4-b80c919497ff	1ceef11b-1a02-4f7d-b61f-b8825a282102	The bread is in aisle 3	Хлеб находится в 3-м проходе	audio/sentence_the_bread_2aba8866.mp3
c631b569-9497-42ae-9131-64fbdad2cd49	a5897aa3-91e5-43c5-b918-af22682965a2	Let's go to the checkout	Давайте пойдём на кассу	audio/sentence_let's_go_5631f63e.mp3
b6beb07f-e60c-464f-a04d-9844241a4c85	ce9cbfa3-614a-4012-95f0-92f6ca2d47b6	The fresh produce section is over there	Отдел со свежими продуктами там	audio/sentence_the_fresh_e238d356.mp3
9d7d24e0-a300-46bb-b2a5-7342a728db95	a33d091f-39d7-4fb7-bd29-289497f45826	We need some canned goods	Нам нужны консервы	audio/sentence_we_need_2f81ba4e.mp3
fcc383df-3d63-4674-8e85-85468507163f	4feded42-5130-492a-8860-ffc5d11d286f	The dairy products are in the fridge	Молочные продукты в холодильнике	audio/sentence_the_dairy_b02c8a17.mp3
b0e2fbc7-fd99-4875-b4ed-6e1050c6c0d1	a8127b66-3bd3-42bc-a757-ed42f2c8c2c2	I like buying frozen foods	Я люблю покупать замороженные продукты	audio/sentence_i_like_4e5d50f0.mp3
2df0402d-4508-410e-a8f4-151793fe5815	6ac567cc-2f8f-431e-97f0-bc8733ab9ffd	The meat counter is very busy	У мясного прилавка много людей	audio/sentence_the_meat_41a0d688.mp3
550de26f-fd88-450a-9a61-13cc8fc333df	00a17d17-8453-4ae7-87b9-09b30f534a6e	There's a long line at the checkout counter	Огромная очередь на кассе	audio/sentence_there's_a_3d64bd56.mp3
80735c97-360a-483b-89ea-97badda3b456	7e9cb3fb-8526-4bd3-8fe2-04f038ea0996	There's a discount on apples	На яблоки скидка	audio/sentence_there's_a_87e8dd8b.mp3
d03db9b9-d05c-4801-80e1-9e4cac1a0a39	452e7b2c-d94b-4fee-a04b-31eac0a886ff	How will you pay?	Как вы будете платить?	audio/sentence_how_will_69f6b7c8.mp3
65371d79-d50c-44bf-ad89-8880cfe94a5c	8fd80cbb-bc29-466d-b582-7afce75256f7	I'll pay by credit card	Я заплачу кредитной картой	audio/sentence_i'll_pay_8bdd73cb.mp3
9e879f88-4691-4b29-9824-e659bbd6be7d	4f79a7ab-a40b-4c79-81a0-81c8f4269b29	I'll pay with cash	Я заплачу наличными	audio/sentence_i'll_pay_1cdac612.mp3
106995f7-c96f-4157-b25f-a38b5d890b96	0ebc95d6-50df-404e-a53d-d32fa15a1a30	Here's your receipt	Вот ваш чек	audio/sentence_here's_your_122f5bb9.mp3
44dd169f-4d68-4733-a851-974f3cc45685	9deb433e-56dc-4f72-84d4-d676c38550e6	I'll use the self-checkout	Я воспользуюсь самообслуживанием	audio/sentence_i'll_use_bfb7619f.mp3
55674ec1-d93f-4ce4-892a-b863519949e5	6c874159-f491-4afd-8a7d-3251736ed778	Scan your items	Сканируйте ваши товары	audio/sentence_scan_your_0a0a6b5c.mp3
c8585575-71dc-449d-baca-4e55709a3ef8	27248749-0ce7-45b2-a5c2-63141ea1e801	Pack your groceries carefully	Аккуратно упакуйте ваши продукты	audio/sentence_pack_your_dda0c64a.mp3
7a91743b-def1-4094-922d-75942ebbcbda	7d8ad0d0-42ec-4374-ac46-95f8b995edf5	I bought a lovely souvenir from the market	Я купил прекрасный сувенир на рынке	audio/sentence_i_bought_26986ed0.mp3
cec12e75-b8ae-4805-baf3-46becff37ebc	1204f12e-1966-4c0c-9be8-795f74020130	I found a tiny silver ring	Я нашла крошечное серебряное колечко	audio/sentence_i_found_075a93c8.mp3
a18b8e7c-0c3c-4fc6-a416-2f141e45f732	e0c52d3d-1ab2-48bc-a2b6-8fec59abea1a	The local market has amazing crafts	На местном рынке продаются удивительные поделки	audio/sentence_the_local_c096eff9.mp3
a3f71c98-e076-4086-9eb6-7b95af4f9b55	dcf4c13e-6406-4d51-8f8d-11677b714cbd	I like to haggle for a better price	Я люблю торговаться за лучшую цену	audio/sentence_i_like_0418d0e0.mp3
4620c241-aab7-4190-bf61-a756e49a8a83	622fda80-f4b0-4f2d-bcad-e863a5d3953e	That's a real bargain!	Это настоящая выгодная покупка!	audio/sentence_that's_a_5c2b1593.mp3
731c4a62-4fe7-45a5-8542-304811efcc92	b87d05bf-f6f6-4ff4-8bcb-d51f99c45f74	Let's bargain for a lower price	Давайте поторгуемся за более низкую цену	audio/sentence_let's_bargain_257ab583.mp3
a361fee6-830d-4789-b509-86d19f859508	92121269-336f-4a81-99b8-9988c0b53b25	We negotiated the price down by 20%	Мы договорились о снижении цены на 20%	audio/sentence_we_negotiated_cd75da0c.mp3
a3e44b1f-c217-4e52-8102-f1f447313de6	db63b081-1aa8-400f-838b-d7a94f89d8f7	What's the price of this?	Какая цена этого?	audio/sentence_what's_the_bdb8f82c.mp3
e94638cf-9253-48ec-99ee-6495733bcf4f	e9be2d90-3dd7-441e-be03-66b8fdd7b4e7	It's very cheap!	Это очень дёшево!	audio/sentence_it's_very_45db8679.mp3
8ffe0d51-3e6d-46dd-85fb-edd2f1101127	c274aed2-1b65-49d7-8ffe-dbde79987519	That's too expensive!	Это слишком дорого!	audio/sentence_that's_too_fe0eb4c4.mp3
e97fed6f-1ece-420f-9497-6bb892b63dc5	45912b94-59ba-4ae4-a217-e7b7b4d69206	That's too much money	Это слишком много денег	audio/sentence_that's_too_b5860828.mp3
5862666b-6d25-4018-8ade-68a326e46bb9	0c4f7a6f-59fa-4822-8191-03b2cab1341a	That's a reasonable price	Это разумная цена	audio/sentence_that's_a_bad63182.mp3
5f0ea631-b21a-44f8-9b97-d0c5c0b1f884	7e8715ee-32a2-4b28-9311-d8d7280efe35	I think it's a bit too much	Я думаю, это немного слишком дорого	audio/sentence_i_think_2e4a4c1b.mp3
b2c8bbcb-c1f8-4b5d-8ce4-349a8f71205a	71a75362-63a9-4679-97c0-cbae149c19f3	Can you come down on the price?	Можете ли вы снизить цену?	audio/sentence_can_you_1b90ca05.mp3
3227dea2-ca3d-4b82-947e-8d6dd8a9748e	e89521b1-56d1-49e1-9e23-292a7d7b16eb	Could you do it for a little less?	Можете ли вы сделать это за немного меньше?	audio/sentence_could_you_9ec439f6.mp3
5da68387-b7fa-4912-a2cc-ce52441fd838	b7276086-621d-4d58-8578-ff699a3262f9	I'll make you an offer	Я сделаю вам предложение	audio/sentence_i'll_make_8c34cc63.mp3
5fddc8c5-0e8b-452e-85cb-d77e56cd9858	077a73e4-1492-4bc0-b4b0-e94045975564	I accept your offer	Я принимаю ваше предложение	audio/sentence_i_accept_3c6c71c3.mp3
ac061280-ca69-4ca7-a61e-8e7b575d3927	3de6652c-0f13-4ce0-b4e5-07b996ef2772	I'll decline your offer	Я отклоню ваше предложение	audio/sentence_i'll_decline_aca09d6a.mp3
9d9986fc-16ad-4801-a515-d9c4e42907a2	e8ef1297-54eb-4431-8448-62fcbe1980b0	If they won't come down, I'll walk away	Если они не снизят цену, я уйду	audio/sentence_if_they_f631aa45.mp3
38f722f0-4794-4cc9-9c9d-38463f698f28	c4524b8b-08e4-4edc-8d64-5ac32fbc8694	I think it's worth it	Я думаю, оно того стоит	audio/sentence_i_think_70d35034.mp3
20e0cd9e-cd30-4aae-a26b-980bd2f06694	a586001e-9ebd-429a-ba88-c078ca3ccfc6	It's good value for money	Это хорошее соотношение цены и качества	audio/sentence_it's_good_cf5575c9.mp3
12f35bcd-69bb-4ad2-beca-ed4a8957c286	e328395e-c4fd-4a91-b9a5-dcc045331e0e	Haggling is worth a try	Торговаться стоит попробовать	audio/sentence_haggling_is_f182b75e.mp3
83bf7deb-9bba-4bb6-bcde-d931fd035c5f	74bc7221-0143-40d4-bb80-d3906c853a08	Okay, I'll take it	Ладно, я возьму это.	audio/sentence_okay,_i'll_42bfecb1.mp3
1f672164-a912-4441-b39f-685c10efb471	f6e2ed3a-2f06-4b6f-8ddd-b81d88abb24c	I bought a lovely souvenir from the market	Я купил чудесный сувенир на рынке	audio/sentence_i_bought_afd82980.mp3
ce293983-76c0-43b1-b185-ede1d55faa3c	a09b2f04-f2ae-4be1-a2a8-1c0d6cb70d2a	This scarf is handmade	Этот шарф ручной работы	audio/sentence_this_scarf_ffe01384.mp3
68ff8fea-5252-4f7c-aa4d-6e56522270d6	b2115373-0c89-4545-a245-233a3610b1da	I love browsing the local crafts	Я люблю рассматривать местные ремесла	audio/sentence_i_love_db352342.mp3
4e17c5ec-8667-4fc8-bce6-e6380d4bbedc	4e376a43-be1a-4fe7-8937-effc5c7f472d	The market stall sold beautiful pottery	На рыночном прилавке продавалась красивая керамика	audio/sentence_the_market_e6e89aff.mp3
1ae0ecdf-9e10-4c42-9e0b-5ab6c3e7f0b5	51ca6d42-bbbf-49ee-afd5-66e041eb2e0b	I got a real bargain at the market	Я сделал настоящую выгодную покупку на рынке	audio/sentence_i_got_3df2dbb5.mp3
a2777d17-3a4e-4af3-b656-9babe2490c98	5a6d9aed-b347-4696-96a1-2e78054e10e3	I picked up some gifts for my friends	Я приобрёл несколько подарков для своих друзей	audio/sentence_i_picked_d3355d1a.mp3
867f20c1-77d3-495c-8cfb-94b07b48b7d4	28919c89-4852-4591-b5a5-7bfb24271922	I like to browse the shops before I buy anything	Я люблю просматривать магазины, прежде чем что-нибудь купить	audio/sentence_i_like_4ffdf7df.mp3
7f684483-b38d-441c-9fc3-e0b35ade5e66	a4e1a4e8-7493-42ae-b6f2-8f5af8f58660	Let's look around the market	Давайте осмотримся на рынке	audio/sentence_let's_look_ffe30da5.mp3
7ae0db02-1331-4359-8dd2-8b593389c3a0	c87e34d8-d837-4010-a6fe-b9f564cf2214	The souvenirs were really cheap	Сувениры были очень дешёвые	audio/sentence_the_souvenirs_5664d9f4.mp3
e709606c-1d79-4e38-a509-1b732452117d	86a9dd51-d230-4252-ae6e-6caab11cfc97	This item is too expensive	Этот предмет слишком дорогой	audio/sentence_this_item_9a208379.mp3
83dd859d-78a0-4ab6-a92d-0d622cf59468	b9418bc1-3e29-4247-b031-efe1358a2505	It was expensive, but it was worth it	Это было дорого, но стоило того	audio/sentence_it_was_4201b5de.mp3
dc5ad77a-49f4-4289-aeb2-95bd3335be92	d5a47419-e545-419e-a616-75d711201934	That necklace is definitely worth buying	Это колье определённо стоит купить	audio/sentence_that_necklace_a41d805b.mp3
b9d63889-e915-41bf-8519-b4cebb9a0d0b	2ece545f-de0b-4d02-b2ab-3a02e4f16d51	I wanted to buy something unique	Я хотел купить что-нибудь уникальное	audio/sentence_i_wanted_efbe3d4b.mp3
6da0c0db-2b2a-4335-a649-346b07d8b1e8	7ea8d0e7-8880-4c71-b0dc-dff2ef2ea23e	I bought some traditional crafts	Я купил несколько традиционных ремесленных изделий	audio/sentence_i_bought_6e2bc239.mp3
6ada6113-3a6d-4fea-aef0-d18fbe5b7b0f	e9c25338-6013-42a0-951d-934f05996635	The pottery is beautiful	Керамика красивая	audio/sentence_the_pottery_7e81748c.mp3
bc0fbe62-9e05-46f1-847b-5dcf6506a858	70843f90-7e60-44d6-be87-c6b4fbdfa68e	The view from the top was stunning	Вид сверху был потрясающим	audio/sentence_the_view_a5a5270b.mp3
3a70239c-d42e-4259-9c40-9e5a72695fc9	cc7d3de2-dc26-48fc-bcab-2346803ba60a	She's wearing a gorgeous dress	На ней великолепное платье	audio/sentence_she's_wearing_4c90ff3a.mp3
776b4901-b95d-40db-884b-a4b57d3f4051	b73a3d86-b95a-483a-85f7-eb3e7a14c58c	That's a lovely scarf	Это прекрасный шарф	audio/sentence_that's_a_0a773e08.mp3
3d3a14a9-8959-4fd5-8f3a-023ae95bc16f	bee9dc96-e4ab-455c-ac5d-31ab02e2d3c2	This is a perfect souvenir	Это идеальный сувенир	audio/sentence_this_is_3d30f830.mp3
256913ef-f861-4a7b-8c95-ede67d059f90	d7019429-4bfe-42de-9d53-0dbb5618c50e	It was a delightful experience	Это был восхитительный опыт	audio/sentence_it_was_feaa78fc.mp3
6ac7082e-ea75-4886-87c5-281b18c1e358	71864cd1-38d0-4fdb-b3d6-f48b944e13dd	I bought a small wooden doll	Я купила маленькую деревянную куклу	audio/sentence_i_bought_86127723.mp3
759637b8-b669-4ae0-8f5d-09ecc93f5581	81603969-7933-481c-870d-95d8a9491446	This bag is too big	Эта сумка слишком большая	audio/sentence_this_bag_7a0b94ba.mp3
dad4477c-a02e-4598-9197-05e322661d0d	aa2a52c3-a6af-43dd-851b-3bcca0fbd1e2	I bought a lovely souvenir at the market	Я купил чудесный сувенир на рынке	audio/sentence_i_bought_dd9a07ce.mp3
0d38b71e-cf6e-49b6-beeb-7ddf531ea21e	fd1e8b4d-0058-45de-8fba-42162d792b9e	The market is full of colorful souvenirs	Рынок полон красочных сувениров	audio/sentence_the_market_3072153c.mp3
bc8a1a4f-587b-4b04-a484-380846448572	d97b7649-79b8-44ed-a31f-b916c7e592f7	What size do you need?	Какой размер вам нужен?	audio/sentence_what_size_12a5d962.mp3
eedadb17-37c2-4516-9cc4-f69a70cd7b6e	12177209-1b93-4d85-84df-962a7428fc2b	What color do you prefer?	Какой цвет вы предпочитаете?	audio/sentence_what_color_5c6d5e78.mp3
0e5c0a51-cc24-4a50-8342-0eac5b80d494	1676b628-adcf-439f-9fd4-3dd4819d7f6c	What is this made of? What's the material?	Из чего это сделано? Какой материал?	audio/sentence_what_is_fb8d2090.mp3
f09cafa3-9e83-427e-8a1b-75e5d0018a4f	f32dddae-ec87-4d5a-ac7e-42935d488c29	I'm looking for a small wooden toy	Я ищу маленькую деревянную игрушку	audio/sentence_i'm_looking_b55cd0b6.mp3
50f63499-01be-491c-a149-12197157e1ab	0f73cf74-d4f7-4987-a2d5-3fc8c6d43374	I need to pick out a gift for my friend	Мне нужно выбрать подарок для моего друга	audio/sentence_i_need_d20ff333.mp3
5c04cebd-ce13-48c3-882f-9a8d35df22b5	0c7ae404-abdc-4f25-8b0c-04a4e8a12229	I like to shop around before buying anything	Я люблю сравнивать цены, прежде чем что-нибудь купить	audio/sentence_i_like_09e6aa39.mp3
b24b3350-8b7a-497f-a71d-f5957745cbc9	d3392c8d-e101-442e-872c-cb8b8f3fdd83	Don't be afraid to haggle for a better price	Не бойтесь торговаться за лучшую цену	audio/sentence_don't_be_d2f04118.mp3
de3d7d52-28ee-49c3-a2e5-51acd7ef06da	8f8ec64e-e89b-4ba2-93ff-2a1f29f83339	This is too expensive for me	Это слишком дорого для меня	audio/sentence_this_is_0697d779.mp3
817a7343-6a89-4116-bfb1-f4359d296825	c71db2c9-7df3-4992-b32c-63e12116f833	It's a bit pricey, but it's worth it	Это немного дороговато, но оно того стоит	audio/sentence_it's_a_ecc3fd52.mp3
b4eb34f0-8f18-47d1-bd41-1a56bf610c90	bcf2783d-9255-4d01-a02c-9679de69c8bd	That's a reasonable price	Это разумная цена	audio/sentence_that's_a_b3d589ef.mp3
5ffcf64e-dbf3-4719-83ce-09dc08203427	0267d5e4-a2dc-4031-a15e-eb12a6de064d	This is the perfect gift for my daughter	Это идеальный подарок для моей дочери	audio/sentence_this_is_a358d366.mp3
dd17c554-4004-4585-967f-db58cc895555	19c48a06-0f98-4cc2-9878-aef43e5d38d6	I want to buy something special	Я хочу купить что-то особенное	audio/sentence_i_want_9fa674f4.mp3
2e1b555f-8fa4-4387-814e-f72770e2f565	b446a4c7-23e3-4da0-b9bb-c98e3f311532	Let me check the price	Позвольте мне проверить цену	audio/sentence_let_me_394ae51f.mp3
6a5d98af-e2bf-4cbc-9268-f2a83bc6e788	a5ccb91e-9ba2-49bc-854b-560ce8974d38	How much is it?	Сколько это стоит?	audio/sentence_how_much_1a20e6e9.mp3
3a5cddc6-4a43-4a58-bd57-0c08ea2bf122	4204fe37-6f80-434c-ae42-ace3b81c8ee1	Can I pay by card?	Можно ли оплатить картой?	audio/sentence_can_i_7f1b69cd.mp3
ee0f6af1-72ab-4cae-92ce-2b79512a9015	790ac9a3-9d44-4207-bdc2-081ba538dd2b	They have different sizes available	У них есть разные размеры в наличии	audio/sentence_they_have_2e2ffd57.mp3
b7f91de8-fa67-43f3-b52f-9738ed9929eb	fc38f28e-8c42-41a9-a614-e249180f438d	They come in various colors	Они бывают разных цветов	audio/sentence_they_come_a01fab87.mp3
53c07472-58da-43fe-aff3-28e1cf7a69af	88105525-3265-4e38-a5dc-7c70752393ca	They have a wide range of souvenirs	У них широкий выбор сувениров	audio/sentence_they_have_34b14a8b.mp3
0a29c9ef-8cb6-4c9e-a135-883c5ec9968f	3e8389d6-9c0e-4561-b13b-8e943b298287	I want to buy a silk scarf	Я хочу купить шелковый шарф	audio/sentence_i_want_d1a0a0e0.mp3
31ebbc57-412a-4c2d-b3f4-63d9f06831e4	27ec8b14-ebe2-4573-974e-3375afce6d65	This cotton shirt is very comfortable	Эта хлопковая рубашка очень удобная	audio/sentence_this_cotton_506e75b0.mp3
8d396f6d-3fb8-4b68-a77b-1898878de25f	83f22592-bbb1-4440-9d9e-d5c96d542821	That wooden carving is beautiful	Эта деревянная резьба прекрасна	audio/sentence_that_wooden_05157a9a.mp3
2cd79297-22d1-4d29-8ad9-240cf5e54be7	880b36ae-8e44-4dc8-8f8b-f5e1b7ced427	I'm looking for a leather bag	Я ищу кожаную сумку	audio/sentence_i'm_looking_086aafe0.mp3
2a08b849-3baf-4f3f-a57c-3f195f117b9c	47952c3a-1f07-417f-9f60-53379e33a962	I'd like to make a reservation for two people	Я хотел бы сделать резервацию на двух человек	audio/sentence_i'd_like_285c56ed.mp3
b3c6f3a6-e9f4-4187-9742-bf3e9f17b387	60232f3a-a752-4485-a7eb-7f5340dbb281	We need to book a table for tonight	Нам нужно забронировать столик на сегодня вечером	audio/sentence_we_need_43319d94.mp3
38eae492-e494-48f6-8a27-dcbb5f9de7b4	9de687b5-2301-4a13-856c-86192465bcdd	I've made a booking under the name Smith	Я сделал бронь на имя Смит	audio/sentence_i've_made_0b455e40.mp3
86a4279a-3df7-4b80-b080-e9468a3db0c9	cdcf6c92-c9b4-453b-b19c-2bb2ce76db7f	Can you confirm my reservation?	Можете ли вы подтвердить мою бронь?	audio/sentence_can_you_853f4603.mp3
1724821f-fb44-47ee-86e9-cb61bfd7e187	faa408a8-ec62-480a-9778-a4d2560ce498	I need to cancel my reservation	Мне нужно отменить мою бронь	audio/sentence_i_need_6ee0e039.mp3
47c893eb-7495-49f9-8cbc-e6c87e15be38	e6a0cbd3-b248-42af-a829-d4df732dcec1	We have a table for two	У нас есть столик на двоих	audio/sentence_we_have_a5a12649.mp3
65729ab1-3f0a-4ceb-bf12-3202af8dd579	c70c9b25-fcb1-4407-b3fd-00a8dd3a69c7	What time would you like to dine?	Во сколько вы хотели бы поужинать?	audio/sentence_what_time_1ca3fc40.mp3
b9caa6e5-0564-4deb-a83a-8b6a397c02df	9a55c0bc-7159-47c3-9063-d650c84643b8	What date is your reservation?	На какую дату ваша резервация?	audio/sentence_what_date_c9f2698a.mp3
6258ae84-3048-4a02-8b3d-0f83c39f8334	e6335cd3-5992-4516-b07e-fda05863d1cf	What time is your reservation?	На какое время ваша резервация?	audio/sentence_what_time_cf4f5bd1.mp3
ea747a41-4202-40d3-af10-e8700db9362f	1dcfc0d1-486f-4737-9ff6-ef33e5dcb2a1	We prefer to dine in rather than take away	Мы предпочитаем пообедать в ресторане, а не взять с собой	audio/sentence_we_prefer_e9b91570.mp3
3fdba2a6-e1fc-47b3-a125-b9ae29ff5262	b987598e-8304-443a-885e-d7afbcef567d	What is the restaurant's dress code?	Какой дресс-код в ресторане?	audio/sentence_what_is_51c5400e.mp3
210656ab-b6f0-4adf-9df3-2de8fbb0a6b2	0ae303cf-c766-4111-97b0-69acfd16858d	Can I see the menu, please?	Могу ли я посмотреть меню, пожалуйста?	audio/sentence_can_i_b7f964d8.mp3
a1424737-21a3-4a13-b142-fa62d4a51d2c	440ba0c1-80cb-41dd-8ece-d4b5abb6aad0	I'd like to order the steak	Я хотел бы заказать стейк	audio/sentence_i'd_like_788d2e18.mp3
f0a3303f-92a5-416b-a98a-b710a1e7f804	95413b0c-2edc-48fa-92c8-e16df887606d	Could we have the bill, please?	Можно нам счёт, пожалуйста?	audio/sentence_could_we_5ea86545.mp3
b1666f65-8ffa-4685-90d3-43f641f4b43a	ce7dbcab-7272-4264-81ee-60e91cfa3fca	Excuse me, waiter?	Извините, официант?	audio/sentence_excuse_me,_34ab8707.mp3
672213c6-88b3-4cb1-b547-9a4809734cc0	7d78a6c9-6935-4223-9801-aae2da9911c6	Do we need to leave a tip?	Нужно ли оставлять чаевые?	audio/sentence_do_we_9b214bb3.mp3
8645fadf-cdc1-4791-9da3-05b19dabfe9a	f6622e4f-6ece-4ac0-828f-864d0c8f9c9d	Enjoy your meal!	Приятного аппетита!	audio/sentence_enjoy_your_70153f9c.mp3
4daf5062-7fcf-4650-9ea5-0a4d428756b9	ae70c14f-6c51-4593-abba-34c91e4cb4c2	The food was delicious!	Еда была вкусной!	audio/sentence_the_food_0a4cfe6b.mp3
aa4f83ef-d79e-4a92-a7a9-3637090f92da	ec548648-6f9f-42a9-87fb-a8ebaa1c2350	I feel unwell	Я чувствую себя плохо	audio/sentence_i_feel_3332063d.mp3
a6b365ee-c512-4b46-8984-163b0d64be77	74868d2d-00e8-4059-8834-b7a9355bec13	The service was fantastic!	Обслуживание было фантастическим!	audio/sentence_the_service_fe315c51.mp3
9d49de66-30ea-4c08-8b46-6924bb966e11	187628dd-a880-426d-b8da-9240cf3bc5fa	Can you recommend a wine?	Можете ли вы порекомендовать вино?	audio/sentence_can_you_05149eb4.mp3
fac4849d-2a1b-43ed-8676-731280255dee	6c589c43-a278-497e-9a16-63b53887c67d	I have a seafood allergy	У меня аллергия на морепродукты	audio/sentence_i_have_87175258.mp3
087881d7-032d-46e0-bde3-cd52f93f4d41	0a21e3ea-4cfd-48dc-8012-e011391dec8d	What is the daily special?	Какое сегодня блюдо дня?	audio/sentence_what_is_2309c980.mp3
e9d2243b-886b-4795-a191-47f706e786af	bfc4ba97-aef7-4ce8-8b30-d57ffa71524d	Would you like an appetizer?	Вы хотели бы заказать закуску?	audio/sentence_would_you_91bd4e2d.mp3
b1137bc5-27dd-46a5-a09d-6a7385870157	2b93d4e2-12b0-4791-9413-46189e4ea04c	What is your main course?	Что у вас на основное блюдо?	audio/sentence_what_is_ea3a2661.mp3
ec343f11-d111-42bd-9779-0e09ff9bc2de	9087567f-4bff-4ffb-b761-73b98f78aa64	I'll have the dessert menu, please	Пожалуйста, меню десертов	audio/sentence_i'll_have_58c8de68.mp3
ef376bf6-4682-4d40-9b86-caed097ccf12	1e021e13-af55-4c46-ab06-dbbc0daa4478	May I see the wine list?	Можно посмотреть винную карту?	audio/sentence_may_i_ffe6eb7c.mp3
bcfbf749-26c8-45a7-a0d3-28e9d6680118	155fdffa-edca-4319-beb1-d23a0c339b13	Do you have any non-alcoholic drinks?	У вас есть безалкогольные напитки?	audio/sentence_do_you_dc0740bf.mp3
a0fa52d0-bfd4-4909-89b9-f35ea9fb966a	01c56e0e-58fa-4b99-815a-530a3bde4c45	I'll pay by credit card	Я заплачу кредитной картой	audio/sentence_i'll_pay_971a47cb.mp3
6ffd07f5-5387-4fe7-929b-96afe5424d20	a39eb5fb-62eb-47fb-91c2-9e4066e6efd9	I'll pay in cash	Я заплачу наличными	audio/sentence_i'll_pay_cb257ed1.mp3
fa1dda73-f365-43c7-866b-0bbcfccd6d36	3c1e893c-044f-49bb-93b1-6d9efae5bc7c	Can we split the bill?	Можно разделить счёт?	audio/sentence_can_we_42063094.mp3
517601b3-3c0f-4e39-9d36-b60363123f1c	0d7e35a2-7762-4a9c-a2e1-c5099e541c9d	Can I leave a message for the manager?	Могу ли я оставить сообщение для менеджера?	audio/sentence_can_i_f51f6a0b.mp3
05367cf9-2e5a-44c3-a16f-96144d3a70bf	540abd02-4794-4d51-8f47-d9eb2fafa855	We need a table for two	Нам нужен столик на двоих	audio/sentence_we_need_e603f5ee.mp3
18946311-07d0-4859-9aaf-a0e87f9726c2	8c0ded21-2bee-4c09-8d00-90b78e99163d	Excuse me, waiter!	Извините, официант!	audio/sentence_excuse_me,_7df4dcaa.mp3
4fc40c51-277f-4791-a52d-08d6abc33abf	02128302-d7d5-486e-ae75-5e5dbebd721d	Can I see the menu, please?	Можно посмотреть меню, пожалуйста?	audio/sentence_can_i_7b8b5a04.mp3
df2c6179-40e5-4d9e-9c9c-fa87e4b3b4e4	db335bde-285b-4e60-8403-b7add02824ed	I'd like to order, please	Я хотел бы сделать заказ, пожалуйста	audio/sentence_i'd_like_674b86ee.mp3
0b9888db-6dd9-40f2-921d-e251f67e1593	e5f9a5a5-4485-440d-b916-02b7df843533	What kind of food do you have?	Какую еду вы предлагаете?	audio/sentence_what_kind_e843851d.mp3
878f2c0d-cfb2-4ac5-b43e-18bd9e564740	a8a033db-ba56-4fa3-a9b8-715175494c38	I'll have a glass of water, please	Я возьму стакан воды, пожалуйста	audio/sentence_i'll_have_ed73352b.mp3
92a533a0-496b-478b-b577-eb88f0f40243	1eee72b4-b8df-4cd2-88af-7b01bba5968a	Could we have the bill, please?	Можно счёт, пожалуйста?	audio/sentence_could_we_c48854cd.mp3
cc25c7a5-b369-4908-88d3-92e0b5a25939	ec6e197b-47fd-4a06-938a-44d76744bb6c	The food was delicious!	Еда была вкусной!	audio/sentence_the_food_7345a3dc.mp3
8d4d8fea-91a3-403b-81e0-931c6f0e540a	976b8e21-8399-470e-8d18-fe0ff4cba394	This soup is very tasty	Этот суп очень вкусный	audio/sentence_this_soup_fc3cb712.mp3
195b4fa8-23b0-43a1-915c-4a3a6bf6db95	8fc7d942-aa2a-4bd9-8b66-96cc7d5c92f7	We'll start with an appetizer	Мы начнём с закуски	audio/sentence_we'll_start_037cc40a.mp3
af35fbea-6d78-4c51-90ec-6b2f49941403	758007e2-c168-4ff8-baef-d9456e5ad8f1	What's the main course today?	Какое сегодня главное блюдо?	audio/sentence_what's_the_59341cb4.mp3
975e7400-de1e-4345-94bf-715334704ce4	19eb857a-a311-49aa-bcd9-88d2689e9f16	What do you have for dessert?	Что у вас есть на десерт?	audio/sentence_what_do_64ebaa0e.mp3
6d0f3ae0-b305-4352-ae92-2375456c1ebd	37db31e4-15eb-47dc-897b-584f8580176b	Could you recommend something?	Вы могли бы что-нибудь порекомендовать?	audio/sentence_could_you_48a902a3.mp3
40ae8df4-c168-483a-b075-08019b22b07e	3e0d8da1-b4ef-4fdc-b418-fe1610027d70	The waiter came to take our order	Официант подошёл, чтобы принять наш заказ	audio/sentence_the_waiter_fbab20a7.mp3
63b9c2be-508f-41dc-a7e2-a2018a6cd8ed	85f0bfd8-d50f-48fe-b009-aaa9a6032ae7	Could you clear the table?	Вы могли бы убрать со стола?	audio/sentence_could_you_9fdddd5a.mp3
45a421cd-883c-4c9d-b059-d3a3f80acc52	62eed417-a632-4756-9207-42ec0c90c878	Could we have some extra napkins?	Можно нам дополнительные салфетки?	audio/sentence_could_we_748868b2.mp3
ca233d5d-014f-4f67-882c-9a7cd01588bc	f0a1c79e-39e8-46d6-860d-2d8c1dc357ce	Is service charge included?	Включена ли плата за обслуживание?	audio/sentence_is_service_f3117a55.mp3
5950c0ac-d719-41d6-86ec-c6aa7757681e	716e94ac-49a8-4369-b473-db18352322b6	I'd like to leave a tip	Я хотел бы оставить чаевые	audio/sentence_i'd_like_e436efa2.mp3
6045ae0f-7733-4d10-afd6-a2fe97969bb4	e9177f63-c10a-4588-a961-339234a7d1d7	I'm allergic to nuts	У меня аллергия на орехи	audio/sentence_i'm_allergic_bfd523a0.mp3
e25d73b3-3324-4fb2-bda5-b7b541975a94	5326ab4c-eedf-4bf1-a6fd-468daf61312c	I'm on a diet, so I'll just have a salad	Я на диете, поэтому возьму только салат	audio/sentence_i'm_on_937c41b1.mp3
c4b7786c-a922-4ad3-9bd1-1ae457b3327a	1869dbf1-dfb0-4ada-8b8c-a9e59b27e613	Could you bring me another fork?	Не могли бы вы принести мне ещё одну вилку?	audio/sentence_could_you_7af0530e.mp3
da3064ab-d736-491b-9662-76f1ee7a2530	56c30ae1-c76d-41f9-99c2-9ccdeee16aae	I'd like to make a reservation for tonight	Я хотел бы сделать резервацию на сегодня вечером	audio/sentence_i'd_like_45eee798.mp3
38d5a0c7-4e9e-4d1f-beb7-22cc38534d28	ec0915ff-7544-43a7-a369-7f8fc618f015	I'll have the steak	Я возьму стейк	audio/sentence_i'll_have_00b3c518.mp3
bd37080a-4616-4e13-8004-7d2d2560bee0	175537e3-3037-4f02-9d4b-6ac812efc21a	Can I see the menu, please?	Можете показать меню, пожалуйста?	audio/sentence_can_i_5ef4ef28.mp3
158d5bb4-09be-4b8f-a001-a7459f0b005d	a4dcfd2b-76c0-44fe-9f71-38e9a9d7d02a	What's your favorite dish?	Какое ваше любимое блюдо?	audio/sentence_what's_your_e93ff768.mp3
6900b6aa-477e-4598-b5f4-0cf4445ceb0c	11adee25-be1e-4590-9d88-721965d9ed64	Could I have another plate?	Могу ли я получить еще одну тарелку?	audio/sentence_could_i_e38a46f3.mp3
031b97ed-fae2-4f0e-966b-dbfb0c46558b	4b573971-7db8-4752-87ca-d9431509d9db	I'd like to order now	Я хотел бы сделать заказ сейчас	audio/sentence_i'd_like_1e762dc7.mp3
704791e7-6156-4581-aae8-bd240c3d9d24	28e14c78-1347-4422-b99f-3211254f058b	The waiter will take your order soon	Официант скоро примет ваш заказ	audio/sentence_the_waiter_40cc254c.mp3
95e4fc29-3d18-4ffe-8eb8-7d3aea0235d5	922a6218-6892-4bc3-a658-ca3c15632273	Do you have any specials today?	У вас есть сегодня какие-нибудь специальные предложения?	audio/sentence_do_you_b13f115b.mp3
58ab5a5c-8d45-44d5-a10e-950bd7f2ffd7	9adf92ef-d4fe-4489-b356-b383e9ad03a5	What would you recommend?	Что бы вы посоветовали?	audio/sentence_what_would_2403b545.mp3
166ad2b0-7711-47aa-a50c-86025c7b4161	f169e1b0-5f3a-4462-b820-6b489961fe06	We'll start with an appetizer	Мы начнём с закуски	audio/sentence_we'll_start_805dfeb9.mp3
0c283a3d-d7ca-4c08-b67f-e073110d7e09	dd2aa7a7-b75c-4080-969a-4538c99c0669	What will you have for the main course?	Что вы возьмёте на основное блюдо?	audio/sentence_what_will_abe4ed37.mp3
1a0af3b4-a8f6-455c-99e3-d64fe2587607	f4911896-15fa-4bf0-98b2-8184df4d3223	What kind of dessert do you have?	Какие у вас есть десерты?	audio/sentence_what_kind_a04576bf.mp3
d0468ef3-d7cc-4fd3-ba6f-5f1bcb3c4b27	a11e2406-9549-4c8a-864b-04d345c53e4f	What side dishes do you have?	Какие у вас есть гарниры?	audio/sentence_what_side_f2051b33.mp3
17565b58-a609-4d65-8ea1-91df29ff2c13	8e4d051d-2ead-49a7-a6d4-63331a96764e	Is this dish spicy?	Это блюдо острое?	audio/sentence_is_this_94457d0b.mp3
97956402-a6db-4815-a87c-751d09edcfd8	a80f4a42-3db9-46c7-b4f1-88e30f4f1c78	What are the ingredients?	Какие ингредиенты?	audio/sentence_what_are_4d967269.mp3
0bf3fc5c-ad3f-4262-9412-ed8fa1517b44	0b79161c-7ddb-4f90-8995-7bd9b563e8b1	I have some allergies	У меня есть аллергия	audio/sentence_i_have_d17daed6.mp3
84bc8d03-79b3-4f41-84fd-3f91bbb33dc1	6c3e1a73-d5a2-48c0-8f8a-5816f743d7d3	Do you have any vegetarian options?	У вас есть вегетарианские варианты?	audio/sentence_do_you_1cc74dcd.mp3
76ecb6d3-7f4c-48dc-be2d-21ab0705ce10	90c320ed-2b93-44fd-90e7-877ebdb0e76e	Do you have anything gluten-free?	У вас есть что-нибудь безглютеновое?	audio/sentence_do_you_a44b68c8.mp3
637d767d-082c-446b-b5d3-35b275cb5ee8	0a45dde3-03a1-4e12-8844-6a8acff22761	I need a dairy-free option	Мне нужен вариант без молочных продуктов	audio/sentence_i_need_cf7d7ffc.mp3
0842ab19-3ae8-48a7-8b2a-ab52be479cc6	cb859acc-e340-4797-a01a-845506f74e86	Can you describe the dish?	Можете описать блюдо?	audio/sentence_can_you_e38dc403.mp3
758c9833-dec1-4eb9-81c0-fad6bae91af0	84e9b2ad-c87c-4b27-a2bb-c595d058f791	How is this dish cooked?	Как приготовлено это блюдо?	audio/sentence_how_is_e044868c.mp3
82c29979-f05b-4ddf-b6f0-aa8838c65ad2	33d835b0-5f89-45b1-a112-fd01077c4f7e	May I see the wine list?	Можно посмотреть винную карту?	audio/sentence_may_i_68f3dfa4.mp3
a8e34194-d3de-42b7-bbcc-3bdc2e9b83bd	1e77e212-4f6d-4cbe-a1f1-4a1439824557	Could we have the bill, please?	Можно счёт, пожалуйста?	audio/sentence_could_we_3a13f00c.mp3
d9b84e1c-f01a-4771-9b17-eecb675c9bb7	0e121226-ad95-4359-b52f-ec8ad5cdc39f	Check, please!	Счёт, пожалуйста!	audio/sentence_check,_please!_e0571f87.mp3
ed64c25f-632d-4b62-b1a3-ec9960d64f2f	5ef27d52-45f3-42d7-ac34-d4f9bf2542cb	This is delicious!	Это очень вкусно!	audio/sentence_this_is_36a822ea.mp3
45539779-8cb6-4d8a-b5bd-ed0de4929cf1	39b88c1f-528e-4761-8f4c-cc23725e7c0e	This is very tasty!	Это очень вкусно!	audio/sentence_this_is_9637dbd3.mp3
9289de3c-34cc-48a6-ac20-44ad035e4b98	86a0023f-ee89-4ca7-9053-f1a6ba1544d8	Enjoy your meal!	Приятного аппетита!	audio/sentence_enjoy_your_c8aed937.mp3
06c9fc27-2884-4e47-af42-34161534744a	76dbeb9b-40b3-418b-bfe8-bb83ee30b6b1	Can I have the bill, please?	Можно мне счёт, пожалуйста?	audio/sentence_can_i_bd17170f.mp3
f2f89966-d245-4a89-af1c-f29f5ff11ef4	61578746-0a9d-44aa-9cc4-f9c2d38645e5	Could we get the check?	Можем ли мы получить счёт?	audio/sentence_could_we_4f9081a6.mp3
c302108a-d49e-4e3a-a214-8175b6efa986	8cb0f317-299a-4059-a5a2-7ae90088e31e	Check, please?	Счёт, пожалуйста?	audio/sentence_check,_please?_d3eaf909.mp3
08af3dd4-5575-49b3-b078-ab642090b3fc	69d40ffc-5982-40ed-95f7-85817bd29d02	Could we have some water, please?	Можно нам воды, пожалуйста?	audio/sentence_could_we_081b2294.mp3
f22fac8f-0e84-4839-a207-aa10e848632c	28b1ec90-11f1-4d5e-8d32-e050d4658fb3	I'd like some still water	Я бы хотел(а) негазированной воды	audio/sentence_i'd_like_69e37bb4.mp3
be3f1b1d-0710-4853-b074-22b705bf9beb	d6c4c032-b172-402a-8a7b-b1af03fdcff8	I'll have sparkling water, please	Я возьму газированную воду, пожалуйста	audio/sentence_i'll_have_1837ecc5.mp3
9802d940-2caa-457e-95d7-7370ac2d87ff	e6dff9af-2ab5-4003-857d-3dec191053bb	Do you have tap water?	У вас есть вода из-под крана?	audio/sentence_do_you_2d03fabf.mp3
251bc5fb-6785-4325-a152-d7a36bec00a5	d8192385-eed3-49c4-8c1b-6b55b005c007	Where is the toilet?	Где туалет?	audio/sentence_where_is_4d2d847b.mp3
c922c304-d2c8-4b78-841d-ec51e110a9ca	243872cd-9bd6-4f57-8ed7-01a1af313a08	Excuse me, where is the restroom?	Извините, где туалет?	audio/sentence_excuse_me,_1817db37.mp3
a58d1307-a655-496b-afc6-1a08dbf2e279	97e2118a-3bc1-4340-84ce-c9dd28b55955	Could you tell me where the washroom is?	Не могли бы вы сказать, где туалет?	audio/sentence_could_you_33d05792.mp3
c6a857af-cd79-4abd-8a56-e8dbb6e33040	057afa3c-f932-4923-bf69-a031189d2551	Where's the bathroom?	Где ванная/туалет?	audio/sentence_where's_the_c11f1289.mp3
d48b0eba-3c72-4401-a384-f9d3f2c2d238	d0c01a02-f4d1-4dec-bccf-27371930274f	Excuse me, waiter?	Извините, официант?	audio/sentence_excuse_me,_770a5acb.mp3
3748ca77-c059-498b-a85d-8978723eb4c3	12d6ddbd-fc6b-42d7-8617-762cb515f06f	Waiter!	Официант!	audio/sentence_waiter!_108bbb79.mp3
46688bcb-5dd3-4884-ad27-93222c4ae105	6bd12343-e8c7-4c96-9219-5d5b139978d1	Waitress!	Официантка!	audio/sentence_waitress!_0b3f6d59.mp3
ab12fd14-89f9-49ef-8c41-65b9a88b17c6	5242d6ee-bd05-4323-9079-582633ea76e5	Can I have the menu, please?	Можно мне меню, пожалуйста?	audio/sentence_can_i_3a447ff6.mp3
8db27e09-9861-4408-bbc5-e72d6ec63752	e94fccc2-95f1-4346-af38-f284475b5116	Could I have some more bread?	Можно мне ещё хлеба?	audio/sentence_could_i_0c370caa.mp3
3089a001-c3e8-436d-ba56-47850ae31373	ad3ad8fb-71ba-4db3-824f-1940caf4a558	Thank you very much, please	Большое спасибо, пожалуйста	audio/sentence_thank_you_0c6fb1ba.mp3
8a805988-4e5c-4706-aa61-1041fac9f6f2	3c121bfc-f06d-42cc-bd7a-d82dd08e7d9c	Thank you!	Спасибо!	audio/sentence_thank_you!_40b0af0a.mp3
807e1a40-bba6-43a3-938f-a21545e77a3d	24cbe610-8fba-4735-b5a7-20457c396c44	Sorry to bother you	Извините за беспокойство	audio/sentence_sorry_to_799c67b5.mp3
a8e47776-a31e-4816-8b0d-995fbc6cbe9e	99d96816-215e-462f-aedb-c577b9ea06c8	I'd like some more wine	Я бы хотел(а) ещё вина	audio/sentence_i'd_like_798c0a2c.mp3
bd20a46c-0cfa-458a-8db6-14c4f94c4ab6	be1b3e49-7e3c-464e-b51d-fb4cf1f36eb5	I have a pain in my chest	У меня болит грудь	audio/sentence_i_have_c8d0177d.mp3
be2ef4c8-ab1f-4246-bc86-7b3cd4d9558d	4675a28a-f79c-4b9a-aca0-2aa4baa15cec	I have a headache	У меня болит голова	audio/sentence_i_have_0f664124.mp3
27859b4d-d70b-4445-a027-0c252cadc620	1f2cfd10-07fc-49c9-95fc-181614e917d0	I have a terrible headache	У меня ужасная головная боль	audio/sentence_i_have_501517e9.mp3
b81e18a3-53aa-4474-b227-4749562eaa49	bc23e78c-57b2-4550-aebd-4495d1d59d62	I have a bad stomachache	У меня сильная боль в животе	audio/sentence_i_have_32756691.mp3
150dd9ad-3240-41b4-9308-4333d7dab9fe	c0b27c9b-2a31-4f75-a234-a4222d829261	I have a bad cough	У меня сильный кашель	audio/sentence_i_have_3424a04d.mp3
e95581d4-27fd-4b88-8654-4627ea4a8a92	e7909a26-ee6d-4340-b063-b8ec27436dad	I have a high fever	У меня высокая температура	audio/sentence_i_have_ecfe1556.mp3
d5c16c9a-0af3-483a-b326-f54bdec3c363	55503bf7-ae3d-4948-8e66-4c0cbb505eb5	What's your temperature?	Какая у вас температура?	audio/sentence_what's_your_ff07a978.mp3
a1a222f9-a2a3-4d14-b21b-87891952850e	c05ccdc1-38bc-41b4-93dd-56c7b9c46449	I have a runny nose	У меня насморк	audio/sentence_i_have_6dea49dc.mp3
61e020c2-f5e5-4007-b5d6-6dca2dffab00	7eca535a-e26e-49ee-b1f9-865f3ab37aff	I have a sore throat	У меня болит горло	audio/sentence_i_have_0f6fc6fd.mp3
760264fa-626e-4388-9d29-9b1a11ac2841	08d2f6ce-f862-4e00-9e45-94a98d1dd28e	I feel dizziness	У меня кружится голова	audio/sentence_i_feel_b1b406d0.mp3
602dcc68-00cf-4dc9-854a-f8ebdf5f8c28	a2e4d02a-267b-48d7-9827-f42207cd075d	I feel sick to my stomach	Мне плохо	audio/sentence_i_feel_e0a07ddd.mp3
b6178b4b-d7c1-439f-b635-45a5428fa06f	c2160d88-9e70-4375-8291-653a27d8e512	I'm experiencing shortness of breath	У меня одышка	audio/sentence_i'm_experiencing_964b40b7.mp3
ad2ea630-c869-49b4-a1ce-f1633d78d9e5	53212c3e-ea3b-4075-91f7-82527651f9b7	I think I'm having an allergic reaction	Кажется, у меня аллергическая реакция	audio/sentence_i_think_f37722bb.mp3
51de3286-6876-4d99-85f0-97d89838c013	1e991d6e-5a00-42ec-82fb-9bcef332de05	Do you have a prescription?	У вас есть рецепт?	audio/sentence_do_you_409aec4d.mp3
2af6c4a0-a97a-4a13-ae7d-c46d5923b1b8	a9e9a74a-6635-4dbf-bae7-644b699df670	I need some over-the-counter medicine	Мне нужно какое-нибудь безрецептурное лекарство	audio/sentence_i_need_99b626d6.mp3
1b17c49f-b937-4072-a332-e522bf4df72c	8312d666-9970-4a80-b7e0-d12ef6097c38	What are the side effects?	Какие побочные эффекты?	audio/sentence_what_are_d35e06f7.mp3
c0565df3-fc64-4a9b-9b71-39bfa6b0fbc2	594dab50-57e8-452f-99cd-2546981c0999	My symptoms are worsening	Мои симптомы ухудшаются	audio/sentence_my_symptoms_a77b0c84.mp3
c2e528eb-5e83-46c0-a134-3ae4c65ffe04	2c49d9fb-c10c-41ac-8655-ca69415a6bee	I need some medicine for my headache.	Мне нужно лекарство от головной боли	audio/sentence_i_need_f975d652.mp3
91420694-1c39-4f44-86b2-29298912c1c3	c385e63f-ee5c-444b-9d79-ecfe0d6f9abb	Do you have a prescription for this medicine?	У вас есть рецепт на это лекарство?	audio/sentence_do_you_f42c9d4a.mp3
82b972f8-ec54-4df7-b7b2-c3e5561296bb	20a2bff3-a195-48cf-9634-df46bdb8709c	I can buy this medicine over-the-counter.	Я могу купить это лекарство без рецепта	audio/sentence_i_can_0cc77638.mp3
247d61c9-9a6a-4030-9de5-c85220869205	b42f182a-7262-42bd-a191-6f702fbb8d3c	I need to ask for some pain relief medicine.	Мне нужно попросить обезболивающее	audio/sentence_i_need_8b8055ec.mp3
ace63e1b-6ae1-421b-b9e1-b7230c9f162c	4229a5c2-9394-4810-a0af-7d20fec0a7e6	I'm requesting this medication.	Я запрашиваю это лекарство	audio/sentence_i'm_requesting_b3abd380.mp3
cdc1413e-2087-492a-a6dc-5a3f091cfa35	7f8d213a-c244-4769-af8b-eb5c4227f358	I really need this medicine.	Мне очень нужно это лекарство	audio/sentence_i_really_0d2d9786.mp3
4527ad77-7818-4b55-b16d-e7434b71d693	a7eb456b-40b6-4d91-8cd7-bea600470418	I need pain relief medicine.	Мне нужно обезболивающее	audio/sentence_i_need_d56413aa.mp3
ccc80af8-01ca-473a-bdc2-cc1950fd1ca0	63a3fb6c-6ae9-4e36-a0ea-1924d6c35346	I'm allergic to penicillin.	У меня аллергия на пенициллин	audio/sentence_i'm_allergic_bd6ab725.mp3
ae7b92df-a998-45d5-9d9f-12839edf47c2	7545c5e8-0bdf-423b-80dc-030536ff60b5	What are the side effects of this medicine?	Какие побочные эффекты у этого лекарства?	audio/sentence_what_are_d9e394a5.mp3
a0ac3a56-a9b3-4903-9ae6-ca92ce4e1690	07ebd5e6-5d96-4074-aca7-66553018dbb5	How should I take this medicine?	Как мне принимать это лекарство?	audio/sentence_how_should_5da58e4e.mp3
e79a12fc-1107-4c99-94b7-f14e80fa4398	614d6ba3-c7d9-4921-b294-18fb41b37eb3	What's the correct dosage?	Какая правильная дозировка?	audio/sentence_what's_the_e09bebe3.mp3
6c2a1172-1b12-4a10-8093-af405e8e9caa	e0a873e5-3a21-472f-b755-eb179a153e5e	Where's the nearest pharmacy?	Где ближайшая аптека?	audio/sentence_where's_the_a8b79cbf.mp3
00517984-f6e5-44d1-af4a-d84051274596	ab5dbd35-d6b5-4b19-b7b7-d06f6ebabbb8	I need to go to the chemist.	Мне нужно сходить в аптеку	audio/sentence_i_need_c4a58aee.mp3
4ab98c2d-c37f-46b0-933e-5ead9a9668ae	8b8f5477-b02d-4bce-bdce-0781a3748872	The pharmacist can help you.	Фармацевт может вам помочь	audio/sentence_the_pharmacist_7c7b5b95.mp3
c347b858-4f3b-4ae0-8324-38b5f6374f6a	e4b6b952-5812-4132-a4fc-d3b6ab9fdcd7	What's the correct dosage for this medicine?	Какая правильная дозировка этого лекарства?	audio/sentence_what's_the_75d7082e.mp3
2f202c6e-c7d7-45ab-bd11-0b11f6b673be	d6c940bd-4902-4cdc-ba2e-814a4d8a2d10	Take one tablet three times a day	Принимайте одну таблетку три раза в день	audio/sentence_take_one_1cfaa6b9.mp3
0060e727-04e1-4a6f-997f-40e1cb47ad3e	c95de5ea-fbb0-425d-867d-d43ab1c7e984	Do you have a prescription for this medication?	У вас есть рецепт на это лекарство?	audio/sentence_do_you_72d1130b.mp3
63eb9c96-5d2b-4cac-844c-c16bbc4e94fb	c6b451ca-7be9-4c1c-ac7f-54daa9b23a8d	An overdose can be dangerous	Передозировка может быть опасной	audio/sentence_an_overdose_87fcef3c.mp3
b616825a-6196-4e14-93b3-29533a0761e1	c2ac2a56-f9c6-427d-8342-e21276c0a7b1	What are the possible side effects?	Какие возможны побочные эффекты?	audio/sentence_what_are_1cfcebdf.mp3
883a2727-fbc4-40af-9aad-29902bcbb52d	2fc89a4f-f5da-4d3d-9c46-9cf6f0a6d9d2	Follow the instructions carefully	Внимательно следуйте инструкциям	audio/sentence_follow_the_4147a1c2.mp3
10a6e3ee-fe00-44f3-80e0-63015ddb38b0	8a00d084-e66d-449b-bd46-85aa37a0a45b	Take the medicine once a day	Принимайте лекарство один раз в день	audio/sentence_take_the_e0f57c57.mp3
55d70bb6-315d-4fb8-9a1f-496dfa1ea6b2	04b39ed0-ebf5-42fe-a675-b744d35f7ed4	Take this medicine twice a day	Принимайте это лекарство два раза в день	audio/sentence_take_this_7a8fd6bd.mp3
3493ee06-7bb6-4490-b9b4-31ba0e2f2842	1e6a05e8-2a1a-4cd7-a043-c11cfc1d1610	Take it three times a day	Принимайте его три раза в день	audio/sentence_take_it_40315713.mp3
39812c3e-6076-433f-94a4-1f65467a6d48	a65f8df2-bbae-465a-924d-eb90260d2d89	The dosage is 500 milligrams	Дозировка составляет 500 миллиграммов	audio/sentence_the_dosage_13b926a2.mp3
cd1d7da7-296e-4ba0-b647-53cc52c97f63	adead2fd-314d-4d63-852c-d45482022e09	Take 10 milliliters of this syrup	Примите 10 миллилитров этого сиропа	audio/sentence_take_10_162d81a6.mp3
332bb1ff-25ec-4789-a522-7377f82831d7	4092340a-a3c6-40b8-a96b-c1faac7fb8af	Take one tablespoon before meals	Принимайте одну столовую ложку перед едой	audio/sentence_take_one_9b3c6bbc.mp3
079b1ed5-8786-4ad9-b7c6-324104b7b7ed	c34eb7c4-1807-497c-8fff-491ad7c0ec4f	Take one teaspoon after meals	Принимайте одну чайную ложку после еды	audio/sentence_take_one_46ea0184.mp3
c212e9dc-ee0b-4d27-9050-4488bc606e8e	aa78ef96-711e-4dae-97f5-ff05116c641a	How many pills should I take?	Сколько таблеток мне нужно принять?	audio/sentence_how_many_65ce6607.mp3
9e014a3b-aa22-449a-a532-54453d616a70	8330d847-811d-4022-b2a0-a7d0de66ffda	These are capsules, not tablets	Это капсулы, а не таблетки	audio/sentence_these_are_60681f62.mp3
65564343-b7f3-4d09-953a-924a91236c63	1f156ece-626f-4618-855c-4b4354abeef2	This medicine is in liquid form	Это лекарство в жидкой форме	audio/sentence_this_medicine_59eb8e66.mp3
2d59b8be-3afb-4676-aef5-21abcac231ea	bf3a8bba-93c0-4054-bc8c-1d7d287ca232	Mix the powder with water	Смешайте порошок с водой	audio/sentence_mix_the_fc18da62.mp3
9ea8ddc8-5914-447e-a235-c9895b765330	98d6d9d2-2f55-4770-9a05-ad3b53ac631e	Fill the syringe with the medicine	Наполните шприц лекарством	audio/sentence_fill_the_7f4e6ae6.mp3
04418e6d-5619-4982-921f-d4fdbf86394c	d4da3148-3f89-4f6b-954a-9a12550095af	Swallow the pill with water	Проглотите таблетку с водой	audio/sentence_swallow_the_888a42d1.mp3
fe097160-db05-4cb8-9952-c1217fcbb3e4	a66a23f8-f022-43c6-a07b-9a64561ca639	Carefully measure the dosage	Внимательно отмерьте дозировку	audio/sentence_carefully_measure_bc4a799b.mp3
44ed3271-2765-40b5-9367-cac5a984cf87	847208be-cf8f-4656-ae31-9b749ae7e51c	Apply the cream to the affected area	Нанесите крем на пораженный участок	audio/sentence_apply_the_416e7d06.mp3
bd2eddf9-48d9-42c0-9aa5-e9dd394dc4c3	216f46ad-1869-40ab-9dae-501585a7f25f	The doctor will inject the medicine	Врач введет лекарство	audio/sentence_the_doctor_5f6ae8c6.mp3
7a56e9a2-43e7-4971-8878-a063accad193	67779a62-43b1-447f-ac7e-d32f3e5165a5	Consult your doctor before taking this	Проконсультируйтесь с врачом перед приемом этого лекарства	audio/sentence_consult_your_66826468.mp3
068de06a-7ac0-4919-93c1-34c9281a49ff	17513034-462f-499d-8311-247cf7a8814a	I have a doctor's appointment	У меня запись к врачу	audio/sentence_i_have_189d95d1.mp3
67ee1cdc-be48-42ae-a1e8-fd827cb8f24d	35fa9285-8909-4ebe-bc8c-076f281a542d	I need a check-up	Мне нужна проверка состояния здоровья	audio/sentence_i_need_ffdec30e.mp3
082eebf5-d2cf-41d9-82b8-7fbde2a33534	7f8ba23d-f3a4-49cc-a090-e5de5e1d0124	The doctor examined my body part	Врач осмотрел мою часть тела	audio/sentence_the_doctor_14c5e401.mp3
d626056a-8aed-4cc5-b81d-6363edc1e1fd	18fc91dc-eb5f-4281-a918-3edc46525522	I have a terrible headache	У меня ужасная головная боль	audio/sentence_i_have_060a67af.mp3
0d368b4a-f588-4488-b387-6948e3226b03	bc6a9188-1909-4640-8e06-54e0c05ce055	I have a bad stomachache	У меня сильные боли в животе	audio/sentence_i_have_d5232d53.mp3
60fdc0ac-5a2f-47a8-91bb-550fb78e7325	96412a78-1314-47ff-8a5f-2524a245d2f5	I have an earache	У меня болит ухо	audio/sentence_i_have_9172a82f.mp3
4e15105e-1cb3-42da-8de2-b53a85201edf	e58985d8-2374-4f48-af1d-c705c1212ec3	I have a terrible toothache	У меня ужасная зубная боль	audio/sentence_i_have_f139d76b.mp3
3da46421-2ba3-4ab7-bdd8-578ee6868573	c61daf94-75ab-4577-b59c-a688b5dd2464	My throat hurts	У меня болит горло	audio/sentence_my_throat_80bb444d.mp3
e794d115-266c-4a2e-af84-b5d6b623717c	3eb0e664-f131-4bcc-9859-58f2fd56d50f	I hurt my arm	Я поранил руку	audio/sentence_i_hurt_3ca06bb1.mp3
0267d7df-00ae-4ca9-aad1-6c3b843b1219	15474bd7-9c3a-480f-adaa-2c1a3a1284a1	My leg is broken	У меня сломана нога	audio/sentence_my_leg_28be7543.mp3
468f8c58-7b57-4643-9942-3cea21c38cf9	c2cd33bf-056d-456a-b5dc-011a4530d2ba	I cut my hand	Я порезал руку	audio/sentence_i_cut_832f3915.mp3
38756b64-655c-4ae7-adff-f3c2c732c69c	b6a15961-cdc3-47ad-8503-ef4f0e39b71e	My foot hurts	У меня болит нога	audio/sentence_my_foot_0c0a08d7.mp3
4b21226b-9249-4686-bc1b-3e246905ccaa	adb2ab7b-8221-42f4-aca6-e6ae870d5e5d	I broke my finger	Я сломал палец	audio/sentence_i_broke_5c396456.mp3
be0d6b5e-f062-4528-837d-b935227e8d57	c503f70b-a72c-48a7-9080-97c77333903c	I stubbed my toe	Я ударился пальцем ноги	audio/sentence_i_stubbed_fbf01da9.mp3
32cc416c-8898-443e-af69-fd6496fc7287	292e1a19-840c-4bef-ab7e-0b0d732bd9ad	My eye hurts	У меня болит глаз	audio/sentence_my_eye_1ff5d072.mp3
dca19178-9b45-4b5c-a435-40f6d059cf93	077d2aa2-cd3f-4b1d-b851-103fac549bee	My nose is stuffy	У меня заложен нос	audio/sentence_my_nose_afea90a6.mp3
8a3a5188-5469-41d0-b1fb-39c9e3e1ae8b	a310b83b-e133-4dde-961f-48819313aa80	My back aches	У меня болит спина	audio/sentence_my_back_211d03ae.mp3
b462af5b-9df8-4632-859c-1398bc53b5d8	a7c87fc6-0c9c-4a55-9d27-cc9e3323e87d	My knee is swollen	У меня опухло колено	audio/sentence_my_knee_59dc7564.mp3
de1e3984-7894-4396-8ccd-77890f629651	5515c356-8fd9-4fb3-88f4-0786531bfe8a	My shoulder hurts	У меня болит плечо	audio/sentence_my_shoulder_4a5b74c5.mp3
3e402f0b-e36b-4be4-a113-876e64a7fbe1	80b86c1f-2a69-472e-a386-4a42fe93a719	I have pain in my chest	У меня боль в груди	audio/sentence_i_have_b3326171.mp3
2eb78997-0a0b-4a5f-bb2f-9672b0282faa	d43cf66c-6dc5-4d5f-a78c-391fb79c5a45	My heart is racing	У меня учащенное сердцебиение	audio/sentence_my_heart_8aa56afb.mp3
927471ff-d1a1-4ebf-a678-f420dcd8b6b4	5c566434-b41a-4b28-9319-f2a0fa5eda49	I have a high temperature	У меня высокая температура	audio/sentence_i_have_3a85530d.mp3
a908ae1e-107d-4ca0-a1a5-b1fd906a1f25	f746a926-ae2a-4378-9f6c-cd113387c60e	Check my blood pressure, please	Проверьте, пожалуйста, мое кровяное давление	audio/sentence_check_my_490a27d2.mp3
e96a1c12-3417-45c6-9ca6-83abb60518b2	4fb4c201-9a43-46a3-bb62-fff36a8f0e18	I have a lot of pain	У меня сильная боль	audio/sentence_i_have_ff125b82.mp3
0593e967-f629-449b-8d58-54b45784d99a	4bd7ed43-00fb-4167-a3da-9f11a02b50df	My arm hurts	У меня болит рука	audio/sentence_my_arm_1a039707.mp3
8faf0d4d-3adc-495e-937f-745316459817	44a263fb-d9d0-4f86-8f4e-0eb74a596bef	My head aches	У меня болит голова	audio/sentence_my_head_79f2fe77.mp3
47596cea-7342-48dd-b408-7ba543569618	4a41e9bf-eefe-4bfd-8794-5752261f3a3e	I feel unwell	Я чувствую себя плохо	audio/sentence_i_feel_163641a3.mp3
5d90c955-1d63-4ad1-b0b7-ca84a5c62013	4568f42c-6073-435c-b6c0-c40355239598	I need to make an appointment	Мне нужно записаться на прием	audio/sentence_i_need_0a10aa50.mp3
0e8d0951-924d-44bf-b8ca-a2d5236bc63c	0721a401-3cd6-4ce6-ad7b-1e7cb616636d	I need to see a doctor	Мне нужно пойти к врачу	audio/sentence_i_need_0f59e04d.mp3
c895a4a1-8797-46fd-93f2-0bf0899b4db5	62312c12-dcca-460f-904d-f914b39a3774	I need to take medicine	Мне нужно принимать лекарство	audio/sentence_i_need_2ef0bb17.mp3
947001ae-3f9e-4d18-b4af-dd079c9ec951	58e281cc-4baf-4c56-bee6-968a632f1cf5	I hope I get better soon	Надеюсь, я скоро поправлюсь	audio/sentence_i_hope_59c82e2b.mp3
ff1428fe-2adb-44d1-8287-52a2d64cc094	26dc511a-5104-4144-816d-a2b27525da09	I have a doctor's appointment tomorrow	У меня завтра прием у врача	audio/sentence_i_have_2f3eb8a0.mp3
49298132-8141-4ba5-a745-079aba2a037b	87193eac-7fcf-46d5-809b-609f01bb91eb	What’s your schedule for today?	Какой у вас сегодня график?	audio/sentence_what’s_your_34daa701.mp3
81d9edfc-4bc4-4bc3-a399-efa658603a4f	e3ea66b1-a044-48ad-b8e0-ca379040aec7	Are you available on Friday?	Вы свободны в пятницу?	audio/sentence_are_you_dac01dde.mp3
74aa0380-4373-4a11-bc66-de0f2a91634d	75d78ce3-7766-4c9a-bb5f-c8b6fbcdbb6f	I'd like to book an appointment	Я хотел бы записаться	audio/sentence_i'd_like_d8da7481.mp3
9a6589b6-3af5-46f0-8302-70eb0e87d2ff	dacb9796-35d0-438c-983f-2a1b447fe10d	What’s your reason for visiting?	Что вас привело сюда?	audio/sentence_what’s_your_128a17eb.mp3
b2cea886-f7ba-4cfb-a25f-348bb8be56ba	b51ceee2-7924-4179-879f-16dfe633cdf2	What symptoms are you having?	Какие симптомы вы испытываете?	audio/sentence_what_symptoms_283efe44.mp3
1607230b-0567-4853-9aa4-7a61de40fd34	e4090874-a6ea-4999-8471-707314cd851e	I need to reschedule my appointment	Мне нужно перенести прием	audio/sentence_i_need_135a947e.mp3
88a7d305-7740-459a-a049-1cdc96e800fe	0cf993e9-bc1c-4485-aadd-9223a7bb3bc8	Can I cancel my appointment?	Можно ли мне отменить прием?	audio/sentence_can_i_47fe2ccd.mp3
a6dc5368-5593-4178-bf9b-275cd3d94d6b	4ac08eaf-cca5-4568-9095-1aa9dc5360c6	Check in at the reception desk	Зарегистрируйтесь на ресепшене	audio/sentence_check_in_08d9db7f.mp3
1848a16c-0bf2-4098-8234-d350f682604f	dabb08ba-540e-4034-9094-c3e5442d7f62	Please fill out this form	Пожалуйста, заполните эту форму	audio/sentence_please_fill_d6fe802d.mp3
a536a9c6-1e6e-4263-b6e2-b4826ba4dbb9	4d26ee8a-968d-4980-8de9-c7797f744a24	First-time patient or returning?	Вы впервые или повторный пациент?	audio/sentence_first-time_patient_0578082b.mp3
1c8dba22-5693-42d5-8528-0bc66b7e67ce	487703ed-3cc9-49cd-992f-c2b6767e0a92	Talk to the receptionist	Поговорите с администратором	audio/sentence_talk_to_664e6502.mp3
fc1cdf67-5a44-45b0-b4a0-680f3e4f59b9	66894c42-ded3-4018-82a4-6bf7c960614f	Do you have health insurance?	У вас есть медицинская страховка?	audio/sentence_do_you_4cf87ab3.mp3
7659e675-7fb1-4286-838d-3da756500169	bf95113e-7165-4798-93ad-9e7dd79a63f9	Bring your health card	Возьмите вашу медкарту	audio/sentence_bring_your_15898a7c.mp3
fd6c60fd-8025-400a-876a-eccbc7cae4b5	55d6bcb1-74fe-4e76-b672-d89e2ff5f340	They offer same-day appointments	Они предлагают прием в тот же день	audio/sentence_they_offer_ac2c3d3e.mp3
c4f0b090-8bee-4cfd-9041-5d1088b609d7	51419fb4-7a18-4fa9-9d7e-7976a92e336f	You might have to wait	Вам, возможно, придется подождать	audio/sentence_you_might_d2611e11.mp3
531c2329-4e67-47fe-87d3-00bc0f946f34	e884122e-b1a7-4e36-a1cd-ea9dc391b7ca	Is it urgent?	Это срочно?	audio/sentence_is_it_8b191d18.mp3
43de4573-e4fb-45ad-aa43-acec32b793b2	c84e67d6-8f12-49cf-8628-687b99d3dd87	Take a number from the dispenser	Возьмите номер из автомата	audio/sentence_take_a_fb9602c4.mp3
71f602a5-606c-477c-bc32-b1f9eacf7f63	33bbe067-b1bf-42e9-a332-95091cfd1339	What time is your appointment?	Во сколько у вас прием?	audio/sentence_what_time_0b1ef063.mp3
3121273b-cdaa-48f3-974e-5263ccdadb5c	3ef416cf-09b5-495b-98ea-7e05a6ff1c2f	The doctor's office is on the second floor	Кабинет врача на втором этаже	audio/sentence_the_doctor's_83d0e680.mp3
0600eb61-654f-4e42-899d-17f2f4a61492	6fa1414d-6540-44be-b700-d134980ca80e	How soon can I be seen?	Как быстро меня примут?	audio/sentence_how_soon_71e0df3c.mp3
ebbc09e7-bb4a-42a9-9335-1fefc0a04646	5b91b1ab-5c59-43a9-be32-e2a956f5fccd	What’s your problem today?	Какая у вас проблема сегодня?	audio/sentence_what’s_your_0c54b0d7.mp3
61c0a056-6d2b-4e42-a1a7-17478b18c897	d19c07b7-a23d-41c3-9137-8898144be85d	The nurse will assist you	Медсестра вам поможет	audio/sentence_the_nurse_7120bdb6.mp3
e6a8773d-85e3-4155-91e7-7f812764323b	a2152bf1-0920-45d7-9fa2-a2b992755816	This is not an emergency	Это не экстренный случай	audio/sentence_this_is_1164b7a5.mp3
9f833bcf-269e-47b3-a6e0-4862e601a01f	290e3991-5d28-45df-9dff-82fc44956a1c	When is the clinic open?	Когда клиника открыта?	audio/sentence_when_is_fef82a32.mp3
62e2d55b-af9d-4255-8fe2-18adae86024f	2aa2dd3e-9f4c-434d-a9a9-7a82ee964ea3	When are you available?	Когда вы свободны?	audio/sentence_when_are_f8c8f860.mp3
2b5d43ea-72b7-45d9-b162-b49941dad442	ca8affed-2204-4d80-a6ff-798ac6cc8de5	Medical history is required	Требуется медицинская история	audio/sentence_medical_history_08a8bc6d.mp3
fffa948a-06a2-4caa-b8ea-09ac873426e7	d82cf3c6-eceb-470d-996d-ddb8d47e4049	Call to make an appointment	Позвоните, чтобы записаться	audio/sentence_call_to_5004feaf.mp3
34887a36-c46b-4235-92fd-b9790b371f46	eaf7008c-3708-4954-9cdc-eebccd9c0260	I need a checkup	Мне нужен профилактический осмотр	audio/sentence_i_need_aafe9e89.mp3
3255e1e0-16c0-485c-90dc-195188a601a2	f941bff2-ec8c-451e-a49a-beba50c8e030	Your next visit is in two weeks	Ваш следующий визит через две недели	audio/sentence_your_next_87358a20.mp3
6bd57cc7-35eb-43dd-809d-cadbf166edbd	922d220f-e339-49db-8a5a-3fa3433f42dd	She needs a full examination	Ему требуется полное обследование	audio/sentence_she_needs_f4568068.mp3
73daebee-eb8f-4dd9-879c-fb6fce940ffc	f1986bad-f0d4-42db-a722-93ed6a7e119a	The doctor will prescribe medication	Врач назначит лекарства	audio/sentence_the_doctor_cd23226e.mp3
511c62be-9c72-41da-a843-6dc2839fd87d	5003ed73-6045-4e35-bb3b-961afab393f9	Schedule a follow-up appointment	Запланируйте повторный визит	audio/sentence_schedule_a_9b3b48ab.mp3
0d1098a4-c5d6-48a5-9368-b6b599eb54c7	25f86b9d-073b-4082-a415-3f4be85b495f	Update your medical record	Обновите вашу медкарту	audio/sentence_update_your_930c7c53.mp3
1c509390-9665-4177-9ad5-5c94bc2562e6	ab59351e-b5d1-4878-b3f0-428a29bb0b6e	What procedure are you scheduled for?	Какая процедура вам назначена?	audio/sentence_what_procedure_e1611393.mp3
b7421c57-364e-4a31-8d57-ed79b40549bb	94ae686f-eff4-44b5-bd3e-8facd6bab067	What time is it?	Сколько времени сейчас?	audio/sentence_what_time_f00e1dd6.mp3
04b62eb4-4709-4c29-9291-79b9a042fabb	bbf71fc5-d6de-4558-b2fc-5e14bda4e6d1	It's three o'clock	Сейчас три часа ровно	audio/sentence_it's_three_3323879d.mp3
2ee019ca-bc5d-4cef-83af-fda059f034fd	601d4989-558e-47d7-88df-2af29a643303	It's half past two	Сейчас два тридцать (половина третьего)	audio/sentence_it's_half_257c1d9d.mp3
315d5f0c-318d-4639-94f8-3a7f6922807c	4f9cdc3f-1801-4639-952a-1a0df3a753f7	It's a quarter to five	Сейчас без четверти пять	audio/sentence_it's_a_275b43e9.mp3
944075f3-8184-4b23-baca-798040638164	fe727ee8-4fbd-4f26-b67f-dd10d9977a6b	Twenty past six	Сейчас шесть двадцать	audio/sentence_twenty_past_f6a6bafb.mp3
57c4bdf5-3704-4549-8f73-b579d933bafe	3f99e398-ff44-4347-9743-9beb583ca4ff	Ten to seven	Сейчас без семи десять	audio/sentence_ten_to_987c30ad.mp3
312e9e3b-29de-4f2c-8804-f22cedec8994	0ab722f8-ba6b-4d10-a056-f7d45585a86c	Five minutes to go	Осталось пять минут	audio/sentence_five_minutes_e350f341.mp3
625b7643-711d-4984-bc11-44906ea26327	1e166566-4357-487d-b845-f13cb0268c25	Two hours late	Опоздание на два часа	audio/sentence_two_hours_6db457ac.mp3
e4b13a8d-bc7e-49a4-a533-64a85caa4305	4250c04c-e03a-40bd-9daf-58071f822b19	Morning departure	Утренний вылет	audio/sentence_morning_departure_ac7b1dac.mp3
0b3f8b23-732f-48b7-8d49-f3a4a447d0ec	2f02496e-5a30-438b-9d4c-8570627d1681	Afternoon arrival	Дневное прибытие	audio/sentence_afternoon_arrival_df0fc05c.mp3
f10f3aba-ed55-473a-9403-8a0f155f852c	e0904453-e4f1-4bec-8798-1640ab06bc5b	Evening flight	Вечерний рейс	audio/sentence_evening_flight_81fe9db5.mp3
2f072dae-94cb-4732-80bb-9575802fc1ac	7e1301ac-e671-4367-9dc4-8f736991525b	Night flight	Ночной рейс	audio/sentence_night_flight_896ca25d.mp3
12a7ab1c-0975-4a24-919c-bd52a79b9e04	fd5d2051-44c2-4a80-9911-b496fc004559	Get it now right now	Получи это сразу же	audio/sentence_get_it_1e8ca6f7.mp3
f6ef66cb-5bb4-45fa-99df-dd0dc00f79c6	a281c51a-5c41-4ee5-a816-892a04ab785d	Early check-in	Ранняя регистрация	audio/sentence_early_check-in_f1e38fba.mp3
ba0c8830-e746-456e-8509-8e6402e03f5b	929c0712-bbb3-4471-8711-c8804d30657a	Late arrival	Позднее прибытие	audio/sentence_late_arrival_54260dbf.mp3
5755a6a0-9c13-4218-81c2-bcdff2fb1a49	ba6cd3e5-cad4-4834-b4ab-fba871c1a878	10 am check-in	Регистрация в 10 утра	audio/sentence_10_am_59857802.mp3
1a2a15cf-c85c-4524-b4b1-c20259b83016	523d7b80-5024-4cef-8f61-3688f0a6fe37	4 pm boarding	Посадка в 4 часа вечера	audio/sentence_4_pm_8e657205.mp3
652e8f30-bd4e-4992-b943-8889eda11f8d	0ec82910-c5c4-4ce1-82f5-1632ef902886	Flight schedule	Расписание рейсов	audio/sentence_flight_schedule_3633ae64.mp3
f00359d0-3f44-40a4-a78c-1841640a571a	d6b41344-bf88-45cc-96e8-81b6b8407f1d	Departure time	Время вылета	audio/sentence_departure_time_0b7e6af9.mp3
8b555a2c-5b3f-484d-b53f-5a593c0e313b	64c85973-8bd7-44d2-998f-c84851616d59	Arrival gate	Гейт прибытия	audio/sentence_arrival_gate_4e4334d0.mp3
791b6a72-c51b-42df-b925-d23242d44870	947b45ea-8111-40a5-9da3-e0b09d925cca	Arrival local time	Местное время прибытия	audio/sentence_arrival_local_5435cf31.mp3
6aa59b9d-304b-4b62-8b42-83179dbf35b5	5352b457-248f-4f77-923a-427cff930614	Flight duration	Длительность полета	audio/sentence_flight_duration_17d73ff1.mp3
046b3910-23f9-45a4-9337-8c612ef9e7c7	177e865e-7d87-4956-9664-6422c1acc74a	Gate departure time	Время вылета с гейта	audio/sentence_gate_departure_3d1554e7.mp3
e715bf9e-e437-4c7e-a625-0d18a5f78f41	26987310-475d-4456-abaf-fecac2148b65	Connecting time	Время до пересадки	audio/sentence_connecting_time_d208367d.mp3
3fad534f-c0ea-4d50-bd18-20c3e2a1c2ec	dae6d3eb-5818-4650-8300-3debc21ebdfe	Boarding at ten past three	Посадка в три десять	audio/sentence_boarding_at_81d36d03.mp3
002221fc-50f3-489e-aa6e-9f70a07e7601	bcd6cb78-ff9a-4a52-9c7b-0b44db34af1e	Departure at twenty past five	Вылет в пять двадцать	audio/sentence_departure_at_7a16a671.mp3
45368d8b-9edf-4b8f-b378-181a946a825a	73c0f4c4-65dc-44ec-baa9-b032bf434bb4	Flight at half past seven	Рейс в половине восьмого	audio/sentence_flight_at_30c40e99.mp3
c434058e-ab91-4d8d-90b7-d34805814c1b	9658bb1b-24d9-4a6f-a5f6-349e4f1c0c04	Meeting at quarter past ten	Встреча в десять десять	audio/sentence_meeting_at_873a5d39.mp3
83e7c45b-d080-41bb-bfb4-1bae3240c82a	d15013be-8ec4-4bda-b1aa-b6e6af9beb78	Check-in closes quarter to six	Регистрация закрывается без четверти шесть	audio/sentence_check-in_closes_e5149011.mp3
ede22cc0-d1a7-461b-ad8d-79e94a9dbca3	abc1c4b4-64fb-48c8-bf4a-bb2b589d8c97	Gates close five to eight	Гейты закрываются без пяти восемь	audio/sentence_gates_close_73861416.mp3
b7d02fb9-a548-4112-a93c-50f5a4680948	6c0a10cc-ef30-4d05-8535-a46544e30e0a	Timetable changes	Изменения в расписании	audio/sentence_timetable_changes_132dac32.mp3
ba7b50df-f5f9-4813-8397-12a7229f26f3	87afd049-09e1-47d1-a457-73270cdf2e6e	Delayed departure	Задержанный вылет	audio/sentence_delayed_departure_9310a408.mp3
29971859-6fc9-4b08-8209-484bdb4efba9	051c5db5-1e31-4d78-9ce4-e759e69dcc51	We'll reschedule your flight	Мы перенесем ваш рейс	audio/sentence_we'll_reschedule_8d0f3630.mp3
eba3d192-d64e-4250-9e20-af50c80902b6	62ead9b2-77b9-4a63-bea2-8a6dbba5ef65	Minimum connecting time	Минимальное время на пересадку	audio/sentence_minimum_connecting_72b4642d.mp3
d8ae70e4-300b-4a86-ae60-66d7d459c434	4725c000-3d75-44c6-9e91-fefb49a9e62d	Cross time zones	Пересечение часовых поясов	audio/sentence_cross_time_62744a2a.mp3
3fa1ceb4-49f9-4760-ae59-4e987d32b132	fd08e28f-b58f-4dea-ac75-a160e8299c4a	Change clocks for DST	Перевести часы на летнее время	audio/sentence_change_clocks_db0e3c86.mp3
62b1ffa3-f2f5-4eed-9830-34037c2c4a99	0f4a378a-cd2e-4a4e-925a-9d52a1554364	Schedule conflict detected	Обнаружен конфликт в расписании	audio/sentence_schedule_conflict_505544d3.mp3
6da2f2cc-36a3-402e-bd4b-c07546d0b3ab	ba47b84d-2e06-4e2a-b47b-b2aafa5be823	Timetabling process	Процесс составления расписания	audio/sentence_timetabling_process_15da6157.mp3
a4984f36-86c8-4623-bd1b-3b08d745f1bf	db9b9176-4c02-4bb6-8a25-4fbbddd7b274	My flight is at 9am	Мой рейс в 9 утра	audio/sentence_my_flight_73967d74.mp3
258ecff6-91df-47d5-ad97-4e49b2df074c	4acb2755-52db-4ee0-a4ca-804e53aa0334	What's the departure time?	Во время вылета?	audio/sentence_what's_the_176af79a.mp3
e0dab328-e385-4340-9c1a-aaed8ec85fa9	1eb19561-a327-4a4c-9711-24fb6218ac45	The plane leaves on time	Самолет вылетает вовремя	audio/sentence_the_plane_382f183c.mp3
23ad33c7-221d-4553-bafd-9257352ac81c	07a599da-16c2-4169-a0ed-e42a5247f85c	Boarding starts in 15 minutes	Посадка на рейс начнется через 15 минут	audio/sentence_boarding_starts_79690ac3.mp3
e45b0867-280c-45c1-b0c1-f47ec13b63e3	a3abfc54-df68-43a3-93fc-57cdde871430	Flight duration is 5 hours	Продолжительность полета составляет 5 часов	audio/sentence_flight_duration_9badbccd.mp3
b26473a1-c150-415a-b563-ddbec404d1ac	6fe3c4ef-13c0-49ed-82b5-f2f7725e86d7	Crossed 3 time zones	Пересек 3 часовых пояса	audio/sentence_crossed_3_d815ef47.mp3
1caf2d24-4a24-4f71-98da-3008c900af84	4c17cb49-ed83-420a-9750-2b3f0c9b6fb9	Daylight saving time started	Переход на летнее время начался	audio/sentence_daylight_saving_cef416ee.mp3
aee62e4d-f381-4a0f-9708-568690d19200	1469046c-a3cd-4463-815d-7706c4d38ebb	Flight schedule changed	Расписание рейса изменилось	audio/sentence_flight_schedule_3617676e.mp3
ab3a0bbd-5b14-4753-94a7-182d19e4b0e3	2f583bfe-c065-4a0b-b034-f47344f57046	Connecting flight too short	Слишком мало времени между пересадками	audio/sentence_connecting_flight_a504bf45.mp3
3fd4cef3-bee5-4a5f-8bbc-c1deb45f65d0	e6ba9e36-5b6e-41d0-b240-6a9bb9a893e8	What are the opening hours of the currency exchange?	В какое время работает пункт обмена валюты?	audio/sentence_what_are_7a17121c.mp3
d26723f5-7376-4897-8ca9-e785ab1b8276	d05e465b-93b0-42c1-9924-57a671d4982d	What is the closing time for the restaurant?	Во сколько закрывается ресторан?	audio/sentence_what_is_ca5cd397.mp3
248790d9-1bc7-44d2-a879-a739381ea360	c8173d10-82c9-4a01-8eeb-42784314b830	Where can I find the departure schedule?	Где я могу найти расписание вылетов?	audio/sentence_where_can_da27cf55.mp3
46f6e9aa-e37d-49e0-836c-dd9e8455386e	8623cc51-367d-4701-9a47-829ccb67b3b4	What is the departure time for flight AA275?	Во сколько вылетает рейс AA275?	audio/sentence_what_is_ef7bedae.mp3
3333ca93-60b5-4cfc-b2a6-dd8d17988752	a5eed4db-b6b4-4e67-91b9-94be3ceb0bc0	The arrival time has been delayed.	Время прилета было задержано.	audio/sentence_the_arrival_c1ba5323.mp3
ec02fb83-e8ac-4346-bc06-a8c200330618	60a18c71-9b56-4b98-bf8e-a6c9011a5045	My flight is delayed by three hours.	Мой рейс задержан на три часа.	audio/sentence_my_flight_c15b4293.mp3
0bab2482-af7a-42c2-8ad4-05b119a386b0	a05f5e7a-ec26-4e61-887a-9b75e73be95e	Is the flight on schedule?	Рейс будет по расписанию?	audio/sentence_is_the_60ac321a.mp3
f361e5c9-1f1d-4adb-9ce1-cdcd979a915b	366a2128-19d3-497f-9f00-b8d87723cebf	What time does boarding start?	Во время начинается посадка?	audio/sentence_what_time_5ecd9d48.mp3
a852fd4c-3171-402e-aad3-3c4f7636cbe6	30c57ced-fb51-4f1a-bfc1-5bb7194534f1	Which gate should I go for my connection?	К какому входу мне идти для трансфера?	audio/sentence_which_gate_47b6d1b7.mp3
14e8ea75-dce0-42c6-8f9d-914b995da606	f2ffe75e-0df0-4a4f-9c1a-e984361e37c0	Check-in closes one hour before departure.	Регистрация закрывается за час до вылета.	audio/sentence_check-in_closes_19758ef8.mp3
684953a8-82ca-4aa1-9982-96d10267715f	76bc8cbe-7645-451a-aa45-9d9296aa1298	The duty-free shop opens at 8 AM.	Магазин беспошлинной торговли открывается в 8 утра.	audio/sentence_the_duty-free_21d3f244.mp3
51edf378-c7c5-4f0c-9af1-2e43deb7ad3b	1ab83142-865a-4c97-a196-ad77989eb44b	The information desk closes at midnight.	Информационный центр закрывается в полночь.	audio/sentence_the_information_7ba3ac51.mp3
a1d19bec-6d92-4a30-9bbf-300225f6e264	06b2cf49-4e78-45a4-aa9d-60fb53541883	Is the lost and found counter now open?	Стойка поиска вещей сейчас открыта?	audio/sentence_is_the_fa99ae3e.mp3
54abb5c6-f705-402f-8cee-4c1b7a3c4da4	4bb53152-cca3-486f-ad02-3c32e4746c47	The ATM is now closed.	Банкомат сейчас закрыт.	audio/sentence_the_atm_eb1ec89f.mp3
c50ca0b6-810e-4a87-ae4e-c885957aff3b	cfa1917f-faf1-4eb9-9d56-c514a5d063a3	What time does the pharmacy open?	Во сколько открывается аптека?	audio/sentence_what_time_1cb06cc7.mp3
4a4f5a0b-6bad-46d9-8613-7e4362c6d21e	0a0fe004-f06b-46eb-87f9-b12fcfe2c700	What time does the luggage storage close?	Во сколько закрывается камера хранения?	audio/sentence_what_time_391397f6.mp3
118fba3a-658a-491c-804e-4113a6f4a07f	ca3729d6-f074-4583-a74a-26b1bb193d28	Is there a 24-hour restaurant at the airport?	Есть ли в аэропорту круглосуточный ресторан?	audio/sentence_is_there_fffed03a.mp3
30c2b5ff-8e2b-46c7-8688-77af1cd9eb0f	bc76cd5e-be82-4f9c-a649-a5d839c197ff	Open until the last flight departs.	Открыто до вылета последнего рейса.	audio/sentence_open_until_66c6a533.mp3
8b2f44ea-af9f-4e4b-8bd6-fab4ed6b219d	fb4e6b18-ca9c-4015-aa4a-b0dda9d19780	There is an early closing on Christmas Eve.	24 декабря раннее закрытие.	audio/sentence_there_is_9da85fb3.mp3
6c6f02b1-bbcc-491b-95d9-bdbbb88b892c	ebc4e3d0-a93d-4d72-a441-5b87abbf6636	What are the business hours for the airport lounge?	Какое время работы зала ожидания аэропорта?	audio/sentence_what_are_656fb5f9.mp3
ef9622ce-e868-4bc8-846e-b2f2324fd8ab	8eaecb64-f4df-41f0-b08f-548180e6d108	Could you show me the flight timetable?	Не могли бы вы показать расписание рейсов?	audio/sentence_could_you_d6efeac7.mp3
a836310b-c743-45e2-a3a5-b92b6aad81cf	a1256538-7ee3-43db-88e2-cc6762027efa	Boarding will begin in 30 minutes.	Посадка начнется через 30 минут.	audio/sentence_boarding_will_932e5445.mp3
d2a1f96b-f1a6-407b-b54c-cf6ae43932ac	50ac2240-bf99-418b-953a-1d1521374b3e	Which day is your flight?	В какой день у вас рейс?	audio/sentence_which_day_c904e2b9.mp3
0b9fefd8-4a23-475a-98d7-5dbccff4218a	e3278cab-0083-4465-b1dc-5c5e679cedfa	Which month does your holiday fall in?	В каком месяце приходится ваш отпуск?	audio/sentence_which_month_9f834da1.mp3
f2aaf343-e5e0-4a51-a1df-c5df8d594bb9	c6930345-12af-4aa8-862d-79d426c9721b	Could you confirm the travel date?	Можете подтвердить дату поездки?	audio/sentence_could_you_2506c208.mp3
ab7fabbe-bbca-461f-9591-8b455e07c3c2	bc897021-8d5c-4b87-8c22-1df85b56038f	Today is the departure day	Сегодня день вылета	audio/sentence_today_is_31455e17.mp3
ca234a04-ddb2-4ca0-9eba-d58c5e4bb46b	8d1d19f1-72ef-48fd-84ee-2d806d5c8313	The flight departs tomorrow	Рейс вылетает завтра	audio/sentence_the_flight_6f5d74f9.mp3
02883e45-53b9-4a71-9298-e8418543069c	ded38074-b9d6-455c-8a10-2e6506ceb541	Arrived yesterday	Прилетел вчера	audio/sentence_arrived_yesterday_8aa00529.mp3
8be39fe0-bde9-456e-9e68-21f88f86ca48	9069ae91-f4ce-4105-906b-ffda4f3ac16d	Weekday fares are cheaper	Цены в будние дни дешевле	audio/sentence_weekday_fares_94e17a27.mp3
60287906-5a5e-483c-aec0-c3f0f6808cfa	eecec22f-1db5-4c57-9a93-681af123134c	Weekend travel requires advance notice	За поездку в выходные нужно предупреждать заранее	audio/sentence_weekend_travel_5b2a47a7.mp3
b7444cc0-c6aa-4234-b9a8-4f5423fc83f6	49894395-3c03-4b21-b015-a7342de50633	Which year is your booking for?	На какой год бронирование?	audio/sentence_which_year_3a6e1aeb.mp3
a315a751-425e-4fcc-ae51-64ada1dfca53	eeefeada-07ef-4433-8f0c-809b1a78e2ef	Check the calendar for free dates	Проверь календарь на свободные даты	audio/sentence_check_the_aedf6df4.mp3
3b898e67-b047-46cb-9ef6-9951a4a0197d	8fd70bef-0a64-4701-b603-a4a0ad700a32	The flight schedule is online	Расписание рейсов в сети	audio/sentence_the_flight_dd619514.mp3
8ba7e771-f0e5-4ac1-8fff-98a2338c3034	af0841b4-a58f-492c-a5fa-41d249bfc320	Off-season travel is budget-friendly	Путешествие в межсезонье бюджетное	audio/sentence_off-season_travel_12cd0252.mp3
718c8ed1-e08b-47b7-8d5e-269c61f90f62	e4493f46-f5a6-4d6c-b26d-d4c098067dfe	Book the ticket in advance	Бронируйте билет заранее	audio/sentence_book_the_157cd6ed.mp3
f0f5b2e9-3ecd-436c-a396-f67da8503609	815efb74-2544-4d11-b1cf-d01e7b0bc11f	Holidays affect flight prices	Праздники влияют на цены на авиабилеты	audio/sentence_holidays_affect_216005d2.mp3
2e1564b5-3253-4f42-86af-733986b30732	6352695b-615e-4cd3-82f5-aa9534ca66da	Always check the date on your ticket	Всегда проверяйте дату на билете	audio/sentence_always_check_ab441e49.mp3
c04f0525-8f85-4ece-b90b-697f2a1adb85	b53f16d9-806f-4584-b430-69e3db32ac99	Excuse me, what's the date today?	Извините, какая сегодня дата?	audio/sentence_excuse_me,_fda85d17.mp3
ec95d097-8fb3-4196-9418-d34d56a95a69	4ffa63b2-3eb4-4298-8ad1-33ea2b649501	January is the first month of the year	Январь - первый месяц года	audio/sentence_january_is_b9e16653.mp3
ee1871b6-cbad-45c5-a225-90aaa2d854d5	55781669-747a-46b3-993f-b2c10ea49f84	What day of the week is the check-in?	Какой день недели регистрация?	audio/sentence_what_day_37bd407f.mp3
8bc7bab7-615e-43cc-87d2-8ff3ce43573f	3595b7ba-18ff-4a71-84ae-f67146884228	You must enter your birth date	Нужно ввести дату рождения	audio/sentence_you_must_5b8fe18a.mp3
24265d05-78c1-4660-8bc9-f566340b7dc2	61778aea-0c03-4adb-9637-aa08555e5b8c	I'll fly this week	Я лечу на этой неделе	audio/sentence_i'll_fly_9ceb0c43.mp3
8dbe45d8-f814-4f92-bf33-739ab1dff9c9	27746377-705d-4998-82ab-63bb41185070	Meeting schedules move to next week	Встречи переносятся на следующую неделю	audio/sentence_meeting_schedules_610228f8.mp3
9608fa82-a6a5-474d-97c0-30040d36823f	c30abf2d-e84c-4c08-9017-0df322c6885a	Booked tickets last week	Билеты забронированы на прошлой неделе	audio/sentence_booked_tickets_daee2a93.mp3
d7e9aa0d-ea9d-4754-9a9f-7d069357ba59	9afd1ed8-ded8-42bc-8646-e8684249c565	Adjust for different time zones	Скорректируй для разных часовых поясов	audio/sentence_adjust_for_706123dd.mp3
58d2459d-b0fc-40ae-92c5-064d431e490c	8b2bed17-33e6-4aa0-a0f6-a3f6aab4b2e6	Departure at midnight meets the schedule	Вылет в полночь符合 расписанию	audio/sentence_departure_at_0c90a83e.mp3
1b56ab5a-a147-435c-a8d2-714aa815096e	f3d2366a-a2d6-4432-a6bf-59a8af367808	Arrival at noon is convenient	Прибытие в полдень удобно	audio/sentence_arrival_at_df1edb4c.mp3
6d94b2ca-63e2-463c-b75f-622b5fca2604	c44ca6a4-a8c9-49c3-bbaa-08b064a6b2fa	Trip from June to July	Поездка с июня по июль	audio/sentence_trip_from_872cfa12.mp3
30e8ff28-5588-4d8f-84f5-4ecbebc79ab2	a9589b2a-d944-4514-998e-0a5e5a0e1ae5	Enter your date of birth please	Введите дату рождения	audio/sentence_enter_your_dbd11f72.mp3
021308fb-4554-4911-ad98-e2225dafc1c8	b0360778-f382-437c-91a1-2a153434e856	Check the bus timetable	Проверить расписание автобусов	audio/sentence_check_the_9a18bb0b.mp3
34f41d97-a9a4-4e2b-89b0-6612702b2328	123c8a22-3c00-45c6-86e5-aa1d865eb8fa	Travel costs increased last month	Цены на поездки выросли в прошлом месяце	audio/sentence_travel_costs_2fe5c5f7.mp3
dca8d57f-0b5a-4440-a962-6d9b73c2c77f	751fdca2-109d-4f03-a4fd-865b800e7b65	Will finalize plans next month	Окончательные планы в следующем месяце	audio/sentence_will_finalize_16dc0043.mp3
72d745f8-b12d-490c-af90-a9b9f5fefca7	2f4050ff-c970-4df2-90f8-08e5775ecc6d	Earnings fell in the third quarter	Доход упал в третьем квартале	audio/sentence_earnings_fell_41fd52f8.mp3
188bc4fb-9c6b-4e98-83a4-546831dd3c5d	ce624fbd-a078-4423-b0bd-38d300fb43f7	I'll stay for a fortnight	Останусь на две недели	audio/sentence_i'll_stay_f7506bbc.mp3
a3c80377-9dba-465d-bc2e-4f0b1578a277	e74af809-3a2c-46f8-86d9-e96e18798a28	Track annual expenditure	Отслеживай годовые расходы	audio/sentence_track_annual_6bc3e19b.mp3
482f4996-664b-43cc-90bb-21e793dadb1b	e6efa6f9-f1ce-4a6a-aac8-7526cae3f1b0	Best booking window opens soon	Лучшее окно бронирования скоро откроется	audio/sentence_best_booking_c9e28b34.mp3
9cad5d2d-85a4-4b4f-806f-125d663126b6	72a2feaa-a695-4368-90a0-fba325e2f023	High season prices are steep	Высокий сезон - высокие цены	audio/sentence_high_season_09c85b20.mp3
3eded1aa-064f-487c-aa27-6fe079c5a10c	167b6b9b-476e-41a7-b9ec-ea9c2a04b3f5	Low season discounts are available	Скидки в низкий сезон доступны	audio/sentence_low_season_c6873b8d.mp3
7407c786-dc2b-4859-ab0a-43a470df9a24	882026a5-31bc-4a03-8304-897dc3f289d7	Scheduling week days off is rare	Выходные в будние дни - редкость	audio/sentence_scheduling_week_5a23efe1.mp3
beb68429-b06e-485a-9699-3e5655057b69	b2e60549-be4c-49b5-963b-88ca1e8c7285	Planned arrival matches the schedule	Планируемый прилет соответствует расписанию	audio/sentence_planned_arrival_b4fc68f1.mp3
c4e85104-98e7-4de6-904b-8c9608d67d24	8b0fc5e6-8072-4b55-a5e1-d19fe6701200	Select your preferred time slot	Выбери желаемый временной слот	audio/sentence_select_your_52bb0e54.mp3
9efe877c-fb10-4afc-a65e-b6855e276d8b	d32f5838-5cb5-414a-a39a-f59757bf7571	Enter the date range результатов	Введите диапазон дат	audio/sentence_enter_the_01bae820.mp3
eb924150-33b7-4ba2-91e8-592bdbd3c6df	7bdf60a8-6bbc-49e4-9760-e76a8d1826d5	Day trips during holidays	Однодневные поездки в праздники	audio/sentence_day_trips_fec4047f.mp3
d9b01e44-3e9c-45c1-9a1e-c53fa4f6ca26	0190f6e9-b07c-4fbb-8f4f-3efe404aa29a	Buy a monthly pass for commutes	Купи ежемесячный проездной для поездок	audio/sentence_buy_a_ddf4f1f0.mp3
a3584c63-56f3-421b-a042-652271c3d07f	7ac6650c-c1e7-4551-b12a-a8f615c6299a	Fiscal year closed in the annual report	Финансовый год закрыт в годовом отчете	audio/sentence_fiscal_year_ba43d81b.mp3
a817ce76-74f1-4041-a4bc-8f7d187b41d6	23b1e0b4-0e03-4fea-8d3d-054a116fc081	Seasonal ticket offers savings	Сезонный билет - экономия	audio/sentence_seasonal_ticket_cda24e55.mp3
c5ac95db-0ced-4386-a5ab-ad346c17caec	0c42bbbf-ddef-4b62-ace6-41d8cf0baec0	Change clocks during daylight saving time	Часы меняются на летнее время	audio/sentence_change_clocks_6499cdad.mp3
2fbd2951-f786-45d5-a451-dfebb7bc6c15	3aadb229-c730-479d-b835-2da7acf0dde9	Check flight path on maps	Проверь маршрут полета на картах	audio/sentence_check_flight_325d7b29.mp3
3e9528c0-f356-4425-91b2-429f2069cbd0	a309650f-0d19-4eeb-b1a6-8417b71aa8f8	Arrival date change fee applies	Взимается плата за изменение даты прибытия	audio/sentence_arrival_date_60c977fc.mp3
1dff8d32-977c-42d3-b69e-d7b37df0ae29	c584e2f5-13ff-4cad-a09f-e00f50720ba5	Departure time is noted in the ticket	Время вылета указано в билете	audio/sentence_departure_time_21aba610.mp3
e3c28f3c-e94f-4977-9695-7a95a5a98371	a933d101-81a6-4603-b6f2-07bc93149510	Date validation shows no conflicts	Проверка даты показывает конфликтов нет	audio/sentence_date_validation_0f42c671.mp3
78b6b169-62b2-45c6-aed4-911956b04f45	c59ff904-25e2-43dc-9c15-86dd3d123d20	Travel date selection affects price	Выбор даты поездки влияет на цену	audio/sentence_travel_date_9043a4f4.mp3
6a4e9a15-be66-42da-b9b9-cca968460031	e855cbfc-f9ff-4beb-a122-2b8f1411961c	Booking confirmation has the date	Подтверждение бронирования содержит дату	audio/sentence_booking_confirmation_4fffae8f.mp3
a8592d80-199d-4c0f-887f-e045f51c5f09	d263fc69-5a83-48bb-a62d-260576fb7b4e	Plan a weekend getaway	Запланируй поездку на выходные	audio/sentence_plan_a_8685d8da.mp3
72d03c53-8bc0-4349-aabb-7260fcf87d92	b1a12ecb-8fd4-4502-ad85-8e2a42d6496c	Trip duration is two weeks	Длительность поездки - две недели	audio/sentence_trip_duration_6af39515.mp3
ba231a28-6d66-4023-b61a-adaf920340c1	bc379d55-facf-4713-aeeb-11c720a60e7c	Last day off before vacation	Последний выходной перед отпуском	audio/sentence_last_day_15a08046.mp3
49c2056a-abc0-460d-b2c0-c1c6cec5b958	ff78db9c-8d1c-476d-b671-34baf3d89a3f	Meeting scheduled for next Monday	Встреча назначена на понедельник	audio/sentence_meeting_scheduled_42fe1928.mp3
0a4d4fb4-ec0c-45c1-8864-9fc2dc7e8d20	cf5c0907-297b-4044-8ad4-a7422f183a82	Clocks go forward in spring	Весной часы переводят вперед	audio/sentence_clocks_go_f26f9633.mp3
ac46da23-0360-4a11-9e06-e62bd8d0374b	b8cd7c8d-4cc2-43c4-a112-70d167a45c7e	Clocks go back in autumn	Осенью часы переводят назад	audio/sentence_clocks_go_450d3c45.mp3
1055389e-3b19-43e4-ba0b-9be4c814a9ff	06b5c8bd-6fc1-4e2b-aece-40b4e86fc280	Stay within the monthly limit	Не превышай месячный лимит	audio/sentence_stay_within_d5e14b13.mp3
a5c217ca-a7ef-4be5-8f51-39ddfb5ff206	1342f58c-5833-4832-8bfe-cdbe56196727	Annual festival draws crowds	Годовой фестиваль привлекает толпы	audio/sentence_annual_festival_56c0095f.mp3
08b4d7b1-bf2b-43e4-af22-084678b76986	7a9d50cb-f4cb-4a3a-8c54-a76eb10229ef	Check date of expiry on card	Проверь срок действия карты	audio/sentence_check_date_4f9eb3eb.mp3
56be3ac5-6b05-427c-b2c6-e177a6bb1894	d49b56c3-6cc1-4b02-9254-af4e543699d2	Travel period coincides with holidays	Период поездки совпадает с праздниками	audio/sentence_travel_period_d9715c1a.mp3
c9527683-d90b-45f9-a426-01094fc53216	bbb3ed8c-957d-4fc2-8cfa-f7113db9fad2	Departure hall opens two hours early	Зал вылета открывается на два часа раньше	audio/sentence_departure_hall_f50ff9b7.mp3
86705fa7-fec4-4e2d-a5e6-401d7c80b243	a2d05fee-fc49-459a-9a94-c06d874bcd9f	Arrival area gets crowded	Зал прилета заполняется	audio/sentence_arrival_area_302c17ce.mp3
1744dc6d-5c85-46f3-8b24-47a483479ff8	697fe104-9e61-4e0d-bd3e-bf7844738a28	Todays date matches the booking	Совпадает сегодняшняя дата	audio/sentence_todays_date_1523d975.mp3
a68479dc-a052-4478-aa51-4d8addad14c8	aff00bb1-2dfa-4b8e-b025-147163cd056f	Financial reports due at month end	Финансовые отчеты к концу месяца	audio/sentence_financial_reports_4b794c1b.mp3
85315355-1789-4262-a9a0-ed989bb3256c	21755ed7-d724-4004-a269-9b07e2ca8ce4	Year end report shows profits	Годовой отчет показывает прибыль	audio/sentence_year_end_a700789f.mp3
7d8cf11f-0c6e-4d7d-bbbb-bf9536ecd297	8629ac51-06b9-40de-905d-f60cea18a6a3	Quarterly results beat forecasts	Квартальные результаты превзошли прогнозы	audio/sentence_quarterly_results_c90bfe67.mp3
2cfe5dd5-9cec-4f9f-81ce-4f32ffefba5b	1cb308d6-b019-4f4f-9d63-74a2456248cb	Check daily routine before travel	Проверь распорядок перед поездкой	audio/sentence_check_daily_e60ca6aa.mp3
cbe90587-8b13-4439-b280-161c0a669f42	9536e54c-2508-4993-aacb-2d34f36dfcd7	Biannual visit to relatives	Полугодовое посещение родственников	audio/sentence_biannual_visit_8c5eba2f.mp3
1cfa7f01-407a-4b37-bbbe-b64b02484513	91368d3f-ac09-46b4-88a9-e67c33b2f29b	Overnight stay before connecting flight	Ночка в трансферном аэропорту	audio/sentence_overnight_stay_d4d86ba6.mp3
c6bdc7b6-4c9a-42d5-b547-c2e9be186d06	9c89b78a-2428-42e8-8aa9-9cb742d18e40	Same-day return flights cost more	Рейсы с возвращением в тот же день дороже	audio/sentence_same-day_return_d84997b1.mp3
8ae19943-b84e-4e4f-b0cc-a90e3c79f186	1340dab8-9a50-46e2-8ec8-4fe3525517cb	Check weekly flight schedule online	Проверяем расписание рейсов онлайн	audio/sentence_check_weekly_c1e21882.mp3
6b70851c-a47b-489b-bc94-1c07c4f129f0	6f77c871-135c-48c8-817e-2f793e5b68ed	Date not available in booking system	В системе бронирования дата недоступна	audio/sentence_date_not_974e491a.mp3
54ecd8d1-ce04-4661-9689-194ef9e2c494	d029b666-2d2a-44ec-91dd-c59366631065	See availability date before booking	Смотрим доступную дату перед бронированием	audio/sentence_see_availability_eac80c01.mp3
616fde34-fa67-4136-b309-617991db103c	92bcbe78-c633-42c2-9fc7-b2c5c3a5c39b	Next available date is in three weeks	Следующая доступная дата через три недели	audio/sentence_next_available_36e7d158.mp3
103a80ce-bb9e-4115-b79d-abdd7d523d81	c76397ac-6e09-427b-b084-6bbfdb00328a	Flight frequency increases in summer	Частота рейсов увеличивается летом	audio/sentence_flight_frequency_3d198a6a.mp3
84214946-90bc-41ab-9faa-50864a05e22a	91d76fae-e47d-4c3a-8670-ef4de86eab27	Daily flight operates on this route	Ежедневный рейс operates по этому маршруту	audio/sentence_daily_flight_e86a19d5.mp3
217e4021-4dc2-47c9-9a09-a7ecb0ca7e23	05c26d0b-fe8c-4976-a2b5-1fde6892db99	View monthly calendar of meetings	Посмотреть календарь на месяц	audio/sentence_view_monthly_e0e440d7.mp3
d12c268e-de70-491f-a6e7-912a8e7e9671	1c9d517b-4923-4a83-94cd-bcfa6992a5a3	Annual leave period overlaps with holidays	Срок отпуска совпадает с праздниками	audio/sentence_annual_leave_3adb1035.mp3
4e0877ff-de6f-48bd-a67c-0dbec18ffbe2	65f06742-c4f1-40a6-accc-842fdafdc7f1	Flight departs twice weekly	Рейс вылетает дважды в неделю	audio/sentence_flight_departs_f4111e92.mp3
cdf539a6-ab44-4759-bea2-626da7f66b67	f795af22-21e5-4234-b17a-e26250cc42af	Track monthly budget for travel	Следи за месячным бюджетом	audio/sentence_track_monthly_6e178731.mp3
36ca8eec-fdaf-4b93-abdd-dd07402beb61	00307926-124d-4dd2-bf72-d6b6b5269391	Enter date correctly in DD/MM format	Правильно вводи дату в формате ДД/ММ	audio/sentence_enter_date_e48b125c.mp3
df685647-87d9-4c30-8429-8aa084a15f7f	82a9a53c-09c4-4e9c-a1d1-ada0b616e659	Daily schedule includes airport runs	В ежедневном расписании поездки в аэропорт	audio/sentence_daily_schedule_fe6e2d9f.mp3
4c1952c8-1dbd-4d43-91f0-ed1b98ef639d	11023aa9-dfc5-4c1a-9895-23e52ed8df08	Date of travel cannot be changed	Дата поездки не может быть изменена	audio/sentence_date_of_76f7440e.mp3
840f1ab3-1e64-460d-8d95-eb50520be0df	a19b578a-7bda-423b-9dfa-296bc9034417	Arrival time slot is allocated to you	Слот времени прибытия выделен вам	audio/sentence_arrival_time_d43c20a4.mp3
70d5b92f-ad14-462b-9e22-ab257ef67043	a2e91e65-3fb8-4dc2-8696-218813ab1429	Flight duration is 8 hours	Продолжительность полета - 8 часов	audio/sentence_flight_duration_579207f6.mp3
ae1f33ac-0f4c-4c7d-a651-212341107f7a	dddeac3a-6e07-4826-a96d-f229d3461643	Departure date flexibility saves money	Гибкость даты вылета экономит деньги	audio/sentence_departure_date_aa293d2d.mp3
021754c4-f728-4a0b-b694-ad92b1906154	80cbf1aa-d910-461d-822a-a42592e9eb61	Enter all travel dates	Введи все даты поездки	audio/sentence_enter_all_993187cf.mp3
6cf09cde-6bb3-40ef-97c3-aaaa4a2936ed	0c87dbb9-2e8a-4ca1-a031-875a0cd96903	Seasonal discounts apply in autumn	Сезонные скидки осенью	audio/sentence_seasonal_discounts_5d6cb418.mp3
7761bc70-5537-4bcb-8a91-3b9522e12833	a68f4815-2767-48f6-b608-13fe00f0adff	Next available date slot is November	Следующий доступный слот - ноябрь	audio/sentence_next_available_1e52339d.mp3
39fe6922-926f-44ed-821c-9b46dbae151b	3024193b-282a-4d6d-a25b-3817ad2d3a35	Daily flight schedule shows all departures	Ежедневное расписание показывает все вылеты	audio/sentence_daily_flight_9afe7d74.mp3
998bb283-6eca-42ff-8b34-d32978b38ec6	6466dee1-a1d8-4862-9587-93b60ea7001b	Biannual review of expenses	Полугодовой обзор расходов	audio/sentence_biannual_review_71b32396.mp3
f3f680ee-a17d-47fd-9b0d-b875ae223bab	c0f31543-b0ab-4ef2-b748-d920e7a4c99c	Date of entry on the visa	Дата въезда в визе	audio/sentence_date_of_95b22272.mp3
6d4ae9a6-4dd3-4833-8967-1ee49d7d8431	75eb3938-21cf-4e2d-98b9-82b179c58e86	Quarterly planning session set for July	Квартальный сеанс планирования на июль	audio/sentence_quarterly_planning_580e5416.mp3
17667b54-7610-4cab-ae6b-d1904bfd307f	2ed0691e-983a-4196-b853-c7863f1ff576	Monthly target for sales reached	Ежемесячная цель продаж достигнута	audio/sentence_monthly_target_c06dc9f4.mp3
7448a8ed-1c71-4ccb-b001-c6ec1ccd43c6	600f8498-567a-4f70-bcff-b98ba8970895	Departure gate is B42	Выход искажаетуйтеля B42	audio/sentence_departure_gate_0859f149.mp3
daf3d297-168a-4ac2-86c2-07d205d0462e	db3bd4e3-b7fb-46a1-abb4-a6fd1682db42	Arrival lounge is spacious	Зал прибытия просторный	audio/sentence_arrival_lounge_ab7792c4.mp3
ce9e06b6-c565-4c81-93fa-70a73d2abec6	6eeaa15e-c8e7-432d-9ba6-9318775bcd9d	Month of travel affects prices	Месяц поездки влияет на цены	audio/sentence_month_of_6a7c1c2e.mp3
228463e6-5f33-426a-b531-c9ebcb0eeb54	28861282-5bec-475f-931a-017935a1c880	Yearly event brings tourists	Годовое событие привлекает туристов	audio/sentence_yearly_event_14ac2fa7.mp3
b031e0d3-f5b8-46a6-8438-0dc90b3036c8	198c9649-8040-4d26-b52f-a2d370a50d99	Daylight hours vary seasonally	Продолжительность светового дня меняется по сезонам	audio/sentence_daylight_hours_634a62ed.mp3
8506fa16-a485-4178-a5a2-0c6c2e6bfb14	55fd66a3-d7e0-4d22-b263-9f7211508453	Date stamped ticket is valid	Отштампованный билет действителен	audio/sentence_date_stamped_260af226.mp3
17e9f37c-7bca-4299-8a2f-0ad658804cd1	a9600f5f-3173-476b-98a6-a4647b763b1c	Check flight calendar for cheap deals	Проверь авиакалендарь на скидки	audio/sentence_check_flight_1dd82fd1.mp3
5bf545a3-23de-4acc-bbcf-62cd63d8ae3f	91558762-f04e-40f1-948f-a1e63064db32	Peak season costs more money	Пик сезона стоит дороже	audio/sentence_peak_season_0149f412.mp3
01e704d8-260b-4c11-9d78-f174b92070a1	0a9272ff-0963-468a-8f8f-041159940d5c	Off-peak travel offers savings	Путешествие вне пика - сбережения	audio/sentence_off-peak_travel_fd42d322.mp3
91f46312-7cd9-42a9-ab91-aed0c49c856b	0a73a907-7ffc-4dce-b096-590c351c4d69	Annual limit for foreign travel exceeded	Годовой лимит заграничных поездок превышен	audio/sentence_annual_limit_7a5192a4.mp3
e4e6131a-e386-4c81-b694-31048eeb2d41	1337906c-2992-4d2d-add5-b4f6e434fc48	Quarterly performance exceeded targets	Квартальная производительность превысила цели	audio/sentence_quarterly_performance_f9a7c559.mp3
ae704873-b547-43fc-b72b-c2656c81d40f	5c88dae2-77ad-4a66-a502-3ac8d37ed1dc	Weekly summary shows travel expenses	Еженедельный отчет показывает расходы на поездки	audio/sentence_weekly_summary_ef5064a7.mp3
4178ff88-e51a-4fb2-a6eb-ba968ad4378c	9409a6f3-85a5-428d-a32d-719aa11d7ed2	Next available month is March	Следующий доступный месяц - март	audio/sentence_next_available_2609c6df.mp3
fcbd29cb-3199-4b3e-8dd7-11d93152fe2b	2a1f1656-7aae-46ca-8130-8287ffc2dda9	Daily flights connect major cities	Ежедневные рейсы связывают крупные города	audio/sentence_daily_flights_fe58f59f.mp3
756885ba-5208-45ed-a27c-bd9916180463	06735eaa-d9ad-41f2-a082-eba74193fe09	Travel month information is online	Информация о месяце поездки в сети	audio/sentence_travel_month_08f55778.mp3
c5fff655-ea6c-482f-873a-5f7c2b151aff	34aef930-d215-4621-a96c-fa697d314782	Yearly meeting is in November	Годовое собрание в ноябре	audio/sentence_yearly_meeting_7d4cacff.mp3
4f042f7f-3982-4a7c-a9f6-9d507f4a8e6f	d71c5824-e437-4ec2-980c-d6c339cca786	Bimonthly visit to the branch	Раз в два месяца посещение филиала	audio/sentence_bimonthly_visit_760d65aa.mp3
31c9deef-8bd6-4ef4-b94a-7e1ff707e827	da6c5f8d-78b9-417f-838d-f3f30e5030e0	Date of issue shown on ticket	Дата выдачи на билете	audio/sentence_date_of_abb8b4dc.mp3
93c15b52-1f85-46b7-b669-bcdb29d47332	a74929f2-bec6-4f83-b586-4f6def73421d	Monthly targets met consistently	Ежемесячные цели последовательно достигнуты	audio/sentence_monthly_targets_b2b4d4fb.mp3
f2c1f059-532c-468d-9bd7-449177d4f807	d28ede57-1809-4b72-839e-d81c071eedbf	Overnight flight to New York	Ночной рейс в Нью-Йорк	audio/sentence_overnight_flight_1eebce44.mp3
9c038bed-c456-4611-afce-c311e60db0a8	fc84ffc8-7c7e-429f-8b75-b064dd6de1d2	Date validation check passed	Проверка валидности даты пройдена	audio/sentence_date_validation_049f4a3a.mp3
4642b3d0-fe07-404c-99ba-33ab047ab679	4cc8ef18-d5a5-4a21-b0a6-f5b58c0f426a	Flight path variation saves fuel	Изменение маршрута экономит топливо	audio/sentence_flight_path_21980391.mp3
0de4d3da-7b78-42b6-856c-7d534d422835	9ac2bbf5-ce4b-4458-ad03-2704c99bc568	Booking date stamp confirms reservation	Штамп даты бронирования подтверждает бронирование	audio/sentence_booking_date_9c87d4f1.mp3
2e030868-6478-4ee6-99c2-a58c3af91c43	4cfaa495-c7e2-48a6-abc2-bb7143ec976a	Trip duration planner estimates costs	Планировщик длительности оценивает расходы	audio/sentence_trip_duration_98e10a8d.mp3
b9bf71bf-3009-4f38-b488-1d1e304e6286	78d31366-9169-4621-aea4-a6cf67d189e9	Quarterly financial report released	Квартальный финансовый отчет опубликован	audio/sentence_quarterly_financial_d48e93b1.mp3
96f85739-8803-4435-81bb-842f16434d30	9740d3db-4247-40a5-85d6-fb171bb6304e	Last minute travel deals available	Есть выгодные предложения по срочным поездкам	audio/sentence_last_minute_34d9b662.mp3
30ba1de2-febf-4f71-aa6d-c542cf4dc595	d6ac6be2-c27f-4496-a2c1-ecf4f24a18e6	Book the ticket in advance	Бронируйте билет заранее	audio/sentence_book_the_a0d0e0b8.mp3
41cb4196-a919-4812-9b7f-7c0c45c85703	68cc8bf2-7f76-4cfe-8d1a-c7440a095775	Twice yearly event held in city center	Событие дважды в год проходит в центре города	audio/sentence_twice_yearly_161deb03.mp3
baad00c9-d968-4516-990f-403d0f661bf6	b9148d81-e591-467c-867b-66c8e3c8171e	Date of passport issue must be entered	Нужно ввести дату выдачи паспорта	audio/sentence_date_of_4c4ed370.mp3
2df1a907-81fb-4169-9aa3-4d4ec893f81e	43aeda69-1a78-4bfd-b689-5246ef7c30d7	Seasonal trends affect ticket prices	Сезонные тенденции влияют на цены на билеты	audio/sentence_seasonal_trends_ea45e392.mp3
a0b11460-b2b6-4599-971c-833654f771b6	7f3c85ea-7ce5-4874-9956-2f85a42adda6	Weekly hotel rates lower than daily	Ежедельные отельные ставки ниже дневных	audio/sentence_weekly_hotel_6bcc525c.mp3
a0665bcf-daf7-44b3-b2ad-2bbf9ddddb1d	17c1d39b-6298-4501-b708-0cc1212a1dc1	Monthly subscription includes discounts	Ежемесячная подписка включает скидки	audio/sentence_monthly_subscription_077b40f1.mp3
30942218-ce4d-4ed5-a40f-47ec1e169a71	73ad5a88-6e4e-418f-98b1-48c025e61226	Annual membership fee waived first year	Годовой взнос за членство отменен в первый год	audio/sentence_annual_membership_21e90756.mp3
a4de5191-c7cc-457b-bfa8-a1fb93b22eb7	cdb40e40-cc85-470f-9349-e650db30bd8a	Seasonal menu features local dishes	Сезонное меню предлагает местные блюда	audio/sentence_seasonal_menu_455d890e.mp3
a5baf023-39c9-405d-ad15-b616be9ba2c6	59a4fcc5-ece4-4a5a-89e6-263d0677f747	Departure lounge notification announced	Объявлено уведомление в зале вылета	audio/sentence_departure_lounge_cdd211f6.mp3
f1804006-17ed-4aa4-b286-eb4870c963dd	a6552443-e317-44bb-a381-ed98fdc9e2c9	Arrival time flexibility offered airline	Авиакомпания предлагает гибкость времени прибытия	audio/sentence_arrival_time_2909d5cf.mp3
f0a31474-fe7b-4054-9855-7338fcf74291	2c0ce71c-5235-4032-b349-ae86437a6cd8	Daily flight numbers listed online	Номера рейсов в день показаны в сети	audio/sentence_daily_flight_f43c2719.mp3
fd365a48-30ef-47b4-b9fa-f66626e64f5d	cbc2d502-2ace-4f57-8dc4-8a4f65413288	Next day delivery for urgent tickets	Доставка на следующий день для срочных билетов	audio/sentence_next_day_6825949b.mp3
f539c8e1-604a-4814-b314-adc5fa430584	e8e9a738-2b84-4feb-aa7d-5a306fe1a668	Flight frequency monitoring required	Требуется мониторинг частоты рейсов	audio/sentence_flight_frequency_18a3f46d.mp3
5dc3716a-4579-44b2-a045-a7803a28bf2a	bff428a3-d92a-4bc8-a076-af0ed6d93cef	Travel date flexibility saves costs	Гибкость даты поездки экономит затраты	audio/sentence_travel_date_cda22435.mp3
412a9f75-5f99-4285-8c66-cff595397321	9b5130ae-2077-4937-97f4-5ff8b4598e8e	Flight path reduces flight duration	Оптимизация маршрута сокращает длительность полета	audio/sentence_flight_path_60d3bf5e.mp3
7d914dcb-8b7b-48e4-9ea1-77014a5f2157	fee8a3ae-4ef8-4746-8511-20409d2dac17	Arrival hall signage is multilingual	Указатели в зале прибытия на нескольких языках	audio/sentence_arrival_hall_7e05a689.mp3
23836316-08d4-4e36-9c3e-be1621d8c9d8	761d470e-58c8-4435-9dcc-d1a8de204b49	Monthly expense tracker app	Приложение для трекера расходов	audio/sentence_monthly_expense_0034a803.mp3
f1c4bb26-87bf-44b9-b332-8d26d45334c5	f45b5be5-3a7a-432a-8810-6c5ada22bccb	Semester break travel schedules	Расписание поездок на каникулы	audio/sentence_semester_break_3d328495.mp3
ca1e7b36-9c36-4402-b0c5-3810b17a0fc5	aee005d3-ba18-4e28-be0a-f2955a9840dc	Year end sales include travel deals	Годовые распродажи включают путешествия	audio/sentence_year_end_fdfc8469.mp3
c98e8c6e-df97-4d3e-9de3-60d15102392e	40f9a32c-a6b1-4a0a-b635-ea1d3d0bad22	Annual budget meeting scheduled	Назначена встреча о бюджете	audio/sentence_annual_budget_45e45a11.mp3
41e56d55-064d-45c2-97d9-b9e712531a36	6ae43588-137f-4a53-b75e-aba2f9e4d84c	Date format specification must be followed	Должен соблюдаться спецификация формата даты	audio/sentence_date_format_038856f1.mp3
fa4ba22e-ac8d-4ee7-ac60-367cd45db069	f3ef31dd-bbd8-441a-a30f-de953b066cf1	Flight time table lookup system	Система поиска в расписании рейсов	audio/sentence_flight_time_1a300e93.mp3
d13508d7-2948-44af-90c6-898ad3be49f3	039cd757-689b-4325-acdc-15686c873ec8	Arrival concierge service available	Доступна служба встречи при прибытии	audio/sentence_arrival_concierge_b9484971.mp3
3be72d5b-6d05-4d27-b5fc-271150e7677a	5febf2f9-f296-4aaf-a7c9-4c38b113f4dd	Next day itinerary arranged	Распорядок на следующий день организован	audio/sentence_next_day_019ad91e.mp3
62b7bc79-cfe8-4204-a397-4d64be5e460f	243eb985-6993-4579-a367-3d29402c85d4	Flight path tracking shows delays	Трекинг маршрута показывает задержки	audio/sentence_flight_path_27f4141d.mp3
d5d7b7f0-9452-4680-8e66-e53f321ec934	97d148e6-c1be-4783-9a38-ae517adfde03	Bimonthly subscription for magazines	Подписка на журналы раз в два месяца	audio/sentence_bimonthly_subscription_9656b806.mp3
8bf05449-d4ac-4517-ac64-841b1fbbd7c3	b530c245-9609-4176-b45a-d66febf75b95	Monthly performance review conducted	Проведено ежемесячное обзорное собрание	audio/sentence_monthly_performance_ba75c06c.mp3
4895260c-eb84-4b93-9df8-8f625e447a91	6fce7e1b-343c-49bb-84b1-a0b19dfd8e02	Date stamping machine at check-in	Машина для штамповки даты на регистрации	audio/sentence_date_stamping_f111e4fb.mp3
46563d15-1436-4161-ab55-dc2aa5c30b35	862582d4-54be-4d5e-be21-ebf31a7ed38c	Seasonal promotions on hotel rooms	Сезонные акции на номера в гостиницах	audio/sentence_seasonal_promotions_0423ff00.mp3
d0f097aa-785e-4f9b-a0f1-05b31b206baf	9bf3f3e6-6e2e-45dc-b853-8d3db17e9149	Arrival terminal guide available	Доступен гид по терминалу прибытия	audio/sentence_arrival_terminal_0d0ba863.mp3
0fb77214-9321-45b2-b6cf-e5b469cb7d6c	5379528a-f70a-4554-b225-0899e849d2bf	Flight schedule frequency explained	Объяснена частота расписания рейсов	audio/sentence_flight_schedule_0bd7395a.mp3
165c6cec-13a0-4b80-92ff-b71494d806d0	2efc2358-8fd3-4792-9de9-936780d9eb6f	Daily departure schedule displayed	Отображено расписание вылетов в день	audio/sentence_daily_departure_4dd9407f.mp3
3824ee2c-3d52-4466-9fa9-bc46a5909d68	47a92f0e-610b-4242-821c-8750104b8562	Quarterly business result impressive	Впечатлительный квартальный результат работы	audio/sentence_quarterly_business_bcbd942a.mp3
0d5216f2-7ef3-4452-b4f5-9937a3022597	bb157aeb-8dfe-43bf-ae1e-a09a4d2bab1f	Trip duration extension possible	Продление длительности поездки возможно	audio/sentence_trip_duration_aa87cecb.mp3
0f690f26-a3be-4b08-813a-9fdedfca8cab	70bd81b9-0346-459c-9af1-3ee85e2b7910	Date of entry visa requirements	Требования к дате въезда в визе	audio/sentence_date_of_57276bca.mp3
5b6f983d-b346-4445-b20a-6aae64804327	3a325205-225e-4b68-abf1-ed2bf5c4e72f	Seasonal temperature variation affects travel	Сезонное колебание температур влияет на поездки	audio/sentence_seasonal_temperature_e06ec216.mp3
dcc7b56a-5cc9-48da-b88a-636b185b2233	f8fbb759-c761-406c-8a3d-c52265762a5d	Weekly chit chat meeting scheduled	Назначена встреча еженедельная болтовня	audio/sentence_weekly_chit_c3f23a55.mp3
0099b71d-70c5-4ad7-a71f-0830781667b8	7d921093-8d7b-4b04-bee7-0b57319dd49a	Arrival baggage claim display shows baggage	Табло показывает багаж прилетевший	audio/sentence_arrival_baggage_4c33363b.mp3
ba7e698d-ebfe-49c2-ae70-1404e836e22b	863375ed-4d20-4ff4-9d0d-c4d412dfe443	Monthly financial statement prepared	Подготовлен ежемесячный финансовый отчет	audio/sentence_monthly_financial_c07a2a22.mp3
326bdd96-9ace-415a-bd73-60c2e1e8115a	d193299e-0d13-4cf5-ab8b-802563d67176	Bimonthly training session conducted	Проведен двухнедельный учебный сеанс	audio/sentence_bimonthly_training_5e0278b5.mp3
453783ea-87f2-4715-8e55-4ab344ff7623	5bde5585-7502-4b9d-a1cf-cacd61d50e26	Date stamp validation required	Требуется проверка штампа даты	audio/sentence_date_stamp_693ecc0c.mp3
8080080b-164f-4347-a279-d3a7536461c5	022a67e5-a83b-4516-9710-8ebd224f0d7f	Flight path accuracy check performed	Выполнена проверка точности маршрута полета	audio/sentence_flight_path_94aa5014.mp3
7d4e5e7f-025f-4b95-b72b-ffca572cfa03	fa1ef7ff-f3e6-440f-bdb8-6bead9b2a59a	Arrival door service counter helpful	Полезен сервисная стойка у дверей прибытия	audio/sentence_arrival_door_b3ed2a80.mp3
818172eb-7be9-48e6-94ea-2afc305d7671	2106b32c-9767-4805-8a3d-34b76ca01902	Next available boarding gate announced	Объявлен следующий доступный выход на посадку	audio/sentence_next_available_03deeca2.mp3
b371c63a-3ad7-40f4-8e53-f72894e269c9	c9686011-ae72-4f5b-a52c-6bcb5aee7bf8	Flight schedule planner recommended	Рекомендован планировщик расписания рейсов	audio/sentence_flight_schedule_1e62c864.mp3
613b9a21-1110-45a4-97dd-96419162de42	d9e994cd-ff0a-479a-8605-fcc71952881f	Arrival instruction booklet provided	Предоставлена инструкция при прибытии	audio/sentence_arrival_instruction_5e9d5dcc.mp3
7b886ed9-c8dd-475e-85de-85bc7f770ff7	6c95d10c-b205-4dc8-b745-ca89e50d34d4	Date passport issued verified	Дата выдачи паспорта проверена	audio/sentence_date_passport_c2bd803f.mp3
d1b82638-e05c-480c-b443-4306bda85dbe	fb0e0d39-af31-42af-80e9-72999936f39c	Seasonal travel tip shared in blog	Сезонный совет по путешествиям поделился в блоге	audio/sentence_seasonal_travel_50fdb78e.mp3
5966d17d-e756-4fb4-9914-331248c3919f	362677df-fb27-4d28-aa4e-32923f087c15	Weekly team meeting rescheduled	Еженедельная встреча команды перенесена	audio/sentence_weekly_team_f391e696.mp3
18b36ca8-974a-4811-b9b0-8302c7ffe9fc	7d77bb9d-07af-4da5-ba29-8cd4729cd1c0	Flight path weather impact assessed	Оценено влияние погоды на маршрут полета	audio/sentence_flight_path_da2a7b64.mp3
20f51099-56d8-4ae6-a4d2-b7722c357a34	9755ed17-1f02-401c-b00e-b045e98cea94	Arrival assistance service available	Доступна служба помощи при прибытии	audio/sentence_arrival_assistance_aa109938.mp3
40ee066b-79bf-4b16-b535-e714f3957b0d	0b5c6517-f12c-417e-b3f5-8dda8994813e	Trip duration calculator reliable	Калькулятор длительности поездки надежен	audio/sentence_trip_duration_52e11448.mp3
ed9f92ec-6811-49a8-a984-ed09f9b1e2af	b73bda73-7888-4f27-a166-5f7945bff70b	Quarterly bonus payment processed	Квартальная выплата бонуса обработана	audio/sentence_quarterly_bonus_f16c8dad.mp3
a3dcfcfa-9c56-4ac0-990b-f50f497dc33f	622e491a-38a7-4455-b268-f9d388a95c3d	Bimonthly performance review scheduled	Назначен двухнедельный пересмотр производительности	audio/sentence_bimonthly_performance_70e85234.mp3
bc1d807f-e63d-4e9f-8b48-fa897af7dfd8	b9704973-482c-44c9-a278-55c7d43d447f	Flight path reroute protocol activated	Активирован протокол перенаправления маршрута полета	audio/sentence_flight_path_2c64da87.mp3
2caed0ec-c4ba-4e9a-a0e1-884bd4db2142	fcf2331a-3214-47aa-b292-4dfeb63cd6d7	Travel date flexibility fee waived	Плата за гибкость даты поездки отменена	audio/sentence_travel_date_a6c5164d.mp3
9a8add84-30aa-47c0-b666-3aeb5a461e69	ab56adb7-df18-4dd9-aa4f-7cf215fadb2e	Seasonal cargo schedule adjusted	Сезонное расписание грузов скорректировано	audio/sentence_seasonal_cargo_43774a23.mp3
a953124f-9a35-4721-a71a-5108f490fb21	a00cbd4a-c35a-492b-8131-26573dc58124	Weekly backup system check completed	Завершена еженедельная проверка резервной системы	audio/sentence_weekly_backup_b542a384.mp3
8d7ac6a3-c4ad-4d3a-ba42-b38f110af444	7f52736c-832d-409c-b57c-b334387ca915	Bimonthly security drill conducted	Проведена двухнедельная проверка безопасности	audio/sentence_bimonthly_security_975676eb.mp3
38d01fdc-3bff-4870-a6b3-cf8e16b92ef6	edad1152-c894-4949-871f-638f1cb80fda	Flight path optimization cost calculated	Рассчитана стоимость оптимизации маршрута полета	audio/sentence_flight_path_a8f0cb26.mp3
8faf644c-735d-4454-99c8-79a197a4947d	93f2a32d-f073-48a0-9873-317ab0e8e7ba	Date format conversion tool helpful	Инструмент преобразования формата даты полезен	audio/sentence_date_format_dce5ae62.mp3
014fb35b-7d8d-48a9-b86c-1a1fc843c8a6	0a1f4fcc-498d-422a-9ddd-ebd96325079f	Seasonal staffing plan implemented	Реализован сезонный план персонала	audio/sentence_seasonal_staffing_699a6b5e.mp3
6be5e727-1cfa-43c1-a2ad-b37308d3eb1b	40dd8d51-05fd-440f-81c6-43e0e843f5da	Arrival procedure manual updated	Инструкция при прибытия обновлена	audio/sentence_arrival_procedure_e46426f9.mp3
b21c1b7f-fdd3-43f3-bfe6-5baefaa673c1	d4ea0b29-5bc4-4f88-82d1-2283b55d4636	Date passport validation rule enforced	Правило проверки паспорта даты применяется	audio/sentence_date_passport_c920c47a.mp3
763c1166-5cac-4950-b0c5-99f3ff3de616	b6a86f71-3353-45be-97b9-afd47f3e1617	Flight schedule disruption log maintained	Ведется журнал сбоев расписания рейсов	audio/sentence_flight_schedule_3dbabd42.mp3
4dc6cd02-ce21-46a8-84b6-e2336cea470c	16b21f6e-27ab-4850-aea2-57300abc7e9d	Which month does your holiday fall in?	В каком месяце приходится ваш отпуск?	audio/sentence_which_month_687f482a.mp3
767753ea-3e99-466d-b300-0176b7b6c135	b2efe8c8-b447-47f9-9bcf-5d8008f3ad73	Could you confirm the travel date?	Можете подтвердить дату поездки?	audio/sentence_could_you_4a565c78.mp3
e699b06d-f60e-4a3e-81a3-e8762cab68dc	05b4fb47-6a12-4213-b2d4-33d46a3328e6	Today is the departure day	Сегодня день вылета	audio/sentence_today_is_091550c9.mp3
3d3070b8-4d9a-461c-98ba-4e13f4c99b78	0fa7595c-4cef-4ce9-a782-53c4bdf4eea6	The flight departs tomorrow	Рейс вылетает завтра	audio/sentence_the_flight_db52f473.mp3
068963ef-7548-44a6-890b-802e42b5c9c2	866847a2-8949-4216-861f-11a35dcd82a3	Arrived yesterday	Прилетел вчера	audio/sentence_arrived_yesterday_8ddcae79.mp3
bc5239f8-21ee-4242-97c2-82ebe71552a6	60c0415f-d59a-4d75-a278-db4dbe7634cf	Weekday fares are cheaper	Цены в будние дни дешевле	audio/sentence_weekday_fares_b62c670a.mp3
199b1842-05b8-48cd-bea4-41c05be0fc83	e7302e31-4c8d-4c20-ba37-357db77505ce	Weekend travel requires advance notice	За поездку в выходные нужно предупреждать заранее	audio/sentence_weekend_travel_4e150cae.mp3
e564a8b0-553f-4293-a1d1-7cc610d525a8	4e8f8f79-e0b7-4577-b6fc-f5297089c859	Which year is your booking for?	На какой год бронирование?	audio/sentence_which_year_41f1cfdc.mp3
5c4c40a3-f2ad-4fb9-bd4d-6dd17e17a3b4	ee834b94-7711-4185-b6f7-8c3a219836af	Check the calendar for free dates	Проверь календарь на свободные даты	audio/sentence_check_the_006f25fa.mp3
12aa8c35-07ce-4c42-81b6-64f9331addca	c8c01cee-1ffb-4a68-9eb9-35d6b530c2e2	The flight schedule is online	Расписание рейсов в сети	audio/sentence_the_flight_6c980d6d.mp3
a22d06a9-ad53-4775-b1ec-7f092f99564b	da35778a-eda2-4f61-88c0-0401210e894f	Off-season travel is budget-friendly	Путешествие в межсезонье бюджетное	audio/sentence_off-season_travel_be2d92bc.mp3
0471c07c-2e20-41f1-9952-39ced9be297b	134f783e-8662-4d8c-86dc-c9b153110141	Holidays affect flight prices	Праздники влияют на цены на авиабилеты	audio/sentence_holidays_affect_33df91e5.mp3
f54b99e7-a301-4697-a991-a6ee923a34fa	e72a0d57-ac8f-4dcf-8382-c46416ec969d	Always check the date on your ticket	Всегда проверяйте дату на билете	audio/sentence_always_check_047cafa8.mp3
8ad61bb3-a238-4293-9ce7-3723730df6d8	b2cb74f5-1173-4371-bb63-fd26c0bda30a	Excuse me, what's the date today?	Извините, какая сегодня дата?	audio/sentence_excuse_me,_b9ed0f8b.mp3
9505cdba-3fda-4ecb-90f7-071c96d677d8	cb5b7559-d06b-4620-9b82-4b4e937e1d3a	January is the first month of the year	Январь - первый месяц года	audio/sentence_january_is_4aed1809.mp3
7e978019-cccb-4781-a80d-747861b2fab4	d420519f-a38a-4f8a-9374-830fd876033c	What day of the week is the check-in?	Какой день недели регистрация?	audio/sentence_what_day_aaa4400b.mp3
fdc5d4f4-9176-42f7-a26d-5cd95aad419e	a944083a-481b-4b01-9a30-9e184f18fa57	You must enter your birth date	Нужно ввести дату рождения	audio/sentence_you_must_64149a8f.mp3
ba58369f-dab4-4102-933a-60c0cd235211	2c7373c8-9276-4e33-82a5-59eb824068a4	I'll fly this week	Я лечу на этой неделе	audio/sentence_i'll_fly_9c2b14f0.mp3
24ef8e44-3f1e-4099-9cd2-19976aac4996	2f0d52cc-1fc4-4aa2-bc68-aa29074c1bcf	Meeting schedules move to next week	Встречи переносятся на следующую неделю	audio/sentence_meeting_schedules_3d371608.mp3
bb0740ad-7ded-434e-9c68-3e992aba7144	0bd96d43-9a33-49fa-b1f9-858d9d23ac6b	Booked tickets last week	Билеты забронированы на прошлой неделе	audio/sentence_booked_tickets_35219296.mp3
27ad31a0-68d9-4c08-b322-c8bf2344ad32	2ce47d65-91a5-4e64-ae9b-992089cb6f1b	Adjust for different time zones	Скорректируй для разных часовых поясов	audio/sentence_adjust_for_09c3b2d8.mp3
6f3d816d-bc56-4986-ada8-3a80d6792c46	dbf87cc7-3c73-4cc8-adb7-cf34a83aa331	Departure at midnight meets the schedule	Вылет в полночь符合 расписанию	audio/sentence_departure_at_c5f92211.mp3
1ac6843a-d5af-4a09-ba35-a59f88442586	46cc6e62-1362-44bd-8fc6-4b43f8407662	Arrival at noon is convenient	Прибытие в полдень удобно	audio/sentence_arrival_at_91692676.mp3
d891bbef-038f-44ac-9013-17574569e3c2	8157ebf9-1abd-48b9-973c-4c5506876f8b	Trip from June to July	Поездка с июня по июль	audio/sentence_trip_from_8593b45e.mp3
2897bb9b-4f32-45d5-ac0d-6c98b58e349c	8ada5e44-b410-4b60-8e73-591733f9c100	Enter your date of birth please	Введите дату рождения	audio/sentence_enter_your_e8308992.mp3
2af56e4a-7de2-45e6-a321-85c4e7632b02	e67f6ac2-f52a-4885-9fbc-e6b35d34e538	Check the bus timetable	Проверить расписание автобусов	audio/sentence_check_the_960d5984.mp3
fe2c7260-b627-4526-bf77-230a308a9ff6	bb1cdfa0-522d-4053-82e5-1f035a3d1779	Travel costs increased last month	Цены на поездки выросли в прошлом месяце	audio/sentence_travel_costs_bc6115aa.mp3
53ede27c-8811-421b-ae4e-1e150d68f37c	d4a13529-f753-42d3-af67-538af562015d	Will finalize plans next month	Окончательные планы в следующем месяце	audio/sentence_will_finalize_ff03fe3e.mp3
db1f527f-fc52-41d0-8969-2b5847d9b585	30d0a593-5f4c-4b58-bdbb-e2f3db4af61a	Earnings fell in the third quarter	Доход упал в третьем квартале	audio/sentence_earnings_fell_83f743b0.mp3
9065044e-080b-43ea-b6bf-1e8180504944	08cdba2a-3821-4aa8-8401-522184936192	I'll stay for a fortnight	Останусь на две недели	audio/sentence_i'll_stay_ae622283.mp3
6f1100cf-f88b-4686-81e6-ba018b20e59a	9b1efda5-c418-4510-9965-0dd47c5b5230	Track annual expenditure	Отслеживай годовые расходы	audio/sentence_track_annual_6a85d6d2.mp3
3999b577-2899-40b8-b595-ee8011e63ed2	368f27a1-44e2-4928-8033-173277efd123	Best booking window opens soon	Лучшее окно бронирования скоро откроется	audio/sentence_best_booking_b4310ec9.mp3
264ba87c-d8ff-48e4-bab0-60b60af63176	f76b0391-7206-445f-9d89-f5b18b4c7d22	High season prices are steep	Высокий сезон - высокие цены	audio/sentence_high_season_0c4c721b.mp3
c2c1ecdd-4386-4040-bd02-e4412ff3dfc3	27805ae1-0571-499e-8c83-cecd4cb0ea7c	Low season discounts are available	Скидки в низкий сезон доступны	audio/sentence_low_season_62162d22.mp3
6061e362-5847-4587-abbb-f18e7b81d29b	3a0d7097-a868-42a7-bee9-d7f5712cd38c	Scheduling week days off is rare	Выходные в будние дни - редкость	audio/sentence_scheduling_week_ffe848c9.mp3
3bd7798b-c806-48c6-b5ac-943dfbf7c301	82379bf3-646e-4ddf-87be-f4b911af4de3	Planned arrival matches the schedule	Планируемый прилет соответствует расписанию	audio/sentence_planned_arrival_591dca2c.mp3
cbe32989-bd53-41f7-bef6-0f15b8e92a33	ea427cdd-f1ab-4973-9f21-d8612d382667	Select your preferred time slot	Выбери желаемый временной слот	audio/sentence_select_your_60c9a8fe.mp3
34a7409b-560e-497c-8267-4b0463fb8884	81f53fc0-445c-4ada-8706-1d0fcad936a2	Enter the date range results	Введите диапазон дат	audio/sentence_enter_the_d3c7f2b4.mp3
9961a818-62f6-43cb-8ac6-6ba3da03c776	a873eb49-f127-4460-bf5f-fe6eca0423b9	Day trips during holidays	Однодневные поездки в праздники	audio/sentence_day_trips_f7ec2e5b.mp3
95b60265-0326-4cd9-9c19-69bd3a178c91	ce129a69-0961-4a1c-8d57-e697fb31e7ff	Buy a monthly pass for commutes	Купи ежемесячный проездной для поездок	audio/sentence_buy_a_c089a91b.mp3
3b89228d-8b3c-47df-a7c9-0ed58e7a4b7d	9a611b7f-6e4e-48c2-bd85-17326ca4a83f	Fiscal year closed in the annual report	Финансовый год закрыт в годовом отчете	audio/sentence_fiscal_year_d35cf3ea.mp3
17430642-e636-4e27-93ad-3e31735f85c2	71fa3c2e-a8e2-48dc-ac11-99413280de0d	Seasonal ticket offers savings	Сезонный билет - экономия	audio/sentence_seasonal_ticket_a0959093.mp3
ab8e6109-1ea7-4604-a720-2288ab3e60bf	c11a11dd-d5c9-4242-aa57-e1f87f5197aa	Change clocks during daylight saving time	Часы меняются на летнее время	audio/sentence_change_clocks_8bf9c287.mp3
89c1672b-73db-46fb-bf2f-aa653eb507b5	94acfeb7-e214-4de6-a66c-a03cb04f0e08	Check flight path on maps	Проверь маршрут полета на картах	audio/sentence_check_flight_450e5c91.mp3
3c23e822-51ee-439a-a7ba-a3590ae290ad	31b19895-3577-45f6-8bb9-bd06d07ad00c	Arrival date change fee applies	Взимается плата за изменение даты прибытия	audio/sentence_arrival_date_5c306358.mp3
6b13cd43-4594-4ece-815c-ec274bcea1cc	a6bfc260-f30c-4e8f-b572-f684aa1a3486	Departure time is noted in the ticket	Время вылета указано в билете	audio/sentence_departure_time_4c381336.mp3
5be51811-da98-457c-9c94-83f1ba2b74d3	6cd734eb-8e23-4d17-b5d1-e66f745ee2fd	Date validation shows no conflicts	Проверка даты показывает конфликтов нет	audio/sentence_date_validation_8bbf5c3f.mp3
563da03c-43b6-42df-99d8-df9310dae95d	16b5f876-cc49-4f1e-978c-f742361cfe76	Travel date selection affects price	Выбор даты поездки влияет на цену	audio/sentence_travel_date_6e5ebbec.mp3
60b9d3b5-bfb1-4480-97fc-95ca16cb74c1	91af51cc-0bf2-4bb9-b0c5-b2f186c65cb2	Booking confirmation has the date	Подтверждение бронирования содержит дату	audio/sentence_booking_confirmation_72bfe283.mp3
bc00394f-867e-49e2-8451-444dad60328d	35a65bca-251e-411b-a1fe-bfc227a8e4b8	Plan a weekend getaway	Запланируй поездку на выходные	audio/sentence_plan_a_a9a89178.mp3
b786968b-2860-4ab1-a3bc-78e91b45c6c3	b719ae24-59e1-43be-a961-45b8b2e4e9a0	Trip duration is two weeks	Длительность поездки - две недели	audio/sentence_trip_duration_9061702a.mp3
d194e191-776d-4f97-af4f-9bfc7b54f454	f6482bcc-72e1-4f31-8e6e-ba291694c606	Last day off before vacation	Последний выходной перед отпуском	audio/sentence_last_day_70741e61.mp3
fc6fb555-84ce-4622-a11e-0f8e694e21f4	8f8f9940-925a-4f62-a76d-e42fd04e47dc	Meeting scheduled for next Monday	Встреча назначена на понедельник	audio/sentence_meeting_scheduled_b51f9c5b.mp3
38d55cef-a6ef-437b-a480-cb48a17f65f9	56feb4e4-87dc-4b86-b7ce-5c99d29fd490	Clocks go forward in spring	Весной часы переводят вперед	audio/sentence_clocks_go_5891b621.mp3
628adb49-549d-434a-98b7-b2e54c023e58	7faaffe3-e885-449c-b31b-e3ff050c6610	Clocks go back in autumn	Осенью часы переводят назад	audio/sentence_clocks_go_c80a9474.mp3
bfe9e078-2329-453c-a0b5-363a7bb3b7f5	14411510-9bbe-455b-993c-ac3f206be0e5	Stay within the monthly limit	Не превышай месячный лимит	audio/sentence_stay_within_cf4e34a0.mp3
85bb99c0-7d38-4751-a4b0-65b98077652d	c027d058-36a0-4bff-b20e-0eea134ecd98	Annual festival draws crowds	Годовой фестиваль привлекает толпы	audio/sentence_annual_festival_f65a09a0.mp3
47e10ba2-673f-4079-b378-4428c5bdd5c9	dae49813-8564-4ce1-8c7a-3af570a9db2d	Check date of expiry on card	Проверь срок действия карты	audio/sentence_check_date_1b07474e.mp3
9a2db29e-1801-4e9e-a968-b7a3d4464bb9	339b40b5-f8c0-45c7-b2cb-0c38cdaf084d	Travel period coincides with holidays	Период поездки совпадает с праздниками	audio/sentence_travel_period_7cd7c99e.mp3
f41920e8-e5ba-4ff3-9aaf-6928b3d681b8	56b52b90-ef12-4519-9544-0f4bcbd68505	Departure hall opens two hours early	Зал вылета открывается на два часа раньше	audio/sentence_departure_hall_8d91734f.mp3
1d4622f0-a1f5-4668-a83d-7e6ebb353bec	24925e2a-fec4-44c1-b420-0a51d2e12d95	Arrival area gets crowded	Зал прилета заполняется	audio/sentence_arrival_area_5a37776d.mp3
5d750959-3895-4321-934c-a4a3ceb8de9a	0c5b2874-a1b8-4766-a53a-ce037fb48462	Todays date matches the booking	Совпадает сегодняшняя дата	audio/sentence_todays_date_636f46a0.mp3
28a256dd-a49a-4aba-b7b7-e6829f9d5700	3bce3c85-4f00-41b3-92bb-c65bf95c2a23	Financial reports due at month end	Финансовые отчеты к концу месяца	audio/sentence_financial_reports_e7106338.mp3
49b9f3c0-4186-43af-8d16-39c02b83b150	51dc9f9c-21d6-4073-82a2-1c6e3e692577	Year end report shows profits	Годовой отчет показывает прибыль	audio/sentence_year_end_58bd09dd.mp3
10f02682-e879-414f-a4a2-fb4cb08d4e5c	af48d976-33ff-4b59-b946-9cea57d1e890	Quarterly results beat forecasts	Квартальные результаты превзошли прогнозы	audio/sentence_quarterly_results_ebc00749.mp3
29beff84-42e5-4d80-9e99-265db8a67e1d	4f616fbd-e7ff-43df-a66d-3e35fde5676a	Check daily routine before travel	Проверь распорядок перед поездкой	audio/sentence_check_daily_5ab0f661.mp3
7833fcb2-a539-4e7c-9d8b-f9ca54c87394	ccb537df-87ec-448d-81c1-fd16ca67d177	Biannual visit to relatives	Полугодовое посещение родственников	audio/sentence_biannual_visit_a6c8d141.mp3
643f872e-1604-46f3-ac98-54676cf62ab8	5ed5da1f-8ec5-4a6b-81bd-dd9ec87ef3b8	Overnight stay before connecting flight	Ночка в трансферном аэропорту	audio/sentence_overnight_stay_b0fd9544.mp3
1e4ed9df-48d8-45e3-9d76-c2699d20f8e0	c96edc36-57c0-45e3-86d7-fb5e7545b6e3	Same-day return flights cost more	Рейсы с возвращением в тот же день дороже	audio/sentence_same-day_return_e99d8934.mp3
bbaef325-600a-4d0a-85e1-3a35b394eb1f	c103e03d-56cf-44b1-9869-bc903d89e9c3	Check weekly flight schedule online	Проверяем расписание рейсов онлайн	audio/sentence_check_weekly_ef447938.mp3
2c81589f-8642-4aee-a7a1-f73c7acabe1f	f89ba8c2-e9ac-4c4b-b844-a94fd2d98b18	Date not available in booking system	В системе бронирования дата недоступна	audio/sentence_date_not_2b4f7ad2.mp3
262f1518-b41c-436a-8e8f-7fb0d4b01735	a7cb33b2-9c2b-4a37-b0bd-b5e06be7dabc	See availability date before booking	Смотрим доступную дату перед бронированием	audio/sentence_see_availability_304d0821.mp3
c5b51716-730d-43c4-ba69-cab2ad13851b	88dff52b-5ef6-4aed-b95a-6436f110e999	Next available date is in three weeks	Следующая доступная дата через три недели	audio/sentence_next_available_91a3c542.mp3
09df43bf-6ced-4569-b6ee-71cd96591543	c11423df-0e91-42ad-89fe-90cc9ed3da6b	Flight frequency increases in summer	Частота рейсов увеличивается летом	audio/sentence_flight_frequency_a2530a1f.mp3
eb797808-477d-48df-97ca-fce2c3767d27	121869d4-41e3-4b7f-ab09-49c7992694c3	Daily flight operates on this route	Ежедневный рейс operates по этому маршруту	audio/sentence_daily_flight_8d556d17.mp3
fbeb3e0b-3634-4d0f-8104-49c7a65c98f6	1268f797-b8b9-4a55-ae52-7dfba33b16a2	View monthly calendar of meetings	Посмотреть календарь на месяц	audio/sentence_view_monthly_7a286010.mp3
b263c62c-604f-4424-9265-c60de0b006e4	2a9ac0ee-e2cf-47e8-9159-f3c8d0f63190	Annual leave period overlaps with holidays	Срок отпуска совпадает с праздниками	audio/sentence_annual_leave_e2b92344.mp3
12eab27c-21db-46d4-a6ba-35e964e5fc54	e115e4bd-9dbf-450c-95f2-45a77c6e3717	Flight departs twice weekly	Рейс вылетает дважды в неделю	audio/sentence_flight_departs_e8acd186.mp3
8f4ff5a8-f950-4fb1-8f49-14850abc5c94	50bf0b0c-a440-4b34-b56e-7641be977910	Track monthly budget for travel	Следи за месячным бюджетом	audio/sentence_track_monthly_e010b904.mp3
4857c245-d949-40e7-be32-1613dd9e9c26	ae1ab1fe-5181-42cd-8858-a77169bdc60a	Enter date correctly in DD/MM format	Правильно вводи дату в формате ДД/ММ	audio/sentence_enter_date_40b30867.mp3
423794ee-aad2-4d2a-8964-4c51332c937b	21e25937-89a9-418c-a284-f42b816124ad	Daily schedule includes airport runs	В ежедневном расписании поездки в аэропорт	audio/sentence_daily_schedule_70a95864.mp3
fc37a885-14ac-4fef-8a53-2b55f9f6e0f0	16c40242-33bf-4c3d-b1d6-62add1c71141	Date of travel cannot be changed	Дата поездки не может быть изменена	audio/sentence_date_of_1cf9b978.mp3
52ea12e7-9582-4d76-9664-c1bdab44e8bf	5517678b-51e9-4bca-ab25-2916c2221f48	Arrival time slot is allocated to you	Слот времени прибытия выделен вам	audio/sentence_arrival_time_935aca45.mp3
8d354d05-d3d3-4035-a2a0-c80c459e921e	da774073-401c-4cfd-af2e-66af851ca55e	Flight duration is 8 hours	Продолжительность полета - 8 часов	audio/sentence_flight_duration_e16a42a3.mp3
1d2be45a-3e8b-40b8-9ba9-7622f89017aa	40769d5c-156f-45fd-8337-16bd4aa45c71	Departure date flexibility saves money	Гибкость даты вылета экономит деньги	audio/sentence_departure_date_064b6926.mp3
c2b34010-af61-4c5a-954b-cd938587eb26	eedca128-c384-4fa9-8141-9ceac7ce92bf	Enter all travel dates	Введи все даты поездки	audio/sentence_enter_all_0135f5a2.mp3
03def480-72f8-4e28-8965-8eea9a15cc23	4e3c9a57-e375-44d1-ae62-7a647b3963c1	Seasonal discounts apply in autumn	Сезонные скидки осенью	audio/sentence_seasonal_discounts_996df7a2.mp3
d31fa3b3-f4ff-47b1-8661-d8ed794d34be	e585dba7-057f-4365-b24e-6aada80199de	Next available date slot is November	Следующий доступный слот - ноябрь	audio/sentence_next_available_c925ca54.mp3
1b61722f-bdb0-4150-b88b-f836e07713cd	cf7b9286-1284-4037-a160-d05662289dda	Daily flight schedule shows all departures	Ежедневное расписание показывает все вылеты	audio/sentence_daily_flight_6ceb426b.mp3
39e5c4fa-1f0c-4871-b0e2-a705c56da383	ab7bcc5e-7f1e-4e37-b9b1-fc4b437f5a8d	Biannual review of expenses	Полугодовой обзор расходов	audio/sentence_biannual_review_04656c08.mp3
cbed4755-c7ca-49ba-954c-7d10b74ba18b	4ed7627c-6096-4f8e-85de-ef9ab0d69476	Date of entry on the visa	Дата въезда в визе	audio/sentence_date_of_fe330b69.mp3
cac17fb3-df82-478d-9bc4-e090922f108d	6e19deb9-3704-4b9b-9eb3-b4fab1421db1	Quarterly planning session set for July	Квартальный сеанс планирования на июль	audio/sentence_quarterly_planning_ded11ced.mp3
55fc39a7-4e40-4e8f-8116-5665e7714504	294b80e0-d3a6-40c9-94cc-9c37099f1f25	Monthly target for sales reached	Ежемесячная цель продаж достигнута	audio/sentence_monthly_target_5e302c6e.mp3
51b1d80b-6ecd-449e-a0eb-b425b69e54a1	584c4df6-b755-4d76-a05c-973bd258212c	Departure gate is B42	Выход искажуетуйтеля B42	audio/sentence_departure_gate_240cf626.mp3
41a73e6e-057e-45d5-8093-c2a24e9d9e5b	2a7047c5-0c23-4599-959e-e5a25ccc9e30	Arrival lounge is spacious	Зал прибытия просторный	audio/sentence_arrival_lounge_cba27f9e.mp3
b8190663-3797-476f-907a-626877c955e1	7dd86495-7cff-4bfe-8b5d-9a1f99bb548a	Month of travel affects prices	Месяц поездки влияет на цены	audio/sentence_month_of_6f5b544c.mp3
ed69a261-8ac7-4eaa-aa75-c594372c87e2	691b8d14-0d24-4bcd-81f0-0cf524a0754d	Yearly event brings tourists	Годовое событие привлекает туристов	audio/sentence_yearly_event_c2346218.mp3
92859534-edce-479a-9431-4d922a230114	252cbd95-ff72-4515-904b-9a3da77223a2	Daylight hours vary seasonally	Продолжительность светового дня меняется по сезонам	audio/sentence_daylight_hours_3cf9012c.mp3
6149ea72-0918-4df2-84a8-1c1cd6db8f1f	ca7fe833-ec4e-4b78-aa65-4eb4bbc7c946	Date stamped ticket is valid	Отштампованный билет действителен	audio/sentence_date_stamped_195e40f1.mp3
6c841374-76fc-4b2c-9582-6e0d01403495	78604fba-2637-444b-b78e-dc9b8520cda2	Check flight calendar for cheap deals	Проверь авиакалендарь на скидки	audio/sentence_check_flight_4a891413.mp3
b04cdf73-7b57-4eab-b719-ae0e10a375a0	7237bc94-e005-4f63-999f-e6481492f100	Peak season costs more money	Пик сезона стоит дороже	audio/sentence_peak_season_b0d35d81.mp3
e23eb9e3-9f43-44d4-b426-6845e63f65f2	6ff39802-f91f-4574-b6fa-9caa053f5905	Off-peak travel offers savings	Путешествие вне пика - сбережения	audio/sentence_off-peak_travel_5f84ab1e.mp3
937c5d00-2db4-41bc-84a9-86b9e7f7d27b	b8081b04-77e7-4fc9-96ee-264a3802410b	Annual limit for foreign travel exceeded	Годовой лимит заграничных поездок превышен	audio/sentence_annual_limit_59f68bac.mp3
d2d7d036-7954-4227-9e9f-0a805ccf0e21	3f907b26-893b-4d06-a7db-bc1b834b41fa	Quarterly performance exceeded targets	Квартальная производительность превысила цели	audio/sentence_quarterly_performance_fc068d0f.mp3
c479b0f5-031b-467d-ae20-5608318da25c	0533eb10-5b18-4ec5-b0f0-ce443091d45b	Weekly summary shows travel expenses	Еженедельный отчет показывает расходы на поездки	audio/sentence_weekly_summary_cbb9322c.mp3
a768bb6b-2b4f-41aa-ba20-12b1a23a6443	b504ee07-d8d8-4df9-908a-e8a592df0797	Next available month is March	Следующий доступный месяц - март	audio/sentence_next_available_d1b83b84.mp3
74545ff7-08ce-4722-b9c5-893307586a78	2a4919f2-f2d3-4872-85be-368e5a4b20fc	Daily flights connect major cities	Ежедневные рейсы связывают крупные города	audio/sentence_daily_flights_b74e0157.mp3
51fb4be4-71da-4ff8-a2d5-493fc4d6aecc	e7839b09-cbdb-4c4e-9268-f9d810773a3f	Travel month information is online	Информация о месяце поездки в сети	audio/sentence_travel_month_335a7813.mp3
481fb1e4-dc59-4458-b4f3-bbe810daf281	e6683995-7c8a-4b63-9da2-dec0c8f395ce	Yearly meeting is in November	Годовое собрание в ноябре	audio/sentence_yearly_meeting_5bd86b02.mp3
23d20dfd-ab8d-4c5c-a1c1-fadc6727adfe	01da6c5c-1206-4b02-9913-a83ea52b1c39	Bimonthly visit to the branch	Раз в два месяца посещение филиала	audio/sentence_bimonthly_visit_fff7ea10.mp3
90d295fd-ce04-43fb-8d90-7ddc8a8f4e87	1473e3ee-bedc-4563-86fd-ca1c4982f674	Date of issue shown on ticket	Дата выдачи на билете	audio/sentence_date_of_4a98ec9d.mp3
aaa1f065-5897-4c1e-9567-7c6dc718f657	17532c8d-1eb2-4657-8703-6ba9996461be	Monthly targets met consistently	Ежемесячные цели последовательно достигнуты	audio/sentence_monthly_targets_a58e1d54.mp3
4437b34f-83ed-46de-bb04-d269436dc475	6654861c-3ab5-4b4f-b65d-97306474c4f2	Overnight flight to New York	Ночной рейс в Нью-Йорк	audio/sentence_overnight_flight_ca2a9cbb.mp3
09d827d9-d73e-4403-a416-e061a4d43629	846d1cfc-3156-4919-b7c6-03bc65a30814	Date validation check passed	Проверка валидности даты пройдена	audio/sentence_date_validation_5ba549a4.mp3
2d13c964-23d5-4057-ac3b-4bb6595c021d	2185d265-2503-432e-96a6-c2cf63ee478e	Flight path variation saves fuel	Изменение маршрута экономит топливо	audio/sentence_flight_path_0e5ddc5e.mp3
6875f48f-646b-483e-a9bb-1c4302c1975d	ea10f2c9-ebf9-4c6b-ae99-a6b1d8ddee86	Booking date stamp confirms reservation	Штамп даты бронирования подтверждает бронирование	audio/sentence_booking_date_6764c099.mp3
49c22e25-1f5a-437e-b737-779be0a061bf	938cd40a-1442-475c-b1d2-caa9866fd590	Trip duration planner estimates costs	Планировщик длительности оценивает расходы	audio/sentence_trip_duration_79d3981c.mp3
f750d9c0-bb28-46b9-88ad-58719127726b	ee11fbe9-eb56-471c-8ef7-2a5f77bdc4c8	Quarterly financial report released	Квартальный финансовый отчет опубликован	audio/sentence_quarterly_financial_152e2eb9.mp3
230afb20-2ada-4af3-b7ed-ca6f15c2d5b5	50fd9821-e167-4c77-bbe9-8ef80457b4b7	Last minute travel deals available	Есть выгодные предложения по срочным поездкам	audio/sentence_last_minute_df971863.mp3
596ef4e8-dd1c-492b-9e57-1611fc2df54f	9dce7fc8-83d2-4705-8c14-1ed33cb20f53	Twice yearly event held in city center	Событие дважды в год проходит в центре города	audio/sentence_twice_yearly_fa0ce533.mp3
bed59935-140c-4dab-90cf-45ec69e0781e	9b8474a9-0a29-470e-91bf-45246b1afeb5	Date of passport issue must be entered	Нужно ввести дату выдачи паспорта	audio/sentence_date_of_e3694805.mp3
faea6b82-e08c-4c6f-a0cd-960f4b911e52	237b3fba-a4a3-4133-be5c-faa666fb5329	Seasonal trends affect ticket prices	Сезонные тенденции влияют на цены на билеты	audio/sentence_seasonal_trends_c1375606.mp3
c1b02b7a-5c17-44f7-9719-901ef2386f98	393dc8d2-ce21-496c-93b8-8d211f4fb473	Weekly hotel rates lower than daily	Ежедельные отельные ставки ниже дневных	audio/sentence_weekly_hotel_92646460.mp3
16ab4d4b-d618-45b6-9795-42b6a4dcb8e2	30f109b1-d260-4a4c-92c4-749569c04693	Monthly subscription includes discounts	Ежемесячная подписка включает скидки	audio/sentence_monthly_subscription_5a3e1161.mp3
60c6adf3-0c01-42dc-9824-ce4b2688b380	cfbe4534-e6a5-483e-b724-e6eea4b19770	Annual membership fee waived first year	Годовой взнос за членство отменен в первый год	audio/sentence_annual_membership_8b842be3.mp3
27510d31-8b42-4791-96b9-0a1d21fa183e	439984a9-34f3-4c89-8215-78362670c578	Seasonal menu features local dishes	Сезонное меню предлагает местные блюда	audio/sentence_seasonal_menu_b2fbf407.mp3
55d90fde-4583-4aa6-922c-a8d3a31d9766	333a438b-6597-4b8c-8db9-51a12d94f59b	Departure lounge notification announced	Объявлено уведомление в зале вылета	audio/sentence_departure_lounge_c4dc13ff.mp3
ee814119-a650-4c8d-ad1b-2c9bf773ad34	4dcf09ee-1666-4408-85d3-391b8ff4db9c	Arrival time flexibility offered airline	Авиакомпания предлагает гибкость времени прибытия	audio/sentence_arrival_time_d77a5d60.mp3
425dfbbe-c32e-41f1-ae74-f8d162ddc1f1	d6d6f0bd-470d-4eef-b7be-185fcfe1b666	Daily flight numbers listed online	Номера рейсов в день показаны в сети	audio/sentence_daily_flight_501f4c98.mp3
fee15f46-259d-4496-9ba3-7ece77359bfd	c466f906-24a3-4294-ad34-d30168d9d2b0	Next day delivery for urgent tickets	Доставка на следующий день для срочных билетов	audio/sentence_next_day_6df9e033.mp3
f857da89-cc92-4c17-ab6b-f21e94e9c3e3	55e6d78f-8a4c-4dee-9fbc-4a7602c54eaa	Flight frequency monitoring required	Требуется мониторинг частоты рейсов	audio/sentence_flight_frequency_912e7262.mp3
83d0287f-f3af-4164-867b-0307b6506998	ce01abea-e27d-47e3-8231-58f8bbf39898	Travel date flexibility saves costs	Гибкость даты поездки экономит затраты	audio/sentence_travel_date_14f5e052.mp3
c030717e-41d2-4903-85af-5c1971fd418a	e499a04b-432c-4787-813b-f5b0f8000d61	Flight path reduces flight duration	Оптимизация маршрута сокращает длительность полета	audio/sentence_flight_path_7ef3a8d3.mp3
fff3f917-4c77-45a7-8421-e78bfbd93ec8	27e41eef-f3b9-4c5f-9354-84f95e78ed79	Arrival hall signage is multilingual	Указатели в зале прибытия на нескольких языках	audio/sentence_arrival_hall_0edda141.mp3
50c5119c-cc6c-4a4a-a89b-8622427041af	129884ec-758a-4872-9de7-ec9dc0ba2dd4	Monthly expense tracker app	Приложение для трекера расходов	audio/sentence_monthly_expense_4554a7ea.mp3
80e6ef9f-f5f6-430c-afc1-ca9006cc6ea0	c06f6c8a-e038-4aba-b226-a5f80044c888	Semester break travel schedules	Расписание поездок на каникулы	audio/sentence_semester_break_84a120e5.mp3
a1b16e6b-95f9-4655-8915-ec2199735f31	6c883a34-4d01-412a-ae55-d73ff7ab7d44	Year end sales include travel deals	Годовые распродажи включают путешествия	audio/sentence_year_end_366e1041.mp3
93473493-4316-4f32-87f7-a450dd430c49	52ea5edc-4519-49a4-99b0-65f812bd4348	Annual budget meeting scheduled	Назначена встреча о бюджете	audio/sentence_annual_budget_03fe6097.mp3
d7daf874-ad73-4182-9e73-d20bb119e44f	a554f1c2-6347-4955-9c01-a9204e3d8ae3	Date format specification must be followed	Должен соблюдаться спецификация формата даты	audio/sentence_date_format_645907f9.mp3
81ca2d48-4f01-4387-82b2-178299f6efdd	38445ace-4ab4-4a61-a3b9-9dce47748b83	Flight time table lookup system	Система поиска в расписании рейсов	audio/sentence_flight_time_3097d2b2.mp3
c1273e5e-5fbc-4456-86c0-87430e00a0e6	b079133d-5419-43e7-87b9-970aa32a49cd	Arrival concierge service available	Доступна служба встречи при прибытии	audio/sentence_arrival_concierge_c94831ac.mp3
859c3c68-9f6f-4c2a-93b9-1c1429e2b7c6	524fc363-c7e1-454b-a69f-4952ca50667d	Next day itinerary arranged	Распорядок на следующий день организован	audio/sentence_next_day_a03444a6.mp3
afabc99d-fe29-46cc-a0aa-aa8f198e5da3	a91c4232-4126-44c7-b898-6132fe484887	Flight path tracking shows delays	Трекинг маршрута показывает задержки	audio/sentence_flight_path_cb92f194.mp3
ec73c8a0-b5c9-4605-aada-6c69541f6f17	69dfa273-234d-41c1-8360-9b7e160f4d37	Bimonthly subscription for magazines	Подписка на журналы раз в два месяца	audio/sentence_bimonthly_subscription_8945dd4a.mp3
cfa77fd5-f5d5-4fc9-b240-2fd9548a8850	ab582b0a-489c-4b15-8906-30c5fd464232	Monthly performance review conducted	Проведено ежемесячное обзорное собрание	audio/sentence_monthly_performance_ca7fd9c0.mp3
ff9c1e15-6651-43c7-a908-8312ec9f3318	d23d41fc-f398-4db9-906e-19c0d1f6a874	Date stamping machine at check-in	Машина для штамповки даты на регистрации	audio/sentence_date_stamping_1f5d3885.mp3
958022be-8ada-40db-a9a1-e54524e72a3e	b4e98a2e-ee2c-453c-81fa-c9439c55bbee	Seasonal promotions on hotel rooms	Сезонные акции на номера в гостиницах	audio/sentence_seasonal_promotions_100cee7c.mp3
d7e3f85a-7a84-4e3b-a43b-a7e9cd4cce2f	0fb6f836-3e9b-42f3-86c5-1e1c467fda39	Arrival terminal guide available	Доступен гид по терминалу прибытия	audio/sentence_arrival_terminal_ea1fb5e6.mp3
d009b3da-f3d6-47d3-b639-98dc2d9f1095	83ca98fe-0fb5-46a2-915a-fbdec2b9b688	Flight schedule frequency explained	Объяснена частота расписания рейсов	audio/sentence_flight_schedule_79bb5412.mp3
fe7a879a-b4ab-4df8-8378-aea723c5336f	56dfd2d3-2000-4758-8a9b-1baa0b52a9e2	Daily departure schedule displayed	Отображено расписание вылетов в день	audio/sentence_daily_departure_8a36dba7.mp3
89200770-f352-4765-9b22-9646438012c5	13dd972e-e1bb-41a2-b36d-d1015e6e2a78	Quarterly business result impressive	Впечатлительный квартальный результат работы	audio/sentence_quarterly_business_7229ad8c.mp3
752a3bd1-1711-4d76-9d7a-f58064a0640d	50d474b7-8793-4620-b862-cf1a0208c879	Trip duration extension possible	Продление длительности поездки возможно	audio/sentence_trip_duration_41ffce59.mp3
828bff17-8612-4ea5-b696-0986a14ee553	506c0a58-3362-4cb1-b215-3c461b2a7fa7	Date of entry visa requirements	Требования к дате въезда в визе	audio/sentence_date_of_d0dde42c.mp3
8ca2bf92-c596-4dbb-8244-66cea9a382aa	71236aae-6209-4844-9fff-cce7a6dda28e	Seasonal temperature variation affects travel	Сезонное колебание температур влияет на поездки	audio/sentence_seasonal_temperature_bb2e2b76.mp3
56d237c8-fe4d-4585-9dc3-772442e7e38d	d4ec950e-ea19-4609-aed6-c286f6b1b052	Weekly chit chat meeting scheduled	Назначена встреча еженедельная болтовня	audio/sentence_weekly_chit_19743d03.mp3
7dd9ce3c-ec67-4228-b2f7-f062ad4992d5	1131e4f2-55df-4a51-9db0-f406f2ced731	Arrival baggage claim display shows baggage	Табло показывает багаж прилетевший	audio/sentence_arrival_baggage_8e6d7bec.mp3
a48d24bb-86e6-49e0-a345-9361786e0d43	1ba70301-d23e-43be-a2a7-464a657a0530	Monthly financial statement prepared	Подготовлен ежемесячный финансовый отчет	audio/sentence_monthly_financial_1bc46fa4.mp3
69d5bea7-f27b-46b9-a809-fbaf0c030b8c	0f581ec7-af8d-4627-8e0d-1a4bf618a195	Bimonthly training session conducted	Проведен двухнедельный учебный сеанс	audio/sentence_bimonthly_training_2ab11949.mp3
68525994-2a0c-4bca-8f9f-57faca65d931	7fc1a8d5-5f77-486c-ada2-d1009a9d99b0	Date stamp validation required	Требуется проверка штампа даты	audio/sentence_date_stamp_7c84628a.mp3
ed178438-ec4a-4dab-ba2f-c47596e9bf8e	d04b28a1-da1d-4375-8323-786f3b72f1f3	Flight path accuracy check performed	Выполнена проверка точности маршрута полета	audio/sentence_flight_path_f6108f91.mp3
bc2a02d9-d0f0-4069-887c-40653fca35b5	c3cd50e8-7cf4-455c-b887-1d761d492eb9	Arrival door service counter helpful	Полезен сервисная стойка у дверей прибытия	audio/sentence_arrival_door_7289f0a5.mp3
45e18be7-8862-45b0-89aa-08bc117a57cb	f12918dd-3ef8-42db-84d5-31e1f9c31286	Next available boarding gate announced	Объявлен следующий доступный выход на посадку	audio/sentence_next_available_40cae8f6.mp3
ff5e096a-1da2-41d5-b339-b5e31fcdc5ea	72d5093e-6b3b-42fa-a21e-6d957fec7b8f	Flight schedule planner recommended	Рекомендован планировщик расписания рейсов	audio/sentence_flight_schedule_6c774d13.mp3
64d2b0f8-9283-4bae-a389-f2c9f1d5f4ae	0e1d7ed0-3331-4a35-8175-7cb837c8ec16	Arrival instruction booklet provided	Предоставлена инструкция при прибытии	audio/sentence_arrival_instruction_3cacac0f.mp3
cb836584-5f0b-45fd-9a93-7036b98ac3df	d6e41f33-b5cb-46f7-a6e6-500ff4bb878a	Date passport issued verified	Дата выдачи паспорта проверена	audio/sentence_date_passport_dfd8084a.mp3
ac29c22d-2d22-40e9-baac-11c6364a3789	ef4accc6-2bc4-4dd8-bc1e-b73845d53d9e	Seasonal travel tip shared in blog	Сезонный совет по путешествиям поделился в блоге	audio/sentence_seasonal_travel_29585e44.mp3
e69b701f-7b46-49a1-bdab-e2eea2bfe5b5	06e9c2c6-f8df-417c-9674-aece8e2ffb04	Weekly team meeting rescheduled	Еженедельная встреча команды перенесена	audio/sentence_weekly_team_3fe94d36.mp3
b84cb09f-935d-4c1c-8f67-cb01ded07c00	cdc969c5-a5c6-4f3a-a50f-9ca6e5389eb7	Flight path weather impact assessed	Оценено влияние погоды на маршрут полета	audio/sentence_flight_path_ef8c7fb8.mp3
23f11ef5-4f4b-46d7-ad7c-c9ce805f9e9d	91ef53d1-f2cb-4b39-87d3-a25f2f40f967	Arrival assistance service available	Доступна служба помощи при прибытии	audio/sentence_arrival_assistance_a2fb3088.mp3
37a49b29-eaee-490e-90c0-3cbcc1b5d453	52a082d6-6f9e-4988-b176-86b8faf300bc	Trip duration calculator reliable	Калькулятор длительности поездки надежен	audio/sentence_trip_duration_1dfc1d38.mp3
736ff148-2a46-4a83-b78e-c2ff3dfa67f9	1f37bebe-b0ff-43f7-b41e-d4ebc7c2672a	Quarterly bonus payment processed	Квартальная выплата бонуса обработана	audio/sentence_quarterly_bonus_c9f00b26.mp3
c05857a8-f24e-4e1b-9120-c0f7f0a285ca	c1ad23e5-4cb6-40ea-adae-ff8953d0ad71	Bimonthly performance review scheduled	Назначен двухнедельный пересмотр производительности	audio/sentence_bimonthly_performance_1003de5b.mp3
ed06cceb-cbb9-4d1d-9fc1-6c5e125ca8a4	6fd84537-3a1b-4964-9043-aad37a5b0037	Flight path reroute protocol activated	Активирован протокол перенаправления маршрута полета	audio/sentence_flight_path_65cd787f.mp3
7319465b-caa8-4484-a6b0-b150ba2ee654	1fd96fcb-4bdc-46bd-9166-136275ffc05e	Travel date flexibility fee waived	Плата за гибкость даты поездки отменена	audio/sentence_travel_date_b3efffed.mp3
f4ba630c-d2b5-4d56-a81e-0e6e6521b83b	98223e5f-b9c4-4fce-bfc4-d40b8b0f65e0	Seasonal cargo schedule adjusted	Сезонное расписание грузов скорректировано	audio/sentence_seasonal_cargo_630f411d.mp3
acb2c60f-e187-452c-b22b-8c0ecca2e48b	c4ab6d7f-611c-4fbd-a9d3-25e20821c534	Weekly backup system check completed	Завершена еженедельная проверка резервной системы	audio/sentence_weekly_backup_81a17a2b.mp3
5fea9145-4e74-4749-8911-bd1e9bcc59d4	1c38ca8e-ff01-4520-91a6-5baf43cc697c	Bimonthly security drill conducted	Проведена двухнедельная проверка безопасности	audio/sentence_bimonthly_security_c8a8a075.mp3
41cad085-ac8a-427f-a6b0-330e85eb5a07	0070227d-91dc-4218-92db-5a9be67be56f	Flight path optimization cost calculated	Рассчитана стоимость оптимизации маршрута полета	audio/sentence_flight_path_6f8d1468.mp3
fc9f10f4-0431-4cd7-b3e1-b3f89e518fcb	46afd5a0-ca2f-4ee6-81b9-cf52875be263	Date format conversion tool helpful	Инструмент преобразования формата даты полезен	audio/sentence_date_format_26583c27.mp3
a9cb5f12-c97a-4804-97c0-c54733c0817e	80578cbf-9f1d-41f2-b937-3ec245f54360	Seasonal staffing plan implemented	Реализован сезонный план персонала	audio/sentence_seasonal_staffing_27e74f73.mp3
dfe51001-5c83-4561-8a3b-a7a3cb585eca	5691a7c0-e914-4cb4-a996-ae9f8e5ca059	Arrival procedure manual updated	Инструкция при прибытия обновлена	audio/sentence_arrival_procedure_2b4a0416.mp3
0c8e8105-8e57-42bc-949b-56ef2b748f78	a3b99f07-740c-4fcb-a15d-6e98d7e5989e	Date passport validation rule enforced	Правило проверки паспорта даты применяется	audio/sentence_date_passport_ff5e2251.mp3
1498135b-3e16-484b-8cf9-3dcb8a2cabf0	10c90346-a799-4d00-b894-ecec2ff40bd0	Flight schedule disruption log maintained	Ведется журнал сбоев расписания рейсов	audio/sentence_flight_schedule_09c2b10c.mp3
7b0e4b12-d806-4a87-8c4a-0bf49f373f0d	2da842e0-379e-413d-b304-8858aa5023e8	We have a bank holiday next Monday	У нас будет банковский выходной в понедельник	audio/sentence_we_have_593b47ef.mp3
20c4a8ae-c691-4a39-b4f1-c557e2e6c81f	0e9b80a6-b9f9-44ce-8e3f-142a1801d76d	We celebrate New Year's Day on January 1st	Мы отмечаем Новый год 1 января	audio/sentence_we_celebrate_5daf4449.mp3
ffa3a044-7b69-48c7-9e79-0a160f1d97ec	cda62ed4-14f5-43a8-9e92-d59da4b4914b	Christmas is my favorite holiday	Рождество – мой любимый праздник	audio/sentence_christmas_is_2da7b7ce.mp3
2a4ebacb-b5fa-4fe5-aec6-91c8167793d7	932aa391-cdfb-44d5-bf2f-e783d5c4f3ab	Easter is a Christian holiday	Пасха – христианский праздник	audio/sentence_easter_is_efc9770f.mp3
9680dbcb-6c20-4753-96b3-4a169bee8b18	d307f78a-f809-4627-8450-ee1a0ee9ea8b	Americans celebrate Independence Day on July 4th	Американцы отмечают День независимости 4 июля	audio/sentence_americans_celebrate_afedfbe4.mp3
b4bd6bb9-843b-4f3e-ae78-c8326e8d3f00	6c60b1c8-f5f4-428a-a0ea-94ff341f5caf	We eat turkey on Thanksgiving	Мы едим индейку на День благодарения	audio/sentence_we_eat_934626b0.mp3
2f30d2f8-ddf2-4c9c-a504-489f420cc561	36ed2862-45d0-4634-90e0-4c0163b8db30	Children dress up for Halloween	Дети наряжаются на Хэллоуин	audio/sentence_children_dress_48537fa9.mp3
5b6bebae-81df-4ca6-8adb-986a0c3266a8	44787df6-1455-4a5b-9385-84300ca3eef4	Do you have a Valentine's Day date?	У тебя есть планы на День святого Валентина?	audio/sentence_do_you_8c8b4e75.mp3
9341eab0-d413-4c29-8bfa-ed14e813f5ff	fb5bca5b-96d6-46a2-a357-d5ffc4bcee64	When do you take a holiday this year?	Когда ты берешь отпуск в этом году?	audio/sentence_when_do_4bc00ece.mp3
f5c0351b-7c95-419c-beb6-e82ab3440dd9	a33635be-035f-4f5b-a248-8520c6723c53	We decorate the Christmas tree	Мы украшаем ёлку	audio/sentence_we_decorate_84570704.mp3
22299c64-a015-487a-9ce1-1687190e04b3	7d850b20-a6ce-4fea-8a7f-21cdfaa693fd	What gift should I buy?	Какой подарок мне купить?	audio/sentence_what_gift_7e58a702.mp3
3a113f49-2bc8-4352-b4c3-44bdcbd3a648	a6e21b6d-0630-439b-a3f8-206c243f36aa	Can you help me wrap this gift?	Можешь помочь мне упаковать этот подарок?	audio/sentence_can_you_f80a0ef6.mp3
295171e2-87fa-45d8-9f00-44ffa7d82a25	dfc74480-c580-4568-be1a-006261f5e580	We exchange gifts on Christmas Eve	Мы обмениваемся подарками в Сочельник	audio/sentence_we_exchange_90db52e6.mp3
5eac2a89-ed70-4a9d-9415-bba6053a2d0a	57df5acb-ed32-40b1-8224-b96dbfeee6f6	We have a family gathering at Christmas	У нас есть семейное собрание на Рождество	audio/sentence_we_have_1623762b.mp3
583a5e85-8e22-48e6-835c-b3bf77d6a2bc	8765789f-149a-4a8f-9184-c7cc6030813b	They light fireworks on New Year's Eve	Они зажигают фейерверки в Новый год	audio/sentence_they_light_f1e0a19b.mp3
6d26706a-1364-4766-9cc8-4f0b230c6c18	88dd62c7-2f04-483c-9ed8-e8a6a58fc59e	People dress up for the festival	Люди наряжаются на фестиваль	audio/sentence_people_dress_3917e972.mp3
226194c0-3b1d-4cd9-b265-dfed35d4c453	1df04357-71ca-4d04-bd2a-1bd60bc076b7	We have a long weekend for Easter	У нас длинные выходные на Пасху	audio/sentence_we_have_cf8eaef5.mp3
7c1c2569-370a-4f0b-a63f-fe5d6b700e05	58cc18ed-e2b3-4684-8a70-2ac8eb67b88a	What are your holiday travel plans?	Каковы ваши планы на отпуск	audio/sentence_what_are_8c71e553.mp3
28a989bf-fd8e-4e5b-a5ac-2f3c11188d0f	1110c2c8-33c7-40f0-ba73-c97d446b63b4	The festive season is very busy	Праздничный сезон очень загруженный	audio/sentence_the_festive_d36c09b9.mp3
67123892-31d8-4200-b22c-1ef5c6b92680	e72579bd-d282-4b53-b4f6-a15b9466f260	Let's start the New Year countdown	Давайте начнём обратный отсчёт до Нового года	audio/sentence_let's_start_b9fb237a.mp3
714c542a-41df-4de6-8d87-c8afb7686326	5ea0572f-057f-42c5-92d2-7454f9d81248	We went on holiday abroad last summer	Мы ездили в отпуск за границу в прошлом году	audio/sentence_we_went_fa0d4bb2.mp3
b106b3db-f483-4fc7-babf-7cd4c31f1f7d	3971a9ca-3611-46c2-ac99-65a94d4884d6	Can you help me find my gate?	Вы можете помочь мне найти свой выход?	audio/sentence_can_you_52290ef1.mp3
0f91aac0-8833-41ea-a24f-45b020a8f421	eee4483a-70d9-4ed5-9127-23418c30d92e	Where is the check-in desk?	Где стойка регистрации?	audio/sentence_where_is_1b249946.mp3
939c0b59-27ba-4e31-9045-260643138082	5fb868d8-1762-4499-932b-e1e3d91c476a	I need assistance with my luggage	Мне нужна помощь с моей багажом	audio/sentence_i_need_c74236ad.mp3
b40ef444-54b5-4b34-8be3-ae300b741cb9	96a3b779-92fd-4466-a0fc-58ac6f91d91a	Could you please tell me where the restroom is?	Не могли бы вы сказать, где находится туалет?	audio/sentence_could_you_8d16af4b.mp3
ea089a3c-036a-4bb7-b2ab-adbbde0a709d	3d633c6e-51be-4b44-9497-6b3887709744	Excuse me, is this the queue for departure?	Извините, это очередь на вылет?	audio/sentence_excuse_me,_162022fe.mp3
3167a34b-2993-4400-872b-c10f829f6c62	f9a6e4e3-8d95-4013-ae8b-08325628c30e	I'm lost, can you help me?	Я потерялся, можете помочь?	audio/sentence_i'm_lost,_5e875dfd.mp3
8598cffa-9846-489f-bdb5-208b1ab23b0c	5eee0c1b-5554-41cb-9415-3ef0eafe0339	How do I get to the duty-free shop?	Как мне добраться до магазина беспошлинной торговли?	audio/sentence_how_do_67272f34.mp3
a8eecfa3-d3e9-46d4-8bb3-61474ccac4ab	39e781de-6571-4947-b2a6-78e269b9fbe4	I can't find my boarding pass	Я не могу найти свой посадочный талон	audio/sentence_i_can't_8da8c713.mp3
432747e2-3f6a-4459-a523-07198724f810	fca92577-1b71-44ce-9ae4-be0e14aa4647	Could you repeat the gate number?	Можете повторить номер выхода?	audio/sentence_could_you_ed39064c.mp3
922a6693-c56b-4e0e-99a2-c46dc991eb02	f023ce23-4e44-4d92-91ff-da6d51c97268	What time does the flight leave?	Во сколько вылетает рейс?	audio/sentence_what_time_bf820da4.mp3
278bcfa1-c4a2-4992-be67-9215dd0c7619	19134dc6-f56f-41e7-b49e-ca88b61f15af	Where is gate number 34?	Где выход №34?	audio/sentence_where_is_3fb61f12.mp3
aac0c2fc-6fec-4a9f-880e-031a9ce433b4	d4cf500d-7682-4a9b-9e37-1c31cdfee5ac	I have a problem with my ticket	У меня проблема с билетом	audio/sentence_i_have_849711c2.mp3
f3357a8d-3053-42f5-b55c-056574b4de94	066c54ef-12db-4368-ab27-fc614c1ae9b2	Could you speak slowly, please?	Говорите медленнее, пожалуйста?	audio/sentence_could_you_4e9af741.mp3
94508c92-9b15-46aa-95ef-11eb92fc7e16	d9473a8c-934c-40ea-b86e-0e38978e7878	I need a wheelchair for the flight	Мне нужна инвалидная коляска на рейс	audio/sentence_i_need_5d9c99fb.mp3
61dc96c8-4493-4de1-b4c2-eea1041f815b	19ccd16f-6a48-4568-b0a3-d8368d2ae257	Where is security check?	Где контрольно-пропускной пункт?	audio/sentence_where_is_906c6dce.mp3
4b25c82f-ef9a-4e9a-a7aa-a31ae51606a8	5e265c48-597c-4b65-9e3c-2a46a9b2cd50	Boarding has started for flight BA455	Посадка на рейс BA455 началась	audio/sentence_boarding_has_024c3839.mp3
4a7b62d4-015f-455e-bae5-ec2a9e09497a	4cbbeac3-6936-412f-b30d-79d034b9878b	Please go to check-in	Пожалуйста, пройдите на регистрацию	audio/sentence_please_go_696c9085.mp3
328061e3-2e99-4e60-90c6-29b5230e02a7	cdd6eae9-e641-4ef0-a642-5e206b0aeaf8	Show your boarding pass	Покажите свой посадочный талон	audio/sentence_show_your_3feca8e2.mp3
42d6b6c7-5adc-41d9-8e12-347e9f3d1aea	c8d3cd45-21ff-4507-82a5-abe32762a3fe	My flight is at gate B12	Мой рейс у выхода B12	audio/sentence_my_flight_81f7f51f.mp3
b9d6b6fd-9296-4dd7-afc9-243a1a1a2934	013eca79-2b8c-4343-abc4-c4353f1401c1	What's the arrival time?	Какое время прибытия?	audio/sentence_what's_the_c37f812c.mp3
42f13a36-e23b-47c6-84b1-48afca9c76c5	0e582197-df81-40ff-92b0-8d7c765bc8b6	My luggage is missing	Мой багаж потерян	audio/sentence_my_luggage_e36afa0c.mp3
360f8280-79a9-471b-aaea-f1d4a8ac76e1	5264bc9e-4f99-4ddd-80e5-c8118c7f4d40	Where is my suitcase?	Где мой чемодан?	audio/sentence_where_is_a3699ef6.mp3
8ca28b5b-7451-4ae3-a631-292962b2a51d	8b1180d1-739d-4d49-8d02-57981a7b5275	Baggage claim is on the left	Зал выдачи багажа слева	audio/sentence_baggage_claim_1fd0c37d.mp3
26b76faf-e6ef-4bfc-bf65-4a4473f6d099	4f00a568-9c68-4223-8fae-f03683402014	Flight delayed due to weather	Рейс задержан из-за погоды	audio/sentence_flight_delayed_17979022.mp3
8f4ab606-d0e5-4d39-ab6a-e5e10bac5ac2	52de9218-720b-4088-b0a9-4d2df7229cd7	The flight was cancelled	Рейс был отменен	audio/sentence_the_flight_fac78983.mp3
72a1c48f-90b3-41d1-8609-8e6d74410257	009bd45c-ba72-4df5-aa72-d7e148ca8347	Which terminal for BA267?	Из какого терминала BA267?	audio/sentence_which_terminal_b7761c6a.mp3
009e6583-5bf3-47b4-8f39-ce668180478d	56354bb8-d29b-4471-83b7-d8f45042ffbf	Final boarding call	Последнее объявление о посадке	audio/sentence_final_boarding_ab580913.mp3
a51e8953-d37e-46e8-9455-67d1d4b78906	a63bd475-7fd5-4424-bc28-73ba8a905891	I prefer an aisle seat	Я предпочитаю место у прохода	audio/sentence_i_prefer_81090d4f.mp3
a06450bc-a49d-45f9-a1d2-55e43cddb9d0	4b5ba6c9-facd-4da1-a4b8-33dbaa9a98b4	Can I get a window seat?	Могу я место у окна?	audio/sentence_can_i_9271fe3b.mp3
72054366-076a-463d-990a-9c0c1f999e7c	6cb62920-d899-445e-ac0d-55b94f87ecce	Put your bag in the overhead bin	Положите сумку в полку над сиденьем	audio/sentence_put_your_2421910e.mp3
d6bc82df-ed06-4b17-90ae-6e226bd84834	e5d44b43-054f-4fb9-8186-b7a7d230fff1	Flight to New York	Рейс в Нью-Йорк	audio/sentence_flight_to_b8a53d12.mp3
25d19739-bcb8-4c41-90e7-7aa990ecb2f4	01841719-1ab2-4f33-a30e-442f168869f7	When does it arrive?	Когда прилетаем?	audio/sentence_when_does_b47edd78.mp3
3ee09421-f4c3-44b7-9316-889ad78e0d50	7e13be7b-2454-4dc2-af60-7e703846d4f1	Connecting flight in Paris	Пересадочный рейс в Париже	audio/sentence_connecting_flight_9a45f4d7.mp3
159979b5-a459-4106-8250-e2623f9a4577	495f249f-3538-4233-bec0-28b14d5186d1	I don't understand.	Я не понимаю.	audio/sentence_i_don't_2dd030ea.mp3
8ede4fcc-e89c-4710-9e7a-c11b84d79de4	826764b2-1142-4911-83f4-767bceb2aa77	Could you send me the meeting agenda?	Можешь прислать повестку дня?	audio/sentence_could_you_e90713e5.mp3
05cf65b8-c8f5-4e2c-92ac-b761d36184fc	b69c0100-ab8d-4385-8111-c9e99922e95b	Let's check the team schedule	Проверим расписание команды	audio/sentence_let's_check_ee04bab1.mp3
6f6019f9-4d7e-4675-b49e-29dea2578ad2	8ddb6dcc-eee7-4250-8867-94afedc031ef	We need to postpone the meeting	Нам нужно перенести встречу	audio/sentence_we_need_22a8a1ee.mp3
a3a6d99d-ddea-4ed1-9978-71c7018a8f93	36b1709b-2631-4c43-bdfc-216e5e50622a	Let's discuss your proposal	Давайте обсудим ваше предложение	audio/sentence_let's_discuss_e25409ce.mp3
9e47b922-ac7e-46a6-bafd-7e9b041f308e	887840e1-38ac-4d4d-ad96-ab70f4a58417	We need to make a decision	Нам нужно принять решение	audio/sentence_we_need_108bf857.mp3
18facbd8-d7f2-4934-8be8-06261802cb14	b8de193a-16ac-479a-a63e-13e76076523e	Assign action items after the meeting	Назначьте действия после встречи	audio/sentence_assign_action_8aeae49a.mp3
4ef711f1-2db2-4b43-96be-5de5bad210aa	16b0d89b-cb10-45e9-89ef-3f2a5641fd6f	The first point is budget	Первый пункт - бюджет	audio/sentence_the_first_21601832.mp3
72762246-849c-46e1-bdf3-e6be686cdfa3	9a8fa2a8-41d9-44e8-9b75-9f940268d4f6	I have a meeting at 3	У меня встреча в 3	audio/sentence_i_have_15205304.mp3
5c428f71-59ee-461c-bc16-72dc081df978	9644596a-393a-4140-b58e-d54d1aaff90c	Follow up on this email tomorrow	Продолжай по этому письму завтра	audio/sentence_follow_up_d3710b52.mp3
4fec0765-478b-4b28-87d9-ffffaa646cc7	56fdf47b-d0d4-4b7b-826f-e92b23bbee33	This matter is urgent	Это срочное дело	audio/sentence_this_matter_02fbf7b4.mp3
bb5cee42-3fc7-4d34-93f2-51e7b5f3f57f	b11acd1f-2437-41f3-81f8-5dd3ea4559bc	Is this information relevant?	Эта информация актуальна?	audio/sentence_is_this_6429e7b4.mp3
9d8b799d-5fd7-4d3c-aff2-963c85a064ae	d847e152-df39-4d5f-9f2e-373e525aa31b	Show preparedness for the meeting	Покажи готовность к встрече	audio/sentence_show_preparedness_7778b772.mp3
cf30d619-483d-4dc4-8f67-d359a1325b4b	4452b0a8-283e-4bec-b456-37ad01a2fb6e	Work efficiently in meetings	Работай эффективно на встречах	audio/sentence_work_efficiently_8f918f2e.mp3
c388c8c3-0355-406f-bafd-62b734e2018d	530b1987-55fb-4a97-85b4-ba4506b8f615	Give a presentation next week	Будь презентацию на следующей неделе	audio/sentence_give_a_bb6e920d.mp3
e8fc48b8-ab81-4a50-b93a-c2f349e9c715	f64aa5c9-2523-4389-ba94-7ac461950157	Outline your project ideas	Структурируй свои идеи по проекту	audio/sentence_outline_your_aa11d4eb.mp3
ca87b6a1-1b5d-4817-8e45-902ee52551f7	f30d865f-af7e-4343-9bbb-cfc62aa0165f	Summarize the key points	Обобщи ключевые моменты	audio/sentence_summarize_the_271ae9de.mp3
5e5b4d4f-3b3a-4680-a464-4186a7b71dd2	e6a6d3f5-ec5f-44c5-99bb-26aa5f3c9fad	Let's conclude the meeting	Давайте закончим встречу	audio/sentence_let's_conclude_aa2d4a5d.mp3
b45a1289-ba3f-4bd9-b0b4-8c9b63ea9920	e015508f-4c03-4927-b1af-d9804b3d05bb	Clear up confusion now	Разберись в путанице сейчас	audio/sentence_clear_up_ede7bc9f.mp3
29aeae34-1a8e-4722-b183-f4788c84add4	afc263c5-34e0-4550-a688-0638aa63ae6c	Bring up this issue	Затронь этот вопрос	
5db566e0-f5bc-4f74-96d4-da88480146ed	683a3c8f-8ec8-4f02-9002-e4e13faae11a	Arrive on time for meetings	Приезжай вовремя на встречи	audio/sentence_arrive_on_c80744f5.mp3
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title, parent_id, seed_words) FROM stdin;
3a3b836a-7839-44a2-af93-7de4b4523f33	Travel	\N	\N
0b92b4d3-9715-4267-a933-bbdf553b51b8	Airport	3a3b836a-7839-44a2-af93-7de4b4523f33	\N
aa4543d8-f212-48b4-97da-5ea924de3c99	Check-in & Security	0b92b4d3-9715-4267-a933-bbdf553b51b8	check-in,ticket,passport,security,boarding pass,screening,gate
b1fa70a1-f4d0-4996-8202-e4c20862d1b9	Talking to Airline Staff	0b92b4d3-9715-4267-a933-bbdf553b51b8	flight,delay,luggage,reservation,boarding,passport,ticket,transfer
970b454c-676a-4b33-8d4f-86819b828e64	Asking for Directions	0b92b4d3-9715-4267-a933-bbdf553b51b8	gate,terminal,directions,information desk,map,signs,departure
3703d1bf-478b-4630-81a1-5f39b1161fc9	Lost Luggage	0b92b4d3-9715-4267-a933-bbdf553b51b8	luggage,baggage,claim,missing,report,form,tag
32470776-4044-4e4b-84ac-5d5d7c3863dc	Customs & Immigration	0b92b4d3-9715-4267-a933-bbdf553b51b8	customs,declaration,passport,visa,immigration,officer,entry
483e6654-b835-4d7b-ad7e-cd54be8f179c	Transportation	3a3b836a-7839-44a2-af93-7de4b4523f33	\N
adde6fc0-341a-4788-9e81-8b3c2e8df6ca	Taxi / Ride Hailing	483e6654-b835-4d7b-ad7e-cd54be8f179c	taxi,cab,driver,uber,ride,pickup,destination,fare
b66ed7fd-27fd-4406-8382-d841e8144e7b	Public Transport	483e6654-b835-4d7b-ad7e-cd54be8f179c	bus,train,metro,ticket,station,line,platform
1bc072b7-a10d-4e83-b567-e16f863829f2	Renting a Car	483e6654-b835-4d7b-ad7e-cd54be8f179c	car,rent,license,insurance,vehicle,reservation,deposit
fd370ee5-b869-4c70-a415-f73bd0158a67	Buying Tickets	483e6654-b835-4d7b-ad7e-cd54be8f179c	ticket,buy,purchase,window,booth,price,schedule
46d60632-35c9-45ad-b876-be4ec8cf36f4	Accommodation	3a3b836a-7839-44a2-af93-7de4b4523f33	\N
35380b89-1706-4c35-8445-bb3ab74653e8	Booking a Room	46d60632-35c9-45ad-b876-be4ec8cf36f4	hotel,reservation,book,stay,check-in,availability,room
01fda5a0-9551-4b80-a795-51694c63e1be	Hotel Reception	46d60632-35c9-45ad-b876-be4ec8cf36f4	reception,check-in,checkout,key,room,service,lobby
64bf03f3-eb8b-4b27-a87d-aa3b527738e1	Room Requests	46d60632-35c9-45ad-b876-be4ec8cf36f4	towels,pillow,blanket,cleaning,soap,water,repair
9a95bf9d-4e4b-4ca5-a508-8574864dcbac	Complaints	46d60632-35c9-45ad-b876-be4ec8cf36f4	problem,dirty,noisy,broken,complain,issue,fix
d28f19d6-b0cf-47a2-bfa2-fabf1612a40f	Town/City Navigation	3a3b836a-7839-44a2-af93-7de4b4523f33	\N
b84e6ebe-e62e-4173-bb74-75b5285738cd	Asking for Directions	d28f19d6-b0cf-47a2-bfa2-fabf1612a40f	directions,street,corner,left,right,block,map
72532b9f-4718-4e14-87a6-472ff4931700	Using a Map / GPS	d28f19d6-b0cf-47a2-bfa2-fabf1612a40f	map,gps,route,navigation,location,app,coordinates
3261997a-1d80-4b4a-b062-ee0f785b4a78	Describing Landmarks	d28f19d6-b0cf-47a2-bfa2-fabf1612a40f	church,bridge,statue,building,monument,plaza
ee32c75c-0f15-4952-b9cc-817b7a99e2d5	Asking About Distance / Time	d28f19d6-b0cf-47a2-bfa2-fabf1612a40f	distance,time,minutes,how far,walk,drive,bus
9259a527-12c0-4575-a75c-bad989052f8e	Eating Out	3a3b836a-7839-44a2-af93-7de4b4523f33	\N
36a98168-317b-48a0-aad7-6516d9298352	Ordering Food & Drinks	9259a527-12c0-4575-a75c-bad989052f8e	menu,order,food,drink,water,dish,please
586e0d3e-08e6-4003-bc88-ab50b7e1b1cc	Asking About the Menu	9259a527-12c0-4575-a75c-bad989052f8e	menu,vegetarian,spicy,contains,gluten,ingredient
f5efcff2-32b5-4b9d-b4eb-cbb13aba277f	Dietary Restrictions	9259a527-12c0-4575-a75c-bad989052f8e	vegetarian,vegan,allergy,gluten,dairy,nuts,halal
8ac30e42-14c6-4de5-b37f-ff130697fafb	Paying the Bill	9259a527-12c0-4575-a75c-bad989052f8e	bill,check,pay,cash,card,tips,split
ff71c086-af8b-4c46-94c9-818666e2fb06	Complaining Politely	9259a527-12c0-4575-a75c-bad989052f8e	cold,undercooked,wrong,late,sorry,mistake,replace
77a5c14d-caaf-418b-897a-38b25f6c15c2	Social Interaction	\N	\N
23408b01-1249-407a-b1d5-a80a187f61ba	Greetings & Introductions	77a5c14d-caaf-418b-897a-38b25f6c15c2	\N
a105c3b1-720d-410f-9a6c-bc6f4c1839d5	Meeting Strangers	23408b01-1249-407a-b1d5-a80a187f61ba	hello,hi,name,nice,meet,introduce,where from
84cb6e14-6ea0-4cdc-a7eb-8b90e6159249	Saying Goodbye	23408b01-1249-407a-b1d5-a80a187f61ba	bye,goodbye,see you,take care,travel safe
29039255-5042-4097-962a-8e640327db25	Small Talk	23408b01-1249-407a-b1d5-a80a187f61ba	weather,job,hobby,travel,food,how are you
00588743-8bce-4fa1-9e17-8b0e2fc5ce9e	Asking for Help	77a5c14d-caaf-418b-897a-38b25f6c15c2	\N
74e29385-e700-4a34-95e4-9c39f5396ad7	In a Shop	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e	help,where,find,item,size,price,aisle
ae3a4133-4763-4ef9-9dd1-107700f3d88b	On the Street	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e	directions,where,how,get,toilet,station,bus
727d5b3c-850a-400a-8590-6511de3ca195	At the Police Station	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e	report,stolen,help,passport,document,emergency
50390dad-aa1a-4471-9d1d-5adc1900fe12	Emergency Situations	77a5c14d-caaf-418b-897a-38b25f6c15c2	\N
4605b4b3-bdb1-4ded-92ec-45a5d42389b2	Medical Help	50390dad-aa1a-4471-9d1d-5adc1900fe12	doctor,help,pain,emergency,ambulance,hospital
9175c742-633c-4a95-a574-391bfe0a36ad	Lost Passport	50390dad-aa1a-4471-9d1d-5adc1900fe12	passport,stolen,lost,report,embassy,ID
7b5a0280-b2dd-43e8-9926-9668e269f55e	Stolen Items	50390dad-aa1a-4471-9d1d-5adc1900fe12	stolen,bag,phone,report,police,missing
7093071d-fa66-4cda-9463-dd99ade6f956	Fire or Accident	50390dad-aa1a-4471-9d1d-5adc1900fe12	fire,accident,emergency,help,burn,injury
832f86dc-f6ee-400e-a8c1-b620072bbc71	Shopping	\N	\N
2d01e13b-8ad5-4800-8401-0e7cd25bc8db	Grocery Store	832f86dc-f6ee-400e-a8c1-b620072bbc71	\N
fc81b67c-8e5d-42c6-b1c4-f5b97adae10a	Weights and Measures	2d01e13b-8ad5-4800-8401-0e7cd25bc8db	kilo,gram,liter,weight,quantity,scale
3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8	Asking Prices	2d01e13b-8ad5-4800-8401-0e7cd25bc8db	price,cost,how much,expensive,cheap
b45f9a53-fe24-416b-b245-a6cae3a536b3	Item Categories	2d01e13b-8ad5-4800-8401-0e7cd25bc8db	fruit,vegetable,dairy,bread,meat,snack
4f419e0f-3497-4741-8383-2379c77051a9	Souvenirs & Markets	832f86dc-f6ee-400e-a8c1-b620072bbc71	\N
ffb2f11d-06ce-406d-be45-c42643eb3c19	Haggling / Bargaining	4f419e0f-3497-4741-8383-2379c77051a9	discount,price,cheap,too much,bargain,offer
7332086d-d229-4db6-b658-f3408aa99bb3	Describing Items	4f419e0f-3497-4741-8383-2379c77051a9	color,size,material,handmade,local
a4fa7e42-0fb3-4dc8-900a-b9de678881b2	Sizes / Colors / Materials	4f419e0f-3497-4741-8383-2379c77051a9	small,medium,large,red,blue,cotton,leather
ca00eccf-7168-4254-ace2-d3a4e287f231	Dining	\N	\N
e00a469c-5652-49ab-8657-a6f46a96b208	In a Restaurant	ca00eccf-7168-4254-ace2-d3a4e287f231	\N
4a220014-7da3-46c4-8c0d-ebf0b05433e9	Making a Reservation	e00a469c-5652-49ab-8657-a6f46a96b208	reservation,table,time,number,people,book
343595a2-73bc-478f-84ce-b02fe7d898e4	Talking to Waiters	e00a469c-5652-49ab-8657-a6f46a96b208	menu,recommendation,order,please,thank you,waiter
c4f57c05-e684-430e-a85d-3acccb354554	Asking About Dishes	e00a469c-5652-49ab-8657-a6f46a96b208	ingredient,spicy,sweet,salty,gluten,dairy,contains
4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3	Requesting Check / Water / Toilet	e00a469c-5652-49ab-8657-a6f46a96b208	check,bill,water,toilet,restroom,ice
acb3b56d-8cde-4424-85ea-645802ac0b4f	Health	\N	\N
0f7d5117-191c-48ee-963d-a710ca1dc0b3	Pharmacy	acb3b56d-8cde-4424-85ea-645802ac0b4f	\N
9d303b04-b092-4abc-af81-968eabcdd205	Describing Symptoms	0f7d5117-191c-48ee-963d-a710ca1dc0b3	headache,fever,cough,pain,nausea,tired
d7f212a4-a5b6-4492-8991-3a123873c483	Asking for Medicine	0f7d5117-191c-48ee-963d-a710ca1dc0b3	medicine,tablet,pill,cough syrup,ointment,cream
1e08f1d6-3834-4953-bea7-f858511a6d84	Understanding Dosage	0f7d5117-191c-48ee-963d-a710ca1dc0b3	dosage,instructions,times,how often,take,after meal
f2d13fc1-c4a9-4979-8b81-93d9a9969a28	Doctor’s Office	acb3b56d-8cde-4424-85ea-645802ac0b4f	\N
7811cf8e-37f9-45f2-a15c-3092320e59e8	Body Part Names	f2d13fc1-c4a9-4979-8b81-93d9a9969a28	head,arm,leg,chest,back,throat
926f30ae-00cc-42fa-9ae9-3d813b784ef4	Types of Pain	f2d13fc1-c4a9-4979-8b81-93d9a9969a28	sharp,dull,ache,stabbing,constant,occasional
a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78	Making an Appointment	f2d13fc1-c4a9-4979-8b81-93d9a9969a28	appointment,doctor,schedule,available,date,time
28dd9708-a8e5-445f-9754-320c968b96d4	Time & Numbers	\N	\N
33df7a3b-f68d-4430-bfd5-dda6b517bcd1	Telling Time	28dd9708-a8e5-445f-9754-320c968b96d4	\N
96dbf3ae-869f-4393-bccd-9939fc05f646	what time	33df7a3b-f68d-4430-bfd5-dda6b517bcd1	when,now,early,late,o’clock
d1ad27ab-7385-48f6-bde9-7b9cc86d2ddc	Duration	33df7a3b-f68d-4430-bfd5-dda6b517bcd1	how long,minutes,hours,days,time,wait
b2073d08-e313-4b58-8ff6-85ca9b858ad8	Opening Hours	33df7a3b-f68d-4430-bfd5-dda6b517bcd1	open,close,time,schedule,when
83bea03d-2a3c-4eba-bdf9-7205eb6591be	Dates & Calendar	28dd9708-a8e5-445f-9754-320c968b96d4	\N
53e0c106-9803-4a4e-a880-f36db64c1373	Days and Months	83bea03d-2a3c-4eba-bdf9-7205eb6591be	monday,friday,january,month,day,week
f404724a-3fa0-48b0-a89c-04643421f399	Holidays	83bea03d-2a3c-4eba-bdf9-7205eb6591be	holiday,festival,christmas,easter,vacation
5c0ed7ed-cbfa-4d6c-bd49-74c877470f71	Scheduling Appointments	83bea03d-2a3c-4eba-bdf9-7205eb6591be	book,schedule,appointment,meeting,date,time
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (id, user_id, cefr_level, fact_everyday, notifications, notifications_at, words_per_day, goal, subscribed, avatar_image_url) FROM stdin;
22717408-7c5e-4653-b699-5a7ca18f84af	154c7fe4-8368-440b-84fa-d90ab8c3a772	A1	f	f	\N	10	Learn new words	f	
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, google_id, provider, name, role, email, password_hash, telegram_id, last_login_at, is_active, created_at) FROM stdin;
154c7fe4-8368-440b-84fa-d90ab8c3a772		password	Danila	user	Woolfer0097@yandex.ru	$2a$10$lO8hLQqdbeLOSRxeIOonJOPU9J2o8WpCHNM8O0iPM3FGitlGg486y	\N	2025-08-05 18:07:20.360857+00	t	2025-08-05 18:07:20.361052+00
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.words (id, word, translation, part_of_speech, context, cefr_level, audio_url, phonetic, topic_id) FROM stdin;
b80f08a3-9af3-454b-8d94-01307c160420	check in	регистрироваться	phrasal verb	Please check in at the counter	A2	audio/word_check_in_02d29875.mp3	ʧɛk ɪn	aa4543d8-f212-48b4-97da-5ea924de3c99
f33ed5ad-3fc6-4d60-97ea-9e9a5b06f290	boarding pass	посадочный талон	noun	Show me your boarding pass	A2	audio/word_boarding_pass_60cc3bc3.mp3	ˈbɔrdɪŋ pæs	aa4543d8-f212-48b4-97da-5ea924de3c99
e48b84b2-1454-4701-b95f-cb99a62d12ef	passport control	проверка паспортов	noun	We have to go through passport control	B1	audio/word_passport_control_c709f4d9.mp3	ˈpæˌspɔrt kənˈtroʊl	aa4543d8-f212-48b4-97da-5ea924de3c99
152a3230-2236-43c3-8194-d7ca4be33ed2	security check	контроль безопасности	noun	There is a security check ahead	A2	audio/word_security_check_2db34fa5.mp3	sɪˈkjʊrəti ʧɛk	aa4543d8-f212-48b4-97da-5ea924de3c99
ce92caf8-2e26-4e99-814c-f2a3a912953a	luggage drop-off	сдача багажа	noun	Where is the luggage drop-off point?	B1	audio/word_luggage_drop-off_67482c79.mp3	ˈləgɪʤ ˈdrɑˌpɔf	aa4543d8-f212-48b4-97da-5ea924de3c99
62866357-aa05-4408-9b68-f0f71792e58d	carry-on	ручная кладь	noun	Keep your carry-on with you	A2	audio/word_carry-on_293e36b3.mp3	carry-on*	aa4543d8-f212-48b4-97da-5ea924de3c99
63352a22-f975-4de8-a16b-6a8287f4e595	metal detector	металлоискатель	noun	Walk through the metal detector	A2	audio/word_metal_detector_0ae43253.mp3	ˈmɛtəl dɪˈtɛktər	aa4543d8-f212-48b4-97da-5ea924de3c99
d4dc7b2d-333b-48e7-958a-1dad7c7b899e	remove shoes	снять обувь	phrase	Please remove your shoes	A2	audio/word_remove_shoes_89c57ef4.mp3	riˈmuv ʃuz	aa4543d8-f212-48b4-97da-5ea924de3c99
b240b5e4-57ce-4271-b324-5041701b134c	place in tray	положить в лоток	phrase	Place your laptop in the tray	B1	audio/word_place_in_627bd7e1.mp3	pleɪs ɪn treɪ	aa4543d8-f212-48b4-97da-5ea924de3c99
58b698bd-3c94-4801-81d3-337bfdbd6eda	liquids rule	правило жидкостей	phrase	Remember the liquids rule	B1	audio/word_liquids_rule_4f4f9f5a.mp3	ˈlɪkwɪdz rul	aa4543d8-f212-48b4-97da-5ea924de3c99
9988fb9b-3ec7-41cd-a279-b2a4ba1bf612	boarding gate	выход на посадку	noun	Find your boarding gate	A2	audio/word_boarding_gate_58c7a5ce.mp3	ˈbɔrdɪŋ geɪt	aa4543d8-f212-48b4-97da-5ea924de3c99
0da9f583-06a5-4226-9671-2878e13949e1	ID card	удостоверение личности	noun	Show your ID card	A1	audio/word_id_card_2e8824df.mp3	ˈaɪˈdi kɑrd	aa4543d8-f212-48b4-97da-5ea924de3c99
3ccdf515-2819-4108-8d73-1d5d277a5cba	check your bag	проверить багаж	phrasal verb	They will check your bag	B1	audio/word_check_your_50d20386.mp3	ʧɛk jʊr bæg	aa4543d8-f212-48b4-97da-5ea924de3c99
46c18eec-e452-4cef-b9a6-361219753ef4	overflow charge	плата за перевес	noun	You may have to pay an overflow charge	B2	audio/word_overflow_charge_60068a4b.mp3	ˌoʊvərˈfloʊ ʧɑrʤ	aa4543d8-f212-48b4-97da-5ea924de3c99
5970bde5-1937-4a3e-a8a5-6791d2a03f1e	hand luggage	ручная кладь (брит.)	noun	Place hand luggage under the seat	A2	audio/word_hand_luggage_a2ae8c96.mp3	hænd ˈləgɪʤ	aa4543d8-f212-48b4-97da-5ea924de3c99
29ab0175-7d6e-4b6b-a099-61ce1fdecba3	scan	сканировать	verb	Scan your boarding pass	A2	audio/word_scan_3ea7ab77.mp3	skæn	aa4543d8-f212-48b4-97da-5ea924de3c99
2e01113e-0cec-4a85-be20-dc0d7558864e	check-in	регистрация	noun	I need to check in for my flight	A1	audio/word_check-in_06533391.mp3	check-in*	aa4543d8-f212-48b4-97da-5ea924de3c99
90bb171b-5612-4aca-b613-5f5436ae9ef6	boarding pass	посадочный талон	noun	Show me your boarding pass, please	A1	audio/word_boarding_pass_c7bbc049.mp3	ˈbɔrdɪŋ pæs	aa4543d8-f212-48b4-97da-5ea924de3c99
805633bc-4388-487d-9c6d-27f893d87343	security check	контроль безопасности	noun	Go through security check	A1	audio/word_security_check_881231f3.mp3	sɪˈkjʊrəti ʧɛk	aa4543d8-f212-48b4-97da-5ea924de3c99
cd1b9ac5-0ffc-4cb1-b24f-603fe1944922	passport control	паспортный контроль	noun	Passport control is over there	A1	audio/word_passport_control_fc69ed55.mp3	ˈpæˌspɔrt kənˈtroʊl	aa4543d8-f212-48b4-97da-5ea924de3c99
a4e382e7-c622-45f1-97e3-95696e036f9b	ID card	удостоверение личности	noun	Do you have your ID card?	A1	audio/word_id_card_c296fe2b.mp3	ˈaɪˈdi kɑrd	aa4543d8-f212-48b4-97da-5ea924de3c99
e5e5131d-0f19-4a1f-ab47-99d49180c3e1	boarding gate	выход на посадку	noun	What is my boarding gate?	A1	audio/word_boarding_gate_9f88abb6.mp3	ˈbɔrdɪŋ geɪt	aa4543d8-f212-48b4-97da-5ea924de3c99
b6a90edc-c731-493f-af31-1644ae077dda	flight number	номер рейса	noun	What is your flight number?	A1	audio/word_flight_number_b953dc50.mp3	flaɪt ˈnəmbər	aa4543d8-f212-48b4-97da-5ea924de3c99
d07c320f-8765-41c6-81b3-34c1342a7401	hand luggage	ручная кладь	noun	This is my hand luggage	A1	audio/word_hand_luggage_09ef770f.mp3	hænd ˈləgɪʤ	aa4543d8-f212-48b4-97da-5ea924de3c99
e9f66967-c7af-42c4-899e-d80f6a39d8bb	check-in counter	стойка регистрации	noun	The check-in counter is over there	A1	audio/word_check-in_counter_296a12a7.mp3	check-in* ˈkaʊntər	aa4543d8-f212-48b4-97da-5ea924de3c99
14130d63-d04a-47be-ae1f-52b467c9d93f	baggage allowance	норма провоза багажа	noun	What is my baggage allowance?	A2	audio/word_baggage_allowance_d8c3a1a6.mp3	ˈbægɪʤ əˈlaʊəns	aa4543d8-f212-48b4-97da-5ea924de3c99
17e1b5c7-0d7e-45ca-bcda-deadcafd7cc5	excess baggage	сверхнормативный багаж	noun	I have some excess baggage	A2	audio/word_excess_baggage_14723689.mp3	ˈɛkˌsɛs ˈbægɪʤ	aa4543d8-f212-48b4-97da-5ea924de3c99
aa811dea-a204-4d7d-8fd3-a733a7d2db92	fill in	заполнять	verb	Please fill in this form	A2	audio/word_fill_in_b5cc1b54.mp3	fɪl ɪn	aa4543d8-f212-48b4-97da-5ea924de3c99
19199535-55a3-49c1-9e39-6340bb3c2875	go through	проходить	verb	You need to go through security	A2	audio/word_go_through_327b16df.mp3	goʊ θru	aa4543d8-f212-48b4-97da-5ea924de3c99
bc61ecd5-93ef-467f-8f34-dea5c98afe50	take off	взлетать	verb	When does the plane take off?	A2	audio/word_take_off_be9ccdd9.mp3	teɪk ɔf	aa4543d8-f212-48b4-97da-5ea924de3c99
52a17071-383c-4663-af4e-ca92cc293044	get on	садиться	verb	Get on the plane now	A2	audio/word_get_on_c859fcfd.mp3	gɪt ɔn	aa4543d8-f212-48b4-97da-5ea924de3c99
c2cab820-99d8-481c-a4e0-ec6f00627552	hold on	держать	verb	Hold on to your bags	A2	audio/word_hold_on_1ff93b70.mp3	hoʊld ɔn	aa4543d8-f212-48b4-97da-5ea924de3c99
c8355fdd-0bbb-42c4-a6d4-f7b5d94c33b3	queue up	стоять в очереди	verb	We have to queue up for security	A2	audio/word_queue_up_135f67f1.mp3	kju əp	aa4543d8-f212-48b4-97da-5ea924de3c99
7c3312e2-ac5a-4bb3-80fa-b046b8dca00c	boarding time	время посадки	noun	What time is boarding?	A2	audio/word_boarding_time_25109985.mp3	ˈbɔrdɪŋ taɪm	aa4543d8-f212-48b4-97da-5ea924de3c99
f1db223f-b5db-438a-9065-a10e4cf19e59	delay	задержка	noun	The flight is delayed	A2	audio/word_delay_468e7ca8.mp3	dɪˈleɪ	aa4543d8-f212-48b4-97da-5ea924de3c99
9ea6e329-24c7-49b4-b2d7-de67e5e51070	gate number	номер выхода	noun	What is the gate number?	A2	audio/word_gate_number_071d0764.mp3	geɪt ˈnəmbər	aa4543d8-f212-48b4-97da-5ea924de3c99
b1fe5398-6e47-4eff-b959-f8ccb2d50d39	security personnel	персонал службы безопасности	noun	Ask the security personnel	A2	audio/word_security_personnel_dddb434e.mp3	sɪˈkjʊrəti ˌpərsəˈnɛl	aa4543d8-f212-48b4-97da-5ea924de3c99
5015ae3f-7cbc-4ccf-a52a-a50ee56df1aa	prohibited items	запрещенные предметы	noun	These are prohibited items	A2	audio/word_prohibited_items_b21cd609.mp3	proʊˈhɪbətəd ˈaɪtəmz	aa4543d8-f212-48b4-97da-5ea924de3c99
5a0aabfc-b369-471d-b710-3a18c4050e42	liquid restrictions	ограничения на жидкости	noun	Are there liquid restrictions?	A2	audio/word_liquid_restrictions_b391f391.mp3	ˈlɪkwɪd riˈstrɪkʃənz	aa4543d8-f212-48b4-97da-5ea924de3c99
670aec19-1e89-42c9-b76f-17c5603af03b	metal detector	металлодетектор	noun	Go through the metal detector	A2	audio/word_metal_detector_74be4cb9.mp3	ˈmɛtəl dɪˈtɛktər	aa4543d8-f212-48b4-97da-5ea924de3c99
33a74ac2-5362-430d-b68e-7ba819bcf9ee	X-ray machine	рентгеновский аппарат	noun	Put your bag on the X-ray machine	A2	audio/word_x-ray_machine_390dd8c0.mp3	ˈɛksˌreɪ məˈʃin	aa4543d8-f212-48b4-97da-5ea924de3c99
ca105d2e-9c0d-48bf-a095-48bd33e626bf	scan	сканировать	verb	They will scan your passport	A2	audio/word_scan_78b3ce8a.mp3	skæn	aa4543d8-f212-48b4-97da-5ea924de3c99
f79dbdd8-c605-44a1-ae4e-776b4dfe0999	remove	удалять	verb	Remove your shoes and belt	A2	audio/word_remove_6c4987e4.mp3	riˈmuv	aa4543d8-f212-48b4-97da-5ea924de3c99
b2a62912-e24c-4ffe-9528-101e47d9742d	declare	декларировать	verb	Do you have anything to declare?	A2	audio/word_declare_91ac7cbe.mp3	dɪˈklɛr	aa4543d8-f212-48b4-97da-5ea924de3c99
5c55751e-4fa5-4578-bc5f-c077a2d3fa01	flight	рейс	noun	What time is my flight?	A1	audio/word_flight_d42813ed.mp3	flaɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
7597e13c-8f5c-4b2e-8c10-dc3671e98a77	delayed	задержанный	adjective	My flight is delayed	A1	audio/word_delayed_335513e8.mp3	dɪˈleɪd	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
f47f4c8b-5460-40d6-9f06-c62193b556e2	boarding gate	выход на посадку	noun	Where is my boarding gate?	A1	audio/word_boarding_gate_381b20a4.mp3	ˈbɔrdɪŋ geɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
8b5726f2-f0db-4cbd-b898-8fbc6f3604e0	terminal	терминал	noun	Which terminal is my flight from?	A1	audio/word_terminal_e4359da9.mp3	ˈtərmənəl	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
283e8217-b053-4f12-ad25-54ca9a69a2f8	baggage claim	выдача багажа	noun	Where is baggage claim?	A1	audio/word_baggage_claim_b706d845.mp3	ˈbægɪʤ kleɪm	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
c28209d9-2f8d-4ec4-ad52-bb8ac81a38b3	check-in desk	стойка регистрации	noun	Go to the check-in desk	A1	audio/word_check-in_desk_54a730ef.mp3	check-in* dɛsk	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
648eb7dd-72ee-4d57-8418-0e2c5edc4a6e	hand luggage	ручная кладь	noun	This is my hand luggage	A1	audio/word_hand_luggage_d1f8006b.mp3	hænd ˈləgɪʤ	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
a052f528-c2b5-48dc-b5b3-dad9fb703969	lost luggage	утерянный багаж	noun	I have lost luggage	A1	audio/word_lost_luggage_35b34f59.mp3	lɔst ˈləgɪʤ	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
9145cc40-1271-44bd-8a91-c1c2f6e93930	connecting flight	стыковочный рейс	noun	I have a connecting flight	A2	audio/word_connecting_flight_b0c2f6f9.mp3	kəˈnɛktɪŋ flaɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
1d27f874-1a7e-46f2-914e-4e17684e2076	change flight	изменить рейс	verb	Can I change my flight?	A2	audio/word_change_flight_c7c25d33.mp3	ʧeɪnʤ flaɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
baa650e3-75e8-4b9d-8131-b50074a181e7	miss a flight	пропустить рейс	verb	I don't want to miss my flight	A2	audio/word_miss_a_c27fd8c5.mp3	mɪs ə flaɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
70f88a05-a658-4877-9d0b-c4261fe669d7	boarding	посадка	noun	Boarding is now beginning	A2	audio/word_boarding_3c61994a.mp3	ˈbɔrdɪŋ	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
c46249b2-9e49-484c-a0ba-3cb8e69623d3	confirm flight	подтвердить рейс	verb	Please confirm my flight	A2	audio/word_confirm_flight_5c4c28fa.mp3	kənˈfərm flaɪt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
6999122f-e9cd-4d99-9276-7aa4069f7780	upgrade	апгрейд	noun	Is it possible to get an upgrade?	A2	audio/word_upgrade_f4331a07.mp3	ˈəpˈgreɪd	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
d20717fb-d023-4861-b2bd-992ef3bc4598	assistance	помощь	noun	I need some assistance	A2	audio/word_assistance_51f057f3.mp3	əˈsɪstəns	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
63d9c324-7b64-458b-8ab4-2cc3f48b24e9	rebook	перебронировать	verb	I need to rebook my flight	A2	audio/word_rebook_0c0c3ef0.mp3	riˈbʊk	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
709a44b5-9d03-44ca-b6a9-8171eb738544	re-route	перенаправить	verb	Can you re-route me?	A2	audio/word_re-route_bdf895a4.mp3	re-route*	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
6f6968b4-a579-439c-84c7-a894dc6d9f15	complain	жаловаться	verb	I want to complain about my baggage	A2	audio/word_complain_d7ae3333.mp3	kəmˈpleɪn	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
e018c7f3-9cee-4c44-a2c3-b4c72fe4d364	inquiry	запрос	noun	I have an inquiry	A2	audio/word_inquiry_da3686e5.mp3	ˌɪnkˈwaɪˌri	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
1aac3a60-e116-4788-84aa-33f17deb4a6e	passport control	паспортный контроль	noun	Go through passport control	B1	audio/word_passport_control_33e8b097.mp3	ˈpæˌspɔrt kənˈtroʊl	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
ab6470a7-52c4-4f65-befa-cfc777368f84	customs	таможня	noun	Go through customs	B1	audio/word_customs_8cd3f8a6.mp3	ˈkəstəmz	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
6c5d498c-297c-4a44-a419-65c1939b25c9	security check	контроль безопасности	noun	Go through the security check	B1	audio/word_security_check_9686a046.mp3	sɪˈkjʊrəti ʧɛk	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
f88e6186-1f60-4596-8b0e-1ae82ff57b88	excess baggage	сверхнормативный багаж	noun	I have excess baggage	B1	audio/word_excess_baggage_4cf7881a.mp3	ˈɛkˌsɛs ˈbægɪʤ	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
c3489adf-bc6f-4bb3-847c-af9c949f827d	flight number	номер рейса	noun	What is your flight number?	B1	audio/word_flight_number_36ce6cf9.mp3	flaɪt ˈnəmbər	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
8aa1ff16-29aa-4aa3-99ac-2176cf39775b	get through	пройти	phrasal verb	I need to get through security	B1	audio/word_get_through_56fe8768.mp3	gɪt θru	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
30fc0bef-0621-40f1-ac8b-ddece6cd3fa2	sort out	разрешить	phrasal verb	Can you help me sort this out?	B1	audio/word_sort_out_7a85f571.mp3	sɔrt aʊt	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
f128bda2-3d69-4fee-aa8f-e91236ec8342	hold on	подождите	phrasal verb	Please hold on a moment	B1	audio/word_hold_on_2b25490c.mp3	hoʊld ɔn	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
338f320a-fe8f-4868-b83c-f0a05e8c9e40	take care of	заботиться	phrasal verb	I hope you can take care of it	B1	audio/word_take_care_2bfc00f7.mp3	teɪk kɛr əv	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
ef88ff2b-55d6-4aa3-83c1-63fde389647b	excuse me	извините	exclamation	Excuse me, I need help	A1	audio/word_excuse_me_16ec5767.mp3	ɪkˈskjuz mi	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
6e0720e5-f44d-4929-83ae-19b2eaeb16ac	thank you	спасибо	exclamation	Thank you very much	A1	audio/word_thank_you_0417d191.mp3	θæŋk ju	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
b33f5927-e95e-44e4-b957-908d593eae47	please	пожалуйста	adverb	Please help me	A1	audio/word_please_892deab2.mp3	pliz	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
89015a68-6f2a-42d7-af30-66826f0a9122	sorry	извините	interjection	Sorry, I didn't understand	A1	audio/word_sorry_f423a8a6.mp3	ˈsɑri	b1fa70a1-f4d0-4996-8202-e4c20862d1b9
a1afb737-3596-4ea5-8a3a-3d30fad9517b	Excuse me	Извините	interjection	Excuse me, could you help me?	A1	audio/word_excuse_me_c808260a.mp3	ɪkˈskjuz mi	b84e6ebe-e62e-4173-bb74-75b5285738cd
f178feca-e991-4ffa-88f9-77c35bf84a17	Where is?	Где?	phrase	Where is gate 23?	A1	audio/word_where_is?_82d5e3be.mp3	wɛr ɪz?	b84e6ebe-e62e-4173-bb74-75b5285738cd
c57a44f3-df42-4ca3-a58a-67b57a9de6d2	terminal	терминал	noun	Which terminal is my flight from?	A1	audio/word_terminal_1e43c132.mp3	ˈtərmənəl	b84e6ebe-e62e-4173-bb74-75b5285738cd
6853e981-1dd3-49b0-a040-600c389a45f6	gate	выход	noun	What gate is my flight?	A1	audio/word_gate_6ca32aea.mp3	geɪt	b84e6ebe-e62e-4173-bb74-75b5285738cd
15655eb8-7808-419a-b6d4-2aa2a8b87576	flight number	номер рейса	noun phrase	What is your flight number?	A1	audio/word_flight_number_9bad0ccd.mp3	flaɪt ˈnəmbər	b84e6ebe-e62e-4173-bb74-75b5285738cd
02fe5743-3705-406a-85e7-5840cca56375	directions	указания	noun	Can you give me directions?	A1	audio/word_directions_adac1a6c.mp3	dɪˈrɛkʃɪnz	b84e6ebe-e62e-4173-bb74-75b5285738cd
42535431-5ffe-4f0a-b7b9-b814c9dfc8fc	go straight ahead	идти прямо	verb phrase	Go straight ahead and then turn left	A1	audio/word_go_straight_2eb0ee12.mp3	goʊ streɪt əˈhɛd	b84e6ebe-e62e-4173-bb74-75b5285738cd
d5e1b926-39af-47f7-b84f-9d174495e874	turn left	повернуть налево	verb phrase	Turn left at the end of the corridor	A1	audio/word_turn_left_76d636b3.mp3	tərn lɛft	b84e6ebe-e62e-4173-bb74-75b5285738cd
c19aac4f-7bbd-4e54-83e5-c1d0800c418c	turn right	повернуть направо	verb phrase	Turn right at the information desk	A1	audio/word_turn_right_bcfbf8d1.mp3	tərn raɪt	b84e6ebe-e62e-4173-bb74-75b5285738cd
4736b23d-9c63-4b6e-a25b-d6f26ad994f7	follow the signs	следуйте указателям	verb phrase	Follow the signs to gate 45	A1	audio/word_follow_the_7d6b1b6e.mp3	ˈfɑloʊ ðə saɪnz	b84e6ebe-e62e-4173-bb74-75b5285738cd
4ebd1e61-905e-4f2d-9cef-b75717d3efa3	it's over there	это там	phrase	The restrooms are over there	A1	audio/word_it's_over_1b4993d8.mp3	ɪts ˈoʊvər ðɛr	b84e6ebe-e62e-4173-bb74-75b5285738cd
d8266c9e-cd1a-4663-9f30-ebabf0f27f71	near	рядом	preposition	The cafe is near the gate	A1	audio/word_near_be63e012.mp3	nɪr	b84e6ebe-e62e-4173-bb74-75b5285738cd
c84659df-e35d-4308-94dc-710fd978a743	far	далеко	adjective	Is the gate far?	A1	audio/word_far_944bd45d.mp3	fɑr	b84e6ebe-e62e-4173-bb74-75b5285738cd
13ea4545-1dc1-4dae-a4b4-a4d950f7b3b0	how far?	как далеко?	phrase	How far is the gate?	A1	audio/word_how_far?_2ed47c69.mp3	haʊ fɑr?	b84e6ebe-e62e-4173-bb74-75b5285738cd
7eee35d5-7599-46c2-80b4-182d98e23295	take the elevator	возьмите лифт	verb phrase	Take the elevator to the second floor	A1	audio/word_take_the_32cd52c9.mp3	teɪk ðə ˈɛləˌveɪtər	b84e6ebe-e62e-4173-bb74-75b5285738cd
0d786e9d-f2be-408d-a141-aab276340ba0	escalator	эскалатор	noun	Take the escalator up	A1	audio/word_escalator_6a58503b.mp3	ˈɛskəˌleɪtər	b84e6ebe-e62e-4173-bb74-75b5285738cd
d7d95619-e506-40f6-ab0d-58aeb53cf825	baggage claim	получение багажа	noun phrase	Where is baggage claim?	A1	audio/word_baggage_claim_c2de15e5.mp3	ˈbægɪʤ kleɪm	b84e6ebe-e62e-4173-bb74-75b5285738cd
5a17370c-b58a-415f-91db-18c9e05935fe	customs	таможня	noun	Go to customs	A1	audio/word_customs_efc080df.mp3	ˈkəstəmz	b84e6ebe-e62e-4173-bb74-75b5285738cd
f0a2e9cf-29d3-429d-b1d7-7e347e8081ef	passport control	паспортный контроль	noun phrase	Passport control is over there	A1	audio/word_passport_control_be23de11.mp3	ˈpæˌspɔrt kənˈtroʊl	b84e6ebe-e62e-4173-bb74-75b5285738cd
4e979256-e6ab-4401-8680-d39f8c49ed39	help me	помогите мне	verb phrase	Help me find my gate	A1	audio/word_help_me_90b6da2a.mp3	hɛlp mi	b84e6ebe-e62e-4173-bb74-75b5285738cd
ec2f127f-7eae-4e80-8ddc-f88229d28d79	lost and found	бюро находок	noun phrase	Where is lost and found?	A1	audio/word_lost_and_dba6f740.mp3	lɔst ənd faʊnd	b84e6ebe-e62e-4173-bb74-75b5285738cd
f0752755-fd17-48fd-9e58-f510d65fd64f	could you please	не могли бы вы пожалуйста	phrase	Could you please point me in the right direction?	A2	audio/word_could_you_ee81f2f9.mp3	kʊd ju pliz	b84e6ebe-e62e-4173-bb74-75b5285738cd
f631f60e-d1fb-4281-b80e-b5081f8188f9	I'm lost	я заблудился/заблудилась	phrase	I'm lost, can you help me?	A2	audio/word_i'm_lost_3c85b8a2.mp3	əm lɔst	b84e6ebe-e62e-4173-bb74-75b5285738cd
a05be6be-a61b-42e2-8eeb-13d389d34705	approximately	приблизительно	adverb	It's approximately 10 minutes walk	A2	audio/word_approximately_4308c066.mp3	əˈprɑksəmətli	b84e6ebe-e62e-4173-bb74-75b5285738cd
3c37b576-dfa0-4d6a-8d55-52c95b224001	a bit far	немного далеко	phrase	The gate is a bit far, let me help you	A2	audio/word_a_bit_5a89b21e.mp3	ə bɪt fɑr	b84e6ebe-e62e-4173-bb74-75b5285738cd
13805a71-acd7-432a-8937-a7132095e2f5	how long?	сколько времени займёт?	phrase	How long will it take to get there?	A1	audio/word_how_long?_8c97275b.mp3	haʊ lɔŋ?	b84e6ebe-e62e-4173-bb74-75b5285738cd
35d7a8cb-39a6-4e44-a49c-af1afe1dd996	lost luggage	утерянный багаж	noun	I have lost luggage	A2	audio/word_lost_luggage_347346aa.mp3	lɔst ˈləgɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
df6e0f0d-bd1c-4f7b-98d3-833e57b6b75e	missing baggage	пропавший багаж	noun	My missing baggage is a suitcase	A2	audio/word_missing_baggage_c1c69683.mp3	ˈmɪsɪŋ ˈbægɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
2ba18c77-d904-49ab-8c97-0f5fc8ec31dd	delayed baggage	задержанный багаж	noun	My baggage is delayed	B1	audio/word_delayed_baggage_e526dd98.mp3	dɪˈleɪd ˈbægɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
2bca3b3e-6baa-45b9-802f-2eb00807d62e	report lost luggage	сообщить о пропавшем багаже	verb phrase	You need to report lost luggage to the airline	B1	audio/word_report_lost_b32a0400.mp3	rɪˈpɔrt lɔst ˈləgɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
ca15f219-c701-4680-adfc-87535db0dbac	fill out a form	заполнить форму	verb phrase	Please fill out a form to report your lost luggage	A2	audio/word_fill_out_58898993.mp3	fɪl aʊt ə fɔrm	3703d1bf-478b-4630-81a1-5f39b1161fc9
f1ad5ea1-3053-407c-8ce9-d8d71e5a2bc7	baggage claim	выдача багажа	noun	Where is the baggage claim?	A2	audio/word_baggage_claim_87d0c588.mp3	ˈbægɪʤ kleɪm	3703d1bf-478b-4630-81a1-5f39b1161fc9
d8e43c5b-7d9e-4b50-a03d-7fd0801f414a	claim tag	бирка на багаж	noun	Keep your claim tag	A1	audio/word_claim_tag_51bf6bb7.mp3	kleɪm tæg	3703d1bf-478b-4630-81a1-5f39b1161fc9
69e58524-6b80-4731-aaa7-2f5b645e74df	reference number	номер заявки	noun	I need my reference number	B1	audio/word_reference_number_a77f4866.mp3	ˈrɛfərəns ˈnəmbər	3703d1bf-478b-4630-81a1-5f39b1161fc9
c6a06a8c-7a10-4ee4-8860-bc39830858dd	airline counter	стойка авиакомпании	noun	Go to the airline counter	A2	audio/word_airline_counter_06819d61.mp3	ˈɛˌrlaɪn ˈkaʊntər	3703d1bf-478b-4630-81a1-5f39b1161fc9
2fd51c1b-5a5a-4941-b71b-dbac036b7bc6	file a claim	подать заявление	verb phrase	I need to file a claim for my lost luggage	B1	audio/word_file_a_0c6b4385.mp3	faɪl ə kleɪm	3703d1bf-478b-4630-81a1-5f39b1161fc9
046c7b0b-5646-4ecd-81ea-250c4de30279	get in touch with	связаться с	verb phrase	Get in touch with the airline	B1	audio/word_get_in_955d3f4a.mp3	gɪt ɪn təʧ wɪθ	3703d1bf-478b-4630-81a1-5f39b1161fc9
ae1dbee6-4d9f-4cdb-855c-4ee29e67e5c2	look for	искать	verb	I am looking for my suitcase	A1	audio/word_look_for_0ce4bbcc.mp3	lʊk fər	3703d1bf-478b-4630-81a1-5f39b1161fc9
ca3e7b12-2bf3-4f4c-91c6-55fc12471d92	check the carousel	проверить ленту багажа	verb phrase	Let’s check the carousel	A2	audio/word_check_the_f04e6dae.mp3	ʧɛk ðə ˈkɛrəˌsɛl	3703d1bf-478b-4630-81a1-5f39b1161fc9
45ec31ba-fb06-4133-9c8e-116dfb2f76e9	description of the bag	описание сумки	noun phrase	Give a description of the bag	B1	audio/word_description_of_1356de3a.mp3	dɪˈskrɪpʃən əv ðə bæg	3703d1bf-478b-4630-81a1-5f39b1161fc9
27b2b16e-d8bf-4649-aeb2-c97a0ac7e080	contents of the bag	содержание сумки	noun phrase	Describe the contents of the bag	B1	audio/word_contents_of_04c8056c.mp3	ˈkɑntɛnts əv ðə bæg	3703d1bf-478b-4630-81a1-5f39b1161fc9
b63f038e-7aa1-4b5c-9392-b66b682312ee	damaged baggage	поврежденный багаж	noun	My baggage is damaged	B1	audio/word_damaged_baggage_bd468464.mp3	ˈdæmɪʤd ˈbægɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
17895b1e-2baa-4651-aa5d-71e203f0dc55	compensation	компенсация	noun	I want compensation for my lost luggage	B2	audio/word_compensation_8a86bbca.mp3	ˌkɑmpənˈseɪʃən	3703d1bf-478b-4630-81a1-5f39b1161fc9
426fef67-119e-487e-8990-7109f30a4df4	trace the baggage	отследить багаж	verb phrase	They will trace the baggage	B2	audio/word_trace_the_ea4919cf.mp3	treɪs ðə ˈbægɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
4d091b2d-b052-4143-8013-9e2ac2bf4f21	it's gone missing	он пропал	phrase	My bag, it's gone missing	B1	audio/word_it's_gone_632f313a.mp3	ɪts gɔn ˈmɪsɪŋ	3703d1bf-478b-4630-81a1-5f39b1161fc9
74860cc2-4cc0-408a-932a-97d85fb0310b	I'm so frustrated	я так расстроен	phrase	I'm so frustrated, my bag is lost	B2	audio/word_i'm_so_9422de8c.mp3	əm soʊ ˈfrəˌstreɪtəd	3703d1bf-478b-4630-81a1-5f39b1161fc9
763e761b-fc7a-4576-b1ba-5bbefaf7a088	what a nightmare!	какой кошмар!	exclamation	What a nightmare! My luggage is lost!	B2	audio/word_what_a_867f5cc6.mp3	wət ə ˈnaɪtˌmɛr!	3703d1bf-478b-4630-81a1-5f39b1161fc9
7a48765b-cc0b-45ed-852b-2ec0b3bf69b7	Oh no!	О нет!	exclamation	Oh no! My bag is gone!	A1	audio/word_oh_no!_7d0e4ef4.mp3	oʊ noʊ!	3703d1bf-478b-4630-81a1-5f39b1161fc9
66dee369-4920-4f71-87d9-11a18b603660	that's terrible	это ужасно	phrase	That's terrible. Your bag is lost	B1	audio/word_that's_terrible_839b16a0.mp3	ðæts ˈtɛrəbəl	3703d1bf-478b-4630-81a1-5f39b1161fc9
e2cdcd38-662f-4ef8-8ff0-edade5edf00c	passport	паспорт	noun	Show me your passport, please.	A1	audio/word_passport_abc9cd05.mp3	ˈpæˌspɔrt	32470776-4044-4e4b-84ac-5d5d7c3863dc
c1a9249e-cd98-4c18-ae16-b4f31763518a	visa	виза	noun	Do you have a visa?	A1	audio/word_visa_9ed92bec.mp3	ˈvizə	32470776-4044-4e4b-84ac-5d5d7c3863dc
441b1b6b-7a1a-48cf-87a5-259b1dfd31a7	boarding pass	посадочный талон	noun	Show me your boarding pass.	A1	audio/word_boarding_pass_012b78c9.mp3	ˈbɔrdɪŋ pæs	32470776-4044-4e4b-84ac-5d5d7c3863dc
2b8a4669-e1ae-4be1-b654-436f144a9897	baggage/luggage	багаж	noun	Where is your baggage?	A1		baggage/luggage*	32470776-4044-4e4b-84ac-5d5d7c3863dc
3024fbe0-c32d-42d9-a182-147883a2094f	hand luggage/carry-on	ручная кладь	noun	You can take this as hand luggage.	A2		hænd luggage/carry-on*	32470776-4044-4e4b-84ac-5d5d7c3863dc
4c4fce09-46d9-4f8e-947a-07ad84207f03	customs declaration	таможенная декларация	noun	Fill out this customs declaration form.	A2	audio/word_customs_declaration_8e522cfc.mp3	ˈkəstəmz ˌdɛklərˈeɪʃən	32470776-4044-4e4b-84ac-5d5d7c3863dc
1cad7238-3f61-4533-96d9-e8de3fc49737	duty-free	без пошлины	noun	I'd like to buy something duty-free.	A2	audio/word_duty-free_5100501b.mp3	duty-free*	32470776-4044-4e4b-84ac-5d5d7c3863dc
2d796b32-91ee-4124-8f33-9eb8ffa896ff	immigration officer	пограничник	noun	The immigration officer asked me some questions.	B1	audio/word_immigration_officer_288caeb1.mp3	ˌɪməˈgreɪʃən ˈɔfɪsər	32470776-4044-4e4b-84ac-5d5d7c3863dc
ff40c9b2-d9b2-45be-b920-cf61c9816d76	fill out	заполнять	verb	Please fill out this form.	A2	audio/word_fill_out_2495987a.mp3	fɪl aʊt	32470776-4044-4e4b-84ac-5d5d7c3863dc
2c4d89b5-ae57-4687-bd7e-27e7b32c6a5c	go through	проходить	verb phrase	Go through customs.	A2	audio/word_go_through_79cf8dfb.mp3	goʊ θru	32470776-4044-4e4b-84ac-5d5d7c3863dc
b5bd7364-afae-4e93-a12d-958e626aa0d1	declare	декларировать	verb	Do you have anything to declare?	B1	audio/word_declare_d6bfd09f.mp3	dɪˈklɛr	32470776-4044-4e4b-84ac-5d5d7c3863dc
7784373e-33d2-468e-a757-8f226905abc3	inspect	проверять	verb	They inspected my luggage.	B1	audio/word_inspect_eb31c988.mp3	ˌɪnˈspɛkt	32470776-4044-4e4b-84ac-5d5d7c3863dc
4cc37f79-c21c-462a-8536-10911672463b	check	проверять	verb	They checked my passport.	A1	audio/word_check_e0804a9b.mp3	ʧɛk	32470776-4044-4e4b-84ac-5d5d7c3863dc
6282cd63-bd22-4ca4-a689-daca850e4604	queue/line	очередь	noun	There's a long queue at customs.	A1		queue/line*	32470776-4044-4e4b-84ac-5d5d7c3863dc
b92fef56-8722-4ea7-a6d4-e9ad9a15e479	security check	контроль безопасности	noun	You need to go through security check.	A2	audio/word_security_check_87bdf733.mp3	sɪˈkjʊrəti ʧɛk	32470776-4044-4e4b-84ac-5d5d7c3863dc
f8ca2ec3-19a9-4bf5-b440-951a113ef481	get through	проходить	verb phrase	Did you get through security quickly?	A2	audio/word_get_through_4b72ca40.mp3	gɪt θru	32470776-4044-4e4b-84ac-5d5d7c3863dc
c166461f-f6df-4176-8305-add202fc30dc	prohibited items	запрещённые предметы	noun phrase	Check the list of prohibited items.	B1	audio/word_prohibited_items_7f9fdc5e.mp3	proʊˈhɪbətəd ˈaɪtəmz	32470776-4044-4e4b-84ac-5d5d7c3863dc
a66c00cd-4780-410c-bdf5-411d75ce3e09	liquid restrictions	ограничения на жидкости	noun phrase	Be aware of liquid restrictions.	B1	audio/word_liquid_restrictions_addba4ce.mp3	ˈlɪkwɪd riˈstrɪkʃənz	32470776-4044-4e4b-84ac-5d5d7c3863dc
e21a3dc6-bb56-46e9-bdaf-95a36de9825b	electronic devices	электронные устройства	noun phrase	You need to turn off your electronic devices.	B1	audio/word_electronic_devices_8d05a926.mp3	ˌɪˌlɛkˈtrɑnɪk dɪˈvaɪsɪz	32470776-4044-4e4b-84ac-5d5d7c3863dc
77e194df-f928-4951-911b-db18a4eacdee	customs officer	таможенник	noun	The customs officer stamped my passport.	B1	audio/word_customs_officer_ff43e047.mp3	ˈkəstəmz ˈɔfɪsər	32470776-4044-4e4b-84ac-5d5d7c3863dc
75105b0c-58ab-47c5-bdc6-c355335df2a6	seal	пломба	noun	Make sure your luggage has a seal.	B1	audio/word_seal_b60b0be2.mp3	sil	32470776-4044-4e4b-84ac-5d5d7c3863dc
b004f277-0314-4b76-839e-eddadf1b06ba	taxi	такси	noun	I need a taxi to the airport	A1	audio/word_taxi_b451ffd9.mp3	ˈtæksi	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
4b5bc061-7f07-47c7-94f7-c5a4b6943b46	ride-hailing app	приложение для вызова такси	noun	I'll use a ride-hailing app	A2	audio/word_ride-hailing_app_16f0503e.mp3	ride-hailing* æp	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
4aa8e869-f5c4-4e30-a64d-956984ef5d59	airport transfer	трансфер в аэропорт	noun	We booked an airport transfer	A2	audio/word_airport_transfer_1a38893e.mp3	ˈɛrˌpɔrt ˈtrænsfər	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
f1f9d58f-c431-4be3-a3c0-712c04acc9dc	get a ride	поймать машину/ взять машину	verb phrase	Can you help me get a ride?	A2	audio/word_get_a_3870f78c.mp3	gɪt ə raɪd	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
c491d4d2-a5d1-4cb6-9bff-6c21ebcc4d37	hail a cab	поймать такси	verb phrase	I hailed a cab outside the terminal	B1	audio/word_hail_a_13739e2a.mp3	heɪl ə kæb	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
79fabbdb-dc8f-4343-9b98-3615af6ce92b	call a taxi	вызвать такси	verb phrase	I'll call a taxi	A1	audio/word_call_a_049ae49c.mp3	kɔl ə ˈtæksi	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
c3377a11-da9a-4549-ade4-a48f813aed49	taxi rank/stand	стоянка такси	noun	The taxi rank is over there	A2		ˈtæksi rank/stand*	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
58c726a7-6848-49ae-ac36-8c13015ed44c	shared ride/taxi	общий проезд/такси	noun	A shared ride is cheaper	B1		ʃɛrd ride/taxi*	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
5c007a27-eb9e-48de-9ef1-bc00b0aef59b	estimate the fare	оценить стоимость проезда	verb phrase	Can you estimate the fare to the city center?	B1	audio/word_estimate_the_51f74673.mp3	ˈɛstəˌmeɪt ðə fɛr	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
95771da5-0f20-4f91-b068-bb3a99be9c72	tip the driver	дать чаевые водителю	verb phrase	I tipped the driver generously	B1	audio/word_tip_the_c7992417.mp3	tɪp ðə ˈdraɪvər	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
5655c40d-38df-494a-b509-67fe04f8894e	meter running	счетчик включен	adjective phrase	Is the meter running?	A2	audio/word_meter_running_0d36a697.mp3	ˈmitər ˈrənɪŋ	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
a7fa0010-d90c-487f-b2a5-55e9820ea1a4	how much will it cost?	сколько это будет стоить?	phrase	How much will it cost to get to the hotel?	A1	audio/word_how_much_1a6eedb9.mp3	haʊ məʧ wɪl ɪt kɔst?	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
7188f67d-51b3-4cba-b7ce-8ca08abfd2b1	it's too expensive	это слишком дорого	phrase	The fare is too expensive	A1	audio/word_it's_too_caa03c84.mp3	ɪts tu ɪkˈspɛnsɪv	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
787216c6-0b37-4205-9275-3fdd12c1cddd	it's a rip-off	это грабеж	phrase	That taxi fare is a rip-off!	B2	audio/word_it's_a_9b06fe21.mp3	ɪts ə rip-off*	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
3ebc9c64-655e-4c33-8c34-ca7ab7959c3d	bargain/negotiate the fare	торговаться о цене	verb phrase	I tried to bargain the fare down	B2		bargain/negotiate* ðə fɛr	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
590bcd0c-6f6a-4251-b47f-edef5a2ea99d	get in/out of the taxi	сесть/выйти из такси	verb phrase	Please get in the taxi	A1		gɪt in/out* əv ðə ˈtæksi	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
bdc49bde-a163-47d0-a4f5-f1a8c46e9882	where to?	куда?	phrase	Where to?	A1	audio/word_where_to?_6ed48651.mp3	wɛr tɪ?	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
f5d7ebe0-8bc3-4270-bb3a-9822028b8f80	airport code	код аэропорта	noun	What's the airport code?	A2	audio/word_airport_code_5b260084.mp3	ˈɛrˌpɔrt koʊd	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
281d9563-394b-4abb-a6be-f62ad5494959	terminal building	терминал	noun	Which terminal are you going to?	A2	audio/word_terminal_building_879e0275.mp3	ˈtərmənəl ˈbɪldɪŋ	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
49c49d9b-8b0f-44ca-9bc0-a7b06263527b	flight number	номер рейса	noun	What's your flight number?	A2	audio/word_flight_number_cb59d07e.mp3	flaɪt ˈnəmbər	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
f05c6648-5044-4640-a6d9-d4cd120cb3c9	drop me off here	высадите меня здесь	phrase	Please drop me off here	B1	audio/word_drop_me_3935ba0e.mp3	drɔp mi ɔf hir	adde6fc0-341a-4788-9e81-8b3c2e8df6ca
f5fc8f73-6d2b-4f98-a3cb-acb60ce10f1a	airport	аэропорт	noun	I'm going to the airport	A1	audio/word_airport_fc6b8994.mp3	ˈɛrˌpɔrt	b66ed7fd-27fd-4406-8382-d841e8144e7b
afb54cec-bb83-4999-a3ac-e5ad31acad01	flight	рейс	noun	What's your flight number?	A1	audio/word_flight_8c133779.mp3	flaɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
2367914b-2011-45d1-a93d-beec50f3f95d	terminal	терминал	noun	Which terminal is your flight from?	A1	audio/word_terminal_7d946fb8.mp3	ˈtərmənəl	b66ed7fd-27fd-4406-8382-d841e8144e7b
df3648b2-ddd1-48c2-a554-3a6ca49bf7dc	gate	ворота	noun	What gate is my flight?	A1	audio/word_gate_cdd8e616.mp3	geɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
2cab730f-b890-410b-84d7-6c569041d2fd	boarding	посадка	noun	Boarding is now commencing	A2	audio/word_boarding_5ec8d96f.mp3	ˈbɔrdɪŋ	b66ed7fd-27fd-4406-8382-d841e8144e7b
1ac136b3-a08e-4574-828c-f23ca8deff59	departure	вылет	noun	What time is the departure?	A2	audio/word_departure_344a0217.mp3	dɪˈpɑrʧər	b66ed7fd-27fd-4406-8382-d841e8144e7b
783f7f25-dee2-4ee6-b00d-fb479f53704b	arrival	прибытие	noun	What time is the arrival?	A2	audio/word_arrival_dba6eb50.mp3	ərˈaɪvəl	b66ed7fd-27fd-4406-8382-d841e8144e7b
c5a3e6d0-904a-4b8e-9216-c8e0c22dd5ad	baggage	багаж	noun	Where do I collect my baggage?	A2	audio/word_baggage_2ffba58d.mp3	ˈbægɪʤ	b66ed7fd-27fd-4406-8382-d841e8144e7b
179a6193-1dff-443d-ae94-bf91afa367f7	luggage	багаж	noun	Is this your luggage?	A2	audio/word_luggage_2ac1c90e.mp3	ˈləgɪʤ	b66ed7fd-27fd-4406-8382-d841e8144e7b
d2964840-b86f-42de-a1b7-a759426ec9f6	hand luggage	ручная кладь	noun	You can take this as hand luggage	A2	audio/word_hand_luggage_d61822f5.mp3	hænd ˈləgɪʤ	b66ed7fd-27fd-4406-8382-d841e8144e7b
be7f1efb-5839-47ea-add3-5fccab2f7021	check-in desk	стойка регистрации	noun	Go to the check-in desk	A2	audio/word_check-in_desk_650e2857.mp3	check-in* dɛsk	b66ed7fd-27fd-4406-8382-d841e8144e7b
c446f5e3-3c7a-40fd-8e8d-483cf9c0b047	security check	контроль безопасности	noun	We need to go through the security check	A2	audio/word_security_check_b522b044.mp3	sɪˈkjʊrəti ʧɛk	b66ed7fd-27fd-4406-8382-d841e8144e7b
4aedc931-3312-4cd9-b9fc-8ce360b556dc	passport control	паспортный контроль	noun	Passport control is over there	A2	audio/word_passport_control_9dfc9fd2.mp3	ˈpæˌspɔrt kənˈtroʊl	b66ed7fd-27fd-4406-8382-d841e8144e7b
9b01b186-9cef-4115-a191-099e1952ff85	customs	таможня	noun	Go through customs	A2	audio/word_customs_4333c4b1.mp3	ˈkəstəmz	b66ed7fd-27fd-4406-8382-d841e8144e7b
8c8ead2d-52a2-4bc7-84d9-d335afc2f4f1	delay	задержка	noun	The flight is delayed	B1	audio/word_delay_3caaa001.mp3	dɪˈleɪ	b66ed7fd-27fd-4406-8382-d841e8144e7b
dbf22049-e1b7-41e2-9a15-53ee57028e7e	missed connection	пропущенная стыковка	noun	I missed my connecting flight	B1	audio/word_missed_connection_be5c1730.mp3	mɪst kəˈnɛkʃən	b66ed7fd-27fd-4406-8382-d841e8144e7b
88b2dc2a-5278-418a-ac29-096117c3e6e3	get on/off	садиться/выходить	verb	Get on the bus	B1		gɪt on/off*	b66ed7fd-27fd-4406-8382-d841e8144e7b
01634846-ac28-4893-acc0-f46c425848d8	check in	регистрироваться	verb	I need to check in	A1	audio/word_check_in_4c90dd1a.mp3	ʧɛk ɪn	b66ed7fd-27fd-4406-8382-d841e8144e7b
a20c6866-3521-44e7-8103-c7b1d5c80f94	board	садиться	verb	We'll board soon	A2	audio/word_board_3a28f069.mp3	bɔrd	b66ed7fd-27fd-4406-8382-d841e8144e7b
f95a51cd-f63e-4f65-af45-ff9204294a6c	take off	взлетать	verb	The plane will take off soon	A2	audio/word_take_off_aa17d3ab.mp3	teɪk ɔf	b66ed7fd-27fd-4406-8382-d841e8144e7b
ab8669ad-fd41-4aef-847e-2886f56cb827	land	приземляться	verb	The plane is about to land	A2	audio/word_land_9938e79f.mp3	lænd	b66ed7fd-27fd-4406-8382-d841e8144e7b
6c977797-1576-4393-a801-4573f5508e3a	transfer	пересадка/пересаживаться	noun/verb	Do I need to transfer?	B1	audio/word_transfer_f91f5934.mp3	ˈtrænsfər	b66ed7fd-27fd-4406-8382-d841e8144e7b
73ff3df7-de98-4077-9eb4-c5450be720dd	public transport	общественный транспорт	noun	What's the best public transport?	B1	audio/word_public_transport_efa1b055.mp3	ˈpəblɪk ˈtrænspɔrt	b66ed7fd-27fd-4406-8382-d841e8144e7b
3155bc43-b665-49a7-9060-0dae1c1269c3	bus	автобус	noun	Take the bus to the airport	A1	audio/word_bus_860d2318.mp3	bəs	b66ed7fd-27fd-4406-8382-d841e8144e7b
b263576e-08c5-45c1-a02e-592a6d5c0448	taxi	такси	noun	Take a taxi	A1	audio/word_taxi_ff9b90dd.mp3	ˈtæksi	b66ed7fd-27fd-4406-8382-d841e8144e7b
60f76fed-7069-4ee8-aad7-91975bb3ac23	train	поезд	noun	Take the train	A1	audio/word_train_14a2dcf5.mp3	treɪn	b66ed7fd-27fd-4406-8382-d841e8144e7b
416da139-c74f-4950-afe0-db964bb14bfb	metro	метро	noun	Take the metro	A2	audio/word_metro_6ceaa72c.mp3	ˈmɛˌtroʊ	b66ed7fd-27fd-4406-8382-d841e8144e7b
708f1c16-9743-4edd-a5cc-e1995e5d73de	tram	трамвай	noun	Take the tram	A2	audio/word_tram_d44268ef.mp3	træm	b66ed7fd-27fd-4406-8382-d841e8144e7b
a3bd7cd4-d706-46cb-bc2b-9796362ab940	timetable	расписание	noun	Check the timetable	A2	audio/word_timetable_31b71ee3.mp3	ˈtaɪmˌteɪbəl	b66ed7fd-27fd-4406-8382-d841e8144e7b
97359cd1-ed27-4ca3-864a-e9440cba1a65	platform	платформа	noun	What platform is the train at?	A2	audio/word_platform_fc0dd802.mp3	ˈplætˌfɔrm	b66ed7fd-27fd-4406-8382-d841e8144e7b
22b02094-bdf2-477f-9156-0d445a82080a	ticket	билет	noun	I need a ticket	A1	audio/word_ticket_a5a9e70f.mp3	ˈtɪkɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
af339c50-093e-4011-bb30-fc87752a86d3	fare	плата за проезд	noun	How much is the fare?	A2	audio/word_fare_b2640ea3.mp3	fɛr	b66ed7fd-27fd-4406-8382-d841e8144e7b
558fe118-a725-4287-ade5-2d9c3efc118a	one-way ticket	билет в один конец	noun	I need a one-way ticket	A2	audio/word_one-way_ticket_b85d2d84.mp3	ˈwənˈweɪ ˈtɪkɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
19c19acb-8771-4317-b8a2-a0e9d3fc3c86	return ticket	билет в оба конца	noun	I need a return ticket	A2	audio/word_return_ticket_d7a5ea80.mp3	rɪˈtərn ˈtɪkɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
0cdc2ff1-5fd5-40fc-b550-e823f98acc75	buy a ticket	купить билет	verb	Can I buy a ticket here?	A2	audio/word_buy_a_8514c71a.mp3	baɪ ə ˈtɪkɪt	b66ed7fd-27fd-4406-8382-d841e8144e7b
89b38830-3c13-4dd5-bfff-106e53770444	get lost	заблудиться	verb	I'm afraid I might get lost	B1	audio/word_get_lost_14f16a4f.mp3	gɪt lɔst	b66ed7fd-27fd-4406-8382-d841e8144e7b
4a408c50-1a73-4192-9639-bc52e644c2d6	lost and found	бюро находок	noun	Go to lost and found	B1	audio/word_lost_and_654e9f35.mp3	lɔst ənd faʊnd	b66ed7fd-27fd-4406-8382-d841e8144e7b
76866ff4-8af0-4947-9754-a0b07dec2b1d	ask for help	попросить о помощи	verb	Don't hesitate to ask for help	B1	audio/word_ask_for_8b191e7f.mp3	æsk fər hɛlp	b66ed7fd-27fd-4406-8382-d841e8144e7b
fa79894f-2549-4316-aae1-93586fe64545	sorry	извините	interjection	Sorry, I don't understand	A1	audio/word_sorry_5ce1fee5.mp3	ˈsɑri	b66ed7fd-27fd-4406-8382-d841e8144e7b
4d164071-be0d-46a4-8085-e7f876c0feb6	thank you	спасибо	interjection	Thank you very much	A1	audio/word_thank_you_d03fcc6c.mp3	θæŋk ju	b66ed7fd-27fd-4406-8382-d841e8144e7b
d099e3ae-b46b-4ec9-b7a5-7f4c56c4ba02	please	пожалуйста	interjection	Please help me	A1	audio/word_please_bebd9030.mp3	pliz	b66ed7fd-27fd-4406-8382-d841e8144e7b
36096dfb-8484-4564-95b0-5ca3189a1b6e	help me	помогите мне	verb	Help me please	A1	audio/word_help_me_d5d0d12a.mp3	hɛlp mi	b66ed7fd-27fd-4406-8382-d841e8144e7b
11d24b9b-8f20-42e8-810b-7eb6573bf9f7	rental car	арендованный автомобиль	noun	I need to pick up my rental car	A2	audio/word_rental_car_c8600b75.mp3	ˈrɛntəl kɑr	1bc072b7-a10d-4e83-b567-e16f863829f2
725fb9f6-6169-483e-b96e-3624c2d54537	pick up	забрать	phrasal verb	I'll pick up the car at the airport	A2	audio/word_pick_up_ddf16a1a.mp3	pɪk əp	1bc072b7-a10d-4e83-b567-e16f863829f2
d0a8156b-60e4-47c5-96ad-558c36fbb978	drop off	отвезти, сдать	phrasal verb	Where do I drop off the car?	A2	audio/word_drop_off_8b4dcd65.mp3	drɔp ɔf	1bc072b7-a10d-4e83-b567-e16f863829f2
c9fd9563-6f0e-4418-8ead-3555ce69b79d	car hire	прокат автомобилей	noun	Car hire is expensive here	A2	audio/word_car_hire_ca66959d.mp3	kɑr haɪər	1bc072b7-a10d-4e83-b567-e16f863829f2
96a1be75-6131-41d9-b757-3f37fcd2cf18	rental agreement	договор аренды	noun	Sign the rental agreement carefully	B1	audio/word_rental_agreement_e770d0a5.mp3	ˈrɛntəl əˈgrimənt	1bc072b7-a10d-4e83-b567-e16f863829f2
69564b07-a89e-4f92-89e2-2adf1107eb52	insurance	страховка	noun	Do you have full insurance?	B1	audio/word_insurance_f907d920.mp3	ˌɪnˈʃʊrəns	1bc072b7-a10d-4e83-b567-e16f863829f2
77dbfc7c-207b-4150-adac-4a232360485c	driving licence	водительские права	noun	Show me your driving licence	B1	audio/word_driving_licence_64816d49.mp3	ˈdraɪvɪŋ ˈlaɪsəns	1bc072b7-a10d-4e83-b567-e16f863829f2
28bb0128-4c3e-4961-bab7-809a24216c75	credit card	кредитная карта	noun	I'll pay with my credit card	A2	audio/word_credit_card_e1214aa4.mp3	ˈkrɛdɪt kɑrd	1bc072b7-a10d-4e83-b567-e16f863829f2
a7b6fe22-c967-47aa-82e5-bca218667be9	debit card	дебетовая карта	noun	Can I pay with my debit card?	A2	audio/word_debit_card_6031423b.mp3	ˈdɛbɪt kɑrd	1bc072b7-a10d-4e83-b567-e16f863829f2
0b253b06-7d12-4f21-ae67-924c9a8c8bbc	to book	бронировать	verb	I booked a car online	A2	audio/word_to_book_cdc49446.mp3	tɪ bʊk	1bc072b7-a10d-4e83-b567-e16f863829f2
550999b1-8ca2-4707-8ee3-3c915acb04ae	confirmation	подтверждение	noun	Do you have your booking confirmation?	B1	audio/word_confirmation_53d8625d.mp3	ˌkɑnfərˈmeɪʃən	1bc072b7-a10d-4e83-b567-e16f863829f2
3b06aab2-fd8a-4e95-b17a-e44a061d46be	extra charges	дополнительные сборы	noun	Be aware of extra charges	B1	audio/word_extra_charges_3b5ed9c2.mp3	ˈɛkstrə ˈʧɑrʤɪz	1bc072b7-a10d-4e83-b567-e16f863829f2
8e2618c3-a3b9-438f-81d7-8cf6e73e1ad7	mileage	пробег	noun	Unlimited mileage is included	B1	audio/word_mileage_34313205.mp3	ˈmaɪlɪʤ	1bc072b7-a10d-4e83-b567-e16f863829f2
39f66452-0549-4790-bdf7-8a3a734cdc21	GPS navigation	GPS-навигация	noun	Does the car have GPS navigation?	B1	audio/word_gps_navigation_33c78dc9.mp3	ˈgipiˈɛs ˌnævəˈgeɪʃən	1bc072b7-a10d-4e83-b567-e16f863829f2
637915f6-18cc-40cd-b084-0297a70a2922	fuel	топливо	noun	Fill up the car with fuel	A2	audio/word_fuel_f88ac7c9.mp3	fjuəl	1bc072b7-a10d-4e83-b567-e16f863829f2
24ee990a-d231-4dbb-8aaa-040b1b99973c	full-to-empty	от полной до пустой	adjective	Return the car full-to-empty	B2	audio/word_full-to-empty_c6aa14c1.mp3	full-to-empty*	1bc072b7-a10d-4e83-b567-e16f863829f2
fcce6770-e120-4d4f-98ef-73c805ca3ca8	breakdown	поломака	noun	In case of a breakdown, call this number	B1	audio/word_breakdown_5f9eef15.mp3	ˈbreɪkˌdaʊn	1bc072b7-a10d-4e83-b567-e16f863829f2
849b49e1-3f4a-4630-b5fc-2fd98f4c0437	to fill up	заправлять	phrasal verb	I need to fill up the tank	A2	audio/word_to_fill_cfe22895.mp3	tɪ fɪl əp	1bc072b7-a10d-4e83-b567-e16f863829f2
195139e2-326a-4715-8b0d-a8f3502aad88	roadside assistance	помощь на дороге	noun	Roadside assistance is included	B1	audio/word_roadside_assistance_9340af16.mp3	ˈroʊdˌsaɪd əˈsɪstəns	1bc072b7-a10d-4e83-b567-e16f863829f2
7c5848c6-f6ea-4207-8378-0a35e1a27e9c	to get lost	заблудиться	verb	I'm afraid I'll get lost	A1	audio/word_to_get_52cc6de7.mp3	tɪ gɪt lɔst	1bc072b7-a10d-4e83-b567-e16f863829f2
976a1447-ae6a-4486-901b-e783a217166e	location	местоположение	noun	Can you tell me the location?	A2	audio/word_location_5bc2e65e.mp3	loʊˈkeɪʃən	1bc072b7-a10d-4e83-b567-e16f863829f2
ce67ba62-c09b-4879-94c4-064220a0e67e	directions	указания, направления	noun	Can you give me directions?	A2	audio/word_directions_da765152.mp3	dɪˈrɛkʃɪnz	1bc072b7-a10d-4e83-b567-e16f863829f2
42a7ccca-846b-4fa6-9549-f8f672f7fd0c	nearby	близлежащий	adjective	Is there a gas station nearby?	A2	audio/word_nearby_5de18d77.mp3	ˈnɪrˈbaɪ	1bc072b7-a10d-4e83-b567-e16f863829f2
65ff5f7d-827e-4502-b67d-e6096edbcb87	around here	вокруг здесь	phrase	Is there a rental car office around here?	A2	audio/word_around_here_0f0d7188.mp3	əraʊnd hir	1bc072b7-a10d-4e83-b567-e16f863829f2
dfeb4978-d057-4564-9740-daca88db05b1	ticket	билет	noun	I need a ticket to London	A1	audio/word_ticket_a05909ec.mp3	ˈtɪkɪt	fd370ee5-b869-4c70-a415-f73bd0158a67
83e7ff36-2edf-4b2f-82a0-a5c4c292665c	boarding pass	посадочный талон	noun	Show me your boarding pass	A1	audio/word_boarding_pass_0746ba53.mp3	ˈbɔrdɪŋ pæs	fd370ee5-b869-4c70-a415-f73bd0158a67
a97d4f35-15f1-48fd-8205-c2daee5eecff	flight	рейс	noun	What time is my flight?	A1	audio/word_flight_962e1815.mp3	flaɪt	fd370ee5-b869-4c70-a415-f73bd0158a67
458ac133-7fc9-47ce-bd8e-7bbadfb640d0	gate	ворота	noun	What gate is my flight?	A1	audio/word_gate_33e54160.mp3	geɪt	fd370ee5-b869-4c70-a415-f73bd0158a67
618196d4-c5dd-4c88-bd5f-15fd3554fde7	departure	вылет	noun	What is the departure time?	A1	audio/word_departure_9cf9b8f2.mp3	dɪˈpɑrʧər	fd370ee5-b869-4c70-a415-f73bd0158a67
dfdbf764-93ee-4638-9052-23289ecef997	arrival	прибытие	noun	What time is the arrival?	A1	audio/word_arrival_569f2ad1.mp3	ərˈaɪvəl	fd370ee5-b869-4c70-a415-f73bd0158a67
a36be055-5335-4291-a63a-d05ce2d1c43d	delay	задержка	noun	The flight is delayed	A1	audio/word_delay_548e986c.mp3	dɪˈleɪ	fd370ee5-b869-4c70-a415-f73bd0158a67
8333ba67-c2b4-4a36-a1bc-61fb94353af3	cancel	отменять	verb	They cancelled my flight	A1	audio/word_cancel_10eb21d7.mp3	ˈkænsəl	fd370ee5-b869-4c70-a415-f73bd0158a67
4e7df774-2e43-4bfc-9c63-98d7d3391d1a	book	бронировать	verb	I booked my ticket online	A1	audio/word_book_d28b6481.mp3	bʊk	fd370ee5-b869-4c70-a415-f73bd0158a67
17fdbb12-0600-4e37-bfb5-344cb3805a8f	check in	регистрироваться	verb	I need to check in	A1	audio/word_check_in_bacea246.mp3	ʧɛk ɪn	fd370ee5-b869-4c70-a415-f73bd0158a67
8ce025d0-c657-4ccf-ac1a-b5c86ddfffba	baggage	багаж	noun	Where do I check my baggage?	A1	audio/word_baggage_471b8b57.mp3	ˈbægɪʤ	fd370ee5-b869-4c70-a415-f73bd0158a67
4aaa924f-ae9d-448e-a1a1-ab3e262e5b8b	hand luggage	ручная кладь	noun	This is my hand luggage	A1	audio/word_hand_luggage_840e5242.mp3	hænd ˈləgɪʤ	fd370ee5-b869-4c70-a415-f73bd0158a67
f3ab30c4-6046-4d3e-aeb8-920a602dc657	carry-on	ручная кладь	noun	Is this allowed as carry-on?	A1	audio/word_carry-on_0614db85.mp3	carry-on*	fd370ee5-b869-4c70-a415-f73bd0158a67
453851f6-602f-4d3a-aef5-be41f5ba0112	passport	паспорт	noun	Show me your passport	A1	audio/word_passport_df71ca5e.mp3	ˈpæˌspɔrt	fd370ee5-b869-4c70-a415-f73bd0158a67
c5111eb5-9414-43c9-8504-c2b1bdfd85b8	customs	таможня	noun	Go through customs	A1	audio/word_customs_cc74f6f1.mp3	ˈkəstəmz	fd370ee5-b869-4c70-a415-f73bd0158a67
f809fdec-e67f-445a-bd86-eb26e6886b18	security	контроль безопасности	noun	Go through security	A1	audio/word_security_cfaf315f.mp3	sɪˈkjʊrəti	fd370ee5-b869-4c70-a415-f73bd0158a67
478654fe-dbc7-402c-8223-c61bf8f821b2	immigration	миграционная служба	noun	Go to immigration	A1	audio/word_immigration_57f28eaa.mp3	ˌɪməˈgreɪʃən	fd370ee5-b869-4c70-a415-f73bd0158a67
6c2fa8c1-78eb-40dd-ab58-228769d95628	seat	место	noun	What's my seat number?	A1	audio/word_seat_75f50f95.mp3	sit	fd370ee5-b869-4c70-a415-f73bd0158a67
a45eef93-c057-46ae-99cb-00ecfcfbe25d	one-way	в один конец	adjective	I need a one-way ticket	A2	audio/word_one-way_fbd21e44.mp3	ˈwənˈweɪ	fd370ee5-b869-4c70-a415-f73bd0158a67
8ae31896-be2b-45f5-90ca-326788855c74	round-trip	туда и обратно	adjective	I need a round-trip ticket	A2	audio/word_round-trip_94289c79.mp3	round-trip*	fd370ee5-b869-4c70-a415-f73bd0158a67
efe9bfc6-7c3c-4a52-8bdb-fd7fb9923e74	confirm	подтверждать	verb	Can you confirm my booking?	A2	audio/word_confirm_cf93ad37.mp3	kənˈfərm	fd370ee5-b869-4c70-a415-f73bd0158a67
45cf68d2-2b1b-4ad1-b023-a467792db198	rebook	перебронировать	verb	I need to rebook my flight	A2	audio/word_rebook_af409499.mp3	riˈbʊk	fd370ee5-b869-4c70-a415-f73bd0158a67
4cec8021-69fb-4561-99f0-c13746cec92e	get through	проходить	phrasal verb	I need to get through security	A2	audio/word_get_through_2eae93c3.mp3	gɪt θru	fd370ee5-b869-4c70-a415-f73bd0158a67
52298bbd-73f9-4016-9073-9d051eacf325	look up	искать информацию	phrasal verb	Let me look up your booking	A2	audio/word_look_up_e667943f.mp3	lʊk əp	fd370ee5-b869-4c70-a415-f73bd0158a67
86eebb6b-bdda-4499-90e1-e1b7ad92e9ea	take off	взлетать	phrasal verb	The plane is about to take off	A2	audio/word_take_off_1757807f.mp3	teɪk ɔf	fd370ee5-b869-4c70-a415-f73bd0158a67
8bf50f04-2a94-4a8e-a1bf-69922667ac8c	land	приземляться	verb	The plane is landing soon	A2	audio/word_land_31468765.mp3	lænd	fd370ee5-b869-4c70-a415-f73bd0158a67
31ec4ca1-d48e-4669-a462-56735b873008	transfer	пересадка	noun	I have a transfer in Dubai	A2	audio/word_transfer_b7feb1c1.mp3	ˈtrænsfər	fd370ee5-b869-4c70-a415-f73bd0158a67
7b7c54bc-cc1e-4017-9297-35d34002058d	connecting flight	стыковочный рейс	noun	What's my connecting flight?	A2	audio/word_connecting_flight_c16f90f6.mp3	kəˈnɛktɪŋ flaɪt	fd370ee5-b869-4c70-a415-f73bd0158a67
2fcb044d-ccad-462f-a733-f57e46b4928e	flight number	номер рейса	noun	What's the flight number?	A2	audio/word_flight_number_1e8db37b.mp3	flaɪt ˈnəmbər	fd370ee5-b869-4c70-a415-f73bd0158a67
f30b2019-dec1-47ad-bc56-58587b36d26d	baggage claim	выдача багажа	noun	Where is baggage claim?	A2	audio/word_baggage_claim_31f51d2d.mp3	ˈbægɪʤ kleɪm	fd370ee5-b869-4c70-a415-f73bd0158a67
2c3a44de-c56c-445a-99da-f10337c83186	lost luggage	утерянный багаж	noun	I have lost luggage	A2	audio/word_lost_luggage_e883bec2.mp3	lɔst ˈləgɪʤ	fd370ee5-b869-4c70-a415-f73bd0158a67
e3cf871c-eac2-4e3e-9021-f8f9d5b6eab6	on time	вовремя	adjective	The flight is on time	A2	audio/word_on_time_a078d78e.mp3	ɔn taɪm	fd370ee5-b869-4c70-a415-f73bd0158a67
502591fa-86ff-45e6-8dd9-6d1ac0a1d6af	delayed	задержанный	adjective	The flight is delayed	A2	audio/word_delayed_2a2b4a0c.mp3	dɪˈleɪd	fd370ee5-b869-4c70-a415-f73bd0158a67
ab1d055e-55d3-4a2f-b33e-0726a23a584c	overbooked	перебронированный	adjective	The flight is overbooked	A2	audio/word_overbooked_8b97d20a.mp3	ˈoʊvərˌbʊkt	fd370ee5-b869-4c70-a415-f73bd0158a67
96fd680a-247c-4d51-b41c-fd083a3e6d6f	excess baggage	сверхнормативный багаж	noun	I have excess baggage	A2	audio/word_excess_baggage_2facd61a.mp3	ˈɛkˌsɛs ˈbægɪʤ	fd370ee5-b869-4c70-a415-f73bd0158a67
2643431d-4df3-458a-9bf2-a4e306bfdeb4	duty-free	duty-free	noun	Let's go to duty-free	A2	audio/word_duty-free_14cb1a9f.mp3	duty-free*	fd370ee5-b869-4c70-a415-f73bd0158a67
4d2a19b7-9bb5-4614-a49d-3f38c77f81f9	online check-in	онлайн регистрация	noun	I did online check-in	B1	audio/word_online_check-in_c0e56df9.mp3	ˈɔnˌlaɪn check-in*	fd370ee5-b869-4c70-a415-f73bd0158a67
587f5df9-0789-4240-ad32-452229163f2e	self-service kiosk	киоск самообслуживания	noun	I'll use a self-service kiosk	B1	audio/word_self-service_kiosk_17aaa08c.mp3	self-service* kiɔsk	fd370ee5-b869-4c70-a415-f73bd0158a67
1f7185dc-2ee6-49c0-805b-60fa5d523274	hotel	отель	noun	I booked a hotel near the airport.	A1	audio/word_hotel_d966e284.mp3	hoʊˈtɛl	35380b89-1706-4c35-8445-bb3ab74653e8
66abf68c-51d2-4e9a-8e75-3e9c8b9251ed	room	комната	noun	We need a room for two.	A1	audio/word_room_e0d8d2b1.mp3	rum	35380b89-1706-4c35-8445-bb3ab74653e8
5439bc17-cc18-4a1d-8d6b-9ae57cc0af6c	booking	бронирование	noun	My booking is confirmed.	A1	audio/word_booking_43517d35.mp3	ˈbʊkɪŋ	35380b89-1706-4c35-8445-bb3ab74653e8
527d01c0-dacc-4eff-9e04-214abe10eb1e	reserve	бронировать	verb	I'd like to reserve a single room.	A1	audio/word_reserve_298305e4.mp3	rɪˈzərv	35380b89-1706-4c35-8445-bb3ab74653e8
a9b0aaac-2cd8-4841-b23c-901083dfb183	make a reservation	сделать бронирование	verb phrase	Let's make a reservation for tonight.	A2	audio/word_make_a_836f877b.mp3	meɪk ə ˌrɛzərˈveɪʃən	35380b89-1706-4c35-8445-bb3ab74653e8
02ef61e9-cea9-40d9-8fe3-233ecdfc463b	book a room	забронировать номер	verb phrase	I've already booked a room.	A2	audio/word_book_a_7a9a27a8.mp3	bʊk ə rum	35380b89-1706-4c35-8445-bb3ab74653e8
d6d43230-e82c-4f9a-83bc-39eab9395f1f	confirm booking	подтвердить бронирование	verb phrase	Please confirm my booking.	B1	audio/word_confirm_booking_15f37bf2.mp3	kənˈfərm ˈbʊkɪŋ	35380b89-1706-4c35-8445-bb3ab74653e8
bf7b12e8-973a-4c8f-ac94-00ec1c519ca6	check availability	проверить наличие мест	verb phrase	Could you check availability for next week?	B1	audio/word_check_availability_c62647b8.mp3	ʧɛk əˌveɪləˈbɪlɪti	35380b89-1706-4c35-8445-bb3ab74653e8
d6f53d70-92a5-42fa-bf79-e0751275175a	cancel a reservation	отменить бронирование	verb phrase	I need to cancel my reservation.	B1	audio/word_cancel_a_a1063d49.mp3	ˈkænsəl ə ˌrɛzərˈveɪʃən	35380b89-1706-4c35-8445-bb3ab74653e8
61ea78f8-9804-45c8-aaba-128718635f21	single room	одноместный номер	noun phrase	I need a single room.	A1	audio/word_single_room_a7bf091c.mp3	ˈsɪŋgəl rum	35380b89-1706-4c35-8445-bb3ab74653e8
6d2835c3-8b0c-40c5-a5fa-17c7f1ca2211	double room	двухместный номер	noun phrase	We need a double room.	A1	audio/word_double_room_491aeed4.mp3	ˈdəbəl rum	35380b89-1706-4c35-8445-bb3ab74653e8
bf18dc4d-956f-490c-a56d-975016604f1a	twin room	номер с двумя односпальными кроватями	noun phrase	We prefer a twin room.	A2	audio/word_twin_room_3ded5a29.mp3	twɪn rum	35380b89-1706-4c35-8445-bb3ab74653e8
2d45ac97-6a17-4e26-a498-cfe878a5c2fa	suite	люкс	noun	They stayed in a luxury suite.	B1	audio/word_suite_c1d4db12.mp3	swit	35380b89-1706-4c35-8445-bb3ab74653e8
13a24f41-afee-4a70-9a40-257997d9d766	rate	тариф	noun	What's the nightly rate?	A2	audio/word_rate_98315778.mp3	reɪt	35380b89-1706-4c35-8445-bb3ab74653e8
cb39782c-c93e-49a9-b2c7-0425088e337c	price	цена	noun	What's the price?	A1	audio/word_price_668f0c02.mp3	praɪs	35380b89-1706-4c35-8445-bb3ab74653e8
3c05e570-03a9-4c17-924d-95ffc7a69cd9	non-refundable	невозвращаемый	adjective	The booking is non-refundable.	B2	audio/word_non-refundable_9b2faeee.mp3	nɑnrɪˈfəndəbəl	35380b89-1706-4c35-8445-bb3ab74653e8
6ef0aab8-ca9e-4d59-ab4b-dd0b8027ce59	free cancellation	бесплатная отмена	noun phrase	This booking offers free cancellation.	B2	audio/word_free_cancellation_cd65b49c.mp3	fri ˌkænsəˈleɪʃən	35380b89-1706-4c35-8445-bb3ab74653e8
6e7aebf0-dacd-4a29-92b2-866967be687f	look for	искать	verb phrase	I'm looking for a cheap hotel.	A2	audio/word_look_for_c5c697d1.mp3	lʊk fər	35380b89-1706-4c35-8445-bb3ab74653e8
3d5d854e-5e2e-4f35-8557-69406e9899c0	search for	искать	verb phrase	I'm searching for a hotel online.	B1	audio/word_search_for_30126274.mp3	sərʧ fər	35380b89-1706-4c35-8445-bb3ab74653e8
8f89a4d8-bb76-4d14-9259-e00b9c1c6df2	best price	лучшая цена	noun phrase	I want to find the best price.	B1	audio/word_best_price_9bf36017.mp3	bɛst praɪs	35380b89-1706-4c35-8445-bb3ab74653e8
2e4371f4-af53-407d-8359-9b1249ccb402	in advance	заранее	adverb	Book in advance to get a better price.	A2	audio/word_in_advance_77266d4b.mp3	ɪn ədˈvæns	35380b89-1706-4c35-8445-bb3ab74653e8
803e5880-892a-4e6d-a970-6114c8c93014	online booking	онлайн-бронирование	noun phrase	I prefer online booking.	B1	audio/word_online_booking_aec2d798.mp3	ˈɔnˌlaɪn ˈbʊkɪŋ	35380b89-1706-4c35-8445-bb3ab74653e8
8a16c8a8-adbe-4615-9972-f03ac73e0293	payment	плата	noun	What payment methods do you accept?	A2	audio/word_payment_1c457196.mp3	ˈpeɪmənt	35380b89-1706-4c35-8445-bb3ab74653e8
c34149af-c0f3-4d5c-b35e-991465239efa	credit card	кредитная карта	noun phrase	I'll pay by credit card.	A2	audio/word_credit_card_4aaf9ba1.mp3	ˈkrɛdɪt kɑrd	35380b89-1706-4c35-8445-bb3ab74653e8
d7a1b645-7ba8-4c33-9277-865b12e9f882	receptionist	администратор	noun	The receptionist was very helpful.	A2	audio/word_receptionist_04cfe73c.mp3	rɪˈsɛpʃənɪst	01fda5a0-9551-4b80-a795-51694c63e1be
879163c5-cd91-4313-9dad-4b2a2a98f038	hotel	гостиница	noun	I booked a room at a hotel near the airport.	A1	audio/word_hotel_f0f47739.mp3	hoʊˈtɛl	01fda5a0-9551-4b80-a795-51694c63e1be
1a804bb7-faee-4fcf-82fd-a3090dce93f9	check-in	регистрация	noun	Check-in is at 2 pm.	A1	audio/word_check-in_c74de121.mp3	check-in*	01fda5a0-9551-4b80-a795-51694c63e1be
c96122d2-7b9d-463f-99b2-f151da24351c	check-out	выписка	noun	Check-out time is 11 am.	A1	audio/word_check-out_6f1ce051.mp3	check-out*	01fda5a0-9551-4b80-a795-51694c63e1be
924722d4-b6ee-4d82-877c-69c3d9beb2cd	room key	ключ от номера	noun	Here's your room key.	A1	audio/word_room_key_72af52f6.mp3	rum ki	01fda5a0-9551-4b80-a795-51694c63e1be
0c940e44-25f2-4f5e-a361-d1086fb5801e	reservation	бронь	noun	I have a reservation under the name Smith.	A2	audio/word_reservation_a76c27d1.mp3	ˌrɛzərˈveɪʃən	01fda5a0-9551-4b80-a795-51694c63e1be
ed1d9a1a-1767-410f-bcaf-ed2a49de0afa	confirm	подтверждать	verb	Can you confirm my reservation?	A2	audio/word_confirm_29f80270.mp3	kənˈfərm	01fda5a0-9551-4b80-a795-51694c63e1be
c46150e2-8bcd-4946-a7ef-204be999f367	request	просить	verb	I'd like to request a wake-up call.	A2	audio/word_request_d7ba5c68.mp3	rɪkˈwɛst	01fda5a0-9551-4b80-a795-51694c63e1be
48ff79ef-fc56-4951-92fc-3c1b4a1f5437	extra bed	дополнительная кровать	noun	Could we have an extra bed in the room?	B1	audio/word_extra_bed_f4d0afe6.mp3	ˈɛkstrə bɛd	01fda5a0-9551-4b80-a795-51694c63e1be
91b84348-bb8a-4f95-ae56-653dd458cddd	luggage	багаж	noun	Leave your luggage here.	A1	audio/word_luggage_064f8a24.mp3	ˈləgɪʤ	01fda5a0-9551-4b80-a795-51694c63e1be
7a1fe2c6-4a7c-4591-b768-c5a4935c2d09	porter	носильщик	noun	The porter will help you with your luggage.	B1	audio/word_porter_7daf9564.mp3	ˈpɔrtər	01fda5a0-9551-4b80-a795-51694c63e1be
950d46c9-d471-46c8-9a2e-2f05013a05d5	bellhop	носильщик	noun	A bellhop took my bags to my room.	B1	audio/word_bellhop_725e11a9.mp3	ˈbɛˌlhɑp	01fda5a0-9551-4b80-a795-51694c63e1be
1cb5cb97-3715-4665-902b-cb8ad6fe82cf	room service	обслуживание в номерах	noun	I'd like to order room service.	B1	audio/word_room_service_e0e35bcb.mp3	rum ˈsərvɪs	01fda5a0-9551-4b80-a795-51694c63e1be
e95009f3-02c2-4634-959e-d55d8fee10b6	complaint	жалоба	noun	I have a complaint about the room.	B2	audio/word_complaint_d7567b54.mp3	kəmˈpleɪnt	01fda5a0-9551-4b80-a795-51694c63e1be
c84cdffb-e8fb-4da4-bc2b-e3dfa577565b	wifi	вай-фай	noun	Is there wifi in the hotel?	A2	audio/word_wifi_c57f6224.mp3	ˈwiˌfi	01fda5a0-9551-4b80-a795-51694c63e1be
bac24924-54f2-4dfc-8201-8fa6d18ffd89	single room	одноместный номер	noun	I need a single room.	A2	audio/word_single_room_f3c807ef.mp3	ˈsɪŋgəl rum	01fda5a0-9551-4b80-a795-51694c63e1be
4ae087ee-e5ea-487f-bd23-e5d4006d48c7	double room	двухместный номер	noun	We need a double room.	A2	audio/word_double_room_1249af34.mp3	ˈdəbəl rum	01fda5a0-9551-4b80-a795-51694c63e1be
c84ed8ff-62a9-4dff-b33b-b6a338922187	twin room	номер с двумя односпальными кроватями	noun	We'd prefer a twin room.	B1	audio/word_twin_room_cd441ba4.mp3	twɪn rum	01fda5a0-9551-4b80-a795-51694c63e1be
f4f8ce2f-0e80-419b-9e0e-ffbd40e93336	triple room	номер на троих	noun	We need a triple room.	B1	audio/word_triple_room_0c6f0c3a.mp3	ˈtrɪpəl rum	01fda5a0-9551-4b80-a795-51694c63e1be
c208d4ab-1149-47db-bf87-06fd59d8764c	suite	люкс	noun	They booked a suite.	B2	audio/word_suite_2d82f45d.mp3	swit	01fda5a0-9551-4b80-a795-51694c63e1be
45139954-2ff1-4d8d-9ae3-3d2f492726c9	upgrade	апгрейд	noun	Is there any possibility of a room upgrade?	B1	audio/word_upgrade_5a6c69a2.mp3	ˈəpˈgreɪd	01fda5a0-9551-4b80-a795-51694c63e1be
eeb86c69-7596-4bf3-a277-aa0fa90e8b99	amenities	удобства	noun	What are the hotel amenities?	B2	audio/word_amenities_5e2d6cbe.mp3	əˈmɛnətiz	01fda5a0-9551-4b80-a795-51694c63e1be
5834fe69-65e7-43f4-84eb-13537cb8d89c	facilities	удобства	noun	What facilities does the hotel offer?	B2	audio/word_facilities_c866b6ea.mp3	fəˈsɪlɪtiz	01fda5a0-9551-4b80-a795-51694c63e1be
3696176b-eebf-40ff-b71a-5c4971472d72	front desk	стойка регистрации	noun	Go to the front desk to check in.	A2	audio/word_front_desk_a6313f33.mp3	frənt dɛsk	01fda5a0-9551-4b80-a795-51694c63e1be
fb76bbe1-886a-4365-945f-1f725aa8126c	look after	присматривать за	verb	Could you look after my luggage for a moment?	B1	audio/word_look_after_c196ae42.mp3	lʊk ˈæftər	01fda5a0-9551-4b80-a795-51694c63e1be
92f4dfb0-2e63-41c9-855f-ff399e82fa9b	hold on	подождите	verb	Hold on, I'll check.	A2	audio/word_hold_on_c75b4c78.mp3	hoʊld ɔn	01fda5a0-9551-4b80-a795-51694c63e1be
b73375ed-ddfb-4295-9d71-3a732c559f8a	fill in	заполнять	verb	Please fill in this form.	B1	audio/word_fill_in_6b8e7ce2.mp3	fɪl ɪn	01fda5a0-9551-4b80-a795-51694c63e1be
a6140ef4-bab4-455b-a2e8-2bf7100e8442	hand in	сдать	verb	Hand in your key at check-out.	B1	audio/word_hand_in_7ff83c6e.mp3	hænd ɪn	01fda5a0-9551-4b80-a795-51694c63e1be
5cfb96f6-ea07-4a39-8c43-e090308b45f4	sort out	решать	verb	We need to sort out the problem with the room.	B2	audio/word_sort_out_f8318f53.mp3	sɔrt aʊt	01fda5a0-9551-4b80-a795-51694c63e1be
0eb9551b-e63f-4764-9982-ca8346c90c02	find out	узнавать	verb	I need to find out about the airport shuttle.	B1	audio/word_find_out_ed00738d.mp3	faɪnd aʊt	01fda5a0-9551-4b80-a795-51694c63e1be
8bc6e00c-a61f-4bb4-b766-33e4c46af64d	figure out	разбираться	verb	Can you figure out how to use the TV?	B2	audio/word_figure_out_33c2c345.mp3	ˈfɪgjər aʊt	01fda5a0-9551-4b80-a795-51694c63e1be
f3b5fe4b-c779-49d2-a295-558d9e6885e0	take care of	заботиться	verb	Someone will take care of your bags.	B1	audio/word_take_care_b51baa13.mp3	teɪk kɛr əv	01fda5a0-9551-4b80-a795-51694c63e1be
843e46bc-6d18-4bd1-92c0-07b6badc9534	get in touch	связываться	verb	Please get in touch if you have any problems.	B1	audio/word_get_in_f163f6c6.mp3	gɪt ɪn təʧ	01fda5a0-9551-4b80-a795-51694c63e1be
9206e9af-d2d1-4403-accc-bcedd2a4c17c	go ahead	продолжайте	verb	Go ahead and check in.	A2	audio/word_go_ahead_96bb34b0.mp3	goʊ əˈhɛd	01fda5a0-9551-4b80-a795-51694c63e1be
87fd0b4d-032f-436c-b9ba-dd1ea3c6ceb1	I'm afraid	боюсь	expression	I'm afraid the room is not available.	A2	audio/word_i'm_afraid_2cc672f0.mp3	əm əˈfreɪd	01fda5a0-9551-4b80-a795-51694c63e1be
789a44ed-c43b-4ada-9ba9-d6d6e5d9783f	excuse me	извините	expression	Excuse me, is this the way to the reception?	A1	audio/word_excuse_me_d986b4da.mp3	ɪkˈskjuz mi	01fda5a0-9551-4b80-a795-51694c63e1be
77182d62-064a-42fc-a266-395f6b3a7aec	thank you	спасибо	expression	Thank you very much.	A1	audio/word_thank_you_69a52e70.mp3	θæŋk ju	01fda5a0-9551-4b80-a795-51694c63e1be
92ceea79-5958-4930-ade7-50fb839d46c6	you're welcome	пожалуйста	expression	You're welcome.	A1	audio/word_you're_welcome_459fb3cf.mp3	jʊr ˈwɛlkəm	01fda5a0-9551-4b80-a795-51694c63e1be
1904800d-f66f-48cc-9b43-84e11cb32719	no problem	нет проблем	expression	No problem.	A2	audio/word_no_problem_e7ad36f0.mp3	noʊ ˈprɑbləm	01fda5a0-9551-4b80-a795-51694c63e1be
eed75359-f04a-41eb-851c-187f22e1ec9b	certainly	конечно	adverb	Certainly, I'll help you.	A2	audio/word_certainly_db09a941.mp3	ˈsərtənli	01fda5a0-9551-4b80-a795-51694c63e1be
bb862046-f162-4360-9297-88e1f2ee2135	absolutely	абсолютно	adverb	Absolutely, I can do that.	B1	audio/word_absolutely_461c938b.mp3	ˌæbsəˈlutli	01fda5a0-9551-4b80-a795-51694c63e1be
9389d79a-f9a1-42be-81f4-aa3a5e67a7a9	definitely	точно	adverb	Definitely, let me assist you.	B1	audio/word_definitely_a53812b1.mp3	ˈdɛfənətli	01fda5a0-9551-4b80-a795-51694c63e1be
e4d771e5-e6c8-4986-bea8-ab6c2e45969d	room	комната	noun	I need a room with a view.	A1	audio/word_room_1300b355.mp3	rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
3ba36ed0-38f1-4062-b253-b1def6a10e55	single room	одноместный номер	noun	I booked a single room.	A1	audio/word_single_room_c9cb82ec.mp3	ˈsɪŋgəl rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
3c2e04ab-89fd-4bd2-a3dd-3844f167f634	double room	двухместный номер	noun	We need a double room.	A1	audio/word_double_room_fe0830c8.mp3	ˈdəbəl rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
20d891e5-1f28-4f3b-a12a-9376072f3ecf	king-size bed	кровать размера "king-size"	noun	We requested a room with a king-size bed.	A2	audio/word_king-size_bed_49a9e388.mp3	king-size* bɛd	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
e2aa4868-9f97-4457-bccc-eba695c7887f	twin beds	две односпальные кровати	noun	The room has twin beds.	A2	audio/word_twin_beds_5768a446.mp3	twɪn bɛdz	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
5258f3eb-21fa-40ac-8cd6-d7b299f1eba3	extra bed	дополнительная кровать	noun	Can we get an extra bed for our child?	A2	audio/word_extra_bed_6fccb11d.mp3	ˈɛkstrə bɛd	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
9d3938a8-c45e-462a-92b4-8941e03ed74b	non-smoking room	номер для некурящих	noun	I need a non-smoking room.	A2	audio/word_non-smoking_room_3b0288be.mp3	ˈnɑnsˈmoʊkɪŋ rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
ea2d5cd7-712b-4948-bab7-73a5a77a1793	high floor	высокий этаж	noun	I'd prefer a room on a high floor.	A2	audio/word_high_floor_215aabe9.mp3	haɪ flɔr	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
6154bc03-2492-40cf-9d11-38bcae613f76	quiet room	тихий номер	noun	Could we have a quiet room, please?	A2	audio/word_quiet_room_2175a386.mp3	kwaɪət rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
94182a2c-9c71-4e32-b913-c13c6ec1d823	view	вид	noun	What's the view from the room?	A2	audio/word_view_58736c90.mp3	vju	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
04a3f1f1-02fe-41f7-8321-043943a296d9	request	запрос	verb	I'd like to make a room request.	A2	audio/word_request_b8fe775b.mp3	rɪkˈwɛst	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
4e00f932-2a05-4499-8364-dfe9cb52118b	confirm	подтверждать	verb	Can you confirm my room request?	B1	audio/word_confirm_bd09b38d.mp3	kənˈfərm	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
a5e69a7e-9eb6-4780-8c2a-935d606a5faf	check	проверять	verb	Could you check the room availability?	B1	audio/word_check_73dc0ca3.mp3	ʧɛk	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
0b0f69b0-5e9e-4cab-a8f6-47f1e354a1d8	book	бронировать	verb	I've already booked the room.	B1	audio/word_book_a2dfcd9f.mp3	bʊk	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
c649c215-abd6-490a-b8a5-d9258bf6a4b8	amenities	удобства	noun	What amenities does the room have?	B1	audio/word_amenities_716b7713.mp3	əˈmɛnətiz	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
85a3604f-29c0-4731-8fc3-e3acf2542ceb	accessible room	номер для людей с ограниченными возможностями	noun	We need an accessible room.	B1	audio/word_accessible_room_dc27e330.mp3	ækˈsɛsəbəl rum	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
442fe4b6-a3b3-4216-9ac6-259b04e2a327	preference	предпочтение	noun	I have a preference for a room with a balcony.	B2	audio/word_preference_9c4a9804.mp3	ˈprɛfərəns	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
2b2f899e-f0e2-4ade-8d3a-6ff5ef6e712a	upgrade	обновление	noun	Is a room upgrade possible?	B2	audio/word_upgrade_de3774ed.mp3	ˈəpˈgreɪd	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
75f3589c-02c5-42b9-b668-8af715965644	availability	наличие	noun	What's the room availability?	B2	audio/word_availability_98c017c7.mp3	əˌveɪləˈbɪlɪti	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
fa727e0a-d989-4be0-a137-413221dfc3df	specific request	специфический запрос	noun	I have a specific room request.	B2	audio/word_specific_request_0864053d.mp3	spɪˈsɪfɪk rɪkˈwɛst	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
2786f209-adbb-48c2-a2f4-f28971caea01	look into	рассмотреть	phrasal verb	We'll look into your room request.	B2	audio/word_look_into_3205f6a8.mp3	lʊk ˈɪntu	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
bafab221-03aa-48ba-a7a6-7dabf6793c78	sort out	разбираться	phrasal verb	We'll sort out your room request.	B2	audio/word_sort_out_0047a55f.mp3	sɔrt aʊt	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
8b88af60-955d-44f5-97e9-9e97ad9a9a6d	deal with	решать	phrasal verb	They'll deal with your room request.	B2	audio/word_deal_with_77434ac1.mp3	dil wɪθ	64bf03f3-eb8b-4b27-a87d-aa3b527738e1
26e8d9c9-05e0-48df-ad2e-b8e4520a8864	complaint	жалоба	noun	I have a complaint about my room.	A2	audio/word_complaint_84277c78.mp3	kəmˈpleɪnt	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
e3fbc1c9-16b9-4ebe-9022-9aa80ee68174	noisy	шумный	adjective	The room was too noisy.	A1	audio/word_noisy_37b7e73b.mp3	ˈnɔɪzi	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
2a531afb-97ba-4890-bed6-93f1062d299a	dirty	грязный	adjective	The bathroom was dirty.	A1	audio/word_dirty_62a000c6.mp3	ˈdərti	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
99d9e25e-8072-4fbc-93f0-c57e28650650	uncomfortable	неудобный	adjective	The bed was uncomfortable.	A2	audio/word_uncomfortable_6ebe0bf5.mp3	ənˈkəmfərtəbəl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
67e2a551-8b32-484c-826e-cbe5e21e887b	broken	сломанный	adjective	The air conditioning was broken.	A1	audio/word_broken_8cda40c7.mp3	ˈbroʊkən	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
523ffd3c-10c2-4ecd-bbea-f041640a84b4	filthy	грязный (очень)	adjective	The sheets were filthy.	B1	audio/word_filthy_0d13cdf2.mp3	ˈfɪlθi	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
4e8ff706-ddcf-4aff-9f2d-e05717e42813	faulty	неисправный	adjective	The toilet was faulty.	B1	audio/word_faulty_89157902.mp3	ˈfɔlti	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
5a108fec-e149-4323-aa87-32126cdbe5b7	sort out	решить	verb	Can you sort out this problem?	B1	audio/word_sort_out_18ceeece.mp3	sɔrt aʊt	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
2ea3d65a-4250-4d46-aa15-8b49a40caf9b	deal with	разобраться с	verb	I want to deal with this complaint.	B1	audio/word_deal_with_84af2737.mp3	dil wɪθ	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
3dbc49b9-7632-45c0-ba52-c5b42056341f	get in touch	связаться	verb	Please get in touch with reception.	B1	audio/word_get_in_b6ce20df.mp3	gɪt ɪn təʧ	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
875b756d-339c-4cf7-9dae-f7d47127a647	call	звонить	verb	Call the hotel manager.	A1	audio/word_call_241a1819.mp3	kɔl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
1c435b12-04f9-4b79-babc-496d206d3317	reception	ресепшен	noun	Go to reception and complain.	A2	audio/word_reception_0a9f9b35.mp3	rɪˈsɛpʃən	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
4e1b5182-e94a-4edf-9e62-7a86014da0a5	manager	менеджер	noun	I want to speak to the manager.	B1	audio/word_manager_d1c5a085.mp3	ˈmænɪʤər	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
9213bcf6-6827-43a7-8a1b-52417c062a32	staff	персонал	noun	The staff were unhelpful.	A2	audio/word_staff_db862d06.mp3	stæf	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
65352aa5-f193-42ff-97fd-0146f9a2172d	rude	грубый	adjective	The staff were rude.	B1	audio/word_rude_32e2c975.mp3	rud	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
0d5299f1-4cf2-4ba3-9be8-cf76972204f4	unhelpful	неполезный, непомогающий	adjective	The staff were unhelpful.	A2	audio/word_unhelpful_d74b50b0.mp3	ənˈhɛlpfəl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
d9da3021-e085-48bd-b3a7-eb692cda7463	terrible	ужасный	adjective	The service was terrible.	A2	audio/word_terrible_c9614c9a.mp3	ˈtɛrəbəl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
d18f2169-fb78-449c-a79d-27900d2b4dab	awful	ужасный	adjective	It was an awful experience.	B1	audio/word_awful_744698e2.mp3	ˈɔfəl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
d81b4a6e-9dba-4b62-b6b6-8e01c4350420	refund	возврат денег	noun	I'd like a refund.	B1	audio/word_refund_1d19f640.mp3	ˈriˌfənd	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
3674ebea-f32f-4e8b-a1b0-e6389bdd4232	compensation	компенсация	noun	I'm asking for compensation.	B2	audio/word_compensation_237db6fe.mp3	ˌkɑmpənˈseɪʃən	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
fedb3f05-be44-421e-a1f1-94f1d17f371e	resolve	решить	verb	They resolved the issue quickly.	B2	audio/word_resolve_e679d702.mp3	riˈzɑlv	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
8f76c762-081b-444b-b1d8-f4afa91e07ba	address	решить	verb	Let's address your complaint.	B2	audio/word_address_88b2d578.mp3	ˈæˌdrɛs	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
565f9d41-f6bd-4f69-a319-6a85c69f16da	fix	чинить	verb	Can you fix this?	A2	audio/word_fix_51cf848f.mp3	fɪks	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
3a4d33a5-3c31-4ee5-996c-ab616722b850	request	запрос	noun	I have a request.	B1	audio/word_request_c5664a6f.mp3	rɪkˈwɛst	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
57ab3051-7881-4577-86bb-00152c83c572	immediately	немедленно	adverb	I need this fixed immediately.	B1	audio/word_immediately_0846ae98.mp3	ˌɪˈmiˌdiətli	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
de25e7d8-ace3-4533-a806-ff507845d6ac	right away	сразу же	adverb	I need help right away!	A2	audio/word_right_away_3fdb9513.mp3	raɪt əˈweɪ	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
4a00d8da-77a5-47a4-bcf0-12aa872b9cc3	as soon as possible	как можно скорее	adverb	Please deal with this as soon as possible.	B1	audio/word_as_soon_fea28109.mp3	ɛz sun ɛz ˈpɑsəbəl	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
59a5c4c5-bdc4-4b79-bc8c-2fb1fba53822	look into	разобраться	verb	I'd like them to look into this.	B2	audio/word_look_into_756cff37.mp3	lʊk ˈɪntu	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
40033134-0ddd-4ba0-98b2-1f68a8f884fd	terrible experience	ужасный опыт	noun phrase	I had a terrible experience.	B1	audio/word_terrible_experience_fe073c6f.mp3	ˈtɛrəbəl ɪkˈspɪriəns	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
fe2d2d13-f580-4fe3-9275-ffee82fdad9f	nightmare	кошмар	noun	It was a complete nightmare.	B2	audio/word_nightmare_dd969149.mp3	ˈnaɪtˌmɛr	9a95bf9d-4e4b-4ca5-a508-8574864dcbac
aaf7c1f9-7040-4241-a3c4-824b966be601	excuse_me	Извините	interjection	Excuse me, could you help me?	A1	audio/word_excuse_me_b6e793a2.mp3	excuse_me*	b84e6ebe-e62e-4173-bb74-75b5285738cd
f016062e-5c59-4391-8c94-db74d3fd4ab3	how_to_get_to	как добраться до	phrase	How to get to the train station?	A2	audio/word_how_to_get_to_d5ea053a.mp3	how_to_get_to*	b84e6ebe-e62e-4173-bb74-75b5285738cd
07d189e3-041f-4701-89cd-adbd51eb6601	to_go_to	идти_к	infinitive	I need to go to the city center	A2	audio/word_to_go_to_7515639f.mp3	to_go_to*	b84e6ebe-e62e-4173-bb74-75b5285738cd
df4b9ac7-bbef-4de7-b4a2-a9632d749128	go_straight_ahead	идти_прямо	verb	Go straight ahead and then turn left	A2	audio/word_go_straight_ahead_f257cf40.mp3	go_straight_ahead*	b84e6ebe-e62e-4173-bb74-75b5285738cd
d531357c-dcf3-461d-8b0b-297d5d4635f3	turn_left/right	повернуть_налево/направо	verb	Turn left at the traffic lights	A2		turn_left/right*	b84e6ebe-e62e-4173-bb74-75b5285738cd
d0241818-978d-4368-a19f-dd4b9976b00f	at_the_corner_of	на_углу	phrase	It's at the corner of Elm Street and Main Street	A2	audio/word_at_the_corner_of_41e89f1c.mp3	at_the_corner_of*	b84e6ebe-e62e-4173-bb74-75b5285738cd
9ddecba2-c929-4d54-9854-aa800f2c5e85	near	рядом	preposition	It's near the post office	A2	audio/word_near_ae0e3c55.mp3	nɪr	b84e6ebe-e62e-4173-bb74-75b5285738cd
9af1a74d-321f-4ba8-84bc-0cea0f4ed882	across_from	напротив	preposition	The hotel is across from the park	A2	audio/word_across_from_efa85549.mp3	across_from*	b84e6ebe-e62e-4173-bb74-75b5285738cd
2b185063-2c8a-4a8a-b99e-e15bda388edf	next_to	рядом_с	preposition	The bank is next to the supermarket	A2	audio/word_next_to_2c266cb7.mp3	next_to*	b84e6ebe-e62e-4173-bb74-75b5285738cd
bf71b9b0-d4c9-459c-bb3f-ddf1d5b6d85e	between	между	preposition	It's between the library and the museum	A2	audio/word_between_7d3233a2.mp3	bɪtˈwin	b84e6ebe-e62e-4173-bb74-75b5285738cd
5236d762-eec9-4229-97c2-0098d12186fd	on_the_left/right	слева/справа	phrase	The shop is on the right	A2		on_the_left/right*	b84e6ebe-e62e-4173-bb74-75b5285738cd
e635d47d-f01e-4381-8a4c-910d3485836d	a_few_blocks	несколько_кварталов	noun	It's a few blocks from here	A2	audio/word_a_few_blocks_fbcec2db.mp3	a_few_blocks*	b84e6ebe-e62e-4173-bb74-75b5285738cd
748fa6c6-62ab-4b24-b831-3039f1f655b3	take_a_taxi/bus	взять_такси/автобус	verb	Take a taxi to the airport	A2		take_a_taxi/bus*	b84e6ebe-e62e-4173-bb74-75b5285738cd
8f9d16ed-503e-4815-9733-45dd0028f626	it's_far/close	далеко/близко	phrase	Is it far from here?	A2		it's_far/close*	b84e6ebe-e62e-4173-bb74-75b5285738cd
6308bab2-91eb-473a-ad3a-9629d00e498c	how_long_does_it_take	сколько_времени_займёт	phrase	How long does it take to get there?	A2	audio/word_how_long_does_it_take_7f1fb594.mp3	how_long_does_it_take*	b84e6ebe-e62e-4173-bb74-75b5285738cd
4adb1fe6-d5b7-4c0e-8637-188107f2be3c	about	примерно	preposition	It takes about 20 minutes	A2	audio/word_about_01d62f41.mp3	əˈbaʊt	b84e6ebe-e62e-4173-bb74-75b5285738cd
2a970f09-5875-4c88-8a59-63914910d695	thank_you	спасибо	expression	Thank you for your help	A1	audio/word_thank_you_cd2c2b2e.mp3	thank_you*	b84e6ebe-e62e-4173-bb74-75b5285738cd
88880130-b46c-4d9d-8ee1-49efb01a98ba	you're_welcome	пожалуйста	expression	You're welcome	A1	audio/word_you're_welcome_70ff484f.mp3	you're_welcome*	b84e6ebe-e62e-4173-bb74-75b5285738cd
92ea109b-14e5-4ef6-9a33-c6041173b84b	I_am_lost	я_потерялся/потерялась	sentence	I am lost, can you help me?	A2	audio/word_i_am_lost_1b9e63bb.mp3	i_am_lost*	b84e6ebe-e62e-4173-bb74-75b5285738cd
f306819c-9c6c-4c12-b9d4-2c8099261c5b	could_you_show_me	могли_бы_вы_показать	phrase	Could you show me the way?	A2	audio/word_could_you_show_me_3aad6f78.mp3	could_you_show_me*	b84e6ebe-e62e-4173-bb74-75b5285738cd
89727584-b79c-4465-93ea-eda8d2f55561	follow_me	идите_за_мной	verb	Follow me, I'll show you	A2	audio/word_follow_me_30e334b5.mp3	follow_me*	b84e6ebe-e62e-4173-bb74-75b5285738cd
56ab5b1e-df0e-45f8-a458-0b7b101545ec	I_don't_understand	я_не_понимаю	sentence	I don't understand, please speak slowly	A2	audio/word_i_don't_understand_a30867dc.mp3	i_don't_understand*	b84e6ebe-e62e-4173-bb74-75b5285738cd
cd60c7a6-b4f8-4854-9790-ee1162fc1ff8	please_repeat	пожалуйста_повторите	phrase	Please repeat that	A2	audio/word_please_repeat_7f61bfd8.mp3	please_repeat*	b84e6ebe-e62e-4173-bb74-75b5285738cd
80375e47-c7fe-4c00-a72f-301af92c1909	map	карта	noun	Do you have a map?	A2	audio/word_map_1177d755.mp3	mæp	b84e6ebe-e62e-4173-bb74-75b5285738cd
93b63562-34fa-44dc-8df7-bf57f772879f	signpost	указатель	noun	Look at the signpost	A2	audio/word_signpost_7a966e66.mp3	ˈsaɪnˌpoʊst	b84e6ebe-e62e-4173-bb74-75b5285738cd
4c608701-aec0-48dd-b4d8-0e3c33c3f51d	map	карта	noun	I need a map to find my way.	A2	audio/word_map_ee1d41e9.mp3	mæp	72532b9f-4718-4e14-87a6-472ff4931700
af6b5c6d-a88c-450b-99d6-59d772eb042b	GPS	GPS-навигатор	noun	My GPS is showing me the way.	A2	audio/word_gps_730af9f3.mp3	ˈgipiˈɛs	72532b9f-4718-4e14-87a6-472ff4931700
40163eaa-9490-46ab-9be8-d4820d52b6f1	get lost	заблудиться	verb phrase	I don't want to get lost in this city.	B1	audio/word_get_lost_e6f98d22.mp3	gɪt lɔst	72532b9f-4718-4e14-87a6-472ff4931700
3aa42b0d-512d-4a66-9cfc-82e6679eb5b5	figure out	разобраться	verb phrase	I need to figure out how to get to the hotel.	B1	audio/word_figure_out_f9e80d37.mp3	ˈfɪgjər aʊt	72532b9f-4718-4e14-87a6-472ff4931700
7ea5c1d8-5c98-42b5-a609-03ddf88f21ba	follow the signs	следовать указателям	verb phrase	Just follow the signs to the terminal.	A2	audio/word_follow_the_92cc867c.mp3	ˈfɑloʊ ðə saɪnz	72532b9f-4718-4e14-87a6-472ff4931700
72cf9afa-885a-4608-a200-4f2eca5cd2e6	get there	добраться туда	verb phrase	How do I get there from the airport?	A2	audio/word_get_there_2b52e609.mp3	gɪt ðɛr	72532b9f-4718-4e14-87a6-472ff4931700
e835bf30-df42-426d-acf3-b93f3e0f23c0	street name	название улицы	noun	What's the street name?	A2	audio/word_street_name_3628c260.mp3	strit neɪm	72532b9f-4718-4e14-87a6-472ff4931700
15f8cd2d-a8cd-48b0-99a6-252958d24e03	landmark	ориентир	noun	The Eiffel Tower is a good landmark.	B1	audio/word_landmark_a31d60f7.mp3	ˈlændˌmɑrk	72532b9f-4718-4e14-87a6-472ff4931700
deb1b013-1897-4bea-b5ba-343cd803f250	crossroads	перекресток	noun	Turn left at the crossroads.	A2	audio/word_crossroads_727ff033.mp3	ˈkrɔsˌroʊdz	72532b9f-4718-4e14-87a6-472ff4931700
cf7895df-658c-4ff3-b173-f4d1c9d324af	intersection	пересечение	noun	The accident happened at the intersection.	A2	audio/word_intersection_905a7d0d.mp3	ˌɪntərˈsɛkʃən	72532b9f-4718-4e14-87a6-472ff4931700
18764cdf-9e3c-4b9f-a072-de7630ffa567	street	улица	noun	What street is this?	A2	audio/word_street_94a188b3.mp3	strit	72532b9f-4718-4e14-87a6-472ff4931700
39929d75-2692-4f12-b3cd-4db59863d5c1	route	маршрут	noun	What's the best route to take?	B1	audio/word_route_0de03693.mp3	rut	72532b9f-4718-4e14-87a6-472ff4931700
dbd4d4f6-b227-4527-ac18-ac3b302ec8d9	destination	место назначения	noun	What is your final destination?	B1	audio/word_destination_0cf208cb.mp3	ˌdɛstɪˈneɪʃən	72532b9f-4718-4e14-87a6-472ff4931700
70855ac4-fead-46ec-8065-9b8d8e1b229e	go straight ahead	идти прямо	verb phrase	Go straight ahead for 500 meters.	A2	audio/word_go_straight_6de5d2e6.mp3	goʊ streɪt əˈhɛd	72532b9f-4718-4e14-87a6-472ff4931700
9887c70d-0c61-4fe7-9ae8-e2d250a49aec	turn left/right	повернуть налево/направо	verb phrase	Turn left at the next corner.	A2		tərn left/right*	72532b9f-4718-4e14-87a6-472ff4931700
03b85f4d-1419-443c-8eaf-0059a3cfe235	block	квартал	noun	The hotel is two blocks away.	A2	audio/word_block_1f517d3a.mp3	blɑk	72532b9f-4718-4e14-87a6-472ff4931700
b211b1b9-61ce-4d62-bac9-bddfc7671bdb	landmark	достопримечательность	noun	That building is a famous landmark.	A2	audio/word_landmark_320eeae7.mp3	ˈlændˌmɑrk	3261997a-1d80-4b4a-b062-ee0f785b4a78
ffee281f-3ff8-4c74-9dc9-e8126f9ede02	iconic	знаковый	adjective	The Eiffel Tower is an iconic landmark.	B1	audio/word_iconic_b3804438.mp3	ˌaɪˈkɑnɪk	3261997a-1d80-4b4a-b062-ee0f785b4a78
3cefb09a-dae8-417d-a179-4e759eea10ff	point of interest	место, представляющее интерес	noun phrase	There are many points of interest in the old town.	B1	audio/word_point_of_abde7f00.mp3	pɔɪnt əv ˈɪntəˌrɛst	3261997a-1d80-4b4a-b062-ee0f785b4a78
448239be-cce4-4ad0-b397-3b6f668c1aa2	tourist attraction	туристическая достопримечательность	noun phrase	The museum is a popular tourist attraction.	B1	audio/word_tourist_attraction_568d45a5.mp3	ˈtʊrɪst əˈtrækʃən	3261997a-1d80-4b4a-b062-ee0f785b4a78
d5e42a85-20e7-46cb-a7b4-06565e7c95e1	easily visible	легко видимый	adjective phrase	The church is easily visible from the square.	B2	audio/word_easily_visible_195d4f65.mp3	ˈizəli ˈvɪzəbəl	3261997a-1d80-4b4a-b062-ee0f785b4a78
0d3cb936-dc5d-40fb-ac67-621111804774	catch sight of	заметить	phrasal verb	We caught sight of the castle in the distance.	B1	audio/word_catch_sight_22f5a443.mp3	kæʧ saɪt əv	3261997a-1d80-4b4a-b062-ee0f785b4a78
5fca4738-5c98-4f07-99ce-7a9cd22bf0f3	spot	заметить	verb	I spotted a familiar face in the crowd.	A2	audio/word_spot_51b17c18.mp3	spɑt	3261997a-1d80-4b4a-b062-ee0f785b4a78
85680b86-b029-4f9f-a232-b6db535857fc	notice	заметить	verb	Did you notice the clock tower?	A2	audio/word_notice_37def3b3.mp3	ˈnoʊtɪs	3261997a-1d80-4b4a-b062-ee0f785b4a78
b1f15961-aad4-460a-8230-aa68a3b5a5f4	take a look at	посмотреть на	phrasal verb	Let's take a look at the map.	A2	audio/word_take_a_9ad91792.mp3	teɪk ə lʊk æt	3261997a-1d80-4b4a-b062-ee0f785b4a78
ea9a32c5-2b38-4887-9549-ca9dc618b6dd	check the map	проверить карту	verb phrase	Check the map to find your way.	A2	audio/word_check_the_d9cb00fc.mp3	ʧɛk ðə mæp	3261997a-1d80-4b4a-b062-ee0f785b4a78
589718b8-3f3c-4895-85c5-56b526f89929	refer to the map	обратиться к карте	verb phrase	Refer to the map to find the location.	B1	audio/word_refer_to_68a87d7a.mp3	rɪˈfər tɪ ðə mæp	3261997a-1d80-4b4a-b062-ee0f785b4a78
d4f4ac88-4461-49b0-8988-a7f0a50aceb0	over there	там	adverb	The hotel is over there.	A1	audio/word_over_there_abd64ceb.mp3	ˈoʊvər ðɛr	3261997a-1d80-4b4a-b062-ee0f785b4a78
7afb0ad1-c1c0-4928-8dc4-ce3a4772bf74	straight ahead	прямо	adverb phrase	Go straight ahead and then turn left.	A1	audio/word_straight_ahead_28e4b196.mp3	streɪt əˈhɛd	3261997a-1d80-4b4a-b062-ee0f785b4a78
aa016926-cc46-404f-aad4-65640e004db3	on your right/left	справа/слева	adverb phrase	The shop is on your right.	A1	audio/word_on_your_9c5b133e.mp3	ɔn jʊr right/left*	3261997a-1d80-4b4a-b062-ee0f785b4a78
350c7464-f347-41ab-98b1-df27a88b23ed	next to	рядом с	preposition	The cafe is next to the bank.	A1	audio/word_next_to_5468b62f.mp3	nɛkst tɪ	3261997a-1d80-4b4a-b062-ee0f785b4a78
1fbeab42-215e-49c6-950e-065916facd09	opposite	напротив	preposition	The post office is opposite the station.	A1	audio/word_opposite_0585eb92.mp3	ˈɑpəzɪt	3261997a-1d80-4b4a-b062-ee0f785b4a78
b1549c3f-b4e0-450e-813f-471330cca797	across from	напротив	preposition	The park is across from the library.	A1	audio/word_across_from_6890052d.mp3	əˈkrɔs frəm	3261997a-1d80-4b4a-b062-ee0f785b4a78
3990a248-d295-461a-b5da-4d59d7bcf78d	in the vicinity	вблизи	preposition phrase	There are several restaurants in the vicinity.	B2	audio/word_in_the_1683c0a7.mp3	ɪn ðə vɪˈsɪnɪti	3261997a-1d80-4b4a-b062-ee0f785b4a78
d48ca275-45ea-4b42-9c56-d4ca05eb4d81	close by	рядом	adverb phrase	There's a supermarket close by.	A2	audio/word_close_by_ab363423.mp3	kloʊz baɪ	3261997a-1d80-4b4a-b062-ee0f785b4a78
5cf8fcd9-7a20-4a06-b77b-ce6cc29b0659	nearby	рядом	adverb	There's a hotel nearby.	A2	audio/word_nearby_c00cfeb8.mp3	ˈnɪrˈbaɪ	3261997a-1d80-4b4a-b062-ee0f785b4a78
c5ee244e-fd64-4217-8a95-fbf328f2f6fa	a little further on	немного дальше	adverb phrase	You'll see a signpost a little further on.	A2	audio/word_a_little_c833eec2.mp3	ə ˈlɪtəl ˈfərðər ɔn	3261997a-1d80-4b4a-b062-ee0f785b4a78
bce03f39-095a-4b9f-9d06-709ebea0d713	around the corner	за углом	adverb phrase	The bakery is just around the corner.	A2	audio/word_around_the_a057bc1c.mp3	əraʊnd ðə ˈkɔrnər	3261997a-1d80-4b4a-b062-ee0f785b4a78
8cf3d112-c4e5-423f-a362-810036b1d9ba	it's easy to find	легко найти	phrase	It's easy to find the station.	A1	audio/word_it's_easy_da45a33b.mp3	ɪts ˈizi tɪ faɪnd	3261997a-1d80-4b4a-b062-ee0f785b4a78
e3062951-3e26-4533-819c-95a78a6096da	it's a bit hard to find	немного сложно найти	phrase	It's a bit hard to find the museum.	A2	audio/word_it's_a_3bfd0164.mp3	ɪts ə bɪt hɑrd tɪ faɪnd	3261997a-1d80-4b4a-b062-ee0f785b4a78
7d9b4fa0-33fa-4d39-b5c1-8dcb79626e0b	get lost	заблудиться	phrasal verb	Don't get lost!	A2	audio/word_get_lost_b5669ce6.mp3	gɪt lɔst	3261997a-1d80-4b4a-b062-ee0f785b4a78
96466de0-da42-4f6a-b3a6-d74ef56d5700	find your way	найти дорогу	verb phrase	Find your way to the main square.	A2	audio/word_find_your_002f0865.mp3	faɪnd jʊr weɪ	3261997a-1d80-4b4a-b062-ee0f785b4a78
92dae254-24bd-4ac3-a589-e0cbcb950380	follow the signs	следовать указателям	verb phrase	Follow the signs to the airport.	A2	audio/word_follow_the_32267063.mp3	ˈfɑloʊ ðə saɪnz	3261997a-1d80-4b4a-b062-ee0f785b4a78
94ff7ffb-43f9-461f-8a58-9d0701984940	follow this path/road	следовать этой тропе/дороге	verb phrase	Follow this path to the lake.	A2	audio/word_follow_this_1bcc14be.mp3	ˈfɑloʊ ðɪs path/road*	3261997a-1d80-4b4a-b062-ee0f785b4a78
aa645cd1-ab73-461c-9f4e-ea1266487ce1	how far?	как далеко?	phrase	How far is the train station from here?	A1	audio/word_how_far?_5305e458.mp3	haʊ fɑr?	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
ab6b64e5-9378-4767-832b-dde2e4e71451	how long?	сколько времени?	phrase	How long does it take to get to the city centre?	A1	audio/word_how_long?_0cf44f10.mp3	haʊ lɔŋ?	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
eed4bc79-435b-4772-95d8-235782f6757a	distance to	расстояние до	phrase	What's the distance to the airport?	A1	audio/word_distance_to_ea077817.mp3	ˈdɪstəns tɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
03f62d3a-1f03-4cc3-9a73-dae0b6db0987	it takes	это занимает	verb phrase	It takes about 30 minutes by bus	A1	audio/word_it_takes_4006fef7.mp3	ɪt teɪks	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
ba5ba939-c7bd-4ec3-9d9a-9d5c8140ceaa	about	примерно	adverb	It's about 10 kilometers	A1	audio/word_about_096d626e.mp3	əˈbaʊt	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
1a32e139-a02a-4c3a-a5da-89fe59696a53	minutes	минуты	noun	It takes 15 minutes by taxi	A1	audio/word_minutes_ad05e394.mp3	ˈmɪnəts	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
9efae393-0a7c-4bbc-a12a-a32b107a7620	kilometers/miles	километры/мили	noun	It's 5 kilometers from here	A1		kilometers/miles*	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
bfc24771-4a1b-41a6-bb11-0dffbdde933f	taxi ride	поездка на такси	noun phrase	The taxi ride was expensive	A1	audio/word_taxi_ride_f4432487.mp3	ˈtæksi raɪd	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
424e9062-17ef-4e57-b731-65d212e67ebc	bus ride	поездка на автобусе	noun phrase	The bus ride was long	A1	audio/word_bus_ride_466c9516.mp3	bəs raɪd	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
c515a55a-d004-4fe9-ae99-5247b28d828c	train journey	поездка на поезде	noun phrase	The train journey was comfortable	A1	audio/word_train_journey_eb2cb298.mp3	treɪn ˈʤərni	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
d665e18c-7c58-4c11-b79a-5edac13473a1	walking distance	в пешей доступности	noun phrase	The hotel is within walking distance	A1	audio/word_walking_distance_e2e3b9d2.mp3	ˈwɔkɪŋ ˈdɪstəns	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
a3dbe089-45d4-4ec3-b3de-b1f968e85a38	short walk	недолгая прогулка	noun phrase	It's a short walk from here	A1	audio/word_short_walk_17f85ea3.mp3	ʃɔrt wɔk	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
fec2afac-9539-4845-8720-ef3725f48c25	a little far	немного далеко	phrase	It's a little far to walk	A1	audio/word_a_little_cbc13827.mp3	ə ˈlɪtəl fɑr	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
cbe10056-074e-4043-b152-a66c9da16d06	quite far	довольно далеко	phrase	It's quite far from the airport	A1	audio/word_quite_far_510a7cba.mp3	kwaɪt fɑr	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
8abddd54-5150-4325-b01c-6e134a59698d	nearby	рядом	adjective	Is there a pharmacy nearby?	A2	audio/word_nearby_07f1fac5.mp3	ˈnɪrˈbaɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
4a79e000-9a51-4e27-9e21-afa53c48d2de	close to	близко к	phrase	The hotel is close to the train station	A2	audio/word_close_to_0865299d.mp3	kloʊz tɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
9d9b684f-2da4-4004-b1db-753e0f6bdd99	far from	далеко от	phrase	The museum is far from the city center	A2	audio/word_far_from_b773611e.mp3	fɑr frəm	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
2f835197-a2fe-4ec2-b3bd-c532a6b5e2b1	direct route	прямой маршрут	noun phrase	Is there a direct route to the hotel?	A2	audio/word_direct_route_6cc53ae9.mp3	dɪˈrɛkt rut	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
a4a19323-2c95-4c7f-9d7d-d3dc44b64dfc	easy to get to	легко добраться до	phrase	The city center is easy to get to	A2	audio/word_easy_to_fdf68ec1.mp3	ˈizi tɪ gɪt tɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
1abd26cd-b5a9-4206-98b9-093fb33b2141	difficult to reach	трудно добраться до	phrase	The museum is difficult to reach by public transport	A2	audio/word_difficult_to_ccac77d0.mp3	ˈdɪfəkəlt tɪ riʧ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
8f042be9-9571-49ed-875b-0ab7005732f3	get there by	добраться туда на	phrase	How can I get there by bus?	A2	audio/word_get_there_129a4f33.mp3	gɪt ðɛr baɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
9852f08d-98b7-43fc-b12d-7eb2cf7351d9	how to get to	как добраться до	phrase	Could you tell me how to get to the station?	A2	audio/word_how_to_0acdf3da.mp3	haʊ tɪ gɪt tɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
8e3a1565-fbc7-4c7d-9d62-f8546ac63274	approximately	приблизительно	adverb	It will take approximately 20 minutes	B1	audio/word_approximately_8a9188b5.mp3	əˈprɑksəmətli	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
2c8da61e-9987-4cbb-9030-ad28cc38180f	in the vicinity	в окрестностях	phrase	There are several hotels in the vicinity	B1	audio/word_in_the_4c207011.mp3	ɪn ðə vɪˈsɪnɪti	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
5f240505-0484-4ffa-b872-32d89383ad6f	conveniently located	удобно расположенный	phrase	The hotel is conveniently located near the airport	B1	audio/word_conveniently_located_3563e8db.mp3	kənˈvinjəntli ˈloʊˌkeɪtəd	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
71f17b1a-60ec-4d6c-b1fe-5dfd8b544662	within easy reach	в пределах досягаемости	phrase	The supermarket is within easy reach	B1	audio/word_within_easy_09cac605.mp3	wɪˈθɪn ˈizi riʧ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
f9ae85d6-17a0-4b4f-bcbc-47641626f32d	proximity to	близость к	phrase	The hotel's proximity to the beach is a plus	B1	audio/word_proximity_to_d7128452.mp3	prɑkˈsɪməti tɪ	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
f8cd7ce8-0aaf-4724-b80f-b5e16eddf571	commuting distance	расстояние для ежедневных поездок	noun phrase	The house is within commuting distance of my work	B1	audio/word_commuting_distance_e03db0d8.mp3	kəmˈjutɪŋ ˈdɪstəns	ee32c75c-0f15-4952-b9cc-817b7a99e2d5
8a4f4d61-21fe-4a82-b2d0-a01e7e9a5cf6	menu	меню	noun	Can I see the menu, please?	A2	audio/word_menu_11b35846.mp3	ˈmɛnju	36a98168-317b-48a0-aad7-6516d9298352
64914d04-5a57-4d9d-bb57-3e925f32e9c7	order	заказать	verb	I'd like to order the pasta	A2	audio/word_order_70ff88e2.mp3	ˈɔrdər	36a98168-317b-48a0-aad7-6516d9298352
c8d6e100-2479-4816-844d-fe8e7c2931b1	food	еда	noun	What kind of food do you have?	A1	audio/word_food_6b80fda6.mp3	fud	36a98168-317b-48a0-aad7-6516d9298352
2665401a-5ee8-4e5c-a542-082a1d77b48c	drinks	напитки	noun	What drinks do you have?	A2	audio/word_drinks_cd95f4cf.mp3	drɪŋks	36a98168-317b-48a0-aad7-6516d9298352
0a16dbb0-bfdb-4522-bbda-a74e186e8f6d	bill	счёт	noun	Can we have the bill, please?	A1	audio/word_bill_4e336951.mp3	bɪl	36a98168-317b-48a0-aad7-6516d9298352
8041378a-1d6e-4ece-9735-299465e0e621	to pay the bill	оплатить счёт	verb phrase	It's time to pay the bill	B1	audio/word_to_pay_eb387c28.mp3	tɪ peɪ ðə bɪl	36a98168-317b-48a0-aad7-6516d9298352
e379c1c8-a001-4249-becb-fcd1d65dec55	waiter/waitress	официант/официантка	noun	Excuse me, waiter?	A2		waiter/waitress*	36a98168-317b-48a0-aad7-6516d9298352
1c1b09d2-622f-44be-9871-1b53abadecf5	table	столик	noun	We need a table for two	A1	audio/word_table_55023318.mp3	ˈteɪbəl	36a98168-317b-48a0-aad7-6516d9298352
4fd401c3-f068-47cc-9480-c5d217e8779c	take away	на вынос	verb phrase	I'd like to take away this food	B1	audio/word_take_away_d992127a.mp3	teɪk əˈweɪ	36a98168-317b-48a0-aad7-6516d9298352
19fe742e-5561-43cb-880a-58b2b982e3a5	to go	на вынос	adverb	Coffee to go, please	A2	audio/word_to_go_9eee5544.mp3	tɪ goʊ	36a98168-317b-48a0-aad7-6516d9298352
1418c76a-2ced-4063-8465-60937e5d497e	special	специальное блюдо	adjective	What is the daily special?	A2	audio/word_special_167359e5.mp3	ˈspɛʃəl	36a98168-317b-48a0-aad7-6516d9298352
a3a38bfe-3c3e-4222-a5ad-ba4d391088ca	appetizer	закуска	noun	I'll start with an appetizer	B1	audio/word_appetizer_24d0a98c.mp3	ˈæpəˌtaɪzər	36a98168-317b-48a0-aad7-6516d9298352
1b165739-ad0d-4269-ab41-bce936cc5de4	main course	главное блюдо	noun	What's your main course?	B1	audio/word_main_course_82857c97.mp3	meɪn kɔrs	36a98168-317b-48a0-aad7-6516d9298352
a33570b0-0f35-4791-8a12-5aaa49dcba5e	dessert	десерт	noun	I'll have the dessert menu, please	A2	audio/word_dessert_88d8ed22.mp3	dɪˈzərt	36a98168-317b-48a0-aad7-6516d9298352
c703a63e-9f7a-4c08-8f1b-5424a3d499ff	to pick	выбрать	verb	I can't decide, what to pick	B1	audio/word_to_pick_3ef61c87.mp3	tɪ pɪk	36a98168-317b-48a0-aad7-6516d9298352
4bf2f6ef-c73e-4812-85f1-6e1bf7603b1b	delicious	вкусно	adjective	The food was delicious!	A2	audio/word_delicious_2185161c.mp3	dɪˈlɪʃəs	36a98168-317b-48a0-aad7-6516d9298352
d84c39e1-50e8-432a-bd35-370d00c0e9e9	tasty	вкусный	adjective	This cake is so tasty!	A2	audio/word_tasty_0cede869.mp3	ˈteɪsti	36a98168-317b-48a0-aad7-6516d9298352
b000f714-f6a8-4b65-8792-f18dadaed80b	to taste	попробовать	verb	Can I taste this?	A2	audio/word_to_taste_d6735e42.mp3	tɪ teɪst	36a98168-317b-48a0-aad7-6516d9298352
40951d69-b587-4a1a-b600-e69f42ba78ce	hungry	голодный	adjective	I'm so hungry!	A1	audio/word_hungry_21c4ecac.mp3	ˈhəŋgri	36a98168-317b-48a0-aad7-6516d9298352
3e893bb2-71e1-4ddd-9720-3a96b329c8dd	thirsty	жаждущий	adjective	I'm very thirsty	A1	audio/word_thirsty_2ebe4593.mp3	ˈθərsti	36a98168-317b-48a0-aad7-6516d9298352
a6ab8a51-8b34-4539-b8f3-d2025ca1df62	to recommend	рекомендовать	verb	Can you recommend something?	B1	audio/word_to_recommend_0fde987e.mp3	tɪ ˌrɛkəˈmɛnd	36a98168-317b-48a0-aad7-6516d9298352
da466f96-1830-426f-9554-b398194fa25d	reservation	бронь	noun	Do you have a reservation?	B1	audio/word_reservation_8da37fbe.mp3	ˌrɛzərˈveɪʃən	36a98168-317b-48a0-aad7-6516d9298352
83568b0d-a1de-44dd-890a-c065395663d4	tip	чаевые	noun	Here's your tip	B1	audio/word_tip_e56609b7.mp3	tɪp	36a98168-317b-48a0-aad7-6516d9298352
19c125c0-5954-4929-bfe2-320beeff383e	credit card	кредитная карта	noun	I'll pay by credit card	A2	audio/word_credit_card_5e21af5c.mp3	ˈkrɛdɪt kɑrd	36a98168-317b-48a0-aad7-6516d9298352
18887aa0-fbe0-44c9-af76-4e0a323eb564	cash	наличные	noun	I'll pay cash	A1	audio/word_cash_21f04e0e.mp3	kæʃ	36a98168-317b-48a0-aad7-6516d9298352
0e24910e-fd2f-4e1c-a1a1-4badac85091f	menu	меню	noun	Can I see the menu, please?	A2	audio/word_menu_bb59e450.mp3	ˈmɛnju	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
ce93ed16-15ff-4456-a8d0-0a8eb20605bf	food	еда	noun	What kind of food do you have?	A1	audio/word_food_64a3fb4c.mp3	fud	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
2e88990d-ea1a-4f29-a57c-9adf32342af2	dishes	блюда	noun	What are your special dishes?	A2	audio/word_dishes_3483b944.mp3	ˈdɪʃɪz	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
2e03f0f4-2acf-4dc0-b69d-0cd3b146c7e2	appetizers	закуски	noun	Do you have any appetizers?	A2	audio/word_appetizers_5ae1269e.mp3	ˈæpəˌtaɪzərz	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
c43d892a-f4ba-4759-9f99-24172dcef042	main courses	основные блюда	noun	What are your main courses today?	B1	audio/word_main_courses_a4db535a.mp3	meɪn ˈkɔrsɪz	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
d01a12b0-efc8-412f-b5ff-1a30a661f283	dessert	десерт	noun	What do you recommend for dessert?	A2	audio/word_dessert_8bd3b36d.mp3	dɪˈzərt	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
8c79c9cd-2ddf-490b-a49c-9f31427f27eb	drinks	напитки	noun	What drinks do you have?	A1	audio/word_drinks_822627c8.mp3	drɪŋks	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
aceb2a7a-c2cf-497c-9ba4-d6e667216b46	wine list	винная карта	noun	May I see the wine list?	B1	audio/word_wine_list_6063315d.mp3	waɪn lɪst	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
641b227f-e566-483c-8945-bd2a4919cda4	special	специальный	adjective	Do you have any specials today?	A2	audio/word_special_fbc87098.mp3	ˈspɛʃəl	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
0b6f21ce-e7e7-4ba8-8a7f-cdf935cca8c1	vegetarian	вегетарианский	adjective	Do you have any vegetarian options?	B1	audio/word_vegetarian_8e7a3543.mp3	ˌvɛʤəˈtɛˌriən	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
f8cbe5cd-1338-4a28-88c4-ecad37fe382b	spicy	острый	adjective	Is this dish spicy?	A2	audio/word_spicy_19a7279d.mp3	ˈspaɪsi	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
decd45da-062a-46f7-ad09-11682c069b20	allergies	аллергия	noun	I have a seafood allergy	B1	audio/word_allergies_07304203.mp3	ˈælərʤiz	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
f543e35e-f480-4f6e-8049-28ef8c087ab9	recommend	рекомендовать	verb	Can you recommend something?	B1	audio/word_recommend_0bb4f73c.mp3	ˌrɛkəˈmɛnd	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
75b95c85-f24a-4504-953d-313c5eaf3ae6	order	заказывать	verb	I'd like to order the pasta	A2	audio/word_order_5ffe6c08.mp3	ˈɔrdər	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
97022bfd-0268-40e9-80d2-b5c35e65c94d	take	брать	verb	I'll take the fish	A1	audio/word_take_16f9246e.mp3	teɪk	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
05eb566f-b339-47b7-ac07-206b20552228	bill	счёт	noun	Can I have the bill, please?	A1	audio/word_bill_d699e1e5.mp3	bɪl	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
4e12bc9d-4a91-4b5a-86a6-69d7c50c45ea	check	чек	noun	Here's your check	A2	audio/word_check_2444d1b6.mp3	ʧɛk	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
1909eb65-3790-47e4-a30c-cb5d0c8b5525	delicious	вкусный	adjective	This is delicious!	A2	audio/word_delicious_7fc73521.mp3	dɪˈlɪʃəs	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
6ec1dd7d-5fe1-404d-987b-3d568d4087d8	tasty	вкусный	adjective	It's very tasty	A2	audio/word_tasty_36249253.mp3	ˈteɪsti	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
ffcda9eb-7a3f-4938-9395-82014f69cfee	expensive	дорогой	adjective	This is quite expensive!	A2	audio/word_expensive_f4290556.mp3	ɪkˈspɛnsɪv	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
52ab866d-4d25-4de5-be35-ba1084d161ad	reasonable	разумный	adjective	The prices are reasonable	B1	audio/word_reasonable_9a539418.mp3	ˈrizənəbəl	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
2cb98cf0-ee80-4e13-92ca-0f70985bea47	how much is	сколько стоит	phrase	How much is the pizza?	A2	audio/word_how_much_3bf376d2.mp3	haʊ məʧ ɪz	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
b9223024-e4a4-412b-bad5-3000af20f3d7	Excuse me	Извините	interjection	Excuse me, waiter?	A1	audio/word_excuse_me_54726c5a.mp3	ɪkˈskjuz mi	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
7d7a4244-5fe7-4930-a564-0a33b7f876e3	waiter	официант	noun	Waiter!	A2	audio/word_waiter_0f1d4f68.mp3	ˈweɪtər	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
18866058-cfa9-4db7-811e-af49a47c4aa4	could I	могу ли я	modal verb	Could I have some water, please?	B1	audio/word_could_i_b9195074.mp3	kʊd aɪ	586e0d3e-08e6-4003-bc88-ab50b7e1b1cc
b20170be-5405-47ce-a367-dc01ca94b488	allergy	аллергия	noun	I have a serious nut allergy	B1	audio/word_allergy_0ac98d52.mp3	ˈælərʤi	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
fe19b85e-4c9d-4d8a-8789-d1c4aec50f7d	gluten-free	безглютеновый	adjective	Do you have any gluten-free options?	B1	audio/word_gluten-free_3c1220a0.mp3	gluten-free*	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
72a455b7-1375-496e-9ac6-0524512beb89	dairy-free	безмолочный	adjective	I need a dairy-free dessert	B1	audio/word_dairy-free_99f12370.mp3	dairy-free*	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
a7dcdd2f-d367-4088-a2cf-23d4b6308865	halal	халяльный	adjective	Where can I find halal food?	B1	audio/word_halal_ad2b9397.mp3	halal*	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
ca059f23-6b89-44d5-887a-2e258f6f6006	kosher	кошерный	adjective	Is there a kosher restaurant nearby?	B1	audio/word_kosher_bbdfa59d.mp3	ˈkoʊʃər	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
c068c0d0-cd5c-4bca-99b0-58a30abb0717	food intolerance	непереносимость пищи	noun	I have a food intolerance to shellfish	B2	audio/word_food_intolerance_2d0ebfc9.mp3	fud ˌɪnˈtɑlərəns	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
9216568f-fdd9-48c5-9d12-b79bd2a01fb6	special dietary requirements	специальные диетические требования	noun	I have some special dietary requirements	B2	audio/word_special_dietary_30880ce5.mp3	ˈspɛʃəl ˈdaɪəˌtɛri rɪkˈwaɪrmənts	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
074f615f-05f7-4b02-8e47-571f8f68ecfe	accommodate	учитывать	verb	Can you accommodate my dietary needs?	B2	audio/word_accommodate_63cd31de.mp3	əˈkɑməˌdeɪt	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
98807e01-1bb4-4b2d-a72d-a4c355d5fe02	catering	питание	noun	What's the in-flight catering like?	B2	audio/word_catering_f8057495.mp3	ˈkeɪtərɪŋ	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
ab82dd0b-c70c-49c2-8fc9-5bef9001f870	restaurant	ресторан	noun	Is there a restaurant in the airport?	A1	audio/word_restaurant_c4d0d359.mp3	ˈrɛˌstrɑnt	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
14597bd2-be76-43ba-a90d-c4c5d19b4d5c	menu	меню	noun	Can I see the menu, please?	A1	audio/word_menu_c1de1f88.mp3	ˈmɛnju	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
07c5bf6b-2dfd-4e99-925f-bba5b403536e	order	заказывать	verb	I'd like to order a sandwich	A1	audio/word_order_bab0e873.mp3	ˈɔrdər	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
7ea03ef9-503a-43d6-830d-4e09fdee09c6	bill	счет	noun	Can I have the bill, please?	A1	audio/word_bill_1b65cf81.mp3	bɪl	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
9f3b96a7-8894-44b7-a2fc-d926985e64e2	tip	чаевые	noun	Should I leave a tip?	A2	audio/word_tip_a362f707.mp3	tɪp	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
753c90c7-ce2a-477c-b3c8-ec9c6ee907ee	find out	узнать	phrasal verb	I need to find out where the restaurants are	B1	audio/word_find_out_1c25ad32.mp3	faɪnd aʊt	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
86f13010-3e27-4f96-bf32-45a214ba3b13	look for	искать	phrasal verb	I'm looking for a vegetarian restaurant	A2	audio/word_look_for_1083bbbb.mp3	lʊk fər	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
57b6bb69-a2db-46ae-aaae-db8fa3925474	check	проверять	verb	Let me check the menu	A1	audio/word_check_7e8c989a.mp3	ʧɛk	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
83beb652-5280-4360-a685-4436fcf75af2	have	иметь	verb	Do you have any vegetarian options?	A1	audio/word_have_e960f419.mp3	hæv	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
948da67b-8e6a-47d3-b00c-aefecd6bfa97	need	нуждаться	verb	I need a gluten-free meal	A1	audio/word_need_8aeacef3.mp3	nid	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
dfdb0430-20cb-4616-90cc-1b35915f8cbc	want	хотеть	verb	I want something to eat	A1	audio/word_want_999cd245.mp3	wɔnt	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
38add3a8-4eb9-4239-bf1f-c83519d04098	like	любить	verb	I like this restaurant	A1	audio/word_like_522452db.mp3	laɪk	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
01e0de86-d792-4a1b-814d-792adfd8a5bd	sorry	извини	interjection	I'm sorry, I don't understand	A1	audio/word_sorry_9a76ffc7.mp3	ˈsɑri	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
e33298d4-f60d-413d-a3a2-8225bc5bec4d	excuse me	извините	interjection	Excuse me, where's the restaurant?	A1	audio/word_excuse_me_265628f7.mp3	ɪkˈskjuz mi	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
08c18b13-3a8b-468a-b7a0-edb0e00ff88b	please	пожалуйста	interjection	Please speak slowly	A1	audio/word_please_0a33efbe.mp3	pliz	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
202077a2-1d84-44e7-94ed-2b37708f5c81	thank you	спасибо	interjection	Thank you for your help	A1	audio/word_thank_you_dfef7d58.mp3	θæŋk ju	f5efcff2-32b5-4b9d-b4eb-cbb13aba277f
a450d55f-b76a-4c3d-b045-38e4e88964b0	bill	счёт	noun	Can we see the bill, please?	A2	audio/word_bill_c6d17c55.mp3	bɪl	8ac30e42-14c6-4de5-b37f-ff130697fafb
5d6da8d0-bcca-4bde-8937-498230d994c3	pay the bill	платить по счёту	verb phrase	We need to pay the bill before we leave	A2	audio/word_pay_the_ef8f7d2e.mp3	peɪ ðə bɪl	8ac30e42-14c6-4de5-b37f-ff130697fafb
095cb51e-e256-4201-a36e-90ade3b6f54a	split the bill	разделить счёт	verb phrase	Let's split the bill equally	B1	audio/word_split_the_0de4c470.mp3	splɪt ðə bɪl	8ac30e42-14c6-4de5-b37f-ff130697fafb
4f7d6aab-4333-4631-91d2-74bb2099e3b6	go Dutch	разделиться поровну	verb phrase	We decided to go Dutch on dinner	B1	audio/word_go_dutch_ebcf4d78.mp3	goʊ dəʧ	8ac30e42-14c6-4de5-b37f-ff130697fafb
9402b12d-2288-482c-9551-4bebdb2860a1	tip	чаевые	noun	We should leave a tip for the waiter	A2	audio/word_tip_fc528349.mp3	tɪp	8ac30e42-14c6-4de5-b37f-ff130697fafb
ae6c531a-d58d-4fc1-8553-5ed2b186b991	service charge	плата за обслуживание	noun	The service charge is included in the bill	B1	audio/word_service_charge_f7ea03d0.mp3	ˈsərvɪs ʧɑrʤ	8ac30e42-14c6-4de5-b37f-ff130697fafb
0c5e3a1c-67f1-4af7-bbe3-a01b15473f66	add up	подсчитать	verb phrase	Can you add up the bill, please?	B1	audio/word_add_up_3bbcd1d4.mp3	æd əp	8ac30e42-14c6-4de5-b37f-ff130697fafb
2f87f282-7f75-4637-a507-a40433e9aae7	total	итого	noun	What's the total?	A2	audio/word_total_4ea6575a.mp3	ˈtoʊtəl	8ac30e42-14c6-4de5-b37f-ff130697fafb
056f9509-b636-4b7c-b323-9c210bc85914	credit card	кредитная карта	noun	I'll pay with my credit card	A2	audio/word_credit_card_fb3cbeab.mp3	ˈkrɛdɪt kɑrd	8ac30e42-14c6-4de5-b37f-ff130697fafb
966bce46-4e13-4fe6-b526-6179e7655619	debit card	дебетовая карта	noun	Do you accept debit cards?	B1	audio/word_debit_card_b8e60e98.mp3	ˈdɛbɪt kɑrd	8ac30e42-14c6-4de5-b37f-ff130697fafb
f9ffb8c1-d497-4270-b845-3cb1891ded63	cash	наличные	noun	I'll pay in cash	A1	audio/word_cash_7130d925.mp3	kæʃ	8ac30e42-14c6-4de5-b37f-ff130697fafb
1f414f5d-f137-4c5c-8a0a-05e36ac9c218	separate bills	отдельные счета	noun phrase	Could we have separate bills, please?	B1	audio/word_separate_bills_b99418ff.mp3	ˈsɛpərˌeɪt bɪlz	8ac30e42-14c6-4de5-b37f-ff130697fafb
5451cbf4-0ae6-4b1c-9e3a-e627a148ec62	expensive	дорогой	adjective	This restaurant is very expensive	A2	audio/word_expensive_230f74b8.mp3	ɪkˈspɛnsɪv	8ac30e42-14c6-4de5-b37f-ff130697fafb
3ea2c79c-0e8a-490a-b519-4853a7ccc231	reasonable	разумный	adjective	The prices were very reasonable	B1	audio/word_reasonable_74357596.mp3	ˈrizənəbəl	8ac30e42-14c6-4de5-b37f-ff130697fafb
11fe0475-1235-4f0a-b0a8-dac3ab7aa573	overpriced	завышенный	adjective	I think this meal is overpriced	B2	audio/word_overpriced_bc0a0df2.mp3	ˈoʊvərˌpraɪst	8ac30e42-14c6-4de5-b37f-ff130697fafb
92ff759c-826a-41e1-aa1b-578d3e315992	delicious	вкусный	adjective	The food was absolutely delicious	A2	audio/word_delicious_2e05284a.mp3	dɪˈlɪʃəs	8ac30e42-14c6-4de5-b37f-ff130697fafb
1b9e3ace-de08-4e02-87f7-555aa66545f5	worth it	стоит того	adjective phrase	The high price was worth it	B1	audio/word_worth_it_ffa4ad45.mp3	wərθ ɪt	8ac30e42-14c6-4de5-b37f-ff130697fafb
c0c28b23-ec3d-4c49-91c8-d0247fe06a2b	affordable	доступный	adjective	We need to find an affordable restaurant	B1	audio/word_affordable_06aeb56c.mp3	əˈfɔrdəbəl	8ac30e42-14c6-4de5-b37f-ff130697fafb
ff69412a-4dc7-4493-b378-8ca702b93a5a	tasty	вкусный	adjective	The food was really tasty	A2	audio/word_tasty_34598550.mp3	ˈteɪsti	8ac30e42-14c6-4de5-b37f-ff130697fafb
03efc9f0-1b9f-4df7-822a-41ea745ea24f	scrumptious	изысканный	adjective	That cake looked scrumptious	B2	audio/word_scrumptious_0291f006.mp3	scrumptious*	8ac30e42-14c6-4de5-b37f-ff130697fafb
96432221-c225-43ce-b48f-550e1f77979f	reasonable price	разумная цена	noun phrase	The meal was good value for its reasonable price	B1	audio/word_reasonable_price_bcf11aaf.mp3	ˈrizənəbəl praɪs	8ac30e42-14c6-4de5-b37f-ff130697fafb
ba4ef72e-04a0-4f34-be81-82b7234c1532	value for money	соответствие цены и качества	noun phrase	This restaurant offers excellent value for money	B1	audio/word_value_for_dc94bd20.mp3	ˈvælju fər ˈməni	8ac30e42-14c6-4de5-b37f-ff130697fafb
d7b80514-3ec0-41d0-9cee-3a578e556cb6	not bad	неплохо	adjective phrase	The food was not bad	B1	audio/word_not_bad_a2208d64.mp3	nɑt bæd	8ac30e42-14c6-4de5-b37f-ff130697fafb
62ed7ac2-867f-41c2-bcb0-292d953637cd	not quite right	не совсем правильно	phrase	Something is not quite right with my order.	A2	audio/word_not_quite_995d5c27.mp3	nɑt kwaɪt raɪt	ff71c086-af8b-4c46-94c9-818666e2fb06
4dcaceb6-184f-4009-8717-c6d3a9effb29	could you please	не могли бы вы, пожалуйста	phrase	Could you please replace this dish?	A1	audio/word_could_you_ac2c1e98.mp3	kʊd ju pliz	ff71c086-af8b-4c46-94c9-818666e2fb06
93eae01e-0ac5-4840-9e4d-6fd762a3c4dd	it's not what I ordered	это не то, что я заказывал	phrase	This is not what I ordered.	A2	audio/word_it's_not_43d2c03c.mp3	ɪts nɑt wət aɪ ˈɔrdərd	ff71c086-af8b-4c46-94c9-818666e2fb06
a0c434b5-46cc-4299-9ea0-d897952371f8	this is wrong	это неправильно	phrase	This dish is wrong.	A2	audio/word_this_is_7e4d0f6e.mp3	ðɪs ɪz rɔŋ	ff71c086-af8b-4c46-94c9-818666e2fb06
c8278fde-4d54-4e72-9cf9-aa02d0ec3575	it's undercooked	недоваренный	phrase	The fish is undercooked.	B1	audio/word_it's_undercooked_f0d22155.mp3	ɪts əndərˈkʊkt	ff71c086-af8b-4c46-94c9-818666e2fb06
75d7a47d-e5e7-4b4d-b685-8690baf7561f	it's overcooked	переваренный	phrase	The vegetables are overcooked.	B1	audio/word_it's_overcooked_4b6bb066.mp3	ɪts ˌoʊvərˈkʊkt	ff71c086-af8b-4c46-94c9-818666e2fb06
a6d045d3-2420-4adf-970f-1cce1d5c0b36	it's too salty	слишком солёный	phrase	The soup is too salty.	A2	audio/word_it's_too_b1ebb3df.mp3	ɪts tu ˈsɔlti	ff71c086-af8b-4c46-94c9-818666e2fb06
b7ad989f-a70d-4307-bb85-83928d0449be	it's too spicy	слишком острый	phrase	The curry is too spicy.	A2	audio/word_it's_too_f7424b6b.mp3	ɪts tu ˈspaɪsi	ff71c086-af8b-4c46-94c9-818666e2fb06
bcdc893d-7d58-4f9e-bcd7-36b18e99bf54	I'm not happy	я недоволен	phrase	I'm not happy with the service.	A2	audio/word_i'm_not_d6456e73.mp3	əm nɑt ˈhæpi	ff71c086-af8b-4c46-94c9-818666e2fb06
d46a2abc-a1a8-4e29-97d4-854684a40dc8	I'm not satisfied	я не удовлетворён	phrase	I'm not satisfied with my meal.	B1	audio/word_i'm_not_084071be.mp3	əm nɑt ˈsætɪsˌfaɪd	ff71c086-af8b-4c46-94c9-818666e2fb06
265afb2d-d92d-44a1-856c-f8c108679e01	I'm disappointed	я разочарован	phrase	I'm disappointed with the quality of the food.	B1	audio/word_i'm_disappointed_f823247a.mp3	əm ˌdɪsəˈpɔɪnɪd	ff71c086-af8b-4c46-94c9-818666e2fb06
152dd15e-749f-4f2b-8531-6771e1722bf4	a refund	возврат денег	noun	I would like a refund, please.	B1	audio/word_a_refund_171db0dd.mp3	ə ˈriˌfənd	ff71c086-af8b-4c46-94c9-818666e2fb06
57df382e-ff99-4811-8af2-f7ac972bdf3a	replacement	замена	noun	I'd like a replacement.	B1	audio/word_replacement_a50aa26f.mp3	rɪˈpleɪsmənt	ff71c086-af8b-4c46-94c9-818666e2fb06
80da7cc9-c2c8-4c69-8258-8a66600c4e31	I'm sorry to bother you	извините, что беспокою вас	phrase	I'm sorry to bother you, but...	A2	audio/word_i'm_sorry_d15405d7.mp3	əm ˈsɑri tɪ ˈbɑðər ju	ff71c086-af8b-4c46-94c9-818666e2fb06
7376d671-260c-4ee5-a65c-7dfc98976d29	excuse me	извините	interjection	Excuse me, waiter?	A1	audio/word_excuse_me_fc348138.mp3	ɪkˈskjuz mi	ff71c086-af8b-4c46-94c9-818666e2fb06
1f8f66c6-8953-4f2c-912f-05ee9f8bd562	waiter	официант	noun	Waiter!	A1	audio/word_waiter_fb891e4b.mp3	ˈweɪtər	ff71c086-af8b-4c46-94c9-818666e2fb06
16f47cf7-203a-43a9-88f8-6535347014a5	to complain	жаловаться	verb	I need to complain about the service.	B1	audio/word_to_complain_a3ac8900.mp3	tɪ kəmˈpleɪn	ff71c086-af8b-4c46-94c9-818666e2fb06
ee7c63a7-5d15-431f-9870-a03aca5c2808	sort it out	разбираться	phrasal verb	Could you sort it out?	B2	audio/word_sort_it_bc8845c4.mp3	sɔrt ɪt aʊt	ff71c086-af8b-4c46-94c9-818666e2fb06
34f3e9bb-8075-4eab-929b-e882d734bf49	to make a complaint	подать жалобу	phrase	I want to make a complaint.	B1	audio/word_to_make_efe4c9ac.mp3	tɪ meɪk ə kəmˈpleɪnt	ff71c086-af8b-4c46-94c9-818666e2fb06
03fc33bd-360f-4ba6-936e-4cccc187bc52	apologize	извиниться	verb	I apologize for the inconvenience.	B1	audio/word_apologize_1592e57b.mp3	əˈpɑləˌʤaɪz	ff71c086-af8b-4c46-94c9-818666e2fb06
853f802d-ab46-42a4-9820-1ce2431e2cfb	I appreciate it	я ценю это	phrase	I appreciate your help.	B1	audio/word_i_appreciate_1e943860.mp3	aɪ əˈpriʃiˌeɪt ɪt	ff71c086-af8b-4c46-94c9-818666e2fb06
27184eea-7ae9-4e74-8955-e921fa3516a8	thank you	спасибо	interjection	Thank you.	A1	audio/word_thank_you_848ab2c8.mp3	θæŋk ju	ff71c086-af8b-4c46-94c9-818666e2fb06
208a1a5f-9c0b-46d4-ac5e-042ffef875bd	please	пожалуйста	interjection	Please.	A1	audio/word_please_12cb1c4d.mp3	pliz	ff71c086-af8b-4c46-94c9-818666e2fb06
21007b10-313a-4845-adcd-65beec3c3e91	hello	Привет	interjection	Hello, how are you?	A1	audio/word_hello_4a7e94a3.mp3	hɛˈloʊ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
9635b0c3-5eb9-4b7a-9666-6b99271e481f	hi	Привет	interjection	Hi there!	A1	audio/word_hi_75282a12.mp3	haɪ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
21dadc35-e71e-4135-aa52-9f93d8bbe6a7	good morning	Доброе утро	noun phrase	Good morning, sir!	A1	audio/word_good_morning_057e1c8f.mp3	gʊd ˈmɔrnɪŋ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
6dbbd63e-ff99-4000-8cb7-9853bd180f77	good afternoon	Добрый день	noun phrase	Good afternoon, madam!	A1	audio/word_good_afternoon_b6b4df32.mp3	gʊd ˌæftərˈnun	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
1f4b9e97-57a7-4160-a018-61be26edec78	good evening	Добрый вечер	noun phrase	Good evening!	A1	audio/word_good_evening_789d1332.mp3	gʊd ˈivnɪŋ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
6e03db33-ffc5-4d58-8e0b-a3b92e3ec136	excuse me	Извините	interjection	Excuse me, do you speak English?	A1	audio/word_excuse_me_88024b5d.mp3	ɪkˈskjuz mi	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
50a726db-76cd-4695-b3c0-7d514778483c	sorry	Извините	interjection	Sorry, I didn't understand.	A1	audio/word_sorry_c8c1cb28.mp3	ˈsɑri	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
5a5a87fd-20a4-478f-a739-7eb6736ca96f	please	Пожалуйста	interjection	Please help me.	A1	audio/word_please_a532b02b.mp3	pliz	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
31f43b8c-73fa-47b5-99f8-c230f516478b	thank you	Спасибо	interjection	Thank you very much!	A1	audio/word_thank_you_642ea4f9.mp3	θæŋk ju	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
bf3986f5-5cf2-4895-8410-4ca3321fb805	you're welcome	Пожалуйста	phrase	You're welcome!	A1	audio/word_you're_welcome_c4a526d9.mp3	jʊr ˈwɛlkəm	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
576c3886-1859-4b7a-98bb-fdb9bc17b554	my name is	Меня зовут	phrase	My name is John.	A1	audio/word_my_name_df6d8262.mp3	maɪ neɪm ɪz	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
ae056de5-431b-4c7c-b68b-e86266ca9d8e	I'm...	Я...	phrase	I'm from America.	A1	audio/word_i'm..._c73b88a1.mp3	əm...	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
7294aa5a-d751-47ab-98be-caf8410544c9	where are you from?	Откуда вы?	phrase	Where are you from?	A1	audio/word_where_are_f82d5263.mp3	wɛr ər ju frəm?	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
b02f7c98-a1c3-4df9-8336-42e3be06364d	nice to meet you	Приятно познакомиться	phrase	Nice to meet you too!	A1	audio/word_nice_to_bcee2ff9.mp3	nis tɪ mit ju	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
8b8008af-42de-4f39-a9d0-4cd965feda29	it's a pleasure	Приятно познакомиться	phrase	It's a pleasure to meet you.	A1	audio/word_it's_a_e7893f4a.mp3	ɪts ə ˈplɛʒər	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
900b996b-c161-44b6-8c61-84022da725eb	how are you?	Как ваши дела?	phrase	How are you doing?	A1	audio/word_how_are_ec7fdab8.mp3	haʊ ər ju?	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
961f8365-329e-42b7-ae1f-faadb2f5f28e	I'm fine, thank you	Хорошо, спасибо	phrase	I'm fine, thank you.	A1	audio/word_i'm_fine,_169e927e.mp3	əm faɪn, θæŋk ju	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
9824f4e1-8029-4c49-8fab-634d49f21682	and you?	А вы?	phrase	And you?	A1	audio/word_and_you?_40577979.mp3	ənd ju?	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
cd8020da-7dbb-4463-901b-72e5f41a4a01	have a nice day	Хорошего дня	phrase	Have a nice day!	A1	audio/word_have_a_4ff70fb0.mp3	hæv ə nis deɪ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
2362b91b-1c4b-4e75-9542-6c2b693858e0	have a good flight	Приятного полёта	phrase	Have a good flight!	A1	audio/word_have_a_8bd93b94.mp3	hæv ə gʊd flaɪt	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
e623a6da-7d47-4c2b-b956-20c7e8f91b37	see you later	Увидимся позже	phrase	See you later!	A1	audio/word_see_you_d787c7b2.mp3	si ju ˈleɪtər	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
1742ea74-0a87-4326-9d0a-caa888169bdd	take care	Берегите себя	phrase	Take care!	A1	audio/word_take_care_73fa7a4e.mp3	teɪk kɛr	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
e013e45d-9226-47e1-8572-21853937517f	could you help me?	Не могли бы вы мне помочь?	phrase	Could you help me with my bag?	A2	audio/word_could_you_57f792c1.mp3	kʊd ju hɛlp mi?	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
829d0226-7fb1-4f0d-b60c-ff5a31699a74	I need help	Мне нужна помощь	phrase	I need help with my luggage.	A2	audio/word_i_need_93926b67.mp3	aɪ nid hɛlp	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
e708f8ee-e5fd-4ca0-9a80-d1a9a3cf077d	I don't understand	Я не понимаю	phrase	I don't understand what you're saying.	A2	audio/word_i_don't_a0261acd.mp3	aɪ doʊnt ˌəndərˈstænd	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
2f970c21-0567-4a71-b1f5-f5299b59d16b	what's your name?	Как вас зовут?	phrase	What's your name?	A2	audio/word_what's_your_fe54f6c6.mp3	wəts jʊr neɪm?	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
7ec032d8-6fba-42ac-9443-108719ce86a9	let me introduce myself	Разрешите представиться	phrase	Let me introduce myself, I'm John.	B1	audio/word_let_me_2a0b32eb.mp3	lɛt mi ˌɪntrəˈdus ˌmaɪˈsɛlf	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
46ea36b5-75cc-406a-90e9-b8b45fc5e2a9	goodbye	До свидания	interjection	Goodbye, it was nice meeting you!	A1	audio/word_goodbye_742261ce.mp3	ˌgʊdˈbaɪ	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
b2116a43-2036-4ce4-b9b1-a3c2048abcec	farewell	Прощай	interjection	Farewell, have a safe journey!	A1	audio/word_farewell_2322b0ed.mp3	ˌfɛrˈwɛl	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
dcca3c6d-d6d8-4bc4-a1b6-374cce4f5e71	see you later	Увидимся позже	phrase	See you later, I'll miss you!	A1	audio/word_see_you_e798ea58.mp3	si ju ˈleɪtər	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
5949766a-f433-4a96-b734-a899bfa03bf4	see you soon	Увидимся скоро	phrase	See you soon, take care!	A1	audio/word_see_you_2df3ea46.mp3	si ju sun	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
90b75259-8528-4c96-add6-c55f49a9ae5d	take care	Береги себя	phrase	Take care, and have a good flight!	A1	audio/word_take_care_ccae7193.mp3	teɪk kɛr	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
739ad12c-9dae-4128-8638-c9bd20443665	have a good flight	Хорошего полёта	phrase	Have a good flight and safe travels!	A1	audio/word_have_a_76fb7d79.mp3	hæv ə gʊd flaɪt	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
611a7c11-b57c-4c79-a12f-41152a021b50	safe travels	Счастливого пути	phrase	Safe travels, and I hope to see you again soon!	A1	audio/word_safe_travels_dd1bb26a.mp3	seɪf ˈtrævəlz	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
960f9f33-fc34-4be1-b33d-597c8c7261a9	all the best	Всего наилучшего	phrase	All the best, and enjoy your trip!	A1	audio/word_all_the_dad618c4.mp3	ɔl ðə bɛst	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
77b55a86-d753-4b90-bfd1-341475034d20	best wishes	Всего хорошего	phrase	Best wishes for a wonderful vacation!	A1	audio/word_best_wishes_23a9cbe2.mp3	bɛst ˈwɪʃɪz	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
77fc4789-6d56-4750-90bd-6c1110bea3ac	catch you later	Увидимся позже	phrase	Catch you later, don't forget to call!	B1	audio/word_catch_you_13e5750a.mp3	kæʧ ju ˈleɪtər	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
c883f9a4-577f-402f-9972-82079bd007fc	it was nice meeting you	Приятно было познакомиться	phrase	It was nice meeting you, I hope we'll meet again!	A2	audio/word_it_was_e7801090.mp3	ɪt wɑz nis ˈmitɪŋ ju	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
fd7b2d12-85df-4d15-aa0c-9b31cb946840	it was a pleasure meeting you	Было приятно познакомиться	phrase	It was a pleasure meeting you, I hope you have a great time!	B1	audio/word_it_was_184cb74e.mp3	ɪt wɑz ə ˈplɛʒər ˈmitɪŋ ju	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
f39d0f53-d1a4-41d2-b0ce-dbe6a83f5f69	have a great trip	Хорошей поездки	phrase	Have a great trip, and send us a postcard!	A2	audio/word_have_a_c8f44139.mp3	hæv ə greɪt trɪp	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
73b235eb-785a-4e5c-b62e-605ef076b18b	enjoy your flight	Приятного полёта	phrase	Enjoy your flight, and have a safe arrival!	A2	audio/word_enjoy_your_5fa6a381.mp3	ˌɛnˈʤɔɪ jʊr flaɪt	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
dbc93b16-bf24-46ab-9087-28f337620f8b	enjoy your journey	Приятного путешествия	phrase	Enjoy your journey and come back soon!	A2	audio/word_enjoy_your_e6543ba8.mp3	ˌɛnˈʤɔɪ jʊr ˈʤərni	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
67740bff-f902-4f49-b879-64911b58fa97	I hope to see you again	Надеюсь, мы снова увидимся	phrase	I hope to see you again, it's been a pleasure!	A2	audio/word_i_hope_c4613eca.mp3	aɪ hoʊp tɪ si ju əˈgɛn	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
0116f31b-210e-41ca-874f-e4bff0b8de06	I'll miss you	Я буду скучать по тебе	phrase	I'll miss you, but I'm happy for you!	A2	audio/word_i'll_miss_4113a48a.mp3	aɪl mɪs ju	84cb6e14-6ea0-4cdc-a7eb-8b90e6159249
3c939397-020b-4bc9-8a45-dfc9cb19cb1d	hello	Привет	interjection	Hello, how are you today?	A1	audio/word_hello_9b76a967.mp3	hɛˈloʊ	29039255-5042-4097-962a-8e640327db25
886eb150-1b8e-49d9-a476-0f30f03eba35	hi	Привет	interjection	Hi there!	A1	audio/word_hi_040e480c.mp3	haɪ	29039255-5042-4097-962a-8e640327db25
f0844c9b-5818-4203-9e25-9acd176d4e7b	good morning	Доброе утро	noun phrase	Good morning, sir/madam!	A1	audio/word_good_morning_d536f563.mp3	gʊd ˈmɔrnɪŋ	29039255-5042-4097-962a-8e640327db25
2756062a-8db6-410d-9c38-0603e02d66c0	good afternoon	Добрый день	noun phrase	Good afternoon, I need some help.	A1	audio/word_good_afternoon_ab9e4660.mp3	gʊd ˌæftərˈnun	29039255-5042-4097-962a-8e640327db25
b52cf7ab-7c0e-4ca8-83fc-232b74e23f86	good evening	Добрый вечер	noun phrase	Good evening, have a nice flight!	A1	audio/word_good_evening_ecbe4a7e.mp3	gʊd ˈivnɪŋ	29039255-5042-4097-962a-8e640327db25
7f44c6c2-777d-458a-a452-acaa93173a5c	excuse me	Извините	interjection	Excuse me, could you help me?	A1	audio/word_excuse_me_97cf81bb.mp3	ɪkˈskjuz mi	29039255-5042-4097-962a-8e640327db25
817a161b-1257-47bd-b32b-0653f2037db0	sorry	Извините	interjection	Sorry for the inconvenience.	A1	audio/word_sorry_5f9b68df.mp3	ˈsɑri	29039255-5042-4097-962a-8e640327db25
7688f223-5ba9-4907-bdeb-5236a599e47c	please	Пожалуйста	interjection	Please, show me your passport.	A1	audio/word_please_0778968e.mp3	pliz	29039255-5042-4097-962a-8e640327db25
f008bbc0-18e9-49bf-ab3e-0716134056f9	thank you	Спасибо	interjection	Thank you very much!	A1	audio/word_thank_you_bb14e29d.mp3	θæŋk ju	29039255-5042-4097-962a-8e640327db25
a6e36cfa-7a0d-4c3c-9852-b18097ffad1a	you're welcome	Пожалуйста	phrase	You're welcome!	A1	audio/word_you're_welcome_6ed3db04.mp3	jʊr ˈwɛlkəm	29039255-5042-4097-962a-8e640327db25
93edf865-14e1-4039-803c-08e18c23ca9e	have a nice day	Хорошего дня	phrase	Have a nice day!	A1	audio/word_have_a_b0d17cd1.mp3	hæv ə nis deɪ	29039255-5042-4097-962a-8e640327db25
78710cab-3593-4bb3-b386-8363519c5546	have a good flight	Хорошего полёта	phrase	Have a good flight!	A1	audio/word_have_a_798792d2.mp3	hæv ə gʊd flaɪt	29039255-5042-4097-962a-8e640327db25
2deab0d2-2a39-477e-84a6-be373ce803ca	have a nice trip	Хорошей поездки	phrase	Have a nice trip!	A1	audio/word_have_a_c480c491.mp3	hæv ə nis trɪp	29039255-5042-4097-962a-8e640327db25
e5a95261-c31c-42e6-85b7-fe9120910594	nice to meet you	Приятно познакомиться	phrase	Nice to meet you too!	A1	audio/word_nice_to_7f167db9.mp3	nis tɪ mit ju	29039255-5042-4097-962a-8e640327db25
b8675924-c6b2-4b4a-aa53-20fca3f0658d	how are you?	Как ваши дела?	phrase	How are you?	A1	audio/word_how_are_61919229.mp3	haʊ ər ju?	29039255-5042-4097-962a-8e640327db25
f58ba7c4-cd5e-4a0e-9b5f-c8a3e484cdbb	I'm fine, thank you	У меня всё хорошо, спасибо	phrase	I'm fine, thank you.	A1	audio/word_i'm_fine,_661a520b.mp3	əm faɪn, θæŋk ju	29039255-5042-4097-962a-8e640327db25
7bd093c5-7dea-4877-b6b8-82421793872e	and you?	А вы?	phrase	And you?	A1	audio/word_and_you?_42a9e23c.mp3	ənd ju?	29039255-5042-4097-962a-8e640327db25
b6c2187e-4516-432f-9743-b1ef278d6825	what's your name?	Как вас зовут?	phrase	What's your name?	A1	audio/word_what's_your_1d75eb2a.mp3	wəts jʊr neɪm?	29039255-5042-4097-962a-8e640327db25
481589df-b015-4030-95a9-33e70b4ff2f0	my name is...	Меня зовут...	phrase	My name is John.	A1	audio/word_my_name_17033866.mp3	maɪ neɪm ɪz...	29039255-5042-4097-962a-8e640327db25
c3eddcc6-d470-42f2-9740-d91c0218d457	it's a pleasure	Приятно	phrase	It's a pleasure to meet you.	A1	audio/word_it's_a_38bb4a04.mp3	ɪts ə ˈplɛʒər	29039255-5042-4097-962a-8e640327db25
1241ea51-4674-46c3-9ab4-c074dd0471ab	small talk	небольшая беседа	noun	We made small talk while waiting for the flight.	B1	audio/word_small_talk_51b9163d.mp3	smɔl tɔk	29039255-5042-4097-962a-8e640327db25
d473cdf7-30c9-46a2-83fb-3355632a7d03	flight details	информация о рейсе	noun phrase	Could you check my flight details?	B1	audio/word_flight_details_ff9af2d7.mp3	flaɪt ˈditeɪlz	29039255-5042-4097-962a-8e640327db25
cac56435-edb6-4dd0-ad21-4c845ccc756b	gate number	номер выхода	noun phrase	What's the gate number?	A2	audio/word_gate_number_e2c9a9e3.mp3	geɪt ˈnəmbər	29039255-5042-4097-962a-8e640327db25
1adb04ec-0306-4b24-b064-6211e80155d7	boarding time	время посадки	noun phrase	What time is boarding?	A2	audio/word_boarding_time_3c867706.mp3	ˈbɔrdɪŋ taɪm	29039255-5042-4097-962a-8e640327db25
59d4b43c-d732-423c-9303-d323b931b871	delayed flight	задержанный рейс	noun phrase	My flight is delayed.	B1	audio/word_delayed_flight_51fe7525.mp3	dɪˈleɪd flaɪt	29039255-5042-4097-962a-8e640327db25
c4e03f84-7913-46d5-8f53-a77e136daf1a	lost luggage	потерянный багаж	noun phrase	I have lost luggage.	B1	audio/word_lost_luggage_26000cce.mp3	lɔst ˈləgɪʤ	29039255-5042-4097-962a-8e640327db25
c15c5d7a-b776-458f-8e8b-ee09ff2d2ce4	check in	регистрироваться	verb	I need to check in.	A1	audio/word_check_in_9814f49e.mp3	ʧɛk ɪn	29039255-5042-4097-962a-8e640327db25
9eafca33-2bb1-4931-bfe8-7d37a7677ab0	look for	искать	phrasal verb	I'm looking for the gate.	A1	audio/word_look_for_1f88172d.mp3	lʊk fər	29039255-5042-4097-962a-8e640327db25
ecfaea8a-e0c9-474f-8224-9b408f69fe95	look after	присматривать за	phrasal verb	Could you look after my bags?	B1	audio/word_look_after_a5184d18.mp3	lʊk ˈæftər	29039255-5042-4097-962a-8e640327db25
e25169e2-7537-4a73-9bb4-26e6e9299e52	look up	найти информацию	phrasal verb	Let me look up the flight schedule.	B1	audio/word_look_up_f5b56256.mp3	lʊk əp	29039255-5042-4097-962a-8e640327db25
c295cdef-05b6-4119-90e7-ccd76ec6163c	set off	отправляться	phrasal verb	We're going to set off soon.	B1	audio/word_set_off_6bdaa9b4.mp3	sɛt ɔf	29039255-5042-4097-962a-8e640327db25
775a0e63-74f1-49c8-b3f0-a6e77643c168	take off	взлетать	phrasal verb	When does the plane take off?	A2	audio/word_take_off_9cec5b1f.mp3	teɪk ɔf	29039255-5042-4097-962a-8e640327db25
ca53b244-44e1-483f-8344-fbbda8989ec3	get on	садиться (в транспорт)	phrasal verb	Let's get on the plane.	A2	audio/word_get_on_25ba9176.mp3	gɪt ɔn	29039255-5042-4097-962a-8e640327db25
eb1f44b9-13a0-4a69-bf49-95d77bc7acb4	get off	выходить (из транспорта)	phrasal verb	When do we get off?	A2	audio/word_get_off_11a1c5eb.mp3	gɪt ɔf	29039255-5042-4097-962a-8e640327db25
e003cb98-12de-433e-a19f-8262538fd43f	catch a flight	улететь	phrasal verb	I need to catch a flight.	B1	audio/word_catch_a_cf315221.mp3	kæʧ ə flaɪt	29039255-5042-4097-962a-8e640327db25
618a1a3f-0e9b-4728-8e43-0c0bf2ad5d1e	flight	рейс	noun	My flight is delayed.	A1	audio/word_flight_4392397a.mp3	flaɪt	9175c742-633c-4a95-a574-391bfe0a36ad
c05d6e43-4128-4986-9230-f3162eed7376	miss a flight	пропустить рейс	phrasal verb	I don't want to miss my flight.	B1	audio/word_miss_a_22814234.mp3	mɪs ə flaɪt	29039255-5042-4097-962a-8e640327db25
3bffe0a3-2486-4de6-8c9b-3538b3b0fe3c	go through	проходить	phrasal verb	Go through security.	A2	audio/word_go_through_d070e069.mp3	goʊ θru	29039255-5042-4097-962a-8e640327db25
aa350fba-c9db-47bb-a918-7b31b9b27541	come across	встретить(ся)	phrasal verb	I came across an old friend at the airport.	B1	audio/word_come_across_12ee2fcd.mp3	kəm əˈkrɔs	29039255-5042-4097-962a-8e640327db25
96102115-806b-4fed-add3-e18c8a6ef925	Excuse me	Извините	interjection	Excuse me, could you help me?	A1	audio/word_excuse_me_bf2e7de4.mp3	ɪkˈskjuz mi	74e29385-e700-4a34-95e4-9c39f5396ad7
d320e71b-fd7e-49f2-b08a-760ee439755a	Could you help me?	Не могли бы вы мне помочь?	phrase	Could you help me find something?	A1	audio/word_could_you_ab6baf96.mp3	kʊd ju hɛlp mi?	74e29385-e700-4a34-95e4-9c39f5396ad7
5ce4dec0-2793-41d4-a556-57e09698ec0f	I need help	Мне нужна помощь	phrase	I need help finding a specific item	A1	audio/word_i_need_51a827e0.mp3	aɪ nid hɛlp	74e29385-e700-4a34-95e4-9c39f5396ad7
e008037b-4a59-40bd-993d-25b454293d21	I'm looking for	Я ищу	phrase	I'm looking for a red dress	A2	audio/word_i'm_looking_83349943.mp3	əm ˈlʊkɪŋ fər	74e29385-e700-4a34-95e4-9c39f5396ad7
19994b46-61b2-4831-829d-b60098b4b9b1	Do you have?	У вас есть?	phrase	Do you have this in a different size?	A1	audio/word_do_you_4dcee56d.mp3	du ju hæv?	74e29385-e700-4a34-95e4-9c39f5396ad7
37c39247-3f0f-4942-939a-3ebc98781ec6	Where is?	Где находится?	phrase	Where is the men's department?	A1	audio/word_where_is?_3fd95d2b.mp3	wɛr ɪz?	74e29385-e700-4a34-95e4-9c39f5396ad7
828d7038-5596-40ac-827b-31a8b240d3c0	Can I see?	Могу ли я посмотреть?	phrase	Can I see that shirt?	A2	audio/word_can_i_ed9c9043.mp3	kən aɪ si?	74e29385-e700-4a34-95e4-9c39f5396ad7
901dacbf-ed6b-43a1-bbdb-6d2b4419f379	Show me	Покажите мне	verb	Show me the blue shoes	A1	audio/word_show_me_1c022499.mp3	ʃoʊ mi	74e29385-e700-4a34-95e4-9c39f5396ad7
bd77a5af-32ec-4eb1-b8f8-22f4b07c3fb3	This one	Этот	pronoun	I'll take this one	A1	audio/word_this_one_9058925e.mp3	ðɪs wən	74e29385-e700-4a34-95e4-9c39f5396ad7
174be8e4-881d-4fc7-be13-e095b88ed538	That one	Тот	pronoun	I prefer that one	A1	audio/word_that_one_068ca5de.mp3	ðət wən	74e29385-e700-4a34-95e4-9c39f5396ad7
5a23bfb9-08f2-4e6a-b40c-a1b67e86805c	Over there	Там	adverb	The shoes are over there	A1	audio/word_over_there_687d4ae1.mp3	ˈoʊvər ðɛr	74e29385-e700-4a34-95e4-9c39f5396ad7
d0e46dd5-a867-4ba2-9a5a-e1e98038dc84	Right here	Прямо здесь	adverb	The dress is right here	A1	audio/word_right_here_c18708d6.mp3	raɪt hir	74e29385-e700-4a34-95e4-9c39f5396ad7
ebd415df-9388-4d5c-9b36-5edd20bc815d	Over here	Здесь	adverb	Come over here	A1	audio/word_over_here_f79d404e.mp3	ˈoʊvər hir	74e29385-e700-4a34-95e4-9c39f5396ad7
ff8fe13e-97f8-49ee-8d84-b60eea78e32b	This way	Сюда	phrase	Please go this way	A1	audio/word_this_way_ae100429.mp3	ðɪs weɪ	74e29385-e700-4a34-95e4-9c39f5396ad7
48572d28-d6a7-492f-a489-7f2d53850a1b	Help me find	Помогите мне найти	phrase	Help me find a gift for my wife	A2	audio/word_help_me_83417809.mp3	hɛlp mi faɪnd	74e29385-e700-4a34-95e4-9c39f5396ad7
20fffecb-4f62-4b43-ab93-93bbab6834ce	I can't find	Я не могу найти	phrase	I can't find the fitting room	A2	audio/word_i_can't_767fe1bb.mp3	aɪ kænt faɪnd	74e29385-e700-4a34-95e4-9c39f5396ad7
86b069af-2582-461b-b2d5-7f23d34cae9c	fitting room	примерочная	noun	Where is the fitting room?	A2	audio/word_fitting_room_f0cb0ff5.mp3	ˈfɪtɪŋ rum	74e29385-e700-4a34-95e4-9c39f5396ad7
0369b024-46f0-40fe-9829-ca612a5f7a10	I need help with	Мне нужна помощь с	phrase	I need help with choosing a colour	A2	audio/word_i_need_4fbb1cf2.mp3	aɪ nid hɛlp wɪθ	74e29385-e700-4a34-95e4-9c39f5396ad7
77ae45a8-ff5f-4596-8505-62bb45d73313	sizes	размеры	noun	What sizes do you have?	A2	audio/word_sizes_a648b8c6.mp3	ˈsaɪzɪz	74e29385-e700-4a34-95e4-9c39f5396ad7
a222f53b-c637-45ad-b16d-810d7b6b751f	colours	цвета	noun	What colours do you have?	A2	audio/word_colours_b3054f95.mp3	colours*	74e29385-e700-4a34-95e4-9c39f5396ad7
8d961097-6d31-4e19-ac27-6dc6e1744383	price	цена	noun	What is the price?	A1	audio/word_price_9e01d456.mp3	praɪs	74e29385-e700-4a34-95e4-9c39f5396ad7
3d43a1d8-e3b3-43c4-8f39-5e03ed876964	How much is it?	Сколько это стоит?	phrase	How much is this?	A1	audio/word_how_much_add99782.mp3	haʊ məʧ ɪz ɪt?	74e29385-e700-4a34-95e4-9c39f5396ad7
5e2766a4-9984-488b-b818-bce627b2d1ab	it's too expensive	это слишком дорого	phrase	It's too expensive for me	B1	audio/word_it's_too_5f87a4d8.mp3	ɪts tu ɪkˈspɛnsɪv	74e29385-e700-4a34-95e4-9c39f5396ad7
2a9bf479-ff8e-4a15-ad03-55f621ac004f	That's fine	Всё в порядке	phrase	That's fine, thank you	A2	audio/word_that's_fine_3f7fdb5a.mp3	ðæts faɪn	74e29385-e700-4a34-95e4-9c39f5396ad7
3e116fdb-c111-4969-9046-e2d44b7ae563	Thank you	Спасибо	interjection	Thank you for your help	A1	audio/word_thank_you_a8936daf.mp3	θæŋk ju	74e29385-e700-4a34-95e4-9c39f5396ad7
9a9ae259-2906-4ca7-ae47-d5ff40abf577	You're welcome	Пожалуйста	phrase	You're welcome	A1	audio/word_you're_welcome_0cbc9e1c.mp3	jʊr ˈwɛlkəm	74e29385-e700-4a34-95e4-9c39f5396ad7
729d2719-62cf-46ff-bcc1-dd3721f77ac6	No problem	Нет проблем	phrase	No problem at all	A2	audio/word_no_problem_b4dbcc5a.mp3	noʊ ˈprɑbləm	74e29385-e700-4a34-95e4-9c39f5396ad7
af2d4619-452b-4d81-9a10-c2f19ae450d1	Certainly	Конечно	adverb	Certainly, I'll help you	B1	audio/word_certainly_c2cefef4.mp3	ˈsərtənli	74e29385-e700-4a34-95e4-9c39f5396ad7
367b2a41-1bd8-44b2-8521-c96471f6842f	excuse_me	извините	interjection	Excuse me, could you help me?	A1	audio/word_excuse_me_8d9c3eab.mp3	excuse_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
930ef1c3-23ae-49e0-8b31-28ffef6e9a70	help	помощь	verb	I need help with my luggage	A1	audio/word_help_93e066ee.mp3	hɛlp	ae3a4133-4763-4ef9-9dd1-107700f3d88b
cefce49d-87e0-47c3-b1fd-2b7eb5171aab	lost	потерянный	adjective	I'm lost	A1	audio/word_lost_8f76ddcf.mp3	lɔst	ae3a4133-4763-4ef9-9dd1-107700f3d88b
a4849aad-63f0-40eb-93de-4821555f8f3d	direction	направление	noun	Can you give me directions?	A1	audio/word_direction_14a78691.mp3	dɪˈrɛkʃɪn	ae3a4133-4763-4ef9-9dd1-107700f3d88b
11f3fb5a-a54a-43dd-88c7-27c68a238ac0	street	улица	noun	Which street is this?	A1	audio/word_street_6efd2824.mp3	strit	ae3a4133-4763-4ef9-9dd1-107700f3d88b
dbbd0bca-3f67-4ab1-9799-17e678f28b0c	lost_and_found	бюро находок	noun	Is there a lost and found?	A1	audio/word_lost_and_found_95f4b4b5.mp3	lost_and_found*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
a9bfa8a2-c0bc-442f-b6f7-0e3195f4ccdd	ask_for_help	просить о помощи	verb	I need to ask for help	A1	audio/word_ask_for_help_eac670b3.mp3	ask_for_help*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
6e387ab0-953b-4474-8613-7bd7858cc52c	need_help	нуждаться в помощи	verb	I need help finding the train station	A1	audio/word_need_help_2102cf12.mp3	need_help*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
89353667-251c-465a-bb9b-d2c82bc06095	can_you_help_me	вы можете мне помочь	phrase	Can you help me with this?	A1	audio/word_can_you_help_me_1d2d11ce.mp3	can_you_help_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
2c244230-30b6-4585-81d6-6b1da921f193	could_you_help_me	не могли бы вы мне помочь	phrase	Could you help me carry this?	A1	audio/word_could_you_help_me_cf12e4ec.mp3	could_you_help_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
210579c0-c36d-45fd-929c-5a22947d1013	please_help_me	пожалуйста, помогите мне	phrase	Please help me, I'm lost	A1	audio/word_please_help_me_2dbac61f.mp3	please_help_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
339308b1-24ca-460a-af30-a7fd68b5c681	where_is	где находится	phrase	Where is the nearest bus stop?	A1	audio/word_where_is_9abdd273.mp3	where_is*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
a03d08b1-9c38-4a9b-9ac2-5d8466ee5826	how_to_get_to	как добраться до	phrase	How to get to the airport?	A1	audio/word_how_to_get_to_75ed02c3.mp3	how_to_get_to*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
7890c057-c77e-4e4d-882f-7a358a4fe910	point_the_way	указывать путь	verb	Could you point me the way?	A1	audio/word_point_the_way_853d7316.mp3	point_the_way*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
188ef08b-8619-4ac0-9f54-21fa6dd339ef	show_me	показать мне	verb	Show me the way, please.	A1	audio/word_show_me_6865f45f.mp3	show_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
9347cde4-5bec-4998-9c03-a1aafd2aaf43	find	находить	verb	I can't find my way	A1	audio/word_find_18c3bb74.mp3	faɪnd	ae3a4133-4763-4ef9-9dd1-107700f3d88b
6fb71aea-fad7-4051-a7d1-6c2528183b58	get_lost	заблудиться	verb	I got lost	A1	audio/word_get_lost_3644864d.mp3	get_lost*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
53629cf1-2f27-409f-b37a-3f4d84759da1	look_for	искать	verb	I'm looking for the information desk	A1	audio/word_look_for_046f8570.mp3	look_for*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
8d912dcb-2c3a-48f3-88d6-7117d2ac57e7	address	адрес	noun	What's your address?	A1	audio/word_address_ff5888b8.mp3	ˈæˌdrɛs	ae3a4133-4763-4ef9-9dd1-107700f3d88b
2f9b037e-fce7-4df9-906e-358da0a6f531	tell_me	сказать мне	verb	Tell me how to get there	A1	audio/word_tell_me_6c3d6699.mp3	tell_me*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
389fc381-2f09-483f-8c64-9935aeeb0eae	nearby	рядом	adverb	Is there a hotel nearby?	A1	audio/word_nearby_80d67d3c.mp3	ˈnɪrˈbaɪ	ae3a4133-4763-4ef9-9dd1-107700f3d88b
cd296cc3-ad63-409c-96ba-84d43ad20a0d	go_straight	идти прямо	verb	Go straight ahead	A1	audio/word_go_straight_8438deb5.mp3	go_straight*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
2e8ff220-21c3-4594-9190-27f0bbb47ddd	turn_left	повернуть налево	verb	Turn left at the corner	A1	audio/word_turn_left_7601a862.mp3	turn_left*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
bb3f0bba-f90a-4e09-b90d-4532bc10147a	turn_right	повернуть направо	verb	Turn right at the traffic lights	A1	audio/word_turn_right_a1f0f201.mp3	turn_right*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
6f39527f-4097-498b-8ea4-f106a1bb8b90	take_a_left	свернуть налево	verb	Take a left at the next junction	A1	audio/word_take_a_left_2b344789.mp3	take_a_left*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
a1b1fee6-0fb4-4ccd-b326-af52f5b413c6	take_a_right	свернуть направо	verb	Take a right at the next junction	A1	audio/word_take_a_right_6c354b4a.mp3	take_a_right*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
c690b418-9650-4634-bbe7-d68fcc9c1525	I'm_sorry	извините	phrase	I'm sorry, I'm lost	A1	audio/word_i'm_sorry_f3f9a7cc.mp3	i'm_sorry*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
7f23e80f-831a-4d6b-b057-f98af0fdd640	I_don't_understand	я не понимаю	phrase	I don't understand	A1	audio/word_i_don't_understand_6b41586d.mp3	i_don't_understand*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
d2b504d8-5652-4450-b0b0-7bced1060995	thank_you	спасибо	interjection	Thank you very much	A1	audio/word_thank_you_98f8606a.mp3	thank_you*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
86c2bd51-f75d-4776-baa6-8e7ee01bca5c	you're_welcome	пожалуйста	phrase	You're welcome	A1	audio/word_you're_welcome_3f779a11.mp3	you're_welcome*	ae3a4133-4763-4ef9-9dd1-107700f3d88b
88057b6b-d5f8-44d8-982a-da862c54f8d7	help	помощь	noun	I need help	A1	audio/word_help_995c120b.mp3	hɛlp	727d5b3c-850a-400a-8590-6511de3ca195
183d121d-3f4c-4048-8327-474a50e46c4d	assistance	помощь	noun	Can I get some assistance?	A1	audio/word_assistance_4c230e7c.mp3	əˈsɪstəns	727d5b3c-850a-400a-8590-6511de3ca195
927f7a82-a310-4392-8ec8-6c78e99ec4b1	lost	потерянный	adjective	My passport is lost	A1	audio/word_lost_50cb0bd4.mp3	lɔst	727d5b3c-850a-400a-8590-6511de3ca195
6c6b5fbe-d4f7-4aec-b235-77519c2369d6	stolen	украденный	adjective	My wallet was stolen	A1	audio/word_stolen_70038834.mp3	ˈstoʊlən	727d5b3c-850a-400a-8590-6511de3ca195
be8c0960-203a-4fcf-b0bf-3b30df1a6c04	report	сообщать	verb	I need to report a crime	A1	audio/word_report_09da21aa.mp3	rɪˈpɔrt	727d5b3c-850a-400a-8590-6511de3ca195
008bec9c-502d-4260-a546-1d6b40366a55	police officer	полицейский	noun	Can I speak to a police officer?	A1	audio/word_police_officer_b8009c76.mp3	pəˈlis ˈɔfɪsər	727d5b3c-850a-400a-8590-6511de3ca195
9415176c-8627-4a6f-b07b-48d61f077f67	emergency	экстренная ситуация	noun	This is an emergency	A1	audio/word_emergency_facdb0d0.mp3	ˈimərʤənsi	727d5b3c-850a-400a-8590-6511de3ca195
2199d25e-a5ce-42d1-a56b-83f3bbae3a47	urgent	срочный	adjective	This is urgent	A1	audio/word_urgent_d8b38293.mp3	ˈərʤənt	727d5b3c-850a-400a-8590-6511de3ca195
d9d717dc-1655-4897-ab56-0ab0bcc6e400	explain	объяснять	verb	Can you explain what happened?	A2	audio/word_explain_4a4a523b.mp3	ɪkˈspleɪn	727d5b3c-850a-400a-8590-6511de3ca195
909ce7f7-a383-4a12-812f-0cb691f28678	what happened?	что случилось?	phrase	What happened?	A2	audio/word_what_happened?_25f3d89e.mp3	wət ˈhæpənd?	727d5b3c-850a-400a-8590-6511de3ca195
875393c2-4822-461c-8d3c-68c3ca28801e	details	подробности	noun	Can you give me some details?	A2	audio/word_details_103ee908.mp3	ˈditeɪlz	727d5b3c-850a-400a-8590-6511de3ca195
8cf1d01a-6df8-4547-ba40-3fa406ac3cea	situation	ситуация	noun	Can you describe the situation?	A2	audio/word_situation_aa43500f.mp3	ˌsɪʧuˈeɪʃən	727d5b3c-850a-400a-8590-6511de3ca195
f5afc6ee-cee2-4899-a590-9cab5189d42f	witness	свидетель	noun	Were there any witnesses?	A2	audio/word_witness_d8b1a0af.mp3	ˈwɪtnəs	727d5b3c-850a-400a-8590-6511de3ca195
b50ea320-eb29-413b-a357-227d135b097f	crime	преступление	noun	I have been the victim of a crime	A2	audio/word_crime_dd45d1dc.mp3	kraɪm	727d5b3c-850a-400a-8590-6511de3ca195
f3e4820c-04de-4d9b-aca5-e23625357dbb	information	информация	noun	I need some information	A2	audio/word_information_86153841.mp3	ˌɪnˌfɔrˈmeɪʃən	727d5b3c-850a-400a-8590-6511de3ca195
1b108346-b6f2-4aba-8bf2-f2a9393f7198	statement	заявление	noun	I need to make a statement	B1	audio/word_statement_1a31f310.mp3	ˈsteɪtmənt	727d5b3c-850a-400a-8590-6511de3ca195
36fb1173-4c2e-4edf-a605-3630ab2d41b6	file a report	подать заявление	phrase	I need to file a report	B1	audio/word_file_a_f998d141.mp3	faɪl ə rɪˈpɔrt	727d5b3c-850a-400a-8590-6511de3ca195
ce96915f-8e0b-4e92-b389-558018e7b74c	investigation	расследование	noun	The police are conducting an investigation	B1	audio/word_investigation_4b98a606.mp3	ˌɪnˌvɛstəˈgeɪʃən	727d5b3c-850a-400a-8590-6511de3ca195
4e47505c-7f86-4e46-a0e7-5093e93fe88e	evidence	доказательства	noun	Do you have any evidence?	B1	audio/word_evidence_8a94b663.mp3	ˈɛvədəns	727d5b3c-850a-400a-8590-6511de3ca195
ce453f7f-32a0-48a1-983d-76a9a9190cf0	suspect	подозреваемый	noun	Do you know the suspect?	B1	audio/word_suspect_6ad84185.mp3	ˈsəˌspɛkt	727d5b3c-850a-400a-8590-6511de3ca195
0123a4c7-7830-451b-833a-37c8aa4748a5	identification	удостоверение личности	noun	Can I see your identification?	B1	audio/word_identification_fb5f61b4.mp3	aɪˌdɛntəfəˈkeɪʃən	727d5b3c-850a-400a-8590-6511de3ca195
33f81ea9-84a7-4195-97be-51774c62fd26	emergency	экстренная ситуация	noun	There's a medical emergency.	A2	audio/word_emergency_6730baf3.mp3	ˈimərʤənsi	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
b2f09c6c-662f-492c-96ba-bcc4f46c74cc	medical help	медицинская помощь	noun phrase	I need medical help.	A2	audio/word_medical_help_008d2a5a.mp3	ˈmɛdɪkəl hɛlp	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
d6d09b43-e00c-4fc1-bb21-6913240eadfb	call for help	вызвать помощь	verb phrase	Please call for help.	B1	audio/word_call_for_8702d82b.mp3	kɔl fər hɛlp	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
83f5373b-b270-4946-a3ff-069aa637a2d1	first aid	первая помощь	noun phrase	Do you know first aid?	A2	audio/word_first_aid_21826d05.mp3	fərst eɪd	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
a4d28515-0853-4079-ae6d-e2ba34c32018	injured person	пострадавший	noun phrase	There's an injured person.	A2	audio/word_injured_person_1d4f8604.mp3	ˈɪnʤərd ˈpərsən	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
865b5d83-dda8-4de5-93fe-e47ab46ec45e	seek help	обратиться за помощью	verb phrase	You should seek help immediately.	B1	audio/word_seek_help_53ca2a9a.mp3	sik hɛlp	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
56b96015-fd81-498f-bcd0-406629e5f26e	get help	получить помощь	verb phrase	I need to get help.	A2	audio/word_get_help_d7f4a0c1.mp3	gɪt hɛlp	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
c1846c1f-b549-49e8-aeba-234e0313b073	urgent care	срочная медицинская помощь	noun phrase	He needs urgent care.	B1	audio/word_urgent_care_5d08f499.mp3	ˈərʤənt kɛr	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
2f4de225-e80b-4f85-b4be-bdc06127fe75	feel unwell	чувствовать себя плохо	verb phrase	I feel unwell.	A2	audio/word_feel_unwell_9a4d9619.mp3	fil ənˈwɛl	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
4a06def3-5945-454f-8982-a19d261917e0	have an accident	попасть в аварию	verb phrase	Someone has had an accident.	A1	audio/word_have_an_13dc7e19.mp3	hæv ən ˈæksədənt	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
ef2d5a3c-684a-4277-8217-67a9290b3aec	severe pain	сильная боль	noun phrase	I'm in severe pain.	B1	audio/word_severe_pain_2894916e.mp3	səˈvɪr peɪn	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
080b181a-5e62-4182-a128-23693d75dc2a	serious injury	серьезное ранение	noun phrase	It's a serious injury.	B1	audio/word_serious_injury_527229e8.mp3	ˈsɪriəs ˈɪnʤəri	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
ba0562d9-20c4-41bd-b5d5-ccc38988f8d3	cut	порез	noun	I have a deep cut.	A2	audio/word_cut_2b1b7fd9.mp3	kət	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
999330c2-fde2-4e23-a5ee-1e9ced19f171	bleed	кровоточить	verb	My arm is bleeding.	A2	audio/word_bleed_c73c842a.mp3	blid	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
a54b2c94-f91b-46a4-af7b-85b4bd308ee9	faint	обморок	verb	I think I'm going to faint.	A2	audio/word_faint_7555d736.mp3	feɪnt	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
9db50788-40bd-4699-a683-2a9b82a7e07c	short of breath	задыхаюсь	adjective phrase	I'm short of breath.	B1	audio/word_short_of_8165c1b0.mp3	ʃɔrt əv brɛθ	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
68d46896-8945-4c56-ab3b-df6dd88219a3	allergic reaction	аллергическая реакция	noun phrase	I'm having an allergic reaction.	B1	audio/word_allergic_reaction_99202e80.mp3	əˈlərʤɪk riˈækʃən	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
6fdc0d68-a3f1-4012-afde-4684a9bf7b1e	asthma attack	приступ астмы	noun phrase	I'm having an asthma attack.	B1	audio/word_asthma_attack_2829dba0.mp3	ˈæzmə əˈtæk	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
b9e11719-f1ee-4f66-a524-c1e982bf6f71	chest pain	боль в груди	noun phrase	I have chest pain.	B1	audio/word_chest_pain_d598707a.mp3	ʧɛst peɪn	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
f31f9f89-3df2-4ef1-aa36-24de57af8acf	help me	помогите мне	verb phrase	Help me, please!	A1	audio/word_help_me_d5c08dba.mp3	hɛlp mi	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
af4ed353-b93e-4118-8141-74ba93258dd9	I need a doctor	мне нужен врач	sentence	I need a doctor, please.	A2	audio/word_i_need_d5bd63cb.mp3	aɪ nid ə ˈdɔktər	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
97f01972-d21b-4e99-9c4b-0f62bb00707e	call an ambulance	вызвать скорую помощь	verb phrase	Call an ambulance!	A2	audio/word_call_an_3788018e.mp3	kɔl ən ˈæmbjələns	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
a35a7fba-6021-4d54-a117-9e9761444115	emergency services	службы экстренной помощи	noun phrase	Dial emergency services.	A2	audio/word_emergency_services_fcd170a0.mp3	ˈimərʤənsi ˈsərvɪsɪz	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
7061564f-4b62-42a6-bc4c-e1de0c0217c3	stay calm	сохраняйте спокойствие	verb phrase	Please stay calm.	A2	audio/word_stay_calm_7d2cd777.mp3	steɪ kɑm	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
44819475-1b7b-4a1e-9814-abcff4f0bbe8	what happened?	что случилось?	sentence	What happened?	A1	audio/word_what_happened?_45d04d4a.mp3	wət ˈhæpənd?	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
91789b54-6405-47d5-b64f-913f97f6db9e	where's the nearest hospital?	где ближайшая больница?	sentence	Where's the nearest hospital?	A2	audio/word_where's_the_17c32481.mp3	wɛrz ðə ˈnɪrəst ˈhɑˌspɪtəl?	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
860b521d-39d9-4ce4-9ba4-fd81c5cea924	medical staff	медицинский персонал	noun phrase	Call medical staff.	B1	audio/word_medical_staff_4fb69c81.mp3	ˈmɛdɪkəl stæf	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
8b6c4202-92cc-439e-8840-c24b09a12130	first-aid kit	аптечка первой помощи	noun phrase	Where's the first-aid kit?	B1	audio/word_first-aid_kit_633dc34c.mp3	first-aid* kɪt	4605b4b3-bdb1-4ded-92ec-45a5d42389b2
63b9a276-733a-411f-b649-0c370297b0c9	lost	потерянный	adjective	My passport is lost.	A1	audio/word_lost_825cbb2b.mp3	lɔst	9175c742-633c-4a95-a574-391bfe0a36ad
9d3050b8-78dd-4b96-97b6-32b97bad6b2d	passport	паспорт	noun	I need to find my passport.	A1	audio/word_passport_fb135f76.mp3	ˈpæˌspɔrt	9175c742-633c-4a95-a574-391bfe0a36ad
1906da46-d066-43ed-ad53-737d2ebd276d	help	помощь	verb	Can you help me?	A1	audio/word_help_3f5c767a.mp3	hɛlp	9175c742-633c-4a95-a574-391bfe0a36ad
0748a10a-dc0d-490d-ac5a-542b48c1e8d1	emergency	экстренная ситуация	noun	This is an emergency!	A1	audio/word_emergency_f0bde35a.mp3	ˈimərʤənsi	9175c742-633c-4a95-a574-391bfe0a36ad
23db1dba-39c9-4a4c-b19f-a456460cbda4	police	полиция	noun	I need to go to the police.	A1	audio/word_police_d160c981.mp3	pəˈlis	9175c742-633c-4a95-a574-391bfe0a36ad
50814274-19c3-45e7-a3b5-b8a8a5ebfd05	ambassador	посол	noun	Contact your country's ambassador.	B1	audio/word_ambassador_73dfca7f.mp3	æmˈbæsədər	9175c742-633c-4a95-a574-391bfe0a36ad
b057b636-b168-478b-9631-889f39cd2b1f	embassy	посольство	noun	Go to your embassy.	B1	audio/word_embassy_a95496b2.mp3	ˈɛmbəsi	9175c742-633c-4a95-a574-391bfe0a36ad
76dd5a33-3fa3-426a-bd13-088abe663216	report	сообщить	verb	Report the lost passport.	B1	audio/word_report_2172daae.mp3	rɪˈpɔrt	9175c742-633c-4a95-a574-391bfe0a36ad
1f576400-37a7-4944-8e75-e43acaffb970	fill out	заполнить	phrasal verb	Fill out this form.	B1	audio/word_fill_out_6dc81c85.mp3	fɪl aʊt	9175c742-633c-4a95-a574-391bfe0a36ad
57842462-de6a-4787-a2e9-f6c926189081	form	форма	noun	I need a form to report it.	A2	audio/word_form_b2736d57.mp3	fɔrm	9175c742-633c-4a95-a574-391bfe0a36ad
5020944e-cf97-454d-ae2e-635d1e189eae	immediately	немедленно	adverb	I need help immediately.	A2	audio/word_immediately_609a50eb.mp3	ˌɪˈmiˌdiətli	9175c742-633c-4a95-a574-391bfe0a36ad
d6011648-7fac-4999-9a36-f426a3dc777e	right away	сразу же	phrase	I need to do this right away.	A2	audio/word_right_away_b51f6b7a.mp3	raɪt əˈweɪ	9175c742-633c-4a95-a574-391bfe0a36ad
7b4be1de-3207-4d2f-80ce-a3177cfa35e8	as soon as possible	как можно скорее	phrase	Please help me as soon as possible.	B1	audio/word_as_soon_29e5f949.mp3	ɛz sun ɛz ˈpɑsəbəl	9175c742-633c-4a95-a574-391bfe0a36ad
fbf54b7e-3530-42f0-a472-e621c817fdd6	officer	офицер	noun	Talk to an officer.	A2	audio/word_officer_e055f096.mp3	ˈɔfɪsər	9175c742-633c-4a95-a574-391bfe0a36ad
a9bd92f9-4f12-4dac-9f0f-0c499c87da03	situation	ситуация	noun	Explain your situation.	A2	audio/word_situation_e551c0be.mp3	ˌsɪʧuˈeɪʃən	9175c742-633c-4a95-a574-391bfe0a36ad
8c6c78b2-6461-4d4b-bded-eefcde5fd2ae	calm down	успокоиться	phrasal verb	Try to calm down.	A2	audio/word_calm_down_e44e728b.mp3	kɑm daʊn	9175c742-633c-4a95-a574-391bfe0a36ad
a6106bcc-cd36-4f74-abbf-ea68cebcbc94	panic	паниковать	verb	Don't panic.	A2	audio/word_panic_d7d4b9e0.mp3	ˈpænɪk	9175c742-633c-4a95-a574-391bfe0a36ad
845df52a-8272-47d7-a27f-e9539bf01f49	explain	объяснить	verb	Can you explain what happened?	A2	audio/word_explain_9442575b.mp3	ɪkˈspleɪn	9175c742-633c-4a95-a574-391bfe0a36ad
e8bb0bb0-89d0-444d-bdcb-8c3c813c8465	what happened?	что случилось?	phrase	What happened?	A1	audio/word_what_happened?_00230214.mp3	wət ˈhæpənd?	9175c742-633c-4a95-a574-391bfe0a36ad
4b2a008d-aa7f-4fa3-93ed-a81382d651f4	what to do	что делать?	phrase	I don't know what to do.	A1	audio/word_what_to_fa361b70.mp3	wət tɪ du	9175c742-633c-4a95-a574-391bfe0a36ad
a431ab08-0ec6-4787-808a-f385e615ec54	get through	связаться	phrasal verb	I need to get through to the embassy.	B1	audio/word_get_through_a600d4d1.mp3	gɪt θru	9175c742-633c-4a95-a574-391bfe0a36ad
f80746b9-c8b1-469e-8bf0-21bdc7da8c51	call	звонить	verb	Call the embassy.	A1	audio/word_call_29f97d6e.mp3	kɔl	9175c742-633c-4a95-a574-391bfe0a36ad
40dfd210-0e02-4b64-abf0-93736960f925	contact	связаться	verb	Contact them immediately.	A2	audio/word_contact_cc48c5ff.mp3	ˈkɑnˌtækt	9175c742-633c-4a95-a574-391bfe0a36ad
a0275aca-8326-4a93-80c2-e57d38625bb4	identification	документ удостоверения личности	noun	Do you have any other identification?	B1	audio/word_identification_9415d66e.mp3	aɪˌdɛntəfəˈkeɪʃən	9175c742-633c-4a95-a574-391bfe0a36ad
bc21106b-d711-47b9-9fa2-fad062a03409	proof	доказательство	noun	This is proof of my identity.	B1	audio/word_proof_3b23ea22.mp3	pruf	9175c742-633c-4a95-a574-391bfe0a36ad
ac06fc98-8cfe-430f-9325-f1ee77fb6c25	stolen	украденный	adjective	My bag is stolen!	A2	audio/word_stolen_dde192da.mp3	ˈstoʊlən	7b5a0280-b2dd-43e8-9926-9668e269f55e
67639f43-35b1-46d6-afaa-9e159ad0c107	report	сообщать	verb	Report it to the police	A2	audio/word_report_8072ab50.mp3	rɪˈpɔrt	7b5a0280-b2dd-43e8-9926-9668e269f55e
f8c29dc1-36e4-487b-a84f-756945063952	missing	пропавший	adjective	My passport is missing!	A2	audio/word_missing_f7f83658.mp3	ˈmɪsɪŋ	7b5a0280-b2dd-43e8-9926-9668e269f55e
f6616255-8693-486a-a766-5ad7eb7bc32b	lost	потерянный	adjective	I've lost my wallet!	A2	audio/word_lost_bb1a09de.mp3	lɔst	7b5a0280-b2dd-43e8-9926-9668e269f55e
bdd5a455-e7ef-4938-ba56-bc8281fb71dc	immediately	немедленно	adverb	Call the police immediately!	A2	audio/word_immediately_1c0ff46f.mp3	ˌɪˈmiˌdiətli	7b5a0280-b2dd-43e8-9926-9668e269f55e
3d213fe4-94a4-455f-97ac-ce3ad4355575	police officer	полицейский	noun	Ask a police officer for help	A2	audio/word_police_officer_fae5d200.mp3	pəˈlis ˈɔfɪsər	7b5a0280-b2dd-43e8-9926-9668e269f55e
1f8dabae-4b9e-4c6a-87b7-34c04264b396	help	помогать	verb	Can you help me?	A2	audio/word_help_dc66df64.mp3	hɛlp	7b5a0280-b2dd-43e8-9926-9668e269f55e
0546aef7-2515-47e0-8b6b-a4d8ba5118aa	emergency	экстренная ситуация	noun	This is an emergency!	B1	audio/word_emergency_445a5ae3.mp3	ˈimərʤənsi	7b5a0280-b2dd-43e8-9926-9668e269f55e
d6f42ddd-3566-4b4a-8afd-5cec774bbb2a	urgent	срочный	adjective	It's urgent!	B1	audio/word_urgent_1e25878c.mp3	ˈərʤənt	7b5a0280-b2dd-43e8-9926-9668e269f55e
f2365c33-3401-4e16-8d1d-3eb158d0c8a8	assistance	помощь	noun	I need assistance!	B1	audio/word_assistance_21509e26.mp3	əˈsɪstəns	7b5a0280-b2dd-43e8-9926-9668e269f55e
11a78a9b-27ff-45b4-8c3c-315c776d2626	security	безопасность	noun	Go to security	B1	audio/word_security_331e6acf.mp3	sɪˈkjʊrəti	7b5a0280-b2dd-43e8-9926-9668e269f55e
69162d08-ddbc-44c4-bcdd-8338d030e605	find	находить	verb	Can you help me find my bag?	B1	audio/word_find_673b146d.mp3	faɪnd	7b5a0280-b2dd-43e8-9926-9668e269f55e
484eece2-fbc4-4b12-b64c-7e8343e8d5be	look for	искать	phrasal verb	I'm looking for my passport	B1	audio/word_look_for_9399e745.mp3	lʊk fər	7b5a0280-b2dd-43e8-9926-9668e269f55e
764cbeb1-4e37-4b9b-b0c9-ead68c9935c4	call	звонить	verb	Call the airport security	A1	audio/word_call_75bbd016.mp3	kɔl	7b5a0280-b2dd-43e8-9926-9668e269f55e
c43d7ef9-a4d1-40b2-ae1e-fb9a009770ae	panic	паниковать	verb	Don't panic!	B1	audio/word_panic_8e3f2d18.mp3	ˈpænɪk	7b5a0280-b2dd-43e8-9926-9668e269f55e
07f4b01a-d3d4-4015-bd9a-4c6b8b1a672a	stay calm	сохранять спокойствие	verb	Try to stay calm	B1	audio/word_stay_calm_9737a104.mp3	steɪ kɑm	7b5a0280-b2dd-43e8-9926-9668e269f55e
6a071a4c-5975-485f-bcb3-461662836697	describe	описывать	verb	Describe the thief to the police	B1	audio/word_describe_c6ae2b3c.mp3	dɪˈskraɪb	7b5a0280-b2dd-43e8-9926-9668e269f55e
5544dbf3-376a-447e-9db8-94a02b55cb56	details	подробности	noun	Give them all the details	B1	audio/word_details_40eef177.mp3	ˈditeɪlz	7b5a0280-b2dd-43e8-9926-9668e269f55e
cc7c6abb-2abb-424d-bfce-bba6acf2c532	valuable	ценный	adjective	I had valuable items in my bag	B1	audio/word_valuable_e76094b5.mp3	ˈvæljəbəl	7b5a0280-b2dd-43e8-9926-9668e269f55e
dee0ab30-1ffb-4f88-b3d4-ce5e9c272a40	witness	свидетель	noun	Were there any witnesses?	B1	audio/word_witness_11283e01.mp3	ˈwɪtnəs	7b5a0280-b2dd-43e8-9926-9668e269f55e
abe2c9fa-ad82-4003-a01a-5fbca5dbf71e	statement	заявление	noun	I need to make a statement	B1	audio/word_statement_c7b13c84.mp3	ˈsteɪtmənt	7b5a0280-b2dd-43e8-9926-9668e269f55e
b58f47b7-eea1-4203-ac1f-06c0d1586b4d	thief	вор	noun	The thief ran away	B1	audio/word_thief_623e4774.mp3	θif	7b5a0280-b2dd-43e8-9926-9668e269f55e
1ee87fba-9205-45bd-8633-38e5568f781d	robbery	грабеж	noun	This is a robbery!	B2	audio/word_robbery_6491fe9d.mp3	ˈrɑbəri	7b5a0280-b2dd-43e8-9926-9668e269f55e
dc2b63c3-0787-4c61-a5df-9618b553df58	property	имущество	noun	My property was stolen	B2	audio/word_property_58c01388.mp3	ˈprɑpərti	7b5a0280-b2dd-43e8-9926-9668e269f55e
149b4a5d-8623-4c10-b168-c42c59b21ab8	filing a report	подача заявления	noun phrase	Filing a report is essential	B2	audio/word_filing_a_eaa4a1db.mp3	ˈfaɪlɪŋ ə rɪˈpɔrt	7b5a0280-b2dd-43e8-9926-9668e269f55e
16e18283-a698-4762-801c-cc0f6666a077	investigate	расследовать	verb	The police will investigate	B2	audio/word_investigate_ccbb10ea.mp3	ˌɪnˈvɛstəˌgeɪt	7b5a0280-b2dd-43e8-9926-9668e269f55e
fac763b9-49aa-43e9-804a-b3e8b39c54a8	procedure	процедура	noun	What's the procedure?	B2	audio/word_procedure_824edb40.mp3	prəˈsiʤər	7b5a0280-b2dd-43e8-9926-9668e269f55e
d286208c-4146-44fe-bf44-873ca96b9a02	thorough	тщательный	adjective	A thorough investigation is required	B2	audio/word_thorough_de98bd0f.mp3	θəroʊ	7b5a0280-b2dd-43e8-9926-9668e269f55e
af5e6462-fdcb-4b5e-ab63-1cf0556673a0	fire alarm	пожарный сигнал	noun	The fire alarm went off	A2	audio/word_fire_alarm_c3aab07e.mp3	faɪər əˈlɑrm	7093071d-fa66-4cda-9463-dd99ade6f956
cfeeabd2-15a8-419b-9f18-55ee1c4c7da7	emergency exit	аварийный выход	noun	We need to find the emergency exit	A2	audio/word_emergency_exit_580bd053.mp3	ˈimərʤənsi ˈɛksət	7093071d-fa66-4cda-9463-dd99ade6f956
5c7aacb7-7419-410c-84ec-f9bdcde41eb3	escape route	путь эвакуации	noun	Follow the escape route	B1	audio/word_escape_route_8d577c92.mp3	ɪˈskeɪp rut	7093071d-fa66-4cda-9463-dd99ade6f956
8e37bf92-fdc5-4731-b8f7-e89e3e1fc8d6	get out	выходить	phrasal verb	Get out of the building quickly!	A1	audio/word_get_out_0d315e1a.mp3	gɪt aʊt	7093071d-fa66-4cda-9463-dd99ade6f956
66b37853-90e5-4bca-acd8-c6495b66bb56	evacuate	эвакуировать	verb	The passengers were evacuated	B1	audio/word_evacuate_c7290636.mp3	ɪˈvækjəˌeɪt	7093071d-fa66-4cda-9463-dd99ade6f956
3675b990-6e0f-4e25-b64f-9a72db333369	stay calm	сохранять спокойствие	phrase	Stay calm and follow instructions	A2	audio/word_stay_calm_cd0cabf5.mp3	steɪ kɑm	7093071d-fa66-4cda-9463-dd99ade6f956
36044cdd-9d1e-48b0-bb8c-0205680e241a	follow instructions	следовать инструкциям	phrase	Follow the instructions of the airport staff	A2	audio/word_follow_instructions_c445dd3e.mp3	ˈfɑloʊ ˌɪnˈstrəkʃənz	7093071d-fa66-4cda-9463-dd99ade6f956
c2465656-da63-40e5-b5f4-099eccac0564	help someone	помочь кому-то	phrase	Help someone who needs assistance	A2	audio/word_help_someone_84dd84dc.mp3	hɛlp ˈsəmˌwən	7093071d-fa66-4cda-9463-dd99ade6f956
95f962c2-9760-486d-8287-2d512c33e6ff	call for help	позвать на помощь	phrase	Call for help immediately	A2	audio/word_call_for_864074ac.mp3	kɔl fər hɛlp	7093071d-fa66-4cda-9463-dd99ade6f956
34cb030b-6a78-4761-b4f7-2264d01364ad	first aid	первая помощь	noun	Do you know first aid?	B1	audio/word_first_aid_dfa33e9d.mp3	fərst eɪd	7093071d-fa66-4cda-9463-dd99ade6f956
ac682d5d-6e41-4bc4-bb69-2dbc732a909f	injured person	пострадавший	noun	There's an injured person over there	B1	audio/word_injured_person_229f502a.mp3	ˈɪnʤərd ˈpərsən	7093071d-fa66-4cda-9463-dd99ade6f956
0c467e1c-40e8-4dfa-94a2-2f44b5105371	accident	несчастный случай	noun	There's been an accident	A2	audio/word_accident_13537961.mp3	ˈæksədənt	7093071d-fa66-4cda-9463-dd99ade6f956
97480b73-838e-4d44-8db6-721ab19de251	report the incident	сообщить о происшествии	phrase	Report the incident to the authorities	B1	audio/word_report_the_0d34c4bf.mp3	rɪˈpɔrt ðə ˈɪnsədənt	7093071d-fa66-4cda-9463-dd99ade6f956
33f2f8fc-62da-4c39-a5d1-2dcb13d05a0d	assistance	помощь	noun	Do you need assistance?	B1	audio/word_assistance_60ba461d.mp3	əˈsɪstəns	7093071d-fa66-4cda-9463-dd99ade6f956
e37ca722-bbba-4f6c-8715-3b99d96144cc	seek help	обратиться за помощью	phrase	Seek help from the airport staff	B1	audio/word_seek_help_3c2784ca.mp3	sik hɛlp	7093071d-fa66-4cda-9463-dd99ade6f956
b8a47cf7-933d-4ab8-bb85-7dddb51b60b7	take cover	укрыться	phrase	Take cover immediately!	B1	audio/word_take_cover_dea24e7b.mp3	teɪk ˈkəvər	7093071d-fa66-4cda-9463-dd99ade6f956
b502b4da-4746-44e1-ac2e-68869cc28fc6	run away	убегать	phrasal verb	Run away from the smoke	A1	audio/word_run_away_ada1f80a.mp3	rən əˈweɪ	7093071d-fa66-4cda-9463-dd99ade6f956
c10b8dcb-93a4-4ccf-a5af-b16923d57419	be careful	будьте осторожны	phrase	Be careful!	A1	audio/word_be_careful_007cd3ec.mp3	bi ˈkɛrfəl	7093071d-fa66-4cda-9463-dd99ade6f956
fdc08720-2766-4e7a-bcdb-38ce77f0171f	what happened?	что случилось?	phrase	What happened?	A1	audio/word_what_happened?_2e93138b.mp3	wət ˈhæpənd?	7093071d-fa66-4cda-9463-dd99ade6f956
fbd44310-9aad-49b5-8fcb-2a7067269721	I need help	мне нужна помощь	phrase	I need help!	A1	audio/word_i_need_43a68863.mp3	aɪ nid hɛlp	7093071d-fa66-4cda-9463-dd99ade6f956
4d2a9f19-8bda-49d9-88e9-733721d18c61	weight	вес	noun	What is the weight of this bag?	A2	audio/word_weight_5f4bc527.mp3	weɪt	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
ecfd8933-6d77-47da-bc6a-5be59f1ce9c9	measure	измерять	verb	Can you measure the length of the counter?	A2	audio/word_measure_a35f209c.mp3	ˈmɛʒər	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
74680972-7ae7-461b-b05c-6aad19baaf3b	pounds	фунты	noun	This weighs five pounds	A2	audio/word_pounds_7af996d6.mp3	paʊnz	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
59b2381c-2510-4982-9bfb-181c6f14e846	kilograms	килограммы	noun	It weighs ten kilograms	A2	audio/word_kilograms_d1836fdb.mp3	ˈkɪləˌgræmz	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
1b678c19-56bc-4a8d-ada8-8e7546fac1cc	ounces	унции	noun	The package weighs six ounces	B1	audio/word_ounces_b680c8bb.mp3	ˈaʊnsɪz	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
3709341e-2344-40f9-9854-f46298e1a8db	grams	граммы	noun	This is 200 grams of cheese	B1	audio/word_grams_28e4112b.mp3	græmz	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
0b99b19a-360a-40e9-9513-6e9baa2ed96c	scale	весы	noun	Let's use the scale to weigh this	A2	audio/word_scale_bf4bf316.mp3	skeɪl	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
192bf663-1e01-464d-a5e9-b6201973739c	weigh	взвешивать	verb	I need to weigh my luggage	A2	audio/word_weigh_480608e1.mp3	weɪ	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
96c659ca-89c4-4af2-9f2a-a28f8a8b7206	check the weight	проверить вес	verb phrase	Please check the weight of your bags	A2	audio/word_check_the_b1d1d32b.mp3	ʧɛk ðə weɪt	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
3fb777b1-33d7-44ba-b2d2-f1d08211f888	too heavy	слишком тяжёлый	adjective	This bag is too heavy	A2	audio/word_too_heavy_76cbfcac.mp3	tu ˈhɛvi	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
169b27a0-19ae-469d-b6d1-f1cd3d7e79c1	overweight	сверхвеса	adjective	My luggage is overweight	B1	audio/word_overweight_01098725.mp3	ˌoʊvərˈweɪt	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
1f980f71-ee56-4c4b-b916-7f0981238f8d	underweight	легче нормы	adjective	The package is underweight	B1	audio/word_underweight_b70b68f7.mp3	ˈəndərˌweɪt	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
68412f50-ba33-48aa-b90c-353f2205c71d	price per pound/kilogram	цена за фунт/килограмм	noun phrase	What's the price per kilogram?	B1	audio/word_price_per_dce3ede1.mp3	praɪs pər pound/kilogram*	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
789ea806-fc1c-4305-81a8-574376e5f136	unit price	цена за единицу	noun phrase	Can I see the unit price?	B1	audio/word_unit_price_88a51869.mp3	ˈjunɪt praɪs	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
f1cf7480-cab7-4649-a324-1f1b3109c939	grocery shopping	продуктовый шопинг	noun phrase	I'm going grocery shopping	A2	audio/word_grocery_shopping_7305fc21.mp3	ˈgroʊsəri ˈʃɑpɪŋ	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
82b043eb-3756-4f57-82ea-941cf5423c5c	shopping list	список покупок	noun phrase	I have a shopping list	A2	audio/word_shopping_list_e87e0b7b.mp3	ˈʃɑpɪŋ lɪst	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
749d407e-69ba-49be-bb1a-8c2f061b9e37	checkout	касса	noun	Go to checkout number three	A1	audio/word_checkout_a1357bba.mp3	ˈʧɛˌkaʊt	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
f8b84c02-f10f-4787-b846-d17a69cd3602	checkout counter	кассовый аппарат	noun phrase	There's a long queue at the checkout counter	A2	audio/word_checkout_counter_25bc8c25.mp3	ˈʧɛˌkaʊt ˈkaʊntər	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
c07a24e1-5cf3-48e0-a23e-61057d0d3784	scan	сканировать	verb	They will scan your items	B1	audio/word_scan_1f537fbd.mp3	skæn	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
c1033c2e-7d72-46cf-93fc-300a8d2ba3ac	bagging area	зона упаковки	noun phrase	I'll meet you at the bagging area	B1	audio/word_bagging_area_89a657c8.mp3	ˈbægɪŋ ˈɛriə	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
c3a7b2da-2d67-4736-a01e-44eeb8852e4d	self-checkout	самообслуживание	noun phrase	I prefer the self-checkout	B1	audio/word_self-checkout_ebe3dd81.mp3	self-checkout*	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
0c2979c4-811a-4eb4-8d40-4cceadaead77	till	касса	noun	The till is broken	A2	audio/word_till_1c2760e0.mp3	tɪl	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
7692f01d-c036-42d0-8a8c-eb31ed0e43d1	receipt	чек	noun	Here's your receipt	A1	audio/word_receipt_28311bbc.mp3	rɪˈsit	fc81b67c-8e5d-42c6-b1c4-f5b97adae10a
70f73962-1faa-47ad-8f5b-25c3f0efdb60	how much is this?	Сколько это стоит?	phrase	How much is this apple?	A1	audio/word_how_much_df73a30a.mp3	haʊ məʧ ɪz ðɪs?	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
c0f0f2eb-549b-4a3d-ba0d-5334033e2ef8	how much does it cost?	Сколько это стоит?	phrase	How much does it cost?	A1	audio/word_how_much_a47cc03f.mp3	haʊ məʧ dɪz ɪt kɔst?	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
6c882398-3435-44b1-b6dc-120a30067412	the price of...	цена...	phrase	What's the price of this bread?	A2	audio/word_the_price_2d7ada24.mp3	ðə praɪs əv...	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
7f58a005-dc8b-4d80-8d94-5bee858c7d1b	price	цена	noun	What's the price?	A1	audio/word_price_d7ba025b.mp3	praɪs	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
f675d0bd-a707-4a00-a559-17de192ce307	expensive	дорогой	adjective	This is too expensive!	A2	audio/word_expensive_90d05f33.mp3	ɪkˈspɛnsɪv	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
a69f1cc5-9614-4f92-b4f0-cb96e01051de	cheap	дешёвый	adjective	This is very cheap!	A2	audio/word_cheap_784c2da4.mp3	ʧip	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
488a4a7f-65be-4d60-b47e-c016fce8ad36	a little bit expensive	немного дороговато	phrase	It's a little bit expensive.	A2	audio/word_a_little_b1376958.mp3	ə ˈlɪtəl bɪt ɪkˈspɛnsɪv	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
c6935bd3-f123-49a2-ac28-9b6ea75ba810	reasonable price	разумная цена	phrase	That's a reasonable price.	B1	audio/word_reasonable_price_425d169a.mp3	ˈrizənəbəl praɪs	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
690f2f41-174c-4aee-8f0e-2d06f97ac0ec	bargain	выгодная покупка	noun	I got a good bargain.	B1	audio/word_bargain_52a051cb.mp3	ˈbɑrgɪn	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
f384d4e8-86c0-4869-9a66-bdfbecfdeefc	overpriced	завышенная цена	adjective	I think it's overpriced.	B2	audio/word_overpriced_45acfc07.mp3	ˈoʊvərˌpraɪst	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
8d4d31c9-40d9-414b-af41-81d04f97e5d2	affordable	доступный по цене	adjective	Is this affordable?	B1	audio/word_affordable_be3e3bf8.mp3	əˈfɔrdəbəl	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
aa817426-daed-458b-b91f-24bbdf258cda	can I pay by card?	Могу ли я заплатить картой?	phrase	Can I pay by card?	A2	audio/word_can_i_3155d9b6.mp3	kən aɪ peɪ baɪ kɑrd?	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
7d1fe5ef-a3e3-4543-a3ed-051ab44bcf95	cash	наличные	noun	Do you accept cash?	A1	audio/word_cash_1caadf94.mp3	kæʃ	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
846e881b-f1ad-4300-ab6d-502f3922357b	discount	скидка	noun	Do you have any discounts?	B1	audio/word_discount_e182582a.mp3	ˈdɪskaʊnt	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
6728dc4a-9c20-43d1-9397-2d62edfc79b0	on sale	на распродаже	phrase	It's on sale.	B1	audio/word_on_sale_70e63279.mp3	ɔn seɪl	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
df120169-884c-4c70-a6f1-ba351582419c	total	итого	noun	What's the total?	A2	audio/word_total_9b1175da.mp3	ˈtoʊtəl	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
0541b492-8241-4ead-af2b-8ebe0e01e7cf	receipt	чек	noun	Can I have a receipt, please?	A2	audio/word_receipt_012fd7f1.mp3	rɪˈsit	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
9b9555ac-ff57-4868-8d48-1106377dad66	look at the prices	посмотрите на цены	phrase	Can I look at the prices?	A2	audio/word_look_at_ee986079.mp3	lʊk æt ðə ˈpraɪsɪz	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
c0124f64-aa40-4979-9881-25a6976615f8	I'd like to buy...	Я хотел бы купить...	phrase	I'd like to buy some milk.	A1	audio/word_i'd_like_4396295b.mp3	aɪd laɪk tɪ baɪ...	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
ccdef437-eeb9-4346-8975-86a94b465459	I'll take...	Я возьму...	phrase	I'll take these apples.	A1	audio/word_i'll_take..._c917ec48.mp3	aɪl teɪk...	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
31fa15c7-621c-4f23-926e-eb69f9c2b13e	it's a bit pricey	это немного дорого	phrase	It's a bit pricey for me	B1	audio/word_it's_a_ba9c4403.mp3	ɪts ə bɪt ˈpraɪsi	3d4b489c-e18e-423d-bcfa-b9f3a09fb4e8
cdbedd7f-d65e-46f4-a8b7-58a59f9fb00e	grocery	продукты	noun	I need to go to the grocery store	A1	audio/word_grocery_dfee0813.mp3	ˈgroʊsəri	b45f9a53-fe24-416b-b245-a6cae3a536b3
a032a9f4-696a-44f9-9072-c5a33c92b891	shopping list	список покупок	noun	Do you have a shopping list?	A1	audio/word_shopping_list_d0ac98d0.mp3	ˈʃɑpɪŋ lɪst	b45f9a53-fe24-416b-b245-a6cae3a536b3
1ceef11b-1a02-4f7d-b61f-b8825a282102	aisle	проход	noun	The bread is in aisle 3	A2	audio/word_aisle_6eb21bc5.mp3	aɪəl	b45f9a53-fe24-416b-b245-a6cae3a536b3
a5897aa3-91e5-43c5-b918-af22682965a2	checkout	касса	noun	Let's go to the checkout	A1	audio/word_checkout_208b8583.mp3	ˈʧɛˌkaʊt	b45f9a53-fe24-416b-b245-a6cae3a536b3
ce9cbfa3-614a-4012-95f0-92f6ca2d47b6	fresh produce	свежие продукты	noun	The fresh produce section is over there	A2	audio/word_fresh_produce_c9612350.mp3	frɛʃ ˈproʊdus	b45f9a53-fe24-416b-b245-a6cae3a536b3
a33d091f-39d7-4fb7-bd29-289497f45826	canned goods	консервы	noun	We need some canned goods	A2	audio/word_canned_goods_bb5de5ee.mp3	kænd gʊdz	b45f9a53-fe24-416b-b245-a6cae3a536b3
4feded42-5130-492a-8860-ffc5d11d286f	dairy products	молочные продукты	noun	The dairy products are in the fridge	A2	audio/word_dairy_products_008a6565.mp3	ˈdɛri ˈprɑdəkts	b45f9a53-fe24-416b-b245-a6cae3a536b3
a8127b66-3bd3-42bc-a757-ed42f2c8c2c2	frozen foods	мороженные продукты	noun	I like buying frozen foods	A2	audio/word_frozen_foods_60541db6.mp3	ˈfroʊzən fudz	b45f9a53-fe24-416b-b245-a6cae3a536b3
6ac567cc-2f8f-431e-97f0-bc8733ab9ffd	meat counter	мясной прилавок	noun	The meat counter is very busy	A2	audio/word_meat_counter_100f7fad.mp3	mit ˈkaʊntər	b45f9a53-fe24-416b-b245-a6cae3a536b3
00a17d17-8453-4ae7-87b9-09b30f534a6e	checkout counter	касса	noun	There's a long line at the checkout counter	A2	audio/word_checkout_counter_3e904c66.mp3	ˈʧɛˌkaʊt ˈkaʊntər	b45f9a53-fe24-416b-b245-a6cae3a536b3
7e9cb3fb-8526-4bd3-8fe2-04f038ea0996	discount	скидка	noun	There's a discount on apples	A2	audio/word_discount_8d6cbf51.mp3	ˈdɪskaʊnt	b45f9a53-fe24-416b-b245-a6cae3a536b3
452e7b2c-d94b-4fee-a04b-31eac0a886ff	pay	платить	verb	How will you pay?	A1	audio/word_pay_86c74935.mp3	peɪ	b45f9a53-fe24-416b-b245-a6cae3a536b3
8fd80cbb-bc29-466d-b582-7afce75256f7	credit card	кредитная карта	noun	I'll pay by credit card	A1	audio/word_credit_card_17024dd7.mp3	ˈkrɛdɪt kɑrd	b45f9a53-fe24-416b-b245-a6cae3a536b3
4f79a7ab-a40b-4c79-81a0-81c8f4269b29	cash	наличные	noun	I'll pay with cash	A1	audio/word_cash_55905887.mp3	kæʃ	b45f9a53-fe24-416b-b245-a6cae3a536b3
0ebc95d6-50df-404e-a53d-d32fa15a1a30	receipt	чек	noun	Here's your receipt	A1	audio/word_receipt_900ef920.mp3	rɪˈsit	b45f9a53-fe24-416b-b245-a6cae3a536b3
9deb433e-56dc-4f72-84d4-d676c38550e6	self-checkout	самообслуживание	noun	I'll use the self-checkout	A2	audio/word_self-checkout_8365bc16.mp3	self-checkout*	b45f9a53-fe24-416b-b245-a6cae3a536b3
6c874159-f491-4afd-8a7d-3251736ed778	scan	сканировать	verb	Scan your items	A2	audio/word_scan_1266f241.mp3	skæn	b45f9a53-fe24-416b-b245-a6cae3a536b3
27248749-0ce7-45b2-a5c2-63141ea1e801	pack	упаковывать	verb	Pack your groceries carefully	A2	audio/word_pack_b61a34e6.mp3	pæk	b45f9a53-fe24-416b-b245-a6cae3a536b3
7d8ad0d0-42ec-4374-ac46-95f8b995edf5	souvenir	сувенир	noun	I bought a lovely souvenir from the market	A2	audio/word_souvenir_c5016f00.mp3	ˌsuvəˈnɪr	ffb2f11d-06ce-406d-be45-c42643eb3c19
e0c52d3d-1ab2-48bc-a2b6-8fec59abea1a	market	рынок	noun	The local market has amazing crafts	A1	audio/word_market_2e98a099.mp3	ˈmɑrkɪt	ffb2f11d-06ce-406d-be45-c42643eb3c19
dcf4c13e-6406-4d51-8f8d-11677b714cbd	haggle	торговаться	verb	I like to haggle for a better price	B1	audio/word_haggle_57587cb8.mp3	ˈhægəl	ffb2f11d-06ce-406d-be45-c42643eb3c19
622fda80-f4b0-4f2d-bcad-e863a5d3953e	bargain	выгодная покупка	noun	That's a real bargain!	B1	audio/word_bargain_0d356d88.mp3	ˈbɑrgɪn	ffb2f11d-06ce-406d-be45-c42643eb3c19
b87d05bf-f6f6-4ff4-8bcb-d51f99c45f74	bargain	торговаться	verb	Let's bargain for a lower price	B1	audio/word_bargain_2c272f4f.mp3	ˈbɑrgɪn	ffb2f11d-06ce-406d-be45-c42643eb3c19
92121269-336f-4a81-99b8-9988c0b53b25	negotiate	договариваться	verb	We negotiated the price down by 20%	B2	audio/word_negotiate_f9ce70d6.mp3	nɪˈgoʊʃiˌeɪt	ffb2f11d-06ce-406d-be45-c42643eb3c19
db63b081-1aa8-400f-838b-d7a94f89d8f7	price	цена	noun	What's the price of this?	A1	audio/word_price_7d518064.mp3	praɪs	ffb2f11d-06ce-406d-be45-c42643eb3c19
e9be2d90-3dd7-441e-be03-66b8fdd7b4e7	cheap	дешёвый	adjective	It's very cheap!	A2	audio/word_cheap_4a40f51d.mp3	ʧip	ffb2f11d-06ce-406d-be45-c42643eb3c19
c274aed2-1b65-49d7-8ffe-dbde79987519	expensive	дорогой	adjective	That's too expensive!	A2	audio/word_expensive_c7092365.mp3	ɪkˈspɛnsɪv	ffb2f11d-06ce-406d-be45-c42643eb3c19
45912b94-59ba-4ae4-a217-e7b7b4d69206	too much	слишком дорого	phrase	That's too much money	A2	audio/word_too_much_c7d88ea5.mp3	tu məʧ	ffb2f11d-06ce-406d-be45-c42643eb3c19
0c4f7a6f-59fa-4822-8191-03b2cab1341a	reasonable	разумный	adjective	That's a reasonable price	B1	audio/word_reasonable_b120f268.mp3	ˈrizənəbəl	ffb2f11d-06ce-406d-be45-c42643eb3c19
7e8715ee-32a2-4b28-9311-d8d7280efe35	a bit too much	немного слишком дорого	phrase	I think it's a bit too much	B1	audio/word_a_bit_bd00a5a7.mp3	ə bɪt tu məʧ	ffb2f11d-06ce-406d-be45-c42643eb3c19
71a75362-63a9-4679-97c0-cbae149c19f3	come down	снизить(цену)	phrasal verb	Can you come down on the price?	B1	audio/word_come_down_c93adaef.mp3	kəm daʊn	ffb2f11d-06ce-406d-be45-c42643eb3c19
e89521b1-56d1-49e1-9e23-292a7d7b16eb	a little less	немного меньше	phrase	Could you do it for a little less?	B1	audio/word_a_little_2ab11398.mp3	ə ˈlɪtəl lɛs	ffb2f11d-06ce-406d-be45-c42643eb3c19
b7276086-621d-4d58-8578-ff699a3262f9	make an offer	сделать предложение	phrase	I'll make you an offer	B2	audio/word_make_an_b142a7cf.mp3	meɪk ən ˈɔfər	ffb2f11d-06ce-406d-be45-c42643eb3c19
077a73e4-1492-4bc0-b4b0-e94045975564	accept	принимать	verb	I accept your offer	B1	audio/word_accept_555ddf7e.mp3	əkˈsɛpt	ffb2f11d-06ce-406d-be45-c42643eb3c19
3de6652c-0f13-4ce0-b4e5-07b996ef2772	decline	отклонять	verb	I'll decline your offer	B2	audio/word_decline_434e7081.mp3	dɪˈklaɪn	ffb2f11d-06ce-406d-be45-c42643eb3c19
e8ef1297-54eb-4431-8448-62fcbe1980b0	walk away	уйти	phrasal verb	If they won't come down, I'll walk away	B1	audio/word_walk_away_f89883f1.mp3	wɔk əˈweɪ	ffb2f11d-06ce-406d-be45-c42643eb3c19
c4524b8b-08e4-4edc-8d64-5ac32fbc8694	worth it	стоит того	phrase	I think it's worth it	B1	audio/word_worth_it_e45c9237.mp3	wərθ ɪt	ffb2f11d-06ce-406d-be45-c42643eb3c19
a586001e-9ebd-429a-ba88-c078ca3ccfc6	good value for money	хорошее соотношение цены и качества	phrase	It's good value for money	B2	audio/word_good_value_aba2cfb4.mp3	gʊd ˈvælju fər ˈməni	ffb2f11d-06ce-406d-be45-c42643eb3c19
e328395e-c4fd-4a91-b9a5-dcc045331e0e	worth a try	стоит попробовать	phrase	Haggling is worth a try	B1	audio/word_worth_a_5d5c7a1a.mp3	wərθ ə traɪ	ffb2f11d-06ce-406d-be45-c42643eb3c19
74bc7221-0143-40d4-bb80-d3906c853a08	I'll take it	Я возьму это	phrase	Okay, I'll take it	A2	audio/word_i'll_take_d9a4eb76.mp3	aɪl teɪk ɪt	ffb2f11d-06ce-406d-be45-c42643eb3c19
f6e2ed3a-2f06-4b6f-8ddd-b81d88abb24c	souvenir	сувенир	noun	I bought a lovely souvenir from the market	A2	audio/word_souvenir_32fda02d.mp3	ˌsuvəˈnɪr	7332086d-d229-4db6-b658-f3408aa99bb3
a09b2f04-f2ae-4be1-a2a8-1c0d6cb70d2a	handmade	ручной работы	adjective	This scarf is handmade	A2	audio/word_handmade_4cf099ad.mp3	ˈhænˈmeɪd	7332086d-d229-4db6-b658-f3408aa99bb3
b2115373-0c89-4545-a245-233a3610b1da	local crafts	местные ремесла	noun phrase	I love browsing the local crafts	A2	audio/word_local_crafts_c45f1d65.mp3	ˈloʊkəl kræfts	7332086d-d229-4db6-b658-f3408aa99bb3
4e376a43-be1a-4fe7-8937-effc5c7f472d	market stall	рыночный прилавок	noun phrase	The market stall sold beautiful pottery	A2	audio/word_market_stall_31c0d8fa.mp3	ˈmɑrkɪt stɔl	7332086d-d229-4db6-b658-f3408aa99bb3
51ca6d42-bbbf-49ee-afd5-66e041eb2e0b	bargain	выгодная покупка	noun	I got a real bargain at the market	B1	audio/word_bargain_8d3fc1c4.mp3	ˈbɑrgɪn	7332086d-d229-4db6-b658-f3408aa99bb3
5a6d9aed-b347-4696-96a1-2e78054e10e3	pick up	приобрести	phrasal verb	I picked up some gifts for my friends	B1	audio/word_pick_up_729d96e2.mp3	pɪk əp	7332086d-d229-4db6-b658-f3408aa99bb3
28919c89-4852-4591-b5a5-7bfb24271922	browse	смотреть, просматривать	verb	I like to browse the shops before I buy anything	B1	audio/word_browse_d8a0a030.mp3	braʊz	7332086d-d229-4db6-b658-f3408aa99bb3
a4e1a4e8-7493-42ae-b6f2-8f5af8f58660	look around	осмотреть	phrasal verb	Let's look around the market	B1	audio/word_look_around_70dc4e89.mp3	lʊk əraʊnd	7332086d-d229-4db6-b658-f3408aa99bb3
c87e34d8-d837-4010-a6fe-b9f564cf2214	cheap	дешёвый	adjective	The souvenirs were really cheap	A1	audio/word_cheap_2659bc6e.mp3	ʧip	7332086d-d229-4db6-b658-f3408aa99bb3
86a9dd51-d230-4252-ae6e-6caab11cfc97	expensive	дорогой	adjective	This item is too expensive	A1	audio/word_expensive_c22abc93.mp3	ɪkˈspɛnsɪv	7332086d-d229-4db6-b658-f3408aa99bb3
b9418bc1-3e29-4247-b031-efe1358a2505	worth it	стоит того	phrase	It was expensive, but it was worth it	B1	audio/word_worth_it_3076fee3.mp3	wərθ ɪt	7332086d-d229-4db6-b658-f3408aa99bb3
d5a47419-e545-419e-a616-75d711201934	worth buying	стоит купить	phrase	That necklace is definitely worth buying	B1	audio/word_worth_buying_290b20b5.mp3	wərθ baɪɪŋ	7332086d-d229-4db6-b658-f3408aa99bb3
2ece545f-de0b-4d02-b2ab-3a02e4f16d51	unique	уникальный	adjective	I wanted to buy something unique	B1	audio/word_unique_c6792670.mp3	juˈnik	7332086d-d229-4db6-b658-f3408aa99bb3
7ea8d0e7-8880-4c71-b0dc-dff2ef2ea23e	traditional	традиционный	adjective	I bought some traditional crafts	A2	audio/word_traditional_a42e75ea.mp3	trəˈdɪʃənəl	7332086d-d229-4db6-b658-f3408aa99bb3
e9c25338-6013-42a0-951d-934f05996635	beautiful	красивый	adjective	The pottery is beautiful	A1	audio/word_beautiful_ce56a3a2.mp3	ˈbjutəfəl	7332086d-d229-4db6-b658-f3408aa99bb3
70843f90-7e60-44d6-be87-c6b4fbdfa68e	stunning	потрясающий	adjective	The view from the top was stunning	B2	audio/word_stunning_b5785bd3.mp3	ˈstənɪŋ	7332086d-d229-4db6-b658-f3408aa99bb3
cc7d3de2-dc26-48fc-bcab-2346803ba60a	gorgeous	великолепный	adjective	She's wearing a gorgeous dress	B2	audio/word_gorgeous_32f8fc9a.mp3	ˈgɔrʤəs	7332086d-d229-4db6-b658-f3408aa99bb3
b73a3d86-b95a-483a-85f7-eb3e7a14c58c	lovely	прекрасный	adjective	That's a lovely scarf	A2	audio/word_lovely_9cdf0bcb.mp3	ˈləvli	7332086d-d229-4db6-b658-f3408aa99bb3
bee9dc96-e4ab-455c-ac5d-31ab02e2d3c2	perfect	идеальный	adjective	This is a perfect souvenir	A2	audio/word_perfect_0bf9fb7d.mp3	ˈpərˌfɪkt	7332086d-d229-4db6-b658-f3408aa99bb3
d7019429-4bfe-42de-9d53-0dbb5618c50e	delightful	прекрасный, восхитительный	adjective	It was a delightful experience	B2	audio/word_delightful_ab6b4dcc.mp3	dɪˈlaɪtfəl	7332086d-d229-4db6-b658-f3408aa99bb3
71864cd1-38d0-4fdb-b3d6-f48b944e13dd	small	маленький	adjective	I bought a small wooden doll	A1	audio/word_small_883b4f2e.mp3	smɔl	7332086d-d229-4db6-b658-f3408aa99bb3
81603969-7933-481c-870d-95d8a9491446	big	большой	adjective	This bag is too big	A1	audio/word_big_0acf247c.mp3	bɪg	7332086d-d229-4db6-b658-f3408aa99bb3
1204f12e-1966-4c0c-9be8-795f74020130	tiny	крошечный	adjective	I found a tiny silver ring	B1	audio/word_tiny_37b3b313.mp3	ˈtaɪni	7332086d-d229-4db6-b658-f3408aa99bb3
c6b7d0d2-f574-4c7a-ae4a-8bfdd7d9a41b	nice	хороший, приятный	adjective	It's a nice gift	A1	audio/word_nice_9086eedd.mp3	nis	7332086d-d229-4db6-b658-f3408aa99bb3
aa2a52c3-a6af-43dd-851b-3bcca0fbd1e2	souvenir	сувенир	noun	I bought a lovely souvenir at the market	A2	audio/word_souvenir_7f169bb8.mp3	ˌsuvəˈnɪr	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
fd1e8b4d-0058-45de-8fba-42162d792b9e	market	рынок	noun	The market is full of colorful souvenirs	A1	audio/word_market_fe106148.mp3	ˈmɑrkɪt	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
d97b7649-79b8-44ed-a31f-b916c7e592f7	size	размер	noun	What size do you need?	A2	audio/word_size_9dc2bfb1.mp3	saɪz	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
12177209-1b93-4d85-84df-962a7428fc2b	color	цвет	noun	What color do you prefer?	A2	audio/word_color_0de9561b.mp3	ˈkələr	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
1676b628-adcf-439f-9fd4-3dd4819d7f6c	material	материал	noun	What is this made of? What's the material?	B1	audio/word_material_4013f467.mp3	məˈtɪriəl	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
f32dddae-ec87-4d5a-ac7e-42935d488c29	look for	искать	phrasal verb	I'm looking for a small wooden toy	B1	audio/word_look_for_97e93cb2.mp3	lʊk fər	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
0f73cf74-d4f7-4987-a2d5-3fc8c6d43374	pick out	выбрать	phrasal verb	I need to pick out a gift for my friend	B1	audio/word_pick_out_66de45bd.mp3	pɪk aʊt	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
0c7ae404-abdc-4f25-8b0c-04a4e8a12229	shop around	сравнивать цены	phrasal verb	I like to shop around before buying anything	B2	audio/word_shop_around_2ca05b80.mp3	ʃɑp əraʊnd	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
d3392c8d-e101-442e-872c-cb8b8f3fdd83	haggle	торговаться	verb	Don't be afraid to haggle for a better price	B2	audio/word_haggle_ce96935f.mp3	ˈhægəl	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
8f8ec64e-e89b-4ba2-93ff-2a1f29f83339	too expensive	слишком дорого	adjective	This is too expensive for me	A2	audio/word_too_expensive_4cc10ae5.mp3	tu ɪkˈspɛnsɪv	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
c71db2c9-7df3-4992-b32c-63e12116f833	a bit pricey	немного дороговато	adjective	It's a bit pricey, but it's worth it	B1	audio/word_a_bit_be632af5.mp3	ə bɪt ˈpraɪsi	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
bcf2783d-9255-4d01-a02c-9679de69c8bd	reasonable price	разумная цена	noun phrase	That's a reasonable price	B1	audio/word_reasonable_price_a059c84e.mp3	ˈrizənəbəl praɪs	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
0267d5e4-a2dc-4031-a15e-eb12a6de064d	perfect gift	идеальный подарок	noun phrase	This is the perfect gift for my daughter	B1	audio/word_perfect_gift_12f5f50a.mp3	ˈpərˌfɪkt gɪft	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
19c48a06-0f98-4cc2-9878-aef43e5d38d6	something special	что-то особенное	noun phrase	I want to buy something special	B1	audio/word_something_special_4450b78d.mp3	ˈsəmθɪŋ ˈspɛʃəl	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
b446a4c7-23e3-4da0-b9bb-c98e3f311532	check the price	проверить цену	verb phrase	Let me check the price	A2	audio/word_check_the_11f99d04.mp3	ʧɛk ðə praɪs	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
a5ccb91e-9ba2-49bc-854b-560ce8974d38	how much is it?	сколько это стоит?	phrase	How much is it?	A1	audio/word_how_much_2fa39dd3.mp3	haʊ məʧ ɪz ɪt?	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
4204fe37-6f80-434c-ae42-ace3b81c8ee1	can I pay by card?	можно ли оплатить картой?	phrase	Can I pay by card?	A2	audio/word_can_i_67b57bea.mp3	kən aɪ peɪ baɪ kɑrd?	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
790ac9a3-9d44-4207-bdc2-081ba538dd2b	different sizes	разные размеры	noun phrase	They have different sizes available	A2	audio/word_different_sizes_89da5caa.mp3	ˈdɪfərənt ˈsaɪzɪz	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
fc38f28e-8c42-41a9-a614-e249180f438d	various colors	различные цвета	noun phrase	They come in various colors	A2	audio/word_various_colors_9e7c3fef.mp3	ˈvɛriəs ˈkələrz	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
88105525-3265-4e38-a5dc-7c70752393ca	wide range	широкий выбор	noun phrase	They have a wide range of souvenirs	B1	audio/word_wide_range_fbd22b0c.mp3	waɪd reɪnʤ	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
3e8389d6-9c0e-4561-b13b-8e943b298287	silk scarf	шелковый шарф	noun phrase	I want to buy a silk scarf	B1	audio/word_silk_scarf_ea45a0ca.mp3	sɪlk skɑrf	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
27ec8b14-ebe2-4573-974e-3375afce6d65	cotton shirt	хлопковая рубашка	noun phrase	This cotton shirt is very comfortable	B1	audio/word_cotton_shirt_0ed5d0ce.mp3	ˈkɔtən ʃərt	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
83f22592-bbb1-4440-9d9e-d5c96d542821	wooden carving	деревянная резьба	noun phrase	That wooden carving is beautiful	B1	audio/word_wooden_carving_5d2f540e.mp3	ˈwʊdən ˈkɑrvɪŋ	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
880b36ae-8e44-4dc8-8f8b-f5e1b7ced427	leather bag	кожаная сумка	noun phrase	I'm looking for a leather bag	B1	audio/word_leather_bag_71c3c40f.mp3	ˈlɛðər bæg	a4fa7e42-0fb3-4dc8-900a-b9de678881b2
47952c3a-1f07-417f-9f60-53379e33a962	reservation	резервация	noun	I'd like to make a reservation for two people	A2	audio/word_reservation_7bb6a874.mp3	ˌrɛzərˈveɪʃən	4a220014-7da3-46c4-8c0d-ebf0b05433e9
60232f3a-a752-4485-a7eb-7f5340dbb281	book a table	забронировать столик	verb phrase	We need to book a table for tonight	A2	audio/word_book_a_2f71c865.mp3	bʊk ə ˈteɪbəl	4a220014-7da3-46c4-8c0d-ebf0b05433e9
9de687b5-2301-4a13-856c-86192465bcdd	make a booking	сделать бронь	verb phrase	I've made a booking under the name Smith	B1	audio/word_make_a_2b98f073.mp3	meɪk ə ˈbʊkɪŋ	4a220014-7da3-46c4-8c0d-ebf0b05433e9
cdcf6c92-c9b4-453b-b19c-2bb2ce76db7f	confirm a reservation	подтвердить бронь	verb phrase	Can you confirm my reservation?	B1	audio/word_confirm_a_e23e78c1.mp3	kənˈfərm ə ˌrɛzərˈveɪʃən	4a220014-7da3-46c4-8c0d-ebf0b05433e9
faa408a8-ec62-480a-9778-a4d2560ce498	cancel a reservation	отменить бронь	verb phrase	I need to cancel my reservation	B1	audio/word_cancel_a_4fc321fd.mp3	ˈkænsəl ə ˌrɛzərˈveɪʃən	4a220014-7da3-46c4-8c0d-ebf0b05433e9
e6a0cbd3-b248-42af-a829-d4df732dcec1	table for two	столик на двоих	noun phrase	We have a table for two	A2	audio/word_table_for_4bbc00ec.mp3	ˈteɪbəl fər tu	4a220014-7da3-46c4-8c0d-ebf0b05433e9
c70c9b25-fcb1-4407-b3fd-00a8dd3a69c7	what time?	во сколько?	question	What time would you like to dine?	A1	audio/word_what_time?_b0f36d7a.mp3	wət taɪm?	4a220014-7da3-46c4-8c0d-ebf0b05433e9
9a55c0bc-7159-47c3-9063-d650c84643b8	date	дата	noun	What date is your reservation?	A2	audio/word_date_7d274061.mp3	deɪt	4a220014-7da3-46c4-8c0d-ebf0b05433e9
e6335cd3-5992-4516-b07e-fda05863d1cf	time	время	noun	What time is your reservation?	A1	audio/word_time_184af2a4.mp3	taɪm	4a220014-7da3-46c4-8c0d-ebf0b05433e9
1dcfc0d1-486f-4737-9ff6-ef33e5dcb2a1	dine in	обедать в ресторане	verb phrase	We prefer to dine in rather than take away	B1	audio/word_dine_in_22467f8c.mp3	daɪn ɪn	4a220014-7da3-46c4-8c0d-ebf0b05433e9
b987598e-8304-443a-885e-d7afbcef567d	dress code	дресс-код	noun phrase	What is the restaurant's dress code?	B2	audio/word_dress_code_f23e7947.mp3	drɛs koʊd	4a220014-7da3-46c4-8c0d-ebf0b05433e9
0ae303cf-c766-4111-97b0-69acfd16858d	menu	меню	noun	Can I see the menu, please?	A1	audio/word_menu_6fab5eba.mp3	ˈmɛnju	4a220014-7da3-46c4-8c0d-ebf0b05433e9
440ba0c1-80cb-41dd-8ece-d4b5abb6aad0	order	заказать	verb	I'd like to order the steak	A2	audio/word_order_f4161e9f.mp3	ˈɔrdər	4a220014-7da3-46c4-8c0d-ebf0b05433e9
95413b0c-2edc-48fa-92c8-e16df887606d	bill	счёт	noun	Could we have the bill, please?	A1	audio/word_bill_0f3874de.mp3	bɪl	4a220014-7da3-46c4-8c0d-ebf0b05433e9
ce7dbcab-7272-4264-81ee-60e91cfa3fca	waiter/waitress	официант/официантка	noun	Excuse me, waiter?	A2		waiter/waitress*	4a220014-7da3-46c4-8c0d-ebf0b05433e9
7d78a6c9-6935-4223-9801-aae2da9911c6	tip	чаевые	noun	Do we need to leave a tip?	B1	audio/word_tip_556c71f6.mp3	tɪp	4a220014-7da3-46c4-8c0d-ebf0b05433e9
f6622e4f-6ece-4ac0-828f-864d0c8f9c9d	enjoy your meal	приятного аппетита	phrase	Enjoy your meal!	A2	audio/word_enjoy_your_672f77b4.mp3	ˌɛnˈʤɔɪ jʊr mil	4a220014-7da3-46c4-8c0d-ebf0b05433e9
ae70c14f-6c51-4593-abba-34c91e4cb4c2	delicious	вкусно	adjective	The food was delicious!	A2	audio/word_delicious_009758d7.mp3	dɪˈlɪʃəs	4a220014-7da3-46c4-8c0d-ebf0b05433e9
74868d2d-00e8-4059-8834-b7a9355bec13	fantastic service	фантастическое обслуживание	noun phrase	The service was fantastic!	B2	audio/word_fantastic_service_098c2458.mp3	fænˈtæstɪk ˈsərvɪs	4a220014-7da3-46c4-8c0d-ebf0b05433e9
187628dd-a880-426d-b8da-9240cf3bc5fa	recommend	рекомендовать	verb	Can you recommend a wine?	B1	audio/word_recommend_5b696cec.mp3	ˌrɛkəˈmɛnd	4a220014-7da3-46c4-8c0d-ebf0b05433e9
6c589c43-a278-497e-9a16-63b53887c67d	allergy	аллергия	noun	I have a seafood allergy	B1	audio/word_allergy_aae15301.mp3	ˈælərʤi	4a220014-7da3-46c4-8c0d-ebf0b05433e9
0a21e3ea-4cfd-48dc-8012-e011391dec8d	special	специальное блюдо	noun	What is the daily special?	A2	audio/word_special_acf1473c.mp3	ˈspɛʃəl	4a220014-7da3-46c4-8c0d-ebf0b05433e9
bfc4ba97-aef7-4ce8-8b30-d57ffa71524d	appetizer	закуска	noun	Would you like an appetizer?	B1	audio/word_appetizer_d482da0b.mp3	ˈæpəˌtaɪzər	4a220014-7da3-46c4-8c0d-ebf0b05433e9
2b93d4e2-12b0-4791-9413-46189e4ea04c	main course	основное блюдо	noun phrase	What is your main course?	B1	audio/word_main_course_a13fe70a.mp3	meɪn kɔrs	4a220014-7da3-46c4-8c0d-ebf0b05433e9
9087567f-4bff-4ffb-b761-73b98f78aa64	dessert	десерт	noun	I'll have the dessert menu, please	A2	audio/word_dessert_cb456fe3.mp3	dɪˈzərt	4a220014-7da3-46c4-8c0d-ebf0b05433e9
1e021e13-af55-4c46-ab06-dbbc0daa4478	wine list	винная карта	noun phrase	May I see the wine list?	B1	audio/word_wine_list_763960df.mp3	waɪn lɪst	4a220014-7da3-46c4-8c0d-ebf0b05433e9
155fdffa-edca-4319-beb1-d23a0c339b13	non-alcoholic	безалкогольный	adjective	Do you have any non-alcoholic drinks?	B1	audio/word_non-alcoholic_7dc9b5f3.mp3	ˌnɑˌnælkəˈhɑlɪk	4a220014-7da3-46c4-8c0d-ebf0b05433e9
01c56e0e-58fa-4b99-815a-530a3bde4c45	credit card	кредитная карта	noun phrase	I'll pay by credit card	A2	audio/word_credit_card_b10b6444.mp3	ˈkrɛdɪt kɑrd	4a220014-7da3-46c4-8c0d-ebf0b05433e9
a39eb5fb-62eb-47fb-91c2-9e4066e6efd9	cash	наличные	noun	I'll pay in cash	A1	audio/word_cash_779736ca.mp3	kæʃ	4a220014-7da3-46c4-8c0d-ebf0b05433e9
3c1e893c-044f-49bb-93b1-6d9efae5bc7c	split the bill	разделить счёт	verb phrase	Can we split the bill?	B1	audio/word_split_the_29a34166.mp3	splɪt ðə bɪl	4a220014-7da3-46c4-8c0d-ebf0b05433e9
0d7e35a2-7762-4a9c-a2e1-c5099e541c9d	leave a message	оставить сообщение	verb phrase	Can I leave a message for the manager?	B1	audio/word_leave_a_ac9f0f57.mp3	liv ə ˈmɛsɪʤ	4a220014-7da3-46c4-8c0d-ebf0b05433e9
540abd02-4794-4d51-8f47-d9eb2fafa855	table	стол	noun	We need a table for two	A1	audio/word_table_971ed676.mp3	ˈteɪbəl	343595a2-73bc-478f-84ce-b02fe7d898e4
8c0ded21-2bee-4c09-8d00-90b78e99163d	waiter/waitress	официант/официантка	noun	Excuse me, waiter!	A1		waiter/waitress*	343595a2-73bc-478f-84ce-b02fe7d898e4
02128302-d7d5-486e-ae75-5e5dbebd721d	menu	меню	noun	Can I see the menu, please?	A1	audio/word_menu_ee849589.mp3	ˈmɛnju	343595a2-73bc-478f-84ce-b02fe7d898e4
db335bde-285b-4e60-8403-b7add02824ed	order	заказывать	verb	I'd like to order, please	A1	audio/word_order_2c23f449.mp3	ˈɔrdər	343595a2-73bc-478f-84ce-b02fe7d898e4
e5f9a5a5-4485-440d-b916-02b7df843533	food	еда	noun	What kind of food do you have?	A1	audio/word_food_5b10548e.mp3	fud	343595a2-73bc-478f-84ce-b02fe7d898e4
a8a033db-ba56-4fa3-a9b8-715175494c38	drink	напиток	noun	I'll have a glass of water, please	A1	audio/word_drink_ddc17041.mp3	drɪŋk	343595a2-73bc-478f-84ce-b02fe7d898e4
1eee72b4-b8df-4cd2-88af-7b01bba5968a	bill/check	счёт	noun	Could we have the bill, please?	A1		bill/check*	343595a2-73bc-478f-84ce-b02fe7d898e4
ec6e197b-47fd-4a06-938a-44d76744bb6c	delicious	вкусный	adjective	The food was delicious!	A2	audio/word_delicious_3e58e292.mp3	dɪˈlɪʃəs	343595a2-73bc-478f-84ce-b02fe7d898e4
976b8e21-8399-470e-8d18-fe0ff4cba394	tasty	вкусный	adjective	This soup is very tasty	A2	audio/word_tasty_e9b89c78.mp3	ˈteɪsti	343595a2-73bc-478f-84ce-b02fe7d898e4
8fc7d942-aa2a-4bd9-8b66-96cc7d5c92f7	appetizer	закуска	noun	We'll start with an appetizer	A2	audio/word_appetizer_fd6c672a.mp3	ˈæpəˌtaɪzər	343595a2-73bc-478f-84ce-b02fe7d898e4
758007e2-c168-4ff8-baef-d9456e5ad8f1	main course	главное блюдо	noun	What's the main course today?	A2	audio/word_main_course_260d6642.mp3	meɪn kɔrs	343595a2-73bc-478f-84ce-b02fe7d898e4
19eb857a-a311-49aa-bcd9-88d2689e9f16	dessert	десерт	noun	What do you have for dessert?	A2	audio/word_dessert_e87d16ce.mp3	dɪˈzərt	343595a2-73bc-478f-84ce-b02fe7d898e4
37db31e4-15eb-47dc-897b-584f8580176b	to recommend	рекомендовать	verb	Could you recommend something?	A2	audio/word_to_recommend_ae83bfa4.mp3	tɪ ˌrɛkəˈmɛnd	343595a2-73bc-478f-84ce-b02fe7d898e4
3e0d8da1-b4ef-4fdc-b418-fe1610027d70	to take one's order	принимать заказ	verb	The waiter came to take our order	A2	audio/word_to_take_18f750b4.mp3	tɪ teɪk wənz ˈɔrdər	343595a2-73bc-478f-84ce-b02fe7d898e4
85f0bfd8-d50f-48fe-b009-aaa9a6032ae7	to clear the table	убирать со стола	verb	Could you clear the table?	A2	audio/word_to_clear_0064b172.mp3	tɪ klɪr ðə ˈteɪbəl	343595a2-73bc-478f-84ce-b02fe7d898e4
62eed417-a632-4756-9207-42ec0c90c878	extra napkins	дополнительные салфетки	noun phrase	Could we have some extra napkins?	A2	audio/word_extra_napkins_0d6724c6.mp3	ˈɛkstrə ˈnæpkɪnz	343595a2-73bc-478f-84ce-b02fe7d898e4
f0a1c79e-39e8-46d6-860d-2d8c1dc357ce	service charge	плата за обслуживание	noun	Is service charge included?	B1	audio/word_service_charge_9bd148d1.mp3	ˈsərvɪs ʧɑrʤ	343595a2-73bc-478f-84ce-b02fe7d898e4
716e94ac-49a8-4369-b473-db18352322b6	tip	чаевые	noun	I'd like to leave a tip	B1	audio/word_tip_8f7e087a.mp3	tɪp	343595a2-73bc-478f-84ce-b02fe7d898e4
e9177f63-c10a-4588-a961-339234a7d1d7	I'm allergic to...	У меня аллергия на...	phrase	I'm allergic to nuts	B1	audio/word_i'm_allergic_0d3f3897.mp3	əm əˈlərʤɪk tɪ...	343595a2-73bc-478f-84ce-b02fe7d898e4
5326ab4c-eedf-4bf1-a6fd-468daf61312c	I'm on a diet	Я на диете	phrase	I'm on a diet, so I'll just have a salad	B1	audio/word_i'm_on_33a518ba.mp3	əm ɔn ə daɪət	343595a2-73bc-478f-84ce-b02fe7d898e4
1869dbf1-dfb0-4ada-8b8c-a9e59b27e613	Could you bring me...?	Не могли бы вы принести мне...?	phrase	Could you bring me another fork?	B1	audio/word_could_you_a8a3c08c.mp3	kʊd ju brɪŋ mi...?	343595a2-73bc-478f-84ce-b02fe7d898e4
56c30ae1-c76d-41f9-99c2-9ccdeee16aae	I'd like to make a reservation	Я хотел бы сделать резерв	phrase	I'd like to make a reservation for tonight	B1	audio/word_i'd_like_6eb32533.mp3	aɪd laɪk tɪ meɪk ə ˌrɛzərˈveɪʃən	343595a2-73bc-478f-84ce-b02fe7d898e4
ec0915ff-7544-43a7-a369-7f8fc618f015	I'll have the ...	Я возьму...	phrase	I'll have the steak	B1	audio/word_i'll_have_4e9dc95f.mp3	aɪl hæv ðə 	343595a2-73bc-478f-84ce-b02fe7d898e4
175537e3-3037-4f02-9d4b-6ac812efc21a	menu	меню	noun	Can I see the menu, please?	A1	audio/word_menu_db9381e1.mp3	ˈmɛnju	c4f57c05-e684-430e-a85d-3acccb354554
a4dcfd2b-76c0-44fe-9f71-38e9a9d7d02a	dish	блюдо	noun	What's your favorite dish?	A1	audio/word_dish_3d80fed2.mp3	dɪʃ	c4f57c05-e684-430e-a85d-3acccb354554
11adee25-be1e-4590-9d88-721965d9ed64	plate	тарелка	noun	Could I have another plate?	A1	audio/word_plate_1dd2f66d.mp3	pleɪt	c4f57c05-e684-430e-a85d-3acccb354554
4b573971-7db8-4752-87ca-d9431509d9db	order	заказывать	verb	I'd like to order now	A2	audio/word_order_b57ae59b.mp3	ˈɔrdər	c4f57c05-e684-430e-a85d-3acccb354554
28e14c78-1347-4422-b99f-3211254f058b	take order	принимать заказ	verb phrase	The waiter will take your order soon	A2	audio/word_take_order_36f1deb4.mp3	teɪk ˈɔrdər	c4f57c05-e684-430e-a85d-3acccb354554
922a6218-6892-4bc3-a658-ca3c15632273	special	специальное	adjective	Do you have any specials today?	A2	audio/word_special_3b4335ab.mp3	ˈspɛʃəl	c4f57c05-e684-430e-a85d-3acccb354554
9adf92ef-d4fe-4489-b356-b383e9ad03a5	recommend	рекомендовать	verb	What would you recommend?	A2	audio/word_recommend_95dcb54f.mp3	ˌrɛkəˈmɛnd	c4f57c05-e684-430e-a85d-3acccb354554
f169e1b0-5f3a-4462-b820-6b489961fe06	appetizer	закуска	noun	We'll start with an appetizer	A2	audio/word_appetizer_d5af84a7.mp3	ˈæpəˌtaɪzər	c4f57c05-e684-430e-a85d-3acccb354554
dd2aa7a7-b75c-4080-969a-4538c99c0669	main course	главное блюдо	noun phrase	What will you have for the main course?	A2	audio/word_main_course_dce850b7.mp3	meɪn kɔrs	c4f57c05-e684-430e-a85d-3acccb354554
f4911896-15fa-4bf0-98b2-8184df4d3223	dessert	десерт	noun	What kind of dessert do you have?	A2	audio/word_dessert_af9cc006.mp3	dɪˈzərt	c4f57c05-e684-430e-a85d-3acccb354554
a11e2406-9549-4c8a-864b-04d345c53e4f	side dish	гарнир	noun phrase	What side dishes do you have?	A2	audio/word_side_dish_2f040afb.mp3	saɪd dɪʃ	c4f57c05-e684-430e-a85d-3acccb354554
8e4d051d-2ead-49a7-a6d4-63331a96764e	spicy	острый	adjective	Is this dish spicy?	A2	audio/word_spicy_b9399611.mp3	ˈspaɪsi	c4f57c05-e684-430e-a85d-3acccb354554
a80f4a42-3db9-46c7-b4f1-88e30f4f1c78	ingredients	ингредиенты	noun	What are the ingredients?	B1	audio/word_ingredients_c03cd577.mp3	ˌɪnˈgridiənts	c4f57c05-e684-430e-a85d-3acccb354554
0b79161c-7ddb-4f90-8995-7bd9b563e8b1	allergies	аллергия	noun	I have some allergies	B1	audio/word_allergies_26c65fed.mp3	ˈælərʤiz	c4f57c05-e684-430e-a85d-3acccb354554
6c3e1a73-d5a2-48c0-8f8a-5816f743d7d3	vegetarian	вегетарианец	noun	Do you have any vegetarian options?	B1	audio/word_vegetarian_d2fdcdb3.mp3	ˌvɛʤəˈtɛˌriən	c4f57c05-e684-430e-a85d-3acccb354554
90c320ed-2b93-44fd-90e7-877ebdb0e76e	gluten-free	безглютеновый	adjective	Do you have anything gluten-free?	B1	audio/word_gluten-free_55a8178d.mp3	gluten-free*	c4f57c05-e684-430e-a85d-3acccb354554
0a45dde3-03a1-4e12-8844-6a8acff22761	dairy-free	безмолочный	adjective	I need a dairy-free option	B1	audio/word_dairy-free_a83c25b9.mp3	dairy-free*	c4f57c05-e684-430e-a85d-3acccb354554
cb859acc-e340-4797-a01a-845506f74e86	description	описание	noun	Can you describe the dish?	B1	audio/word_description_e97474be.mp3	dɪˈskrɪpʃən	c4f57c05-e684-430e-a85d-3acccb354554
84e9b2ad-c87c-4b27-a2bb-c595d058f791	how is it cooked	как это приготовлено	phrase	How is this dish cooked?	B1	audio/word_how_is_606a8816.mp3	haʊ ɪz ɪt kʊkt	c4f57c05-e684-430e-a85d-3acccb354554
33d835b0-5f89-45b1-a112-fd01077c4f7e	wine list	винная карта	noun phrase	May I see the wine list?	B1	audio/word_wine_list_a6cd06b0.mp3	waɪn lɪst	c4f57c05-e684-430e-a85d-3acccb354554
1e77e212-4f6d-4cbe-a1f1-4a1439824557	bill	счёт	noun	Could we have the bill, please?	B1	audio/word_bill_cb34d67d.mp3	bɪl	c4f57c05-e684-430e-a85d-3acccb354554
0e121226-ad95-4359-b52f-ec8ad5cdc39f	check please	счёт пожалуйста	phrase	Check, please!	B1	audio/word_check_please_8e0edd13.mp3	ʧɛk pliz	c4f57c05-e684-430e-a85d-3acccb354554
5ef27d52-45f3-42d7-ac34-d4f9bf2542cb	delicious	вкусный	adjective	This is delicious!	B1	audio/word_delicious_37557bb8.mp3	dɪˈlɪʃəs	c4f57c05-e684-430e-a85d-3acccb354554
39b88c1f-528e-4761-8f4c-cc23725e7c0e	tasty	вкусный	adjective	This is very tasty!	B1	audio/word_tasty_b335b0f8.mp3	ˈteɪsti	c4f57c05-e684-430e-a85d-3acccb354554
86a0023f-ee89-4ca7-9053-f1a6ba1544d8	enjoy your meal	приятного аппетита	phrase	Enjoy your meal!	B1	audio/word_enjoy_your_c539ad46.mp3	ˌɛnˈʤɔɪ jʊr mil	c4f57c05-e684-430e-a85d-3acccb354554
76dbeb9b-40b3-418b-bfe8-bb83ee30b6b1	bill	счёт	noun	Can I have the bill, please?	A2	audio/word_bill_c1bd869c.mp3	bɪl	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
61578746-0a9d-44aa-9cc4-f9c2d38645e5	check	чек	noun	Could we get the check?	A2	audio/word_check_1ea7cd5d.mp3	ʧɛk	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
8cb0f317-299a-4059-a5a2-7ae90088e31e	check, please	чек, пожалуйста	phrase	Check, please?	A2	audio/word_check,_please_5522ae40.mp3	ʧɛk, pliz	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
69d40ffc-5982-40ed-95f7-85817bd29d02	water	вода	noun	Could we have some water, please?	A1	audio/word_water_f54a0112.mp3	ˈwɔtər	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
28b1ec90-11f1-4d5e-8d32-e050d4658fb3	still water	негазированная вода	noun	I'd like some still water	A2	audio/word_still_water_811541c4.mp3	stɪl ˈwɔtər	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
d6c4c032-b172-402a-8a7b-b1af03fdcff8	sparkling water	газированная вода	noun	I'll have sparkling water, please	A2	audio/word_sparkling_water_69bc3bb9.mp3	ˈspɑrkəlɪŋ ˈwɔtər	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
e6dff9af-2ab5-4003-857d-3dec191053bb	tap water	вода из-под крана	noun	Do you have tap water?	B1	audio/word_tap_water_3a5da645.mp3	tæp ˈwɔtər	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
d8192385-eed3-49c4-8c1b-6b55b005c007	toilet	туалет	noun	Where is the toilet?	A1	audio/word_toilet_13398a4c.mp3	ˈtɔɪlət	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
243872cd-9bd6-4f57-8ed7-01a1af313a08	restroom	туалет	noun	Excuse me, where is the restroom?	A2	audio/word_restroom_c6365bed.mp3	ˈrɛˌstrum	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
97e2118a-3bc1-4340-84ce-c9dd28b55955	washroom	туалет	noun	Could you tell me where the washroom is?	A2	audio/word_washroom_1f674914.mp3	ˈwɑʃˌrum	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
057afa3c-f932-4923-bf69-a031189d2551	bathroom	туалет	noun	Where's the bathroom?	A2	audio/word_bathroom_910bc65e.mp3	ˈbæθˌrum	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
d0c01a02-f4d1-4dec-bccf-27371930274f	excuse me	извините	phrase	Excuse me, waiter?	A1	audio/word_excuse_me_c727deea.mp3	ɪkˈskjuz mi	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
12d6ddbd-fc6b-42d7-8617-762cb515f06f	waiter	официант	noun	Waiter!	A2	audio/word_waiter_e8cb9c62.mp3	ˈweɪtər	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
6bd12343-e8c7-4c96-9219-5d5b139978d1	waitress	официантка	noun	Waitress!	A2	audio/word_waitress_00c63b26.mp3	ˈweɪtrəs	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
5242d6ee-bd05-4323-9079-582633ea76e5	can I have...	можно мне...	phrase	Can I have the menu, please?	A2	audio/word_can_i_6af10871.mp3	kən aɪ hæv...	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
e94fccc2-95f1-4346-af38-f284475b5116	could I have...	можно мне...	phrase	Could I have some more bread?	A2	audio/word_could_i_23e48339.mp3	kʊd aɪ hæv...	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
ad3ad8fb-71ba-4db3-824f-1940caf4a558	please	пожалуйста	adverb	Thank you very much, please	A1	audio/word_please_3618557f.mp3	pliz	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
3c121bfc-f06d-42cc-bd7a-d82dd08e7d9c	thank you	спасибо	phrase	Thank you!	A1	audio/word_thank_you_58e62826.mp3	θæŋk ju	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
24cbe610-8fba-4735-b5a7-20457c396c44	sorry	извините	interjection	Sorry to bother you	A1	audio/word_sorry_8fe03bca.mp3	ˈsɑri	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
99d96816-215e-462f-aedb-c577b9ea06c8	more	ещё	adverb	I'd like some more wine	A1	audio/word_more_eda60d81.mp3	mɔr	4f6fedbe-6abe-41a8-b2e8-8ea78232dfa3
be1b3e49-7e3c-464e-b51d-fb4cf1f36eb5	pain	боль	noun	I have a pain in my chest	A1	audio/word_pain_43fdd647.mp3	peɪn	9d303b04-b092-4abc-af81-968eabcdd205
4675a28a-f79c-4b9a-aca0-2aa4baa15cec	ache	боль	noun	I have a headache	A1	audio/word_ache_74edf73e.mp3	eɪk	9d303b04-b092-4abc-af81-968eabcdd205
1f2cfd10-07fc-49c9-95fc-181614e917d0	headache	головная боль	noun	I have a terrible headache	A1	audio/word_headache_870fd739.mp3	ˈhɛˌdeɪk	9d303b04-b092-4abc-af81-968eabcdd205
bc23e78c-57b2-4550-aebd-4495d1d59d62	stomachache	боли в животе	noun	I have a bad stomachache	A1	audio/word_stomachache_e78d21a7.mp3	stomachache*	9d303b04-b092-4abc-af81-968eabcdd205
c0b27c9b-2a31-4f75-a234-a4222d829261	cough	кашель	noun	I have a bad cough	A1	audio/word_cough_f890e1aa.mp3	kɔf	9d303b04-b092-4abc-af81-968eabcdd205
e7909a26-ee6d-4340-b063-b8ec27436dad	fever	лихорадка	noun	I have a high fever	A1	audio/word_fever_7d8a66c7.mp3	ˈfivər	9d303b04-b092-4abc-af81-968eabcdd205
55503bf7-ae3d-4948-8e66-4c0cbb505eb5	temperature	температура	noun	What's your temperature?	A1	audio/word_temperature_8db6c418.mp3	ˈtɛmpərəʧər	9d303b04-b092-4abc-af81-968eabcdd205
c05ccdc1-38bc-41b4-93dd-56c7b9c46449	runny nose	насморк	noun	I have a runny nose	A2	audio/word_runny_nose_697f5928.mp3	ˈrəni noʊz	9d303b04-b092-4abc-af81-968eabcdd205
7eca535a-e26e-49ee-b1f9-865f3ab37aff	sore throat	боль в горле	noun	I have a sore throat	A2	audio/word_sore_throat_aa724687.mp3	sɔr θroʊt	9d303b04-b092-4abc-af81-968eabcdd205
08d2f6ce-f862-4e00-9e45-94a98d1dd28e	dizziness	головокружение	noun	I feel dizziness	A2	audio/word_dizziness_4776b9d0.mp3	ˈdɪzinəs	9d303b04-b092-4abc-af81-968eabcdd205
a2e4d02a-267b-48d7-9827-f42207cd075d	feel sick	чувствовать себя плохо	verb phrase	I feel sick to my stomach	A2	audio/word_feel_sick_3043a80e.mp3	fil sɪk	9d303b04-b092-4abc-af81-968eabcdd205
ec548648-6f9f-42a9-87fb-a8ebaa1c2350	feel unwell	чувствовать себя плохо	verb phrase	I feel unwell	A2	audio/word_feel_unwell_dc9e227e.mp3	fil ənˈwɛl	9d303b04-b092-4abc-af81-968eabcdd205
c2160d88-9e70-4375-8291-653a27d8e512	shortness of breath	одышка	noun phrase	I'm experiencing shortness of breath	B1	audio/word_shortness_of_cfd76b4a.mp3	ˈʃɔrtnəs əv brɛθ	9d303b04-b092-4abc-af81-968eabcdd205
53212c3e-ea3b-4075-91f7-82527651f9b7	allergic reaction	аллергическая реакция	noun phrase	I think I'm having an allergic reaction	B1	audio/word_allergic_reaction_66b19503.mp3	əˈlərʤɪk riˈækʃən	9d303b04-b092-4abc-af81-968eabcdd205
1e991d6e-5a00-42ec-82fb-9bcef332de05	prescription	рецепт	noun	Do you have a prescription?	B1	audio/word_prescription_565e81ff.mp3	prəˈskrɪpʃən	9d303b04-b092-4abc-af81-968eabcdd205
a9e9a74a-6635-4dbf-bae7-644b699df670	over-the-counter medicine	безрецептурные лекарства	noun phrase	I need some over-the-counter medicine	B2	audio/word_over-the-counter_medicine_67021883.mp3	over-the-counter* ˈmɛdəsən	9d303b04-b092-4abc-af81-968eabcdd205
8312d666-9970-4a80-b7e0-d12ef6097c38	side effects	побочные эффекты	noun phrase	What are the side effects?	B2	audio/word_side_effects_1993d3e8.mp3	saɪd ˈifɛkts	9d303b04-b092-4abc-af81-968eabcdd205
594dab50-57e8-452f-99cd-2546981c0999	worsen	ухудшаться	verb	My symptoms are worsening	B2	audio/word_worsen_16a27fe2.mp3	ˈwərsən	9d303b04-b092-4abc-af81-968eabcdd205
2c49d9fb-c10c-41ac-8655-ca69415a6bee	medicine	лекарство	noun	I need some medicine for my headache.	A2	audio/word_medicine_cd296162.mp3	ˈmɛdəsən	d7f212a4-a5b6-4492-8991-3a123873c483
c385e63f-ee5c-444b-9d79-ecfe0d6f9abb	prescription	рецепт	noun	Do you have a prescription for this medicine?	B1	audio/word_prescription_ed832b47.mp3	prəˈskrɪpʃən	d7f212a4-a5b6-4492-8991-3a123873c483
20a2bff3-a195-48cf-9634-df46bdb8709c	over-the-counter	без рецепта	adjective	I can buy this medicine over-the-counter.	A2	audio/word_over-the-counter_b83313fb.mp3	over-the-counter*	d7f212a4-a5b6-4492-8991-3a123873c483
b42f182a-7262-42bd-a191-6f702fbb8d3c	ask for	просить	verb phrase	I need to ask for some pain relief medicine.	A1	audio/word_ask_for_df686a24.mp3	æsk fər	d7f212a4-a5b6-4492-8991-3a123873c483
4229a5c2-9394-4810-a0af-7d20fec0a7e6	request	запрашивать	verb	I'm requesting this medication.	B1	audio/word_request_3e057f1b.mp3	rɪkˈwɛst	d7f212a4-a5b6-4492-8991-3a123873c483
7f8d213a-c244-4769-af8b-eb5c4227f358	need	нуждаться	verb	I really need this medicine.	A1	audio/word_need_d7f4cdb3.mp3	nid	d7f212a4-a5b6-4492-8991-3a123873c483
a7eb456b-40b6-4d91-8cd7-bea600470418	pain relief	обезболивание	noun phrase	I need pain relief medicine.	A2	audio/word_pain_relief_7c8a78b1.mp3	peɪn rɪˈlif	d7f212a4-a5b6-4492-8991-3a123873c483
63a3fb6c-6ae9-4e36-a0ea-1924d6c35346	allergic	аллергичный	adjective	I'm allergic to penicillin.	A2	audio/word_allergic_0250a05c.mp3	əˈlərʤɪk	d7f212a4-a5b6-4492-8991-3a123873c483
7545c5e8-0bdf-423b-80dc-030536ff60b5	side effects	побочные эффекты	noun phrase	What are the side effects of this medicine?	B1	audio/word_side_effects_b034bec0.mp3	saɪd ˈifɛkts	d7f212a4-a5b6-4492-8991-3a123873c483
07ebd5e6-5d96-4074-aca7-66553018dbb5	take	принимать	verb	How should I take this medicine?	A1	audio/word_take_35e64364.mp3	teɪk	d7f212a4-a5b6-4492-8991-3a123873c483
614d6ba3-c7d9-4921-b294-18fb41b37eb3	dosage	дозировка	noun	What's the correct dosage?	B1	audio/word_dosage_6721ce14.mp3	ˈdoʊsɪʤ	d7f212a4-a5b6-4492-8991-3a123873c483
e0a873e5-3a21-472f-b755-eb179a153e5e	pharmacy	аптека	noun	Where's the nearest pharmacy?	A2	audio/word_pharmacy_9313136f.mp3	ˈfɑrməsi	d7f212a4-a5b6-4492-8991-3a123873c483
ab5dbd35-d6b5-4b19-b7b7-d06f6ebabbb8	chemist	аптека/фармацевт	noun	I need to go to the chemist.	A2	audio/word_chemist_0a7fa202.mp3	ˈkɛmɪst	d7f212a4-a5b6-4492-8991-3a123873c483
8b8f5477-b02d-4bce-bdce-0781a3748872	pharmacist	фармацевт	noun	The pharmacist can help you.	B1	audio/word_pharmacist_dc60889a.mp3	ˈfɑrməsɪst	d7f212a4-a5b6-4492-8991-3a123873c483
e4b6b952-5812-4132-a4fc-d3b6ab9fdcd7	dosage	дозировка	noun	What's the correct dosage for this medicine?	A2	audio/word_dosage_7b36bf45.mp3	ˈdoʊsɪʤ	1e08f1d6-3834-4953-bea7-f858511a6d84
d6c940bd-4902-4cdc-ba2e-814a4d8a2d10	take	принимать	verb	Take one tablet three times a day	A1	audio/word_take_b2f8417b.mp3	teɪk	1e08f1d6-3834-4953-bea7-f858511a6d84
c95de5ea-fbb0-425d-867d-d43ab1c7e984	prescription	рецепт	noun	Do you have a prescription for this medication?	B1	audio/word_prescription_77cc0df4.mp3	prəˈskrɪpʃən	1e08f1d6-3834-4953-bea7-f858511a6d84
c6b451ca-7be9-4c1c-ac7f-54daa9b23a8d	overdose	передозировка	noun	An overdose can be dangerous	B2	audio/word_overdose_0a330da9.mp3	ˈoʊvərˌdoʊs	1e08f1d6-3834-4953-bea7-f858511a6d84
c2ac2a56-f9c6-427d-8342-e21276c0a7b1	side effects	побочные эффекты	noun	What are the possible side effects?	B1	audio/word_side_effects_cfa8fa5d.mp3	saɪd ˈifɛkts	1e08f1d6-3834-4953-bea7-f858511a6d84
2fc89a4f-f5da-4d3d-9c46-9cf6f0a6d9d2	instructions	инструкции	noun	Follow the instructions carefully	A2	audio/word_instructions_0b5d67f4.mp3	ˌɪnˈstrəkʃənz	1e08f1d6-3834-4953-bea7-f858511a6d84
8a00d084-e66d-449b-bd46-85aa37a0a45b	once a day	один раз в день	phrase	Take the medicine once a day	A2	audio/word_once_a_62587803.mp3	wəns ə deɪ	1e08f1d6-3834-4953-bea7-f858511a6d84
04b39ed0-ebf5-42fe-a675-b744d35f7ed4	twice a day	два раза в день	phrase	Take this medicine twice a day	A2	audio/word_twice_a_d8221e21.mp3	twaɪs ə deɪ	1e08f1d6-3834-4953-bea7-f858511a6d84
1e6a05e8-2a1a-4cd7-a043-c11cfc1d1610	three times a day	три раза в день	phrase	Take it three times a day	A2	audio/word_three_times_c6c520a4.mp3	θri taɪmz ə deɪ	1e08f1d6-3834-4953-bea7-f858511a6d84
a65f8df2-bbae-465a-924d-eb90260d2d89	milligrams	миллиграммы	noun	The dosage is 500 milligrams	B1	audio/word_milligrams_1f918873.mp3	ˈmɪləˌgræmz	1e08f1d6-3834-4953-bea7-f858511a6d84
adead2fd-314d-4d63-852c-d45482022e09	milliliters	миллилитры	noun	Take 10 milliliters of this syrup	B1	audio/word_milliliters_e20b9533.mp3	ˈmɪləˌlitərz	1e08f1d6-3834-4953-bea7-f858511a6d84
4092340a-a3c6-40b8-a96b-c1faac7fb8af	tablespoon	столовая ложка	noun	Take one tablespoon before meals	A2	audio/word_tablespoon_29e6b59b.mp3	ˈteɪbəlˌspun	1e08f1d6-3834-4953-bea7-f858511a6d84
c34eb7c4-1807-497c-8fff-491ad7c0ec4f	teaspoon	чайная ложка	noun	Take one teaspoon after meals	A2	audio/word_teaspoon_18caad2c.mp3	ˈtiˌspun	1e08f1d6-3834-4953-bea7-f858511a6d84
aa78ef96-711e-4dae-97f5-ff05116c641a	pills	таблетки	noun	How many pills should I take?	A1	audio/word_pills_538ca621.mp3	pɪlz	1e08f1d6-3834-4953-bea7-f858511a6d84
8330d847-811d-4022-b2a0-a7d0de66ffda	capsules	капсулы	noun	These are capsules, not tablets	A2	audio/word_capsules_d064891b.mp3	ˈkæpsəlz	1e08f1d6-3834-4953-bea7-f858511a6d84
1f156ece-626f-4618-855c-4b4354abeef2	liquid	жидкий	adjective	This medicine is in liquid form	A1	audio/word_liquid_dc477980.mp3	ˈlɪkwɪd	1e08f1d6-3834-4953-bea7-f858511a6d84
bf3a8bba-93c0-4054-bc8c-1d7d287ca232	powder	порошок	noun	Mix the powder with water	A2	audio/word_powder_ba7363cc.mp3	ˈpaʊdər	1e08f1d6-3834-4953-bea7-f858511a6d84
98d6d9d2-2f55-4770-9a05-ad3b53ac631e	fill	наполнять	verb	Fill the syringe with the medicine	A2	audio/word_fill_16dda3f5.mp3	fɪl	1e08f1d6-3834-4953-bea7-f858511a6d84
d4da3148-3f89-4f6b-954a-9a12550095af	swallow	глотать	verb	Swallow the pill with water	A1	audio/word_swallow_0a1af0f5.mp3	sˈwɔloʊ	1e08f1d6-3834-4953-bea7-f858511a6d84
a66a23f8-f022-43c6-a07b-9a64561ca639	measure	измерять	verb	Carefully measure the dosage	A2	audio/word_measure_04b40108.mp3	ˈmɛʒər	1e08f1d6-3834-4953-bea7-f858511a6d84
847208be-cf8f-4656-ae31-9b749ae7e51c	apply	наносить	verb	Apply the cream to the affected area	A2	audio/word_apply_01e764f0.mp3	əˈplaɪ	1e08f1d6-3834-4953-bea7-f858511a6d84
216f46ad-1869-40ab-9dae-501585a7f25f	inject	вводить(инъекцию)	verb	The doctor will inject the medicine	B1	audio/word_inject_7a84ebc6.mp3	ˌɪnˈʤɛkt	1e08f1d6-3834-4953-bea7-f858511a6d84
67779a62-43b1-447f-ac7e-d32f3e5165a5	consult	консультироваться	verb	Consult your doctor before taking this	B1	audio/word_consult_11b7b502.mp3	kənˈsəlt	1e08f1d6-3834-4953-bea7-f858511a6d84
17513034-462f-499d-8311-247cf7a8814a	appointment	запись	noun	I have a doctor's appointment	A2	audio/word_appointment_3346c084.mp3	əˈpɔɪntmənt	7811cf8e-37f9-45f2-a15c-3092320e59e8
35fa9285-8909-4ebe-bc8c-076f281a542d	check-up	проверка состояния здоровья	noun	I need a check-up	A2	audio/word_check-up_285ace65.mp3	ˈʧɛˌkəp	7811cf8e-37f9-45f2-a15c-3092320e59e8
7f8ba23d-f3a4-49cc-a090-e5de5e1d0124	body part	часть тела	noun	The doctor examined my body part	A2	audio/word_body_part_088ff15f.mp3	ˈbɑdi pɑrt	7811cf8e-37f9-45f2-a15c-3092320e59e8
18fc91dc-eb5f-4281-a918-3edc46525522	headache	головная боль	noun	I have a terrible headache	A1	audio/word_headache_a3fa8adc.mp3	ˈhɛˌdeɪk	7811cf8e-37f9-45f2-a15c-3092320e59e8
bc6a9188-1909-4640-8e06-54e0c05ce055	stomachache	боли в животе	noun	I have a bad stomachache	A1	audio/word_stomachache_cbbf0a54.mp3	stomachache*	7811cf8e-37f9-45f2-a15c-3092320e59e8
96412a78-1314-47ff-8a5f-2524a245d2f5	earache	боль в ухе	noun	I have an earache	A1	audio/word_earache_83685921.mp3	earache*	7811cf8e-37f9-45f2-a15c-3092320e59e8
e58985d8-2374-4f48-af1d-c705c1212ec3	toothache	зубная боль	noun	I have a terrible toothache	A1	audio/word_toothache_f9e73cdb.mp3	toothache*	7811cf8e-37f9-45f2-a15c-3092320e59e8
c61daf94-75ab-4577-b59c-a688b5dd2464	throat	горло	noun	My throat hurts	A2	audio/word_throat_414e4a16.mp3	θroʊt	7811cf8e-37f9-45f2-a15c-3092320e59e8
3eb0e664-f131-4bcc-9859-58f2fd56d50f	arm	рука	noun	I hurt my arm	A1	audio/word_arm_57bfbdbe.mp3	ɑrm	7811cf8e-37f9-45f2-a15c-3092320e59e8
15474bd7-9c3a-480f-adaa-2c1a3a1284a1	leg	нога	noun	My leg is broken	A1	audio/word_leg_ada3011a.mp3	lɛg	7811cf8e-37f9-45f2-a15c-3092320e59e8
c2cd33bf-056d-456a-b5dc-011a4530d2ba	hand	рука	noun	I cut my hand	A1	audio/word_hand_5c0448a6.mp3	hænd	7811cf8e-37f9-45f2-a15c-3092320e59e8
b6a15961-cdc3-47ad-8503-ef4f0e39b71e	foot	нога	noun	My foot hurts	A1	audio/word_foot_24060ae0.mp3	fʊt	7811cf8e-37f9-45f2-a15c-3092320e59e8
adb2ab7b-8221-42f4-aca6-e6ae870d5e5d	finger	палец	noun	I broke my finger	A1	audio/word_finger_ab0be1e0.mp3	ˈfɪŋgər	7811cf8e-37f9-45f2-a15c-3092320e59e8
c503f70b-a72c-48a7-9080-97c77333903c	toe	палец ноги	noun	I stubbed my toe	A1	audio/word_toe_2947596a.mp3	toʊ	7811cf8e-37f9-45f2-a15c-3092320e59e8
292e1a19-840c-4bef-ab7e-0b0d732bd9ad	eye	глаз	noun	My eye hurts	A1	audio/word_eye_a565693f.mp3	aɪ	7811cf8e-37f9-45f2-a15c-3092320e59e8
077d2aa2-cd3f-4b1d-b851-103fac549bee	nose	нос	noun	My nose is stuffy	A1	audio/word_nose_2b4ca207.mp3	noʊz	7811cf8e-37f9-45f2-a15c-3092320e59e8
a310b83b-e133-4dde-961f-48819313aa80	back	спина	noun	My back aches	A1	audio/word_back_93560daf.mp3	bæk	7811cf8e-37f9-45f2-a15c-3092320e59e8
a7c87fc6-0c9c-4a55-9d27-cc9e3323e87d	knee	колено	noun	My knee is swollen	A2	audio/word_knee_240f01bf.mp3	ni	7811cf8e-37f9-45f2-a15c-3092320e59e8
5515c356-8fd9-4fb3-88f4-0786531bfe8a	shoulder	плечо	noun	My shoulder hurts	A2	audio/word_shoulder_2f407201.mp3	ˈʃoʊldər	7811cf8e-37f9-45f2-a15c-3092320e59e8
80b86c1f-2a69-472e-a386-4a42fe93a719	chest	грудь	noun	I have pain in my chest	A2	audio/word_chest_fec5d2d1.mp3	ʧɛst	7811cf8e-37f9-45f2-a15c-3092320e59e8
d43cf66c-6dc5-4d5f-a78c-391fb79c5a45	heart	сердце	noun	My heart is racing	A1	audio/word_heart_2d06d812.mp3	hɑrt	7811cf8e-37f9-45f2-a15c-3092320e59e8
5c566434-b41a-4b28-9319-f2a0fa5eda49	temperature	температура	noun	I have a high temperature	A2	audio/word_temperature_b16be19e.mp3	ˈtɛmpərəʧər	7811cf8e-37f9-45f2-a15c-3092320e59e8
f746a926-ae2a-4378-9f6c-cd113387c60e	blood pressure	кровяное давление	noun	Check my blood pressure, please	B1	audio/word_blood_pressure_1aa15945.mp3	bləd ˈprɛʃər	7811cf8e-37f9-45f2-a15c-3092320e59e8
4fb4c201-9a43-46a3-bb62-fff36a8f0e18	pain	боль	noun	I have a lot of pain	A1	audio/word_pain_0657ba4f.mp3	peɪn	7811cf8e-37f9-45f2-a15c-3092320e59e8
4bd7ed43-00fb-4167-a3da-9f11a02b50df	hurt	болеть	verb	My arm hurts	A1	audio/word_hurt_a60962e5.mp3	hərt	7811cf8e-37f9-45f2-a15c-3092320e59e8
44a263fb-d9d0-4f86-8f4e-0eb74a596bef	ache	болеть	verb	My head aches	A2	audio/word_ache_a47816a7.mp3	eɪk	7811cf8e-37f9-45f2-a15c-3092320e59e8
4a41e9bf-eefe-4bfd-8794-5752261f3a3e	feel unwell	чувствовать себя плохо	verb phrase	I feel unwell	A2	audio/word_feel_unwell_bbcca2f9.mp3	fil ənˈwɛl	7811cf8e-37f9-45f2-a15c-3092320e59e8
4568f42c-6073-435c-b6c0-c40355239598	make an appointment	записаться на прием	verb phrase	I need to make an appointment	A2	audio/word_make_an_6f690783.mp3	meɪk ən əˈpɔɪntmənt	7811cf8e-37f9-45f2-a15c-3092320e59e8
0721a401-3cd6-4ce6-ad7b-1e7cb616636d	see a doctor	пойти к врачу	verb phrase	I need to see a doctor	A2	audio/word_see_a_d6638285.mp3	si ə ˈdɔktər	7811cf8e-37f9-45f2-a15c-3092320e59e8
62312c12-dcca-460f-904d-f914b39a3774	take medicine	принимать лекарство	verb phrase	I need to take medicine	A2	audio/word_take_medicine_97412dd3.mp3	teɪk ˈmɛdəsən	7811cf8e-37f9-45f2-a15c-3092320e59e8
58e281cc-4baf-4c56-bee6-968a632f1cf5	get better	поправляться	verb phrase	I hope I get better soon	A2	audio/word_get_better_b0f45061.mp3	gɪt ˈbɛtər	7811cf8e-37f9-45f2-a15c-3092320e59e8
26dc511a-5104-4144-816d-a2b27525da09	appointment	запись	noun	I have a doctor's appointment tomorrow	A1	audio/word_appointment_1f864021.mp3	əˈpɔɪntmənt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
87193eac-7fcf-46d5-809b-609f01bb91eb	schedule	расписание	noun	What’s your schedule for today?	A2	audio/word_schedule_a4adb162.mp3	ˈskɛʤʊl	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
e3ea66b1-a044-48ad-b8e0-ca379040aec7	available	доступный	adjective	Are you available on Friday?	A1	audio/word_available_7c1c4c8a.mp3	əˈveɪləbəl	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
75d78ce3-7766-4c9a-bb5f-c8b6fbcdbb6f	book	записать	verb	I'd like to book an appointment	A2	audio/word_book_836adb10.mp3	bʊk	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
dacb9796-35d0-438c-983f-2a1b447fe10d	reason	причина	noun	What’s your reason for visiting?	A1	audio/word_reason_65794bc3.mp3	ˈrizən	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
b51ceee2-7924-4179-879f-16dfe633cdf2	symptoms	симптомы	noun	What symptoms are you having?	A2	audio/word_symptoms_0d52b867.mp3	ˈsɪmptəmz	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
e4090874-a6ea-4999-8471-707314cd851e	reschedule	перенести	verb	I need to reschedule my appointment	B1	audio/word_reschedule_1d6d93aa.mp3	riˈskɛʤul	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
0cf993e9-bc1c-4485-aadd-9223a7bb3bc8	cancel	отменить	verb	Can I cancel my appointment?	A1	audio/word_cancel_28b6466f.mp3	ˈkænsəl	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
4ac08eaf-cca5-4568-9095-1aa9dc5360c6	check-in	зарегистрироваться	phrasal verb	Check in at the reception desk	A1	audio/word_check-in_c703cbe8.mp3	check-in*	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
dabb08ba-540e-4034-9094-c3e5442d7f62	fill out	заполнить	phrasal verb	Please fill out this form	A2	audio/word_fill_out_080eabc5.mp3	fɪl aʊt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
4d26ee8a-968d-4980-8de9-c7797f744a24	patient	пациент	noun	First-time patient or returning?	A1	audio/word_patient_0eb49fc0.mp3	ˈpeɪʃənt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
487703ed-3cc9-49cd-992f-c2b6767e0a92	receptionist	администратор	noun	Talk to the receptionist	A1	audio/word_receptionist_7e0cd83b.mp3	rɪˈsɛpʃənɪst	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
66894c42-ded3-4018-82a4-6bf7c960614f	insurance	страховка	noun	Do you have health insurance?	A1	audio/word_insurance_dc4ec461.mp3	ˌɪnˈʃʊrəns	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
bf95113e-7165-4798-93ad-9e7dd79a63f9	health card	медицинская карта	noun	Bring your health card	A1	audio/word_health_card_defddb54.mp3	hɛlθ kɑrd	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
55d6bcb1-74fe-4e76-b672-d89e2ff5f340	offer	предлагать	verb	They offer same-day appointments	A1	audio/word_offer_d68438ea.mp3	ˈɔfər	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
51419fb4-7a18-4fa9-9d7e-7976a92e336f	wait	ждать	verb	You might have to wait	A1	audio/word_wait_e6a037f2.mp3	weɪt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
e884122e-b1a7-4e36-a1cd-ea9dc391b7ca	urgent	срочный	adjective	Is it urgent?	A1	audio/word_urgent_3e2ebd36.mp3	ˈərʤənt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
c84e67d6-8f12-49cf-8628-687b99d3dd87	take number	взять номер	phrasal verb	Take a number from the dispenser	A2	audio/word_take_number_962ffb52.mp3	teɪk ˈnəmbər	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
33bbe067-b1bf-42e9-a332-95091cfd1339	appointment time	время приема	phrase	What time is your appointment?	A1	audio/word_appointment_time_a80d62ac.mp3	əˈpɔɪntmənt taɪm	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
3ef416cf-09b5-495b-98ea-7e05a6ff1c2f	doctor's office	кабинет врача	phrase	The doctor's office is on the second floor	A1	audio/word_doctor's_office_ad2c4560.mp3	ˈdɑktərz ˈɔfəs	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
6fa1414d-6540-44be-b700-d134980ca80e	how soon	как скоро	phrase	How soon can I be seen?	A1	audio/word_how_soon_6ef22207.mp3	haʊ sun	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
5b91b1ab-5c59-43a9-be32-e2a956f5fccd	problem	проблема	noun	What’s your problem today?	A1	audio/word_problem_058e8110.mp3	ˈprɑbləm	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
d19c07b7-a23d-41c3-9137-8898144be85d	nurse	медсестра	noun	The nurse will assist you	A1	audio/word_nurse_7c8b7072.mp3	nərs	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
a2152bf1-0920-45d7-9fa2-a2b992755816	emergency	экстренный случай	noun	This is not an emergency	A1	audio/word_emergency_90d9778c.mp3	ˈimərʤənsi	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
290e3991-5d28-45df-9dff-82fc44956a1c	open	открытый	adjective	When is the clinic open?	B1	audio/word_open_e70c97a9.mp3	ˈoʊpən	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
2aa2dd3e-9f4c-434d-a9a9-7a82ee964ea3	when	когда	adverb	When are you available?	A1	audio/word_when_a0f521e5.mp3	wɪn	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
ca8affed-2204-4d80-a6ff-798ac6cc8de5	history	история	noun	Medical history is required	A2	audio/word_history_4a139e24.mp3	ˈhɪstəri	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
d82cf3c6-eceb-470d-996d-ddb8d47e4049	call	звонить	verb	Call to make an appointment	A1	audio/word_call_5c6753bb.mp3	kɔl	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
eaf7008c-3708-4954-9cdc-eebccd9c0260	need	нуждаться	verb	I need a checkup	A1	audio/word_need_230e85d5.mp3	nid	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
f941bff2-ec8c-451e-a49a-beba50c8e030	visit	визит	noun	Your next visit is in two weeks	A1	audio/word_visit_170fcac9.mp3	ˈvɪzɪt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
922d220f-e339-49db-8a5a-3fa3433f42dd	examination	осмотр	noun	She needs a full examination	A2	audio/word_examination_17c90d1a.mp3	ɪgˌzæməˈneɪʃən	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
f1986bad-f0d4-42db-a722-93ed6a7e119a	prescribe	назначить	verb	The doctor will prescribe medication	B2	audio/word_prescribe_edbdcda6.mp3	prəˈskraɪb	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
5003ed73-6045-4e35-bb3b-961afab393f9	follow-up	повторный визит	noun	Schedule a follow-up appointment	A2	audio/word_follow-up_fe6b8c0b.mp3	ˈfɑloʊˌəp	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
25f86b9d-073b-4082-a415-3f4be85b495f	medical record	медицинская карта	noun	Update your medical record	A2	audio/word_medical_record_dde8b7f5.mp3	ˈmɛdɪkəl ˈrɛkərd	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
ab59351e-b5d1-4878-b3f0-428a29bb0b6e	procedure	процедур	noun	What procedure are you scheduled for?	A2	audio/word_procedure_90bd428e.mp3	prəˈsiʤər	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
94ae686f-eff4-44b5-bd3e-8facd6bab067	time	время	noun	What time is it?	A1	audio/word_time_3ac7ebcd.mp3	taɪm	96dbf3ae-869f-4393-bccd-9939fc05f646
bbf71fc5-d6de-4558-b2fc-5e14bda4e6d1	o'clock	ровно	phrase	It's three o'clock	A1	audio/word_o'clock_5ddd5893.mp3	əˈklɑk	96dbf3ae-869f-4393-bccd-9939fc05f646
601d4989-558e-47d7-88df-2af29a643303	half	половина	noun	It's half past two	A1	audio/word_half_ed7d9666.mp3	hæf	96dbf3ae-869f-4393-bccd-9939fc05f646
4f9cdc3f-1801-4639-952a-1a0df3a753f7	quarter	четверть	noun	It's a quarter to five	A1	audio/word_quarter_3f0dda4e.mp3	kˈwɔrtər	96dbf3ae-869f-4393-bccd-9939fc05f646
fe727ee8-4fbd-4f26-b67f-dd10d9977a6b	past	после	preposition	Twenty past six	A1	audio/word_past_af863bda.mp3	pæst	96dbf3ae-869f-4393-bccd-9939fc05f646
3f99e398-ff44-4347-9743-9beb583ca4ff	to	до	preposition	Ten to seven	A1	audio/word_to_9507fd56.mp3	tɪ	96dbf3ae-869f-4393-bccd-9939fc05f646
0ab722f8-ba6b-4d10-a056-f7d45585a86c	minute	минута	noun	Five minutes to go	A1	audio/word_minute_45e23ec7.mp3	ˈmɪnət	96dbf3ae-869f-4393-bccd-9939fc05f646
1e166566-4357-487d-b845-f13cb0268c25	hour	час	noun	Two hours late	A1	audio/word_hour_cfcac0df.mp3	aʊər	96dbf3ae-869f-4393-bccd-9939fc05f646
4250c04c-e03a-40bd-9daf-58071f822b19	morning	утро	noun	Morning departure	A1	audio/word_morning_7d23e47d.mp3	ˈmɔrnɪŋ	96dbf3ae-869f-4393-bccd-9939fc05f646
2f02496e-5a30-438b-9d4c-8570627d1681	afternoon	день	noun	Afternoon arrival	A1	audio/word_afternoon_ca193dc8.mp3	ˌæftərˈnun	96dbf3ae-869f-4393-bccd-9939fc05f646
e0904453-e4f1-4bec-8798-1640ab06bc5b	evening	вечер	noun	Evening flight	A1	audio/word_evening_aa0e3c4a.mp3	ˈivnɪŋ	96dbf3ae-869f-4393-bccd-9939fc05f646
7e1301ac-e671-4367-9dc4-8f736991525b	night	ночь	noun	Night flight	A1	audio/word_night_73be77eb.mp3	naɪt	96dbf3ae-869f-4393-bccd-9939fc05f646
fd5d2051-44c2-4a80-9911-b496fc004559	now	сейчас	adverb	Get it now right now	A1	audio/word_now_eded64fd.mp3	naʊ	96dbf3ae-869f-4393-bccd-9939fc05f646
a281c51a-5c41-4ee5-a816-892a04ab785d	early	рано	adverb	Early check-in	A1	audio/word_early_885273e8.mp3	ˈərli	96dbf3ae-869f-4393-bccd-9939fc05f646
929c0712-bbb3-4471-8711-c8804d30657a	late	поздно	adverb	Late arrival	A1	audio/word_late_c105f6a7.mp3	leɪt	96dbf3ae-869f-4393-bccd-9939fc05f646
ba6cd3e5-cad4-4834-b4ab-fba871c1a878	am	утра	abbreviation	10 am check-in	A1	audio/word_am_dcc1ef12.mp3	æm	96dbf3ae-869f-4393-bccd-9939fc05f646
523d7b80-5024-4cef-8f61-3688f0a6fe37	pm	вечера	abbreviation	4 pm boarding	A1	audio/word_pm_3c1c8c4b.mp3	piɛm	96dbf3ae-869f-4393-bccd-9939fc05f646
0ec82910-c5c4-4ce1-82f5-1632ef902886	schedule	расписание	noun	Flight schedule	A1	audio/word_schedule_efd06b22.mp3	ˈskɛʤʊl	96dbf3ae-869f-4393-bccd-9939fc05f646
d6b41344-bf88-45cc-96e8-81b6b8407f1d	departure	вылет	noun	Departure time	A1	audio/word_departure_339ee05f.mp3	dɪˈpɑrʧər	96dbf3ae-869f-4393-bccd-9939fc05f646
64c85973-8bd7-44d2-998f-c84851616d59	arrival	прибытие	noun	Arrival gate	A1	audio/word_arrival_88deea39.mp3	ərˈaɪvəl	96dbf3ae-869f-4393-bccd-9939fc05f646
947b45ea-8111-40a5-9da3-e0b09d925cca	local time	местное время	noun	Arrival local time	A2	audio/word_local_time_e273703f.mp3	ˈloʊkəl taɪm	96dbf3ae-869f-4393-bccd-9939fc05f646
5352b457-248f-4f77-923a-427cff930614	flight time	время полета	noun	Flight duration	A2	audio/word_flight_time_4cc2a064.mp3	flaɪt taɪm	96dbf3ae-869f-4393-bccd-9939fc05f646
177e865e-7d87-4956-9664-6422c1acc74a	departure gate	гейт вылета	noun	Gate departure time	A2	audio/word_departure_gate_12fa1e5f.mp3	dɪˈpɑrʧər geɪt	96dbf3ae-869f-4393-bccd-9939fc05f646
26987310-475d-4456-abaf-fecac2148b65	connecting flight	трансфер	noun	Connecting time	A2	audio/word_connecting_flight_e9653bd1.mp3	kəˈnɛktɪŋ flaɪt	96dbf3ae-869f-4393-bccd-9939fc05f646
dae6d3eb-5818-4650-8300-3debc21ebdfe	ten past three	десять минут третьего	phrase	Boarding at ten past three	A2	audio/word_ten_past_cb3cf508.mp3	tɛn pæst θri	96dbf3ae-869f-4393-bccd-9939fc05f646
bcd6cb78-ff9a-4a52-9c7b-0b44db34af1e	twenty past five	двадцать минут шестого	phrase	Departure at twenty past five	A2	audio/word_twenty_past_0fd2fc1b.mp3	tˈwɛnti pæst faɪv	96dbf3ae-869f-4393-bccd-9939fc05f646
73c0f4c4-65dc-44ec-baa9-b032bf434bb4	half past seven	половина восьмого	phrase	Flight at half past seven	A2	audio/word_half_past_defd74c3.mp3	hæf pæst ˈsɛvən	96dbf3ae-869f-4393-bccd-9939fc05f646
9658bb1b-24d9-4a6f-a5f6-349e4f1c0c04	quarter past ten	десять минут одиннадцатого	phrase	Meeting at quarter past ten	A2	audio/word_quarter_past_7420cdf1.mp3	kˈwɔrtər pæst tɛn	96dbf3ae-869f-4393-bccd-9939fc05f646
d15013be-8ec4-4bda-b1aa-b6e6af9beb78	quarter to six	без четверти шесть	phrase	Check-in closes quarter to six	A2	audio/word_quarter_to_c31a203f.mp3	kˈwɔrtər tɪ sɪks	96dbf3ae-869f-4393-bccd-9939fc05f646
abc1c4b4-64fb-48c8-bf4a-bb2b589d8c97	five to eight	без пяти восемь	phrase	Gates close five to eight	A2	audio/word_five_to_06dd16cd.mp3	faɪv tɪ eɪt	96dbf3ae-869f-4393-bccd-9939fc05f646
6c0a10cc-ef30-4d05-8535-a46544e30e0a	timetable	расписание	noun	Timetable changes	A2	audio/word_timetable_30b329a8.mp3	ˈtaɪmˌteɪbəl	96dbf3ae-869f-4393-bccd-9939fc05f646
87afd049-09e1-47d1-a457-73270cdf2e6e	delayed	задержан	adjective	Delayed departure	B1	audio/word_delayed_1d8174b9.mp3	dɪˈleɪd	96dbf3ae-869f-4393-bccd-9939fc05f646
051c5db5-1e31-4d78-9ce4-e759e69dcc51	reschedule	перенести	verb	We'll reschedule your flight	B1	audio/word_reschedule_d5cf55e2.mp3	riˈskɛʤul	96dbf3ae-869f-4393-bccd-9939fc05f646
62ead9b2-77b9-4a63-bea2-8a6dbba5ef65	connecting time	время на пересадку	noun	Minimum connecting time	B1	audio/word_connecting_time_4ff0351c.mp3	kəˈnɛktɪŋ taɪm	96dbf3ae-869f-4393-bccd-9939fc05f646
4725c000-3d75-44c6-9e91-fefb49a9e62d	time zone	часовой пояс	noun	Cross time zones	B1	audio/word_time_zone_66c43ed5.mp3	taɪm zoʊn	96dbf3ae-869f-4393-bccd-9939fc05f646
fd08e28f-b58f-4dea-ac75-a160e8299c4a	daylight saving	летнее время	noun	Change clocks for DST	B1	audio/word_daylight_saving_ffbdd3b7.mp3	ˈdeɪˌlaɪt ˈseɪvɪŋ	96dbf3ae-869f-4393-bccd-9939fc05f646
0f4a378a-cd2e-4a4e-925a-9d52a1554364	schedule conflict	конфликт расписания	noun	Schedule conflict detected	B2	audio/word_schedule_conflict_4ff81dda.mp3	ˈskɛʤʊl ˈkɑnflɪkt	96dbf3ae-869f-4393-bccd-9939fc05f646
ba47b84d-2e06-4e2a-b47b-b2aafa5be823	timetabling	составление расписания	noun	Timetabling process	B2	audio/word_timetabling_301980b1.mp3	timetabling*	96dbf3ae-869f-4393-bccd-9939fc05f646
db9b9176-4c02-4bb6-8a25-4fbbddd7b274	my flight is at 9am	мой рейс в 9 утра	phrase	My flight is at 9am	A1	audio/word_my_flight_98ae5860.mp3	maɪ flaɪt ɪz æt 9am*	96dbf3ae-869f-4393-bccd-9939fc05f646
4acb2755-52db-4ee0-a4ca-804e53aa0334	what's the departure time?	во время вылета?	phrase	What's the departure time?	A1	audio/word_what's_the_afbfabfd.mp3	wəts ðə dɪˈpɑrʧər taɪm?	96dbf3ae-869f-4393-bccd-9939fc05f646
1eb19561-a327-4a4c-9711-24fb6218ac45	the plane leaves on time	самолет вылетает вовремя	phrase	The plane leaves on time	A1	audio/word_the_plane_e9ce604f.mp3	ðə pleɪn livz ɔn taɪm	96dbf3ae-869f-4393-bccd-9939fc05f646
07a599da-16c2-4169-a0ed-e42a5247f85c	boarding starts in 15 minutes	посадка начнется через 15 минут	phrase	Boarding starts in 15 minutes	A1	audio/word_boarding_starts_92725548.mp3	ˈbɔrdɪŋ stɑrts ɪn 15 ˈmɪnəts	96dbf3ae-869f-4393-bccd-9939fc05f646
a3abfc54-df68-43a3-93fc-57cdde871430	flight duration is 5 hours	продолжительность полета 5 часов	phrase	Flight duration is 5 hours	A2	audio/word_flight_duration_35f26eb4.mp3	flaɪt ˈdʊˈreɪʃən ɪz 5 aʊərz	96dbf3ae-869f-4393-bccd-9939fc05f646
6fe3c4ef-13c0-49ed-82b5-f2f7725e86d7	crossed 3 time zones	пересек 3 часовых пояса	phrase	Crossed 3 time zones	A2	audio/word_crossed_3_e80b55e0.mp3	krɔst 3 taɪm zoʊnz	96dbf3ae-869f-4393-bccd-9939fc05f646
4c17cb49-ed83-420a-9750-2b3f0c9b6fb9	daylight saving time started	перешли на летнее время	phrase	Daylight saving time started	B1	audio/word_daylight_saving_3bc00afa.mp3	ˈdeɪˌlaɪt ˈseɪvɪŋ taɪm ˈstɑrtɪd	96dbf3ae-869f-4393-bccd-9939fc05f646
1469046c-a3cd-4463-815d-7706c4d38ebb	flight schedule changed	расписание рейса изменилось	phrase	Flight schedule changed	B1	audio/word_flight_schedule_e3f1da0e.mp3	flaɪt ˈskɛʤʊl ʧeɪnʤd	96dbf3ae-869f-4393-bccd-9939fc05f646
2f583bfe-c065-4a0b-b034-f47344f57046	connecting flight too short	слишком мало времени на пересадку	phrase	Connecting flight too short	B1	audio/word_connecting_flight_77485002.mp3	kəˈnɛktɪŋ flaɪt tu ʃɔrt	96dbf3ae-869f-4393-bccd-9939fc05f646
e6ba9e36-5b6e-41d0-b240-6a9bb9a893e8	opening hours	время работы	compound noun	What are the opening hours of the currency exchange?	A2	audio/word_opening_hours_11cd6f06.mp3	ˈoʊpənɪŋ aʊərz	b2073d08-e313-4b58-8ff6-85ca9b858ad8
d05e465b-93b0-42c1-9924-57a671d4982d	closing time	время закрытия	noun	What is the closing time for the restaurant?	A1	audio/word_closing_time_f9f7fbd8.mp3	ˈkloʊzɪŋ taɪm	b2073d08-e313-4b58-8ff6-85ca9b858ad8
c8173d10-82c9-4a01-8eeb-42784314b830	schedule	расписание	noun	Where can I find the departure schedule?	A1	audio/word_schedule_e9f56662.mp3	ˈskɛʤʊl	b2073d08-e313-4b58-8ff6-85ca9b858ad8
8623cc51-367d-4701-9a47-829ccb67b3b4	departure time	время вылета	noun	What is the departure time for flight AA275?	A1	audio/word_departure_time_4249ee59.mp3	dɪˈpɑrʧər taɪm	b2073d08-e313-4b58-8ff6-85ca9b858ad8
a5eed4db-b6b4-4e67-91b9-94be3ceb0bc0	arrival time	время прилета	noun	The arrival time has been delayed.	A1	audio/word_arrival_time_3d726819.mp3	ərˈaɪvəl taɪm	b2073d08-e313-4b58-8ff6-85ca9b858ad8
60a18c71-9b56-4b98-bf8e-a6c9011a5045	delay	задержка	noun	My flight is delayed by three hours.	A2	audio/word_delay_82e85146.mp3	dɪˈleɪ	b2073d08-e313-4b58-8ff6-85ca9b858ad8
a05f5e7a-ec26-4e61-887a-9b75e73be95e	on time	по расписанию	adjective	Is the flight on schedule?	A1	audio/word_on_time_844e265d.mp3	ɔn taɪm	b2073d08-e313-4b58-8ff6-85ca9b858ad8
366a2128-19d3-497f-9f00-b8d87723cebf	boarding time	время посадки	noun	What time does boarding start?	A2	audio/word_boarding_time_6ec3f6c9.mp3	ˈbɔrdɪŋ taɪm	b2073d08-e313-4b58-8ff6-85ca9b858ad8
30c57ced-fb51-4f1a-bfc1-5bb7194534f1	gate	выход	noun	Which gate should I go for my connection?	A1	audio/word_gate_98c48b40.mp3	geɪt	b2073d08-e313-4b58-8ff6-85ca9b858ad8
f2ffe75e-0df0-4a4f-9c1a-e984361e37c0	check-in closes	регистрация закрывается	verb	Check-in closes one hour before departure.	A1	audio/word_check-in_closes_72fef058.mp3	check-in* ˈkloʊzɪz	b2073d08-e313-4b58-8ff6-85ca9b858ad8
76bc8cbe-7645-451a-aa45-9d9296aa1298	opens at	открывается в	phrase	The duty-free shop opens at 8 AM.	A1	audio/word_opens_at_6fdaf45b.mp3	ˈoʊpənz æt	b2073d08-e313-4b58-8ff6-85ca9b858ad8
1ab83142-865a-4c97-a196-ad77989eb44b	closes at	закрывается в	phrase	The information desk closes at midnight.	A1	audio/word_closes_at_bb553bcb.mp3	ˈkloʊzɪz æt	b2073d08-e313-4b58-8ff6-85ca9b858ad8
06b2cf49-4e78-45a4-aa9d-60fb53541883	now open	сейчас открыто	phrase	Is the lost and found counter now open?	A1	audio/word_now_open_1f503ea9.mp3	naʊ ˈoʊpən	b2073d08-e313-4b58-8ff6-85ca9b858ad8
4bb53152-cca3-486f-ad02-3c32e4746c47	now closed	сейчас закрыто	phrase	The ATM is now closed.	A1	audio/word_now_closed_8497b924.mp3	naʊ kloʊzd	b2073d08-e313-4b58-8ff6-85ca9b858ad8
cfa1917f-faf1-4eb9-9d56-c514a5d063a3	What time does...open?	Во сколько открывается...?	phrase	What time does the pharmacy open?	A2	audio/word_what_time_9eea9c32.mp3	wət taɪm does...open*?	b2073d08-e313-4b58-8ff6-85ca9b858ad8
0a0fe004-f06b-46eb-87f9-b12fcfe2c700	What time does...close?	Во сколько закрывается...?	phrase	What time does the luggage storage close?	A2	audio/word_what_time_168c89ee.mp3	wət taɪm does...close*?	b2073d08-e313-4b58-8ff6-85ca9b858ad8
ca3729d6-f074-4583-a74a-26b1bb193d28	24 hours	круглосуточно	compound noun	Is there a 24-hour restaurant at the airport?	B1	audio/word_24_hours_f361c9d1.mp3	24 aʊərz	b2073d08-e313-4b58-8ff6-85ca9b858ad8
bc76cd5e-be82-4f9c-a649-a5d839c197ff	until	до	preposition	Open until the last flight departs.	A1	audio/word_until_e248df44.mp3	ənˈtɪl	b2073d08-e313-4b58-8ff6-85ca9b858ad8
fb4e6b18-ca9c-4015-aa4a-b0dda9d19780	early closing	раннее закрытие	phrase	There is an early closing on Christmas Eve.	B1	audio/word_early_closing_a054b2c4.mp3	ˈərli ˈkloʊzɪŋ	b2073d08-e313-4b58-8ff6-85ca9b858ad8
ebc4e3d0-a93d-4d72-a441-5b87abbf6636	business hours	время работы	noun	What are the business hours for the airport lounge?	B1	audio/word_business_hours_d1a652ef.mp3	ˈbɪznɪs aʊərz	b2073d08-e313-4b58-8ff6-85ca9b858ad8
8eaecb64-f4df-41f0-b08f-548180e6d108	Timetable	расписание	noun	Could you show me the flight timetable?	A1	audio/word_timetable_91400d58.mp3	ˈtaɪmˌteɪbəl	b2073d08-e313-4b58-8ff6-85ca9b858ad8
a1256538-7ee3-43db-88e2-cc6762027efa	Boarding	посадка	noun	Boarding will begin in 30 minutes.	A1	audio/word_boarding_0521a6b3.mp3	ˈbɔrdɪŋ	b2073d08-e313-4b58-8ff6-85ca9b858ad8
50ac2240-bf99-418b-953a-1d1521374b3e	day	день	noun	Which day is your flight?	A1	audio/word_day_8bdcffdf.mp3	deɪ	53e0c106-9803-4a4e-a880-f36db64c1373
e3278cab-0083-4465-b1dc-5c5e679cedfa	month	месяц	noun	Which month does your holiday fall in?	A1	audio/word_month_4686cad1.mp3	mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
c6930345-12af-4aa8-862d-79d426c9721b	date	дата	noun	Could you confirm the travel date?	A1	audio/word_date_afffc432.mp3	deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
bc897021-8d5c-4b87-8c22-1df85b56038f	today	сегодня	adverb	Today is the departure day	A1	audio/word_today_39d20868.mp3	təˈdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
8d1d19f1-72ef-48fd-84ee-2d806d5c8313	tomorrow	завтра	adverb	The flight departs tomorrow	A1	audio/word_tomorrow_ec8f3fb7.mp3	təˈmɑˌroʊ	53e0c106-9803-4a4e-a880-f36db64c1373
ded38074-b9d6-455c-8a10-2e6506ceb541	yesterday	вчера	adverb	Arrived yesterday	A1	audio/word_yesterday_0f8124ef.mp3	ˈjɛstərˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
9069ae91-f4ce-4105-906b-ffda4f3ac16d	weekday	будний день	noun	Weekday fares are cheaper	B1	audio/word_weekday_1b8a1029.mp3	ˈwikˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
eecec22f-1db5-4c57-9a93-681af123134c	weekend	выходные	noun	Weekend travel requires advance notice	A2	audio/word_weekend_8ee2fc91.mp3	ˈwiˌkɪnd	53e0c106-9803-4a4e-a880-f36db64c1373
49894395-3c03-4b21-b015-a7342de50633	year	год	noun	Which year is your booking for?	A1	audio/word_year_b078b04e.mp3	jɪr	53e0c106-9803-4a4e-a880-f36db64c1373
eeefeada-07ef-4433-8f0c-809b1a78e2ef	calendar	календарь	noun	Check the calendar for free dates	A2	audio/word_calendar_7624b414.mp3	ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
8fd70bef-0a64-4701-b603-a4a0ad700a32	schedule	расписание	noun	The flight schedule is online	B1	audio/word_schedule_eb0b2484.mp3	ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
af0841b4-a58f-492c-a5fa-41d249bfc320	season	сезон	noun	Off-season travel is budget-friendly	A2	audio/word_season_58132dbf.mp3	ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
e4493f46-f5a6-4d6c-b26d-d4c098067dfe	in advance	заранее	наречие	Book the ticket in advance	B1	audio/word_in_advance_a643e763.mp3	ɪn ədˈvæns	53e0c106-9803-4a4e-a880-f36db64c1373
815efb74-2544-4d11-b1cf-d01e7b0bc11f	public holiday	государственный праздник	noun	Holidays affect flight prices	B1	audio/word_public_holiday_8271618d.mp3	ˈpəblɪk ˈhɑlɪˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
6352695b-615e-4cd3-82f5-aa9534ca66da	check the date	проверить дату	глагол	Always check the date on your ticket	A2	audio/word_check_the_a2412241.mp3	ʧɛk ðə deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
b53f16d9-806f-4584-b430-69e3db32ac99	what's the date?	какая сегодня дата?	фраза	Excuse me, what's the date today?	A1	audio/word_what's_the_e9d43e47.mp3	wəts ðə deɪt?	53e0c106-9803-4a4e-a880-f36db64c1373
4ffa63b2-3eb4-4298-8ad1-33ea2b649501	month of the year	месяц года	фраза	January is the first month of the year	A1	audio/word_month_of_bbb49452.mp3	mənθ əv ðə jɪr	53e0c106-9803-4a4e-a880-f36db64c1373
e7302e31-4c8d-4c20-ba37-357db77505ce	weekend	выходные	noun	Weekend travel requires advance notice	A2	audio/word_weekend_81e7d9ac.mp3	ˈwiˌkɪnd	53e0c106-9803-4a4e-a880-f36db64c1373
55781669-747a-46b3-993f-b2c10ea49f84	day of the week	день недели	фраза	What day of the week is the check-in?	A1	audio/word_day_of_2a0265e7.mp3	deɪ əv ðə wik	53e0c106-9803-4a4e-a880-f36db64c1373
3595b7ba-18ff-4a71-84ae-f67146884228	birth date	дата рождения	noun	You must enter your birth date	A1	audio/word_birth_date_a5de8a52.mp3	bərθ deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
61778aea-0c03-4adb-9637-aa08555e5b8c	this week	на этой неделе	фраза	I'll fly this week	A1	audio/word_this_week_b92e621a.mp3	ðɪs wik	53e0c106-9803-4a4e-a880-f36db64c1373
27746377-705d-4998-82ab-63bb41185070	next week	на следующей неделе	фраза	Meeting schedules move to next week	A1	audio/word_next_week_c9a42f2c.mp3	nɛkst wik	53e0c106-9803-4a4e-a880-f36db64c1373
c30abf2d-e84c-4c08-9017-0df322c6885a	last week	на прошлой неделе	фраза	Booked tickets last week	A1	audio/word_last_week_88123ab6.mp3	læst wik	53e0c106-9803-4a4e-a880-f36db64c1373
9afd1ed8-ded8-42bc-8646-e8684249c565	time zone	часовой пояс	noun	Adjust for different time zones	B1	audio/word_time_zone_e4da5668.mp3	taɪm zoʊn	53e0c106-9803-4a4e-a880-f36db64c1373
8b2bed17-33e6-4aa0-a0f6-a3f6aab4b2e6	midnight	полночь	noun	Departure at midnight meets the schedule	A1	audio/word_midnight_263c215f.mp3	ˈmɪdˌnaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
f3d2366a-a2d6-4432-a6bf-59a8af367808	noon	полдень	noun	Arrival at noon is convenient	A1	audio/word_noon_c59ddf6d.mp3	nun	53e0c106-9803-4a4e-a880-f36db64c1373
c44ca6a4-a8c9-49c3-bbaa-08b064a6b2fa	from...to...	с...по...	предлог	Trip from June to July	A1	audio/word_from...to..._671d905b.mp3	from...to*...	53e0c106-9803-4a4e-a880-f36db64c1373
a9589b2a-d944-4514-998e-0a5e5a0e1ae5	date of birth	дата рождения	фраза	Enter your date of birth please	A1	audio/word_date_of_c49277f3.mp3	deɪt əv bərθ	53e0c106-9803-4a4e-a880-f36db64c1373
b0360778-f382-437c-91a1-2a153434e856	timetable	расписание	noun	Check the bus timetable	A1	audio/word_timetable_5571dd19.mp3	ˈtaɪmˌteɪbəl	53e0c106-9803-4a4e-a880-f36db64c1373
123c8a22-3c00-45c6-86e5-aa1d865eb8fa	last month	в прошлом месяце	фраза	Travel costs increased last month	B1	audio/word_last_month_6283a5f1.mp3	læst mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
751fdca2-109d-4f03-a4fd-865b800e7b65	next month	в следующем месяце	фраза	Will finalize plans next month	B1	audio/word_next_month_bd5c137d.mp3	nɛkst mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
2f4050ff-c970-4df2-90f8-08e5775ecc6d	quarter	квартал	noun	Earnings fell in the third quarter	B2	audio/word_quarter_905b2e60.mp3	kˈwɔrtər	53e0c106-9803-4a4e-a880-f36db64c1373
ce624fbd-a078-4423-b0bd-38d300fb43f7	fortnight	две недели	noun	I'll stay for a fortnight	B2	audio/word_fortnight_aff05741.mp3	ˈfɔrtˌnaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
e74af809-3a2c-46f8-86d9-e96e18798a28	annual expenditure	годовые расходы	фраза	Track annual expenditure	B2	audio/word_annual_expenditure_f0951946.mp3	ˈænjuəl ɪkˈspɛndɪʧər	53e0c106-9803-4a4e-a880-f36db64c1373
e6efa6f9-f1ce-4a6a-aac8-7526cae3f1b0	booking window	окно бронирования	фраза	Best booking window opens soon	B2	audio/word_booking_window_0117326f.mp3	ˈbʊkɪŋ ˈwɪndoʊ	53e0c106-9803-4a4e-a880-f36db64c1373
72a2feaa-a695-4368-90a0-fba325e2f023	high season	высокий сезон	фраза	High season prices are steep	B1	audio/word_high_season_03174333.mp3	haɪ ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
167b6b9b-476e-41a7-b9ec-ea9c2a04b3f5	low season	низкий сезон	фраза	Low season discounts are available	B1	audio/word_low_season_dbb286a5.mp3	loʊ ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
882026a5-31bc-4a03-8304-897dc3f289d7	weekdays off	выходные в будние дни	фраза	Scheduling week days off is rare	B1	audio/word_weekdays_off_ab4d3262.mp3	ˈwikˌdeɪz ɔf	53e0c106-9803-4a4e-a880-f36db64c1373
b2e60549-be4c-49b5-963b-88ca1e8c7285	planned arrival	планируемый прилет	фраза	Planned arrival matches the schedule	B1	audio/word_planned_arrival_ec51d14c.mp3	plænd ərˈaɪvəl	53e0c106-9803-4a4e-a880-f36db64c1373
8b0fc5e6-8072-4b55-a5e1-d19fe6701200	time slot	временной слот	фраза	Select your preferred time slot	B1	audio/word_time_slot_da37e747.mp3	taɪm slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
d32f5838-5cb5-414a-a39a-f59757bf7571	date range	диапазон дат	фраза	Enter the date range результатов	B2	audio/word_date_range_0169d0ee.mp3	deɪt reɪnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
7bdf60a8-6bbc-49e4-9760-e76a8d1826d5	day trip	однодневная поездка	фраза	Day trips during holidays	B1	audio/word_day_trip_633403ae.mp3	deɪ trɪp	53e0c106-9803-4a4e-a880-f36db64c1373
0190f6e9-b07c-4fbb-8f4f-3efe404aa29a	monthly pass	ежемесячный проездной	noun	Buy a monthly pass for commutes	B2	audio/word_monthly_pass_c5fe3844.mp3	ˈmənθli pæs	53e0c106-9803-4a4e-a880-f36db64c1373
7ac6650c-c1e7-4551-b12a-a8f615c6299a	annual report	годовой отчет	noun	Fiscal year closed in the annual report	C1	audio/word_annual_report_748660fc.mp3	ˈænjuəl rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
23b1e0b4-0e03-4fea-8d3d-054a116fc081	seasonal ticket	сезонный билет	noun	Seasonal ticket offers savings	B1	audio/word_seasonal_ticket_136f186d.mp3	ˈsizənəl ˈtɪkɪt	53e0c106-9803-4a4e-a880-f36db64c1373
0c42bbbf-ddef-4b62-ace6-41d8cf0baec0	daylight saving time	летнее время	фраза	Change clocks during daylight saving time	B1	audio/word_daylight_saving_9cde794d.mp3	ˈdeɪˌlaɪt ˈseɪvɪŋ taɪm	53e0c106-9803-4a4e-a880-f36db64c1373
3aadb229-c730-479d-b835-2da7acf0dde9	flight path	маршрут полета	noun	Check flight path on maps	B2	audio/word_flight_path_73f6ca10.mp3	flaɪt pæθ	53e0c106-9803-4a4e-a880-f36db64c1373
a309650f-0d19-4eeb-b1a6-8417b71aa8f8	arrival date change	изменение даты прибытия	фраза	Arrival date change fee applies	A2	audio/word_arrival_date_e248b6ce.mp3	ərˈaɪvəl deɪt ʧeɪnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
c584e2f5-13ff-4cad-a09f-e00f50720ba5	departure time	время вылета	фраза	Departure time is noted in the ticket	A1	audio/word_departure_time_bd32bb9a.mp3	dɪˈpɑrʧər taɪm	53e0c106-9803-4a4e-a880-f36db64c1373
a933d101-81a6-4603-b6f2-07bc93149510	date validation	проверка даты	фраза	Date validation shows no conflicts	A2	audio/word_date_validation_71699851.mp3	deɪt ˌvæləˈdeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
c59ff904-25e2-43dc-9c15-86dd3d123d20	travel date selection	выбор даты поездки	фраза	Travel date selection affects price	B1	audio/word_travel_date_00f61f0e.mp3	ˈtrævəl deɪt səˈlɛkʃən	53e0c106-9803-4a4e-a880-f36db64c1373
e855cbfc-f9ff-4beb-a122-2b8f1411961c	booking confirmation	подтверждение бронирования	фраза	Booking confirmation has the date	A1	audio/word_booking_confirmation_ea8a9a09.mp3	ˈbʊkɪŋ ˌkɑnfərˈmeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
d263fc69-5a83-48bb-a62d-260576fb7b4e	weekend getaway	выходные поездка	фраза	Plan a weekend getaway	B1	audio/word_weekend_getaway_0a621842.mp3	ˈwiˌkɪnd ˈgɛtəˌweɪ	53e0c106-9803-4a4e-a880-f36db64c1373
b1a12ecb-8fd4-4502-ad85-8e2a42d6496c	trip duration	длительность поездки	фраза	Trip duration is two weeks	B1	audio/word_trip_duration_1ce7778e.mp3	trɪp ˈdʊˈreɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
bc379d55-facf-4713-aeeb-11c720a60e7c	last day off	последний выходной	фраза	Last day off before vacation	B1	audio/word_last_day_8e90af36.mp3	læst deɪ ɔf	53e0c106-9803-4a4e-a880-f36db64c1373
ff78db9c-8d1c-476d-b671-34baf3d89a3f	next Monday	в понедельник	фраза	Meeting scheduled for next Monday	A1	audio/word_next_monday_d5391af3.mp3	nɛkst ˈmənˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
cf5c0907-297b-4044-8ad4-a7422f183a82	clocks go forward	часы переводят вперед	фраза	Clocks go forward in spring	C1	audio/word_clocks_go_309422a7.mp3	klɑks goʊ ˈfɔrwərd	53e0c106-9803-4a4e-a880-f36db64c1373
b8cd7c8d-4cc2-43c4-a112-70d167a45c7e	clocks go back	часы переводят назад	фраза	Clocks go back in autumn	C1	audio/word_clocks_go_687bbdf8.mp3	klɑks goʊ bæk	53e0c106-9803-4a4e-a880-f36db64c1373
06b5c8bd-6fc1-4e2b-aece-40b4e86fc280	monthly limit	месячный лимит	фраза	Stay within the monthly limit	B2	audio/word_monthly_limit_7eb687c1.mp3	ˈmənθli ˈlɪmət	53e0c106-9803-4a4e-a880-f36db64c1373
1342f58c-5833-4832-8bfe-cdbe56196727	annual festival	годовой фестиваль	фраза	Annual festival draws crowds	B2	audio/word_annual_festival_d85c413f.mp3	ˈænjuəl ˈfɛstɪvəl	53e0c106-9803-4a4e-a880-f36db64c1373
7a9d50cb-f4cb-4a3a-8c54-a76eb10229ef	date of expiry	дата истечения	фраза	Check date of expiry on card	A1	audio/word_date_of_54a2d4a3.mp3	deɪt əv ˌɛkˈspaɪri	53e0c106-9803-4a4e-a880-f36db64c1373
d49b56c3-6cc1-4b02-9254-af4e543699d2	travel period	период поездки	фраза	Travel period coincides with holidays	B1	audio/word_travel_period_6232fb80.mp3	ˈtrævəl ˈpɪriəd	53e0c106-9803-4a4e-a880-f36db64c1373
bbb3ed8c-957d-4fc2-8cfa-f7113db9fad2	departure hall	вылет	фраза	Departure hall opens two hours early	A1	audio/word_departure_hall_b93ae68f.mp3	dɪˈpɑrʧər hɔl	53e0c106-9803-4a4e-a880-f36db64c1373
a2d05fee-fc49-459a-9a94-c06d874bcd9f	arrival area	зал прилета	фраза	Arrival area gets crowded	B1	audio/word_arrival_area_29a889cd.mp3	ərˈaɪvəl ˈɛriə	53e0c106-9803-4a4e-a880-f36db64c1373
697fe104-9e61-4e0d-bd3e-bf7844738a28	todays date	сегодняшняя дата	фраза	Todays date matches the booking	A1	audio/word_todays_date_76d1cf56.mp3	ˈtudeɪz deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
aff00bb1-2dfa-4b8e-b025-147163cd056f	month end	конец месяца	фраза	Financial reports due at month end	A2	audio/word_month_end_db6e1dbc.mp3	mənθ ɛnd	53e0c106-9803-4a4e-a880-f36db64c1373
21755ed7-d724-4004-a269-9b07e2ca8ce4	year end report	годовой отчет	noun	Year end report shows profits	B2	audio/word_year_end_4ff37c45.mp3	jɪr ɛnd rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
8629ac51-06b9-40de-905d-f60cea18a6a3	quarterly results	квартальные результаты	noun	Quarterly results beat forecasts	B2	audio/word_quarterly_results_1fede1b6.mp3	kˈwɔrtərli rɪˈzəlts	53e0c106-9803-4a4e-a880-f36db64c1373
1cb308d6-b019-4f4f-9d63-74a2456248cb	daily routine	ежедневный распорядок	фраза	Check daily routine before travel	A1	audio/word_daily_routine_3fe96296.mp3	ˈdeɪli ruˈtin	53e0c106-9803-4a4e-a880-f36db64c1373
9536e54c-2508-4993-aacb-2d34f36dfcd7	biannual visit	полугодовое посещение	фраза	Biannual visit to relatives	C1	audio/word_biannual_visit_a6c520c9.mp3	baɪˈænuəl ˈvɪzɪt	53e0c106-9803-4a4e-a880-f36db64c1373
91368d3f-ac09-46b4-88a9-e67c33b2f29b	overnight stay	ночка	фраза	Overnight stay before connecting flight	B1	audio/word_overnight_stay_9655581a.mp3	ˈoʊvərˈnaɪt steɪ	53e0c106-9803-4a4e-a880-f36db64c1373
9c89b78a-2428-42e8-8aa9-9cb742d18e40	same-day return	возвращение в тот же день	фраза	Same-day return flights cost more	B2	audio/word_same-day_return_8a8459da.mp3	same-day* rɪˈtərn	53e0c106-9803-4a4e-a880-f36db64c1373
1340dab8-9a50-46e2-8ec8-4fe3525517cb	weekly flight schedule	еженедельное расписание рейсов	фраза	Check weekly flight schedule online	A2	audio/word_weekly_flight_e41bc45b.mp3	ˈwikli flaɪt ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
6f77c871-135c-48c8-817e-2f793e5b68ed	date not available	дата недоступна	фраза	Date not available in booking system	B1	audio/word_date_not_82302f64.mp3	deɪt nɑt əˈveɪləbəl	53e0c106-9803-4a4e-a880-f36db64c1373
d029b666-2d2a-44ec-91dd-c59366631065	availability date	доступная дата	фраза	See availability date before booking	B2	audio/word_availability_date_a750065b.mp3	əˌveɪləˈbɪlɪti deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
92bcbe78-c633-42c2-9fc7-b2c5c3a5c39b	next available date	следующая доступная дата	фраза	Next available date is in three weeks	B2	audio/word_next_available_1019b45f.mp3	nɛkst əˈveɪləbəl deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
c76397ac-6e09-427b-b084-6bbfdb00328a	flight frequency	частота рейсов	noun	Flight frequency increases in summer	B2	audio/word_flight_frequency_66d59af0.mp3	flaɪt ˈfrikwənsi	53e0c106-9803-4a4e-a880-f36db64c1373
91d76fae-e47d-4c3a-8670-ef4de86eab27	daily flight	ежедневный рейс	фраза	Daily flight operates on this route	A1	audio/word_daily_flight_38ce891e.mp3	ˈdeɪli flaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
05c26d0b-fe8c-4976-a2b5-1fde6892db99	monthly calendar	месячный календарь	фраза	View monthly calendar of meetings	A1	audio/word_monthly_calendar_af6b019a.mp3	ˈmənθli ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
1c9d517b-4923-4a83-94cd-bcfa6992a5a3	annual leave period	срок отпуска	фраза	Annual leave period overlaps with holidays	B2	audio/word_annual_leave_c422aa19.mp3	ˈænjuəl liv ˈpɪriəd	53e0c106-9803-4a4e-a880-f36db64c1373
65f06742-c4f1-40a6-accc-842fdafdc7f1	twice weekly	дважды в неделю	фраза	Flight departs twice weekly	A2	audio/word_twice_weekly_b252b67e.mp3	twaɪs ˈwikli	53e0c106-9803-4a4e-a880-f36db64c1373
f795af22-21e5-4234-b17a-e26250cc42af	monthly budget	месячный бюджет	noun	Track monthly budget for travel	B1	audio/word_monthly_budget_ebbfc8ea.mp3	ˈmənθli ˈbəʤɪt	53e0c106-9803-4a4e-a880-f36db64c1373
00307926-124d-4dd2-bf72-d6b6b5269391	date format	формат даты	фраза	Enter date correctly in DD/MM format	A1	audio/word_date_format_0eebc5c9.mp3	deɪt ˈfɔrˌmæt	53e0c106-9803-4a4e-a880-f36db64c1373
82a9a53c-09c4-4e9c-a1d1-ada0b616e659	daily schedule	ежедневное расписание	фраза	Daily schedule includes airport runs	A1	audio/word_daily_schedule_de61409e.mp3	ˈdeɪli ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
11023aa9-dfc5-4c1a-9895-23e52ed8df08	date of travel	дата поездки	фраза	Date of travel cannot be changed	A1	audio/word_date_of_c7888c43.mp3	deɪt əv ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
a19b578a-7bda-423b-9dfa-296bc9034417	arrival time slot	слот времени прибытия	фраза	Arrival time slot is allocated to you	A1	audio/word_arrival_time_67ac6020.mp3	ərˈaɪvəl taɪm slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
a2e91e65-3fb8-4dc2-8696-218813ab1429	flight duration	продолжительность полета	noun	Flight duration is 8 hours	B1	audio/word_flight_duration_abb9a7de.mp3	flaɪt ˈdʊˈreɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
dddeac3a-6e07-4826-a96d-f229d3461643	departure date flexibility	гибкость даты вылета	фраза	Departure date flexibility saves money	B2	audio/word_departure_date_b11bc731.mp3	dɪˈpɑrʧər deɪt ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
80cbf1aa-d910-461d-822a-a42592e9eb61	travel dates plural	даты поездки	фраза	Enter all travel dates	A2	audio/word_travel_dates_a92db1c3.mp3	ˈtrævəl deɪts ˈplʊrəl	53e0c106-9803-4a4e-a880-f36db64c1373
0c87dbb9-2e8a-4ca1-a031-875a0cd96903	seasonal discounts	сезонные скидки	фраза	Seasonal discounts apply in autumn	B1	audio/word_seasonal_discounts_f6063032.mp3	ˈsizənəl ˈdɪˌskaʊnts	53e0c106-9803-4a4e-a880-f36db64c1373
a68f4815-2767-48f6-b608-13fe00f0adff	next available date slot	следующий доступный слот	фраза	Next available date slot is November	B2	audio/word_next_available_a734115d.mp3	nɛkst əˈveɪləbəl deɪt slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
3024193b-282a-4d6d-a25b-3817ad2d3a35	daily flight schedule	ежедневное расписание полетов	фраза	Daily flight schedule shows all departures	A1	audio/word_daily_flight_a591a135.mp3	ˈdeɪli flaɪt ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
6466dee1-a1d8-4862-9587-93b60ea7001b	biannual review	полугодовой обзор	фраза	Biannual review of expenses	C1	audio/word_biannual_review_857d7107.mp3	baɪˈænuəl ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
c0f31543-b0ab-4ef2-b748-d920e7a4c99c	date of entry	дата въезда	фраза	Date of entry on the visa	A1	audio/word_date_of_9aad75e8.mp3	deɪt əv ˈɛntri	53e0c106-9803-4a4e-a880-f36db64c1373
4e8f8f79-e0b7-4577-b6fc-f5297089c859	year	год	noun	Which year is your booking for?	A1	audio/word_year_c5426060.mp3	jɪr	53e0c106-9803-4a4e-a880-f36db64c1373
75eb3938-21cf-4e2d-98b9-82b179c58e86	quarterly planning session	квартальное планирование	фраза	Quarterly planning session set for July	B2	audio/word_quarterly_planning_7567850a.mp3	kˈwɔrtərli ˈplænɪŋ ˈsɛʃən	53e0c106-9803-4a4e-a880-f36db64c1373
2ed0691e-983a-4196-b853-c7863f1ff576	monthly target	ежемесячная цель	noun	Monthly target for sales reached	A2	audio/word_monthly_target_ceb752d8.mp3	ˈmənθli ˈtərgət	53e0c106-9803-4a4e-a880-f36db64c1373
600f8498-567a-4f70-bcff-b98ba8970895	departure gate	выход на посадку	noun	Departure gate is B42	A1	audio/word_departure_gate_621504c1.mp3	dɪˈpɑrʧər geɪt	53e0c106-9803-4a4e-a880-f36db64c1373
db3bd4e3-b7fb-46a1-abb4-a6fd1682db42	arrival lounge	зал прибытия	noun	Arrival lounge is spacious	B1	audio/word_arrival_lounge_a7d452fe.mp3	ərˈaɪvəl laʊnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
6eeaa15e-c8e7-432d-9ba6-9318775bcd9d	month of travel	месяц поездки	фраза	Month of travel affects prices	A1	audio/word_month_of_30170b2b.mp3	mənθ əv ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
28861282-5bec-475f-931a-017935a1c880	yearly event	годовое событие	фраза	Yearly event brings tourists	B1	audio/word_yearly_event_03380503.mp3	ˈjɪrli ɪˈvɛnt	53e0c106-9803-4a4e-a880-f36db64c1373
198c9649-8040-4d26-b52f-a2d370a50d99	daylight hours	световой день	noun	Daylight hours vary seasonally	B2	audio/word_daylight_hours_04522317.mp3	ˈdeɪˌlaɪt aʊərz	53e0c106-9803-4a4e-a880-f36db64c1373
55fd66a3-d7e0-4d22-b263-9f7211508453	date stamped	отштампованная	прилагательное	Date stamped ticket is valid	A2	audio/word_date_stamped_f0f66b0d.mp3	deɪt stæmpt	53e0c106-9803-4a4e-a880-f36db64c1373
a9600f5f-3173-476b-98a6-a4647b763b1c	flight calendar	авиакалендарь	noun	Check flight calendar for cheap deals	B2	audio/word_flight_calendar_3477fcd9.mp3	flaɪt ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
91558762-f04e-40f1-948f-a1e63064db32	peak season	пик сезона	фраза	Peak season costs more money	A1	audio/word_peak_season_f7f4899b.mp3	pik ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
0a9272ff-0963-468a-8f8f-041159940d5c	off-peak travel	поездка вне пика	фраза	Off-peak travel offers savings	B1	audio/word_off-peak_travel_a1e24aad.mp3	off-peak* ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
0a73a907-7ffc-4dce-b096-590c351c4d69	annual limit	годовой лимит	noun	Annual limit for foreign travel exceeded	B2	audio/word_annual_limit_78d9a305.mp3	ˈænjuəl ˈlɪmət	53e0c106-9803-4a4e-a880-f36db64c1373
1337906c-2992-4d2d-add5-b4f6e434fc48	quarterly performance	квартальная производительность	noun	Quarterly performance exceeded targets	B2	audio/word_quarterly_performance_6af59953.mp3	kˈwɔrtərli pərˈfɔrməns	53e0c106-9803-4a4e-a880-f36db64c1373
5c88dae2-77ad-4a66-a502-3ac8d37ed1dc	weekly summary	еженедельный отчет	noun	Weekly summary shows travel expenses	A2	audio/word_weekly_summary_5d385bf7.mp3	ˈwikli ˈsəməri	53e0c106-9803-4a4e-a880-f36db64c1373
9409a6f3-85a5-428d-a32d-719aa11d7ed2	next available month	следующий доступный месяц	фраза	Next available month is March	B2	audio/word_next_available_293da30c.mp3	nɛkst əˈveɪləbəl mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
2a1f1656-7aae-46ca-8130-8287ffc2dda9	daily flights plural	ежедневные рейсы	фраза	Daily flights connect major cities	A1	audio/word_daily_flights_0722d81c.mp3	ˈdeɪli flaɪts ˈplʊrəl	53e0c106-9803-4a4e-a880-f36db64c1373
06735eaa-d9ad-41f2-a082-eba74193fe09	travel month information	информация о месяце поездки	фраза	Travel month information is online	B1	audio/word_travel_month_0c5afa4f.mp3	ˈtrævəl mənθ ˌɪnˌfɔrˈmeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
34aef930-d215-4621-a96c-fa697d314782	yearly meeting	годовое собрание	noun	Yearly meeting is in November	A1	audio/word_yearly_meeting_c003a55e.mp3	ˈjɪrli ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
d71c5824-e437-4ec2-980c-d6c339cca786	bimonthly visit	раз в два месяца	фраза	Bimonthly visit to the branch	B2	audio/word_bimonthly_visit_9d233e5c.mp3	baɪˈmənθli ˈvɪzɪt	53e0c106-9803-4a4e-a880-f36db64c1373
da6c5f8d-78b9-417f-838d-f3f30e5030e0	date of issue	дата выдачи	фраза	Date of issue shown on ticket	A1	audio/word_date_of_b101743c.mp3	deɪt əv ˈɪʃu	53e0c106-9803-4a4e-a880-f36db64c1373
a74929f2-bec6-4f83-b586-4f6def73421d	monthly targets met	ежемесячные цели выполнены	фраза	Monthly targets met consistently	A2	audio/word_monthly_targets_ec199b4b.mp3	ˈmənθli ˈtɑrgəts mɛt	53e0c106-9803-4a4e-a880-f36db64c1373
d28ede57-1809-4b72-839e-d81c071eedbf	overnight flight	ночной рейс	фраза	Overnight flight to New York	B1	audio/word_overnight_flight_e3233ac6.mp3	ˈoʊvərˈnaɪt flaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
fc84ffc8-7c7e-429f-8b75-b064dd6de1d2	date validation check	проверка валидности даты	фраза	Date validation check passed	A1	audio/word_date_validation_bae36432.mp3	deɪt ˌvæləˈdeɪʃən ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
4cc8ef18-d5a5-4a21-b0a6-f5b58c0f426a	flight path variation	изменение маршрута полета	фраза	Flight path variation saves fuel	B2	audio/word_flight_path_3bd761fb.mp3	flaɪt pæθ ˌvɛriˈeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
9ac2bbf5-ce4b-4458-ad03-2704c99bc568	booking date stamp	штамп даты бронирования	фраза	Booking date stamp confirms reservation	A1	audio/word_booking_date_607adfbf.mp3	ˈbʊkɪŋ deɪt stæmp	53e0c106-9803-4a4e-a880-f36db64c1373
4cfaa495-c7e2-48a6-abc2-bb7143ec976a	trip duration planner	планировщик длительности поездки	фраза	Trip duration planner estimates costs	B1	audio/word_trip_duration_167221bd.mp3	trɪp ˈdʊˈreɪʃən ˈplænər	53e0c106-9803-4a4e-a880-f36db64c1373
78d31366-9169-4621-aea4-a6cf67d189e9	quarterly financial report	квартальный финансовый отчет	noun	Quarterly financial report released	B2	audio/word_quarterly_financial_51449e6d.mp3	kˈwɔrtərli ˌfaɪˈnænʃəl rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
9740d3db-4247-40a5-85d6-fb171bb6304e	last minute travel	срочная поездка	фраза	Last minute travel deals available	A2	audio/word_last_minute_f7be2f6a.mp3	læst ˈmɪnət ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
68cc8bf2-7f76-4cfe-8d1a-c7440a095775	twice yearly event	событие дважды в год	фраза	Twice yearly event held in city center	B2	audio/word_twice_yearly_6cfedff3.mp3	twaɪs ˈjɪrli ɪˈvɛnt	53e0c106-9803-4a4e-a880-f36db64c1373
b9148d81-e591-467c-867b-66c8e3c8171e	date of passport issue	дата выдачи паспорта	фраза	Date of passport issue must be entered	A1	audio/word_date_of_0ff4acd0.mp3	deɪt əv ˈpæˌspɔrt ˈɪʃu	53e0c106-9803-4a4e-a880-f36db64c1373
43aeda69-1a78-4bfd-b689-5246ef7c30d7	seasonal trends	сезонные тенденции	фраза	Seasonal trends affect ticket prices	B1	audio/word_seasonal_trends_e3e86839.mp3	ˈsizənəl trɛnz	53e0c106-9803-4a4e-a880-f36db64c1373
7f3c85ea-7ce5-4874-9956-2f85a42adda6	weekly hotel rates	еженедельные отельные ставки	фраза	Weekly hotel rates lower than daily	A2	audio/word_weekly_hotel_82433e90.mp3	ˈwikli hoʊˈtɛl reɪts	53e0c106-9803-4a4e-a880-f36db64c1373
17c1d39b-6298-4501-b708-0cc1212a1dc1	monthly subscription	ежемесячная подписка	noun	Monthly subscription includes discounts	B2	audio/word_monthly_subscription_73ad3f2b.mp3	ˈmənθli səbˈskrɪpʃən	53e0c106-9803-4a4e-a880-f36db64c1373
73ad5a88-6e4e-418f-98b1-48c025e61226	annual membership fee	годовой членский взнос	noun	Annual membership fee waived first year	C2	audio/word_annual_membership_9d428ad4.mp3	ˈænjuəl ˈmɛmbərˌʃɪp fi	53e0c106-9803-4a4e-a880-f36db64c1373
cdb40e40-cc85-470f-9349-e650db30bd8a	seasonal menu	сезонное меню	фраза	Seasonal menu features local dishes	B1	audio/word_seasonal_menu_a2c6e4dc.mp3	ˈsizənəl ˈmɛnju	53e0c106-9803-4a4e-a880-f36db64c1373
59a4fcc5-ece4-4a5a-89e6-263d0677f747	departure lounge notification	уведомление в зале вылета	фраза	Departure lounge notification announced	A1	audio/word_departure_lounge_e8c7c17b.mp3	dɪˈpɑrʧər laʊnʤ ˌnoʊtəfəˈkeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
a6552443-e317-44bb-a381-ed98fdc9e2c9	arrival time flexibility	гибкость времени прибытия	фраза	Arrival time flexibility offered airline	B2	audio/word_arrival_time_5fc7c617.mp3	ərˈaɪvəl taɪm ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
2c0ce71c-5235-4032-b349-ae86437a6cd8	daily flight numbers	номера рейсов в день	фраза	Daily flight numbers listed online	A1	audio/word_daily_flight_c2f6a9e9.mp3	ˈdeɪli flaɪt ˈnəmbərz	53e0c106-9803-4a4e-a880-f36db64c1373
cbc2d502-2ace-4f57-8dc4-8a4f65413288	next day delivery	доставка на следующий день	фраза	Next day delivery for urgent tickets	A1	audio/word_next_day_2abcde98.mp3	nɛkst deɪ dɪˈlɪvəri	53e0c106-9803-4a4e-a880-f36db64c1373
e8e9a738-2b84-4feb-aa7d-5a306fe1a668	flight frequency monitoring	мониторинг частоты рейсов	noun	Flight frequency monitoring required	B2	audio/word_flight_frequency_6b3ab9ce.mp3	flaɪt ˈfrikwənsi ˈmɑnətərɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
bff428a3-d92a-4bc8-a076-af0ed6d93cef	travel date flexibility	гибкость даты поездки	фраза	Travel date flexibility saves costs	A2	audio/word_travel_date_68516f90.mp3	ˈtrævəl deɪt ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
9b5130ae-2077-4937-97f4-5ff8b4598e8e	flight path optimization	оптимизация маршрута полета	фраза	Flight path reduces flight duration	B2	audio/word_flight_path_86336b88.mp3	flaɪt pæθ ɑptɪmɪˈzeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
fee8a3ae-4ef8-4746-8511-20409d2dac17	arrival hall signage	указатели в зале прибытия	фраза	Arrival hall signage is multilingual	A2	audio/word_arrival_hall_1a9f2d0f.mp3	ərˈaɪvəl hɔl ˈsaɪnɪʤ	53e0c106-9803-4a4e-a880-f36db64c1373
761d470e-58c8-4435-9dcc-d1a8de204b49	monthly expense tracker	ежемесячный трекер расходов	noun	Monthly expense tracker app	B1	audio/word_monthly_expense_197aa743.mp3	ˈmənθli ɪkˈspɛns ˈtrækər	53e0c106-9803-4a4e-a880-f36db64c1373
f45b5be5-3a7a-432a-8810-6c5ada22bccb	semester break travel	поездка на каникулы	фраза	Semester break travel schedules	B2	audio/word_semester_break_9eb86118.mp3	səˈmɛstər breɪk ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
aee005d3-ba18-4e28-be0a-f2955a9840dc	year end sales	годовые распродажи	noun	Year end sales include travel deals	C1	audio/word_year_end_f9aed2a6.mp3	jɪr ɛnd seɪlz	53e0c106-9803-4a4e-a880-f36db64c1373
40f9a32c-a6b1-4a0a-b635-ea1d3d0bad22	annual budget meeting	годовая бюджетная встреча	фраза	Annual budget meeting scheduled	B2	audio/word_annual_budget_b1a03c9a.mp3	ˈænjuəl ˈbəʤɪt ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
6ae43588-137f-4a53-b75e-aba2f9e4d84c	date format specification	спецификация формата даты	фраза	Date format specification must be followed	A1	audio/word_date_format_fd8eb7d9.mp3	deɪt ˈfɔrˌmæt ˌspɛsɪfɪˈkeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
f3ef31dd-bbd8-441a-a30f-de953b066cf1	flight time table lookup	поиск в расписании рейсов	фраза	Flight time table lookup system	A1	audio/word_flight_time_e3190b62.mp3	flaɪt taɪm ˈteɪbəl ˈlʊkəp	53e0c106-9803-4a4e-a880-f36db64c1373
039cd757-689b-4325-acdc-15686c873ec8	arrival concierge service	служба встречи при прибытии	фраза	Arrival concierge service available	B1	audio/word_arrival_concierge_ba28af1e.mp3	ərˈaɪvəl ˌkɑnsiˈɛrʒ ˈsərvɪs	53e0c106-9803-4a4e-a880-f36db64c1373
5febf2f9-f296-4aaf-a7c9-4c38b113f4dd	next day itinerary	распорядок на следующий день	фраза	Next day itinerary arranged	B1	audio/word_next_day_d3f46f80.mp3	nɛkst deɪ aɪˈtɪnərˌɛri	53e0c106-9803-4a4e-a880-f36db64c1373
243eb985-6993-4579-a367-3d29402c85d4	flight path tracking	трекинг маршрута полета	noun	Flight path tracking shows delays	B2	audio/word_flight_path_7ac4b1e9.mp3	flaɪt pæθ ˈtrækɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
97d148e6-c1be-4783-9a38-ae517adfde03	bimonthly subscription	подписка раз в два месяца	noun	Bimonthly subscription for magazines	B2	audio/word_bimonthly_subscription_2c81b7d2.mp3	baɪˈmənθli səbˈskrɪpʃən	53e0c106-9803-4a4e-a880-f36db64c1373
b530c245-9609-4176-b45a-d66febf75b95	monthly performance review	ежемесячное обзорное собрание	noun	Monthly performance review conducted	B1	audio/word_monthly_performance_fcd2751c.mp3	ˈmənθli pərˈfɔrməns ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
6fce7e1b-343c-49bb-84b1-a0b19dfd8e02	date stamping machine	машина для штамповки даты	noun	Date stamping machine at check-in	A1	audio/word_date_stamping_89081c4b.mp3	deɪt ˈstæmpɪŋ məˈʃin	53e0c106-9803-4a4e-a880-f36db64c1373
862582d4-54be-4d5e-be21-ebf31a7ed38c	seasonal promotions	сезонные акции	фраза	Seasonal promotions on hotel rooms	B1	audio/word_seasonal_promotions_31799eca.mp3	ˈsizənəl pərˈmoʊʃənz	53e0c106-9803-4a4e-a880-f36db64c1373
9bf3f3e6-6e2e-45dc-b853-8d3db17e9149	arrival terminal guide	гид по терминалу прибытия	нвоg	Arrival terminal guide available	A1	audio/word_arrival_terminal_41efc8aa.mp3	ərˈaɪvəl ˈtərmənəl gaɪd	53e0c106-9803-4a4e-a880-f36db64c1373
5379528a-f70a-4554-b225-0899e849d2bf	flight schedule frequency	частота расписания рейсов	фраза	Flight schedule frequency explained	A2	audio/word_flight_schedule_c8826634.mp3	flaɪt ˈskɛʤʊl ˈfrikwənsi	53e0c106-9803-4a4e-a880-f36db64c1373
2efc2358-8fd3-4792-9de9-936780d9eb6f	daily departure schedule	ежедневное расписание вылетов	фраза	Daily departure schedule displayed	A1	audio/word_daily_departure_69c3cb83.mp3	ˈdeɪli dɪˈpɑrʧər ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
47a92f0e-610b-4242-821c-8750104b8562	quarterly business result	квартальный результат работы	фраза	Quarterly business result impressive	B1	audio/word_quarterly_business_440db8b7.mp3	kˈwɔrtərli ˈbɪznɪs rɪˈzəlt	53e0c106-9803-4a4e-a880-f36db64c1373
bb157aeb-8dfe-43bf-ae1e-a09a4d2bab1f	trip duration extension	продление длительности поездки	фраза	Trip duration extension possible	B1	audio/word_trip_duration_9e173f9d.mp3	trɪp ˈdʊˈreɪʃən ɪkˈstɛnʃən	53e0c106-9803-4a4e-a880-f36db64c1373
70bd81b9-0346-459c-9af1-3ee85e2b7910	date of entry requirements	требования к дате въезда	фраза	Date of entry visa requirements	A1	audio/word_date_of_32ba3612.mp3	deɪt əv ˈɛntri rɪkˈwaɪrmənts	53e0c106-9803-4a4e-a880-f36db64c1373
3a325205-225e-4b68-abf1-ed2bf5c4e72f	seasonal temperature variation	сезонное колебание температур	фраза	Seasonal temperature variation affects travel	B1	audio/word_seasonal_temperature_a7031934.mp3	ˈsizənəl ˈtɛmpərəʧər ˌvɛriˈeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
f8fbb759-c761-406c-8a3d-c52265762a5d	weekly chit chat meeting	еженедельная встреча по болтовне	noun	Weekly chit chat meeting scheduled	A2	audio/word_weekly_chit_99a1273d.mp3	ˈwikli ʧɪt ʧæt ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
7d921093-8d7b-4b04-bee7-0b57319dd49a	arrival baggage claim display	табло выдачи багажа прилетевших	noun	Arrival baggage claim display shows baggage	A1	audio/word_arrival_baggage_ab04346a.mp3	ərˈaɪvəl ˈbægɪʤ kleɪm dɪˈspleɪ	53e0c106-9803-4a4e-a880-f36db64c1373
863375ed-4d20-4ff4-9d0d-c4d412dfe443	monthly financial statement	ежемесячный финансовый отчет	noun	Monthly financial statement prepared	B1	audio/word_monthly_financial_44cd1a26.mp3	ˈmənθli ˌfaɪˈnænʃəl ˈsteɪtmənt	53e0c106-9803-4a4e-a880-f36db64c1373
d193299e-0d13-4cf5-ab8b-802563d67176	bimonthly training session	двухнедельный учебный сеанс	фраза	Bimonthly training session conducted	B2	audio/word_bimonthly_training_8b6edd5c.mp3	baɪˈmənθli ˈtreɪnɪŋ ˈsɛʃən	53e0c106-9803-4a4e-a880-f36db64c1373
5bde5585-7502-4b9d-a1cf-cacd61d50e26	date stamp validation	проверка штампа даты	фраза	Date stamp validation required	A2	audio/word_date_stamp_42d85ace.mp3	deɪt stæmp ˌvæləˈdeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
022a67e5-a83b-4516-9710-8ebd224f0d7f	flight path accuracy check	проверка точности маршрута полета	фраза	Flight path accuracy check performed	C1	audio/word_flight_path_0f7ce08b.mp3	flaɪt pæθ ˈækjərəsi ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
fa1ef7ff-f3e6-440f-bdb8-6bead9b2a59a	arrival door service counter	сервисный стойка у дверей прибытия	noun	Arrival door service counter helpful	B1	audio/word_arrival_door_3b10c30d.mp3	ərˈaɪvəl dɔr ˈsərvɪs ˈkaʊntər	53e0c106-9803-4a4e-a880-f36db64c1373
2106b32c-9767-4805-8a3d-34b76ca01902	next available boarding gate	следующий доступный выход на посадку	фраза	Next available boarding gate announced	A1	audio/word_next_available_6e81fd84.mp3	nɛkst əˈveɪləbəl ˈbɔrdɪŋ geɪt	53e0c106-9803-4a4e-a880-f36db64c1373
c9686011-ae72-4f5b-a52c-6bcb5aee7bf8	flight schedule planner	планировщик расписания рейсов	noun	Flight schedule planner recommended	A1	audio/word_flight_schedule_f8eb9e12.mp3	flaɪt ˈskɛʤʊl ˈplænər	53e0c106-9803-4a4e-a880-f36db64c1373
d9e994cd-ff0a-479a-8605-fcc71952881f	arrival instruction booklet	приемная инструкция	noun	Arrival instruction booklet provided	A2	audio/word_arrival_instruction_a09b7222.mp3	ərˈaɪvəl ˌɪnˈstrəkʃən ˈbʊklɪt	53e0c106-9803-4a4e-a880-f36db64c1373
6c95d10c-b205-4dc8-b745-ca89e50d34d4	date passport issued	дата выдачи паспорта	фраза	Date passport issued verified	A1	audio/word_date_passport_e5418a3b.mp3	deɪt ˈpæˌspɔrt ˈɪʃud	53e0c106-9803-4a4e-a880-f36db64c1373
fb0e0d39-af31-42af-80e9-72999936f39c	seasonal travel tip	сезонный совет по путешествиям	noun	Seasonal travel tip shared in blog	B2	audio/word_seasonal_travel_af100605.mp3	ˈsizənəl ˈtrævəl tɪp	53e0c106-9803-4a4e-a880-f36db64c1373
362677df-fb27-4d28-aa4e-32923f087c15	weekly team meeting	еженедельная встреча команды	noun	Weekly team meeting rescheduled	A1	audio/word_weekly_team_a06ead76.mp3	ˈwikli tim ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
7d77bb9d-07af-4da5-ba29-8cd4729cd1c0	flight path weather impact	влияние погоды на маршрут полета	фраза	Flight path weather impact assessed	B2	audio/word_flight_path_aa1798cf.mp3	flaɪt pæθ ˈwɛðər ˌɪmˈpækt	53e0c106-9803-4a4e-a880-f36db64c1373
9755ed17-1f02-401c-b00e-b045e98cea94	arrival assistance service	служба помощи при прибытии	noun	Arrival assistance service available	B1	audio/word_arrival_assistance_1e6f6193.mp3	ərˈaɪvəl əˈsɪstəns ˈsərvɪs	53e0c106-9803-4a4e-a880-f36db64c1373
0b5c6517-f12c-417e-b3f5-8dda8994813e	trip duration calculator	калькулятор длительности поездки	noun	Trip duration calculator reliable	A1	audio/word_trip_duration_e35a8ad4.mp3	trɪp ˈdʊˈreɪʃən ˈkælkjəˌleɪtər	53e0c106-9803-4a4e-a880-f36db64c1373
b73bda73-7888-4f27-a166-5f7945bff70b	quarterly bonus payment	квартальная выплата бонуса	фраза	Quarterly bonus payment processed	B1	audio/word_quarterly_bonus_792498c1.mp3	kˈwɔrtərli ˈboʊnəs ˈpeɪmənt	53e0c106-9803-4a4e-a880-f36db64c1373
622e491a-38a7-4455-b268-f9d388a95c3d	bimonthly performance review	двухнедельный пересмотр производительности	фраза	Bimonthly performance review scheduled	B2	audio/word_bimonthly_performance_323733f1.mp3	baɪˈmənθli pərˈfɔrməns ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
b9704973-482c-44c9-a278-55c7d43d447f	flight path reroute protocol	протокол перенаправления маршрута полета	noun	Flight path reroute protocol activated	C1	audio/word_flight_path_fe75694a.mp3	flaɪt pæθ riˈrut ˈproʊtəˌkɔl	53e0c106-9803-4a4e-a880-f36db64c1373
fcf2331a-3214-47aa-b292-4dfeb63cd6d7	travel date flexibility fee	плата за гибкость даты поездки	фраза	Travel date flexibility fee waived	B2	audio/word_travel_date_0e167383.mp3	ˈtrævəl deɪt ˌflɛksəˈbɪləti fi	53e0c106-9803-4a4e-a880-f36db64c1373
ab56adb7-df18-4dd9-aa4f-7cf215fadb2e	seasonal cargo schedule	сезонное расписание грузов	noun	Seasonal cargo schedule adjusted	B2	audio/word_seasonal_cargo_922ebc93.mp3	ˈsizənəl ˈkɑrˌgoʊ ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
a00cbd4a-c35a-492b-8131-26573dc58124	weekly backup system check	еженедельная проверка резервной системы	noun	Weekly backup system check completed	A2	audio/word_weekly_backup_3abe0c95.mp3	ˈwikli ˈbæˌkəp ˈsɪstəm ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
7f52736c-832d-409c-b57c-b334387ca915	bimonthly security drill	двухнедельная проверка безопасности	фраза	Bimonthly security drill conducted	B2	audio/word_bimonthly_security_6a8ac708.mp3	baɪˈmənθli sɪˈkjʊrəti drɪl	53e0c106-9803-4a4e-a880-f36db64c1373
edad1152-c894-4949-871f-638f1cb80fda	flight path optimization cost	стоимость оптимизации маршрута полета	фраза	Flight path optimization cost calculated	C1	audio/word_flight_path_b980ae9c.mp3	flaɪt pæθ ɑptɪmɪˈzeɪʃən kɔst	53e0c106-9803-4a4e-a880-f36db64c1373
93f2a32d-f073-48a0-9873-317ab0e8e7ba	date format conversion tool	инструмент преобразования формата даты	noun	Date format conversion tool helpful	A1	audio/word_date_format_ba2ca9e0.mp3	deɪt ˈfɔrˌmæt kənˈvərʒən tul	53e0c106-9803-4a4e-a880-f36db64c1373
0a1f4fcc-498d-422a-9ddd-ebd96325079f	seasonal staffing plan	сезонный план персонала	фраза	Seasonal staffing plan implemented	B1	audio/word_seasonal_staffing_a014f63e.mp3	ˈsizənəl ˈstæfɪŋ plæn	53e0c106-9803-4a4e-a880-f36db64c1373
40dd8d51-05fd-440f-81c6-43e0e843f5da	arrival procedure manual	приемная инструкция	noun	Arrival procedure manual updated	B2	audio/word_arrival_procedure_36a0802b.mp3	ərˈaɪvəl prəˈsiʤər ˈmænjuəl	53e0c106-9803-4a4e-a880-f36db64c1373
d4ea0b29-5bc4-4f88-82d1-2283b55d4636	date passport validation rule	правило проверки паспорта даты	фраза	Date passport validation rule enforced	A1	audio/word_date_passport_412ac692.mp3	deɪt ˈpæˌspɔrt ˌvæləˈdeɪʃən rul	53e0c106-9803-4a4e-a880-f36db64c1373
b6a86f71-3353-45be-97b9-afd47f3e1617	flight schedule disruption log	журнал сбоев расписания рейсов	noun	Flight schedule disruption log maintained	B1	audio/word_flight_schedule_423b10dc.mp3	flaɪt ˈskɛʤʊl dɪsˈrəpʃən lɔg	53e0c106-9803-4a4e-a880-f36db64c1373
16b21f6e-27ab-4850-aea2-57300abc7e9d	month	месяц	noun	Which month does your holiday fall in?	A1	audio/word_month_eef7bfc1.mp3	mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
b2efe8c8-b447-47f9-9bcf-5d8008f3ad73	date	дата	noun	Could you confirm the travel date?	A1	audio/word_date_3a964b28.mp3	deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
05b4fb47-6a12-4213-b2d4-33d46a3328e6	today	сегодня	adverb	Today is the departure day	A1	audio/word_today_678a5a40.mp3	təˈdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
0fa7595c-4cef-4ce9-a782-53c4bdf4eea6	tomorrow	завтра	adverb	The flight departs tomorrow	A1	audio/word_tomorrow_4b4f9e9e.mp3	təˈmɑˌroʊ	53e0c106-9803-4a4e-a880-f36db64c1373
866847a2-8949-4216-861f-11a35dcd82a3	yesterday	вчера	adverb	Arrived yesterday	A1	audio/word_yesterday_279e1b49.mp3	ˈjɛstərˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
60c0415f-d59a-4d75-a278-db4dbe7634cf	weekday	будний день	noun	Weekday fares are cheaper	B1	audio/word_weekday_5ee1010e.mp3	ˈwikˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
ee834b94-7711-4185-b6f7-8c3a219836af	calendar	календарь	noun	Check the calendar for free dates	A2	audio/word_calendar_a4232587.mp3	ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
c8c01cee-1ffb-4a68-9eb9-35d6b530c2e2	schedule	расписание	noun	The flight schedule is online	B1	audio/word_schedule_201c7e85.mp3	ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
da35778a-eda2-4f61-88c0-0401210e894f	season	сезон	noun	Off-season travel is budget-friendly	A2	audio/word_season_af2404c7.mp3	ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
d6ac6be2-c27f-4496-a2c1-ecf4f24a18e6	in advance	заранее	наречие	Book the ticket in advance	B1	audio/word_in_advance_80717346.mp3	ɪn ədˈvæns	53e0c106-9803-4a4e-a880-f36db64c1373
134f783e-8662-4d8c-86dc-c9b153110141	public holiday	государственный праздник	noun	Holidays affect flight prices	B1	audio/word_public_holiday_6eb5512d.mp3	ˈpəblɪk ˈhɑlɪˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
e72a0d57-ac8f-4dcf-8382-c46416ec969d	check the date	проверить дату	глагол	Always check the date on your ticket	A2	audio/word_check_the_ff71d414.mp3	ʧɛk ðə deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
b2cb74f5-1173-4371-bb63-fd26c0bda30a	what's the date?	какая сегодня дата?	фраза	Excuse me, what's the date today?	A1	audio/word_what's_the_b0b4b52f.mp3	wəts ðə deɪt?	53e0c106-9803-4a4e-a880-f36db64c1373
cb5b7559-d06b-4620-9b82-4b4e937e1d3a	month of the year	месяц года	фраза	January is the first month of the year	A1	audio/word_month_of_b1c0995e.mp3	mənθ əv ðə jɪr	53e0c106-9803-4a4e-a880-f36db64c1373
d420519f-a38a-4f8a-9374-830fd876033c	day of the week	день недели	фраза	What day of the week is the check-in?	A1	audio/word_day_of_ec2aaf48.mp3	deɪ əv ðə wik	53e0c106-9803-4a4e-a880-f36db64c1373
a944083a-481b-4b01-9a30-9e184f18fa57	birth date	дата рождения	noun	You must enter your birth date	A1	audio/word_birth_date_f25d55dd.mp3	bərθ deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
2c7373c8-9276-4e33-82a5-59eb824068a4	this week	на этой неделе	фраза	I'll fly this week	A1	audio/word_this_week_dc2a34c7.mp3	ðɪs wik	53e0c106-9803-4a4e-a880-f36db64c1373
2f0d52cc-1fc4-4aa2-bc68-aa29074c1bcf	next week	на следующей неделе	фраза	Meeting schedules move to next week	A1	audio/word_next_week_91569ff0.mp3	nɛkst wik	53e0c106-9803-4a4e-a880-f36db64c1373
0bd96d43-9a33-49fa-b1f9-858d9d23ac6b	last week	на прошлой неделе	фраза	Booked tickets last week	A1	audio/word_last_week_591a64b1.mp3	læst wik	53e0c106-9803-4a4e-a880-f36db64c1373
2ce47d65-91a5-4e64-ae9b-992089cb6f1b	time zone	часовой пояс	noun	Adjust for different time zones	B1	audio/word_time_zone_960b05dd.mp3	taɪm zoʊn	53e0c106-9803-4a4e-a880-f36db64c1373
dbf87cc7-3c73-4cc8-adb7-cf34a83aa331	midnight	полночь	noun	Departure at midnight meets the schedule	A1	audio/word_midnight_7237ddff.mp3	ˈmɪdˌnaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
46cc6e62-1362-44bd-8fc6-4b43f8407662	noon	полдень	noun	Arrival at noon is convenient	A1	audio/word_noon_a2fd9264.mp3	nun	53e0c106-9803-4a4e-a880-f36db64c1373
8157ebf9-1abd-48b9-973c-4c5506876f8b	from...to...	с...по...	предлог	Trip from June to July	A1	audio/word_from...to..._d4ab8461.mp3	from...to*...	53e0c106-9803-4a4e-a880-f36db64c1373
8ada5e44-b410-4b60-8e73-591733f9c100	date of birth	дата рождения	фраза	Enter your date of birth please	A1	audio/word_date_of_91439617.mp3	deɪt əv bərθ	53e0c106-9803-4a4e-a880-f36db64c1373
e67f6ac2-f52a-4885-9fbc-e6b35d34e538	timetable	расписание	noun	Check the bus timetable	A1	audio/word_timetable_fd334764.mp3	ˈtaɪmˌteɪbəl	53e0c106-9803-4a4e-a880-f36db64c1373
bb1cdfa0-522d-4053-82e5-1f035a3d1779	last month	в прошлом месяце	фраза	Travel costs increased last month	B1	audio/word_last_month_0689cdbd.mp3	læst mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
d4a13529-f753-42d3-af67-538af562015d	next month	в следующем месяце	фраза	Will finalize plans next month	B1	audio/word_next_month_7761b9f3.mp3	nɛkst mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
30d0a593-5f4c-4b58-bdbb-e2f3db4af61a	quarter	квартал	noun	Earnings fell in the third quarter	B2	audio/word_quarter_30ce346d.mp3	kˈwɔrtər	53e0c106-9803-4a4e-a880-f36db64c1373
08cdba2a-3821-4aa8-8401-522184936192	fortnight	две недели	noun	I'll stay for a fortnight	B2	audio/word_fortnight_781aa73b.mp3	ˈfɔrtˌnaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
9b1efda5-c418-4510-9965-0dd47c5b5230	annual expenditure	годовые расходы	фраза	Track annual expenditure	B2	audio/word_annual_expenditure_9d3718c5.mp3	ˈænjuəl ɪkˈspɛndɪʧər	53e0c106-9803-4a4e-a880-f36db64c1373
368f27a1-44e2-4928-8033-173277efd123	booking window	окно бронирования	фраза	Best booking window opens soon	B2	audio/word_booking_window_d122b713.mp3	ˈbʊkɪŋ ˈwɪndoʊ	53e0c106-9803-4a4e-a880-f36db64c1373
f76b0391-7206-445f-9d89-f5b18b4c7d22	high season	высокий сезон	фраза	High season prices are steep	B1	audio/word_high_season_76be5d18.mp3	haɪ ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
27805ae1-0571-499e-8c83-cecd4cb0ea7c	low season	низкий сезон	фраза	Low season discounts are available	B1	audio/word_low_season_da895bd2.mp3	loʊ ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
3a0d7097-a868-42a7-bee9-d7f5712cd38c	weekdays off	выходные в будние дни	фраза	Scheduling week days off is rare	B1	audio/word_weekdays_off_f2129f2a.mp3	ˈwikˌdeɪz ɔf	53e0c106-9803-4a4e-a880-f36db64c1373
82379bf3-646e-4ddf-87be-f4b911af4de3	planned arrival	планируемый прилет	фраза	Planned arrival matches the schedule	B1	audio/word_planned_arrival_b38bb703.mp3	plænd ərˈaɪvəl	53e0c106-9803-4a4e-a880-f36db64c1373
ea427cdd-f1ab-4973-9f21-d8612d382667	time slot	временной слот	фраза	Select your preferred time slot	B1	audio/word_time_slot_ab1e73e8.mp3	taɪm slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
81f53fc0-445c-4ada-8706-1d0fcad936a2	date range	диапазон дат	фраза	Enter the date range results	B2	audio/word_date_range_7636e935.mp3	deɪt reɪnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
a873eb49-f127-4460-bf5f-fe6eca0423b9	day trip	однодневная поездка	фраза	Day trips during holidays	B1	audio/word_day_trip_4bb12fac.mp3	deɪ trɪp	53e0c106-9803-4a4e-a880-f36db64c1373
ce129a69-0961-4a1c-8d57-e697fb31e7ff	monthly pass	ежемесячный проездной	noun	Buy a monthly pass for commutes	B2	audio/word_monthly_pass_9a2bbeca.mp3	ˈmənθli pæs	53e0c106-9803-4a4e-a880-f36db64c1373
9a611b7f-6e4e-48c2-bd85-17326ca4a83f	annual report	годовой отчет	noun	Fiscal year closed in the annual report	C1	audio/word_annual_report_99f3e00f.mp3	ˈænjuəl rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
71fa3c2e-a8e2-48dc-ac11-99413280de0d	seasonal ticket	сезонный билет	noun	Seasonal ticket offers savings	B1	audio/word_seasonal_ticket_36c1e4eb.mp3	ˈsizənəl ˈtɪkɪt	53e0c106-9803-4a4e-a880-f36db64c1373
c11a11dd-d5c9-4242-aa57-e1f87f5197aa	daylight saving time	летнее время	фраза	Change clocks during daylight saving time	B1	audio/word_daylight_saving_438ff2ca.mp3	ˈdeɪˌlaɪt ˈseɪvɪŋ taɪm	53e0c106-9803-4a4e-a880-f36db64c1373
94acfeb7-e214-4de6-a66c-a03cb04f0e08	flight path	маршрут полета	noun	Check flight path on maps	B2	audio/word_flight_path_7b0f0fd1.mp3	flaɪt pæθ	53e0c106-9803-4a4e-a880-f36db64c1373
31b19895-3577-45f6-8bb9-bd06d07ad00c	arrival date change	изменение даты прибытия	фраза	Arrival date change fee applies	A2	audio/word_arrival_date_85e3074e.mp3	ərˈaɪvəl deɪt ʧeɪnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
a6bfc260-f30c-4e8f-b572-f684aa1a3486	departure time	время вылета	фраза	Departure time is noted in the ticket	A1	audio/word_departure_time_114d55da.mp3	dɪˈpɑrʧər taɪm	53e0c106-9803-4a4e-a880-f36db64c1373
6cd734eb-8e23-4d17-b5d1-e66f745ee2fd	date validation	проверка даты	фраза	Date validation shows no conflicts	A2	audio/word_date_validation_a958a164.mp3	deɪt ˌvæləˈdeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
16b5f876-cc49-4f1e-978c-f742361cfe76	travel date selection	выбор даты поездки	фраза	Travel date selection affects price	B1	audio/word_travel_date_d07c9efe.mp3	ˈtrævəl deɪt səˈlɛkʃən	53e0c106-9803-4a4e-a880-f36db64c1373
91af51cc-0bf2-4bb9-b0c5-b2f186c65cb2	booking confirmation	подтверждение бронирования	фраза	Booking confirmation has the date	A1	audio/word_booking_confirmation_a6e07dcd.mp3	ˈbʊkɪŋ ˌkɑnfərˈmeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
35a65bca-251e-411b-a1fe-bfc227a8e4b8	weekend getaway	выходные поездка	фраза	Plan a weekend getaway	B1	audio/word_weekend_getaway_fa6f5be7.mp3	ˈwiˌkɪnd ˈgɛtəˌweɪ	53e0c106-9803-4a4e-a880-f36db64c1373
b719ae24-59e1-43be-a961-45b8b2e4e9a0	trip duration	длительность поездки	фраза	Trip duration is two weeks	B1	audio/word_trip_duration_b2349e7b.mp3	trɪp ˈdʊˈreɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
f6482bcc-72e1-4f31-8e6e-ba291694c606	last day off	последний выходной	фраза	Last day off before vacation	B1	audio/word_last_day_06284bd3.mp3	læst deɪ ɔf	53e0c106-9803-4a4e-a880-f36db64c1373
8f8f9940-925a-4f62-a76d-e42fd04e47dc	next Monday	в понедельник	фраза	Meeting scheduled for next Monday	A1	audio/word_next_monday_f34f1f77.mp3	nɛkst ˈmənˌdeɪ	53e0c106-9803-4a4e-a880-f36db64c1373
56feb4e4-87dc-4b86-b7ce-5c99d29fd490	clocks go forward	часы переводят вперед	фраза	Clocks go forward in spring	C1	audio/word_clocks_go_c028e010.mp3	klɑks goʊ ˈfɔrwərd	53e0c106-9803-4a4e-a880-f36db64c1373
7faaffe3-e885-449c-b31b-e3ff050c6610	clocks go back	часы переводят назад	фраза	Clocks go back in autumn	C1	audio/word_clocks_go_58bec9f1.mp3	klɑks goʊ bæk	53e0c106-9803-4a4e-a880-f36db64c1373
14411510-9bbe-455b-993c-ac3f206be0e5	monthly limit	месячный лимит	фраза	Stay within the monthly limit	B2	audio/word_monthly_limit_187923a2.mp3	ˈmənθli ˈlɪmət	53e0c106-9803-4a4e-a880-f36db64c1373
c027d058-36a0-4bff-b20e-0eea134ecd98	annual festival	годовой фестиваль	фраза	Annual festival draws crowds	B2	audio/word_annual_festival_bf10f2ee.mp3	ˈænjuəl ˈfɛstɪvəl	53e0c106-9803-4a4e-a880-f36db64c1373
dae49813-8564-4ce1-8c7a-3af570a9db2d	date of expiry	дата истечения	фраза	Check date of expiry on card	A1	audio/word_date_of_a28468ae.mp3	deɪt əv ˌɛkˈspaɪri	53e0c106-9803-4a4e-a880-f36db64c1373
339b40b5-f8c0-45c7-b2cb-0c38cdaf084d	travel period	период поездки	фраза	Travel period coincides with holidays	B1	audio/word_travel_period_80411dbb.mp3	ˈtrævəl ˈpɪriəd	53e0c106-9803-4a4e-a880-f36db64c1373
56b52b90-ef12-4519-9544-0f4bcbd68505	departure hall	вылет	фраза	Departure hall opens two hours early	A1	audio/word_departure_hall_c1440442.mp3	dɪˈpɑrʧər hɔl	53e0c106-9803-4a4e-a880-f36db64c1373
24925e2a-fec4-44c1-b420-0a51d2e12d95	arrival area	зал прилета	фраза	Arrival area gets crowded	B1	audio/word_arrival_area_8da4ea01.mp3	ərˈaɪvəl ˈɛriə	53e0c106-9803-4a4e-a880-f36db64c1373
0c5b2874-a1b8-4766-a53a-ce037fb48462	todays date	сегодняшняя дата	фраза	Todays date matches the booking	A1	audio/word_todays_date_8dfa5be0.mp3	ˈtudeɪz deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
3bce3c85-4f00-41b3-92bb-c65bf95c2a23	month end	конец месяца	фраза	Financial reports due at month end	A2	audio/word_month_end_133df118.mp3	mənθ ɛnd	53e0c106-9803-4a4e-a880-f36db64c1373
51dc9f9c-21d6-4073-82a2-1c6e3e692577	year end report	годовой отчет	noun	Year end report shows profits	B2	audio/word_year_end_d2553fa1.mp3	jɪr ɛnd rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
af48d976-33ff-4b59-b946-9cea57d1e890	quarterly results	квартальные результаты	noun	Quarterly results beat forecasts	B2	audio/word_quarterly_results_e27a946d.mp3	kˈwɔrtərli rɪˈzəlts	53e0c106-9803-4a4e-a880-f36db64c1373
4f616fbd-e7ff-43df-a66d-3e35fde5676a	daily routine	ежедневный распорядок	фраза	Check daily routine before travel	A1	audio/word_daily_routine_0fd55271.mp3	ˈdeɪli ruˈtin	53e0c106-9803-4a4e-a880-f36db64c1373
ccb537df-87ec-448d-81c1-fd16ca67d177	biannual visit	полугодовое посещение	фраза	Biannual visit to relatives	C1	audio/word_biannual_visit_305bf04c.mp3	baɪˈænuəl ˈvɪzɪt	53e0c106-9803-4a4e-a880-f36db64c1373
5ed5da1f-8ec5-4a6b-81bd-dd9ec87ef3b8	overnight stay	ночка	фраза	Overnight stay before connecting flight	B1	audio/word_overnight_stay_da5effaa.mp3	ˈoʊvərˈnaɪt steɪ	53e0c106-9803-4a4e-a880-f36db64c1373
c96edc36-57c0-45e3-86d7-fb5e7545b6e3	same-day return	возвращение в тот же день	фраза	Same-day return flights cost more	B2	audio/word_same-day_return_a85c26d9.mp3	same-day* rɪˈtərn	53e0c106-9803-4a4e-a880-f36db64c1373
c103e03d-56cf-44b1-9869-bc903d89e9c3	weekly flight schedule	еженедельное расписание рейсов	фраза	Check weekly flight schedule online	A2	audio/word_weekly_flight_2c0bec47.mp3	ˈwikli flaɪt ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
f89ba8c2-e9ac-4c4b-b844-a94fd2d98b18	date not available	дата недоступна	фраза	Date not available in booking system	B1	audio/word_date_not_b72eaaa2.mp3	deɪt nɑt əˈveɪləbəl	53e0c106-9803-4a4e-a880-f36db64c1373
a7cb33b2-9c2b-4a37-b0bd-b5e06be7dabc	availability date	доступная дата	фраза	See availability date before booking	B2	audio/word_availability_date_ddc09a4f.mp3	əˌveɪləˈbɪlɪti deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
88dff52b-5ef6-4aed-b95a-6436f110e999	next available date	следующая доступная дата	фраза	Next available date is in three weeks	B2	audio/word_next_available_fa3e15bc.mp3	nɛkst əˈveɪləbəl deɪt	53e0c106-9803-4a4e-a880-f36db64c1373
c11423df-0e91-42ad-89fe-90cc9ed3da6b	flight frequency	частота рейсов	noun	Flight frequency increases in summer	B2	audio/word_flight_frequency_e6daf152.mp3	flaɪt ˈfrikwənsi	53e0c106-9803-4a4e-a880-f36db64c1373
121869d4-41e3-4b7f-ab09-49c7992694c3	daily flight	ежедневный рейс	фраза	Daily flight operates on this route	A1	audio/word_daily_flight_9e54bf30.mp3	ˈdeɪli flaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
1268f797-b8b9-4a55-ae52-7dfba33b16a2	monthly calendar	месячный календарь	фраза	View monthly calendar of meetings	A1	audio/word_monthly_calendar_3668c50e.mp3	ˈmənθli ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
2a9ac0ee-e2cf-47e8-9159-f3c8d0f63190	annual leave period	срок отпуска	фраза	Annual leave period overlaps with holidays	B2	audio/word_annual_leave_12338a29.mp3	ˈænjuəl liv ˈpɪriəd	53e0c106-9803-4a4e-a880-f36db64c1373
e115e4bd-9dbf-450c-95f2-45a77c6e3717	twice weekly	дважды в неделю	фраза	Flight departs twice weekly	A2	audio/word_twice_weekly_058d0b47.mp3	twaɪs ˈwikli	53e0c106-9803-4a4e-a880-f36db64c1373
50bf0b0c-a440-4b34-b56e-7641be977910	monthly budget	месячный бюджет	noun	Track monthly budget for travel	B1	audio/word_monthly_budget_1970a8c2.mp3	ˈmənθli ˈbəʤɪt	53e0c106-9803-4a4e-a880-f36db64c1373
ae1ab1fe-5181-42cd-8858-a77169bdc60a	date format	формат даты	фраза	Enter date correctly in DD/MM format	A1	audio/word_date_format_38980225.mp3	deɪt ˈfɔrˌmæt	53e0c106-9803-4a4e-a880-f36db64c1373
21e25937-89a9-418c-a284-f42b816124ad	daily schedule	ежедневное расписание	фраза	Daily schedule includes airport runs	A1	audio/word_daily_schedule_a2087b87.mp3	ˈdeɪli ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
16c40242-33bf-4c3d-b1d6-62add1c71141	date of travel	дата поездки	фраза	Date of travel cannot be changed	A1	audio/word_date_of_129fd417.mp3	deɪt əv ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
5517678b-51e9-4bca-ab25-2916c2221f48	arrival time slot	слот времени прибытия	фраза	Arrival time slot is allocated to you	A1	audio/word_arrival_time_1ef7be37.mp3	ərˈaɪvəl taɪm slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
da774073-401c-4cfd-af2e-66af851ca55e	flight duration	продолжительность полета	noun	Flight duration is 8 hours	B1	audio/word_flight_duration_83247e4f.mp3	flaɪt ˈdʊˈreɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
40769d5c-156f-45fd-8337-16bd4aa45c71	departure date flexibility	гибкость даты вылета	фраза	Departure date flexibility saves money	B2	audio/word_departure_date_100c89e2.mp3	dɪˈpɑrʧər deɪt ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
eedca128-c384-4fa9-8141-9ceac7ce92bf	travel dates plural	даты поездки	фраза	Enter all travel dates	A2	audio/word_travel_dates_9a5ce728.mp3	ˈtrævəl deɪts ˈplʊrəl	53e0c106-9803-4a4e-a880-f36db64c1373
4e3c9a57-e375-44d1-ae62-7a647b3963c1	seasonal discounts	сезонные скидки	фраза	Seasonal discounts apply in autumn	B1	audio/word_seasonal_discounts_3d05da85.mp3	ˈsizənəl ˈdɪˌskaʊnts	53e0c106-9803-4a4e-a880-f36db64c1373
e585dba7-057f-4365-b24e-6aada80199de	next available date slot	следующий доступный слот	фраза	Next available date slot is November	B2	audio/word_next_available_fa4fec62.mp3	nɛkst əˈveɪləbəl deɪt slɑt	53e0c106-9803-4a4e-a880-f36db64c1373
cf7b9286-1284-4037-a160-d05662289dda	daily flight schedule	ежедневное расписание полетов	фраза	Daily flight schedule shows all departures	A1	audio/word_daily_flight_0ce5032e.mp3	ˈdeɪli flaɪt ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
ab7bcc5e-7f1e-4e37-b9b1-fc4b437f5a8d	biannual review	полугодовой обзор	фраза	Biannual review of expenses	C1	audio/word_biannual_review_fee898db.mp3	baɪˈænuəl ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
4ed7627c-6096-4f8e-85de-ef9ab0d69476	date of entry	дата въезда	фраза	Date of entry on the visa	A1	audio/word_date_of_fe7d3ff0.mp3	deɪt əv ˈɛntri	53e0c106-9803-4a4e-a880-f36db64c1373
6e19deb9-3704-4b9b-9eb3-b4fab1421db1	quarterly planning session	квартальное планирование	фраза	Quarterly planning session set for July	B2	audio/word_quarterly_planning_ef1e58c6.mp3	kˈwɔrtərli ˈplænɪŋ ˈsɛʃən	53e0c106-9803-4a4e-a880-f36db64c1373
294b80e0-d3a6-40c9-94cc-9c37099f1f25	monthly target	ежемесячная цель	noun	Monthly target for sales reached	A2	audio/word_monthly_target_60da7389.mp3	ˈmənθli ˈtərgət	53e0c106-9803-4a4e-a880-f36db64c1373
584c4df6-b755-4d76-a05c-973bd258212c	departure gate	выход на посадку	noun	Departure gate is B42	A1	audio/word_departure_gate_d717d683.mp3	dɪˈpɑrʧər geɪt	53e0c106-9803-4a4e-a880-f36db64c1373
2a7047c5-0c23-4599-959e-e5a25ccc9e30	arrival lounge	зал прибытия	noun	Arrival lounge is spacious	B1	audio/word_arrival_lounge_7435a162.mp3	ərˈaɪvəl laʊnʤ	53e0c106-9803-4a4e-a880-f36db64c1373
7dd86495-7cff-4bfe-8b5d-9a1f99bb548a	month of travel	месяц поездки	фраза	Month of travel affects prices	A1	audio/word_month_of_899408f6.mp3	mənθ əv ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
691b8d14-0d24-4bcd-81f0-0cf524a0754d	yearly event	годовое событие	фраза	Yearly event brings tourists	B1	audio/word_yearly_event_c93b0998.mp3	ˈjɪrli ɪˈvɛnt	53e0c106-9803-4a4e-a880-f36db64c1373
252cbd95-ff72-4515-904b-9a3da77223a2	daylight hours	световой день	noun	Daylight hours vary seasonally	B2	audio/word_daylight_hours_13b37398.mp3	ˈdeɪˌlaɪt aʊərz	53e0c106-9803-4a4e-a880-f36db64c1373
ca7fe833-ec4e-4b78-aa65-4eb4bbc7c946	date stamped	отштампованная	прилагательное	Date stamped ticket is valid	A2	audio/word_date_stamped_37a31c71.mp3	deɪt stæmpt	53e0c106-9803-4a4e-a880-f36db64c1373
78604fba-2637-444b-b78e-dc9b8520cda2	flight calendar	авиакалендарь	noun	Check flight calendar for cheap deals	B2	audio/word_flight_calendar_42decf2d.mp3	flaɪt ˈkæləndər	53e0c106-9803-4a4e-a880-f36db64c1373
7237bc94-e005-4f63-999f-e6481492f100	peak season	пик сезона	фраза	Peak season costs more money	A1	audio/word_peak_season_7cc13c16.mp3	pik ˈsizən	53e0c106-9803-4a4e-a880-f36db64c1373
6ff39802-f91f-4574-b6fa-9caa053f5905	off-peak travel	поездка вне пика	фраза	Off-peak travel offers savings	B1	audio/word_off-peak_travel_0bd792d6.mp3	off-peak* ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
b8081b04-77e7-4fc9-96ee-264a3802410b	annual limit	годовой лимит	noun	Annual limit for foreign travel exceeded	B2	audio/word_annual_limit_148046fa.mp3	ˈænjuəl ˈlɪmət	53e0c106-9803-4a4e-a880-f36db64c1373
3f907b26-893b-4d06-a7db-bc1b834b41fa	quarterly performance	квартальная производительность	noun	Quarterly performance exceeded targets	B2	audio/word_quarterly_performance_f1aa4e75.mp3	kˈwɔrtərli pərˈfɔrməns	53e0c106-9803-4a4e-a880-f36db64c1373
0533eb10-5b18-4ec5-b0f0-ce443091d45b	weekly summary	еженедельный отчет	noun	Weekly summary shows travel expenses	A2	audio/word_weekly_summary_0da03029.mp3	ˈwikli ˈsəməri	53e0c106-9803-4a4e-a880-f36db64c1373
b504ee07-d8d8-4df9-908a-e8a592df0797	next available month	следующий доступный месяц	фраза	Next available month is March	B2	audio/word_next_available_4b4d5547.mp3	nɛkst əˈveɪləbəl mənθ	53e0c106-9803-4a4e-a880-f36db64c1373
2a4919f2-f2d3-4872-85be-368e5a4b20fc	daily flights plural	ежедневные рейсы	фраза	Daily flights connect major cities	A1	audio/word_daily_flights_8a0c94ed.mp3	ˈdeɪli flaɪts ˈplʊrəl	53e0c106-9803-4a4e-a880-f36db64c1373
e7839b09-cbdb-4c4e-9268-f9d810773a3f	travel month information	информация о месяце поездки	фраза	Travel month information is online	B1	audio/word_travel_month_8b2f70f3.mp3	ˈtrævəl mənθ ˌɪnˌfɔrˈmeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
e6683995-7c8a-4b63-9da2-dec0c8f395ce	yearly meeting	годовое собрание	noun	Yearly meeting is in November	A1	audio/word_yearly_meeting_8097aac2.mp3	ˈjɪrli ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
01da6c5c-1206-4b02-9913-a83ea52b1c39	bimonthly visit	раз в два месяца	фраза	Bimonthly visit to the branch	B2	audio/word_bimonthly_visit_605606f4.mp3	baɪˈmənθli ˈvɪzɪt	53e0c106-9803-4a4e-a880-f36db64c1373
1473e3ee-bedc-4563-86fd-ca1c4982f674	date of issue	дата выдачи	фраза	Date of issue shown on ticket	A1	audio/word_date_of_17a7b4ea.mp3	deɪt əv ˈɪʃu	53e0c106-9803-4a4e-a880-f36db64c1373
17532c8d-1eb2-4657-8703-6ba9996461be	monthly targets met	ежемесячные цели выполнены	фраза	Monthly targets met consistently	A2	audio/word_monthly_targets_12ccf521.mp3	ˈmənθli ˈtɑrgəts mɛt	53e0c106-9803-4a4e-a880-f36db64c1373
6654861c-3ab5-4b4f-b65d-97306474c4f2	overnight flight	ночной рейс	фраза	Overnight flight to New York	B1	audio/word_overnight_flight_383a3fc3.mp3	ˈoʊvərˈnaɪt flaɪt	53e0c106-9803-4a4e-a880-f36db64c1373
846d1cfc-3156-4919-b7c6-03bc65a30814	date validation check	проверка валидности даты	фраза	Date validation check passed	A1	audio/word_date_validation_d021918f.mp3	deɪt ˌvæləˈdeɪʃən ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
2185d265-2503-432e-96a6-c2cf63ee478e	flight path variation	изменение маршрута полета	фраза	Flight path variation saves fuel	B2	audio/word_flight_path_25ae70f6.mp3	flaɪt pæθ ˌvɛriˈeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
ea10f2c9-ebf9-4c6b-ae99-a6b1d8ddee86	booking date stamp	штамп даты бронирования	фраза	Booking date stamp confirms reservation	A1	audio/word_booking_date_2a1fb039.mp3	ˈbʊkɪŋ deɪt stæmp	53e0c106-9803-4a4e-a880-f36db64c1373
938cd40a-1442-475c-b1d2-caa9866fd590	trip duration planner	планировщик длительности поездки	фраза	Trip duration planner estimates costs	B1	audio/word_trip_duration_512bc3ac.mp3	trɪp ˈdʊˈreɪʃən ˈplænər	53e0c106-9803-4a4e-a880-f36db64c1373
ee11fbe9-eb56-471c-8ef7-2a5f77bdc4c8	quarterly financial report	квартальный финансовый отчет	noun	Quarterly financial report released	B2	audio/word_quarterly_financial_8ee13eea.mp3	kˈwɔrtərli ˌfaɪˈnænʃəl rɪˈpɔrt	53e0c106-9803-4a4e-a880-f36db64c1373
50fd9821-e167-4c77-bbe9-8ef80457b4b7	last minute travel	срочная поездка	фраза	Last minute travel deals available	A2	audio/word_last_minute_9264a53e.mp3	læst ˈmɪnət ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
9dce7fc8-83d2-4705-8c14-1ed33cb20f53	twice yearly event	событие дважды в год	фраза	Twice yearly event held in city center	B2	audio/word_twice_yearly_b992fea1.mp3	twaɪs ˈjɪrli ɪˈvɛnt	53e0c106-9803-4a4e-a880-f36db64c1373
9b8474a9-0a29-470e-91bf-45246b1afeb5	date of passport issue	дата выдачи паспорта	фраза	Date of passport issue must be entered	A1	audio/word_date_of_87877bac.mp3	deɪt əv ˈpæˌspɔrt ˈɪʃu	53e0c106-9803-4a4e-a880-f36db64c1373
237b3fba-a4a3-4133-be5c-faa666fb5329	seasonal trends	сезонные тенденции	фраза	Seasonal trends affect ticket prices	B1	audio/word_seasonal_trends_234056d1.mp3	ˈsizənəl trɛnz	53e0c106-9803-4a4e-a880-f36db64c1373
393dc8d2-ce21-496c-93b8-8d211f4fb473	weekly hotel rates	еженедельные отельные ставки	фраза	Weekly hotel rates lower than daily	A2	audio/word_weekly_hotel_97e6a3c1.mp3	ˈwikli hoʊˈtɛl reɪts	53e0c106-9803-4a4e-a880-f36db64c1373
30f109b1-d260-4a4c-92c4-749569c04693	monthly subscription	ежемесячная подписка	noun	Monthly subscription includes discounts	B2	audio/word_monthly_subscription_31876fed.mp3	ˈmənθli səbˈskrɪpʃən	53e0c106-9803-4a4e-a880-f36db64c1373
cfbe4534-e6a5-483e-b724-e6eea4b19770	annual membership fee	годовой членский взнос	noun	Annual membership fee waived first year	C2	audio/word_annual_membership_8571a99d.mp3	ˈænjuəl ˈmɛmbərˌʃɪp fi	53e0c106-9803-4a4e-a880-f36db64c1373
439984a9-34f3-4c89-8215-78362670c578	seasonal menu	сезонное меню	фраза	Seasonal menu features local dishes	B1	audio/word_seasonal_menu_dfca6290.mp3	ˈsizənəl ˈmɛnju	53e0c106-9803-4a4e-a880-f36db64c1373
333a438b-6597-4b8c-8db9-51a12d94f59b	departure lounge notification	уведомление в зале вылета	фраза	Departure lounge notification announced	A1	audio/word_departure_lounge_d9ea9fd3.mp3	dɪˈpɑrʧər laʊnʤ ˌnoʊtəfəˈkeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
4dcf09ee-1666-4408-85d3-391b8ff4db9c	arrival time flexibility	гибкость времени прибытия	фраза	Arrival time flexibility offered airline	B2	audio/word_arrival_time_94cf3ddc.mp3	ərˈaɪvəl taɪm ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
d6d6f0bd-470d-4eef-b7be-185fcfe1b666	daily flight numbers	номера рейсов в день	фраза	Daily flight numbers listed online	A1	audio/word_daily_flight_e9ac4a67.mp3	ˈdeɪli flaɪt ˈnəmbərz	53e0c106-9803-4a4e-a880-f36db64c1373
c466f906-24a3-4294-ad34-d30168d9d2b0	next day delivery	доставка на следующий день	фраза	Next day delivery for urgent tickets	A1	audio/word_next_day_8fefc84d.mp3	nɛkst deɪ dɪˈlɪvəri	53e0c106-9803-4a4e-a880-f36db64c1373
55e6d78f-8a4c-4dee-9fbc-4a7602c54eaa	flight frequency monitoring	мониторинг частоты рейсов	noun	Flight frequency monitoring required	B2	audio/word_flight_frequency_bf6e5a4f.mp3	flaɪt ˈfrikwənsi ˈmɑnətərɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
ce01abea-e27d-47e3-8231-58f8bbf39898	travel date flexibility	гибкость даты поездки	фраза	Travel date flexibility saves costs	A2	audio/word_travel_date_df80847d.mp3	ˈtrævəl deɪt ˌflɛksəˈbɪləti	53e0c106-9803-4a4e-a880-f36db64c1373
e499a04b-432c-4787-813b-f5b0f8000d61	flight path optimization	оптимизация маршрута полета	фраза	Flight path reduces flight duration	B2	audio/word_flight_path_db6c0443.mp3	flaɪt pæθ ɑptɪmɪˈzeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
27e41eef-f3b9-4c5f-9354-84f95e78ed79	arrival hall signage	указатели в зале прибытия	фраза	Arrival hall signage is multilingual	A2	audio/word_arrival_hall_9dc3295d.mp3	ərˈaɪvəl hɔl ˈsaɪnɪʤ	53e0c106-9803-4a4e-a880-f36db64c1373
129884ec-758a-4872-9de7-ec9dc0ba2dd4	monthly expense tracker	ежемесячный трекер расходов	noun	Monthly expense tracker app	B1	audio/word_monthly_expense_35cc69f6.mp3	ˈmənθli ɪkˈspɛns ˈtrækər	53e0c106-9803-4a4e-a880-f36db64c1373
c06f6c8a-e038-4aba-b226-a5f80044c888	semester break travel	поездка на каникулы	фраза	Semester break travel schedules	B2	audio/word_semester_break_5a54e0c4.mp3	səˈmɛstər breɪk ˈtrævəl	53e0c106-9803-4a4e-a880-f36db64c1373
6c883a34-4d01-412a-ae55-d73ff7ab7d44	year end sales	годовые распродажи	noun	Year end sales include travel deals	C1	audio/word_year_end_0333de8c.mp3	jɪr ɛnd seɪlz	53e0c106-9803-4a4e-a880-f36db64c1373
52ea5edc-4519-49a4-99b0-65f812bd4348	annual budget meeting	годовая бюджетная встреча	фраза	Annual budget meeting scheduled	B2	audio/word_annual_budget_ec763a7d.mp3	ˈænjuəl ˈbəʤɪt ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
a554f1c2-6347-4955-9c01-a9204e3d8ae3	date format specification	спецификация формата даты	фраза	Date format specification must be followed	A1	audio/word_date_format_1d513179.mp3	deɪt ˈfɔrˌmæt ˌspɛsɪfɪˈkeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
38445ace-4ab4-4a61-a3b9-9dce47748b83	flight time table lookup	поиск в расписании рейсов	фраза	Flight time table lookup system	A1	audio/word_flight_time_bb326876.mp3	flaɪt taɪm ˈteɪbəl ˈlʊkəp	53e0c106-9803-4a4e-a880-f36db64c1373
b079133d-5419-43e7-87b9-970aa32a49cd	arrival concierge service	служба встречи при прибытии	фраза	Arrival concierge service available	B1	audio/word_arrival_concierge_c15c92a8.mp3	ərˈaɪvəl ˌkɑnsiˈɛrʒ ˈsərvɪs	53e0c106-9803-4a4e-a880-f36db64c1373
524fc363-c7e1-454b-a69f-4952ca50667d	next day itinerary	распорядок на следующий день	фраза	Next day itinerary arranged	B1	audio/word_next_day_fcb4d92a.mp3	nɛkst deɪ aɪˈtɪnərˌɛri	53e0c106-9803-4a4e-a880-f36db64c1373
a91c4232-4126-44c7-b898-6132fe484887	flight path tracking	трекинг маршрута полета	noun	Flight path tracking shows delays	B2	audio/word_flight_path_400fdf09.mp3	flaɪt pæθ ˈtrækɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
69dfa273-234d-41c1-8360-9b7e160f4d37	bimonthly subscription	подписка раз в два месяца	noun	Bimonthly subscription for magazines	B2	audio/word_bimonthly_subscription_f2413e08.mp3	baɪˈmənθli səbˈskrɪpʃən	53e0c106-9803-4a4e-a880-f36db64c1373
ab582b0a-489c-4b15-8906-30c5fd464232	monthly performance review	ежемесячное обзорное собрание	noun	Monthly performance review conducted	B1	audio/word_monthly_performance_63b14b26.mp3	ˈmənθli pərˈfɔrməns ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
d23d41fc-f398-4db9-906e-19c0d1f6a874	date stamping machine	машина для штамповки даты	noun	Date stamping machine at check-in	A1	audio/word_date_stamping_6f44026d.mp3	deɪt ˈstæmpɪŋ məˈʃin	53e0c106-9803-4a4e-a880-f36db64c1373
b4e98a2e-ee2c-453c-81fa-c9439c55bbee	seasonal promotions	сезонные акции	фраза	Seasonal promotions on hotel rooms	B1	audio/word_seasonal_promotions_9500e152.mp3	ˈsizənəl pərˈmoʊʃənz	53e0c106-9803-4a4e-a880-f36db64c1373
0fb6f836-3e9b-42f3-86c5-1e1c467fda39	arrival terminal guide	гид по терминалу прибытия	нвоg	Arrival terminal guide available	A1	audio/word_arrival_terminal_45c80148.mp3	ərˈaɪvəl ˈtərmənəl gaɪd	53e0c106-9803-4a4e-a880-f36db64c1373
83ca98fe-0fb5-46a2-915a-fbdec2b9b688	flight schedule frequency	частота расписания рейсов	фраза	Flight schedule frequency explained	A2	audio/word_flight_schedule_3065c288.mp3	flaɪt ˈskɛʤʊl ˈfrikwənsi	53e0c106-9803-4a4e-a880-f36db64c1373
56dfd2d3-2000-4758-8a9b-1baa0b52a9e2	daily departure schedule	ежедневное расписание вылетов	фраза	Daily departure schedule displayed	A1	audio/word_daily_departure_f598b45d.mp3	ˈdeɪli dɪˈpɑrʧər ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
13dd972e-e1bb-41a2-b36d-d1015e6e2a78	quarterly business result	квартальный результат работы	фраза	Quarterly business result impressive	B1	audio/word_quarterly_business_9df557f7.mp3	kˈwɔrtərli ˈbɪznɪs rɪˈzəlt	53e0c106-9803-4a4e-a880-f36db64c1373
50d474b7-8793-4620-b862-cf1a0208c879	trip duration extension	продление длительности поездки	фраза	Trip duration extension possible	B1	audio/word_trip_duration_3c899a53.mp3	trɪp ˈdʊˈreɪʃən ɪkˈstɛnʃən	53e0c106-9803-4a4e-a880-f36db64c1373
506c0a58-3362-4cb1-b215-3c461b2a7fa7	date of entry requirements	требования к дате въезда	фраза	Date of entry visa requirements	A1	audio/word_date_of_4e735052.mp3	deɪt əv ˈɛntri rɪkˈwaɪrmənts	53e0c106-9803-4a4e-a880-f36db64c1373
71236aae-6209-4844-9fff-cce7a6dda28e	seasonal temperature variation	сезонное колебание температур	фраза	Seasonal temperature variation affects travel	B1	audio/word_seasonal_temperature_41297f1c.mp3	ˈsizənəl ˈtɛmpərəʧər ˌvɛriˈeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
d4ec950e-ea19-4609-aed6-c286f6b1b052	weekly chit chat meeting	еженедельная встреча по болтовне	noun	Weekly chit chat meeting scheduled	A2	audio/word_weekly_chit_0f71b895.mp3	ˈwikli ʧɪt ʧæt ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
1131e4f2-55df-4a51-9db0-f406f2ced731	arrival baggage claim display	табло выдачи багажа прилетевших	noun	Arrival baggage claim display shows baggage	A1	audio/word_arrival_baggage_f9c4dfc0.mp3	ərˈaɪvəl ˈbægɪʤ kleɪm dɪˈspleɪ	53e0c106-9803-4a4e-a880-f36db64c1373
1ba70301-d23e-43be-a2a7-464a657a0530	monthly financial statement	ежемесячный финансовый отчет	noun	Monthly financial statement prepared	B1	audio/word_monthly_financial_db408cac.mp3	ˈmənθli ˌfaɪˈnænʃəl ˈsteɪtmənt	53e0c106-9803-4a4e-a880-f36db64c1373
0f581ec7-af8d-4627-8e0d-1a4bf618a195	bimonthly training session	двухнедельный учебный сеанс	фраза	Bimonthly training session conducted	B2	audio/word_bimonthly_training_6d528283.mp3	baɪˈmənθli ˈtreɪnɪŋ ˈsɛʃən	53e0c106-9803-4a4e-a880-f36db64c1373
7fc1a8d5-5f77-486c-ada2-d1009a9d99b0	date stamp validation	проверка штампа даты	фраза	Date stamp validation required	A2	audio/word_date_stamp_7d30bc46.mp3	deɪt stæmp ˌvæləˈdeɪʃən	53e0c106-9803-4a4e-a880-f36db64c1373
d04b28a1-da1d-4375-8323-786f3b72f1f3	flight path accuracy check	проверка точности маршрута полета	фраза	Flight path accuracy check performed	C1	audio/word_flight_path_b74a5a4c.mp3	flaɪt pæθ ˈækjərəsi ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
c3cd50e8-7cf4-455c-b887-1d761d492eb9	arrival door service counter	сервисный стойка у дверей прибытия	noun	Arrival door service counter helpful	B1	audio/word_arrival_door_82b8d3bc.mp3	ərˈaɪvəl dɔr ˈsərvɪs ˈkaʊntər	53e0c106-9803-4a4e-a880-f36db64c1373
f12918dd-3ef8-42db-84d5-31e1f9c31286	next available boarding gate	следующий доступный выход на посадку	фраза	Next available boarding gate announced	A1	audio/word_next_available_236c142c.mp3	nɛkst əˈveɪləbəl ˈbɔrdɪŋ geɪt	53e0c106-9803-4a4e-a880-f36db64c1373
72d5093e-6b3b-42fa-a21e-6d957fec7b8f	flight schedule planner	планировщик расписания рейсов	noun	Flight schedule planner recommended	A1	audio/word_flight_schedule_cf3782cb.mp3	flaɪt ˈskɛʤʊl ˈplænər	53e0c106-9803-4a4e-a880-f36db64c1373
0e1d7ed0-3331-4a35-8175-7cb837c8ec16	arrival instruction booklet	приемная инструкция	noun	Arrival instruction booklet provided	A2	audio/word_arrival_instruction_a08622cd.mp3	ərˈaɪvəl ˌɪnˈstrəkʃən ˈbʊklɪt	53e0c106-9803-4a4e-a880-f36db64c1373
d6e41f33-b5cb-46f7-a6e6-500ff4bb878a	date passport issued	дата выдачи паспорта	фраза	Date passport issued verified	A1	audio/word_date_passport_556da25e.mp3	deɪt ˈpæˌspɔrt ˈɪʃud	53e0c106-9803-4a4e-a880-f36db64c1373
ef4accc6-2bc4-4dd8-bc1e-b73845d53d9e	seasonal travel tip	сезонный совет по путешествиям	noun	Seasonal travel tip shared in blog	B2	audio/word_seasonal_travel_4dce9927.mp3	ˈsizənəl ˈtrævəl tɪp	53e0c106-9803-4a4e-a880-f36db64c1373
06e9c2c6-f8df-417c-9674-aece8e2ffb04	weekly team meeting	еженедельная встреча команды	noun	Weekly team meeting rescheduled	A1	audio/word_weekly_team_78e1bbdf.mp3	ˈwikli tim ˈmitɪŋ	53e0c106-9803-4a4e-a880-f36db64c1373
cdc969c5-a5c6-4f3a-a50f-9ca6e5389eb7	flight path weather impact	влияние погоды на маршрут полета	фраза	Flight path weather impact assessed	B2	audio/word_flight_path_f78582b5.mp3	flaɪt pæθ ˈwɛðər ˌɪmˈpækt	53e0c106-9803-4a4e-a880-f36db64c1373
91ef53d1-f2cb-4b39-87d3-a25f2f40f967	arrival assistance service	служба помощи при прибытии	noun	Arrival assistance service available	B1	audio/word_arrival_assistance_e1d12e6f.mp3	ərˈaɪvəl əˈsɪstəns ˈsərvɪs	53e0c106-9803-4a4e-a880-f36db64c1373
52a082d6-6f9e-4988-b176-86b8faf300bc	trip duration calculator	калькулятор длительности поездки	noun	Trip duration calculator reliable	A1	audio/word_trip_duration_3c81186e.mp3	trɪp ˈdʊˈreɪʃən ˈkælkjəˌleɪtər	53e0c106-9803-4a4e-a880-f36db64c1373
1f37bebe-b0ff-43f7-b41e-d4ebc7c2672a	quarterly bonus payment	квартальная выплата бонуса	фраза	Quarterly bonus payment processed	B1	audio/word_quarterly_bonus_122b990c.mp3	kˈwɔrtərli ˈboʊnəs ˈpeɪmənt	53e0c106-9803-4a4e-a880-f36db64c1373
c1ad23e5-4cb6-40ea-adae-ff8953d0ad71	bimonthly performance review	двухнедельный пересмотр производительности	фраза	Bimonthly performance review scheduled	B2	audio/word_bimonthly_performance_b4d0d4b1.mp3	baɪˈmənθli pərˈfɔrməns ˌrivˈju	53e0c106-9803-4a4e-a880-f36db64c1373
6fd84537-3a1b-4964-9043-aad37a5b0037	flight path reroute protocol	протокол перенаправления маршрута полета	noun	Flight path reroute protocol activated	C1	audio/word_flight_path_5a42d83d.mp3	flaɪt pæθ riˈrut ˈproʊtəˌkɔl	53e0c106-9803-4a4e-a880-f36db64c1373
1fd96fcb-4bdc-46bd-9166-136275ffc05e	travel date flexibility fee	плата за гибкость даты поездки	фраза	Travel date flexibility fee waived	B2	audio/word_travel_date_2c7a7531.mp3	ˈtrævəl deɪt ˌflɛksəˈbɪləti fi	53e0c106-9803-4a4e-a880-f36db64c1373
98223e5f-b9c4-4fce-bfc4-d40b8b0f65e0	seasonal cargo schedule	сезонное расписание грузов	noun	Seasonal cargo schedule adjusted	B2	audio/word_seasonal_cargo_111bfcb6.mp3	ˈsizənəl ˈkɑrˌgoʊ ˈskɛʤʊl	53e0c106-9803-4a4e-a880-f36db64c1373
c4ab6d7f-611c-4fbd-a9d3-25e20821c534	weekly backup system check	еженедельная проверка резервной системы	noun	Weekly backup system check completed	A2	audio/word_weekly_backup_99040f38.mp3	ˈwikli ˈbæˌkəp ˈsɪstəm ʧɛk	53e0c106-9803-4a4e-a880-f36db64c1373
1c38ca8e-ff01-4520-91a6-5baf43cc697c	bimonthly security drill	двухнедельная проверка безопасности	фраза	Bimonthly security drill conducted	B2	audio/word_bimonthly_security_ec78859d.mp3	baɪˈmənθli sɪˈkjʊrəti drɪl	53e0c106-9803-4a4e-a880-f36db64c1373
0070227d-91dc-4218-92db-5a9be67be56f	flight path optimization cost	стоимость оптимизации маршрута полета	фраза	Flight path optimization cost calculated	C1	audio/word_flight_path_f926438b.mp3	flaɪt pæθ ɑptɪmɪˈzeɪʃən kɔst	53e0c106-9803-4a4e-a880-f36db64c1373
46afd5a0-ca2f-4ee6-81b9-cf52875be263	date format conversion tool	инструмент преобразования формата даты	noun	Date format conversion tool helpful	A1	audio/word_date_format_2cc4bfa2.mp3	deɪt ˈfɔrˌmæt kənˈvərʒən tul	53e0c106-9803-4a4e-a880-f36db64c1373
80578cbf-9f1d-41f2-b937-3ec245f54360	seasonal staffing plan	сезонный план персонала	фраза	Seasonal staffing plan implemented	B1	audio/word_seasonal_staffing_a7019d77.mp3	ˈsizənəl ˈstæfɪŋ plæn	53e0c106-9803-4a4e-a880-f36db64c1373
5691a7c0-e914-4cb4-a996-ae9f8e5ca059	arrival procedure manual	приемная инструкция	noun	Arrival procedure manual updated	B2	audio/word_arrival_procedure_93b07ea8.mp3	ərˈaɪvəl prəˈsiʤər ˈmænjuəl	53e0c106-9803-4a4e-a880-f36db64c1373
a3b99f07-740c-4fcb-a15d-6e98d7e5989e	date passport validation rule	правило проверки паспорта даты	фраза	Date passport validation rule enforced	A1	audio/word_date_passport_4e0c3bf5.mp3	deɪt ˈpæˌspɔrt ˌvæləˈdeɪʃən rul	53e0c106-9803-4a4e-a880-f36db64c1373
10c90346-a799-4d00-b894-ecec2ff40bd0	flight schedule disruption log	журнал сбоев расписания рейсов	noun	Flight schedule disruption log maintained	B1	audio/word_flight_schedule_6f6f8574.mp3	flaɪt ˈskɛʤʊl dɪsˈrəpʃən lɔg	53e0c106-9803-4a4e-a880-f36db64c1373
2da842e0-379e-413d-b304-8858aa5023e8	bank holiday	банковский выходной (особенно в Великобритании)	noun	We have a bank holiday next Monday	B2	audio/word_bank_holiday_1c2f45fa.mp3	bæŋk ˈhɑlɪˌdeɪ	f404724a-3fa0-48b0-a89c-04643421f399
0e9b80a6-b9f9-44ce-8e3f-142a1801d76d	New Year's Day	Новый год	noun	We celebrate New Year's Day on January 1st	A1	audio/word_new_year's_40aa6e33.mp3	nu jɪrz deɪ	f404724a-3fa0-48b0-a89c-04643421f399
cda62ed4-14f5-43a8-9e92-d59da4b4914b	Christmas	Рождество	noun	Christmas is my favorite holiday	A1	audio/word_christmas_935916a9.mp3	ˈkrɪsməs	f404724a-3fa0-48b0-a89c-04643421f399
932aa391-cdfb-44d5-bf2f-e783d5c4f3ab	Easter	Пасха	noun	Easter is a Christian holiday	B2	audio/word_easter_8a416c53.mp3	ˈistər	f404724a-3fa0-48b0-a89c-04643421f399
d307f78a-f809-4627-8450-ee1a0ee9ea8b	Independence Day	День независимости	noun	Americans celebrate Independence Day on July 4th	A2	audio/word_independence_day_8f0311ab.mp3	ˌɪndɪˈpɛndəns deɪ	f404724a-3fa0-48b0-a89c-04643421f399
6c60b1c8-f5f4-428a-a0ea-94ff341f5caf	Thanksgiving	День благодарения	noun	We eat turkey on Thanksgiving	B1	audio/word_thanksgiving_70be52f6.mp3	ˌθæŋksˈgɪvɪŋ	f404724a-3fa0-48b0-a89c-04643421f399
36ed2862-45d0-4634-90e0-4c0163b8db30	Halloween	Хэллоуин	noun	Children dress up for Halloween	A1	audio/word_halloween_479d14c0.mp3	ˌhæləˈwin	f404724a-3fa0-48b0-a89c-04643421f399
44787df6-1455-4a5b-9385-84300ca3eef4	Valentine's Day	День святого Валентина	noun	Do you have a Valentine's Day date?	A1	audio/word_valentine's_day_b772a910.mp3	ˈvælənˌtaɪnz deɪ	f404724a-3fa0-48b0-a89c-04643421f399
fb5bca5b-96d6-46a2-a357-d5ffc4bcee64	take a holiday	брать отпуск	phrasal verb	When do you take a holiday this year?	B2	audio/word_take_a_f8115707.mp3	teɪk ə ˈhɑlɪˌdeɪ	f404724a-3fa0-48b0-a89c-04643421f399
a33635be-035f-4f5b-a248-8520c6723c53	decorate	украшать	verb	We decorate the Christmas tree	A1	audio/word_decorate_7fe53428.mp3	ˈdɛkərˌeɪt	f404724a-3fa0-48b0-a89c-04643421f399
7d850b20-a6ce-4fea-8a7f-21cdfaa693fd	gift	подарок	noun	What gift should I buy?	A1	audio/word_gift_051d2caa.mp3	gɪft	f404724a-3fa0-48b0-a89c-04643421f399
a6e21b6d-0630-439b-a3f8-206c243f36aa	wrap a gift	упаковывать подарок	phrasal verb	Can you help me wrap this gift?	B1	audio/word_wrap_a_1f72f7ab.mp3	ræp ə gɪft	f404724a-3fa0-48b0-a89c-04643421f399
dfc74480-c580-4568-be1a-006261f5e580	exchange gifts	обмениваться подарками	phrasal verb	We exchange gifts on Christmas Eve	B1	audio/word_exchange_gifts_f253eb8c.mp3	ɪksˈʧeɪnʤ gɪfts	f404724a-3fa0-48b0-a89c-04643421f399
57df5acb-ed32-40b1-8224-b96dbfeee6f6	family gathering	семейное собрание	noun	We have a family gathering at Christmas	B1	audio/word_family_gathering_0940c942.mp3	ˈfæməli ˈgæðərɪŋ	f404724a-3fa0-48b0-a89c-04643421f399
8765789f-149a-4a8f-9184-c7cc6030813b	light fireworks	зажигать фейерверки	phrasal verb	They light fireworks on New Year's Eve	B1	audio/word_light_fireworks_dcdfa12d.mp3	laɪt ˈfaɪrˌwərks	f404724a-3fa0-48b0-a89c-04643421f399
88dd62c7-2f04-483c-9ed8-e8a6a58fc59e	dress up	наряжаться	phrasal verb	People dress up for the festival	A2	audio/word_dress_up_47753fbe.mp3	drɛs əp	f404724a-3fa0-48b0-a89c-04643421f399
1df04357-71ca-4d04-bd2a-1bd60bc076b7	long weekend	длинные выходные	noun	We have a long weekend for Easter	A1	audio/word_long_weekend_804eafb2.mp3	lɔŋ ˈwiˌkɪnd	f404724a-3fa0-48b0-a89c-04643421f399
58cc18ed-e2b3-4684-8a70-2ac8eb67b88a	travel plans	планы на путешествие	noun	What are your holiday travel plans?	B1	audio/word_travel_plans_d6b512d4.mp3	ˈtrævəl plænz	f404724a-3fa0-48b0-a89c-04643421f399
1110c2c8-33c7-40f0-ba73-c97d446b63b4	festive season	праздничный сезон	noun	The festive season is very busy	B2	audio/word_festive_season_fdf5f27e.mp3	ˈfɛstɪv ˈsizən	f404724a-3fa0-48b0-a89c-04643421f399
e72579bd-d282-4b53-b4f6-a15b9466f260	countdown	обратный отсчёт	noun	Let's start the New Year countdown	A2	audio/word_countdown_8ef96109.mp3	ˈkaʊntˌdaʊn	f404724a-3fa0-48b0-a89c-04643421f399
5ea0572f-057f-42c5-92d2-7454f9d81248	holiday abroad	отпуск за границей	noun	We went on holiday abroad last summer	C1	audio/word_holiday_abroad_a0547479.mp3	ˈhɑlɪˌdeɪ əˈbrɔd	f404724a-3fa0-48b0-a89c-04643421f399
3971a9ca-3611-46c2-ac99-65a94d4884d6	Can_you_help_me?	Вы можете помочь?	phrase	Can you help me find my gate?	A2	audio/word_can_you_help_me?_7e2e1af3.mp3	can_you_help_me*?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
eee4483a-70d9-4ed5-9127-23418c30d92e	Where_is...?	Где находится...?	phrase	Where is the check-in desk?	A1	audio/word_where_is...?_fe0c70fc.mp3	where_is*...?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
5fb868d8-1762-4499-932b-e1e3d91c476a	I_need_assistance	Мне нужна помощь	phrase	I need assistance with my luggage	A2	audio/word_i_need_assistance_73306d38.mp3	i_need_assistance*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
96a3b779-92fd-4466-a0fc-58ac6f91d91a	Could_you_please...	Не могли бы вы...	phrase	Could you please tell me where the restroom is?	A2	audio/word_could_you_please..._14385d4b.mp3	could_you_please*...	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
3d633c6e-51be-4b44-9497-6b3887709744	Excuse_me	Извините	phrase	Excuse me, is this the queue for departure?	A1	audio/word_excuse_me_963b4993.mp3	excuse_me*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
f9a6e4e3-8d95-4013-ae8b-08325628c30e	I_m_lost	Я потерялся	phrase	I'm lost, can you help me?	A2	audio/word_i_m_lost_25608c4d.mp3	i_m_lost*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
5eee0c1b-5554-41cb-9415-3ef0eafe0339	How_do_I_get_to...?	Как мне добраться до...?	phrase	How do I get to the duty-free shop?	A2	audio/word_how_do_i_get_to...?_28ff0fec.mp3	how_do_i_get_to*...?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
39e781de-6571-4947-b2a6-78e269b9fbe4	I_can_t_find	Я не могу найти	phrase	I can't find my boarding pass	A2	audio/word_i_can_t_find_f367df70.mp3	i_can_t_find*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
fca92577-1b71-44ce-9ae4-be0e14aa4647	Could_you_repeat?	Можете повторить?	phrase	Could you repeat the gate number?	A1	audio/word_could_you_repeat?_b8ad875b.mp3	could_you_repeat*?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
f023ce23-4e44-4d92-91ff-da6d51c97268	What_time_does_the_flight...?	Во сколько вылетает рейс...?	phrase	What time does the flight leave?	A2	audio/word_what_time_does_the_flight...?_e2e86c86.mp3	what_time_does_the_flight*...?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
19134dc6-f56f-41e7-b49e-ca88b61f15af	Where_is_gate_number_34?	Где выход №34?	phrase	Where is gate number 34?	A1	audio/word_where_is_gate_number_34?_dfd5e52b.mp3	where_is_gate_number_34*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
d4cf500d-7682-4a9b-9e37-1c31cdfee5ac	I_have_a_problem	У меня проблема	phrase	I have a problem with my ticket	A2	audio/word_i_have_a_problem_ce0bb27c.mp3	i_have_a_problem*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
066c54ef-12db-4368-ab27-fc614c1ae9b2	Could_you_speak_slowly?	Говорите медленнее	phrase	Could you speak slowly, please?	A1	audio/word_could_you_speak_slowly?_5d2b1547.mp3	could_you_speak_slowly*?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
d9473a8c-934c-40ea-b86e-0e38978e7878	I_need_a_wheelchair	Мне нужна коляска	phrase	I need a wheelchair for the flight	A2	audio/word_i_need_a_wheelchair_68c5aa34.mp3	i_need_a_wheelchair*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
19ccd16f-6a48-4568-b0a3-d8368d2ae257	Where_is_security?	Где контроль безопасности?	phrase	Where is security check?	A1	audio/word_where_is_security?_77845c42.mp3	where_is_security*?	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
5e265c48-597c-4b65-9e3c-2a46a9b2cd50	Boarding_has_started	Посадка началась	phrase	Boarding has started for flight BA455	A2	audio/word_boarding_has_started_5163e7be.mp3	boarding_has_started*	00588743-8bce-4fa1-9e17-8b0e2fc5ce9e
4cbbeac3-6936-412f-b30d-79d034b9878b	check-in	регистрация	noun	Please go to check-in	A1	audio/word_check-in_be884001.mp3	check-in*	aa4543d8-f212-48b4-97da-5ea924de3c99
cdd6eae9-e641-4ef0-a642-5e206b0aeaf8	boarding pass	посадочный талон	noun	Show your boarding pass	A1	audio/word_boarding_pass_4e005aed.mp3	ˈbɔrdɪŋ pæs	\N
c8d3cd45-21ff-4507-82a5-abe32762a3fe	gate	выход (на посадку)	noun	My flight is at gate B12	A1	audio/word_gate_098fdc01.mp3	geɪt	\N
013eca79-2b8c-4343-abc4-c4353f1401c1	arrival	прибытие	noun	What's the arrival time?	A2	audio/word_arrival_63253cb4.mp3	ərˈaɪvəl	\N
0e582197-df81-40ff-92b0-8d7c765bc8b6	luggage	багаж	noun	My luggage is missing	A1	audio/word_luggage_07200491.mp3	ˈləgɪʤ	3703d1bf-478b-4630-81a1-5f39b1161fc9
5264bc9e-4f99-4ddd-80e5-c8118c7f4d40	suitcase	чемодан	noun	Where is my suitcase?	A1	audio/word_suitcase_7a533e71.mp3	ˈsutˌkeɪs	\N
8b1180d1-739d-4d49-8d02-57981a7b5275	baggage claim	зал выдачи багажа	noun	Baggage claim is on the left	A2	audio/word_baggage_claim_0e1568e2.mp3	ˈbægɪʤ kleɪm	\N
4f00a568-9c68-4223-8fae-f03683402014	delay	задержка	noun	Flight delayed due to weather	B1	audio/word_delay_034e459d.mp3	dɪˈleɪ	\N
52de9218-720b-4088-b0a9-4d2df7229cd7	cancel	отменить	verb	The flight was cancelled	B1	audio/word_cancel_eb028f3f.mp3	ˈkænsəl	\N
009bd45c-ba72-4df5-aa72-d7e148ca8347	terminal	терминал	noun	Which terminal for BA267?	A2	audio/word_terminal_47cfed4a.mp3	ˈtərmənəl	\N
56354bb8-d29b-4471-83b7-d8f45042ffbf	boarding call	объявление о посадке	noun	Final boarding call	B1	audio/word_boarding_call_66e6eb29.mp3	ˈbɔrdɪŋ kɔl	\N
a63bd475-7fd5-4424-bc28-73ba8a905891	aisle seat	место у прохода	noun	I prefer an aisle seat	B1	audio/word_aisle_seat_71c96559.mp3	aɪəl sit	\N
4b5ba6c9-facd-4da1-a4b8-33dbaa9a98b4	window seat	место у окна	noun	Can I get a window seat?	B1	audio/word_window_seat_e85ba6a5.mp3	ˈwɪndoʊ sit	\N
6cb62920-d899-445e-ac0d-55b94f87ecce	overhead bin	полка над сиденьем	noun	Put your bag in the overhead bin	A2	audio/word_overhead_bin_fd8dc320.mp3	ˈoʊvərˈhɛd bɪn	\N
e5d44b43-054f-4fb9-8186-b7a7d230fff1	flight	рейс	noun	Flight to New York	A1	audio/word_flight_74af17bd.mp3	flaɪt	\N
01841719-1ab2-4f33-a30e-442f168869f7	arrive	прилетать	verb	When does it arrive?	A2	audio/word_arrive_6ad5cb3c.mp3	əraɪv	\N
7e13be7b-2454-4dc2-af60-7e703846d4f1	connecting flight	пересадочный рейс	noun	Connecting flight in Paris	B1	audio/word_connecting_flight_ec69f4c5.mp3	kəˈnɛktɪŋ flaɪt	\N
495f249f-3538-4233-bec0-28b14d5186d1	"I don't understand."	Я не понимаю.	phrase	I don't understand.	A1	audio/word_"i_don't_9cef2abb.mp3	"aɪ doʊnt ˌəndərˈstænd."	\N
826764b2-1142-4911-83f4-767bceb2aa77	agenda	повестка дня	noun	Could you send me the meeting agenda?	B1	audio/word_agenda_938304c1.mp3	əˈʤɛndə	\N
b69c0100-ab8d-4385-8111-c9e99922e95b	schedule	расписание	noun	Let's check the team schedule	B1	audio/word_schedule_7b758f7e.mp3	ˈskɛʤʊl	\N
8ddb6dcc-eee7-4250-8867-94afedc031ef	postpone	перенести	verb	We need to postpone the meeting	B2	audio/word_postpone_4a23a85f.mp3	poʊstˈpoʊn	\N
36b1709b-2631-4c43-bdfc-216e5e50622a	discuss	обсуждать	verb	Let's discuss your proposal	B1	audio/word_discuss_4521e17b.mp3	dɪˈskəs	\N
887840e1-38ac-4d4d-ad96-ab70f4a58417	decision	решение	noun	We need to make a decision	B1	audio/word_decision_1a9c5a46.mp3	dɪˈsɪʒən	\N
b8de193a-16ac-479a-a63e-13e76076523e	action item	действие	noun	Assign action items after the meeting	B1	audio/word_action_item_5aadffb0.mp3	ˈækʃən ˈaɪtəm	\N
16b0d89b-cb10-45e9-89ef-3f2a5641fd6f	point	пункт	noun	The first point is budget	B1	audio/word_point_695c87f2.mp3	pɔɪnt	a8c715df-25ad-4cb3-9e7b-d9b6c3e85f78
9a8fa2a8-41d9-44e8-9b75-9f940268d4f6	meeting	встреча	noun	I have a meeting at 3	A1	audio/word_meeting_c8b1a79e.mp3	ˈmitɪŋ	a105c3b1-720d-410f-9a6c-bc6f4c1839d5
9644596a-393a-4140-b58e-d54d1aaff90c	follow up	продолжить	phrasal verb	Follow up on this email tomorrow	B2	audio/word_follow_up_44e1d18d.mp3	ˈfɑloʊ əp	\N
56fdf47b-d0d4-4b7b-826f-e92b23bbee33	urgent	срочный	adjective	This matter is urgent	A2	audio/word_urgent_45be534d.mp3	ˈərʤənt	\N
b11acd1f-2437-41f3-81f8-5dd3ea4559bc	relevant	актуальный	adjective	Is this information relevant?	B1	audio/word_relevant_ae4a21b7.mp3	ˈrɛləvənt	\N
d847e152-df39-4d5f-9f2e-373e525aa31b	preparedness	готовность	noun	Show preparedness for the meeting	B2	audio/word_preparedness_5717d65e.mp3	priˈpɛrədnəs	\N
4452b0a8-283e-4bec-b456-37ad01a2fb6e	efficiently	эффективно	adverb	Work efficiently in meetings	B1	audio/word_efficiently_47af3a15.mp3	ɪˈfɪʃəntli	\N
530b1987-55fb-4a97-85b4-ba4506b8f615	presentation	презентация	noun	Give a presentation next week	B1	audio/word_presentation_5271a2de.mp3	ˌprɛzənˈteɪʃən	\N
f64aa5c9-2523-4389-ba94-7ac461950157	outline	структура	noun	Outline your project ideas	B1	audio/word_outline_d31470a8.mp3	ˈaʊˌtlaɪn	\N
f30d865f-af7e-4343-9bbb-cfc62aa0165f	summarize	обобщить	verb	Summarize the key points	B2	audio/word_summarize_3b1f86ba.mp3	ˈsəmərˌaɪz	\N
e6a6d3f5-ec5f-44c5-99bb-26aa5f3c9fad	conclude	заключить	verb	Let's conclude the meeting	B2	audio/word_conclude_76f86e47.mp3	kənˈklud	\N
e015508f-4c03-4927-b1af-d9804b3d05bb	clear up	разобраться	phrasal verb	Clear up confusion now	B2	audio/word_clear_up_a65407cf.mp3	klɪr əp	\N
afc263c5-34e0-4550-a688-0638aa63ae6c	bring up	затронуть	phrasal verb	Bring up this issue	B2	audio/word_bring_up_4d61a53e.mp3	brɪŋ əp	\N
683a3c8f-8ec8-4f02-9002-e4e13faae11a	on time	вовремя	phrase	Arrive on time for meetings	A2	audio/word_on_time_37f9e21d.mp3	ɔn taɪm	\N
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 6, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 1, false);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 5, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: chat_histories chat_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_histories
    ADD CONSTRAINT chat_histories_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: learned_words learned_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learned_words
    ADD CONSTRAINT learned_words_pkey PRIMARY KEY (id);


--
-- Name: link_tokens link_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link_tokens
    ADD CONSTRAINT link_tokens_pkey PRIMARY KEY (id);


--
-- Name: not_learned_words not_learned_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_learned_words
    ADD CONSTRAINT not_learned_words_pkey PRIMARY KEY (id);


--
-- Name: pick_options pick_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pick_options
    ADD CONSTRAINT pick_options_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: sentences sentences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: link_tokens uni_link_tokens_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link_tokens
    ADD CONSTRAINT uni_link_tokens_token UNIQUE (token);


--
-- Name: refresh_tokens uni_refresh_tokens_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT uni_refresh_tokens_token UNIQUE (token);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: idx_chat_histories_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chat_histories_user_id ON public.chat_histories USING btree (user_id);


--
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- Name: idx_topics_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_topics_parent_id ON public.topics USING btree (parent_id);


--
-- Name: idx_topics_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_topics_title ON public.topics USING btree (title);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_telegram_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_users_telegram_id ON public.users USING btree (telegram_id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: learned_words fk_learned_words_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learned_words
    ADD CONSTRAINT fk_learned_words_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: learned_words fk_learned_words_word; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learned_words
    ADD CONSTRAINT fk_learned_words_word FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: not_learned_words fk_not_learned_words_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_learned_words
    ADD CONSTRAINT fk_not_learned_words_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: not_learned_words fk_not_learned_words_word; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_learned_words
    ADD CONSTRAINT fk_not_learned_words_word FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: user_preferences fk_users_pref; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT fk_users_pref FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: sentences fk_words_sentences; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT fk_words_sentences FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: words fk_words_topic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT fk_words_topic FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

