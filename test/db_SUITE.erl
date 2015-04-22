-module(db_SUITE).

-compile(export_all).


all() -> [
        test_new_database_creation
    ].


test_new_database_creation(_Config) ->
    {database, 'db.txt', []} = db:new(),
    ok.
