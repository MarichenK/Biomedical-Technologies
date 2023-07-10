//Here the database is being generated
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'database.dart';


// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}//appDataBaseBuilder

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance; //the personlia 


  

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Todo` (`name` TEXT PRIMARY KEY, `password` TEXT NOT NULL, `height` INTEGER NOT NULL, `age` INTEGER NOT NULL, `weight` INTEGER NOT NULL, `gender` TEXT NOT NULL)');
         
        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }

}//class appDatabase

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(database, 'Todo',
            (Todo item) => <String, Object?>{'name': item.username, 'password': item.password, 'height': item.height, 'age': item.age, 'weight': item.weight, 'gender': item.gender}),
        _todoDeletionAdapter = DeletionAdapter(database, 'Todo', ['id'],
            (Todo item) => <String, Object?>{'id': item.username, 'name': item.password}),
        _todoUpdateAdapter = UpdateAdapter(database, 'Todo', ['id'],
            (Todo item) => <String, Object?>{'id': item.username, 'name': item.password});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

 
    @override
  Future<Todo?> findTodoById(String username) {
    return _queryAdapter.query('SELECT * FROM Todo WHERE name == ?1',
        mapper: (Map<String, Object?> row) => Todo(
            row['name'] as String,
            row['password'] as String,
            row['height'] as int,
            row['age'] as int,
            row['weight'] as int,
            row['gender'] as String),
        arguments: [username]);
  }
  

  @override
  Future<void> insertTodo(Todo todo) async {
    await _todoInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(Todo task) async {
    await _todoDeletionAdapter.delete(task);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _todoUpdateAdapter.update(todo, OnConflictStrategy.abort);
  }
}//class Todo


// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

