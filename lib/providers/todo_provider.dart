import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/models.dart';
import 'auth_provider.dart'; // Authentication provider for API key

part 'todo_provider.g.dart';

@RestApi(baseUrl: "https://todocrud.chiggydoes.tech")
abstract class TodoService {
  factory TodoService(Dio dio, {String? baseUrl}) = _TodoService;

  @GET("/todos/")
  Future<List<Todo>> getTodos();

  @POST("/todos/")
  Future<Todo> createTodo(
      @Body() TodoCreate todo);

  @PUT("/todos/{id}")
  Future<Todo> updateTodo(
      @Path("id") int id, @Body() TodoUpdate todo);

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(
      @Path("id") int id);
}

// Provider for Dio
final dioProvider = Provider<Dio>((ref) {
  final apiKey = ref.watch(apiKeyProvider);
  final dio = Dio(BaseOptions(
    baseUrl: "https://todocrud.chiggydoes.tech",
    headers: {
      "Content-Type": "application/json",
      "X-API-Key": apiKey,
    },
  ));
  return dio;
});

// Provider for TodoService (Retrofit client)
final todoServiceProvider = Provider<TodoService>((ref) {
  final dio = ref.watch(dioProvider);
  return TodoService(dio);
});

// Fetch to-do list with authentication
final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final apiKey = ref.watch(apiKeyProvider);
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception("No API key found");
  }

  final todoService = ref.read(todoServiceProvider);
  return await todoService.getTodos();
});