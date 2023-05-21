import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_sunday/models/task_model.dart';
import 'package:todo_c8_sunday/screens/widgets/task_item.dart';
import 'package:todo_c8_sunday/shared/network/firebase/firebase_functions.dart';
import 'package:todo_c8_sunday/shared/styles/app_colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.lightColor,
          height: 100,
          inactiveDates: [DateTime.now().add(Duration(days: 2))],
          selectedTextColor: Colors.white,
          onDateChange: (newDate) {
            // New date selected
            setState(() {
              date = newDate;
            });
          },
        ),
        StreamBuilder(
          stream: FireBaseFunctions.getTasksFromFirestore(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text("something went wrong"),
                    ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                  ],
                ),
              );
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if(tasks.isEmpty){
              return Center(child: Text("No Tasks"));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
