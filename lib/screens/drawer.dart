import 'package:flutter/material.dart';
import 'package:todo_project/screens/completedtodo.dart';
import 'package:todo_project/screens/incompleted.dart';
import 'package:todo_project/screens/mainui.dart';
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
            leading: const Icon(
              Icons.home,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainUi(
                      context: context,
                    ),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.error,
              color: Colors.red,
              size: 32.0,
            ),
            title: const Text(
              'Failed to Complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
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
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.check_box,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Completed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompletedToDo(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Incomplete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
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
