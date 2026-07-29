import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart'; //for Hive.initFlutter installation
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/startup_ui.dart';
import 'package:todo_app/utils/consts.dart';

void main() async {
  // To keep the app in vertical mode only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //For hive installation
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  // To make the data open when the app opened
  await Hive.openBox<Task>("tasksBox");
  await Hive.openBox("settingsBox");

  runApp(
    BaseWidget(child: const ToDo()),
  ); //BaseWidget at the beginning to make the app reate it first
}

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required super.child});

  final HiveDataStore dataStore = HiveDataStore();

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();

    if (base != null) {
      return base;
    } else {
      throw StateError("Could not find ancestor of type BaseWidget");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw false;
  }
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp to listen for any settings changes
    return ValueListenableBuilder(
      valueListenable: Hive.box('settingsBox').listenable(),
      builder: (context, box, child) {
        // Read the value from Hive; default to false (Light Mode) if not set
        bool isDarkMode = box.get('isDarkMode', defaultValue: false);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To Do App',

          // Set the active theme mode based on the stored preference
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // Load themes directly from consts.dart
          theme: lightTheme,
          darkTheme: darkTheme,

          home: const StartupUi(),
        );
      },
    );
  }
}
