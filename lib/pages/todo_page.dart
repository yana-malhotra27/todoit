import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/models.dart';
import '../services/todo_service.dart';
import '../providers/auth_provider.dart'; // Import your auth provider

class TodoPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKey = ref.watch(apiKeyProvider); // Ensure this provider exists and is set

    return Scaffold(
      appBar: AppBar(title: Text("Todos")),
      body: FutureBuilder<List<Todo>>(
        future: ref.read(todoServiceProvider).getTodos(apiKey!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, ref, apiKey, todo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(todoServiceProvider).deleteTodo(apiKey, todo.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context, ref, apiKey);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref, String apiKey) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Todo"),
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
                final newTodo = TodoCreate(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                ref.read(todoServiceProvider).createTodo(apiKey, newTodo);
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, String apiKey, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Todo"),
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
              onPressed: () async {
                final updatedTodo = TodoUpdate(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                try {
                  await ref.read(todoServiceProvider).updateTodo(apiKey, todo.id, updatedTodo);
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Todo updated successfully!")),
                  );
                  // Navigate back after the update
                  Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update Todo: $e")),
                    );
                  }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}