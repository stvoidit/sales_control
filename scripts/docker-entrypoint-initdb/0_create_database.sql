--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2 (Ubuntu 16.2-1.pgdg22.04+1)

-- Started on 2024-03-21 19:01:37 MSK

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
-- TOC entry 3477 (class 1262 OID 16384)
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

--
-- TOC entry 229 (class 1255 OID 16559)
-- Name: save_price_history(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.save_price_history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO public.prices_history
        (product_id, price, price_date)
        VALUES(OLD.product_id,OLD.price, COALESCE(OLD.updated, now()));
        RETURN NEW;
    END;
$$;


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
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE appointments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.appointments IS 'Таблица связей / привязок';


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN appointments.login_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.appointments.login_id IS 'ID пользователя';


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN appointments.saler_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.appointments.saler_id IS 'ID продавца';


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN appointments.retail_outlet_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.appointments.retail_outlet_id IS 'ID торговой точки';


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
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 222
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- TOC entry 227 (class 1259 OID 16539)
-- Name: prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prices (
    product_id integer NOT NULL,
    price numeric(1000,2) DEFAULT 0 NOT NULL,
    updated timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16553)
-- Name: prices_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prices_history (
    product_id integer NOT NULL,
    price numeric(1000,2) NOT NULL,
    price_date timestamp with time zone NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16532)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    label text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    articul text NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16531)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 225
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


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
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE reports; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.reports IS 'Ежедневные отчеты';


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN reports.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reports.user_id IS 'ID пользователя, который внес запись';


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN reports.saler_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reports.saler_id IS 'ID продавца';


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN reports.retail_outlet_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reports.retail_outlet_id IS 'ID торговой точки';


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN reports.report_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reports.report_date IS 'Дата отчета';


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN reports.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reports.created IS 'Дата и время внесение записи';


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
-- TOC entry 3490 (class 0 OID 0)
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
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE retail_outlets; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.retail_outlets IS 'Торговые точки';


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN retail_outlets.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.retail_outlets.label IS 'название';


--
-- TOC entry 3493 (class 0 OID 0)
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
-- TOC entry 3494 (class 0 OID 0)
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
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE salers; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.salers IS 'Продавцы';


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN salers.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.salers.label IS 'Название продавца';


--
-- TOC entry 3497 (class 0 OID 0)
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
-- TOC entry 3498 (class 0 OID 0)
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
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.users IS 'Пользователи';


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.login IS 'Логин';


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.password IS 'Пароль в bcrypt';


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.name IS 'Имя';


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.address IS 'Адрес';


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.created IS 'Дата создания';


--
-- TOC entry 3505 (class 0 OID 0)
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
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3290 (class 2604 OID 16448)
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16535)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 16465)
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16420)
-- Name: retail_outlets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlets ALTER COLUMN id SET DEFAULT nextval('public.retail_outlets_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 16402)
-- Name: salers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers ALTER COLUMN id SET DEFAULT nextval('public.salers_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 16403)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3309 (class 2606 OID 16454)
-- Name: appointments appointments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pk PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 16446)
-- Name: appointments appointments_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_unique UNIQUE (login_id, saler_id, retail_outlet_id);


--
-- TOC entry 3319 (class 2606 OID 16547)
-- Name: prices prices_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_unique UNIQUE (product_id);


--
-- TOC entry 3317 (class 2606 OID 16545)
-- Name: products products_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pk PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 16513)
-- Name: reports reports_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pk PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 16515)
-- Name: reports reports_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_unique UNIQUE (saler_id, retail_outlet_id, report_date);


--
-- TOC entry 3307 (class 2606 OID 16439)
-- Name: retail_outlets retail_outlets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlets
    ADD CONSTRAINT retail_outlets_pk PRIMARY KEY (id);


--
-- TOC entry 3299 (class 2606 OID 16405)
-- Name: salers salers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_pk PRIMARY KEY (id);


--
-- TOC entry 3301 (class 2606 OID 16407)
-- Name: salers salers_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salers
    ADD CONSTRAINT salers_unique UNIQUE (label);


--
-- TOC entry 3303 (class 2606 OID 16409)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 16411)
-- Name: users users_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique UNIQUE (login);


--
-- TOC entry 3328 (class 2620 OID 16560)
-- Name: prices trigger_save_history; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_save_history AFTER UPDATE ON public.prices FOR EACH ROW EXECUTE FUNCTION public.save_price_history();


--
-- TOC entry 3320 (class 2606 OID 16440)
-- Name: appointments appointments_retail_outlets_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_retail_outlets_fk FOREIGN KEY (retail_outlet_id) REFERENCES public.retail_outlets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3321 (class 2606 OID 16455)
-- Name: appointments appointments_salers_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_salers_fk FOREIGN KEY (saler_id) REFERENCES public.salers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3322 (class 2606 OID 16428)
-- Name: appointments appointments_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_users_fk FOREIGN KEY (login_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3327 (class 2606 OID 16561)
-- Name: prices_history prices_history_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices_history
    ADD CONSTRAINT prices_history_products_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3326 (class 2606 OID 16548)
-- Name: prices prices_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_products_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3323 (class 2606 OID 16526)
-- Name: reports reports_retail_outlets_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_retail_outlets_fk FOREIGN KEY (retail_outlet_id) REFERENCES public.retail_outlets(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3324 (class 2606 OID 16521)
-- Name: reports reports_salers_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_salers_fk FOREIGN KEY (saler_id) REFERENCES public.salers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3325 (class 2606 OID 16516)
-- Name: reports reports_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2024-03-21 19:01:37 MSK

--
-- PostgreSQL database dump complete
--

