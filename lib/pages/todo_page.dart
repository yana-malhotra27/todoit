import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoit/pages/auth_page.dart';
import 'package:todoit/providers/todo_provider.dart';
import '../model/models.dart';
import '../providers/auth_provider.dart'; // Import your auth provider

class TodoPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKey = ref.watch(apiKeyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ref.watch(todoProvider).when(
        data: (todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/tilebg.jpg'), // Ensure the path is correct
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(context, ref, apiKey!, todo);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await ref.read(todoServiceProvider).deleteTodo(apiKey!, todo.id);
                          ref.invalidate(todoProvider); // Refresh the todo list
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context, ref, apiKey!);
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
              onPressed: () async {
                final newTodo = TodoCreate(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                await ref.read(todoServiceProvider).createTodo(apiKey, newTodo);
                ref.invalidate(todoProvider); // Refresh the todo list
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
                  ref.invalidate(todoProvider); // Refresh the todo list
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Todo updated successfully!")),
                  );
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