--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2 (Ubuntu 16.2-1.pgdg22.04+1)

-- Started on 2024-03-09 18:18:11 MSK

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

SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 3414 (class 1262 OID 16384)
-- Name: sales_control; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE sales_control WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru_RU.utf8';


\connect sales_control

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

SET SESSION AUTHORIZATION 'postgres';

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16404)
-- Name: salers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salers (
    id integer NOT NULL,
    label text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    created timestamp with time zone DEFAULT now()
);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN salers.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.salers.label IS 'Название продавца';


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN salers.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.salers.description IS 'Комментарий или описание, свободное поле';


--
-- TOC entry 217 (class 1259 OID 16403)
-- Name: salers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 217
-- Name: salers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salers_id_seq OWNED BY public.salers.id;


--
-- TOC entry 215 (class 1259 OID 16385)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.login IS 'Логин';


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.password IS 'Пароль в bcrypt';


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.name IS 'Имя';


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.address IS 'Адрес';


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.created IS 'Дата создания';


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN users.is_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.is_active IS 'Пользователь активен, может войти';


--
-- TOC entry 216 (class 1259 OID 16391)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3255 (class 2604 OID 16407)
-- Name: salers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers ALTER COLUMN id SET DEFAULT nextval('public.salers_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 16392)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3263 (class 2606 OID 16416)
-- Name: salers salers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_pk PRIMARY KEY (id);


--
-- TOC entry 3265 (class 2606 OID 16414)
-- Name: salers salers_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_unique UNIQUE (label);


--
-- TOC entry 3259 (class 2606 OID 16394)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 16401)
-- Name: users users_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique UNIQUE (login);


-- Completed on 2024-03-09 18:18:11 MSK

--
-- PostgreSQL database dump complete
--

