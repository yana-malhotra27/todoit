import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'auth_provider.dart';

part 'todo_provider.g.dart';

@RestApi(baseUrl: "https://todocrud.chiggydoes.tech")
abstract class TodoService {
  factory TodoService(Dio dio, {String baseUrl}) = _TodoService;

  @GET("/todos")
  Future<List<String>> getTodos(@Header("X-API-Key") String apiKey);
}

final todoServiceProvider = Provider<TodoService>((ref) {
  final dio = Dio();
  return TodoService(dio);
});

final todoProvider = FutureProvider<List<String>>((ref) async {
  final apiKey = ref.watch(apiKeyProvider); // Get API Key from authProvider
  if (apiKey == null) throw Exception("No API key found");

  final todoService = ref.read(todoServiceProvider);
  return await todoService.getTodos(apiKey);
});
