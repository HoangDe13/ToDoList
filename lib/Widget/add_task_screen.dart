import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Data/TaskSQLite/task_database.dart';
import 'package:todolist/Domain/reponsitory.dart';
import 'package:todolist/Widget/main_screen.dart';
import 'package:todolist/main.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  AddTaskScreen({this.task});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  bool _inSync = false;
  String? _taskError;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.task != null) {
      _taskController.text = widget.task!.content!;
    }
    super.initState();
  }

  void addTask() async {
    if (_taskController.text.isEmpty) {
      setState(() {
        _taskError = 'Please enter this field';
      });
      return null;
    }
    setState(() {
      _taskError = null;
      _inSync = true;
    });

    final task = Task(
        date: DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now()),
        content: _taskController.text.trim(),
        status: 'Incomplete');
    Reponsitory().addTask(task);
    setState(() {
      _inSync = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false);
  }

  void updateTask() {
    if (_taskController.text.isEmpty) {
      setState(() {
        _taskError = 'Please enter this field';
      });
      return;
    }
    setState(() {
      _taskError = null;
      _inSync = true;
    });
    final task = Task(
        id: widget.task!.id,
        content: _taskController.text.trim(),
        date: widget.task!.date,
        status: widget.task!.status);
    Reponsitory().updateTask(task);
    setState(() {
      _inSync = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: !_inSync
              ? () {
                  Navigator.pop(context);
                }
              : null,
        ),
        actions: <Widget>[
          !_inSync
              ? IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    widget.task == null ? addTask() : updateTask();
                  },
                )
              : const Icon(Icons.refresh),
        ],
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (!_inSync) return true;
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: 'Task',
              errorText: _taskError,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
