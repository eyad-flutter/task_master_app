import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

dynamic emptyFieldsWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: 'Oops!',
    subMsg: 'No tasks to delete',
    corner: 15,
    duration: 1500,
    color: Colors.red.withValues(alpha: 0.7),
  );
}

dynamic messageDeletedWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: 'Task Deleted Successfully',
    corner: 15,
    duration: 1500,
    color: Colors.green.withValues(alpha: 0.7),
  );
}

dynamic messageUpdatedWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: 'Task Updated Successfully',
    corner: 15,
    duration: 1500,
    color: Colors.green.withValues(alpha: 0.7),
  );
}

dynamic messageAddedWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: 'Task Added Successfully',
    corner: 15,
    duration: 1500,
    color: Colors.green.withValues(alpha: 0.7),
  );
}

dynamic messageDeletedAllWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: 'All Tasks Deleted Successfully',
    corner: 15,
    duration: 1500,
    color: Colors.green.withValues(alpha: 0.7),
  );
}

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(Icons.dangerous_outlined, color: Colors.red, size: 80),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Delete Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to delete this task?\nThis action cannot be undone.",
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          // Delete button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Future<bool?> showDeleteAllConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(Icons.dangerous_outlined, color: Colors.red, size: 80),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Clear All Tasks?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to delete all tasks? This action cannot be undone.",
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          // Delete button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              "Delete All",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
