--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

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
-- Name: action; Type: TYPE; Schema: public; Owner: user1
--

CREATE TYPE public.action AS ENUM (
    'enter',
    'exit'
);


ALTER TYPE public.action OWNER TO user1;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: entry_and_exit_records; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.entry_and_exit_records (
    record_id integer NOT NULL,
    student_id integer NOT NULL,
    action_attr public.action,
    timestamp_attr timestamp without time zone
);


ALTER TABLE public.entry_and_exit_records OWNER TO user1;

--
-- Name: students; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    name text
);


ALTER TABLE public.students OWNER TO user1;

--
-- Data for Name: entry_and_exit_records; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.entry_and_exit_records (record_id, student_id, action_attr, timestamp_attr) FROM stdin;
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.students (student_id, name) FROM stdin;
\.


--
-- Name: entry_and_exit_records entry_and_exit_records_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.entry_and_exit_records
    ADD CONSTRAINT entry_and_exit_records_pkey PRIMARY KEY (record_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: entry_and_exit_records entry_and_exit_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.entry_and_exit_records
    ADD CONSTRAINT entry_and_exit_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- PostgreSQL database dump complete
--

