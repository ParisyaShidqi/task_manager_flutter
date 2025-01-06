import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager_flutter/core/database/delete_task.dart';
import 'package:task_manager_flutter/core/database/insert_task.dart';
import 'package:task_manager_flutter/core/database/task_database.dart';
import 'package:task_manager_flutter/core/model/TaskCardModel.dart';
import 'package:task_manager_flutter/core/utils/loading_task.dart';

class Homestate with ChangeNotifier {
  List<TaskCardModel> taskCardList = [];
  List<TaskCardModel> filteredTaskCardList = [];
  List<TaskCardModel> tempTaskCardList = [];
  List<DropdownMenuEntry> categoryEntry = [
    const DropdownMenuEntry(value: "All", label: "All"),
    const DropdownMenuEntry(value: "Work", label: "Work"),
    const DropdownMenuEntry(value: "Personal", label: "Personal"),
    const DropdownMenuEntry(value: "Urgent", label: "Urgent"),
  ];
  List<DropdownMenuEntry> statusEntry = [
    const DropdownMenuEntry(value: "On Progress", label: "On Progress"),
    const DropdownMenuEntry(value: "Pending", label: "Pending"),
    const DropdownMenuEntry(value: "Completed", label: "Completed"),
  ];
  String selectedCategory = "";
  String selectedStatus = "";
  String dateTime = "";

  bool selectedCategoryEmpty = false;
  bool selectedStatusEmpty = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController filterController = TextEditingController();

  Homestate() {
    initHomeState();
  }

  initHomeState() {
    showTask();
  }

//check if widget is mounted
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

//validate task card insert form
  validateForm(BuildContext context) async {
    if (formKey.currentState!.validate() &&
        selectedCategory.isNotEmpty &&
        selectedStatus.isNotEmpty) {
      loadingTask.loadingDialog(true);
      await insertTask();
      loadingTask.loadingDialog(false);
      Navigator.pop(context);
    } else {
      if (selectedCategory.isEmpty) {
        selectedCategoryEmpty = true;
      }

      if (selectedStatus.isEmpty) {
        selectedStatusEmpty = true;
      }
      notify();
    }
  }

//cancel task card insert form
  cancelForm(BuildContext context) {
    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    selectedCategory = "";
    selectedStatus = "";
    dateTime = "";
    selectedCategoryEmpty = false;
    selectedStatusEmpty = false;
    notify();
    Navigator.pop(context);
  }

//get list of all task
  showTask() async {
    taskCardList = await showTaskCard();
    tempTaskCardList = [];
    notify();
    return taskCardList.length;
  }

//insert task into sqlite
  insertTask() async {
    await insertTaskCard(TaskCardModel(
        title: titleController.text,
        description: descriptionController.text,
        duedate: DateTime.parse(dateTime),
        status: selectedStatus,
        type: selectedCategory));

    showTask();

    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    selectedCategory = "";
    selectedStatus = "";
    dateTime = "";
    showTaskCard();
  }

//delete task from sqlite
  deleteTask(int id) async {
    await deleteTaskCard(id);
    showTask();
  }

//filtering status to color
  Color statusColor(String status) {
    if (status == "On Progress") {
      return Colors.orange;
    } else if (status == "Pending") {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  //filtering type of task
  filterTasks(String category) {
    if (tempTaskCardList.isEmpty && taskCardList.isNotEmpty) {
      tempTaskCardList = taskCardList;
    }
    if (category == "All") {
      taskCardList = tempTaskCardList;
      notify();
      print("object all ${taskCardList.length}");
      return;
    } else {
      taskCardList = tempTaskCardList;
      print("object low ${tempTaskCardList.length}");

      taskCardList = taskCardList.where((task) {
        final matchesCategory = task.type == category;
        print("$matchesCategory and ${task.type} and $category");
        return matchesCategory;
      }).toList();
    }

    notify();
  }

  //search task by title or category
  searchTasks(String query) {
    if (query.isNotEmpty) {
      if (tempTaskCardList.isEmpty && taskCardList.isNotEmpty) {
        tempTaskCardList = taskCardList;
      }
      taskCardList = tempTaskCardList;
      taskCardList = taskCardList.where((task) {
        final matchesTitle = task.title!.toLowerCase().contains(query);
        final matchesCategory = task.type!.toLowerCase().contains(query);
        return matchesTitle || matchesCategory;
      }).toList();
    } else {
      taskCardList = tempTaskCardList;
    }
    notify();
  }

  //filter by date
  filterByDate(DateTime date) {
    if (tempTaskCardList.isEmpty && taskCardList.isNotEmpty) {
        tempTaskCardList = taskCardList;
      }
    taskCardList = tempTaskCardList;
    taskCardList = taskCardList.where((task) {
      final matchesDate = task.duedate!.day == date.day &&
          task.duedate!.month == date.month &&
          task.duedate!.year == date.year;
      return matchesDate;
    }).toList();
    notify();
  }
}
