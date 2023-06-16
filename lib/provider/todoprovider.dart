part of 'providers.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = false;
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;
  List<ToDo> get ftodos => _todos
      .where((element) =>
          element.isChecked == false &&
          element.date.difference(DateTime.now()).isNegative)
      .toList();

  void addToDoHandler(BuildContext context) {
    _showAddTodoModal(context);
    notifyListeners();
  }

  void addTodo(title, description, selectedSDate) {
    final todoBox = Hive.box('my_todo_box');

    todoBox.add(
      ToDo(
        title: title,
        date: selectedDate,
        description: description,
        id: DateTime.now().toString(),
        isChecked: false,
      ),
    );
    notifyListeners();
  }

  // void addTodoHandler(
  //     String title, String description, DateTime selectedDate) async {
  //   isLoading = true;
  //   try {
  //     final url =
  //         Uri.parse('https://todo-fbcb7-default-rtdb.firebaseio.com/todo.json');
  //     final response = await http.post(url,
  //         body: json.encode({
  //           'date': selectedDate.toIso8601String(),
  //           'isChecked': false,
  //           'title': title,
  //           'description': description,
  //         }));

  //     if (response.statusCode == 200) {
  //       isLoading = false;
  //       notifyListeners();
  //       return;
  //     }

  //     final newTodo = ToDo(
  //       date: selectedDate,
  //       isChecked: false,
  //       id: json.decode(response.body)['name'],
  //       title: title,
  //       description: description,
  //     );
  //     _todos.insert(0, newTodo);
  //     notifyListeners();
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     return;
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  // void updateTodoHandler(String id, bool newCheckedValue) async {
  //   isLoading = true;
  //   try {
  //     final url = Uri.parse(
  //         'https://todo-fbcb7-default-rtdb.firebaseio.com/todo/$id.json');
  //     final response = await http.patch(
  //       url,
  //       body: json.encode({'isChecked': newCheckedValue}),
  //     );

  //     if (response.statusCode == 200) {
  //       final updatedTodoIndex = _todos.indexWhere((todo) => todo.id == id);
  //       if (updatedTodoIndex >= 0) {
  //         _todos[updatedTodoIndex].isChecked = newCheckedValue;
  //         notifyListeners();
  //       }
  //       isLoading = false;
  //       notifyListeners();
  //       return;
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     return;
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  void updateTodoHandler(id, newCheckedVal) async {
    final todoBox = Hive.box('my_todo_box');
    final todoIndex =
        todoBox.values.toList().indexWhere((todo) => todo.id == id.toString());

    if (todoIndex != -1) {
      final todo = todoBox.getAt(todoIndex) as ToDo;
      todo.isChecked = newCheckedVal;
      todo.save();
    }
    notifyListeners();
  }

  // Future<void> fetchSetData() async {
  //   notifyListeners();
  //   final url =
  //       Uri.parse('https://todo-fbcb7-default-rtdb.firebaseio.com/todo.json');
  //   final response = await http.get(url);
  //   final extractedData = json.decode(response.body) as Map<String, dynamic>;

  //   final List<ToDo> settodos = [];

  //   extractedData.forEach((key, value) {
  //     settodos.insert(
  //         0,
  //         ToDo(
  //           id: key,
  //           title: value['title'],
  //           description: value['description'],
  //           isChecked: value['isChecked'],
  //           date: DateTime.parse(value['date'] as String),
  //         ));
  //   });
  //   _todos = settodos;
  //   notifyListeners();
  // }

  void fetchSetData() {
    final todoBox = Hive.box('my_todo_box');
    final List<ToDo> fetchedTodos = todoBox.values.toList().cast<ToDo>();
    _todos = fetchedTodos;
    notifyListeners();
  }

  void _showAddTodoModal(BuildContext context) {
    String title = '';
    String description = '';
    notifyListeners();

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
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (title.isNotEmpty && description.isNotEmpty) {
                            addTodo(title, description, selectedDate);
                            Navigator.pop(context);
                            selectedDate = DateTime.now();
                            notifyListeners();
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

  void deleteHandler(todo) {
    todo.delete();
  }

  // void deleteHandler(String id) async {
  //   isLoading = true;
  //   final url = Uri.parse(
  //       'https://todo-fbcb7-default-rtdb.firebaseio.com/todo/$id.json');
  //   await http.delete(url);
  //   _todos.removeWhere((element) => element.id == id);
  //   isLoading = false;
  //   notifyListeners();
  // }

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
    } else {
      searchResults.addAll(
        todos.where(
          (todo) => todo.title.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }

    notifyListeners();
  }

  List<ToDo> completedTodos(List<ToDo> todos) {
    notifyListeners();
    return todos.where((todo) => todo.isChecked).toList();
  }

  List<ToDo> incompletedTodos(List<ToDo> todos) {
    notifyListeners();
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
