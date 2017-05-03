-module(matrixCalculator).
-export([calculate/1]).

-include("results.hrl").

-record(currentHolder,{matrix, row, column, startRow, startColumn, side}).

createEmptyMatrix(Side) ->
    Matrix = array:new(Side, fixed),
    array:map(fun(_,_) -> array:new(Side, fixed) end, Matrix).
    
actual(Value, Side) ->
    if 
        Value < 0 -> Value + Side;
        Value >= Side -> Value - Side;
        true -> Value
    end.

actualRow(Current) ->
    actual(Current#currentHolder.row, Current#currentHolder.side).

actualColumn(Current) ->
    actual(Current#currentHolder.column, Current#currentHolder.side).

getNext(Current, Count) ->
    if 
        Count rem Current#currentHolder.side /= 0 ->
            Current#currentHolder{row=Current#currentHolder.row + 1, column=Current#currentHolder.column + 1};
        true ->
            StartRow = Current#currentHolder.startRow + 1,
            StartColumn = Current#currentHolder.startColumn - 1,
            Current#currentHolder{row=StartRow, column=StartColumn, startRow=StartRow, startColumn=StartColumn}
    end.

testResult(Matrix, ExpectedSum, Side) ->
    IndexList = lists:seq(0, Side - 1),
    GetMatrix = fun(RowIndex, ColumnIndex) ->
        Row = array:get(RowIndex, Matrix),
        array:get(ColumnIndex, Row)
    end,

    RowsGetter = fun() ->
        lists:map(
            fun(RowIndex) -> 
                array:to_list(array:map(fun(_, Column) -> array:get(RowIndex, Column) end, Matrix))
            end,
            IndexList)
    end,

    ColumnsGetter = fun() ->
        array:foldl(fun(_, Row, Acc) -> lists:merge([array:to_list(Row)], Acc) end, [], Matrix)
    end,

    FirstDiagonalGetter = fun() ->
        [lists:map(
            fun(Index) ->
                GetMatrix(Index, Index)
            end,
            IndexList)]
    end,

    SecondDiagonalGetter = fun() ->
        [lists:map(
            fun(Index) ->
                GetMatrix(Index, Side - Index - 1)
            end,
            IndexList)]
    end,

    Sum = fun(List) -> lists:foldl(fun(Value, Acc) -> Value + Acc end, 0, List) end,

    lists:all(
        fun(ValuesGetter) -> 
            lists:all(
                fun(ValueList) -> Sum(ValueList) == ExpectedSum end, 
                ValuesGetter())
        end,
        [
            RowsGetter, 
            ColumnsGetter, 
            FirstDiagonalGetter, 
            SecondDiagonalGetter
        ]).

calculate(Side) ->
    if
        Side rem 2 == 0 -> throw("Side needs to be an odd number.");
        true -> ok
    end,

    ExpectedSum = round(Side * (Side * Side + 1) / 2),
    put(matrix, createEmptyMatrix(Side)),
    StartRow = round(-(Side - 1) / 2),
    StartColumn = round((Side - 1) / 2),

    SetMatrix = fun (RowIndex, ColumnIndex, Value, Matrix) ->
        OriginalRow = array:get(RowIndex, Matrix),
        ChangedRow = array:set(ColumnIndex, Value, OriginalRow),
        array:set(RowIndex, ChangedRow, Matrix)
    end,

    Result = lists:foldl(
        fun(Count, Current) ->
            Matrix = Current#currentHolder.matrix,      
            getNext(Current#currentHolder{matrix=SetMatrix(actualRow(Current), actualColumn(Current), Count, Matrix)}, Count)
        end, 
        #currentHolder{
                matrix=createEmptyMatrix(Side), 
                row=StartRow, 
                column=StartColumn, 
                startRow=StartRow, 
                startColumn=StartColumn, 
                side=Side},
        lists:seq(1, Side * Side)
    ),

    #matrixResult{
        success=testResult(Result#currentHolder.matrix, ExpectedSum, Side), 
        matrix=Result#currentHolder.matrix, 
        sum=ExpectedSum, 
        side=Side
    }.