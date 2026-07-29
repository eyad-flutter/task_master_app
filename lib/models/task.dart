import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart'; // For every task generate a new one & (Must have the same name as this file + .g)

@HiveType(typeId: 0) // Marking this class with Id = 0
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) // As the key of each attribute
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String subtitle;

  @HiveField(3)
  DateTime createdAtTime;

  @HiveField(4)
  DateTime createdAtDate;

  @HiveField(5)
  bool isCompleted;

  factory Task.create({
    required String? title,
    required String? subtitle,
    required DateTime? createdAtTime,
    required DateTime? createdAtDate,
    required bool? isCompleted,
  }) => Task(
    id: const Uuid().v1(),
    // To run the UUID to give to every task it's own id
    title: title ?? "",
    subtitle: subtitle ?? "",
    createdAtTime: createdAtTime ?? DateTime.now(),
    createdAtDate: createdAtDate ?? DateTime.now(),
    isCompleted: isCompleted ?? false,
  );
}
