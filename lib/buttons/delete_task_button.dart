import 'package:flutter/material.dart';
import 'package:todo_app/main_widgets/warnings.dart';
import 'package:todo_app/screens/list_ui.dart';
import 'package:todo_app/screens/update_task_ui.dart';

import '../models/task.dart';
import '../screens/main.dart';
import 'buttons.dart';

class DeleteTaskButton extends StatefulWidget {
  const DeleteTaskButton({
    super.key,
    required this.formKey,
    required this.widget,
    required this.task,
  });

  final GlobalKey<FormState> formKey;
  final UpdateTaskUi widget;
  final Task task;

  @override
  State<DeleteTaskButton> createState() => _DeleteTaskButtonState();
}

class _DeleteTaskButtonState extends State<DeleteTaskButton> {
  void _deleteTask() async {
    final base = BaseWidget.of(context); // To get to all CRUD Operations
    await base.dataStore.deleteTask(task: widget.task);

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ListUi(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );

    messageDeletedWarning(context);
  }

  @override
  Widget build(BuildContext context) {
    return Buttons(
      onTap: () async {
        // Wait until user's decision
        final shouldDelete = await showDeleteConfirmationDialog(context);

        if (shouldDelete == true) {
          _deleteTask();

          if (context.mounted) {
            // Message Deleted Alert
            messageDeletedWarning(context);
          }
        }
      }, // Delete function to delete the task while updating it
      colors: const [Color(0xffF75050), Color(0xffF94E4E)],
      shadowColor: const Color(0xffF75050),
      text: "Delete Task",
    );
  }
}
