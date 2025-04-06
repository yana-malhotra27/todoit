import 'package:dart_mappable/dart_mappable.dart';

part 'models.mapper.dart';

@MappableClass()
class User with UserMappable {
  final int id;
  final String name;
  final String email;
  final String apiKey;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.apiKey,
  });
  static const fromJson = UserMapper.fromJson;
}

@MappableClass()
class Todo with TodoMappable {
  final int id;
  final String title;
  final String? description;
  final String status;
  final DateTime? createdAt;

  Todo(
      {required this.id,
      required this.title,
      this.description,
      required this.status,
      this.createdAt});
  static final fromJson = TodoMapper.fromJson;
}


@MappableClass()
class TodoCreate with TodoCreateMappable {
  final String title;
  final String? description;

  TodoCreate({required this.title, this.description});
  //final Map<String, dynamic> toJson = TodoCreateMapper.toJson;
}

@MappableClass()
class TodoUpdate with TodoUpdateMappable {
  final String title;
  final String description;
  final String status;

  TodoUpdate(
      {required this.title, required this.description, this.status="pending"});
}
