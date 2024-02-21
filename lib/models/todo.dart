class Todo{
  String name;
  String description;
  bool complete;

  Todo({required this.name, required this.description, this.complete = false});


  @override
  String toString() {
    return "$name - ($description) ";
      }
}