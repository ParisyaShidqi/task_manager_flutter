import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_flutter/core/database/task_database.dart';
import 'package:task_manager_flutter/core/database/update_task.dart';
import 'package:task_manager_flutter/core/model/TaskCardModel.dart';
import 'package:task_manager_flutter/core/utils/loading_task.dart';

class DetailTaskState with ChangeNotifier {
  List<DropdownMenuEntry> categoryEntry = [
    const DropdownMenuEntry(value: "Work", label: "Work"),
    const DropdownMenuEntry(value: "Personal", label: "Personal"),
    const DropdownMenuEntry(value: "Urgent", label: "Urgent"),
  ];
  List<DropdownMenuEntry> statusEntry = [
    const DropdownMenuEntry(value: "On Progress", label: "On Progress"),
    const DropdownMenuEntry(value: "Pending", label: "Pending"),
    const DropdownMenuEntry(value: "Completed", label: "Completed"),
  ];

  List<TaskCardModel> taskCardList = [];

  TextEditingController dueDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedCategory = "";
  String selectedStatus = "";
  String dueDate = "";
  String title = "";
  String description = "";
  DateTime datetime = DateTime.now();

  int id = 0;

  bool titleEdit = false;

  DetailTaskState({required this.id}) {
    initDetailTaskState();
  }

  initDetailTaskState() async {
    await showTask();
    dueDateController.text = DateFormat("dd MMM yyyy")
        .format(taskCardList[0].duedate ?? DateTime.now());
    datetime = taskCardList[0].duedate ?? DateTime.now();
    titleController.text = taskCardList[0].title ?? "";
    descriptionController.text = taskCardList[0].description ?? "";

    notify();
  }

  bool mounted = false;
  @override
  void dispose() {
    super.dispose();
    mounted = true;
  }

  notify() {
    if (!mounted) {
      notifyListeners();
    }
  }

  isEditTitle() {
    title = titleController.text;
    titleEdit = !titleEdit;
    notify();
  }

  //get list of all task
  showTask() async {
    print("id here: ${id}");
    taskCardList = await showTaskCard(id: id);
    notify();
  }

//update list of task
  void updateTask(BuildContext context) async {
    loadingTask.loadingDialog(true);
    await updateTaskCard(TaskCardModel(
      title: titleController.text,
      description: descriptionController.text,
      duedate: datetime,
      status: selectedStatus.isEmpty ? taskCardList[0].status : selectedStatus,
      type: selectedCategory.isEmpty ? taskCardList[0].type : selectedCategory,
      id: id,
    ));
    loadingTask.loadingDialog(false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task updated successfully!'),
      ),
    );
    notify();
  }
}
