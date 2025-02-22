import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../api/api.dart'; // Ensure this file contains the correct base URL
import '../model/models.dart';

final todoServiceProvider = Provider<TodoService>((ref) {
  final dio = ref.read(dioProvider); // Ensure dioProvider is defined
  return TodoService(dio);
});

class TodoService {
  final Dio _dio;

  TodoService(this._dio);

  Future<List<Todo>> getTodos(String apiKey) async {
    try {
      final response = await _dio.get(
        "/todos/",
        options: Options(headers: {"X-API-Key": apiKey}),
      );
      // Ensure the response is a List and map it to Todo objects
      return (response.data as List)
          .map((todo) => Todo.fromJson(todo))
          .toList();
    } on DioException catch (e) {
      print("DioError: ${e.response?.statusCode} - ${e.response?.data}");
      throw Exception("Failed to fetch todos: ${e.message}");
    }
  }

  Future<Todo> createTodo(String apiKey, TodoCreate todo) async {
    final response = await _dio.post(
      "/todos/",
      data: todo.toJson(),
      options: Options(headers: {"X-API-Key": apiKey}),
    );
    return Todo.fromJson(response.data);
  }

  Future<Todo> updateTodo(String apiKey, int id, TodoUpdate todoUpdate) async {
    final response = await _dio.put(
      "/todos/$id",
      data: todoUpdate.toJson(),
      options: Options(headers: {"X-API-Key": apiKey}),
    );
    return Todo.fromJson(response.data);
  }

  Future<void> deleteTodo(String apiKey, int id) async {
    await _dio.delete(
      "/todos/$id",
      options: Options(headers: {"X-API-Key": apiKey}),
    );
  }
}
