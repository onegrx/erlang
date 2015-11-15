%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Nov 2015 21:23
%%%-------------------------------------------------------------------
-module(list_operations).
-author("onegrx").

%% API
-export([len/1, sum/1]).


len([]) -> 0;
len([_|T]) -> 1 + len(T).

sum([]) -> 0;
sum([H|T]) -> H + sum(T).




