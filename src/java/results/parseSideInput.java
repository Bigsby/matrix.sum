package results;

public class parseSideInput{
    private final boolean success;
    private String errorMessage;
    private int side;
    private parseSideInput(boolean success){
        this.success = success;
    }

    public parseSideInput(int side){
        this(true);
        this.side = side;
    }

    public parseSideInput(String errorMessage){
        this(false);
        this.errorMessage = errorMessage;
    }

    public boolean getSuccess(){
        return this.success;
    }

    public int getSide(){
        return this.side;
    }

    public String getErrorMessage(){
        return this.errorMessage;
    }
}
