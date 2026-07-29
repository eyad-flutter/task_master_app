import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/main.dart';

import 'tasks_list.dart';

class BodyWidgets extends StatefulWidget {
  const BodyWidgets({super.key, this.task});

  final Task? task;

  @override
  State<BodyWidgets> createState() => _BodyWidgetsState();
}

class _BodyWidgetsState extends State<BodyWidgets> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (context, box, _) {
        var tasks = box.values
            .toList()
            .cast<Task>(); // Get all tasks in the database
        tasks.sort(
          (a, b) => a.createdAtDate.compareTo(b.createdAtDate),
        ); // Sort the tasks by date

        int completedCount = tasks.where((task) => task.isCompleted).length;

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.04,
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      " My Tasks",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color
                            ?.withValues(alpha: 0.68),
                      ),
                    ),
                    leading: Transform.scale(
                      scale: 1.4,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                        value: completedCount / tasks.length,
                        backgroundColor: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.05,
                          maxHeight: MediaQuery.of(context).size.width * 0.05,
                          minHeight: MediaQuery.of(context).size.width * 0.05,
                          minWidth: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "    $completedCount  of  ${tasks.length}  tasks",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 16,
                      ),
                    ),
                  ), // My Tasks Tile
                  Divider(
                    thickness: MediaQuery.of(context).size.width * 0.002,
                    color: Colors.black.withValues(alpha: 0.2),
                    indent: MediaQuery.of(context).size.width * 0.12,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  if (tasks.isEmpty)
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage: const AssetImage(
                              "images/no_tasks.png",
                            ),
                            radius: 80,
                            backgroundColor: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withValues(alpha: 0.1),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Text(
                          "No Tasks",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "It seems there are no task added yet",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color
                                ?.withValues(alpha: 0.1),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  TasksList(
                    tasks: tasks, // All the tasks inside the list
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
