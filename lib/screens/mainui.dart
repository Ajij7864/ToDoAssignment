part of 'screens.dart';

class MainUi extends StatefulWidget {
  final BuildContext context;

  const MainUi({Key? key, required this.context}) : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<TodoProvider>(context, listen: false).fetchSetData());
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      backgroundColor: const Color.fromARGB(255, 51, 49, 52),
      appBar: AppBar(
          elevation: 4,
          backgroundColor: const Color.fromARGB(255, 19, 203, 209),
          actions: [
            IconButton(
              onPressed: () {
                todoProvider.addToDoHandler(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
          title: const Center(
            child: Text('What To Do?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          )),
      drawer: const DrawerForCompletedTask(),
      body: (todoProvider.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<TodoProvider>(
              builder: (context, todoPro, child) => ListView.builder(
                itemCount: todoPro.todos.length,
                itemBuilder: (context, index) {
                  final todos = todoPro.todos;
                  todos.sort((a, b) => a.date
                      .difference(DateTime.now())
                      .compareTo(b.date.difference(DateTime.now())));
                  final todo = todos[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Dismissible(
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
                              builder: (context) =>
                                  TodoDetailScreen(todo: todo),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: const Color.fromARGB(238, 255, 255, 255),
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          todo.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          todo.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
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
                                          builder:
                                              (context, todoProvider, child) {
                                            final selectedDate =
                                                todoProvider.todos[index].date;
                                            final now = DateTime.now();
                                            final timeRemaining =
                                                selectedDate.difference(now);
                                            final days = timeRemaining.inDays;

                                            final hours = timeRemaining.inHours
                                                .remainder(24);
                                            final minutes = timeRemaining
                                                .inMinutes
                                                .remainder(60);

                                            return FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                ' $days D, $hours H, $minutes M',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: todo.isChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                todoProvider.updateTodoHandler(
                                                    todo.id, value!);
                                              });
                                            },
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () => todoProvider
                                                  .deleteHandler(todo),
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
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          elevation: 4,
          backgroundColor: const Color.fromARGB(255, 87, 6, 124),
          hoverColor: Colors.green,
          onPressed: () {
            todoProvider.addToDoHandler(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
