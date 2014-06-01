-module(orSet).
-export([new/0, lookup/2, add/2, remove/2, merge/2, apply/2]).

-record(orset, {store}).

% operations should return {Status, NewStructure, Operation}
% should make it pretty easy to share either the structure or
% the operation, depending on needs

new() -> #orset{store = dict:new()}.
lookup(Self, Key) -> ok.
add(#orset{store = Store}, Key) -> 
	SubMap = case dict:find(Key, Store) of 
		{ok, Value} -> Value;
		error       -> dict:new()
	end,
	ok.
remove(Self, Key) -> ok.
merge(Self, Key) -> ok.
apply(Self, Key) -> ok.
