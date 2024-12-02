
import ssh.example.SSH;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;




public class SSHTest {

    //Testing the database
    @Test
    public void testDatabase(){
        List<Map<String, Object>> result = SSH.Database(0);
        LocalDateTime time = (LocalDateTime) result.get(0).get("timestamp");
        LocalDateTime expected = LocalDateTime.parse("2024-11-18T07:30");
        assertEquals(expected, time);

        int end = result.size() - 1;
        time = (LocalDateTime) result.get(end).get("timestamp");
        expected = LocalDateTime.parse("2024-12-15T17:00");
        assertEquals(expected, time);
    }

    //Testing that the presence matrix is marked correctly
    @Test
    public void testPopulateRecords(){
        int[][] matrix = new int[1][24];
        DayOfWeek day = DayOfWeek.MONDAY;

        //Case: returned at 7:59 and stayed until 11:35
        SSH.markPresence(matrix, day, 479, 695);
        assertEquals(0, matrix[0][7]);
        assertEquals(1, matrix[0][8]);
        assertEquals(1, matrix[0][11]);

        //Case: returned at 12:31 and stayed until 16:30
        SSH.markPresence(matrix, day, 751, 990);
        assertEquals(0, matrix[0][12]);
        assertEquals(1, matrix[0][13]);
        assertEquals(1, matrix[0][16]);
    }

    @Test
    public void testPresenceMatrices(){
        List<Map<String, Object>> result = SSH.Database(2);
        List<int[][]> presenceMatrices = SSH.cleanData(result);

        //Below is an expected presence matrix of student 2 for the week starting 18/11/24
        int [][] expected = {
            //   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23
                {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0}, // Mon 0
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0}, // Tue 1
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1}, // Wed 2
                {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1}, // Thur 3
                {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, // Fri 4
                {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1}, // Sat 5
                {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0}  // Sun 6
        };

        //Testing that the list of matrices is of the correct size
        assertEquals(4, presenceMatrices.size());

        //Testing random entries
        assertEquals(expected[0][17], presenceMatrices.get(3)[0][17]);
        assertEquals(expected[1][23], presenceMatrices.get(3)[1][23]);
        assertEquals(expected[6][8], presenceMatrices.get(3)[6][8]);
        assertEquals(expected[3][15], presenceMatrices.get(3)[3][15]);
        assertEquals(expected[3][14], presenceMatrices.get(3)[3][14]);
    }

    @Test

    public void testCalculate_singleWeek(){
        List<int[][]> presenceMatrices=new ArrayList<>();
        presenceMatrices.add(new int[][]{
        //   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 
            {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Mon 0
            {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Tue 1
            {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Wed 2
            {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Thur 3
            {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Fri 4
            {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Sat 5
            {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}  // Sun 6
        });
//calls the function
        double[][] probabilities=SSH.calculate(presenceMatrices);

        assertEquals(1.0, probabilities[0][0]); // Monday, 12am
        assertEquals(0.0, probabilities[0][1]); // Monday, 1am
        assertEquals(1.0, probabilities[1][1]); // Tuesday, 1am
        assertEquals(1.0, probabilities[2][2]); // Wednesday, 2am

        
    }

    @Test
    public void testCalculate_mulitpleWeek(){

        List<int[][]> presenceMatrices=new ArrayList<>();
        presenceMatrices.add(new int[][]{
        //   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 
            {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Mon 0
            {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Tue 1
            {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Wed 2
            {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Thur 3
            {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Fri 4
            {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Sat 5
            {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}  // Sun 6
        });

        presenceMatrices.add(new int[][]{
            //   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Mon 0
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Tue 1
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Wed 2
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Thur 3
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Fri 4
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // Sat 5
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}  // Sun 6
            });
//calls the function
        double[][] probabilities=SSH.calculate(presenceMatrices);

        assertEquals(0.5, probabilities[0][0]); // Monday, 12am
        assertEquals(0.5, probabilities[0][1]); // Monday, 1am
        assertEquals(0.5, probabilities[1][1]); // Tuesday, 1am
        assertEquals(0.5, probabilities[2][2]); // Wednesday, 2am

        
    }

    
}
