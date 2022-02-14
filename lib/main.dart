import 'package:flutter/material.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Widget/add_task_screen.dart';
import 'package:todolist/Widget/main_screen.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
          primaryColor: Colors.amber[800], primarySwatch: Colors.amber),
      home: const MainScreen(),
    );
  }
}
