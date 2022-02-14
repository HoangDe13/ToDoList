import 'package:flutter/material.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Domain/reponsitory.dart';
import 'package:todolist/Widget/add_task_screen.dart';
import 'package:todolist/Widget/both_screen.dart';
import 'package:todolist/Widget/complete_screen.dart';
import 'package:todolist/Widget/incomplete_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const id = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List _widgetOptions = [
    BothScreen(),
    CompleteScreen(),
    IncompleteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()));
          if (result == true) {
            Reponsitory().getTasks();
            setState(() {});
          }
        },
        backgroundColor: Colors.amber[800],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late_outlined),
            label: 'Incomplete',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
