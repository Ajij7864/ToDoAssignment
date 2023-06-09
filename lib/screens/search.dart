import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/todoprovider.dart';
import 'package:todo_project/screens/tododetailsscreen.dart';
import 'package:todo_project/widgets/searchdelegate.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 34, 35),
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 159, 218, 228),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final searchQuery = await showSearch<String>(
                context: context,
                delegate: TodoSearchDelegate(todoProvider.todos),
              );

              if (searchQuery != null) {
                todoProvider.search(searchQuery);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          final searchResults = todoProvider.searchResults;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final todo = searchResults[index];
              return Dismissible(
                key: ValueKey(todo.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    todoProvider.deleteHandler(todo);
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
          );
        },
      ),
    );
  }
}
