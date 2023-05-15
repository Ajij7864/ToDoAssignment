import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/todoprovider.dart';
import 'package:todo_project/screens/searchdelegate.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 34, 35),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 159, 218, 228),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: TodoSearchDelegate(todoProvider.search),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoProvider.searchResults.length,
        itemBuilder: (context, index) {
          final todo = todoProvider.searchResults[index];
          return Card(
            child: ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
            ),
          );
        },
      ),
    );
  }
}
