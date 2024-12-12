# Smart Scheduling System
By Fatima, Ma'any, Rajveer, Thu

# Summary
We chose Fatima’s EDR, which entailed utilising entry and exit data of a student flat captured by the SSH Camera to allow for a smarter, data-driven way to schedule chores. In the EDR, the goals listed were:<br />
1.	Leverage SSH Camera data to calculate the likelihood of a user being home at specific times. <br />
2.	Remind users of their chores via SSH App notifications. The notification should be sent when the user is most likely to be home. <br />
3.	Notify users via SSH App when they are home alone and provide an estimated duration until another resident returns. <br />
Of which this prototype accomplished 1 and 2. Although Goal 3 was left unaccomplished, we believe this prototype still demonstrates that Goal 3 is possible, with more data processing (e.g., by setting a 70% as the benchmark for notifying and calculating the probability for other students to be home at one hour interval timeslots). Additionally, rather than waiting for the user to be home alone before suggesting doing a chore, we instead send the user a notification that they have x chores to do and calculate the most likely time for the user to be home. <br />


Before running the code in "ssh/src/main/java/ssh/example/ssh.java", the ssh database needs to be created on the local machine. <br />
Download "Smart-scheduling-system-/ssh.sql" (this contains a pg_dump of the database) <br />
Run the following commands in the terminal: <br />
psql postgres <br />
CREATE ROLE user1 NOINHERIT LOGIN PASSWORD 'password'; <br />
CREATE DATABASE ssh WITH OWNER = user1 ENCODING = 'UTF8' CONNECTION LIMIT = -1; <br />
Then exit terminal or create a new terminal to run: <br />
pg_dump ssh <~(path to downloaded ssh.sql)
