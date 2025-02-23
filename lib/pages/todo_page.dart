import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoit/pages/auth_page.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/themes/theme_provider.dart';
import '../model/models.dart';
import '../providers/auth_provider.dart'; // Import your auth provider

class TodoPage extends ConsumerStatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final ScrollController _scrollController = ScrollController(); // Declare here

  @override
  void dispose() {
    _scrollController.dispose(); // Properly dispose to prevent memory leaks
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final apiKey = ref.watch(apiKeyProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"), // ✅ Keep text black
        centerTitle: true,
        elevation: 4,
        backgroundColor: theme.appBarTheme.backgroundColor, // ✅ Uses theme setting
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme(); // Toggle theme
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
        thickness: 6.0, // Width of the scrollbar
        radius: const Radius.circular(10), // Rounded edges
        thumbVisibility: true, // Shows the scrollbar when scrolling
        child: ref.watch(todoProvider).when(
          data: (todos) {
            return ListView.builder(
              controller: _scrollController, // Ensure this is attached!
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('lib/tilebg.jpg'), // Ensure the path is correct
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ListTile(
                    title: Text(todo.title, style: const TextStyle(color: Colors.black)), // ✅ Keep text black
                    subtitle: Text(todo.description ?? '', style: const TextStyle(color: Colors.black54)), // ✅ Dark grey for subtitle
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black), // ✅ Keep icon black
                          onPressed: () {
                            _showEditDialog(context, ref, apiKey!, todo);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black), // ✅ Keep icon black
                          onPressed: () async {
                            await ref.read(todoServiceProvider).deleteTodo(todo.id);
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context, ref, apiKey!);
        },
        backgroundColor: const Color.fromARGB(255, 179, 59, 195),
        //backgroundColor: Theme.of(context).colorScheme.primary, // ✅ Uses theme color
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary), // ✅ Icon in white for visibility
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