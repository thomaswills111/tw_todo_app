import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool completed;

  Todo(
      {this.id = 0,
      required this.name,
      required this.description,
      this.completed = false});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'description': description,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> mapData) {
    bool complete = mapData['completed'] is int
        ? mapData['completed'] == 0
            ? false
            : true
        : mapData['completed'];
    return Todo(
        id: mapData['_id'],
        name: mapData['name'],
        description: mapData['description'],
        completed: complete);
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      completed: json['completed'],
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
      id: reader.read(0),
      name: reader.read(1),
      description: reader.read(2),
      completed: reader.read(3),
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
