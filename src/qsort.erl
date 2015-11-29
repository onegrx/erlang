%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Nov 2015 17:33
%%%-------------------------------------------------------------------
-module(qsort).
-author("onegrx").

%% API
-export([qs/1, randomElems/3]).

lessThan(List, Arg) -> [X || X <- List, X < Arg].
grtEqThan(List, Arg) -> [X || X <- List, X >= Arg].

qs([]) ->[];
qs([Pivot|Tail]) ->
  qs(lessThan(Tail,Pivot)) ++ [Pivot] ++ qs(grtEqThan(Tail,Pivot)).

randomElems(N, Min, Max) ->
  [random:uniform(Max - Min + 1) + Min - 1 || _ <- lists:seq(1,N)].