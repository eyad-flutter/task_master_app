import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/update_task_ui.dart';

class CardsTile extends StatefulWidget {
  const CardsTile({super.key, required this.task});

  final Task task;

  @override
  State<CardsTile> createState() => _CardsTileState();
}

class _CardsTileState extends State<CardsTile> {
  @override
  Widget build(BuildContext context) {
    String formattedTime12 = DateFormat(
      '  hh:mm a',
    ).format(widget.task.createdAtTime);

    String formattedDateMMdd = DateFormat(
      'yyyy/MM/dd',
    ).format(widget.task.createdAtDate);

    return Padding(
      padding: const EdgeInsetsGeometry.directional(top: 8),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ?widget.task.isCompleted
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.25)
                  : Theme.of(
                      context,
                    ).cardTheme.shadowColor?.withValues(alpha: 0.25),
              ?widget.task.isCompleted
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                  : Theme.of(
                      context,
                    ).cardTheme.shadowColor?.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    UpdateTaskUi(task: widget.task),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          leading: Transform.scale(
            scale: 1.45,
            child: Checkbox(
              checkColor: Colors.black.withValues(alpha: 0.68),
              activeColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              value: widget.task.isCompleted,
              side: BorderSide(
                width: MediaQuery.of(context).size.width * 0.002,
              ),
              onChanged: (bool? newValue) async {
                setState(() {
                  widget.task.isCompleted = newValue ?? false;
                });
                // Calling save() is required to update the Hive box so external listeners detect the changes.
                // It is placed outside setState() to avoid UI lag during the disk write process.
                await widget.task.save();
              },
            ),
          ),
          // The checkbox
          title: Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.task.isCompleted
                  ? Colors.grey.shade600
                  : Theme.of(context).textTheme.displayMedium?.color,
              decoration: widget.task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text.rich(
            TextSpan(
              text: widget.task.subtitle,
              style: TextStyle(
                color: widget.task.isCompleted
                    ? Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)
                    : Theme.of(context).textTheme.bodyMedium?.color,
                decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 15,
              ),
            ), // The text inside task
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding: const EdgeInsets.all(10),
          horizontalTitleGap: 10,
          trailing: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      " $formattedDateMMdd \n $formattedTime12",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // DataTime
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
