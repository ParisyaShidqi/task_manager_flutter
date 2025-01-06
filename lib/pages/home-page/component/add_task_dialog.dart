import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_flutter/core/utils/textstyle_task.dart';
import 'package:task_manager_flutter/core/utils/dropdown_menu.dart';
import 'package:task_manager_flutter/pages/home-page/state/homestate.dart';

class AddtaskDialog extends StatefulWidget {
  Homestate homeState = Homestate();

  AddtaskDialog({super.key, required this.homeState});

  @override
  State<AddtaskDialog> createState() => _AddtaskDialogState();
}

class _AddtaskDialogState extends State<AddtaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add Task",
        style: textSty.text14400,
      ),
      content: Form(
        key: widget.homeState.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.homeState.titleController,
                decoration: InputDecoration(
                    labelText: "Title", labelStyle: textSty.text14400),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description", style: textSty.text14400),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: widget.homeState.descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        isDense: true,
                        labelStyle: textSty.text14400,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: widget.homeState.dueDateController,
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(1990, 1),
                          lastDate: DateTime(2200))
                      .then((value) {
                    widget.homeState.dueDateController.text =
                        DateFormat("dd/MMM/yyyy").format(value ?? DateTime(0));
                    widget.homeState.dateTime = value.toString();
                  });
                },
                decoration: InputDecoration(
                    labelText: "Due Date", labelStyle: textSty.text14400),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Due Date';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownTask(
                label: "Category",
                dropdownMenuEntries: widget.homeState.categoryEntry,
                onSelected: (p0) {
                  widget.homeState.selectedCategory = p0;
                },
              ),
              Visibility(
                visible: widget.homeState.selectedCategoryEmpty,
                child: Text(
                  "Please choose category",
                  style: textSty.text12400.copyWith(color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownTask(
                label: "Status",
                dropdownMenuEntries: widget.homeState.statusEntry,
                onSelected: (p0) {
                  widget.homeState.selectedStatus = p0;
                },
              ),
              Visibility(
                visible: widget.homeState.selectedStatusEmpty,
                child: Text(
                  "Please choose status",
                  style: textSty.text12400.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.homeState.cancelForm(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.homeState.validateForm(context);
            setState(() {});
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
