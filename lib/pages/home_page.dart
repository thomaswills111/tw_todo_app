import 'package:flutter/material.dart';
import 'package:week_4/configs/constants.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/pages/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> todos = <Todo>[
    Todo(name: "Shopping", description: "Pick up groceries", complete: true),
    Todo(name: "Paint", description: "Recreate the Mono Lisa"),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
        child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      todos[i].complete = false;
                    });
                  },
                  child: GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        todos.remove(todos[i]);
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          todos[i].complete = true;
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        // builder: ((context) => const TodoPage())));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todos[i].name,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Text(todos[i].description,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic)),
                                  ],
                                ),
                                Icon(
                                  todos[i].complete
                                      ? Icons.check_box_outlined
                                      : Icons.square_outlined,
                                  size: 28,
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        child: const Icon(Icons.edit),
      ),
    );
  }

  _openAddTodo() {
    final size = MediaQuery.of(context).size;
    final TextEditingController _title = TextEditingController();
    final TextEditingController _description = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // showDialog(context: context, builder: ((context) => Column(children: [],)));

    showDialog(
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(top: size.height * 0.3, bottom: size.height * 0.3),
        child: AlertDialog(
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
                        'Add a Todo',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const Text('Title'),
                    TextFormField(
                      controller: _title,
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
                            onPressed: () {
                              if(!_formKey.currentState!.validate()) return;
                              setState(() {
                                todos.add(Todo(
                                    name: _title.text,
                                    description: _description.text));
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Submit')),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  String? emptyFormValidation(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value!';
                      }
                      return null;
                    }
}
