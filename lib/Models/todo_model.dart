import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  int id;
  String task;
  String description;
  bool finished;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    required this.finished,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        task: json["task"],
        description: json["Description"],
        finished: json["finished"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "Description": description,
        "finished": finished,
      };
}
