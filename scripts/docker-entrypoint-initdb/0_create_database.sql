--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2 (Ubuntu 16.2-1.pgdg22.04+1)

-- Started on 2024-03-16 22:14:57 MSK

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
-- TOC entry 3449 (class 1262 OID 16384)
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
-- TOC entry 221 (class 1259 OID 16425)
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    login_id integer,
    saler_id integer,
    retail_outlet_id integer,
    id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16447)
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 222
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- TOC entry 224 (class 1259 OID 16462)
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    user_id integer NOT NULL,
    saler_id integer NOT NULL,
    retail_outlet_id integer NOT NULL,
    report_date date NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    val numeric(1000,2) NOT NULL,
    bl numeric(1000,2) NOT NULL,
    nal numeric(1000,2) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16461)
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 223
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- TOC entry 220 (class 1259 OID 16417)
-- Name: retail_outlets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retail_outlets (
    id integer NOT NULL,
    label text NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN retail_outlets.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.retail_outlets.label IS 'название';


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN retail_outlets.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.retail_outlets.address IS 'адрес';


--
-- TOC entry 219 (class 1259 OID 16416)
-- Name: retail_outlets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.retail_outlets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 219
-- Name: retail_outlets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.retail_outlets_id_seq OWNED BY public.retail_outlets.id;


--
-- TOC entry 215 (class 1259 OID 16385)
-- Name: salers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salers (
    id integer NOT NULL,
    label text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    created timestamp with time zone DEFAULT now()
);


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN salers.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.salers.label IS 'Название продавца';


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN salers.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.salers.description IS 'Комментарий или описание, свободное поле';


--
-- TOC entry 216 (class 1259 OID 16392)
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
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 216
-- Name: salers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salers_id_seq OWNED BY public.salers.id;


--
-- TOC entry 217 (class 1259 OID 16393)
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
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.login IS 'Логин';


--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.password IS 'Пароль в bcrypt';


--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.name IS 'Имя';


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.address IS 'Адрес';


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.created IS 'Дата создания';


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.is_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.is_active IS 'Пользователь активен, может войти';


--
-- TOC entry 218 (class 1259 OID 16401)
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
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3276 (class 2604 OID 16448)
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 16465)
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 16420)
-- Name: retail_outlets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlets ALTER COLUMN id SET DEFAULT nextval('public.retail_outlets_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 16402)
-- Name: salers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers ALTER COLUMN id SET DEFAULT nextval('public.salers_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 16403)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3291 (class 2606 OID 16454)
-- Name: appointments appointments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pk PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 16446)
-- Name: appointments appointments_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_unique UNIQUE (login_id, saler_id, retail_outlet_id);


--
-- TOC entry 3295 (class 2606 OID 16513)
-- Name: reports reports_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pk PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 16515)
-- Name: reports reports_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_unique UNIQUE (saler_id, retail_outlet_id, report_date);


--
-- TOC entry 3289 (class 2606 OID 16439)
-- Name: retail_outlets retail_outlets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlets
    ADD CONSTRAINT retail_outlets_pk PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 16405)
-- Name: salers salers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_pk PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 16407)
-- Name: salers salers_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_unique UNIQUE (label);


--
-- TOC entry 3285 (class 2606 OID 16409)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 16411)
-- Name: users users_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique UNIQUE (login);


--
-- TOC entry 3298 (class 2606 OID 16440)
-- Name: appointments appointments_retail_outlets_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_retail_outlets_fk FOREIGN KEY (retail_outlet_id) REFERENCES public.retail_outlets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3299 (class 2606 OID 16455)
-- Name: appointments appointments_salers_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_salers_fk FOREIGN KEY (saler_id) REFERENCES public.salers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3300 (class 2606 OID 16428)
-- Name: appointments appointments_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_users_fk FOREIGN KEY (login_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-03-16 22:14:57 MSK

--
-- PostgreSQL database dump complete
--

