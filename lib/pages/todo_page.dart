import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Theme.of(context).appBarTheme.centerTitle,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Todos', style: TextStyle(color: Colors.white),),),
    );
  }
}