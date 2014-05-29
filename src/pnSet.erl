-module(pnSet).
-export([new/0, lookup/2, list/1, add/2, remove/2, merge/2, apply/2]).

-record(pnset, {store}).

% operations should return {Status, NewStructure, Operation}
% should make it pretty easy to share either the structure or
% the operation, depending on needs

new() ->
	Store = dict:new(),
	#pnset{store = Store}.

lookup(#pnset{store=Store} = Self, Key) ->
	case dict:find(Key, Store) of
		{ok, Value} when Value > 0 -> true;
		{ok, Value} -> false;
		error -> false
	end.

add(#pnset{store = Store} = Self, Key) -> 
	NewStore = dict:update_counter(Key, 1, Store),
	Self#pnset{store = NewStore}.

remove(#pnset{store = Store} = Self, Key) -> 
	NewStore = dict:update_counter(Key, -1, Store),
	Self#pnset{store = NewStore}.

list(#pnset{store = Store} = State) -> 
	[ Item || {Item, Count} <- dict:to_list(Store), Count > 0].

merge(First, Second) -> ok.
apply(State, Op) -> ok.
