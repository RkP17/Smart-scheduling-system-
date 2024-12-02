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

--
-- Name: weekday; Type: TYPE; Schema: public; Owner: user1
--

CREATE TYPE public.weekday AS ENUM (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);


ALTER TYPE public.weekday OWNER TO user1;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chore; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.chore (
    chore_id integer NOT NULL,
    student_id integer NOT NULL,
    chore_name text,
    weekday_attr public.weekday,
    suggested_time time without time zone
);


ALTER TABLE public.chore OWNER TO user1;

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
-- Name: probability_home; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.probability_home (
    probability_id integer NOT NULL,
    student_id integer NOT NULL,
    weekday_attr public.weekday,
    timeslot_start time without time zone,
    slot_counter integer,
    probability numeric(6,5)
);


ALTER TABLE public.probability_home OWNER TO user1;

--
-- Name: students; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    name text
);


ALTER TABLE public.students OWNER TO user1;

--
-- Data for Name: chore; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.chore (chore_id, student_id, chore_name, weekday_attr, suggested_time) FROM stdin;
0	0	vacuum	Tuesday	11:00:00
1	1	clean counter	Tuesday	13:00:00
2	2	bins	Tuesday	18:00:00
3	3	dishes	Tuesday	13:00:00
4	4	clean bathroom	Tuesday	14:00:00
5	3	vacuum	Wednesday	16:00:00
6	2	clean counter	Wednesday	13:00:00
7	0	laundry	Wednesday	19:30:00
8	1	dishes	Wednesday	18:00:00
9	0	clean bathroom	Wednesday	14:00:00
\.


--
-- Data for Name: entry_and_exit_records; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.entry_and_exit_records (record_id, student_id, action_attr, timestamp_attr) FROM stdin;
1	0	exit	2024-11-18 07:30:00
2	0	enter	2024-11-18 19:00:00
3	1	exit	2024-11-18 07:30:00
4	1	enter	2024-11-18 19:00:00
5	2	exit	2024-11-18 07:30:00
6	2	enter	2024-11-18 12:00:00
7	2	exit	2024-11-18 14:00:00
8	2	enter	2024-11-18 17:00:00
9	2	exit	2024-11-18 20:00:00
10	2	enter	2024-11-18 23:59:00
11	3	exit	2024-11-18 07:30:00
12	3	enter	2024-11-18 12:00:00
13	3	exit	2024-11-18 14:00:00
14	3	enter	2024-11-18 17:00:00
15	3	exit	2024-11-18 20:00:00
16	3	enter	2024-11-18 23:59:00
17	4	exit	2024-11-18 07:30:00
18	4	enter	2024-11-18 12:00:00
19	4	exit	2024-11-18 14:00:00
20	4	enter	2024-11-18 17:00:00
21	0	exit	2024-11-19 07:30:00
22	0	enter	2024-11-19 19:00:00
23	1	exit	2024-11-19 08:30:00
24	1	enter	2024-11-19 12:00:00
25	1	exit	2024-11-19 14:00:00
26	1	enter	2024-11-19 17:00:00
27	2	exit	2024-11-19 08:30:00
28	2	enter	2024-11-19 12:00:00
29	2	exit	2024-11-19 14:00:00
30	2	enter	2024-11-19 17:00:00
31	2	exit	2024-11-19 20:00:00
32	2	enter	2024-11-19 23:59:00
33	3	exit	2024-11-19 08:30:00
34	3	enter	2024-11-19 12:00:00
35	3	exit	2024-11-19 14:00:00
36	3	enter	2024-11-19 17:00:00
37	4	exit	2024-11-19 08:30:00
38	4	enter	2024-11-19 12:00:00
39	4	exit	2024-11-19 14:00:00
40	4	enter	2024-11-19 17:00:00
41	0	exit	2024-11-20 08:30:00
42	0	enter	2024-11-20 12:00:00
43	0	exit	2024-11-20 14:00:00
44	0	enter	2024-11-20 17:00:00
45	0	exit	2024-11-20 20:00:00
46	0	enter	2024-11-20 23:59:00
47	1	exit	2024-11-20 07:30:00
48	1	enter	2024-11-20 17:00:00
49	2	exit	2024-11-20 08:30:00
50	2	enter	2024-11-20 12:00:00
51	2	exit	2024-11-20 14:00:00
52	2	enter	2024-11-20 19:00:00
53	3	exit	2024-11-20 08:30:00
54	3	enter	2024-11-20 12:00:00
55	3	exit	2024-11-20 14:00:00
56	3	enter	2024-11-20 17:00:00
57	4	exit	2024-11-20 07:30:00
58	4	enter	2024-11-20 17:00:00
59	4	exit	2024-11-20 20:00:00
60	4	enter	2024-11-20 23:59:00
61	0	exit	2024-11-21 08:30:00
62	0	enter	2024-11-21 12:00:00
63	0	exit	2024-11-21 14:00:00
64	0	enter	2024-11-21 19:00:00
65	1	exit	2024-11-21 08:30:00
66	1	enter	2024-11-21 12:00:00
67	1	exit	2024-11-21 14:00:00
68	1	enter	2024-11-21 17:00:00
69	2	exit	2024-11-21 07:30:00
70	2	enter	2024-11-21 17:00:00
71	3	exit	2024-11-21 07:30:00
72	3	enter	2024-11-21 17:00:00
73	4	exit	2024-11-21 08:30:00
74	4	enter	2024-11-21 19:00:00
75	0	exit	2024-11-22 07:30:00
76	0	enter	2024-11-22 19:00:00
77	1	exit	2024-11-22 08:30:00
78	1	enter	2024-11-22 12:00:00
79	1	exit	2024-11-22 14:00:00
80	1	enter	2024-11-22 17:00:00
81	2	exit	2024-11-22 07:30:00
82	2	enter	2024-11-22 17:00:00
83	3	exit	2024-11-22 07:30:00
84	3	enter	2024-11-22 17:00:00
85	4	exit	2024-11-22 08:30:00
86	4	enter	2024-11-22 17:00:00
87	0	exit	2024-11-23 08:30:00
88	0	enter	2024-11-23 12:00:00
89	0	exit	2024-11-23 14:00:00
90	0	enter	2024-11-23 19:00:00
91	0	exit	2024-11-23 20:00:00
92	0	enter	2024-11-23 23:59:00
93	1	exit	2024-11-23 07:30:00
94	1	enter	2024-11-23 12:00:00
95	1	exit	2024-11-23 14:00:00
96	1	enter	2024-11-23 17:00:00
97	2	exit	2024-11-23 07:30:00
98	2	enter	2024-11-23 12:00:00
99	2	exit	2024-11-23 14:00:00
100	2	enter	2024-11-23 19:00:00
101	2	exit	2024-11-23 20:00:00
102	2	enter	2024-11-23 23:59:00
103	3	exit	2024-11-23 08:30:00
104	3	enter	2024-11-23 17:00:00
105	4	exit	2024-11-23 08:30:00
106	4	enter	2024-11-23 17:00:00
107	0	exit	2024-11-24 07:30:00
108	0	enter	2024-11-24 12:00:00
109	0	exit	2024-11-24 14:00:00
110	0	enter	2024-11-24 17:00:00
111	1	exit	2024-11-24 08:30:00
112	1	enter	2024-11-24 17:00:00
113	2	exit	2024-11-24 07:30:00
114	2	enter	2024-11-24 12:00:00
115	2	exit	2024-11-24 14:00:00
116	2	enter	2024-11-24 19:00:00
117	3	exit	2024-11-24 08:30:00
118	3	enter	2024-11-24 17:00:00
119	4	exit	2024-11-24 07:30:00
120	4	enter	2024-11-24 19:00:00
121	0	exit	2024-11-25 07:30:00
122	0	enter	2024-11-25 17:00:00
123	1	exit	2024-11-25 08:30:00
124	1	enter	2024-11-25 12:00:00
125	1	exit	2024-11-25 14:00:00
126	1	enter	2024-11-25 17:00:00
127	2	exit	2024-11-25 07:30:00
128	2	enter	2024-11-25 17:00:00
129	2	exit	2024-11-25 20:00:00
130	2	enter	2024-11-25 23:59:00
131	3	exit	2024-11-25 07:30:00
132	3	enter	2024-11-25 19:00:00
133	4	exit	2024-11-25 07:30:00
134	4	enter	2024-11-25 12:00:00
135	4	exit	2024-11-25 14:00:00
136	4	enter	2024-11-25 17:00:00
137	0	exit	2024-11-26 07:30:00
138	0	enter	2024-11-26 12:00:00
139	0	exit	2024-11-26 14:00:00
140	0	enter	2024-11-26 17:00:00
141	1	exit	2024-11-26 08:30:00
142	1	enter	2024-11-26 17:00:00
143	2	exit	2024-11-26 08:30:00
144	2	enter	2024-11-26 17:00:00
145	2	exit	2024-11-26 20:00:00
146	2	enter	2024-11-26 23:59:00
147	3	exit	2024-11-26 07:30:00
148	3	enter	2024-11-26 19:00:00
149	4	exit	2024-11-26 08:30:00
150	4	enter	2024-11-26 17:00:00
151	4	exit	2024-11-26 20:00:00
152	4	enter	2024-11-26 23:59:00
153	0	exit	2024-11-27 07:30:00
154	0	enter	2024-11-27 12:00:00
155	0	exit	2024-11-27 14:00:00
156	0	enter	2024-11-27 19:00:00
157	0	exit	2024-11-27 20:00:00
158	0	enter	2024-11-27 23:59:00
159	1	exit	2024-11-27 08:30:00
160	1	enter	2024-11-27 17:00:00
161	2	exit	2024-11-27 07:30:00
162	2	enter	2024-11-27 19:00:00
163	3	exit	2024-11-27 08:30:00
164	3	enter	2024-11-27 19:00:00
165	4	exit	2024-11-27 08:30:00
166	4	enter	2024-11-27 19:00:00
167	0	exit	2024-11-28 07:30:00
168	0	enter	2024-11-28 12:00:00
169	0	exit	2024-11-28 14:00:00
170	0	enter	2024-11-28 19:00:00
171	1	exit	2024-11-28 08:30:00
172	1	enter	2024-11-28 17:00:00
173	2	exit	2024-11-28 07:30:00
174	2	enter	2024-11-28 12:00:00
175	2	exit	2024-11-28 14:00:00
176	2	enter	2024-11-28 19:00:00
177	2	exit	2024-11-28 20:00:00
178	2	enter	2024-11-28 23:59:00
179	3	exit	2024-11-28 07:30:00
180	3	enter	2024-11-28 17:00:00
181	4	exit	2024-11-28 07:30:00
182	4	enter	2024-11-28 12:00:00
183	4	exit	2024-11-28 14:00:00
184	4	enter	2024-11-28 17:00:00
185	4	exit	2024-11-28 20:00:00
186	4	enter	2024-11-28 23:59:00
187	0	exit	2024-11-29 07:30:00
188	0	enter	2024-11-29 19:00:00
189	0	exit	2024-11-29 20:00:00
190	0	enter	2024-11-29 23:59:00
191	1	exit	2024-11-29 08:30:00
192	1	enter	2024-11-29 12:00:00
193	1	exit	2024-11-29 14:00:00
194	1	enter	2024-11-29 19:00:00
195	2	exit	2024-11-29 07:30:00
196	2	enter	2024-11-29 19:00:00
197	3	exit	2024-11-29 08:30:00
198	3	enter	2024-11-29 12:00:00
199	3	exit	2024-11-29 14:00:00
200	3	enter	2024-11-29 17:00:00
201	3	exit	2024-11-29 20:00:00
202	3	enter	2024-11-29 23:59:00
203	4	exit	2024-11-29 08:30:00
204	4	enter	2024-11-29 19:00:00
205	0	exit	2024-11-30 07:30:00
206	0	enter	2024-11-30 19:00:00
207	0	exit	2024-11-30 20:00:00
208	0	enter	2024-11-30 23:59:00
209	1	exit	2024-11-30 07:30:00
210	1	enter	2024-11-30 17:00:00
211	2	exit	2024-11-30 07:30:00
212	2	enter	2024-11-30 12:00:00
213	2	exit	2024-11-30 14:00:00
214	2	enter	2024-11-30 19:00:00
215	3	exit	2024-11-30 07:30:00
216	3	enter	2024-11-30 17:00:00
217	3	exit	2024-11-30 20:00:00
218	3	enter	2024-11-30 23:59:00
219	4	exit	2024-11-30 07:30:00
220	4	enter	2024-11-30 19:00:00
221	4	exit	2024-11-30 20:00:00
222	4	enter	2024-11-30 23:59:00
223	0	exit	2024-12-01 07:30:00
224	0	enter	2024-12-01 19:00:00
225	1	exit	2024-12-01 07:30:00
226	1	enter	2024-12-01 12:00:00
227	1	exit	2024-12-01 14:00:00
228	1	enter	2024-12-01 19:00:00
229	1	exit	2024-12-01 20:00:00
230	1	enter	2024-12-01 23:59:00
231	2	exit	2024-12-01 08:30:00
232	2	enter	2024-12-01 12:00:00
233	2	exit	2024-12-01 14:00:00
234	2	enter	2024-12-01 19:00:00
235	3	exit	2024-12-01 07:30:00
236	3	enter	2024-12-01 12:00:00
237	3	exit	2024-12-01 14:00:00
238	3	enter	2024-12-01 19:00:00
239	4	exit	2024-12-01 07:30:00
240	4	enter	2024-12-01 17:00:00
241	4	exit	2024-12-01 20:00:00
242	4	enter	2024-12-01 23:59:00
243	0	exit	2024-12-02 08:30:00
244	0	enter	2024-12-02 12:00:00
245	0	exit	2024-12-02 14:00:00
246	0	enter	2024-12-02 19:00:00
247	1	exit	2024-12-02 08:30:00
248	1	enter	2024-12-02 12:00:00
249	1	exit	2024-12-02 14:00:00
250	1	enter	2024-12-02 19:00:00
251	2	exit	2024-12-02 08:30:00
252	2	enter	2024-12-02 19:00:00
253	3	exit	2024-12-02 08:30:00
254	3	enter	2024-12-02 17:00:00
255	3	exit	2024-12-02 20:00:00
256	3	enter	2024-12-02 23:59:00
257	4	exit	2024-12-02 07:30:00
258	4	enter	2024-12-02 12:00:00
259	4	exit	2024-12-02 14:00:00
260	4	enter	2024-12-02 17:00:00
261	0	exit	2024-12-03 08:30:00
262	0	enter	2024-12-03 19:00:00
263	1	exit	2024-12-03 08:30:00
264	1	enter	2024-12-03 12:00:00
265	1	exit	2024-12-03 14:00:00
266	1	enter	2024-12-03 19:00:00
267	2	exit	2024-12-03 07:30:00
268	2	enter	2024-12-03 12:00:00
269	2	exit	2024-12-03 14:00:00
270	2	enter	2024-12-03 19:00:00
271	3	exit	2024-12-03 07:30:00
272	3	enter	2024-12-03 19:00:00
273	4	exit	2024-12-03 08:30:00
274	4	enter	2024-12-03 12:00:00
275	4	exit	2024-12-03 14:00:00
276	4	enter	2024-12-03 19:00:00
277	0	exit	2024-12-04 08:30:00
278	0	enter	2024-12-04 19:00:00
279	0	exit	2024-12-04 20:00:00
280	0	enter	2024-12-04 23:59:00
281	1	exit	2024-12-04 08:30:00
282	1	enter	2024-12-04 19:00:00
283	2	exit	2024-12-04 07:30:00
284	2	enter	2024-12-04 12:00:00
285	2	exit	2024-12-04 14:00:00
286	2	enter	2024-12-04 17:00:00
287	3	exit	2024-12-04 07:30:00
288	3	enter	2024-12-04 12:00:00
289	3	exit	2024-12-04 14:00:00
290	3	enter	2024-12-04 19:00:00
291	4	exit	2024-12-04 07:30:00
292	4	enter	2024-12-04 19:00:00
293	0	exit	2024-12-05 07:30:00
294	0	enter	2024-12-05 19:00:00
295	1	exit	2024-12-05 08:30:00
296	1	enter	2024-12-05 17:00:00
297	2	exit	2024-12-05 07:30:00
298	2	enter	2024-12-05 17:00:00
299	3	exit	2024-12-05 08:30:00
300	3	enter	2024-12-05 12:00:00
301	3	exit	2024-12-05 14:00:00
302	3	enter	2024-12-05 19:00:00
303	4	exit	2024-12-05 07:30:00
304	4	enter	2024-12-05 19:00:00
305	0	exit	2024-12-06 08:30:00
306	0	enter	2024-12-06 12:00:00
307	0	exit	2024-12-06 14:00:00
308	0	enter	2024-12-06 19:00:00
309	1	exit	2024-12-06 08:30:00
310	1	enter	2024-12-06 19:00:00
311	2	exit	2024-12-06 08:30:00
312	2	enter	2024-12-06 12:00:00
313	2	exit	2024-12-06 14:00:00
314	2	enter	2024-12-06 17:00:00
315	2	exit	2024-12-06 20:00:00
316	2	enter	2024-12-06 23:59:00
317	3	exit	2024-12-06 07:30:00
318	3	enter	2024-12-06 19:00:00
319	4	exit	2024-12-06 07:30:00
320	4	enter	2024-12-06 17:00:00
321	0	exit	2024-12-07 07:30:00
322	0	enter	2024-12-07 12:00:00
323	0	exit	2024-12-07 14:00:00
324	0	enter	2024-12-07 19:00:00
325	1	exit	2024-12-07 08:30:00
326	1	enter	2024-12-07 12:00:00
327	1	exit	2024-12-07 14:00:00
328	1	enter	2024-12-07 17:00:00
329	2	exit	2024-12-07 07:30:00
330	2	enter	2024-12-07 17:00:00
331	3	exit	2024-12-07 08:30:00
332	3	enter	2024-12-07 12:00:00
333	3	exit	2024-12-07 14:00:00
334	3	enter	2024-12-07 19:00:00
335	3	exit	2024-12-07 20:00:00
336	3	enter	2024-12-07 23:59:00
337	4	exit	2024-12-07 08:30:00
338	4	enter	2024-12-07 19:00:00
339	4	exit	2024-12-07 20:00:00
340	4	enter	2024-12-07 23:59:00
341	0	exit	2024-12-08 07:30:00
342	0	enter	2024-12-08 12:00:00
343	0	exit	2024-12-08 14:00:00
344	0	enter	2024-12-08 19:00:00
345	1	exit	2024-12-08 08:30:00
346	1	enter	2024-12-08 17:00:00
347	2	exit	2024-12-08 07:30:00
348	2	enter	2024-12-08 19:00:00
349	3	exit	2024-12-08 07:30:00
350	3	enter	2024-12-08 12:00:00
351	3	exit	2024-12-08 14:00:00
352	3	enter	2024-12-08 17:00:00
353	4	exit	2024-12-08 08:30:00
354	4	enter	2024-12-08 12:00:00
355	4	exit	2024-12-08 14:00:00
356	4	enter	2024-12-08 19:00:00
357	4	exit	2024-12-08 20:00:00
358	4	enter	2024-12-08 23:59:00
359	0	exit	2024-12-09 08:30:00
360	0	enter	2024-12-09 17:00:00
361	1	exit	2024-12-09 07:30:00
362	1	enter	2024-12-09 12:00:00
363	1	exit	2024-12-09 14:00:00
364	1	enter	2024-12-09 17:00:00
365	2	exit	2024-12-09 07:30:00
366	2	enter	2024-12-09 12:00:00
367	2	exit	2024-12-09 14:00:00
368	2	enter	2024-12-09 19:00:00
369	3	exit	2024-12-09 08:30:00
370	3	enter	2024-12-09 17:00:00
371	4	exit	2024-12-09 07:30:00
372	4	enter	2024-12-09 17:00:00
373	4	exit	2024-12-09 20:00:00
374	4	enter	2024-12-09 23:59:00
375	0	exit	2024-12-10 07:30:00
376	0	enter	2024-12-10 17:00:00
377	0	exit	2024-12-10 20:00:00
378	0	enter	2024-12-10 23:59:00
379	1	exit	2024-12-10 07:30:00
380	1	enter	2024-12-10 12:00:00
381	1	exit	2024-12-10 14:00:00
382	1	enter	2024-12-10 19:00:00
383	2	exit	2024-12-10 07:30:00
384	2	enter	2024-12-10 12:00:00
385	2	exit	2024-12-10 14:00:00
386	2	enter	2024-12-10 17:00:00
387	3	exit	2024-12-10 07:30:00
388	3	enter	2024-12-10 12:00:00
389	3	exit	2024-12-10 14:00:00
390	3	enter	2024-12-10 17:00:00
391	3	exit	2024-12-10 20:00:00
392	3	enter	2024-12-10 23:59:00
393	4	exit	2024-12-10 07:30:00
394	4	enter	2024-12-10 19:00:00
395	4	exit	2024-12-10 20:00:00
396	4	enter	2024-12-10 23:59:00
397	0	exit	2024-12-11 07:30:00
398	0	enter	2024-12-11 12:00:00
399	0	exit	2024-12-11 14:00:00
400	0	enter	2024-12-11 17:00:00
401	1	exit	2024-12-11 08:30:00
402	1	enter	2024-12-11 17:00:00
403	2	exit	2024-12-11 07:30:00
404	2	enter	2024-12-11 17:00:00
405	3	exit	2024-12-11 08:30:00
406	3	enter	2024-12-11 12:00:00
407	3	exit	2024-12-11 14:00:00
408	3	enter	2024-12-11 17:00:00
409	4	exit	2024-12-11 08:30:00
410	4	enter	2024-12-11 17:00:00
411	4	exit	2024-12-11 20:00:00
412	4	enter	2024-12-11 23:59:00
413	0	exit	2024-12-12 07:30:00
414	0	enter	2024-12-12 17:00:00
415	1	exit	2024-12-12 08:30:00
416	1	enter	2024-12-12 17:00:00
417	1	exit	2024-12-12 20:00:00
418	1	enter	2024-12-12 23:59:00
419	2	exit	2024-12-12 08:30:00
420	2	enter	2024-12-12 12:00:00
421	2	exit	2024-12-12 14:00:00
422	2	enter	2024-12-12 17:00:00
423	3	exit	2024-12-12 07:30:00
424	3	enter	2024-12-12 12:00:00
425	3	exit	2024-12-12 14:00:00
426	3	enter	2024-12-12 19:00:00
427	4	exit	2024-12-12 08:30:00
428	4	enter	2024-12-12 12:00:00
429	4	exit	2024-12-12 14:00:00
430	4	enter	2024-12-12 17:00:00
431	0	exit	2024-12-13 07:30:00
432	0	enter	2024-12-13 12:00:00
433	0	exit	2024-12-13 14:00:00
434	0	enter	2024-12-13 19:00:00
435	0	exit	2024-12-13 20:00:00
436	0	enter	2024-12-13 23:59:00
437	1	exit	2024-12-13 07:30:00
438	1	enter	2024-12-13 12:00:00
439	1	exit	2024-12-13 14:00:00
440	1	enter	2024-12-13 17:00:00
441	2	exit	2024-12-13 07:30:00
442	2	enter	2024-12-13 12:00:00
443	2	exit	2024-12-13 14:00:00
444	2	enter	2024-12-13 19:00:00
445	3	exit	2024-12-13 07:30:00
446	3	enter	2024-12-13 12:00:00
447	3	exit	2024-12-13 14:00:00
448	3	enter	2024-12-13 17:00:00
449	4	exit	2024-12-13 07:30:00
450	4	enter	2024-12-13 19:00:00
451	0	exit	2024-12-14 07:30:00
452	0	enter	2024-12-14 12:00:00
453	0	exit	2024-12-14 14:00:00
454	0	enter	2024-12-14 17:00:00
455	1	exit	2024-12-14 08:30:00
456	1	enter	2024-12-14 19:00:00
457	2	exit	2024-12-14 08:30:00
458	2	enter	2024-12-14 12:00:00
459	2	exit	2024-12-14 14:00:00
460	2	enter	2024-12-14 17:00:00
461	2	exit	2024-12-14 20:00:00
462	2	enter	2024-12-14 23:59:00
463	3	exit	2024-12-14 07:30:00
464	3	enter	2024-12-14 19:00:00
465	4	exit	2024-12-14 07:30:00
466	4	enter	2024-12-14 17:00:00
467	4	exit	2024-12-14 20:00:00
468	4	enter	2024-12-14 23:59:00
469	0	exit	2024-12-15 07:30:00
470	0	enter	2024-12-15 17:00:00
471	1	exit	2024-12-15 07:30:00
472	1	enter	2024-12-15 17:00:00
473	2	exit	2024-12-15 08:30:00
474	2	enter	2024-12-15 12:00:00
475	2	exit	2024-12-15 14:00:00
476	2	enter	2024-12-15 17:00:00
477	2	exit	2024-12-15 20:00:00
478	2	enter	2024-12-15 23:59:00
479	3	exit	2024-12-15 08:30:00
480	3	enter	2024-12-15 17:00:00
481	4	exit	2024-12-15 08:30:00
482	4	enter	2024-12-15 12:00:00
483	4	exit	2024-12-15 14:00:00
484	4	enter	2024-12-15 19:00:00
\.


--
-- Data for Name: probability_home; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.probability_home (probability_id, student_id, weekday_attr, timeslot_start, slot_counter, probability) FROM stdin;
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.students (student_id, name) FROM stdin;
0	John
1	Mary
2	Jesus
3	Joseph
4	Judas
\.


--
-- Name: chore chore_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.chore
    ADD CONSTRAINT chore_pkey PRIMARY KEY (chore_id);


--
-- Name: entry_and_exit_records entry_and_exit_records_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.entry_and_exit_records
    ADD CONSTRAINT entry_and_exit_records_pkey PRIMARY KEY (record_id);


--
-- Name: probability_home probability_home_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.probability_home
    ADD CONSTRAINT probability_home_pkey PRIMARY KEY (probability_id);


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
-- Name: probability_home probability_home_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.probability_home
    ADD CONSTRAINT probability_home_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- PostgreSQL database dump complete
--

