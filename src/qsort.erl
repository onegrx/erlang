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
-export([qs/1]).

lessThan(List, Arg) -> [X || X <- List, X < Arg].
grtEqThan(List, Arg) -> [X || X <- List, X >= Arg].

qs([]) ->[];
qs([Pivot|Tail]) ->
  qs(lessThan(Tail,Pivot)) ++ [Pivot] ++ qs(grtEqThan(Tail,Pivot)).