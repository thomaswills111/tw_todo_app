import 'package:sqflite/sqflite.dart';
import 'package:week_4/models/todo.dart';
import 'package:week_4/services/data_source.dart';
import 'package:path/path.dart';

class SQLDatasource extends IDataSource {
  late Database database;
  late Future init;
  final String tableName = 'todos';

  SQLDatasource() {
    init = initialise();
  }

  Future<void> initialise() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      onCreate: (db, version) {
        
        return db.execute(
            'CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY AUTO_INCREMENT, name TEXT, description TEXT, completed INTEGER)');
      },
      version: 1,
    );
    // initalised = true;
  }

  @override
  Future<List<Todo>> browse() async {
    await init;
    List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  @override
  Future<Todo> read(String id) async {
    final List<Map<String, dynamic>> result;
    await init;
    result = await database.query(tableName, where: 'id = ?', whereArgs: [id]); // ? is a placeholder substituted with whereArgs
    return Todo.fromMap(result[0]);
  }

  @override
  Future<bool> edit(Todo model) async {
    await init;
    await database.update(tableName, model.toMap(), where: 'id = ?', whereArgs: [model.id]);
    return true;
  }

  @override
  Future<bool> add(Todo model) async {
    await init;
    // todo.toMap().remove('id');
    try {
      // await database.insert(tableName, model.toMap().remove('id'));
      await database.insert(tableName, model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(Todo model) async {
    await init;
    await database.delete(tableName, where: 'id = ?', whereArgs: [model.id]);
    return true;
  }
}
