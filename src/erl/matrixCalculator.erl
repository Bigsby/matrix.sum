-module(matrixCalculator).
-export([calculate/1]).

-include("results.hrl").

-record(currentHolder,{row, column, startRow, startColumn, side}).

createEmptyMatrix(Side) ->
    Matrix = array:new(Side),
    array:map(fun(_,_) -> array:new(Side) end, Matrix).

% getMatrix(RowIndex, ColumnIndex, Matrix) ->
%     Row = array:get(RowIndex, Matrix),
%     array:get(ColumnIndex, Row).

setMatrix(RowIndex, ColumnIndex, Value, Matrix) ->
    OriginalRow = array:get(RowIndex, Matrix),
    ChangedRow = array:set(ColumnIndex, Value, OriginalRow),
    array:set(RowIndex, ChangedRow, Matrix).

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

calculate(Side) ->
    if
        Side rem 2 == 0 -> throw("Side needs to be an odd number.");
        true -> ok
    end,

    % Matrix = array_2d:new(3, 3),
    % Matrix2 = array_2d:set(0, 1, 7, Matrix),
    % io:fwrite("~w~n~w", [array_2d:get(0, 1, Matrix2), Matrix2]),
    % ok.

    ExpectedSum = round(Side * (Side * Side + 1) / 2),
    put(matrix, createEmptyMatrix(Side)),
    StartRow = round(-(Side - 1) / 2),
    StartColumn = round((Side - 1) / 2),
    %io:fwrite("StartRow: ~w, StartColumn: ~w~n", [StartRow, StartColumn]),
    put(current, #currentHolder{row=StartRow, column=StartColumn, startRow=StartRow, startColumn=StartColumn, side=Side}),

    lists:foreach(fun (Count) -> 
        Current = get(current),
        Matrix = get(matrix),
        %io:fwrite("[~w,~w] = ~w~n", [actualRow(Current) + 1, actualColumn(Current) + 1, Count]),
        put(matrix, setMatrix(actualRow(Current), actualColumn(Current), Count, Matrix)),
        put(current, getNext(Current, Count))
    end, lists:seq(1, Side * Side)),

    #matrixResult{success=true, matrix=get(matrix), sum=ExpectedSum, side=Side}.

    %{success, get(matrix)}.

    % io:fwrite("calculating for side: ~w.~nExpecting sum: ~w~n", [Side, ExpectedSum]).