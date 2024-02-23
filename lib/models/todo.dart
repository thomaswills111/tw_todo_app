class Todo{
  int id;
  String name;
  String description;
  bool completed;

  Todo({this.id = 0, required this.name, required this.description, this.completed = false});

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
      id: mapData['id'], name: mapData['name'], description:  mapData['description'], completed: complete);
  }

  @override
  String toString() {
    return "$name - ($description) ";
      }
}