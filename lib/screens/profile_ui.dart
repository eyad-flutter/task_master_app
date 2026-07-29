import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/main_widgets/app_bar_tasks.dart';
import 'package:todo_app/main_widgets/tasks_drawer.dart';
import 'package:todo_app/utils/consts.dart';
import 'package:todo_app/utils/custom_text_field.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({super.key});

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  late TextEditingController _nameController;
  late int _selectedAvatarIndex;
  late Box _settingsBox;

  @override
  void initState() {
    super.initState();
    _settingsBox = Hive.box('settingsBox');

    // Fetch saved data from Hive or fallback to default values
    String currentName = _settingsBox.get('userName', defaultValue: '');
    _selectedAvatarIndex = _settingsBox.get('userAvatarIndex', defaultValue: 0);

    _nameController = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProfileData() {
    // Save profile data to Hive
    _settingsBox.put('userName', _nameController.text.trim());
    _settingsBox.put('userAvatarIndex', _selectedAvatarIndex);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withValues(alpha: 0.7),
        content: Text(
          'Profile updated successfully!',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    GlobalKey<ScaffoldState> scaffoldKeyThree = GlobalKey();

    return Scaffold(
      key: scaffoldKeyThree,
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: appBarTasks(context, () {
        scaffoldKeyThree.currentState!.openDrawer();
      }),

      drawer: const TasksDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ------------------ 1. CURRENT AVATAR DISPLAY ------------------
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: avatarList[_selectedAvatarIndex]['color'],
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: avatarList[_selectedAvatarIndex]['icon'],
                      radius: 60,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ------------------ 2. AVATAR SELECTION GRID ------------------
            _buildSectionCard(
              context,
              title: 'Choose Your Avatar',
              child: SizedBox(
                height: 75,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: avatarList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedAvatarIndex == index;
                    Color itemColor = avatarList[index]['color'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatarIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? itemColor : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: itemColor.withValues(alpha: 0.2),
                          child: CircleAvatar(
                            backgroundImage: avatarList[index]['icon'],
                            radius: 32,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ------------------ 3. EDIT USER DETAILS ------------------
            _buildSectionCard(
              context,
              title: 'Personal Details',
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Name",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _nameController,
                    height: 0.07,
                    hintText: "What's Your Name?",
                    maxLines: 1,
                    prefixIcon: Icons.person,
                  ), // Title Field

                  const SizedBox(height: 30),

                  // ------------------ 4. SAVE BUTTON ------------------
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _saveProfileData,
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build consistent section cards
  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
