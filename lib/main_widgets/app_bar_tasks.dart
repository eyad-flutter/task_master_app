import 'package:flutter/material.dart';

AppBar appBarTasks(BuildContext context, Function() onPressed) {
  return AppBar(
    // Prevent AppBar color change on scroll
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
      onPressed: onPressed,
      // Named parameter callback to open drawer (3)
      icon: Icon(
        Icons.menu,
        color: Theme.of(context).textTheme.bodyMedium?.color,
        size: 35,
      ),
    ),
  );
}
