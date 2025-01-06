import 'package:flutter/material.dart';
import 'package:task_manager_flutter/core/utils/textstyle_task.dart';

class DropdownTask extends StatelessWidget {
  final String label;
  final List<DropdownMenuEntry> dropdownMenuEntries;
  String? initialSelection;
  final void Function(dynamic)? onSelected;
  DropdownTask(
      {super.key,
      required this.label,
      this.initialSelection,
      required this.dropdownMenuEntries,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: Text(label, style: textSty.text14400),
      initialSelection: initialSelection,
      textStyle: textSty.text14400,
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: onSelected,
    );
  }
}
