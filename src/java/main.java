import results.*;

public class main {
    private static results.parseSideInput ParseSideInput(String inputSide){
        if (inputSide.matches("^[0-9]+$")){
            return new results.parseSideInput(Integer.parseInt(inputSide));
        }else{
            return new results.parseSideInput("Side input not valid!");
        }
    }

    private static void ErrorOut(String message){
        System.out.println(message);
        System.exit(0);
    }

    public static void main(String[] args) {
        String inputSide = "";
        if (args.length == 0) {
            inputSide = consoleUtil.Prompt("Input side (odd):");
        }else{
            inputSide = args[0];
        }

        results.parseSideInput parseResult = ParseSideInput(inputSide);

        if (parseResult.getSuccess()){
            try{
                results.matrixResult result = matrixCalculator.Calculate(parseResult.getSide());

                if (result.getSuccess()){
                    System.out.println("Matrix calculated successfully!");
                    consoleUtil.DisplayMatrixResult(result);
                }else{
                    System.out.println("Error calculating matrix!!!");
                }
            } catch(Exception ex){
                ErrorOut(ex.getMessage());
            }
        }else{
            ErrorOut(parseResult.getErrorMessage());
        }
    }

}

/*
To compile run in the CLI:
> javac .\*.java .\results\*.java

To execute run in the CLI:
> java main
or provie the side:
> java main 5
*/