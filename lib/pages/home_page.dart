import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_4/components/todo_widget.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/notifiers/todos_notifier.dart';
import 'package:week_4/utils/methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> todos = <Todo>[
    Todo(name: "Shopping", description: "Pick up groceries", completed: true),
    Todo(name: "Paint", description: "Recreate the Mono Lisa"),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<TodosNotifier>(
              builder: (_, notifier, __) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Todo: ${notifier.todoRemainingCount.toString()}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.01,
            bottom: size.height * 0.01,
            left: size.width * 0.12,
            right: size.width * 0.12),
        child: Consumer<TodosNotifier>(
          builder: (context, notifier, child) => RefreshIndicator(
            onRefresh: notifier.refresh,
            child: ListView.builder(
                itemCount: notifier.todoCount,
                itemBuilder: (BuildContext context, int i) {
                  return TodoWidget(todo: notifier.todos[i]);
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        child: const Icon(Icons.edit),
      ),
    );
  }

  _openAddTodo() {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _description = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // showDialog(context: context, builder: ((context) => Column(children: [],)));

    showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            content: Center(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Add Todo',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const Text('Title'),
                      TextFormField(
                        controller: _name,
                        validator: emptyFormValidation,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: Text('Description'),
                      ),
                      TextFormField(
                        controller: _description,
                        validator: emptyFormValidation,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;
                                await Provider.of<TodosNotifier>(context,
                                        listen: false)
                                    .addTodo(Todo(
                                        name: _name.text,
                                        description: _description.text));
                                Navigator.pop(context);
                              },
                              child: const Text('Submit')),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
