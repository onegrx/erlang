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
-export([createAddressBook/0, addContact/3, addEmail/4]).

-record(entry, {person, phone, email}).

createAddressBook() -> [].

addContact(Name, Surname, AddressBook) ->
  case isAlready(Name, Surname, AddressBook) of
    false -> [#entry{person = {Name, Surname}}|AddressBook];
    _ -> {error, "This person already exists"}
  end.

isEmailAlready(_, []) -> false;
isEmailAlready(Email, [#entry{email = Email}|_]) -> true;
isEmailAlready(Email, [_|T]) -> isEmailAlready(Email, T).

addEmail(Name, Surname, Email, AddressBook) ->
  case isEmailAlready(Email, AddressBook) of
    false -> actuallyAddEmail(Name, Surname, Email, AddressBook);
    _ -> {error, "This email already exists"}
  end.


%% The address book is empty
actuallyAddEmail(Name, Surname, Email, []) ->
  [#entry{person = {Name, Surname}, email = Email}];

%% The person already exists and irregardless if he has email or does't it is
%% entered or replaced
actuallyAddEmail(Name, Surname, Email, [#entry{person = {Name, Surname}}|T]) ->
  [#entry{person = {Name, Surname}, email = Email}|T];

%% Continue trying to find the person, in case of failure the tail finally is
%% an empty list and new person is added
actuallyAddEmail(Name, Surname, Email, [H|T]) ->
  [H|actuallyAddEmail(Name, Surname, Email, T)].


isAlready(_, _, []) -> false;
isAlready(Name, Surname, [#entry{person = {Name, Surname}}|_]) -> true;
isAlready(Name, Surname, [_|T]) -> isAlready(Name, Surname, T).