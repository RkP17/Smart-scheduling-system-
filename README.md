Before running the code in "ssh/src/main/java/ssh/example/ssh.java", the ssh database needs to be created on the local machine.
Download "Smart-scheduling-system-/ssh.sql" (this contains a pg_dump of the database)
Run the following commands in the terminal:
psql postgres
CREATE ROLE user1 NOINHERIT LOGIN PASSWORD 'password';
CREATE DATABASE ssh WITH OWNER = user1 ENCODING = 'UTF8' CONNECTION LIMIT = -1;
Then exit terminal or create a new terminal to run:
pg_dump ssh <~(path to downloaded ssh.sql)
