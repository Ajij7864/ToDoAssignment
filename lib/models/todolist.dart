import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todolist.g.dart';

@HiveType(typeId: 1)
class ToDo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  bool isChecked;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.isChecked,
    required this.date,
  });
}
