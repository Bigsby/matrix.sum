-module(consoleUtil).
-export([prompt/1,displayMatrixResult/1]).

-include("results.hrl").

prompt(Question) ->
    io:get_line(Question ++ "\n").

getMatrix(RowIndex, ColumnIndex, Matrix) ->
    Row = array:get(RowIndex, Matrix),
    array:get(ColumnIndex, Row).

displayMatrixResult(Result) ->
    Matrix = Result#matrixResult.matrix,
    Side = Result#matrixResult.side,
    [StringSquare] = io_lib:format("~w", [Side * Side]),
    Length = max(length(StringSquare) + 1, 2),
    lists:foreach(fun(RowIndex) -> 
        lists:foreach(fun(ColumnIndex) -> 
            getMatrix(RowIndex, ColumnIndex, Matrix),
            io:fwrite(string:right(integer_to_list(getMatrix(RowIndex, ColumnIndex, Matrix)), Length))
        end, lists:seq(0, Side - 1)),
        io:fwrite("~n")
    end, lists:seq(0, Side - 1)).