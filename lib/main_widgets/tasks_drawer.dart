import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/screens/details_ui.dart';
import 'package:todo_app/screens/list_ui.dart';
import 'package:todo_app/screens/profile_ui.dart';
import 'package:todo_app/screens/settings_ui.dart';
import 'package:todo_app/utils/consts.dart';

class TasksDrawer extends StatelessWidget {
  const TasksDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settingsBox').listenable(),
      builder: (context, box, child) {
        // Fetch saved data from Hive or fallback to default values
        String name = box.get('userName', defaultValue: '');
        int avatarIndex = box.get('userAvatarIndex', defaultValue: 0);

        // Prevent index out of bounds
        if (avatarIndex >= avatarList.length) avatarIndex = 0;

        var selectedAvatar = avatarList[avatarIndex];

        return Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withValues(alpha: 1),
                  Theme.of(context).primaryColor.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.38),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    boxShadow: [
                      BoxShadow(
                        color: selectedAvatar['color'].withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(1, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    foregroundColor: selectedAvatar['color'],
                    backgroundImage: selectedAvatar['icon'],
                    backgroundColor: selectedAvatar['color'],
                    radius: 55,
                  ),
                ), // Avatar
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white70.withValues(alpha: 0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.3,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                Text(
                  "",
                  style: TextStyle(
                    color: Colors.white70.withValues(alpha: 0.6),
                    fontSize: 15,
                    letterSpacing: 1.3,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.15),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ListUi(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                              transitionDuration: const Duration(
                                milliseconds: 400,
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: const Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                        splashColor: Colors.black.withValues(alpha: 0.2),
                        title: Text(
                          drawerCards[0],
                          style: TextStyle(
                            color: Colors.white70.withValues(alpha: 0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ), // For Home Card
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ProfileUi(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                              transitionDuration: const Duration(
                                milliseconds: 400,
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: const Icon(Icons.person, color: Colors.white),
                        splashColor: Colors.black.withValues(alpha: 0.2),
                        title: Text(
                          drawerCards[1],
                          style: TextStyle(
                            color: Colors.white70.withValues(alpha: 0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ), // For Profile Card
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SettingsUi(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                              transitionDuration: const Duration(
                                milliseconds: 400,
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        splashColor: Colors.black.withValues(alpha: 0.2),
                        title: Text(
                          drawerCards[2],
                          style: TextStyle(
                            color: Colors.white70.withValues(alpha: 0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ), // For Settings Card
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const DetailsUi(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: const Icon(Icons.info, color: Colors.white),
                        splashColor: Colors.black.withValues(alpha: 0.2),
                        title: Text(
                          drawerCards[3],
                          style: TextStyle(
                            color: Colors.white70.withValues(alpha: 0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ), // For Details Card
                    ],
                  ),
                ),
              ], // Cards
            ),
          ),
        );
      },
    );
  }
}
