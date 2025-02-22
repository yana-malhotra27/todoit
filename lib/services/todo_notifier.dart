import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/models.dart';
import 'todo_service.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoService _todoService;

  TodoNotifier(this._todoService) : super([]);

  Future<void> fetchTodos(String apiKey) async {
    final todos = await _todoService.getTodos(apiKey);
    state = todos; // Update the state with the fetched todos
  }

  Future<void> createTodo(String apiKey, TodoCreate todo) async {
    final newTodo = await _todoService.createTodo(apiKey, todo);
    state = [...state, newTodo]; // Add the new Todo to the state
  }

  Future<void> updateTodo(String apiKey, int id, TodoUpdate todoUpdate) async {
    await _todoService.updateTodo(apiKey, id, todoUpdate);
    await fetchTodos(apiKey); // Refresh the list after updating
  }

  Future<void> deleteTodo(String apiKey, int id) async {
    await _todoService.deleteTodo(apiKey, id);
    await fetchTodos(apiKey); // Refresh the list after deleting
  }
}

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(ref.read(todoServiceProvider));
});