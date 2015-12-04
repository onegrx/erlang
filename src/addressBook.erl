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
-export([createAdressBook/0, addContact/3]).

-record(entry, {name, surname, phone, email}).

createAdressBook() -> [].

addContact(Name, Surname, AdressBook) ->
  case isAlready(Name, Surname, AdressBook) of
    false -> [#entry{name = Name, surname = Surname}|AdressBook];
    _ -> {error, "This entry already exists"}
end.

isAlready(_, _, []) -> false;
isAlready(Name, Surname, [#entry{name = Name, surname = Surname}|_]) -> true;
isAlready(Name, Surname, [_|T]) -> isAlready(Name, Surname, T).