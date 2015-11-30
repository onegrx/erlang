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
-export([qs/1, randomElems/3, quicksortVsSort/0, map/2, filter/2]).

lessThan(List, Arg) -> [X || X <- List, X < Arg].
grtEqThan(List, Arg) -> [X || X <- List, X >= Arg].

qs([]) ->[];
qs([Pivot|Tail]) ->
  qs(lessThan(Tail,Pivot)) ++ [Pivot] ++ qs(grtEqThan(Tail,Pivot)).

randomElems(N, Min, Max) ->
  [random:uniform(Max - Min + 1) + Min - 1 || _ <- lists:seq(1,N)].

compareSpeeds(List, Fun1, Fun2) ->
  {Time1, _} = timer:tc(?MODULE, Fun1, [List]),
  {Time2, _} = timer:tc(lists, Fun2, [List]),
  TimeDiff = Time1 - Time2,
  io:format("lists:~s is faster than ~s:~s by ~s microsecunds~n",
    [Fun2, ?MODULE, Fun1, integer_to_list(TimeDiff)]).

quicksortVsSort() ->
  compareSpeeds(randomElems(10000, 1, 100000), qs, sort).

map(Fun, List) ->
  [Fun(X) || X <- List].

filter(Fun, List) ->
  [X || X <- List, Fun(X)].