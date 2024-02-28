import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:week_4/firebase_options.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';
import 'dart:async';

class RemoteApiDatasource extends IDataSource {
  late FirebaseDatabase database;
  late Future initTask;

  RemoteApiDatasource() {
    initTask = Future(() async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      database = FirebaseDatabase.instance;
    });
  }

  @override
  Future<List<Todo>>browse() async {
    await initTask;
    List<Todo> todos = <Todo>[];

    final DataSnapshot snapshot = await database.ref('todos').get();

    if (!snapshot.exists) {
      throw Exception(
          "Invalid Request - Cannot find snapshot: ${snapshot.ref.path}");
    }

    Map<String, dynamic>.from(snapshot.value as Map).forEach((key, value) {
      value['_id'] = key;
      todos.add(Todo.fromJson(value));
    });

    return todos;
  }

  @override
  Future<bool> add(Todo model) async {
    DatabaseReference ref = database.ref('todos/${model.id}');

    await ref.set({
      "_id": model.id,
      "name": model.name,
      "description": model.description,
      "completed": model.completed,
    });

    return true;
  }

  // @override
  // Future<List<Todo>> browse() {
  //   // TODO: implement browse
  //   throw UnimplementedError();
  // }

  @override
  Future<bool> delete(Todo model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Todo model) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Todo> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }
}
