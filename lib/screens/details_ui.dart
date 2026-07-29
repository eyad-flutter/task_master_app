import 'package:flutter/material.dart';
import 'package:todo_app/main_widgets/app_bar_tasks.dart';
import 'package:todo_app/main_widgets/tasks_drawer.dart';

class DetailsUi extends StatefulWidget {
  const DetailsUi({super.key});

  @override
  State<DetailsUi> createState() => _DetailsUiState();
}

class _DetailsUiState extends State<DetailsUi> {
  GlobalKey<ScaffoldState> scaffoldKeyOne = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyOne,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: appBarTasks(context, () {
        scaffoldKeyOne.currentState!.openDrawer();
      }),

      drawer: const TasksDrawer(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.task_alt_rounded,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.055),

                // App name
                Text(
                  'My Tasks',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.027),

                // App version
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.055),

                // App description
                Text(
                  'A simple, clean, and efficient task management app designed to help you stay organized and boost your daily productivity.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Theme.of(
                      context,
                    ).textTheme.displayLarge?.color?.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.055),

                Divider(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.045),

                // Credits
                Text(
                  'Designed & Developed by',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(
                      context,
                    ).textTheme.displayLarge?.color?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Eyad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
