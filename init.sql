--
-- PostgreSQL database dump
--

-- Dumped from database version 10.19
-- Dumped by pg_dump version 10.19






CREATE USER postgres WITH PASSWORD 'postgres';
GRANT ALL PRIVILEGES ON DATABASE postgres to postgres


   





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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.routes (
    id integer NOT NULL,
    bus_number character varying(55) NOT NULL
);


ALTER TABLE public.routes OWNER TO postgres;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.routes_id_seq OWNER TO postgres;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.routes_id_seq OWNED BY public.routes.id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    id integer NOT NULL,
    route_id integer,
    stop_id integer,
    "time" time without time zone NOT NULL
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_id_seq OWNER TO postgres;

--
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_id_seq OWNED BY public.schedule.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stops (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.stops OWNER TO postgres;

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stops_id_seq OWNER TO postgres;

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stops_id_seq OWNED BY public.stops.id;


--
-- Name: way; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.way (
    id integer NOT NULL,
    routes_id integer NOT NULL,
    stops_id integer NOT NULL,
    route_order integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.way OWNER TO postgres;

--
-- Name: routes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes ALTER COLUMN id SET DEFAULT nextval('public.routes_id_seq'::regclass);


--
-- Name: schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN id SET DEFAULT nextval('public.schedule_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stops ALTER COLUMN id SET DEFAULT nextval('public.stops_id_seq'::regclass);


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.routes VALUES (1, 'A1');
INSERT INTO public.routes VALUES (2, 'B2');
INSERT INTO public.routes VALUES (3, 'C3');
INSERT INTO public.routes VALUES (4, 'A1(обратный)');
INSERT INTO public.routes VALUES (5, 'A2(обратный)');
INSERT INTO public.routes VALUES (6, 'A3(обратный)');


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.schedule VALUES (1, 1, 1, '08:00:00');
INSERT INTO public.schedule VALUES (2, 1, 2, '08:05:00');
INSERT INTO public.schedule VALUES (3, 1, 3, '08:10:00');
INSERT INTO public.schedule VALUES (4, 2, 2, '08:15:00');
INSERT INTO public.schedule VALUES (5, 2, 3, '08:20:00');
INSERT INTO public.schedule VALUES (6, 2, 4, '08:25:00');
INSERT INTO public.schedule VALUES (7, 3, 3, '08:25:00');
INSERT INTO public.schedule VALUES (8, 3, 5, '08:30:00');
INSERT INTO public.schedule VALUES (9, 3, 6, '08:35:00');
INSERT INTO public.schedule VALUES (13, 1, 1, '08:15:00');
INSERT INTO public.schedule VALUES (14, 1, 1, '08:30:00');
INSERT INTO public.schedule VALUES (15, 1, 2, '08:20:00');
INSERT INTO public.schedule VALUES (16, 1, 2, '08:35:00');
INSERT INTO public.schedule VALUES (17, 1, 3, '08:25:00');
INSERT INTO public.schedule VALUES (18, 1, 3, '08:40:00');
INSERT INTO public.schedule VALUES (19, 2, 2, '08:30:00');
INSERT INTO public.schedule VALUES (20, 2, 2, '08:45:00');
INSERT INTO public.schedule VALUES (21, 2, 3, '08:35:00');
INSERT INTO public.schedule VALUES (22, 2, 3, '08:50:00');
INSERT INTO public.schedule VALUES (23, 2, 4, '08:40:00');
INSERT INTO public.schedule VALUES (24, 2, 4, '08:55:00');
INSERT INTO public.schedule VALUES (25, 3, 3, '08:40:00');
INSERT INTO public.schedule VALUES (26, 3, 3, '08:55:00');
INSERT INTO public.schedule VALUES (27, 3, 5, '08:45:00');
INSERT INTO public.schedule VALUES (28, 3, 5, '09:00:00');
INSERT INTO public.schedule VALUES (29, 4, 3, '09:30:00');
INSERT INTO public.schedule VALUES (30, 4, 3, '09:45:00');
INSERT INTO public.schedule VALUES (31, 4, 3, '10:00:00');
INSERT INTO public.schedule VALUES (32, 4, 2, '09:40:00');
INSERT INTO public.schedule VALUES (33, 4, 2, '09:55:00');
INSERT INTO public.schedule VALUES (34, 4, 2, '10:10:00');
INSERT INTO public.schedule VALUES (35, 4, 1, '09:50:00');
INSERT INTO public.schedule VALUES (36, 4, 1, '10:05:00');
INSERT INTO public.schedule VALUES (37, 4, 1, '10:20:00');
INSERT INTO public.schedule VALUES (38, 5, 4, '10:00:00');
INSERT INTO public.schedule VALUES (39, 5, 4, '10:15:00');
INSERT INTO public.schedule VALUES (40, 5, 4, '10:30:00');
INSERT INTO public.schedule VALUES (41, 5, 3, '10:10:00');
INSERT INTO public.schedule VALUES (42, 5, 3, '10:25:00');
INSERT INTO public.schedule VALUES (43, 5, 3, '10:40:00');
INSERT INTO public.schedule VALUES (44, 5, 2, '10:20:00');
INSERT INTO public.schedule VALUES (45, 5, 2, '10:35:00');
INSERT INTO public.schedule VALUES (46, 5, 2, '10:50:00');
INSERT INTO public.schedule VALUES (47, 6, 6, '10:20:00');
INSERT INTO public.schedule VALUES (48, 6, 6, '10:35:00');
INSERT INTO public.schedule VALUES (49, 6, 6, '10:50:00');
INSERT INTO public.schedule VALUES (50, 6, 5, '10:30:00');
INSERT INTO public.schedule VALUES (51, 6, 5, '10:45:00');
INSERT INTO public.schedule VALUES (52, 6, 5, '11:00:00');
INSERT INTO public.schedule VALUES (53, 6, 3, '11:40:00');
INSERT INTO public.schedule VALUES (54, 6, 3, '11:55:00');
INSERT INTO public.schedule VALUES (55, 6, 3, '12:10:00');
INSERT INTO public.schedule VALUES (56, 1, 1, '19:00:00');
INSERT INTO public.schedule VALUES (57, 1, 2, '19:05:00');
INSERT INTO public.schedule VALUES (58, 1, 3, '19:10:00');
INSERT INTO public.schedule VALUES (59, 2, 2, '19:15:00');
INSERT INTO public.schedule VALUES (60, 2, 3, '19:20:00');
INSERT INTO public.schedule VALUES (61, 2, 4, '19:25:00');
INSERT INTO public.schedule VALUES (62, 3, 3, '19:25:00');
INSERT INTO public.schedule VALUES (63, 3, 5, '19:30:00');
INSERT INTO public.schedule VALUES (64, 3, 6, '19:35:00');
INSERT INTO public.schedule VALUES (65, 1, 1, '19:15:00');
INSERT INTO public.schedule VALUES (66, 1, 1, '19:30:00');
INSERT INTO public.schedule VALUES (68, 1, 2, '19:35:00');
INSERT INTO public.schedule VALUES (67, 1, 2, '19:20:00');
INSERT INTO public.schedule VALUES (69, 1, 3, '19:25:00');
INSERT INTO public.schedule VALUES (70, 1, 3, '19:40:00');
INSERT INTO public.schedule VALUES (71, 2, 2, '19:30:00');
INSERT INTO public.schedule VALUES (72, 2, 2, '19:45:00');
INSERT INTO public.schedule VALUES (73, 2, 3, '19:35:00');
INSERT INTO public.schedule VALUES (74, 2, 3, '19:50:00');
INSERT INTO public.schedule VALUES (75, 2, 4, '19:40:00');
INSERT INTO public.schedule VALUES (76, 2, 4, '19:55:00');
INSERT INTO public.schedule VALUES (77, 3, 3, '19:40:00');
INSERT INTO public.schedule VALUES (78, 3, 3, '19:55:00');
INSERT INTO public.schedule VALUES (79, 3, 5, '19:45:00');
INSERT INTO public.schedule VALUES (80, 3, 5, '20:00:00');
INSERT INTO public.schedule VALUES (81, 4, 3, '20:30:00');
INSERT INTO public.schedule VALUES (82, 4, 3, '20:45:00');
INSERT INTO public.schedule VALUES (83, 4, 3, '21:00:00');
INSERT INTO public.schedule VALUES (84, 4, 2, '20:40:00');
INSERT INTO public.schedule VALUES (85, 4, 2, '20:55:00');
INSERT INTO public.schedule VALUES (86, 4, 2, '21:10:00');
INSERT INTO public.schedule VALUES (87, 4, 1, '20:50:00');
INSERT INTO public.schedule VALUES (88, 4, 1, '21:05:00');
INSERT INTO public.schedule VALUES (89, 4, 1, '21:20:00');
INSERT INTO public.schedule VALUES (90, 5, 4, '21:00:00');
INSERT INTO public.schedule VALUES (91, 5, 4, '21:15:00');
INSERT INTO public.schedule VALUES (92, 5, 4, '21:30:00');
INSERT INTO public.schedule VALUES (93, 5, 3, '21:10:00');
INSERT INTO public.schedule VALUES (94, 5, 3, '21:25:00');
INSERT INTO public.schedule VALUES (95, 5, 3, '21:40:00');
INSERT INTO public.schedule VALUES (96, 5, 2, '21:20:00');
INSERT INTO public.schedule VALUES (97, 5, 2, '21:35:00');
INSERT INTO public.schedule VALUES (98, 5, 2, '21:50:00');
INSERT INTO public.schedule VALUES (99, 6, 6, '21:20:00');
INSERT INTO public.schedule VALUES (100, 6, 6, '21:35:00');
INSERT INTO public.schedule VALUES (101, 6, 6, '21:50:00');
INSERT INTO public.schedule VALUES (102, 6, 5, '21:30:00');
INSERT INTO public.schedule VALUES (103, 6, 5, '21:45:00');
INSERT INTO public.schedule VALUES (104, 6, 5, '22:00:00');
INSERT INTO public.schedule VALUES (105, 6, 3, '22:40:00');
INSERT INTO public.schedule VALUES (106, 6, 3, '22:55:00');
INSERT INTO public.schedule VALUES (107, 6, 3, '23:10:00');



--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stops VALUES (1, 'Остановка 1');
INSERT INTO public.stops VALUES (2, 'Остановка 2');
INSERT INTO public.stops VALUES (3, 'Остановка 3');
INSERT INTO public.stops VALUES (4, 'Остановка 4');
INSERT INTO public.stops VALUES (5, 'Остановка 5');
INSERT INTO public.stops VALUES (6, 'Остановка 6');


--
-- Data for Name: way; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.way VALUES (11, 5, 3, 2, 'маршрут 2(обратный)');
INSERT INTO public.way VALUES (12, 5, 2, 3, 'маршрут 2(обратный)');
INSERT INTO public.way VALUES (13, 3, 3, 1, 'маршрут 3');
INSERT INTO public.way VALUES (14, 3, 5, 2, 'маршрут 3');
INSERT INTO public.way VALUES (15, 3, 6, 3, 'маршрут 3');
INSERT INTO public.way VALUES (16, 6, 6, 1, 'маршрут 3(обратный)');
INSERT INTO public.way VALUES (17, 6, 5, 2, 'маршрут 3(обратный)');
INSERT INTO public.way VALUES (18, 6, 3, 3, 'маршрут 3(обратный)');
INSERT INTO public.way VALUES (2, 1, 2, 2, 'маршрут 1');
INSERT INTO public.way VALUES (1, 1, 1, 1, 'маршрут 1');
INSERT INTO public.way VALUES (3, 1, 3, 3, 'маршрут 1');
INSERT INTO public.way VALUES (4, 4, 3, 1, 'маршрут 1(обратный)');
INSERT INTO public.way VALUES (5, 4, 2, 2, 'маршрут 1(обратный)');
INSERT INTO public.way VALUES (6, 4, 1, 3, 'маршрут 1(обратный)');
INSERT INTO public.way VALUES (7, 2, 2, 1, 'маршрут 2');
INSERT INTO public.way VALUES (8, 2, 3, 2, 'маршрут 2');
INSERT INTO public.way VALUES (9, 2, 4, 3, 'маршрут 2');
INSERT INTO public.way VALUES (10, 5, 4, 1, 'маршрут 2(обратный)');


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.routes_id_seq', 7, true);


--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_id_seq', 55, true);


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stops_id_seq', 6, true);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: way way_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.way
    ADD CONSTRAINT way_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id);


--
-- Name: schedule schedule_stop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_stop_id_fkey FOREIGN KEY (stop_id) REFERENCES public.stops(id);


--
-- Name: way way_routes_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.way
    ADD CONSTRAINT way_routes_id_fkey FOREIGN KEY (routes_id) REFERENCES public.routes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: way way_stops_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.way
    ADD CONSTRAINT way_stops_id_fkey FOREIGN KEY (stops_id) REFERENCES public.stops(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

