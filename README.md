# Smart Scheduling System
By Fatima, Ma'any, Rajveer, Thu

Before running the code in "ssh/src/main/java/ssh/example/ssh.java", the ssh database needs to be created on the local machine. <br />
Download "Smart-scheduling-system-/ssh.sql" (this contains a pg_dump of the database) <br />
Run the following commands in the terminal: <br />
psql postgres <br />
CREATE ROLE user1 NOINHERIT LOGIN PASSWORD 'password'; <br />
CREATE DATABASE ssh WITH OWNER = user1 ENCODING = 'UTF8' CONNECTION LIMIT = -1; <br />
Then exit terminal or create a new terminal to run: <br />
pg_dump ssh <~(path to downloaded ssh.sql)
