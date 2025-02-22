import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/models.dart';
import 'auth_provider.dart'; // Authentication provider for API key

part 'todo_provider.g.dart';

@RestApi(baseUrl: "https://todocrud.chiggydoes.tech")
abstract class TodoService {
  factory TodoService(Dio dio, {String? baseUrl}) = _TodoService;

  @GET("/todos")
  Future<List<Todo>> getTodos(@Header("X-API-Key") String apiKey);

  @POST("/todos")
  Future<Todo> createTodo(
      @Header("X-API-Key") String apiKey, @Body() TodoCreate todo);

  @PUT("/todos/{id}")
  Future<Todo> updateTodo(@Header("X-API-Key") String apiKey,
      @Path("id") int id, @Body() TodoUpdate todo);

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(
      @Header("X-API-Key") String apiKey, @Path("id") int id);
}
// Provider for Dio with headers
final dioProvider = Provider<Dio>((ref) {
  final apiKey = ref.watch(apiKeyProvider);
  final dio = Dio(BaseOptions(
    baseUrl: "https://todocrud.chiggydoes.tech",
    headers: {
      "Content-Type": "application/json",
      "X-API-Key": apiKey,
    },
    followRedirects: true, // Allow following redirects
    validateStatus: (status) => status != null && status < 500, // ✅ Avoid null status
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print("🔹 Request: ${options.method} ${options.path}");
      print("🔹 Headers: ${options.headers}");
      print("🔹 Body: ${options.data}");
      handler.next(options);
    },
    onResponse: (response, handler) {
      print("✅ Response (${response.statusCode}): ${response.realUri}");
      print("✅ Data: ${response.data}");
      handler.next(response);
    },
    onError: (DioException e, handler) {
      print("❌ Error: ${e.response?.statusCode} - ${e.message}");
      print("❌ Response: ${e.response?.data}");
      handler.next(e);
    },
  ));
  return dio;
});

// Custom TodoService Wrapper (For Custom Requests)
class CustomTodoService {
  final Dio _dio;
  CustomTodoService(this._dio);

  Future<List<Todo>> getTodos(String apiKey) async {
    try {
      final response = await _dio.get(
        "/todos",
        options: Options(headers: {"X-API-Key": apiKey}),
      );
      return (response.data as List)
          .map((todo) => Todo.fromJson(todo))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to fetch todos: ${e.response?.statusCode} - ${e.message}");
    }
  }

  Future<Todo?> createTodo(String apiKey, TodoCreate todo) async {
    try {
      final response = await _dio.post('/todos',
          options: Options(headers: {"X-API-Key": apiKey}),
          data: todo.toJson());

      // ✅ If the response is a 307 redirect, extract the new URL
      if (response.statusCode == 307) {
        final newUrl = response.headers.value('location'); // Get the new URL

        if (newUrl != null) {
          // ✅ Resend the request to the new URL
          final redirectResponse = await _dio.post(newUrl,
              options: Options(headers: {"X-API-Key": apiKey}),
              data: todo.toJson());

          return Todo.fromJson(redirectResponse.data);
        }
      }

      // ✅ Prevent crashes by checking for null
      if (response.data == null) {
        throw Exception("Error: Received null response from server");
      }

      return Todo.fromJson(response.data);
    } catch (e) {
      print("🚨 Error creating TODO: $e");
      return null; // Handle errors gracefully
    }
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

// Custom Service Provider
final customTodoServiceProvider = Provider<CustomTodoService>((ref) {
  final dio = ref.watch(dioProvider);
  return CustomTodoService(dio);
});

// Provider for TodoService (Retrofit client)
final todoServiceProvider = Provider<TodoService>((ref) {
  final dio = ref.watch(dioProvider);
  return TodoService(dio);
});

// Fetch to-do list with authentication
final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final apiKey = ref.watch(apiKeyProvider);
  if (apiKey == null) throw Exception("No API key found");

  final todoService = ref.read(todoServiceProvider);
  return await todoService.getTodos(apiKey);
});
