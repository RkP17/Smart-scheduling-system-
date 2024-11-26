

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import ssh.example.SSH;

public class SSHTest {
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
        assertEquals(0.0, probabilities[2][2]); // Wednesday, 2am

        
    }
    
}
