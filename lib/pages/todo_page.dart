import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoit/pages/auth_page.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/themes/theme_provider.dart';
import '../model/models.dart';
import '../providers/auth_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = ref.watch(apiKeyProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        centerTitle: true,
        elevation: 4,
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: Scrollbar(
        controller: _scrollController,
        thickness: 6.0,
        radius: const Radius.circular(10),
        thumbVisibility: true,
        child: ref.watch(todoProvider).when(
          data: (todos) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  height:  120,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.asset(
                          'lib/tilebg.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 229, 199, 226).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ListTile(
                          title: Text(
                            todo.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            todo.description ?? '',
                            style: const TextStyle(color: Colors.black54),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black, size: 22),
                                onPressed: () {
                                  _showEditDialog(context, ref, apiKey!, todo);
                                },
                              ),
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.black, size: 22),
                                onPressed: () async {
                                  await ref.read(todoServiceProvider).deleteTodo(todo.id);
                                  ref.invalidate(todoProvider);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context, ref, apiKey!);
        },
        backgroundColor: Colors.purpleAccent.withOpacity(0.9),
        elevation: 6,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
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
                await ref.read(todoServiceProvider).createTodo(newTodo);
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
                  await ref.read(todoServiceProvider).updateTodo(todo.id, updatedTodo);
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