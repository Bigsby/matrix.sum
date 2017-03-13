import results.matrixResult;

public class consoleUtil {
    public static String Prompt(String question){
        System.out.println(question);
        return System.console().readLine();
    }

    public static void DisplayMatrixResult(matrixResult  result){
        int[][] matrix = result.getMatrix();
        int length = Math.max(Integer.toString(result.getSide() * result.getSide()).length() + 1, 2);

        for (int rowIndex = 0; rowIndex < result.getSide(); rowIndex++){
            String rowText = "";
            for (int columnIndex = 0; columnIndex < result.getSide(); columnIndex++){
                rowText += String.format("%" + length + "s", Integer.toString(matrix[rowIndex][columnIndex]));
            }

            System.out.println(rowText);
        }

        System.out.println("Sum: " + result.getSum());
    }
}