import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_flutter/core/utils/dropdown_menu.dart';
import 'package:task_manager_flutter/core/utils/textstyle_task.dart';
import 'package:task_manager_flutter/pages/detail-task/state/detail_task_state.dart';

class DetailTaskPage extends StatelessWidget {
  int id;
  DetailTaskPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailTaskState(id: id),
      child: Consumer<DetailTaskState>(
        builder: (context, detailTaskState, child) => detailTaskState
                .taskCardList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context, true);
                      }),
                  title: Visibility(
                    visible: detailTaskState.titleEdit,
                    replacement: Text(
                      detailTaskState.taskCardList[0].title ?? "",
                      style: textSty.text16400.copyWith(color: Colors.white),
                    ),
                    child: TextFormField(
                      controller: detailTaskState.titleController,
                      decoration: InputDecoration(
                          isDense: true, labelStyle: textSty.text16400),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        detailTaskState.isEditTitle();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Category:", style: textSty.text14400),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownTask(
                              label: "Category",
                              initialSelection:
                                  detailTaskState.taskCardList[0].type,
                              dropdownMenuEntries:
                                  detailTaskState.categoryEntry,
                              onSelected: (p0) {
                                detailTaskState.selectedCategory = p0;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Status:", style: textSty.text14400),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownTask(
                              label: "Status",
                              initialSelection:
                                  detailTaskState.taskCardList[0].status,
                              dropdownMenuEntries: detailTaskState.statusEntry,
                              onSelected: (p0) {
                                detailTaskState.selectedStatus = p0;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description", style: textSty.text14400),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: detailTaskState.descriptionController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor ==
                                                      Colors.white
                                                  ? Colors.black
                                                  : Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor ==
                                                      Colors.white
                                                  ? Colors.black
                                                  : Colors.white)),
                                  isDense: true,
                                  labelStyle: textSty.text14400),
                              maxLines: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Due date:",
                                    style: textSty.text14400,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: TextFormField(
                                      controller:
                                          detailTaskState.dueDateController,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                firstDate: DateTime(1990, 1),
                                                lastDate: DateTime(2200))
                                            .then((value) {
                                          detailTaskState
                                                  .dueDateController.text =
                                              DateFormat("dd MMM yyyy")
                                                  .format(value ?? DateTime(0));
                                          detailTaskState.datetime =
                                              value ?? DateTime.now();
                                        });
                                      },
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                              .primaryColor ==
                                                          Colors.white
                                                      ? Colors.black
                                                      : Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                              .primaryColor ==
                                                          Colors.white
                                                      ? Colors.black
                                                      : Colors.white)),
                                          labelStyle: textSty.text14400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                                child: InkWell(
                              onTap: () {
                                detailTaskState.updateTask(context);
                              },
                              child: FittedBox(
                                  child: Text(
                                "Save",
                                style: textSty.text14400
                                    .copyWith(color: Colors.blue),
                              )),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
