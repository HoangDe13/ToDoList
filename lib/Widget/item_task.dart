import 'package:flutter/material.dart';
import 'package:todolist/Data/Model/task.dart';
import 'package:todolist/Domain/reponsitory.dart';

class ItemTask extends StatefulWidget {
  //ItemTask({Key? key}) : super(key: key);
  Task? task;
  ItemTask({this.task});
  @override
  State<ItemTask> createState() => _ItemTaskState();
}

class _ItemTaskState extends State<ItemTask> {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    if (widget.task!.status == 'Complete') {
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
            widget.task!.status = 'Incomplete';
          });
        },
      ),
      title: Text(' ${widget.task!.content}'),
      subtitle: const Text('02/02/2022'),
      trailing: PopupMenuButton(
        onSelected: (i) {
          if (i == 0) {
          } else if (i == 1) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Confirm '),
                  content: const Text(
                      'This task will be deleted permanently. Do you want to do it?'),
                  actions: <Widget>[
                    // Nút hủy, nhấn vào chỉ pop cái dialog đi thôi không làm gì thêm
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('CANCEL'),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          Reponsitory().deleteTask(widget.task!.id);
                        });
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
  }
}
