-module(main).
-export([start/0]).
-include("results.hrl").

parseSideInput(InputSide) ->
    case re:run(InputSide, "^[0-9]+$") of
        {match, _} -> 
            {ParsedSide, _} = string:to_integer(InputSide),
            #parseSideResult{success=true,side=ParsedSide};
            %{success, ParsedSide};
        nomatch ->  #parseSideResult{errorMessage="Side input not valid!"}
        %{failed, "Side input not valid!"}
    end.

errorOut(Message) ->
    io:fwrite(Message),
    erlang:halt().

start() ->
    Args = init:get_plain_arguments(),

    InputSide = if 
        length(Args) > 0 -> lists:nth(1, Args);
        true -> consoleUtil:prompt("Input side (odd):")
    end,

    ParseSideResult = parseSideInput(InputSide),
    case ParseSideResult#parseSideResult.success of
        true -> 
            try
                Result = matrixCalculator:calculate(ParseSideResult#parseSideResult.side),
                
                case Result#matrixResult.success of
                    true -> consoleUtil:displayMatrixResult(Result);
                    false -> io:fwrite("Error calculating matrix!!!")
                end 
            catch
                throw:Message -> errorOut(Message)
            end;
        false -> errorOut(ParseSideResult#parseSideResult.errorMessage)
    end,

    erlang:halt().

% To compile run in the CLI:
% > erl -compile consoleUtil matrixCalculator main

% To execute run in the CLI:
% > erl -noshell -run main
% or provie the side:
% > erl -noshell -run main -- 5