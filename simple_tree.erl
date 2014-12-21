%% -*- erlang -*-
-module(simple_tree).
-export([empty/0, insert/3, search/2]).

empty() -> {node, 'nil'}.

insert(Key, Value, {node, 'nil'}) ->
  {node, {Key, Value, empty(), empty()}};
insert(NewKey, NewValue, {node, {Key, Value, Smaller, Larger}}) when NewKey < Key ->
  {node, {Key, Value, insert(NewKey, NewValue, Smaller), Larger}};
insert(NewKey, NewValue, {node, {Key, Value, Smaller, Larger}}) when NewKey >= Key ->
  {node, {Key, Value, Smaller, insert(NewKey, NewValue, Larger)}};
insert(Key, NewValue, {node, {Key, _, Smaller, Larger}}) ->
  {node, {Key, NewValue, Smaller, Larger}}.

search(_, {node, 'nil'}) ->
  undefined;
search(Key, {node, {Key, Value, _, _}}) ->
  {ok, Value};
search(Key, {node, {CurrentKey, _, Smaller, _}}) when Key < CurrentKey ->
  search(Key, Smaller);
search(Key, {node, {CurrentKey, _, _, Larger}}) when Key >= CurrentKey ->
  search(Key, Larger).
