import '../imports.dart';

@immutable
class ToDoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isChecked;

  const ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isChecked,
    required this.date,
  });

  ToDoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isChecked,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isChecked: isChecked ?? this.isChecked,
      date: date ?? this.date,
    );
  }

  factory ToDoModel.fromToDoHive(ToDo hiveTodo) {
    return ToDoModel(
      id: hiveTodo.id,
      title: hiveTodo.title,
      description: hiveTodo.description,
      isChecked: hiveTodo.isChecked,
      date: hiveTodo.date,
    );
  }
}
