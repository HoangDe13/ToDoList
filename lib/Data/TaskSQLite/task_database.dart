import 'package:todolist/Data/Model/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  Database? _database;

  final String kTableName = 'tasks';
  final String kId = 'id';
  final String kTask = 'content';
  final String kDate = 'date';
  final String kStatus = 'status';

  Future _openDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $kTableName($kId INTEGER PRIMARY KEY AUTOINCREMENT, $kTask TEXT,$kDate TEXT,$kStatus TEXT)');
      },
      version: 2,
    );
  }

  Future insert(Task task) async {
    await _openDB();
    await _database!.insert(kTableName, task.toMap());
    print('Task inserted');
  }

  Future update(Task task) async {
    await _openDB();
    await _database!.update(
      kTableName,
      task.toMap(),
      where: '$kId = ?',
      whereArgs: [task.id],
    );
    print('Task updated');
  }

  Future<void> deleteDb() async {
    await _openDB();
    await _database!.delete(kTableName);
    // delete database
  }

  Future delete(int id) async {
    await _openDB();
    print((await _database!.delete(
      kTableName,
      where: '$kId = ?',
      whereArgs: [id],
    )));
    print('Task deleted');
  }

  Future<List<Task>> getTasks() async {
    await _openDB();
    List<Map<String, dynamic>> maps = await _database!.query(kTableName);
    return List.generate(
        maps.length,
        (i) => Task(
            id: maps[i][kId],
            content: maps[i][kTask],
            date: maps[i][kDate],
            status: maps[i][kStatus]));
  }

  Future<List<Task>> getTasksComplete() async {
    await _openDB();
    List<Map<String, dynamic>> maps = await _database!
        .query(kTableName, where: '${kStatus} = ?', whereArgs: ['Complete']);
    return List.generate(
        maps.length,
        (i) => Task(
            id: maps[i][kId],
            content: maps[i][kTask],
            date: maps[i][kDate],
            status: maps[i][kStatus]));
  }

  Future<List<Task>> getTasksIncomplete() async {
    await _openDB();
    List<Map<String, dynamic>> maps = await _database!
        .query(kTableName, where: '${kStatus} = ?', whereArgs: ['Incomplete']);
    return List.generate(
        maps.length,
        (i) => Task(
            id: maps[i][kId],
            content: maps[i][kTask],
            date: maps[i][kDate],
            status: maps[i][kStatus]));
  }
}
