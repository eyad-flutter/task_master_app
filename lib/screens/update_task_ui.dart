import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/buttons/buttons.dart';
import 'package:todo_app/buttons/delete_task_button.dart';
import 'package:todo_app/main_widgets/warnings.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/list_ui.dart';
import 'package:todo_app/utils/custom_text_field.dart';

class UpdateTaskUi extends StatefulWidget {
  const UpdateTaskUi({super.key, required this.task});

  final Task task;

  @override
  State<UpdateTaskUi> createState() => _UpdateTaskUiState();
}

class _UpdateTaskUiState extends State<UpdateTaskUi> {
  final formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController titleUpdate;
  late TextEditingController subtitleUpdate;

  // Local FocusNodes
  late FocusNode titleFocus;
  late FocusNode subtitleFocus;

  @override
  void initState() {
    super.initState();
    titleUpdate = TextEditingController(text: widget.task.title);
    subtitleUpdate = TextEditingController(text: widget.task.subtitle);
    selectedDate = widget.task.createdAtDate;
    selectedTime = TimeOfDay.fromDateTime(widget.task.createdAtTime);
    titleFocus = FocusNode();
    subtitleFocus = FocusNode();
  } // To give the controllers its value the second the ui open

  @override
  void dispose() {
    titleUpdate.dispose();
    subtitleUpdate.dispose();
    titleFocus.dispose();
    subtitleFocus.dispose();
    super.dispose();
  }

  String get formattedDate => selectedDate != null
      ? DateFormat.yMMMEd().format(selectedDate!)
      : DateFormat.yMMMEd().format(DateTime.now());

  void _updateTask() async {
    try {
      widget.task.title = titleUpdate.text.trim();
      widget.task.subtitle = subtitleUpdate.text.trim();

      final DateTime finalDate = selectedDate ?? widget.task.createdAtDate;
      final TimeOfDay finalTime =
          selectedTime ?? TimeOfDay.fromDateTime(widget.task.createdAtTime);

      widget.task.createdAtTime = DateTime(
        finalDate.year,
        finalDate.month,
        finalDate.day,
        finalTime.hour,
        finalTime.minute,
      );
      widget.task.createdAtDate = finalDate;

      await widget.task.save();

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ListUi(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );

      messageUpdatedWarning(context);
    } catch (e) {
      debugPrint("Error updating task: $e");
    }
  }

  // For date & time
  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String formattedTime12Two = DateFormat('hh:mm a').format(DateTime.now());

  String formattedDateTwo = DateFormat.yMMMEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ListUi(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                transitionDuration: const Duration(milliseconds: 200),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ), // Between AppBar & ADD TASK
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.006,
                        color: Colors.black.withValues(alpha: 0.1),
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Update Task",
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.006,
                        color: Colors.black.withValues(alpha: 0.1),
                        indent: 10,
                      ),
                    ),
                  ],
                ),
              ), // UPDATE TASK title
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ), // Between ADD TASK & Title Field
              Form(
                key: formKey,
                child: CustomTextField(
                  labelText: "Title",
                  titleToSubtitle: subtitleFocus,
                  focusNode: titleFocus,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: titleUpdate,
                  height: 0.07,
                  hintText: "What's The Task Title?",
                  maxLines: 1,
                  prefixIcon: Icons.text_snippet_outlined,
                ),
              ), // Title Field
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.07,
              ), // Between Title Field & Desc...
              CustomTextField(
                focusNode: subtitleFocus,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: subtitleUpdate,
                height: 0.22,
                hintText: "What are you planning for??",
                maxLines: 5,
              ), // Description Field
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  thickness: MediaQuery.of(context).size.width * 0.006,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ), // The divider under the TextFormField
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ), // Between Description Field & TimePicker
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text(
                      "Time",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.512),
                    GestureDetector(
                      onTap: () async {
                        titleFocus.unfocus();
                        subtitleFocus.unfocus();
                        // Open TimePicker and wait for user's decision
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime ?? TimeOfDay.now(),
                        );

                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).datePickerTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            selectedTime != null
                                ? selectedTime!.format(
                                    context,
                                  ) // Show time in --:-- Am/Pm format
                                : formattedTime12Two,
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // TimePicker
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ), // Between TimePicker & DatePicker
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text(
                      "Date",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                    GestureDetector(
                      onTap: () async {
                        titleFocus.unfocus();
                        subtitleFocus.unfocus();
                        // Open DatePicker and wait for user's decision
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          // Default date
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).datePickerTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // DatePicker
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ), // Between DatePicker & Buttons
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    DeleteTaskButton(
                      formKey: formKey,
                      widget: widget,
                      task: widget.task,
                    ),
                    // DELETE TASK Button
                    const Spacer(),
                    Buttons(
                      onTap: () async {
                        if (formKey.currentState!.validate() == false) {
                          return;
                        }
                        _updateTask();
                      },
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.blueAccent.withValues(alpha: 0.3),
                      ],
                      shadowColor: Theme.of(context).primaryColor,
                      text: "Update Task",
                    ),
                    // UPDATE TASK Button
                  ],
                ),
              ), // Buttons
            ],
          ),
        ),
      ),
    );
  }
}
