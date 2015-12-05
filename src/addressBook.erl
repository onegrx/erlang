%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Nov 2015 10:56
%%%-------------------------------------------------------------------
-module(addressBook).
-author("onegrx").

%% API
-export([createAddressBook/0, addContact/3]).

-record(entry, {person, phone, email}).

createAddressBook() -> [].

addContact(Name, Surname, AddressBook) ->
  case isAlready(Name, Surname, AddressBook) of
    false -> [#entry{person = {Name, Surname}}|AddressBook];
    _ -> {error, "This entry already exists"}
  end.

isAlready(_, _, []) -> false;
isAlready(Name, Surname, [#entry{person = {Name, Surname}}|_]) -> true;
isAlready(Name, Surname, [_|T]) -> isAlready(Name, Surname, T).