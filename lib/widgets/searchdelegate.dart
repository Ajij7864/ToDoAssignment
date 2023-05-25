import 'package:flutter/material.dart';

import '../models/todolist.dart';

class TodoSearchDelegate extends SearchDelegate<String> {
  final List<ToDo> todos;

  TodoSearchDelegate(this.todos);

  @override
  String get searchFieldLabel => 'Search by title, description, or date';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredTodos = todos.where((todo) {
      final title = todo.title.toLowerCase();
      final description = todo.description.toLowerCase();
      final formattedDate = todo.date.toString().toLowerCase();
      final queryLowercase = query.toLowerCase();
      return title.contains(queryLowercase) ||
          description.contains(queryLowercase) ||
          formattedDate.contains(queryLowercase);
    }).toList();

    return ListView.builder(
      itemCount: filteredTodos.length,
      itemBuilder: (context, index) {
        final todo = filteredTodos[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedTodos = todos.where((todo) {
      final title = todo.title.toLowerCase();
      final queryLowercase = query.toLowerCase();
      return title.contains(queryLowercase);
    }).toList();

    return ListView.builder(
      itemCount: suggestedTodos.length,
      itemBuilder: (context, index) {
        final todo = suggestedTodos[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          onTap: () {
            close(context, todo.title);
          },
        );
      },
    );
  }
}
