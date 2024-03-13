import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';
import 'package:week_4/services/sql_data_source.dart';

class TodosNotifier extends ChangeNotifier {
  // final SQLDatasource _datasource = SQLDatasource();

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
    IDataSource dataSource = Get.find();
    await dataSource.add(todo);
    refresh();
  }

  removeTodo(Todo todo) async {
    IDataSource dataSource = Get.find();
    await dataSource.delete(todo);
    refresh();
  }

  // Not used currently
  clearTodos() {
    IDataSource dataSource = Get.find();
    _todos.clear();
    notifyListeners();
  }

  updateTodo(Todo todo) async {
    IDataSource dataSource = Get.find();
    await dataSource.edit(todo);
    refresh();
  }

  Future<dynamic> refresh() async {
    IDataSource dataSource = Get.find();
    _todos = await dataSource.browse();
    notifyListeners();
  }
}
