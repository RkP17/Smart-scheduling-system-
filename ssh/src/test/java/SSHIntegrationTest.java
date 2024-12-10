import ssh.example.SSH;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;
import java.util.Map;
import java.sql.*;

import org.junit.jupiter.api.Test;

public class SSHIntegrationTest {

    //Used for  setting up the JDBC connection, put your own username & password for this
    private final String username = " ";
    private final String password = " ";
    private final String url = "jdbc:postgresql://localhost:5432/ssh";

    @Test
    public void integrationTest1() {
        // verifying if correct probabilities are being stored for student id = 2 for monday

        List<Map<String, Object>> rawRecords = SSH.Database(username,password, url,2);

        // process the data
        List<int[][]> presenceMatrices = SSH.cleanData(rawRecords);

        // calculate the probability
        double[][] probabilities = SSH. calculate(presenceMatrices);

        // store the data
        SSH.storeProbabilities(username, password, url, 2, probabilities);

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT probability, slot_counter FROM probability_home WHERE weekday_attr = ?::weekday")) {

            pstmt.setString(1, "Monday");

            try (ResultSet rs = pstmt.executeQuery()) {
                int rowIndex = 0; // row index initialized to track which probability is being compared

                // iterate through the stored probabilities
                while (rs.next()) {
                    double actualProbability = rs.getDouble("probability");
                    int slotCounter = rs.getInt("slot_counter");

                    // looping through slotCounter to expand the combined hours in the database
                    for (int i = 0; i < slotCounter; i++) {
                        if (rowIndex < probabilities[0].length) {
                            // retrieve pre-calculated probabilities
                            double expectedProbability = probabilities[0][rowIndex];
                            System.out.println("Row " + rowIndex + ": Expected = " + expectedProbability + ", Actual = " + actualProbability);

                            assertEquals(expectedProbability, actualProbability, 0.0001);
                            rowIndex++;
                        } else {
                            System.out.println("No expected probability for Row " + rowIndex);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void integrationTest2() {
        // verifying if correct probabilities are being stored for student id = 4 for friday

        List<Map<String, Object>> rawRecords = SSH.Database(username, password, url,4);

        // process the data
        List<int[][]> presenceMatrices = SSH.cleanData(rawRecords);

        // calculate the probability
        double[][] probabilities = SSH. calculate(presenceMatrices);

        // store the data
        SSH.storeProbabilities(username, password, url,4, probabilities);

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT probability, slot_counter FROM probability_home WHERE weekday_attr = ?::weekday")) {

            pstmt.setString(1, "Friday");

            try (ResultSet rs = pstmt.executeQuery()) {
                int rowIndex = 0; // row index initialized to track which probability is being compared

                // iterate through the stored probabilities
                while (rs.next()) {
                    double actualProbability = rs.getDouble("probability");
                    int slotCounter = rs.getInt("slot_counter");

                    // looping through slotCounter to expand the combined hours in the database
                    for (int i = 0; i < slotCounter; i++) {
                        if (rowIndex < probabilities[4].length) {
                            // retrieve pre-calculated probabilities
                            double expectedProbability = probabilities[4][rowIndex];
                            System.out.println("Row " + rowIndex + ": Expected = " + expectedProbability + ", Actual = " + actualProbability);

                            assertEquals(expectedProbability, actualProbability, 0.0001);
                            rowIndex++;
                        } else {
                            System.out.println("No expected probability for Row " + rowIndex);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void integrationTest3() {
        // verifying if correct probabilities are being stored for student id = 0 for tuesday

        List<Map<String, Object>> rawRecords = SSH.Database(username, password, url,0);

        // process the data
        List<int[][]> presenceMatrices = SSH.cleanData(rawRecords);

        // calculate the probability
        double[][] probabilities = SSH. calculate(presenceMatrices);

        // store the data
        SSH.storeProbabilities(username, password, url,0, probabilities);

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT probability, slot_counter FROM probability_home WHERE weekday_attr = ?::weekday")) {

            pstmt.setString(1, "Tuesday");

            try (ResultSet rs = pstmt.executeQuery()) {
                int rowIndex = 0; // row index initialized to track which probability is being compared

                // iterate through the stored probabilities
                while (rs.next()) {
                    double actualProbability = rs.getDouble("probability");
                    int slotCounter = rs.getInt("slot_counter");

                    // looping through slotCounter to expand the combined hours in the database
                    for (int i = 0; i < slotCounter; i++) {
                        if (rowIndex < probabilities[1].length) {
                            // retrieve pre-calculated probabilities
                            double expectedProbability = probabilities[1][rowIndex];
                            System.out.println("Row " + rowIndex + ": Expected = " + expectedProbability + ", Actual = " + actualProbability);

                            assertEquals(expectedProbability, actualProbability, 0.0001);
                            rowIndex++;
                        } else {
                            System.out.println("No expected probability for Row " + rowIndex);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}