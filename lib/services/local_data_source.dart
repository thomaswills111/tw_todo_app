import 'package:hive_flutter/adapters.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';

class LocalHiveDataSource extends IDataSource {
  final String boxName = 'todos';

  LocalHiveDataSource() {
    init();
  }

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    Box box = await Hive.openBox('todos_box');
  }

  @override
  Future<List<Todo>> browse() async {
    List<Todo> todos = [];
    var box = Hive.box(boxName);

    return List.generate(
        box.values.cast().length, (i) => Todo.fromMap(box.get(i)));
  }

  @override
  Future<Todo> read(String string) async {
    return Todo(name: '', description: '');
  }

  @override
  Future<bool> edit(Todo todo) async {
    return true;
  }

  @override
  Future<bool> add(Todo todo) async {
    var box = Hive.box(boxName);
    try {
      box.put('todos', todo);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> delete(Todo todo) async {
    return true;
  }
}
