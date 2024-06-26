import 'package:hive_flutter/adapters.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';

class HiveDataSource implements IDataSource {
  late final Future init;
  final String boxName = 'todos';

  HiveDataSource() {
    init = initialise();
  }

  Future<void> initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>(boxName);
  }

  @override
  Future<List<Todo>> browse() async {
    await init;
    Box<Todo> box = Hive.box(boxName);
    return List.from(box.values.cast());
  }

  @override
  Future<Todo> read(String id) async {
    Box box = await Hive.openBox(boxName);
    return box.get(id);
  }

  @override
  Future<bool> edit(Todo model) async {
    await init;
    Box box = Hive.box<Todo>(boxName);
    Todo todo = box.get(model.key);
    todo.save();
    return true;
  }

  @override
  Future<bool> add(Todo todo) async {
    await init;
    Box box = Hive.box<Todo>(boxName);

    try {
      box.add(todo);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> delete(Todo todo) async {
    await init;
    Box box = Hive.box<Todo>(boxName);
    print(todo.id);
    box.delete(todo.key);
    return true;
  }
}
