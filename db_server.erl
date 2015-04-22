-module(db_server).

-export([start/0, loop/1, stop/0, write/2, read/1, delete/1, match/1]).


start() ->
    DbRef = db:new(),
    Pid = spawn_link(?MODULE, loop, [DbRef]),
    register(db_server_process, Pid).


stop() ->
    db_server_process ! {self(), stop},
    receive
        {ok, _} ->
            ok
        after 100 ->
            timeout
    end.


write(Key, Element) ->
    db_server_process ! {self(), {write, {Key, Element}}},
    receive_result().


read(Key) ->
    db_server_process ! {self(), {read, Key}},
    receive_result().


delete(Key) ->
    db_server_process ! {self(), {delete, Key}},
    receive_result().


match(Element) ->
    db_server_process ! {self(), {match, Element}},
    receive_result().


receive_result() ->
    receive
        Result -> Result
        after 100 -> timeout
    end.


loop(DbRef) ->
    receive
        {Client, {write, Args}} ->
            {Key, Data} = Args,
            NewDbRef = db:write(Key, Data, DbRef),
            Client ! {ok},
            loop(NewDbRef);
        {Client, {read, Key}} ->
            Client ! db:read(Key, DbRef);
        {Client, {delete, Key}} ->
            NewDbRef = db:delete(Key, DbRef),
            Client ! {ok},
            loop(NewDbRef);
        {Client, {match, Element}} ->
            Client ! {ok, db:match(Element, DbRef)};
        {Client, stop} ->
            Client ! {ok, stopped},
            exit(self(), client_stop)
    end,
    loop(DbRef).
