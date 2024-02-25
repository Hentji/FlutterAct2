import 'package:flutter/material.dart';
import 'package:flutter_activity2/Models/todo_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<Todo>> _todoListFuture;

  @override
  void initState() {
    super.initState();
    _todoListFuture = fetchTodoList();
  }

  // Future<List<Todo>> fetchTodoList() async {
  //   final response = await http.get(Uri.parse('http://192.168.1.3:3001/todos'));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //     List<dynamic> todoList = jsonResponse[
  //         'todos']; // Assuming 'todos' is the key containing the list of todos
  //     List<Todo> todos = todoList.map((item) => Todo.fromJson(item)).toList();
  //     return todos;
  //   } else {
  //     throw Exception('Failed to load todo list');
  //   }
  // }

  Future<List<Todo>> fetchTodoList() async {
    final response = await http.get(Uri.parse('http://192.168.1.3:3001/todos'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Todo> todos =
          body.map((dynamic item) => Todo.fromJson(item)).toList();
      return todos;
    } else {
      throw Exception('Failed to load todo list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: snapshot.data![index].finished,
                    onChanged: (newValue) {},
                  ),
                  title: Row(
                    children: [
                      const Text('Task '),
                      Text((index + 1).toString()),
                      const Text(': '),
                      Text(snapshot.data![index].task),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // By default, show a loading spinner
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
