#!/usr/bin/env escript
%% -*- erlang -*-

reverse([]) -> [];
reverse(List) -> reverse(List, []).

reverse([], Accumulator) -> Accumulator;
reverse([Element|List], Accumulator) -> reverse(List, [Element|Accumulator]).

split([], _) -> [];
split(List, Pattern) -> split(List, Pattern, []).

split([], _, Current) -> [Current];
split([Pattern|List], Pattern, Current) -> [Current|split(List, Pattern)];
split([Element|List], Pattern, Current) -> split(List, Pattern, [Current|[Element]]).

join([], _) -> [];
join([Element|[]], _) -> Element;
join([Element|List], Pattern) -> [[Element|Pattern]|join(List, Pattern)].

main(_) ->
  Result = join(reverse(split(reverse("that's something very interesting"), $ )), " "),
  io:format(Result).
