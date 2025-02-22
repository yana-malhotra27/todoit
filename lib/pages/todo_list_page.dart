import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/models.dart';
import '../services/todo_notifier.dart';

class TodoListPage extends ConsumerWidget {
  final String? apiKey;

  TodoListPage({this.apiKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (apiKey == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Todo List")),
        body: Center(child: Text("API Key is required")),
      );
    }

    final todos = ref.watch(todoNotifierProvider); // Watch the state

    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/tilebg.jpg'), // Ensure this path is correct
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
          ),
          // List of Todos
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description ?? "No description"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showUpdateDialog(context, ref, todo);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              ref.read(todoNotifierProvider.notifier).deleteTodo(apiKey!, todo.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoNotifierProvider.notifier).fetchTodos(apiKey!);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, WidgetRef ref, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedTodo = TodoUpdate(
                  title: titleController.text,
                  description: descriptionController.text,
                );

                ref.read(todoNotifierProvider.notifier).updateTodo(apiKey!, todo.id, updatedTodo);
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without updating
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}