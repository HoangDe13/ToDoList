import 'package:flutter/material.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Domain/reponsitory.dart';
import 'package:todolist/Widget/add_task_screen.dart';

class BothScreen extends StatefulWidget {
  const BothScreen({Key? key}) : super(key: key);

  @override
  State<BothScreen> createState() => _BothScreenState();
}

class _BothScreenState extends State<BothScreen> {
  List<Task> getTask = [];

  // ignore: non_constant_identifier_names
  FetchData() async {
    dynamic result = await Reponsitory().getTasks();
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          getTask = result;
        });
      }
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    FetchData();
    super.initState();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red.shade600;
    }
    return Colors.amber.shade900;
  }

  @override
  Widget build(BuildContext context) {
    //FetchData();
    return ListView.builder(
      itemCount: getTask.length,
      itemBuilder: (context, index) {
        bool isChecked = false;
        if (getTask[index].status == 'Complete') {
          isChecked = true;
        }
        return ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                Reponsitory().updateStatus(getTask[index]);
              });
            },
          ),
          title: Text(' ${getTask[index].content}'),
          subtitle: Text('${getTask[index].date}'),
          trailing: PopupMenuButton(
            onSelected: (i) {
              if (i == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTaskScreen(
                              task: getTask[index],
                            )));
              } else if (i == 1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                          'This task will be deleted permanently. Do you want to do it?'),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Reponsitory().deleteTask(getTask[index].id);
                            FetchData();
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'DELETE',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
