import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todoprovider.dart';

class TodoDetailScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final todo;

  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo destails Screen'),
      ),
      backgroundColor: const Color.fromARGB(255, 52, 41, 72),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            color: Colors.white,
            elevation: 12,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Consumer<TodoProvider>(
                      builder: (context, todoProvider, child) {
                        final selectedDate = todo.date;
                        final now = DateTime.now();
                        final timeRemaining = selectedDate.difference(now);
                        final days = timeRemaining.inDays;

                        final hours = timeRemaining.inHours;
                        final minutes = timeRemaining.inMinutes.remainder(60);

                        return Text(
                          ' $days D, $hours H, $minutes M',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        );
                      },
                    ),
                  ),
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    todo.description,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
