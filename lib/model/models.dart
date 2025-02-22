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
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'], // Ensure this matches the API response
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null, // Parse the date string
    );
  }
}


@MappableClass()
class TodoCreate with TodoCreateMappable {
  final String title;
  final String? description;

  TodoCreate({required this.title, this.description});
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description ?? "", // Ensure it's not `null`
    };
  }
}

@MappableClass()
class TodoUpdate with TodoUpdateMappable {
  final String title;
  final String description;
  final String status;

  TodoUpdate(
      {required this.title, required this.description, this.status="pending"});
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status,
    };
  }
}
