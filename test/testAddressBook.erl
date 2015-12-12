%%%-------------------------------------------------------------------
%%% @author onegrx
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Dec 2015 00:21
%%%-------------------------------------------------------------------
-module(testAddressBook).
-author("onegrx").

-include_lib("eunit/include/eunit.hrl").

empty_address_book_test() ->
  [] = addressBook:createAddressBook().

add_contact_test() ->
  AB = addressBook:createAddressBook(),
  AB1 = addressBook:addContact("Will", "Smith", AB),
  [H|_] = AB1,
  {E, Person, Phone, Email} = H,
  ?assertEqual(entry, E),
  ?assertEqual({"Will", "Smith"}, Person),
  ?assertEqual([], Phone),
  ?assertEqual([], Email).

add_email_for_existing_person_test() ->
  AB = addressBook:createAddressBook(),
  AB1 = addressBook:addContact("Will", "Smith", AB),
  AB2 = addressBook:addEmail("Will", "Smith", "will@smith.com", AB1),
  [H|_] = AB2,
  {_, _, _, Email} = H,
  ?assertEqual(["will@smith.com"], Email).
