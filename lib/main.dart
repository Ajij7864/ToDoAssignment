import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/screens/mainui.dart';
import 'package:todo_project/provider/todoprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: const Icon(Icons.home),
            animationDuration: const Duration(seconds: 3),
            backgroundColor: Colors.purple,
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: MainUi(context: context)),
      ),
    );
  }
}
