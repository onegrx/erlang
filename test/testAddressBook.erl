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

add_email_for_nonexistent_person_test() ->
  AB = addressBook:createAddressBook(),
  AB1 = addressBook:addEmail("Will", "Smith", "will@smith.com", AB),
  [H|_] = AB1,
  {_, Person, _, Email} = H,
  ?assertEqual({"Will", "Smith"}, Person),
  ?assertEqual(["will@smith.com"], Email).

remove_contact_test() ->
  AB = addressBook:createAddressBook(),
  AB1 = addressBook:addEmail("John", "Doe", "john@doe.com", AB),
  AB2 = addressBook:addContact("Will", "Smith", AB1),
  AB3 = addressBook:removeContact("Will", "Smith", AB2),
  [_|EmptyTail] = AB3,
  AB4 = addressBook:removeContact("John", "Doe", AB3),
  ?assertEqual([], EmptyTail),
  ?assertNotEqual([], AB3),
  ?assertEqual([], AB4).

remove_email_from_list_of_emails_test() ->
  AB = addressBook:createAddressBook(),
  AB1 = addressBook:addEmail("John", "Doe", "john@doe.com", AB),
  AB2 = addressBook:addEmail("John", "Doe", "brandnewjohnmail@doe.com", AB1),
  AB3 = addressBook:removeEmail("john@doe.com", AB2),
  [{_, _, _, TwoEmailsList}|_] = AB2,
  [{_, _, _, OneEmailList}|_] = AB3,
  [TheOneEmail|_] = OneEmailList,
  ?assertEqual(2, length(TwoEmailsList)),
  ?assertEqual(1, length(OneEmailList)),
  ?assertEqual("brandnewjohnmail@doe.com", TheOneEmail),
  ?assert(lists:member("john@doe.com", TwoEmailsList)),
  ?assertNot(lists:member("john@doe.com", OneEmailList)),
  ?assert(lists:member("brandnewjohnmail@doe.com", OneEmailList)).
