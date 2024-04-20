import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject{
  @HiveField(0)
  dynamic id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool completed;

  Todo(
      {this.id,
      required this.name,
      required this.description,
      this.completed = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> mapData) {
    // bool completed = mapData['completed'] ? true : false; // Dart is not truthy - does not work
    bool completed = mapData['completed'] is int
        ? mapData['completed'] != 0
        : mapData['completed'];
    // bool completed = mapData['completed'] is int
    //     ? mapData['completed'] == 0
    //         ? false
    //         : true
    //     : mapData['completed'];
    return Todo(
        id: (mapData['_id'] == null) ? mapData['id'] : 0,
        // id: mapData['id'],
        //id: 0,
        name: mapData['name'],
        description: mapData['description'],
        completed: completed);
  }

  factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      completed: json['completed'] == 1 
      ? true 
      : false,
    );
  }

  @override
  String toString() {
    return "$name - ($description) ";
  }
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      completed: reader.read(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.completed);
  }
}
