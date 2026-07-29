import 'package:flutter/material.dart';
import 'package:todo_app/main_widgets/floating_add_task_button.dart';

import 'package:todo_app/main_widgets/app_bar_tasks.dart';
import 'package:todo_app/main_widgets/body_widgets.dart';
import 'package:todo_app/main_widgets/tasks_drawer.dart';

class ListUi extends StatefulWidget {
  const ListUi({super.key});

  @override
  State<ListUi> createState() => _ListUiState();
}

class _ListUiState extends State<ListUi> {
  GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey(); // The callback parameter used to trigger the button feature (1)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: scaffoldKey,

      drawer: const TasksDrawer(),

      appBar: appBarTasks(context, () {
        scaffoldKey.currentState!
            .openDrawer(); // Set AppBar leading icon to trigger opening the Drawer (4)
      }),

      body: const BodyWidgets(),

      floatingActionButton: const AddTaskButton(),
    );
  }
}
