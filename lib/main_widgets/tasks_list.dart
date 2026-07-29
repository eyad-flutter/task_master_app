import 'package:flutter/material.dart';
import 'package:todo_app/main_widgets/warnings.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/main.dart';

import 'cards_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        final task =
            tasks[i]; // To get the info from each element in the tasks list

        return Dismissible(
          key: Key(task.id),
          // The key of the Dismissible to remove the task by its id
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete, color: Colors.black45, size: 50),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                const Text(
                  "Swipe to delete",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          // Confirm before removing the item from the UI
          confirmDismiss: (direction) async {
            final confirm = await showDeleteConfirmationDialog(context);
            return confirm ??
                false; // Fallback to false if the dialog is dismissed
          },
          onDismissed: (_) {
            base.dataStore.deleteTask(
              task: task,
            ); // The hive delete command to delete from database
            messageDeletedWarning(context);
          },
          child: CardsTile(
            task: task, // Every task in the tasks list
          ),
        );
      },
    );
  }
}
