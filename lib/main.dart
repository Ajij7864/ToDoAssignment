import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/authentication_provider.dart';
import 'package:todo_project/screens/login.dart';
import 'package:todo_project/provider/todoprovider.dart';

import 'models/todolist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox('my_todo_box');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
