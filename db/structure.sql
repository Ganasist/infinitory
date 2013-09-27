--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departments (
    id integer NOT NULL,
    name character varying(255),
    institute_id integer,
    address text,
    longitude double precision,
    latitude double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    url character varying(255),
    gmaps boolean,
    city character varying(255),
    country character varying(255),
    room character varying(255)
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(40),
    scope character varying(255),
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: institutes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE institutes (
    id integer NOT NULL,
    name character varying(255),
    latitude double precision,
    longitude double precision,
    city character varying(255),
    address text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    alternate_name character varying(255),
    country character varying(255),
    rank integer,
    gmaps boolean,
    url character varying(255),
    acronym character varying(255),
    slug character varying(255),
    icon character varying(255),
    icon_processing boolean
);


--
-- Name: institutes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE institutes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institutes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE institutes_id_seq OWNED BY institutes.id;


--
-- Name: labs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE labs (
    id integer NOT NULL,
    department_id integer,
    institute_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    room character varying(255),
    email character varying(255),
    name character varying(255),
    url character varying(255),
    icon character varying(255),
    slug character varying(255)
);


--
-- Name: labs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labs_id_seq OWNED BY labs.id;


--
-- Name: reagents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reagents (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    location character varying(255),
    price numeric(9,2),
    serial character varying(255),
    quantity numeric(3,0),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    properties hstore
);


--
-- Name: reagents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reagents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reagents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE reagents_id_seq OWNED BY reagents.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    lab_id integer,
    first_name character varying(255),
    last_name character varying(255),
    role character varying(255),
    institute_id integer,
    department_id integer,
    superuser boolean DEFAULT false,
    description character varying(255),
    approved boolean DEFAULT false NOT NULL,
    icon character varying(255),
    joined timestamp without time zone,
    slug character varying(255),
    icon_processing boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY institutes ALTER COLUMN id SET DEFAULT nextval('institutes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY labs ALTER COLUMN id SET DEFAULT nextval('labs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY reagents ALTER COLUMN id SET DEFAULT nextval('reagents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: institutes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY institutes
    ADD CONSTRAINT institutes_pkey PRIMARY KEY (id);


--
-- Name: labs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labs
    ADD CONSTRAINT labs_pkey PRIMARY KEY (id);


--
-- Name: reagents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reagents
    ADD CONSTRAINT reagents_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_departments_on_institute_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departments_on_institute_id ON departments USING btree (institute_id);


--
-- Name: index_departments_on_latitude_and_longitude; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departments_on_latitude_and_longitude ON departments USING btree (latitude, longitude);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_institutes_on_latitude_and_longitude; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_institutes_on_latitude_and_longitude ON institutes USING btree (latitude, longitude);


--
-- Name: index_institutes_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_institutes_on_slug ON institutes USING btree (slug);


--
-- Name: index_labs_on_department_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_labs_on_department_id ON labs USING btree (department_id);


--
-- Name: index_labs_on_institute_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_labs_on_institute_id ON labs USING btree (institute_id);


--
-- Name: index_labs_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_labs_on_slug ON labs USING btree (slug);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_department_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_department_id ON users USING btree (department_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_institute_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_institute_id ON users USING btree (institute_id);


--
-- Name: index_users_on_lab_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_lab_id ON users USING btree (lab_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: institutes_acronym; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX institutes_acronym ON institutes USING gin (to_tsvector('english'::regconfig, (acronym)::text));


--
-- Name: institutes_alternate_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX institutes_alternate_name ON institutes USING gin (to_tsvector('english'::regconfig, (alternate_name)::text));


--
-- Name: institutes_city; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX institutes_city ON institutes USING gin (to_tsvector('english'::regconfig, (city)::text));


--
-- Name: institutes_country; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX institutes_country ON institutes USING gin (to_tsvector('english'::regconfig, (country)::text));


--
-- Name: institutes_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX institutes_name ON institutes USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: reagents_properties; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX reagents_properties ON reagents USING gin (properties);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130802104901');

INSERT INTO schema_migrations (version) VALUES ('20130802104958');

INSERT INTO schema_migrations (version) VALUES ('20130802120129');

INSERT INTO schema_migrations (version) VALUES ('20130802120228');

INSERT INTO schema_migrations (version) VALUES ('20130802202902');

INSERT INTO schema_migrations (version) VALUES ('20130803132749');

INSERT INTO schema_migrations (version) VALUES ('20130803150255');

INSERT INTO schema_migrations (version) VALUES ('20130803155925');

INSERT INTO schema_migrations (version) VALUES ('20130807170710');

INSERT INTO schema_migrations (version) VALUES ('20130808130547');

INSERT INTO schema_migrations (version) VALUES ('20130810113551');

INSERT INTO schema_migrations (version) VALUES ('20130810143521');

INSERT INTO schema_migrations (version) VALUES ('20130810145702');

INSERT INTO schema_migrations (version) VALUES ('20130810151750');

INSERT INTO schema_migrations (version) VALUES ('20130810152545');

INSERT INTO schema_migrations (version) VALUES ('20130811081046');

INSERT INTO schema_migrations (version) VALUES ('20130811081101');

INSERT INTO schema_migrations (version) VALUES ('20130811180934');

INSERT INTO schema_migrations (version) VALUES ('20130811181603');

INSERT INTO schema_migrations (version) VALUES ('20130811182617');

INSERT INTO schema_migrations (version) VALUES ('20130814140850');

INSERT INTO schema_migrations (version) VALUES ('20130815115146');

INSERT INTO schema_migrations (version) VALUES ('20130815115343');

INSERT INTO schema_migrations (version) VALUES ('20130818062638');

INSERT INTO schema_migrations (version) VALUES ('20130819170513');

INSERT INTO schema_migrations (version) VALUES ('20130820132442');

INSERT INTO schema_migrations (version) VALUES ('20130824123809');

INSERT INTO schema_migrations (version) VALUES ('20130826102244');

INSERT INTO schema_migrations (version) VALUES ('20130826103746');

INSERT INTO schema_migrations (version) VALUES ('20130826103935');

INSERT INTO schema_migrations (version) VALUES ('20130826113610');

INSERT INTO schema_migrations (version) VALUES ('20130826121114');

INSERT INTO schema_migrations (version) VALUES ('20130826121146');

INSERT INTO schema_migrations (version) VALUES ('20130826132437');

INSERT INTO schema_migrations (version) VALUES ('20130828121927');

INSERT INTO schema_migrations (version) VALUES ('20130828123548');

INSERT INTO schema_migrations (version) VALUES ('20130828164621');

INSERT INTO schema_migrations (version) VALUES ('20130828164843');

INSERT INTO schema_migrations (version) VALUES ('20130829100059');

INSERT INTO schema_migrations (version) VALUES ('20130829100550');

INSERT INTO schema_migrations (version) VALUES ('20130829104103');

INSERT INTO schema_migrations (version) VALUES ('20130829104130');

INSERT INTO schema_migrations (version) VALUES ('20130829105007');

INSERT INTO schema_migrations (version) VALUES ('20130829111151');

INSERT INTO schema_migrations (version) VALUES ('20130829111342');

INSERT INTO schema_migrations (version) VALUES ('20130829111533');

INSERT INTO schema_migrations (version) VALUES ('20130829112806');

INSERT INTO schema_migrations (version) VALUES ('20130829112849');

INSERT INTO schema_migrations (version) VALUES ('20130829113617');

INSERT INTO schema_migrations (version) VALUES ('20130829114053');

INSERT INTO schema_migrations (version) VALUES ('20130829115133');

INSERT INTO schema_migrations (version) VALUES ('20130829115804');

INSERT INTO schema_migrations (version) VALUES ('20130829115840');

INSERT INTO schema_migrations (version) VALUES ('20130830110229');

INSERT INTO schema_migrations (version) VALUES ('20130830110433');

INSERT INTO schema_migrations (version) VALUES ('20130830112314');

INSERT INTO schema_migrations (version) VALUES ('20130830112740');

INSERT INTO schema_migrations (version) VALUES ('20130830115149');

INSERT INTO schema_migrations (version) VALUES ('20130830115328');

INSERT INTO schema_migrations (version) VALUES ('20130830150044');

INSERT INTO schema_migrations (version) VALUES ('20130830160706');

INSERT INTO schema_migrations (version) VALUES ('20130830184019');

INSERT INTO schema_migrations (version) VALUES ('20130830184048');

INSERT INTO schema_migrations (version) VALUES ('20130830184956');

INSERT INTO schema_migrations (version) VALUES ('20130901163155');

INSERT INTO schema_migrations (version) VALUES ('20130902122214');

INSERT INTO schema_migrations (version) VALUES ('20130902133046');

INSERT INTO schema_migrations (version) VALUES ('20130902135004');

INSERT INTO schema_migrations (version) VALUES ('20130902142804');

INSERT INTO schema_migrations (version) VALUES ('20130904114356');

INSERT INTO schema_migrations (version) VALUES ('20130904114726');

INSERT INTO schema_migrations (version) VALUES ('20130904114814');

INSERT INTO schema_migrations (version) VALUES ('20130904114915');

INSERT INTO schema_migrations (version) VALUES ('20130904115301');

INSERT INTO schema_migrations (version) VALUES ('20130904125915');

INSERT INTO schema_migrations (version) VALUES ('20130904130054');

INSERT INTO schema_migrations (version) VALUES ('20130904171930');

INSERT INTO schema_migrations (version) VALUES ('20130905095116');

INSERT INTO schema_migrations (version) VALUES ('20130905130439');

INSERT INTO schema_migrations (version) VALUES ('20130907092716');

INSERT INTO schema_migrations (version) VALUES ('20130907123452');

INSERT INTO schema_migrations (version) VALUES ('20130909104315');

INSERT INTO schema_migrations (version) VALUES ('20130909154048');

INSERT INTO schema_migrations (version) VALUES ('20130913092657');

INSERT INTO schema_migrations (version) VALUES ('20130913172018');

INSERT INTO schema_migrations (version) VALUES ('20130916130901');

INSERT INTO schema_migrations (version) VALUES ('20130919115346');

INSERT INTO schema_migrations (version) VALUES ('20130923091226');

INSERT INTO schema_migrations (version) VALUES ('20130923091407');

INSERT INTO schema_migrations (version) VALUES ('20130924165346');

INSERT INTO schema_migrations (version) VALUES ('20130925094553');

INSERT INTO schema_migrations (version) VALUES ('20130925103037');

INSERT INTO schema_migrations (version) VALUES ('20130926105557');

INSERT INTO schema_migrations (version) VALUES ('20130927115941');

INSERT INTO schema_migrations (version) VALUES ('20130927123002');

INSERT INTO schema_migrations (version) VALUES ('20130927123936');

INSERT INTO schema_migrations (version) VALUES ('20130927124016');
