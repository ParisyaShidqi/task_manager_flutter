import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_flutter/core/utils/textstyle_task.dart';
import 'package:task_manager_flutter/pages/home-page/component/delete_task_dialog.dart';
import 'package:task_manager_flutter/pages/home-page/state/homestate.dart';

class TaskCard extends StatelessWidget {
  final int index;
  const TaskCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<Homestate>(
      builder: (context, homeState, child) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Card(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeState.taskCardList[index].title ?? "",
                          style: textSty.text14400,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          homeState.taskCardList[index].description ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: textSty.text12400,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: homeState.statusColor(
                          homeState.taskCardList[index].status ?? ""),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 215, 215, 215),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteTaskDialog(
                                      homeState: homeState, index: index);
                                });
                          },
                        ),
                      ),
                      Text(homeState.taskCardList[index].type ?? "",
                          style:
                              textSty.text12400.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
