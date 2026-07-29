import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/main_widgets/app_bar_tasks.dart';
import 'package:todo_app/main_widgets/tasks_drawer.dart';
import 'package:todo_app/main_widgets/warnings.dart';

import 'details_ui.dart';
import 'main.dart';

class SettingsUi extends StatefulWidget {
  const SettingsUi({super.key});

  @override
  State<SettingsUi> createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  // Key used to control the Scaffold state (e.g., opening drawer)
  GlobalKey<ScaffoldState> scaffoldKeyTwo = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      key: scaffoldKeyTwo,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: appBarTasks(context, () {
        scaffoldKeyTwo.currentState!.openDrawer();
      }),

      drawer: const TasksDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ 1. SECTION: APPEARANCE ------------------
            _buildSectionHeader(context, 'Appearance'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              context,
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box('settingsBox').listenable(),
                  builder: (context, box, child) {
                    bool isDarkMode = box.get(
                      'isDarkMode',
                      defaultValue: false,
                    );

                    return Material(
                      color: Colors.transparent,
                      // Allows ListTile to render touch ripple effect over background
                      borderRadius: BorderRadius.circular(30),
                      clipBehavior: Clip.antiAlias,
                      // Prevents press animation from clipping outside border radius
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          // Disable splash effect
                          highlightColor: Colors.transparent,
                          // Disable highlight overlay on tap
                          hoverColor: Colors
                              .transparent, // Disable hover color (Web/Desktop)
                        ),
                        child: SwitchListTile(
                          title: const Text(
                            'Dark Mode',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          secondary: Icon(
                            isDarkMode ? Icons.dark_mode : Icons.light_mode,
                            color: isDarkMode ? Colors.yellow : Colors.grey,
                          ),
                          value: isDarkMode,
                          activeThumbColor: const Color(0xff4fc3f9),
                          onChanged: (value) {
                            // Update value in Hive the whole app rebuilds dynamically
                            box.put('isDarkMode', value);
                          },
                        ),
                      ),
                    ); // The theme switcher
                  },
                ), // Theme switcher
              ],
            ),

            const SizedBox(height: 25),

            // ------------------ 2. SECTION: DATA MANAGEMENT ------------------
            _buildSectionHeader(context, 'Data & Storage'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              context,
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.redAccent,
                    ),
                  ),
                  title: const Text(
                    'Clear All Tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                  subtitle: Text(
                    'Remove all saved tasks from storage',
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () async {
                    // Fetch the Box directly from dataStore
                    final base = BaseWidget.of(context);
                    final box = base.dataStore.listenToTask();

                    if (box.value.isNotEmpty) {
                      // Show delete confirmation dialog
                      final confirm = await showDeleteAllConfirmationDialog(
                        context,
                      );

                      if (confirm == true) {
                        // Clear all tasks from Hive storage
                        await box.value.clear();
                        messageDeletedAllWarning(context);
                      }
                    } else {
                      // Show warning if list is already empty
                      emptyFieldsWarning(context);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ------------------ 3. SECTION: ABOUT & APP ------------------
            _buildSectionHeader(context, 'About App'),
            const SizedBox(height: 10),
            _buildSettingsCard(
              context,
              children: [
                ListTile(
                  leading: _buildIconBox(
                    primaryColor,
                    Icons.info_outline_rounded,
                  ),
                  title: const Text(
                    'App Details',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsUi(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, indent: 60, endIndent: 20),
                ListTile(
                  leading: _buildIconBox(
                    primaryColor,
                    Icons.phonelink_setup_rounded,
                  ),
                  title: const Text(
                    'App Version',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ------------------ FOOTER ------------------
            Center(
              child: Text(
                'Made by Eyad',
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.6,
                  ),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper widget for section headers
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  // Helper widget to build grouped settings cards
  Widget _buildSettingsCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }

  // Helper widget for icon container background
  Widget _buildIconBox(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}
