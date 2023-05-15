import 'package:flutter/material.dart';
import 'package:todo_project/provider/todolist.dart';

import '../datetimepicker.dart';

class TodoProvider with ChangeNotifier {
  final List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  List<ToDo> get failedtodos => _todos
      .where((element) => element.date.difference(DateTime.now()).isNegative)
      .toList();

  void addToDoHandler(BuildContext context) {
    _showAddTodoModal(context);
  }

  void addTodoHandler(String title, String description, DateTime selectedDate) {
    final newTodo = ToDo(
      date: selectedDate,
      isChecked: false,
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _todos.add(newTodo);
    notifyListeners();
  }

  void _showAddTodoModal(BuildContext context) {
    String title = '';
    String description = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const DateTimePicker(),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // dismiss the bottom sheet
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (title.isNotEmpty && description.isNotEmpty) {
                            addTodoHandler(title, description, selectedDate);
                            Navigator.pop(context);
                            selectedDate = DateTime.now();
                            notifyListeners();
                            // dismiss the bottom sheet
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void deleteHandler(String id) {
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();

  void showDatePickerHandler(BuildContext context) {
    notifyListeners();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate = pickedDate;
      notifyListeners();
    });
  }

  List<ToDo> searchResults = [];

  void search(String query) {
    searchResults.clear();

    if (query.isEmpty) {
      searchResults.addAll(todos);
      notifyListeners();
    } else {
      searchResults.addAll(
        todos.where(
          (todo) => todo.title.toLowerCase().contains(query.toLowerCase()),
        ),
      );
      notifyListeners();
    }
  }

  List<ToDo> completedTodos(List<ToDo> todos) {
    return todos.where((todo) => todo.isChecked).toList();
  }

  List<ToDo> incompletedTodos(List<ToDo> todos) {
    return todos.where((todo) => !todo.isChecked).toList();
  }

  void moveCompletedToPending() {
    final completedTodos = _todos.where((todo) => todo.isChecked).toList();
    _todos.removeWhere((todo) => todo.isChecked);
    for (var todo in completedTodos) {
      todo.isChecked = false;
    }
    _todos.addAll(completedTodos);
    notifyListeners();
  }

  void moveIncompletedToPending() {
    final completedTodos = _todos.where((todo) => todo.isChecked).toList();
    _todos.removeWhere((todo) => todo.isChecked);
    for (var todo in completedTodos) {
      todo.isChecked = true;
    }
    _todos.addAll(completedTodos);
    notifyListeners();
  }
}
