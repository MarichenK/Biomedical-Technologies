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

  CaloriesDao? _caloriesDaoInstance;

  //StepsDao? _stepsDaoInstances;
  

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
            'CREATE TABLE IF NOT EXISTS `Todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `height` INTEGER NOT NULL, `age` INTEGER NOT NULL, `weight` INTEGER NOT NULL, `gender` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Calories` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cal` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL, FOREIGN KEY (`name`) REFERENCES `Todo` (`id`) ON UPDATE NO ACTION IN DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Steps` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `step` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL, FOREIGN KEY (`name`) REFERENCES `Todo` (`id`) ON UPDATE NO ACTION IN DELETE NO ACTION)');
        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }

  @override
  CaloriesDao get caloriesDao {
    return _caloriesDaoInstance ??= _$CaloriesDao(database, changeListener);
  }

  /*@override
  StepsDao get stepsDao {
    return _stepsDaoInstances ??= _$StepsDao(database, changeListener);
  }*/
}//class appDatabase

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(database, 'Todo',
            (Todo item) => <String, Object?>{'id': item.id, 'name': item.name}),
        _todoDeletionAdapter = DeletionAdapter(database, 'Todo', ['id'],
            (Todo item) => <String, Object?>{'id': item.id, 'name': item.name}),
        _todoUpdateAdapter = UpdateAdapter(database, 'Todo', ['id'],
            (Todo item) => <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

 
    @override
  Future<Todo?> findTodoById(int id) async {
    return _queryAdapter.query('SELECT * FROM Patient WHERE patient == ?1',
        mapper: (Map<String, Object?> row) => Todo(
            row['id'] as int?,
            row['name'] as String,
            row['height'] as int,
            row['age'] as int,
            row['weight'] as int,
            row['gender'] as String),
        arguments: [Todo]);
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

class _$CaloriesDao extends CaloriesDao{
  _$CaloriesDao(
    this.database,
    this.changeListener,
  )
  : _queryAdapter = QueryAdapter(database),
    _calorieInsertionAdapter = InsertionAdapter(
      database, 
      'Calories', 
      (Calories item) => <String, Object?>{ 
        'id': item.id, 
        'cal': item.cal, 
        'dateTime' : _dateTimeConverter.encode(item.dateTime)}),
    _calorieUpdateAdapter = UpdateAdapter(database, 'Calories', ['id'], 
      (Calories item) => <String, Object?>{ 'id': item.id, 'cal': item.cal, 'dateTime': _dateTimeConverter.encode(item.dateTime)}),
    _calorieDeletionAdapter = DeletionAdapter(database, 'Calories', ['id'], 
      (Calories item) => <String, Object?>{'id': item.id, 'cal': item.cal, 'dateTime': _dateTimeConverter.encode(item.dateTime)
    });
  
  final sqflite.DatabaseExecutor database;
  final StreamController<String> changeListener;
  final QueryAdapter _queryAdapter;
  final InsertionAdapter<Calories> _calorieInsertionAdapter;
  final UpdateAdapter<Calories> _calorieUpdateAdapter;
  final DeletionAdapter<Calories> _calorieDeletionAdapter;

  @override
  Future<List<Calories>> findCaloriesbyDate(
    int id,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM Calories WHERE dateTime between ?2 and ?3 and id == ?1 ORDER BY dateTime ASC', 
      mapper: (Map<String, Object?> row) => Calories(
        id: row['id'] as int?, cal: row['cal'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
      arguments: [
        id, _dateTimeConverter.encode(startTime), _dateTimeConverter.encode(endTime)
      ]
      );
  }

  @override
  Future<List<Calories>> findAllCalories(int id) async{
    return _queryAdapter.queryList(
      'SELECT * FROM Calories WHERE id == ?1', 
      mapper: (Map<String, Object?> row) => Calories(
        id: row['id'] as int?, cal: row['cal'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
      arguments: [id]
    );
  }

  @override
  Future<List<Calories>> findLastWeekCalories(int id) async{
    return _queryAdapter.queryList(
      'SELECT * FROM Calories WHERE id == ?1 and dateTime>?2 ORDER BY dateTime ASC', 
      mapper: (Map<String, Object?> row) => Calories(
        id: row['id'] as int?, cal: row['cal'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
      arguments: [id]);
  }

  @override
  Future<void> insertCalories(Calories calories) async{
    await _calorieInsertionAdapter.insert(calories, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCalories(Calories calories) async{
    await _calorieUpdateAdapter.update(calories, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCalories(Calories calories) async{
    await _calorieDeletionAdapter.delete(calories);
  }
} //Class Calores

/*class _$StepsDao extends StepsDao {
  _$StepsDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database),
      _stepsInsertionAdapter = InsertionAdapter(database, 'Steps', 
      (Steps item) => <String, Object?>{
        'dateTime': _dateTimeConverter.encode(item.dateTime)}, 'steps': item.steps),
      _stepsUpdateAdapter = UpdateAdapter(database, 'Steps', ['id'], 
      (Steps item) => <String, Object?>{'id': item.id, 'steps': item.step, 'dateTime': _dateTimeConverter.encode(item.dateTime)}),
      _stepsDeletionAdapter = DeletionAdapter(database, 'Steps', ['id'], 
      (Steps item) => <String, Object?>{'id': item.id, 'step': item.step, 'dateTime': _dateTimeConverter.encode(item.dateTime)});

  final sqflite.DatabaseExecutor database;
  final StreamController<String> changeListener;
  final QueryAdapter _queryAdapter;
  final InsertionAdapter<Steps> _stepsInsertionAdapter;
  final UpdateAdapter<Steps> _stepsUpdateAdapter;
  final DeletionAdapter<Steps> _stepsDeletionAdapter;

  @override
  Future<void> insertSteps(Steps steps) async{
    await _stepsInsertionAdapter.insert(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSteps(Steps steps) async{
    await _stepsUpdateAdapter.update(steps, OnConflictStrategy.fail);
  }

  @override
  Future<void> deleteSteps(Steps steps) async{
    await _stepsDeletionAdapter.delete(steps);
  }

  @override
  Future<List<Steps>> findStepsbyDate(
    int id,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM Steps WHERE dateTime between ?2 and ?3 and id == ?1 ORDER BY dateTime ASC', 
      mapper: (Map<String, Object?> row) => Steps(id: row['id'] as int?, step: row['step'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
      arguments: [
        id, _dateTimeConverter.encode(startTime), _dateTimeConverter.encode(endTime)
      ]
      );
  }

  @override
  Future<List<Steps>> findAllSteps(int id) async{
    return _queryAdapter.queryList(
      'SELECT * FROM Steps WHERE id == ?1', 
      mapper: (Map<String, Object?> row) => Steps(
        id: row['id'] as int?, step: row['step'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [id]
    );
  }

  @override
  Future<List<Steps>> findLastWeekSteps(int id) async{
    return _queryAdapter.queryList(
      'SELECT * FROM Steps WHERE id == ?1 and dateTime>?2 ORDER BY dateTime ASC', 
      mapper: (Map<String, Object?> row) => Steps(id: row['id'] as int?, step: row['step'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int)),
      arguments: [id]);
  }

} //class StepDao */

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

