import 'package:flutter/material.dart';
import 'package:task_manager_flutter/pages/home-page/state/homestate.dart';

class DeleteTaskDialog extends StatelessWidget {
  final Homestate homeState;
  final int index;
  const DeleteTaskDialog(
      {super.key, required this.homeState, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Task"),
      content: const Text("Are you sure want to delete this task?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            homeState.deleteTask(homeState.taskCardList[index].id ?? 0);
            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
