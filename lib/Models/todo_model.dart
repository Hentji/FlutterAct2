class Todo {
  final String id;
  final String task;
  final String description;
  final bool finished;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    required this.finished,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      description: json['description'],
      finished: json['finished'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'description': description,
      'finished': finished.toString(),
    };
  }
}
