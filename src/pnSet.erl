-module(pnSet).
-export([new/0, lookup/2, add/2, remove/2, merge/2, apply/2]).

-record(orset, {}).

% operations should return {Status, NewStructure, Operation}
% should make it pretty easy to share either the structure or
% the operation, depending on needs

new() -> ok.
lookup(Self, Key) -> ok.
add(Self, Key) -> ok.
remove(Self, Key) -> ok.
