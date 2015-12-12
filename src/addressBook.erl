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
%-export([createAddressBook/0, addContact/3, addEmail/4, addPhone/4]).
%-export([removeContact/3, removeEmail/2]).
-compile(export_all).
-record(entry, {person, phone = [], email= []}).

createAddressBook() -> [].

addContact(Name, Surname, AddressBook) ->
  case isAlreadyPerson(Name, Surname, AddressBook) of
    false -> [#entry{person = {Name, Surname}}|AddressBook];
    _ -> {error, "This person already exists"}
  end.

addEmail(Name, Surname, Email, AddressBook) ->
  case isEmailAlready(Email, AddressBook) of
    false -> actuallyAddEmail(Name, Surname, Email, AddressBook);
    _ -> {error, "This email already exists"}
  end.

addPhone(Name, Surname, Phone, AddressBook) ->
  case isPhoneAlready(Phone, AddressBook) of
    false -> actuallyAddPhone(Name, Surname, Phone, AddressBook);
    _ -> {error, "This phone already exists"}
  end.

removeContact(Name, Surname, AddressBook) ->
  case isAlreadyPerson(Name, Surname, AddressBook) of
    true -> actuallyRemoveContact(Name, Surname, AddressBook);
    _ -> {error, "The contact does't appear in the address book"}
  end.

removeEmail(Email, AddressBook) ->
  case isEmailAlready(Email, AddressBook) of
    true -> actuallyRemoveEmail(Email, AddressBook);
    _ -> {error, "The email doesn't appear in the address book"}
  end.




%% Functions which are not exposed to API

isEmailAlready(_, []) -> false;
isEmailAlready(Email, [#entry{email = Email}|_]) -> true;
isEmailAlready(Email, [_|T]) -> isEmailAlready(Email, T).

isPhoneAlready(_, []) -> false;
isPhoneAlready(Phone, [#entry{phone = Phone}|_]) -> true;
isPhoneAlready(Phone, [_|T]) -> isPhoneAlready(Phone, T).

%% The address book is empty
actuallyAddEmail(Name, Surname, Email, []) ->
  [#entry{person = {Name, Surname}, email = [Email]}];

%% The person already exists and irregardless if he has email or does't it is
%% entered or replaced
actuallyAddEmail(Name, Surname, Email, [#entry{person = {Name, Surname}, email = OldEmail}|T]) ->
  [#entry{person = {Name, Surname}, email = [Email|OldEmail]}|T];

%% Continue trying to find the person, in case of failure the tail finally is
%% an empty list and new person is added
actuallyAddEmail(Name, Surname, Email, [H|T]) ->
  [H|actuallyAddEmail(Name, Surname, Email, T)].

actuallyAddPhone(Name, Surname, Phone, []) ->
  [#entry{person = {Name, Surname}, phone = Phone}];
actuallyAddPhone(Name, Surname, Phone, [#entry{person = {Name, Surname}}|T]) ->
  [#entry{person = {Name, Surname}, phone = Phone}|T];
actuallyAddPhone(Name, Surname, Phone, [H|T]) ->
  [H|actuallyAddEmail(Name, Surname, Phone, T)].

isAlreadyPerson(_, _, []) -> false;
isAlreadyPerson(Name, Surname, [#entry{person = {Name, Surname}}|_]) -> true;
isAlreadyPerson(Name, Surname, [_|T]) -> isAlreadyPerson(Name, Surname, T).

actuallyRemoveContact(_, _, []) -> [];
actuallyRemoveContact(Name, Surname, [#entry{person = {Name, Surname}}|T]) ->
  T;
actuallyRemoveContact(Name, Surname, [H|T]) ->
  [H|actuallyRemoveContact(Name, Surname, T)].

actuallyRemoveEmail(_, []) -> [];
actuallyRemoveEmail(Email, [#entry{email = Email, person = Person, phone = Phone}|T]) ->
  [#entry{person = Person, phone = Phone}|T];
actuallyRemoveEmail(Email, [H|T]) -> [H|actuallyRemoveEmail(Email, T)].


% Checks if given Email is unique in whole AddressBook
% Returns true if uniqueness is confirmed, otherwise false
emailExists(Email, AddressBook) ->
  lists:any(
    fun(#entry{email = E}) -> lists:member(Email, E) end,
    AddressBook
  ).

% Checks if given Phone is unique in whole AddressBook
% Returns true if uniqueness is confirmed, otherwise false
phoneExists(Phone, AddressBook) ->
  lists:any(
    fun(#entry{phone = P}) -> lists:member(Phone, P) end,
    AddressBook
  ).

