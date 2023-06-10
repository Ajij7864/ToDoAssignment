part of 'screens.dart';

class TodoDetailScreen extends StatefulWidget {
  final dynamic todo;

  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(
      context,
    );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Consumer<TodoProvider>(
                          builder: (context, todoProvider, child) {
                            final selectedDate = widget.todo.date;
                            final now = DateTime.now();
                            final timeRemaining = selectedDate.difference(now);
                            final days = timeRemaining.inDays;

                            final hours = timeRemaining.inHours.remainder(24);
                            final minutes =
                                timeRemaining.inMinutes.remainder(60);

                            return Text(
                              ' $days D, $hours H, $minutes M',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            );
                          },
                        ),
                      ),
                      Checkbox(
                        value: widget.todo.isChecked,
                        onChanged: (value) {
                          setState(() {
                            todoProvider.updateTodoHandler(
                                widget.todo.id, value!);
                          });
                        },
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () =>
                              todoProvider.deleteHandler(widget.todo),
                          icon: const Icon(Icons.delete,
                              size: 40, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.todo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.todo.description,
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
