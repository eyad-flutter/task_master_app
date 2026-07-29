import 'package:flutter/material.dart';
import 'package:todo_app/main_widgets/warnings.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/add_task_ui.dart';
import 'package:todo_app/screens/list_ui.dart';
import 'package:todo_app/screens/main.dart';
import 'package:uuid/uuid.dart';

import 'buttons.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key, required this.formKey, required this.widget});

  void _addTask(BuildContext context) async {
    final base = BaseWidget.of(context); // To get to all CRUD Operations
    final newTask = Task(
      id: const Uuid().v1(),
      // To get its unique id
      title: widget.titleAdd.text,
      subtitle: widget.subtitleAdd.text,
      createdAtTime: AddTaskUi.selectedTime ?? DateTime.now(),
      createdAtDate: AddTaskUi.selectedDate ?? DateTime.now(),
      isCompleted: false,
    );

    base.dataStore.addTask(task: newTask); // To add the task

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ListUi(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  final GlobalKey<FormState> formKey;
  final AddTaskUi widget;

  @override
  Widget build(BuildContext context) {
    return Buttons(
      onTap: () async {
        if (formKey.currentState!.validate() == false) {
          return;
        }
        _addTask(context);
        messageAddedWarning(context);
        widget.titleAdd.clear();
        widget.subtitleAdd.clear();
      },
      colors: [
        Theme.of(context).primaryColor,
        Colors.blueAccent.withValues(alpha: 0.3),
      ],
      shadowColor: Theme.of(context).primaryColor,
      text: "Add Task",
    );
  }
}
