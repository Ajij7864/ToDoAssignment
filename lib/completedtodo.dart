import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/todoprovider.dart';
import 'package:todo_project/screens/tododetailsscreen.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({Key? key}) : super(key: key);

  @override
  CompletedToDoState createState() => CompletedToDoState();
}

class CompletedToDoState extends State<CompletedToDo> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed To-Dos'),
      ),
      body: ListView.builder(
        itemCount: todoProvider.completedTodos(todoProvider.todos).length,
        itemBuilder: (context, index) {
          final todo = todoProvider.completedTodos(todoProvider.todos)[index];
          return Dismissible(
            key: ValueKey(todo.id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                todoProvider.deleteHandler(todo.id);
              }
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoDetailScreen(todo: todo),
                  ),
                );
              },
              child: Card(
                elevation: 12,
                margin: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            todo.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: todo.isChecked,
                        onChanged: (value) {
                          setState(() {
                            todo.isChecked = value!;
                            todoProvider.moveCompletedToPending();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => todoProvider.deleteHandler(todo.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
