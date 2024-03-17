import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:week_4/configs/constants.dart';
import 'package:week_4/configs/themes.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/notifiers/todos_notifier.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.name,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(widget.todo.description,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Checkbox(
                    side: BorderSide(color: appTheme.unselectedWidgetColor),
                    value: widget.todo.completed,
                    onChanged: (value) {
                      // setState(() {
                      //   widget.todo.completed = value!;
                      // });
                      widget.todo.completed = value!;
                      Provider.of<TodosNotifier>(context, listen: false)
                          .updateTodo(widget.todo);
                    })
              ],
            ),
          )),
    );
  }
}
