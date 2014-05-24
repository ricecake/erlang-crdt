-module(orSet).
-export([new/0, lookup/2, add/2, remove/2]).

-record(orset, {}).

new() -> ok.
lookup(Self, Key) -> ok.
add(Self, Key) -> ok.
remove(Self, Key) -> ok.
