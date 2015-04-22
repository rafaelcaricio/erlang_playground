-module(misc).
-export([factorial/1, member/2, len/1, index_of/2]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

member(H, [H|_]) -> true;
member(H, [_|T]) -> member(H, T);
member(_, []) -> false.

len(Xs) -> len(Xs, 0).

len([], Acc) -> Acc;
len([_|Xs], Acc) -> len(Xs, Acc + 1).

index_of(_, []) -> -1;
index_of(E, L) -> index_of(E, L, 0).

index_of(E, [E|_], Pos) -> Pos;
index_of(E, [_|L], Pos) -> index_of(E, L, Pos + 1);
index_of(_, [], _) -> -1.
