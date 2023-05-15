import 'package:flutter/material.dart';

class TodoSearchDelegate extends SearchDelegate<String> {
  final Function(String) searchFunction;

  TodoSearchDelegate(this.searchFunction);

  @override
  String get searchFieldLabel => 'Search Todos';

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
    searchFunction(query);
    return Container(); // No need to display results here as they are shown in Settings widget
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No need to show suggestions for this case
  }
}
