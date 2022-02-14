// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Domain/reponsitory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Testing App', () {
    List<Task> checkTask = [];
    test('task is do homework ', () {
      String date = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
      Task newTask =
          Task(content: 'do homework', date: date, status: 'Incomplete');
      Reponsitory().addTask(newTask);

      Future result = Reponsitory().getTasks();
      if (result == null) {
        print('unable');
      } else {
        result.then((value) {
          value.forEach((item) => checkTask.add(item));
        });
      }
      checkTask.where((element) => element.content == 'do homework');
      expect(checkTask.length, 1);
    });
  });
  test('task is null ', () {
    List<Task> checkTask = [];
    String date = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
    Task newTask =
        Task(content: 'do homework', date: date, status: 'Incomplete');
    Reponsitory().addTask(newTask);

    Future result = Reponsitory().getTasks();
    if (result == null) {
      print('unable');
    } else {
      result.then((value) {
        value.forEach((item) => checkTask.add(item));
      });
    }
    checkTask.where((element) => element.content == '');
    expect(checkTask.length, 0);
  });
}
