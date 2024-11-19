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
1	0	enter	2024-11-18 08:00:00
2	0	exit	2024-11-18 12:00:00
3	0	enter	2024-11-18 13:00:00
4	0	exit	2024-11-18 17:00:00
5	1	enter	2024-11-18 08:00:00
6	1	exit	2024-11-18 12:00:00
7	1	enter	2024-11-18 13:00:00
8	1	exit	2024-11-18 17:00:00
9	2	enter	2024-11-18 08:00:00
10	2	exit	2024-11-18 12:00:00
11	2	enter	2024-11-18 13:00:00
12	2	exit	2024-11-18 17:00:00
13	3	enter	2024-11-18 08:00:00
14	3	exit	2024-11-18 12:00:00
15	3	enter	2024-11-18 13:00:00
16	3	exit	2024-11-18 17:00:00
17	4	enter	2024-11-18 08:00:00
18	4	exit	2024-11-18 12:00:00
19	4	enter	2024-11-18 13:00:00
20	4	exit	2024-11-18 17:00:00
21	0	enter	2024-11-19 08:00:00
22	0	exit	2024-11-19 12:00:00
23	0	enter	2024-11-19 13:00:00
24	0	exit	2024-11-19 17:00:00
25	1	enter	2024-11-19 08:00:00
26	1	exit	2024-11-19 12:00:00
27	1	enter	2024-11-19 13:00:00
28	1	exit	2024-11-19 17:00:00
29	2	enter	2024-11-19 08:00:00
30	2	exit	2024-11-19 12:00:00
31	2	enter	2024-11-19 13:00:00
32	2	exit	2024-11-19 17:00:00
33	3	enter	2024-11-19 08:00:00
34	3	exit	2024-11-19 12:00:00
35	3	enter	2024-11-19 13:00:00
36	3	exit	2024-11-19 17:00:00
37	4	enter	2024-11-19 08:00:00
38	4	exit	2024-11-19 12:00:00
39	4	enter	2024-11-19 13:00:00
40	4	exit	2024-11-19 17:00:00
41	0	enter	2024-11-20 08:00:00
42	0	exit	2024-11-20 12:00:00
43	0	enter	2024-11-20 13:00:00
44	0	exit	2024-11-20 17:00:00
45	1	enter	2024-11-20 08:00:00
46	1	exit	2024-11-20 12:00:00
47	1	enter	2024-11-20 13:00:00
48	1	exit	2024-11-20 17:00:00
49	2	enter	2024-11-20 08:00:00
50	2	exit	2024-11-20 12:00:00
51	2	enter	2024-11-20 13:00:00
52	2	exit	2024-11-20 17:00:00
53	3	enter	2024-11-20 08:00:00
54	3	exit	2024-11-20 12:00:00
55	3	enter	2024-11-20 13:00:00
56	3	exit	2024-11-20 17:00:00
57	4	enter	2024-11-20 08:00:00
58	4	exit	2024-11-20 12:00:00
59	4	enter	2024-11-20 13:00:00
60	4	exit	2024-11-20 17:00:00
61	0	enter	2024-11-21 08:00:00
62	0	exit	2024-11-21 12:00:00
63	0	enter	2024-11-21 13:00:00
64	0	exit	2024-11-21 17:00:00
65	1	enter	2024-11-21 08:00:00
66	1	exit	2024-11-21 12:00:00
67	1	enter	2024-11-21 13:00:00
68	1	exit	2024-11-21 17:00:00
69	2	enter	2024-11-21 08:00:00
70	2	exit	2024-11-21 12:00:00
71	2	enter	2024-11-21 13:00:00
72	2	exit	2024-11-21 17:00:00
73	3	enter	2024-11-21 08:00:00
74	3	exit	2024-11-21 12:00:00
75	3	enter	2024-11-21 13:00:00
76	3	exit	2024-11-21 17:00:00
77	4	enter	2024-11-21 08:00:00
78	4	exit	2024-11-21 12:00:00
79	4	enter	2024-11-21 13:00:00
80	4	exit	2024-11-21 17:00:00
81	0	enter	2024-11-22 08:00:00
82	0	exit	2024-11-22 12:00:00
83	0	enter	2024-11-22 13:00:00
84	0	exit	2024-11-22 17:00:00
85	1	enter	2024-11-22 08:00:00
86	1	exit	2024-11-22 12:00:00
87	1	enter	2024-11-22 13:00:00
88	1	exit	2024-11-22 17:00:00
89	2	enter	2024-11-22 08:00:00
90	2	exit	2024-11-22 12:00:00
91	2	enter	2024-11-22 13:00:00
92	2	exit	2024-11-22 17:00:00
93	3	enter	2024-11-22 08:00:00
94	3	exit	2024-11-22 12:00:00
95	3	enter	2024-11-22 13:00:00
96	3	exit	2024-11-22 17:00:00
97	4	enter	2024-11-22 08:00:00
98	4	exit	2024-11-22 12:00:00
99	4	enter	2024-11-22 13:00:00
100	4	exit	2024-11-22 17:00:00
101	0	enter	2024-11-23 08:00:00
102	0	exit	2024-11-23 12:00:00
103	1	enter	2024-11-23 08:00:00
104	1	exit	2024-11-23 12:00:00
105	2	enter	2024-11-23 08:00:00
106	2	exit	2024-11-23 12:00:00
107	3	enter	2024-11-23 08:00:00
108	3	exit	2024-11-23 12:00:00
109	4	enter	2024-11-23 08:00:00
110	4	exit	2024-11-23 12:00:00
111	0	enter	2024-11-24 08:00:00
112	0	exit	2024-11-24 12:00:00
113	1	enter	2024-11-24 08:00:00
114	1	exit	2024-11-24 12:00:00
115	2	enter	2024-11-24 08:00:00
116	2	exit	2024-11-24 12:00:00
117	3	enter	2024-11-24 08:00:00
118	3	exit	2024-11-24 12:00:00
119	4	enter	2024-11-24 08:00:00
120	4	exit	2024-11-24 12:00:00
121	0	enter	2024-11-25 08:00:00
122	0	exit	2024-11-25 12:00:00
123	0	enter	2024-11-25 13:00:00
124	0	exit	2024-11-25 17:00:00
125	1	enter	2024-11-25 08:00:00
126	1	exit	2024-11-25 12:00:00
127	1	enter	2024-11-25 13:00:00
128	1	exit	2024-11-25 17:00:00
129	2	enter	2024-11-25 08:00:00
130	2	exit	2024-11-25 12:00:00
131	2	enter	2024-11-25 13:00:00
132	2	exit	2024-11-25 17:00:00
133	3	enter	2024-11-25 08:00:00
134	3	exit	2024-11-25 12:00:00
135	3	enter	2024-11-25 13:00:00
136	3	exit	2024-11-25 17:00:00
137	4	enter	2024-11-25 08:00:00
138	4	exit	2024-11-25 12:00:00
139	4	enter	2024-11-25 13:00:00
140	4	exit	2024-11-25 17:00:00
141	0	enter	2024-11-26 08:00:00
142	0	exit	2024-11-26 12:00:00
143	0	enter	2024-11-26 13:00:00
144	0	exit	2024-11-26 17:00:00
145	1	enter	2024-11-26 08:00:00
146	1	exit	2024-11-26 12:00:00
147	1	enter	2024-11-26 13:00:00
148	1	exit	2024-11-26 17:00:00
149	2	enter	2024-11-26 08:00:00
150	2	exit	2024-11-26 12:00:00
151	2	enter	2024-11-26 13:00:00
152	2	exit	2024-11-26 17:00:00
153	3	enter	2024-11-26 08:00:00
154	3	exit	2024-11-26 12:00:00
155	3	enter	2024-11-26 13:00:00
156	3	exit	2024-11-26 17:00:00
157	4	enter	2024-11-26 08:00:00
158	4	exit	2024-11-26 12:00:00
159	4	enter	2024-11-26 13:00:00
160	4	exit	2024-11-26 17:00:00
161	0	enter	2024-11-27 08:00:00
162	0	exit	2024-11-27 12:00:00
163	0	enter	2024-11-27 13:00:00
164	0	exit	2024-11-27 17:00:00
165	1	enter	2024-11-27 08:00:00
166	1	exit	2024-11-27 12:00:00
167	1	enter	2024-11-27 13:00:00
168	1	exit	2024-11-27 17:00:00
169	2	enter	2024-11-27 08:00:00
170	2	exit	2024-11-27 12:00:00
171	2	enter	2024-11-27 13:00:00
172	2	exit	2024-11-27 17:00:00
173	3	enter	2024-11-27 08:00:00
174	3	exit	2024-11-27 12:00:00
175	3	enter	2024-11-27 13:00:00
176	3	exit	2024-11-27 17:00:00
177	4	enter	2024-11-27 08:00:00
178	4	exit	2024-11-27 12:00:00
179	4	enter	2024-11-27 13:00:00
180	4	exit	2024-11-27 17:00:00
181	0	enter	2024-11-28 08:00:00
182	0	exit	2024-11-28 12:00:00
183	0	enter	2024-11-28 13:00:00
184	0	exit	2024-11-28 17:00:00
185	1	enter	2024-11-28 08:00:00
186	1	exit	2024-11-28 12:00:00
187	1	enter	2024-11-28 13:00:00
188	1	exit	2024-11-28 17:00:00
189	2	enter	2024-11-28 08:00:00
190	2	exit	2024-11-28 12:00:00
191	2	enter	2024-11-28 13:00:00
192	2	exit	2024-11-28 17:00:00
193	3	enter	2024-11-28 08:00:00
194	3	exit	2024-11-28 12:00:00
195	3	enter	2024-11-28 13:00:00
196	3	exit	2024-11-28 17:00:00
197	4	enter	2024-11-28 08:00:00
198	4	exit	2024-11-28 12:00:00
199	4	enter	2024-11-28 13:00:00
200	4	exit	2024-11-28 17:00:00
201	0	enter	2024-11-29 08:00:00
202	0	exit	2024-11-29 12:00:00
203	0	enter	2024-11-29 13:00:00
204	0	exit	2024-11-29 17:00:00
205	1	enter	2024-11-29 08:00:00
206	1	exit	2024-11-29 12:00:00
207	1	enter	2024-11-29 13:00:00
208	1	exit	2024-11-29 17:00:00
209	2	enter	2024-11-29 08:00:00
210	2	exit	2024-11-29 12:00:00
211	2	enter	2024-11-29 13:00:00
212	2	exit	2024-11-29 17:00:00
213	3	enter	2024-11-29 08:00:00
214	3	exit	2024-11-29 12:00:00
215	3	enter	2024-11-29 13:00:00
216	3	exit	2024-11-29 17:00:00
217	4	enter	2024-11-29 08:00:00
218	4	exit	2024-11-29 12:00:00
219	4	enter	2024-11-29 13:00:00
220	4	exit	2024-11-29 17:00:00
221	0	enter	2024-11-30 08:00:00
222	0	exit	2024-11-30 12:00:00
223	1	enter	2024-11-30 08:00:00
224	1	exit	2024-11-30 12:00:00
225	2	enter	2024-11-30 08:00:00
226	2	exit	2024-11-30 12:00:00
227	3	enter	2024-11-30 08:00:00
228	3	exit	2024-11-30 12:00:00
229	4	enter	2024-11-30 08:00:00
230	4	exit	2024-11-30 12:00:00
231	0	enter	2024-12-01 08:00:00
232	0	exit	2024-12-01 12:00:00
233	1	enter	2024-12-01 08:00:00
234	1	exit	2024-12-01 12:00:00
235	2	enter	2024-12-01 08:00:00
236	2	exit	2024-12-01 12:00:00
237	3	enter	2024-12-01 08:00:00
238	3	exit	2024-12-01 12:00:00
239	4	enter	2024-12-01 08:00:00
240	4	exit	2024-12-01 12:00:00
241	0	enter	2024-12-02 08:00:00
242	0	exit	2024-12-02 12:00:00
243	0	enter	2024-12-02 13:00:00
244	0	exit	2024-12-02 17:00:00
245	1	enter	2024-12-02 08:00:00
246	1	exit	2024-12-02 12:00:00
247	1	enter	2024-12-02 13:00:00
248	1	exit	2024-12-02 17:00:00
249	2	enter	2024-12-02 08:00:00
250	2	exit	2024-12-02 12:00:00
251	2	enter	2024-12-02 13:00:00
252	2	exit	2024-12-02 17:00:00
253	3	enter	2024-12-02 08:00:00
254	3	exit	2024-12-02 12:00:00
255	3	enter	2024-12-02 13:00:00
256	3	exit	2024-12-02 17:00:00
257	4	enter	2024-12-02 08:00:00
258	4	exit	2024-12-02 12:00:00
259	4	enter	2024-12-02 13:00:00
260	4	exit	2024-12-02 17:00:00
261	0	enter	2024-12-03 08:00:00
262	0	exit	2024-12-03 12:00:00
263	0	enter	2024-12-03 13:00:00
264	0	exit	2024-12-03 17:00:00
265	1	enter	2024-12-03 08:00:00
266	1	exit	2024-12-03 12:00:00
267	1	enter	2024-12-03 13:00:00
268	1	exit	2024-12-03 17:00:00
269	2	enter	2024-12-03 08:00:00
270	2	exit	2024-12-03 12:00:00
271	2	enter	2024-12-03 13:00:00
272	2	exit	2024-12-03 17:00:00
273	3	enter	2024-12-03 08:00:00
274	3	exit	2024-12-03 12:00:00
275	3	enter	2024-12-03 13:00:00
276	3	exit	2024-12-03 17:00:00
277	4	enter	2024-12-03 08:00:00
278	4	exit	2024-12-03 12:00:00
279	4	enter	2024-12-03 13:00:00
280	4	exit	2024-12-03 17:00:00
281	0	enter	2024-12-04 08:00:00
282	0	exit	2024-12-04 12:00:00
283	0	enter	2024-12-04 13:00:00
284	0	exit	2024-12-04 17:00:00
285	1	enter	2024-12-04 08:00:00
286	1	exit	2024-12-04 12:00:00
287	1	enter	2024-12-04 13:00:00
288	1	exit	2024-12-04 17:00:00
289	2	enter	2024-12-04 08:00:00
290	2	exit	2024-12-04 12:00:00
291	2	enter	2024-12-04 13:00:00
292	2	exit	2024-12-04 17:00:00
293	3	enter	2024-12-04 08:00:00
294	3	exit	2024-12-04 12:00:00
295	3	enter	2024-12-04 13:00:00
296	3	exit	2024-12-04 17:00:00
297	4	enter	2024-12-04 08:00:00
298	4	exit	2024-12-04 12:00:00
299	4	enter	2024-12-04 13:00:00
300	4	exit	2024-12-04 17:00:00
301	0	enter	2024-12-05 08:00:00
302	0	exit	2024-12-05 12:00:00
303	0	enter	2024-12-05 13:00:00
304	0	exit	2024-12-05 17:00:00
305	1	enter	2024-12-05 08:00:00
306	1	exit	2024-12-05 12:00:00
307	1	enter	2024-12-05 13:00:00
308	1	exit	2024-12-05 17:00:00
309	2	enter	2024-12-05 08:00:00
310	2	exit	2024-12-05 12:00:00
311	2	enter	2024-12-05 13:00:00
312	2	exit	2024-12-05 17:00:00
313	3	enter	2024-12-05 08:00:00
314	3	exit	2024-12-05 12:00:00
315	3	enter	2024-12-05 13:00:00
316	3	exit	2024-12-05 17:00:00
317	4	enter	2024-12-05 08:00:00
318	4	exit	2024-12-05 12:00:00
319	4	enter	2024-12-05 13:00:00
320	4	exit	2024-12-05 17:00:00
321	0	enter	2024-12-06 08:00:00
322	0	exit	2024-12-06 12:00:00
323	0	enter	2024-12-06 13:00:00
324	0	exit	2024-12-06 17:00:00
325	1	enter	2024-12-06 08:00:00
326	1	exit	2024-12-06 12:00:00
327	1	enter	2024-12-06 13:00:00
328	1	exit	2024-12-06 17:00:00
329	2	enter	2024-12-06 08:00:00
330	2	exit	2024-12-06 12:00:00
331	2	enter	2024-12-06 13:00:00
332	2	exit	2024-12-06 17:00:00
333	3	enter	2024-12-06 08:00:00
334	3	exit	2024-12-06 12:00:00
335	3	enter	2024-12-06 13:00:00
336	3	exit	2024-12-06 17:00:00
337	4	enter	2024-12-06 08:00:00
338	4	exit	2024-12-06 12:00:00
339	4	enter	2024-12-06 13:00:00
340	4	exit	2024-12-06 17:00:00
341	0	enter	2024-12-07 08:00:00
342	0	exit	2024-12-07 12:00:00
343	1	enter	2024-12-07 08:00:00
344	1	exit	2024-12-07 12:00:00
345	2	enter	2024-12-07 08:00:00
346	2	exit	2024-12-07 12:00:00
347	3	enter	2024-12-07 08:00:00
348	3	exit	2024-12-07 12:00:00
349	4	enter	2024-12-07 08:00:00
350	4	exit	2024-12-07 12:00:00
351	0	enter	2024-12-08 08:00:00
352	0	exit	2024-12-08 12:00:00
353	1	enter	2024-12-08 08:00:00
354	1	exit	2024-12-08 12:00:00
355	2	enter	2024-12-08 08:00:00
356	2	exit	2024-12-08 12:00:00
357	3	enter	2024-12-08 08:00:00
358	3	exit	2024-12-08 12:00:00
359	4	enter	2024-12-08 08:00:00
360	4	exit	2024-12-08 12:00:00
361	0	enter	2024-12-09 08:00:00
362	0	exit	2024-12-09 12:00:00
363	0	enter	2024-12-09 13:00:00
364	0	exit	2024-12-09 17:00:00
365	1	enter	2024-12-09 08:00:00
366	1	exit	2024-12-09 12:00:00
367	1	enter	2024-12-09 13:00:00
368	1	exit	2024-12-09 17:00:00
369	2	enter	2024-12-09 08:00:00
370	2	exit	2024-12-09 12:00:00
371	2	enter	2024-12-09 13:00:00
372	2	exit	2024-12-09 17:00:00
373	3	enter	2024-12-09 08:00:00
374	3	exit	2024-12-09 12:00:00
375	3	enter	2024-12-09 13:00:00
376	3	exit	2024-12-09 17:00:00
377	4	enter	2024-12-09 08:00:00
378	4	exit	2024-12-09 12:00:00
379	4	enter	2024-12-09 13:00:00
380	4	exit	2024-12-09 17:00:00
381	0	enter	2024-12-10 08:00:00
382	0	exit	2024-12-10 12:00:00
383	0	enter	2024-12-10 13:00:00
384	0	exit	2024-12-10 17:00:00
385	1	enter	2024-12-10 08:00:00
386	1	exit	2024-12-10 12:00:00
387	1	enter	2024-12-10 13:00:00
388	1	exit	2024-12-10 17:00:00
389	2	enter	2024-12-10 08:00:00
390	2	exit	2024-12-10 12:00:00
391	2	enter	2024-12-10 13:00:00
392	2	exit	2024-12-10 17:00:00
393	3	enter	2024-12-10 08:00:00
394	3	exit	2024-12-10 12:00:00
395	3	enter	2024-12-10 13:00:00
396	3	exit	2024-12-10 17:00:00
397	4	enter	2024-12-10 08:00:00
398	4	exit	2024-12-10 12:00:00
399	4	enter	2024-12-10 13:00:00
400	4	exit	2024-12-10 17:00:00
401	0	enter	2024-12-11 08:00:00
402	0	exit	2024-12-11 12:00:00
403	0	enter	2024-12-11 13:00:00
404	0	exit	2024-12-11 17:00:00
405	1	enter	2024-12-11 08:00:00
406	1	exit	2024-12-11 12:00:00
407	1	enter	2024-12-11 13:00:00
408	1	exit	2024-12-11 17:00:00
409	2	enter	2024-12-11 08:00:00
410	2	exit	2024-12-11 12:00:00
411	2	enter	2024-12-11 13:00:00
412	2	exit	2024-12-11 17:00:00
413	3	enter	2024-12-11 08:00:00
414	3	exit	2024-12-11 12:00:00
415	3	enter	2024-12-11 13:00:00
416	3	exit	2024-12-11 17:00:00
417	4	enter	2024-12-11 08:00:00
418	4	exit	2024-12-11 12:00:00
419	4	enter	2024-12-11 13:00:00
420	4	exit	2024-12-11 17:00:00
421	0	enter	2024-12-12 08:00:00
422	0	exit	2024-12-12 12:00:00
423	0	enter	2024-12-12 13:00:00
424	0	exit	2024-12-12 17:00:00
425	1	enter	2024-12-12 08:00:00
426	1	exit	2024-12-12 12:00:00
427	1	enter	2024-12-12 13:00:00
428	1	exit	2024-12-12 17:00:00
429	2	enter	2024-12-12 08:00:00
430	2	exit	2024-12-12 12:00:00
431	2	enter	2024-12-12 13:00:00
432	2	exit	2024-12-12 17:00:00
433	3	enter	2024-12-12 08:00:00
434	3	exit	2024-12-12 12:00:00
435	3	enter	2024-12-12 13:00:00
436	3	exit	2024-12-12 17:00:00
437	4	enter	2024-12-12 08:00:00
438	4	exit	2024-12-12 12:00:00
439	4	enter	2024-12-12 13:00:00
440	4	exit	2024-12-12 17:00:00
441	0	enter	2024-12-13 08:00:00
442	0	exit	2024-12-13 12:00:00
443	0	enter	2024-12-13 13:00:00
444	0	exit	2024-12-13 17:00:00
445	1	enter	2024-12-13 08:00:00
446	1	exit	2024-12-13 12:00:00
447	1	enter	2024-12-13 13:00:00
448	1	exit	2024-12-13 17:00:00
449	2	enter	2024-12-13 08:00:00
450	2	exit	2024-12-13 12:00:00
451	2	enter	2024-12-13 13:00:00
452	2	exit	2024-12-13 17:00:00
453	3	enter	2024-12-13 08:00:00
454	3	exit	2024-12-13 12:00:00
455	3	enter	2024-12-13 13:00:00
456	3	exit	2024-12-13 17:00:00
457	4	enter	2024-12-13 08:00:00
458	4	exit	2024-12-13 12:00:00
459	4	enter	2024-12-13 13:00:00
460	4	exit	2024-12-13 17:00:00
461	0	enter	2024-12-14 08:00:00
462	0	exit	2024-12-14 12:00:00
463	1	enter	2024-12-14 08:00:00
464	1	exit	2024-12-14 12:00:00
465	2	enter	2024-12-14 08:00:00
466	2	exit	2024-12-14 12:00:00
467	3	enter	2024-12-14 08:00:00
468	3	exit	2024-12-14 12:00:00
469	4	enter	2024-12-14 08:00:00
470	4	exit	2024-12-14 12:00:00
471	0	enter	2024-12-15 08:00:00
472	0	exit	2024-12-15 12:00:00
473	1	enter	2024-12-15 08:00:00
474	1	exit	2024-12-15 12:00:00
475	2	enter	2024-12-15 08:00:00
476	2	exit	2024-12-15 12:00:00
477	3	enter	2024-12-15 08:00:00
478	3	exit	2024-12-15 12:00:00
479	4	enter	2024-12-15 08:00:00
480	4	exit	2024-12-15 12:00:00
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

