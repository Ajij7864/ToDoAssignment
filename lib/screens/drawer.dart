part of 'screens.dart';

class DrawerForCompletedTask extends StatelessWidget {
  const DrawerForCompletedTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainUi(
                    context: context,
                  ),
                ),
              );
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
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.search,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Search(),
                ),
              );
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
                ),
              );
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
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 32,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {
              authProvider.signOut(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
