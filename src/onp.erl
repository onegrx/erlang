%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Nov 2015 11:49
%%%-------------------------------------------------------------------
-module(onp).
-author("onegrx").

%% API
-export([onp/1]).

% Expression as string eg. onp("3 4 +").
onp(Expression) ->
  List = string:tokens(Expression, " "),
  eval(List, []).

eval([], []) -> io:format("Empty list ~n");
%eval([], [H|_]) -> H;
eval([], Result) -> Result;

eval(["+"|T], [A,B|Rest]) -> eval(T, [B+A|Rest]);
eval(["-"|T], [A,B|Rest]) -> eval(T, [B-A|Rest]);
eval(["*"|T], [A,B|Rest]) -> eval(T, [B*A|Rest]);
eval(["/"|T], [A,B|Rest]) -> eval(T, [B/A|Rest]);
eval(["sqrt"|T], [A|Rest]) -> eval(T, [math:sqrt(A)|Rest]);



%eval([H|T], Stack) -> eval(T, [list_to_integer(H)|Stack]).
eval([H|T], Stack) -> eval(T, [list_to_float(H)|Stack]).
