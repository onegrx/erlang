%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Nov 2015 09:52
%%%-------------------------------------------------------------------
-module(myFunctions).
-author("onegrx").

%% API
-export([
  power/2, contains/2, tailpower/2, duplicateElements/1, divisibleBy/2, toBinary/1
]).

power(0, _) -> 0;
power(_, 0) -> 1;
power(A, N) when N > 0 -> A * power(A, N - 1).

tailpower(A, N) -> tailpower(A, N, 1).
tailpower(_, 0, Acc) -> Acc;
tailpower(A, N, Acc) -> tailpower(A, N - 1, Acc *A).

contains([], _) -> false;
contains([A|_], A) -> true;
contains([_|T], A) -> contains(T, A).

duplicateElements([]) -> [];
duplicateElements([H|T]) -> [H,H | duplicateElements(T)].

divisibleBy(List, Factor) -> divisibleBy(List, Factor, []).
divisibleBy([], _, Acc) -> Acc;
divisibleBy([H|T], Factor, Acc) when H rem Factor == 0 -> [H|divisibleBy(T, Factor, Acc)];
divisibleBy([_|T], Factor, Acc) -> divisibleBy(T, Factor, Acc).

toBinary(N) -> toBinary(N, []).
toBinary(0, T) -> T;
toBinary(N, T) -> toBinary(N div 2, [N rem 2 + 48|T]). % +48 is a hack to convert from 0 to '0'