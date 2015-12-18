%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Dec 2015 02:57
%%%-------------------------------------------------------------------
-module(pingpong).
-author("onegrx").

%% API
-export([start/0, stop/0, play/1]).

start() ->
  register(ping, spawn(?MODULE, function, [])),
  register(pong, spawn(?MODULE, function, [])).

stop() ->
  ping ! stop,
  pong ! stop.

play(N) ->
  ping ! N.