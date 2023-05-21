import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c8_sunday/models/task_model.dart';
import 'package:todo_c8_sunday/shared/network/firebase/firebase_functions.dart';

import '../../models/task_model.dart';
import '../../shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent)),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FireBaseFunctions.deleteTask(task.id);
            },
            label: "Delete",
            icon: Icons.delete,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          SlidableAction(
            onPressed: (context) {},
            label: "Edit",
            padding: EdgeInsets.zero,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          ),
        ]),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 5,
              decoration: BoxDecoration(
                  color:
                      task.status ? AppColors.greenColor : AppColors.lightColor,
                  borderRadius: BorderRadius.circular(4)),
              margin: EdgeInsets.only(top: 6, bottom: 6, left: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: task.status
                          ? AppColors.greenColor
                          : AppColors.lightColor),
                ),
                Text(
                  task.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Spacer(),
            task.status
                ? Text(
                    "Done!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.greenColor),
                  )
                : InkWell(
                    onTap: () {
                      task.status = true;
                      FireBaseFunctions.updateTask(task.id, task);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
          ],
        ),
      ),
    );
  }
}
