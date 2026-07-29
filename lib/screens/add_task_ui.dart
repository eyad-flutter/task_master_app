import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/buttons/add_task_button.dart';
import 'package:todo_app/screens/list_ui.dart';
import 'package:todo_app/utils/custom_text_field.dart';

class AddTaskUi extends StatefulWidget {
  AddTaskUi({super.key});

  // For title & subtitle
  final TextEditingController titleAdd = TextEditingController();
  final TextEditingController subtitleAdd = TextEditingController();

  // For date & time
  static DateTime? selectedDate;

  static DateTime? selectedTime;

  static String get formattedTime12Two =>
      DateFormat('hh:mm a').format(DateTime.now());

  static String get formattedDate =>
      DateFormat.yMMMEd().format(selectedDate ?? DateTime.now());

  static String get formattedDateTwo =>
      DateFormat.yMMMEd().format(DateTime.now());

  @override
  State<AddTaskUi> createState() => _AddTaskUiState();
}

class _AddTaskUiState extends State<AddTaskUi> {
  final formKey = GlobalKey<FormState>();

  final FocusNode titleFocus = FocusNode();
  final FocusNode subtitleFocus = FocusNode();

  @override
  void dispose() {
    titleFocus.dispose();
    subtitleFocus.dispose();
    widget.titleAdd.dispose();
    widget.subtitleAdd.dispose();
    super.dispose();
  }

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
                transitionDuration: const Duration(milliseconds: 300),
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.15),
              // Between AppBar & ADD TASK
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.006,
                        color: Colors.black.withValues(alpha: 0.1),
                        endIndent: 10,
                      ),
                    ),
                    const Text("Add Task", style: TextStyle(fontSize: 40)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: Divider(
                        thickness: MediaQuery.of(context).size.width * 0.006,
                        color: Colors.black.withValues(alpha: 0.1),
                        indent: 10,
                      ),
                    ),
                  ],
                ), // ADD TASK title
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              // Between ADD TASK & Title Field
              Form(
                key: formKey,
                child: CustomTextField(
                  labelText: "Title",
                  titleToSubtitle: subtitleFocus,
                  focusNode: titleFocus,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: widget.titleAdd,
                  height: 0.07,
                  hintText: "What's The Task Title?",
                  maxLines: 1,
                  prefixIcon: Icons.text_snippet_outlined,
                ),
              ),
              // Title Field
              SizedBox(height: MediaQuery.of(context).size.width * 0.07),
              // Between Title Field & Desc...
              CustomTextField(
                focusNode: subtitleFocus,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: widget.subtitleAdd,
                height: 0.22,
                hintText: "What are you planning for??",
                maxLines: 5,
              ),
              // Description Field
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  thickness: MediaQuery.of(context).size.width * 0.006,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ),
              // The divider under the TextFormField
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              // Between Description Field & TimePicker
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
                          initialTime: TimeOfDay.now(),
                        );

                        if (picked != null) {
                          setState(() {
                            AddTaskUi.selectedTime = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              picked.hour,
                              picked.minute,
                            ); // Update and save in state
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
                            AddTaskUi.selectedTime != null
                                ? DateFormat.jm().format(
                                    AddTaskUi.selectedTime ?? DateTime.now(),
                                  ) // The format of --:-- PM/AM
                                : AddTaskUi.formattedTime12Two,
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // TimePicker
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              // Between TimePicker & DatePicker
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
                          initialDate:
                              AddTaskUi.selectedDate ??
                              DateTime.now(), // Default date
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                        if (picked != null) {
                          setState(() {
                            AddTaskUi.selectedDate = picked;
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
                            AddTaskUi.selectedDate != null
                                ? AddTaskUi.formattedDate
                                : AddTaskUi.formattedDateTwo,
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // DatePicker
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              // Between DatePicker & Buttons
              AddTaskButton(formKey: formKey, widget: widget),
              // ADD TASK Button
            ],
          ),
        ),
      ),
    );
  }
}
