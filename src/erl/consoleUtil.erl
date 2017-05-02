-module(consoleUtil).
-export([prompt/1,displayMatrixResult/1]).

-include("results.hrl").

prompt(Question) ->
    io:get_line(Question ++ "\n").

displayMatrixResult(Result) ->
    io:fwrite("Displaying matrix").
