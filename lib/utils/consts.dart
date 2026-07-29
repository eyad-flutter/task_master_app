import 'package:flutter/material.dart';

// Drawer Cards
final List<String> drawerCards = ["Home", "Profile", "Settings", "Details"];

// Avatars List
final List<Map<String, dynamic>> avatarList = [
  {
    'icon': const AssetImage('images/man.png'),
    'color': const Color(0xff4fc3f9),
  },
  {'icon': const AssetImage('images/boy.png'), 'color': Colors.tealAccent},
  {
    'icon': const AssetImage('images/anonymous.png'),
    'color': Colors.pinkAccent,
  },
  {'icon': const AssetImage('images/woman.png'), 'color': Colors.red},
  {'icon': const AssetImage('images/girl.png'), 'color': Colors.purpleAccent},
  {
    'icon': const AssetImage('images/anonymous girl.png'),
    'color': Colors.pinkAccent,
  },
];

// Themes
final ThemeData lightTheme = ThemeData.light().copyWith(
  // Settings Card's Color
  canvasColor: Colors.white.withValues(alpha: 0.01),
  // theme
  primaryColor: const Color(0xff4fc3f7),
  // backgroundColor
  scaffoldBackgroundColor: Colors.white,
  //shadow
  shadowColor: Colors.grey.shade600.withValues(alpha: 0.06),
  // border
  cardColor: Colors.black87.withValues(alpha: 0.1),

  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.blueAccent.shade200.withValues(alpha: 0.7),
    ),
    // textOne
    bodyMedium: const TextStyle(color: Colors.grey),
    // textTwo
    displayLarge: TextStyle(color: Colors.black.withValues(alpha: 0.68)),
    // MY TASK Text
    displayMedium: const TextStyle(color: Colors.black),
    // card Title 2
    displaySmall: const TextStyle(color: Colors.black), // card Subtitle 2
  ),
  cardTheme: CardThemeData(
    color: Colors.grey.withValues(alpha: 0.04), // tasksOne
    shadowColor: Colors.white.withValues(alpha: 0.17), //tasksTwo
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, // Fields Cursor Color
    selectionHandleColor: Colors.transparent, // Cursor bubble
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.grey.withValues(
      alpha: 0.5,
    ), // Date & time picker color
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  // Settings Card's Color
  canvasColor: Colors.white.withValues(alpha: 0.05),
  // theme
  primaryColor: const Color(0xff4fc3f7),
  // backgroundColor
  scaffoldBackgroundColor: const Color(0xFF121212),
  //shadow
  shadowColor: Colors.grey.shade600.withValues(alpha: 0.06),
  // border
  cardColor: const Color(0xFF1E1E1E),

  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.blueAccent.shade200.withValues(alpha: 0.7),
    ),
    // textOne
    bodyMedium: const TextStyle(color: Colors.grey),
    // textTwo
    displayLarge: const TextStyle(color: Colors.white),
    // MY TASK Text
    displayMedium: const TextStyle(color: Colors.white),
    // card Title 2
    displaySmall: const TextStyle(color: Colors.black), // card Subtitle 2
  ),
  cardTheme: CardThemeData(
    color: Colors.grey.withValues(alpha: 0.04), // tasksOne
    shadowColor: Colors.white.withValues(alpha: 0.17), //tasksTwo
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white70, // Fields Cursor Color
    selectionHandleColor: Colors.transparent, // Cursor bubble
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white70.withValues(
      alpha: 0.35,
    ), // Date & time picker color
  ),
);
