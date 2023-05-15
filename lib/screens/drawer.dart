import 'package:flutter/material.dart';
import 'package:todo_project/screens/completedtodo.dart';
import 'package:todo_project/screens/incompleted.dart';
import 'package:todo_project/screens/settings.dart';

import 'failedtocompleteintime.dart';

class DrawerForCompletedTask extends StatelessWidget {
  const DrawerForCompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 58, 24, 43),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 123, 88, 129),
              ),
              child: Center(
                child: Text(
                  'To Do Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Failed to Complete'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FailedToDoScreen(
                      context: context,
                    ),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('Completed'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompletedToDo(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box_outline_blank),
            title: const Text('Incomplete'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IncompletedToDo(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
