%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Nov 2015 20:33
%%%-------------------------------------------------------------------
-module(factorial).
-author("onegrx").

%% API
-export([factorial/1]).


factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).
