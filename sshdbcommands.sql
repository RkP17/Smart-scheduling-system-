CREATE ROLE user1 NOINHERIT LOGIN PASSWORD 'password';
CREATE DATABASE ssh WITH OWNER = user1 ENCODING = 'UTF8' CONNECTION LIMIT = -1;
\c ssh user1
CREATE TABLE public.students (
    student_id integer NOT NULL,
    name text,
    PRIMARY KEY (student_id)
);

--pg_dump ssh >~thuvo/Documents/OS/ssh.sql

CREATE TYPE action AS ENUM (
    'enter',
    'exit'
);



CREATE TABLE public.entry_and_exit_records (
    record_id integer NOT NULL,
    student_id integer NOT NULL,
    action_attr action,
    timestamp_attr timestamp,
    PRIMARY KEY (record_id)
);

ALTER TABLE public.entry_and_exit_records
    ADD FOREIGN KEY (student_id)
    REFERENCES public.students(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

CREATE TYPE weekday AS ENUM (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);

CREATE TABLE public.chore (
    chore_id integer NOT NULL,
    student_id integer NOT NULL,
    chore_name text,
    weekday_attr weekday,
    suggested_time time,
    PRIMARY KEY (chore_id)
);

ALTER TABLE public.chore
    ADD FOREIGN KEY (student_id)
    REFERENCES public.students(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

probability_id, student_id, weekday, timeslot_start, slot_counter, probability  

CREATE TABLE public.probability_home (
    probability_id integer NOT NULL,
    student_id INTEGER NOT NULL,
    weekday_attr weekday,
    timeslot_start time,
    slot_counter integer,
    probability decimal(6,5),
    PRIMARY KEY (probability_id)
);

ALTER TABLE public.probability_home
    ADD FOREIGN KEY (student_id)
    REFERENCES public.students(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

INSERT INTO public.students(student_id,name) VALUES (0,'John');
INSERT INTO public.students(student_id,name) VALUES (1,'Mary');
INSERT INTO public.students(student_id,name) VALUES (2,'Jesus');
INSERT INTO public.students(student_id,name) VALUES (3,'Joseph');
INSERT INTO public.students(student_id,name) VALUES (4,'Judas');

/*
INSERT INTO public.entry_and_exit_records(record_id,student_id,action_attr,timestamp_attr)
VALUES 
(0,0,'enter','2024-09-23 13:10:11'),
(1,2,'enter','2024-09-23 15:10:11')
(2,0,'exit','2024-09-23 17:18:11'),
(3,4,'enter','2024-09-23 19:19:43'),
(4,3,'enter','2024-09-23 20:10:11'),
(5,1,'enter','2024-09-23 20:17:00'),
(6,2,'exit','2024-09-23 22:00:02'),
--on tuesdays 0 had a 10am and 6pm, 1 idk, 2 went clubbing?, 
(7,2,'enter','2024-09-24 03:00:20'),
(8,0,'enter','2024-07-24 06:15:21');

INSERT INTO public.entry_and_exit_records(record_id,student_id,action_attr,timestamp_attr)
VALUES 
(9,3,'exit','2024-07-24 08:35:07'),
(10,0,'exit','2024-07-23 9:58:00'),
(11,1,'exit','2024-07-24 11:00:20'),
(12,3,'enter','2024-07-24 11:45:21'),
(13,2,'exit','2024-07-24 13:15:56'),
(14,3,'enter','2024-07-24 14:45:09'),
(15,4,'exit','2024-07-24 15:45:01');
--on wednesdays student 0 has a 10am, 1 likes to go to the gym, 2 has nothing but likes to go out to eat, 3 has a 9am, 4 has a 4pm
-----------------
*/
INSERT INTO public.chore (chore_id, student_id, chore_name, weekday_attr, suggested_time)
VALUES 
(0,0, 'vacuum', 'Monday', '11:00:00'),
(1,2, 'clean counter', 'Monday', '13:00:00'),
(2,1, 'laundry', 'Monday', '18:00:00'),
(3,3, 'dishes', 'Monday', '13:00:00'),
(4,4, 'clean bathroom', 'Monday', '14:00:00'),

(5,1, 'vacuum', 'Tuesday', '16:00:00'),
(6,3, 'clean counter', 'Tuesday', '13:00:00'),
(7,0, 'laundry', 'Tuesday', '19:30:00'),
(8,2, 'dishes', 'Tuesday', '18:00:00'),
(9,3, 'clean bathroom', 'Tuesday', '14:00:00'),

(10,2, 'vacuum', 'Wednesday', '11:00:00'),
(11,4, 'clean counter', 'Wednesday', '13:00:00'),
(12,2, 'laundry', 'Wednesday', '15:00:00'),
(13,1, 'dishes', 'Wednesday', '13:00:00'),
(14,2, 'clean bathroom', 'Wednesday', '14:00:00'),

(15,3, 'vacuum', 'Thursday', '16:00:00'),
(16,0, 'clean counter', 'Thursday', '13:00:00'),
(17,3, 'laundry', 'Thursday', '19:30:00'),
(18,0, 'dishes', 'Thursday', '18:00:00'),
(19,1, 'clean bathroom', 'Thursday', '14:00:00'),

(20,4, 'vacuum', 'Friday', '14:00:00'),
(21,1, 'clean counter', 'Friday', '13:00:00'),
(22,4, 'take bins out', 'Friday', '19:00:00'),
(23,4, 'dishes', 'Friday', '13:00:00'),
(24,0, 'clean bathroom', 'Friday', '14:00:00'),

(25,0, 'vacuum', 'Saturday', '16:00:00'),
(26,2, 'clean counter', 'Saturday', '13:00:00'),
(27,4, 'laundry', 'Saturday', '19:30:00'),
(28,3, 'dishes', 'Saturday', '18:00:00'),
(29,4, 'clean bathroom', 'Saturday', '14:00:00'),

(30,1, 'vacuum', 'Sunday', '10:00:00'),
(31,3, 'clean counter', 'Sunday', '13:00:00'),
(32,0, 'clean bathroom', 'Sunday', '18:00:00'),
(33,2, 'dishes', 'Sunday', '13:00:00');

/*
individual chores:
weekly: laundry, clean bathroom

daily: 

shared chores:
weekly: take bin out
daily: clean counter, vacuum, dishes

*/