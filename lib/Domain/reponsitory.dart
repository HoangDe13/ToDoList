import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Data/TaskSQLite/task_database.dart';

class Reponsitory {
  List<Task> tasks = [];

  Future<List> getTasks() async {
    final db = TaskDatabase();

    tasks = await db.getTasks();
    return tasks;
  }

  Future getTasksComplete() async {
    final db = TaskDatabase();
    tasks = await db.getTasksComplete();
    return tasks;
  }

  Future getTasksIncomplete() async {
    final db = TaskDatabase();
    tasks = await db.getTasksIncomplete();
    return tasks;
  }

  Future deleteTask(int? id) async {
    final db = TaskDatabase();
    await db.delete(id!);
    tasks = await db.getTasks();
    await getTasks();
  }

  Future addTask(Task task) async {
    final db = TaskDatabase();
    await db.insert(task);
  }

  Future updateTask(Task task) async {
    final db = TaskDatabase();

    await db.update(task);
  }

  Future updateStatus(Task task) async {
    final db = TaskDatabase();
    if (task.status == 'Complete') {
      task.status = 'Incomplete';
    } else {
      task.status = 'Complete';
    }

    await db.update(task);
  }
}
