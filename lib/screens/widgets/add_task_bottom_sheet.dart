import 'package:flutter/material.dart';
import 'package:todo_c8_sunday/models/task_model.dart';
import 'package:todo_c8_sunday/shared/network/firebase/firebase_functions.dart';
import 'package:todo_c8_sunday/shared/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selected = DateUtils.dateOnly(DateTime.now());

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Task title";
                } else if (value.length < 10) {
                  return "Please Enter at least 10 char";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  label: const Text("Task Title"),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightColor),
                      borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightColor),
                      borderRadius: BorderRadius.circular(18))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Task Description";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: const Text("Task Description"),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightColor),
                      borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightColor),
                      borderRadius: BorderRadius.circular(18))),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Select Date",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              onTap: () {
                chooseDate();
              },
              child: Text(
                selected.toString().substring(0, 10),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.lightColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selected.millisecondsSinceEpoch,
                        status: false);
                    FireBaseFunctions.addTaskToFirestore(task);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void chooseDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().subtract(Duration(days: 365 * 10)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedDate != null) {
      selected = DateUtils.dateOnly(selectedDate);
      setState(() {});
    }
  }
}
