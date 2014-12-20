#!/usr/bin/env escript
%% -*- erlang -*-

reverse([]) -> [];
reverse([E|L]) -> reverse(L) ++ [E].

split([], _) -> [];
split(List, E) -> split(List, E, [], []).

split([], _, Res, Current) -> Res ++ [Current];
split([E|L], E, Res, Current) -> Res ++ [Current] ++ split(L, E);
split([E|L], P, Res, Current) -> split(L, P, Res, Current ++ [E]).

join([], _) -> [];
join(List, Pattern) -> join(List, Pattern, []).

join([], _, Result) -> Result;
join([Element|[]], _, _) -> Element;
join([Element|List], Pattern, _) -> Element ++ Pattern ++ join(List, Pattern).

main(_) ->
  io:fwrite(join(reverse(split(reverse("that's something very interesting"), $ )), " ")),
  io:fwrite('\n').
