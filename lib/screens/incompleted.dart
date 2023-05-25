import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/todoprovider.dart';
import 'package:todo_project/screens/tododetailsscreen.dart';

class IncompletedToDo extends StatefulWidget {
  const IncompletedToDo({Key? key}) : super(key: key);

  @override
  IncompletedToDoState createState() => IncompletedToDoState();
}

class IncompletedToDoState extends State<IncompletedToDo> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 49, 52),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 19, 203, 209),
        title: const Center(
          child: Text('Incompleted ToDos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ),
      ),
      body: ListView.builder(
        itemCount: todoProvider.incompletedTodos(todoProvider.todos).length,
        itemBuilder: (context, index) {
          final todo = todoProvider.incompletedTodos(todoProvider.todos)[index];
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
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              child: Consumer<TodoProvider>(
                                builder: (context, todoProvider, child) {
                                  final selectedDate =
                                      todoProvider.todos[index].date;
                                  final now = DateTime.now();
                                  final timeRemaining =
                                      selectedDate.difference(now);
                                  final days = timeRemaining.inDays;

                                  final hours =
                                      timeRemaining.inHours.remainder(24);
                                  final minutes =
                                      timeRemaining.inMinutes.remainder(60);

                                  return FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      ' $days D, $hours H, $minutes M',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                // TodoCheckbox(
                                //   initialValue: todo.isChecked,
                                // ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () =>
                                        todoProvider.deleteHandler(todo.id),
                                    icon: const Icon(Icons.delete,
                                        size: 40, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
