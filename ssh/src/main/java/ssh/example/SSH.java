package ssh.example;

import java.sql.*;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class SSH{
    public static void main(String[] args) {

        //Database

        //The line below is what I used to test the code
        int student_id = 1;
        List<Map<String, Object>> rawRecords = Database(student_id);

        //Process the data
        List<int[][]> presenceMatrices = cleanData(rawRecords);
        

        //Calculate the probability
        double[][] probabilities=calculate(presenceMatrices);
        //printProbabilityMatrix(probabilities);

        //store the data 
        storeProbabilities(student_id, probabilities);

        //schedule chores
        scheduleChores(student_id);

    }

    // SQL statements for the database (If we want to do it through here rather than the terminal)
    public static List<Map<String, Object>> Database(int id) {
        //Query to get up to 8 weeks worth of data, calculated by subtracting 8 weeks from most recent record
        String query = "WITH latest_date AS (" +
                "    SELECT MAX(timestamp_attr) AS recent_time " +
                "    FROM entry_and_exit_records" +
                "), " +
                "earliest_valid_date AS (" +
                "    SELECT recent_time - INTERVAL '8 weeks' AS start_time " +
                "    FROM latest_date" +
                ") " +
                "SELECT timestamp_attr, action_attr " +
                "FROM entry_and_exit_records " +
                "WHERE timestamp_attr BETWEEN (" +
                "    SELECT start_time FROM earliest_valid_date" +
                ") AND (" +
                "    SELECT recent_time FROM latest_date" +
                ") " +
                "  AND student_id = ? " +
                "ORDER BY timestamp_attr";

        List<Map<String, Object>> records = new ArrayList<>();

        //Seeting up the JDBC connection, put your own password for this
        String username = " ";
        String password = " ";
        String url = "jdbc:postgresql://localhost:5432/ssh";

        try(Connection connection = DriverManager.getConnection(url, username, password)){

            //Executing the query
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            try(ResultSet resultSet = statement.executeQuery()){
                while (resultSet.next()) {

                    //Adding the result set to a hash map
                    Map<String, Object> record = new HashMap<>();
                    record.put("timestamp", resultSet.getTimestamp("timestamp_attr").toLocalDateTime());
                    record.put("action", resultSet.getString("action_attr"));
                    records.add(record);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return records;
    }


    //Function that cleans data and returns a list of presence matrices
    public static List<int[][]> cleanData(List<Map<String, Object>> rawRecords) {

        //To store data by week
        Map<Integer, List<Map<String, Object>>> weeklyData = new TreeMap<>();

        //Using the local machine's date as a benchmark
        LocalDateTime now = LocalDateTime.now();
        LocalDate referenceMonday = now.with(DayOfWeek.MONDAY).toLocalDate();

        //Iterate through each record and note which week it belongs to
        for (Map<String, Object> record : rawRecords) {

            //Look at the date retrieved from the timestamp and go to the Monday of that week
            LocalDateTime timestamp = (LocalDateTime) record.get("timestamp");
            LocalDate recordMonday = timestamp.toLocalDate().with(DayOfWeek.MONDAY);

            //Calculate the weeks between local date and the date retrieved from the record
            long weekIndex = ChronoUnit.WEEKS.between(recordMonday, referenceMonday);

            //Adding each week's worth of data to a tree map
            weeklyData.putIfAbsent((int)weekIndex, new ArrayList<>());
            weeklyData.get((int)weekIndex).add(record);
        }

        //To create the list of presence matrices
        List<int[][]> presenceMatrices = new ArrayList<>();

        //Iterate through the tree map and form a presence matrix for each week
        for(int week : weeklyData.keySet()) {
            List<Map<String, Object>> data = weeklyData.get(week);
            int[][] weeklyMatrix = createMatrix(data);
            presenceMatrices.add(weeklyMatrix);
        }

        return presenceMatrices;
    }

    //Function to create a presence matrix
    public static int[][] createMatrix(List<Map<String, Object>> data) {
        int[][] presenceMatrix = new int[7][24];
        Integer entryTime = null;
        DayOfWeek day = null;

        //Iterates through each record in the list of records to pair up each entry and exit
        for(Map<String, Object> record: data) {
            LocalDateTime timestamp = (LocalDateTime) record.get("timestamp");
            String action = (String) record.get("action");

            //Standardise into minutes after midnight
            int minutes = (timestamp.getHour() * 60) + timestamp.getMinute();
            DayOfWeek dayOfWeek = timestamp.getDayOfWeek();

            //If the action is "enter" it stores its time along with its day of the week
            if("enter".equalsIgnoreCase(action)){
                entryTime = minutes;
                day = dayOfWeek;

            //When exit is detected
            } else if ("exit".equalsIgnoreCase(action)) {
                //If there is no previous entry time, assume the entry belongs to the previous day and start from 00:00
                if(entryTime == null){
                    markPresence(presenceMatrix, dayOfWeek, 0, minutes);

                //If there is a previous entry time
                } else {
                    if(day == dayOfWeek) {
                        //Case where enter and exit occur on the same day
                        markPresence(presenceMatrix, day, entryTime, minutes);
                    } else {
                        //Case where enter and exit occur on different days
                        markPresence(presenceMatrix, day, entryTime, 1440);
                        markPresence(presenceMatrix, dayOfWeek, 0, minutes);
                    }
                    entryTime = null;

                }
            }
        }


        //Case where the user is inside after the last record
        if(entryTime != null) {
            markPresence(presenceMatrix, day, entryTime, 1440);
        }

        return presenceMatrix;
    }

    //Function that marks a 1 in timeslots where the user is home
    public static void markPresence(int[][] matrix, DayOfWeek dayOfWeek, int start, int end) {
        //Represent each day of the week as an index from 0 to 6 (0 = Monday, 6 = Sunday)
        int dayIndex = dayOfWeek.getValue() - 1;

        int startHour = start / 60;
        int endHour = end / 60;

        //Iterates from start to end hour of the entry and exit pair
        for (int hour = startHour; hour <= endHour; hour++) {

            //Start and end of the timeslot interval in minutes
            int hourStart = hour * 60;
            int hourEnd = hourStart + 60;

            // Determine how long the user was at home for (the overlap within the interval)
            int overlapStart = Math.max(start, hourStart); // Latest start time
            int overlapEnd = Math.min(end, hourEnd); // Earliest end time
            int overlap = overlapEnd - overlapStart;

            // Mark the slot with a 1 if overlap >= 30 minutes (if the user was home for 30+ minutes)
            if (overlap >= 30) {
                matrix[dayIndex][hour] = 1;
            }
        }


    }

    public static double[][] calculate(List<int[][]> presenceMatricies) {
        // store the probabilities into a matrix 7x24
        double[][] probabilities= new double[7][24];

        //number of weeks in total
        int numWeeks=presenceMatricies.size();

        // Loop through all the weekly matrices
        for (int[][] weeklyMatrix:presenceMatricies){
            // for each day
            for (int day=0; day<7;day++){
                // for each hour
                for (int hour=0;hour<24;hour++){
                    // sum all the presence values for each hour or each day
                    probabilities[day][hour] += weeklyMatrix[day][hour];
                }
            }
        }

        //convert into probabilities 
        for (int day=0;day<7;day++){
            for(int hour=0; hour<24;hour++){
                //probability= sum/num of weeks 
                probabilities[day][hour]/= numWeeks;
            }
        }

        return probabilities;
        

    }

    // Method to print the probability matrix
    private static void printProbabilityMatrix(double[][] probabilities) {
        System.out.println("Probability Matrix:");
        for (int day = 0; day < 7; day++) {
            System.out.print("Day " + (day + 1) + ": ");
            for (int hour = 0; hour < 24; hour++) {
                System.out.print(probabilities[day][hour]); 
            }
            System.out.println();
        }
    }

    // helper method to store one time slot
    private static void storeProbability(PreparedStatement statement, int probabilityId, int studentId, String weekdayAttr, int startHour, int slotCounter, double probability) throws SQLException {
        // setting the values for SQL query
        statement.setInt(1, probabilityId);
        statement.setInt(2, studentId);
        statement.setString(3, weekdayAttr);
        statement.setTime(4, Time.valueOf(String.format("%02d:00:00", startHour)));
        statement.setInt(5, slotCounter);
        statement.setDouble(6, probability);

        // execute the query to store the probability data in the database
        statement.executeUpdate();
    }

    public static void storeProbabilities(int studentId, double[][] probabilities) {
        // JDBC connection
        String username = " ";
        String password = " ";
        String url = "jdbc:postgresql://localhost:5432/ssh";


        String droppHomequery = "DROP TABLE probability_home";
        String createpHomequery = "CREATE TABLE public.probability_home ( " +
                "probability_id integer NOT NULL, " +
                "student_id INTEGER NOT NULL, " +
                "weekday_attr weekday, " +
                "timeslot_start time, " +
                "slot_counter integer, " +
                "probability decimal(6,5), " +
                "PRIMARY KEY (probability_id) )";
        String ownerpHomeQuery = "ALTER TABLE public.probability_home OWNER TO user1 ";
        String keypHomeQuery = "ALTER TABLE public.probability_home " +
                "ADD FOREIGN KEY (student_id) " +
                "REFERENCES public.students(student_id) " +
                "ON UPDATE CASCADE " +
                "ON DELETE CASCADE " +
                "NOT VALID ";
        String query = "INSERT INTO public.probability_home " +
                "(probability_id, student_id, weekday_attr, timeslot_start, slot_counter, probability) " +
                "VALUES (?, ?, ?::weekday, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            Statement statementbatch = connection.createStatement();
            statementbatch.addBatch(droppHomequery);
            statementbatch.addBatch(createpHomequery);
            statementbatch.addBatch(ownerpHomeQuery);
            statementbatch.addBatch(keypHomeQuery);
            statementbatch.executeBatch();
            PreparedStatement statement = connection.prepareStatement(query);

            int probabilityId = 1; // Initialize probability ID

            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COALESCE(MAX(probability_id), 0) FROM public.probability_home")) {
                    if (rs.next()) {
                    probabilityId = rs.getInt(1) + 1; // start from the next ID
                    }
                 }

            // iterate over each day
            for (int day = 0; day < 7; day++) {
                // map the day index onto corresponding weekday
                String weekdayAttr = DayOfWeek.of(day + 1).toString().substring(0, 1).toUpperCase() + DayOfWeek.of(day + 1).toString().substring(1).toLowerCase();

                int startHour = -1; // hour at which current time block starts
                int slotCounter = 0; // counter for the number of consecutive slots with the same probability
                double currentProbability = -1.0; // for tracking current probability to group consecutive slots

                // iterate over each hour
                for (int hour = 0; hour < 24; hour++) {
                    double prob = probabilities[day][hour]; // get probability for the current hour

                    // with these conditions, this is first time slot or probability matches the current time slot
                    if (startHour == -1 || prob == currentProbability) {
                        // continuing current slot if it's the first hour or probability is the same
                        if (startHour == -1) {
                            startHour = hour; // set the starting hour for the slot
                            currentProbability = prob; // set current probability for the slot
                        }
                        // increment the slot counter for consecutive hours with same probability
                        slotCounter++;
                    } else {
                        // end current time slot and store it if the probability changes
                        if (slotCounter > 0) {
                            storeProbability(statement, probabilityId, studentId, weekdayAttr, startHour, slotCounter, currentProbability);
                            probabilityId++; // increment probability ID for the next time slot
                        }
                        // start a new time slot
                        startHour = hour;
                        currentProbability = prob;
                        slotCounter = 1;
                    }
                }
                // after looping through all hours, checks if there's an ongoing block to store
                if (slotCounter > 0) {
                    storeProbability(statement, probabilityId, studentId, weekdayAttr, startHour, slotCounter, currentProbability);
                    probabilityId++;
                }
            }
            statement.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void scheduleChores(int id) {
        //As usual, change these to your posstgres credentials
        String username = " ";
        String password = " ";
        String url = "jdbc:postgresql://localhost:5432/ssh";

        try(Connection connection = DriverManager.getConnection(url, username, password)){

            //Step 1: Find out what day it is from the database.
            Statement statement = connection.createStatement();
            String findDayIntQuery = "SELECT EXTRACT (ISODOW FROM NOW())"; //SELECT EXTRACT (ISODOW FROM NOW()) returns an integer value 1 for Monday, 2 for Tuesday, and so on until 7 for Sunday.
            try (ResultSet dayIntResult = statement.executeQuery(findDayIntQuery)) {
                while (dayIntResult.next()) {

                    int dayInt = dayIntResult.getInt("extract");
                    //System.out.println(dayInt); //print the dayInt value, for testing purposes

                    //Convert the dayInt value into the corresponding String (Monday, Tuesday, etc)
                    String weekdayAttr = DayOfWeek.of(dayInt).toString().substring(0, 1).toUpperCase() + DayOfWeek.of(dayInt).toString().substring(1).toLowerCase();
                    //System.out.println(weekdayAttr); //print the weekday for testing purposes

                    //Step 2: Find out what chores the student has today
                    String findStudentChoreQuery = "SELECT chore_name FROM CHORE " +
                            "WHERE weekday_attr= '" + weekdayAttr + "'" +
                            "AND student_id= ?";

                    PreparedStatement statement2 = connection.prepareStatement(findStudentChoreQuery);
                    statement2.setInt(1, id);
                    try (ResultSet choresResult = statement2.executeQuery()) {

                        //Add all the chores to the chores string
                        Boolean firstChore = true;
                        String chores ="";
                        while (choresResult.next()) {
                            if (firstChore) {
                                chores = choresResult.getString("chore_name");
                                firstChore = false;
                            } else {
                                chores = chores + "," + choresResult.getString("chore_name");
                            }

                        }
                        if (chores.equals("")) {
                            System.out.println("Student " + id + " does not have any chores scheduled for today.");
                        } else {
                            //System.out.println(chores); //Print the chores for testing purposes

                            //Step 3: Find what the best timeslot for the student to complete their chores, based on how likely they are to be home

                            /*Find the eligible timeslots. To be an eligible timeslot, we want to exclude inappropriate times to do chores (before 8am and after 9pm)
                            To do this, we want to include timeslots that include the times 08:00:00-21:00:00
                            This may include timeslots that start before 08:00:00 */

                            String findEligibleTimeslotQuery = "SELECT probability_id, timeslot_start, " +
                                    "slot_counter, probability, " +
                                    "timeslot_start + INTERVAL '1 hour' * slot_counter " +
                                    "AS timeslot_end  " +
                                    "FROM probability_home " +
                                    "WHERE ( " +
                                    "(" +
                                    "timeslot_start < '08:00:00'::time " +
                                    "AND timeslot_start + INTERVAL '1 hour' * slot_counter > '08:00:00'::time " +
                                    "AND weekday_attr = '" + weekdayAttr + "'" +
                                    ") " +
                                    "OR timeslot_start > '07:59:59'::time " +
                                    "AND timeslot_start < '21:00:00'::time " +
                                    "AND weekday_attr = '" + weekdayAttr + "'" +
                                    "AND student_id= ?" +
                                    " )";
                            PreparedStatement statement3 = connection.prepareStatement(findEligibleTimeslotQuery);
                            statement3.setInt(1,id);
                            try (ResultSet eligbileTimeslotResult = statement3.executeQuery()) {

                                //Find the first timeslot when the student is most likely to be home.
                                /*In the future we may add a feature where if the currect time is past
                                the recommended timeslot, the next best timeslot is suggested */
                                long highestProbability = 0;
                                int probability_id = -1;
                                String timeslot_start = "";
                                while (eligbileTimeslotResult.next()) {
                                    if (eligbileTimeslotResult.getLong("probability") > highestProbability) {
                                        highestProbability = eligbileTimeslotResult.getLong("probability");
                                        probability_id = eligbileTimeslotResult.getInt("probability_id");
                                        timeslot_start = eligbileTimeslotResult.getString("timeslot_start");
                                    }
                                }
                                if (probability_id != -1) {
                                    /*Below is for debugging:
                                    System.out.println(highestProbability);
                                    System.out.println(probability_id);
                                    System.out.println(timeslot_start);*/
                                    System.out.println("The best timeslot for student " + id + " to " + chores +  " on " + weekdayAttr + " is " + timeslot_start);
                                } else {
                                    //This will only be reached when probability_home is incorrectly generated.
                                    System.out.println("Could not find the best time for student " + id + " to do their chores.");
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

