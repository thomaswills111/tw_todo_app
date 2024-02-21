import 'package:flutter/material.dart';
import 'package:week_4/configs/themes.dart';
import 'package:week_4/pages/home_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: appTheme,
      home: const HomePage(title: 'Home'),
    );
  }
}
