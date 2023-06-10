part of 'providers.dart';

const todoHiveBox = "my_todo_box";

class TodoModelProvider extends AsyncNotifier<Map<String, ToDoModel>> {
  Box? todosBox;
  @override
  FutureOr<Map<String, ToDoModel>> build() async {
    todosBox = await Hive.openBox(todoHiveBox);
    final todoBox = Hive.box(todoHiveBox);
    final fetchedTodos = todoBox.values.toList().cast<ToDo>();
    Map<String, ToDoModel> data = {};
    for (final todo in fetchedTodos) {
      final t = ToDoModel.fromToDoHive(todo);
      data[t.id] = t;
    }
    return data;
  }

  void addTodo(ToDoModel todo) {
    Map<String, ToDoModel> data = state.value ?? {};
    data[todo.id] = todo;
    state = AsyncData(data);
  }

  void modifyTodo(
    String id, {
    String? title,
    String? description,
    DateTime? date,
    bool? isChecked,
  }) {
    Map<String, ToDoModel> data = state.value ?? {};
    final todo = data[id];

    if (todo != null) {
      data[id] = todo.copyWith(
        title: title,
        description: description,
        date: date,
        isChecked: isChecked,
      );
      state = AsyncData(data);
    }
  }

  void removeTodo(String id) {
    Map<String, ToDoModel> data = state.value ?? {};
    data.remove(id);
    state = AsyncData(data);
  }

  List<ToDoModel> get todoList => List.from(
        state.value?.values ?? <ToDoModel>[],
      );
}
