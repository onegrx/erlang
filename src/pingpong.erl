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
-export([loop/0]).

start() ->
  Ping = spawn(?MODULE, loop, []),
  Pong = spawn(?MODULE, loop, []),
  register(ping, Ping),
  register(pong, Pong).

stop() ->
  ping ! stop,
  pong ! stop.

play(N) ->
  ping ! {pong, N}.

loop() ->
  receive

    {_, 0} -> stop();
    {Pid, N} ->
      timer:sleep(500),
      {_, Name} = process_info(self(), registered_name),
      io:format("In \"~s\". To send: ~p~n", [Name, N]),
      Pid ! {self(), N - 1},
      loop()
  after 20000 -> ok
  end.

