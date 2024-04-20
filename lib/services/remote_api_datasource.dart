import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:week_4/firebase_options.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';
import 'dart:async';

class RemoteApiDatasource extends IDataSource {
  late FirebaseDatabase database;
  late CollectionReference todosReference;
  late Future initTask;

  RemoteApiDatasource() {
    initTask = Future(() async {
      database = FirebaseDatabase.instance;
    });
  }

  @override
  Future<List<Todo>> browse() async {
    await initTask;
    List<Todo> todos = <Todo>[];

    final DataSnapshot snapshot = await database.ref('todos').get();

    if (!snapshot.exists) {
      throw Exception(
          "Invalid Request - Cannot find snapshot: ${snapshot.ref.path}");
    }

    Map<String, dynamic>.from(snapshot.value as Map).forEach((key, value) {
      value['id'] = key;
      todos.add(Todo.fromJson(value));
    });

    return todos;
  }

  @override
  Future<bool> add(Todo model) async {
    await database.ref('todos').push().set({
      // model.toMap()
      'name': model.name,
      'description' : model.description,
      'completed': model.completed,
  });
    return true;

  }

  @override
  Future<bool> delete(Todo model) async {
    await database.ref('todos/${model.id}').remove();
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    await database
        .ref('todos/${model.id}')
        .update({'completed': model.completed});
    return true;
  }

  @override
  Future<Todo> read(String id) async {
    final snapshot =  await database.ref('todos/$id').get();
    return Todo.fromJson(snapshot.value as Map);

  }
}
