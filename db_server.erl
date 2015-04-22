-module(db_server).

-export([start/0, loop/1]).


start() ->
    DbRef = db:new(),
    spawn_link(?MODULE, loop, [DbRef]).


loop(DbRef) ->
    receive
        {Client, {write, Args}} ->
            {Key, Data} = Args,
            NewDbRef = db:write(Key, Data, DbRef),
            Client ! {self(), ok},
            loop(NewDbRef);
        {Client, {read, KeyToRead}} ->
            Client ! {self(), db:read(KeyToRead, DbRef)}
    end,
    loop(DbRef).
