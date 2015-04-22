-module(db).

-export([
        new/0,
        write/3,
        delete/2,
        read/2,
        match/2
    ]).

-record(database, {
          file_name,
          cache=[]
        }).


new() ->
    DbFile = 'db.txt',
    #database{file_name=DbFile}.


write(Key, Element, DbRef = #database{cache = DbData}) ->
    NewDbData = [{Key, Element}|DbData],
    DbRef#database{cache = NewDbData}.


delete(Key, DbRef) ->
    NewData = lists:foldl(fun({CurrentKey, Element}, Acc) ->
            case CurrentKey of
                Key -> Acc;
                OtherKey -> [{OtherKey, Element}|Acc]
            end
        end, [], DbRef#database.cache),
    DbRef#database{cache=NewData}.


read(Key, DbRef) ->
    case DbRef of
        #database{cache = [{Key, Element}|_]} ->
            {ok, Element};
        #database{cache = []} ->
            {error, Key};
        #database{cache = [_|Data]} ->
            read(Key, DbRef#database{cache = Data})
    end.


match(Element, DbRef) ->
    lists:foldl(fun({Key, CElement}, Acc) ->
            case CElement of
                Element -> [Key|Acc];
                _ -> Acc
            end
        end, [], DbRef#database.cache).
