import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_flutter/core/utils/textstyle_task.dart';
import 'package:task_manager_flutter/pages/detail-task/page/detail_task_page.dart';
import 'package:task_manager_flutter/pages/home-page/component/add_task_dialog.dart';
import 'package:task_manager_flutter/pages/home-page/component/delete_task_dialog.dart';
import 'package:task_manager_flutter/core/utils/dropdown_menu.dart';
import 'package:task_manager_flutter/pages/home-page/component/task_card.dart';
import 'package:task_manager_flutter/pages/home-page/state/homestate.dart';

class Homepage extends StatelessWidget {
  final ValueNotifier<bool> isDarkMode;
  const Homepage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Homestate(),
      child: Consumer<Homestate>(
        builder: (context, homeState, child) => Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownTask(
                      label: "Category",
                      dropdownMenuEntries: homeState.categoryEntry,
                      onSelected: (p0) {
                        homeState.filterTasks(p0);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AddtaskDialog(homeState: homeState);
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Add Task",
                            style: textSty.text14400,
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.add),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: homeState.filterController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    prefixIcon: Icon(Icons.calendar_today),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        homeState.showTask();
                        homeState.filterController.text = "";
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    showDatePicker(
                            context: context,
                            firstDate: DateTime(1990, 1),
                            lastDate: DateTime(2200))
                        .then((value) {
                      homeState.filterByDate(value ?? DateTime.now());
                      homeState.filterController.text =
                          DateFormat("dd MMM yyyy")
                              .format(value ?? DateTime.now());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          homeState.searchTasks(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search Tasks",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(isDarkMode.value ? "Dark Mode" : "Light Mode",
                            style: textSty.text14400),
                        Switch(
                          value: isDarkMode.value,
                          onChanged: (value) {
                            isDarkMode.value = value;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Visibility(
                    visible: homeState.taskCardList.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        "No Task",
                        style: textSty.text14400,
                      ),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: homeState.taskCardList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTaskPage(
                                        id: homeState.taskCardList[index].id ??
                                            0))).then((value) {
                              homeState.showTask();
                            });
                          },
                          child: TaskCard(index: index),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
