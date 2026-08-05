/// Prepares SQLite before a database test.
///
/// Since `sqlite3` 3.x provides SQLite through native asset hooks, tests no
/// longer need to override the library loader. Keeping this helper makes the
/// shared test setup explicit and isolates future platform changes.
void configureTestSqlite() {}
