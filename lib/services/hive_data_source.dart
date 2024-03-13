import 'package:hive_flutter/adapters.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';

class HiveDataSource implements IDataSource {
  late final Future init;
  final String boxName = 'todos';
  // final Box box;

  HiveDataSource() {
    init = initialise();
  }

  Future<void> initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    // Hive.deleteBoxFromDisk(boxName);
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
    return true;
    // await init;
    // Box box = await Hive.box(boxName);
    // Todo todo = box.get(model.id.toString());
    // todo.completed = model.completed;
    // box.put(model.id.toString(), todo);
    // return true;
  }

  @override
  Future<bool> add(Todo model) async {
    await init;
    Box box = Hive.box<Todo>(boxName);

    // Box box = Hive.box(boxName);
    try {
      box.add(model);
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
