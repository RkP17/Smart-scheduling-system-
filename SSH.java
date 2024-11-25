import java.sql.*;
import java.time.DayOfWeek;
import java.util.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class SSH{
    public static void main(String[] args) {

        //Database

        //Below is what I used to test the code
        int student_id = 1;
        List<Map<String, Object>> rawRecords = Database(student_id);

        // Process the data
        List<int[][]> presenceMatrices = cleanData(rawRecords);

        calculateProbabilities();

        //store the data 
        storeProbabilities();

        //schedule chores
        scheduleChores();

    }

    // SQL statements for the database (If we want to do it through here rather than the terminal)
    private static List<Map<String, Object>> Database(int id) {
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
        String username = "postgres";
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


    //Function that returns a list of the presence matrices
    private static List<int[][]> cleanData(List<Map<String, Object>> rawRecords) {

        //Stores records by week
        Map<Integer, List<Map<String, Object>>> weeklyData = new TreeMap<>();

        //Using the local machine's date as a benchmark
        LocalDateTime now = LocalDateTime.now();

        //Iterate through each record and note which week it belongs to
        for (Map<String, Object> record : rawRecords) {
            LocalDateTime timestamp = (LocalDateTime) record.get("timestamp");

            // Calculate week index, meaning how far away the week is from the current(0 = most recent week)
            int weekIndex = (int) ChronoUnit.WEEKS.between(timestamp, now);
            //Adding each week's worth of data to a tree map
            weeklyData.putIfAbsent(weekIndex, new ArrayList<>());
            weeklyData.get(weekIndex).add(record);
        }


        //To create the presenceMatrices
        List<int[][]> presenceMatrices = new ArrayList<>();

        //Iterate through the tree map and form a presence matrix for each week
        for(int week : weeklyData.keySet()) {
            List<Map<String, Object>> data = weeklyData.get(week);
            int[][] weeklyMatrix = createMatrix(data);
            presenceMatrices.add(weeklyMatrix);
        }

        return presenceMatrices;
    }

    private static int[][] createMatrix(List<Map<String, Object>> data) {
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
            //When exit is detected, it checks if there is a previous "enter" and that they belong to the same day
            } else if ("exit".equalsIgnoreCase(action)) {
                if(entryTime != null && day == dayOfWeek){
                    markPresence(presenceMatrix, day, entryTime, minutes);
                    entryTime = null;
                }
            }
        }

        return presenceMatrix;
    }

    private static void markPresence(int[][] matrix, DayOfWeek dayOfWeek, int start, int end) {
        //Represent each day of the week as an index from 0 to 6 (0 = Monday, 6 = Sunday)
        int dayIndex = dayOfWeek.getValue() - 1;

        //Iterates through entry and exit time, putting 1's between start time and end time
        for (int time = start; time < end; time++) {
            int hourSlot = time / 60;
            if (hourSlot >= 0 && hourSlot < 24) {
                matrix[dayIndex][hourSlot] = 1;
            }
        }
    }

    private static void calculateProbabilities() {

    }

    private static void storeProbabilities() {

    }

    private static void scheduleChores() {

    }




}


