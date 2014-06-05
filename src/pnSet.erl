-module(pnSet).
-export([new/0, lookup/2, list/1, add/2, remove/2, merge/2, apply/2, gc/1]).

-record(pnset, {store}).

% operations should return {Status, NewStructure, Operation}
% should make it pretty easy to share either the structure or
% the operation, depending on needs

new() ->
	Store = dict:new(),
	#pnset{store = Store}.

lookup(#pnset{store=Store}, Key) ->
	case dict:find(Key, Store) of
		{ok, Value} when Value > 0 -> true;
		{ok, Value} when Value < 1 -> false;
		error -> false
	end.

add(Store, Key) -> 
	case lookup(Store, Key) of
		true -> {ok, Store, {add, Key, 0}};
		false-> do_add(Store, Key)
	end.

do_add(#pnset{store = Store} = Self, Key) -> 
	Increment = case dict:find(Key, Store) of
		{ok, Value} when Value > 0 -> 1;
		{ok, Value} when Value < 1 -> abs(Value)+1;
		error -> 1
	end,
	NewStore = dict:update_counter(Key, Increment, Store),
	{ok, Self#pnset{store = NewStore}, {add, Key, Increment}};
do_add(#pnset{store = Store} = Self, {add, Key, Increment}) -> 
	NewStore = dict:update_counter(Key, Increment, Store),
	{ok, Self#pnset{store = NewStore}, {add, Key, Increment}};

remove(#pnset{store = Store} = Self, Key) -> 
	NewStore = dict:update_counter(Key, -1, Store),
	{ok, Self#pnset{store = NewStore}, {del, Key}}.

list(#pnset{store = Store}) -> 
	[ Item || {Item, Count} <- dict:to_list(Store), Count > 0].

merge(#pnset{store = Fstore}, #pnset{store = Sstore}) ->
	NewStore = lists:foldl(fun({Key, Count}, Store)-> dict:update_counter(Key, Count, Store) end, Fstore, dict:to_list(Sstore)),
	#pnset{store = NewStore}.

apply(State, {add, Key}) -> do_add(State, Key);
apply(State, {del, Key}) -> remove(State, Key).

gc(#pnset{store = Store}) ->
	NewList = [ {Item, Count} || {Item, Count} <- dict:to_list(Store), Count /= 0],
	#pnset{store = dict:from_list(NewList)}.

