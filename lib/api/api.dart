import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://todocrud.chiggydoes.tech')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/todos/")
  Future<Todo> createTodo(@Body() TodoCreate todo);

  @GET("/todos/")
  Future<List<Todo>> getTodos();

  @PUT("/todos/{id}")
  Future<Todo> updateTodo(@Path("id") int id, @Body() TodoUpdate todo);

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
// Function to create Dio instance with BaseOptions
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: "https://todocrud.chiggydoes.tech",
    headers: {
      "Content-Type": "application/json",
    },
  ));
  return dio;
});
