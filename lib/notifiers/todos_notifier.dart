import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';
import 'package:week_4/services/sql_data_source.dart';

class TodosNotifier extends ChangeNotifier {
  final SQLDatasource _datasource = SQLDatasource();

  List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  int get todoRemainingCount =>
      _todos.where((t) => t.completed == false).length;

  TodosNotifier() {
    refresh();
  }

  addTodo(Todo todo) async {
    // _todos.add(todo);
    await _datasource.add(todo);
    refresh();
    notifyListeners();
  }

  removeTodo(Todo todo) async {
    // _todos.remove(todo);
    await _datasource.delete(todo);
    refresh();
    notifyListeners();
  }

  // Not used currently
  clearTodos() {
    _todos.clear();
    notifyListeners();
  }

  updateTodo(Todo todo) {
    _datasource.edit(todo);
    refresh();
    notifyListeners();
  }

  // FIX THIS
  Future<void> refresh() async {
    if (GetIt.I.isReadySync<IDataSource>()) {
      _todos = await GetIt.I<IDataSource>().browse();
      notifyListeners();
    } else {
      print('Was not ready');
      _todos = await GetIt.I<IDataSource>().browse();
      notifyListeners();
    }
  }
}
