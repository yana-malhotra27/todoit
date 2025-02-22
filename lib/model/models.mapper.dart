// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'models.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static int _$id(User v) => v.id;
  static const Field<User, int> _f$id = Field('id', _$id);
  static String _$name(User v) => v.name;
  static const Field<User, String> _f$name = Field('name', _$name);
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email = Field('email', _$email);
  static String _$apiKey(User v) => v.apiKey;
  static const Field<User, String> _f$apiKey = Field('apiKey', _$apiKey);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #apiKey: _f$apiKey,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        email: data.dec(_f$email),
        apiKey: data.dec(_f$apiKey));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJsonString(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJsonString() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toJson() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return UserMapper.ensureInitialized().equalsValue(this as User, other);
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name, String? email, String? apiKey});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  $R call({int? id, String? name, String? email, String? apiKey}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (apiKey != null) #apiKey: apiKey
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email),
      apiKey: data.get(#apiKey, or: $value.apiKey));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl($value, $cast, t);
}

class TodoMapper extends ClassMapperBase<Todo> {
  TodoMapper._();

  static TodoMapper? _instance;
  static TodoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TodoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Todo';

  static int _$id(Todo v) => v.id;
  static const Field<Todo, int> _f$id = Field('id', _$id);
  static String _$title(Todo v) => v.title;
  static const Field<Todo, String> _f$title = Field('title', _$title);
  static String? _$description(Todo v) => v.description;
  static const Field<Todo, String> _f$description =
      Field('description', _$description, opt: true);
  static String _$status(Todo v) => v.status;
  static const Field<Todo, String> _f$status = Field('status', _$status);
  static DateTime? _$createdAt(Todo v) => v.createdAt;
  static const Field<Todo, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);

  @override
  final MappableFields<Todo> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #status: _f$status,
    #createdAt: _f$createdAt,
  };

  static Todo _instantiate(DecodingData data) {
    return Todo(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        status: data.dec(_f$status),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Todo fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Todo>(map);
  }

  static Todo fromJsonString(String json) {
    return ensureInitialized().decodeJson<Todo>(json);
  }
}

mixin TodoMappable {
  String toJsonString() {
    return TodoMapper.ensureInitialized().encodeJson<Todo>(this as Todo);
  }

  Map<String, dynamic> toJson() {
    return TodoMapper.ensureInitialized().encodeMap<Todo>(this as Todo);
  }

  TodoCopyWith<Todo, Todo, Todo> get copyWith =>
      _TodoCopyWithImpl(this as Todo, $identity, $identity);
  @override
  String toString() {
    return TodoMapper.ensureInitialized().stringifyValue(this as Todo);
  }

  @override
  bool operator ==(Object other) {
    return TodoMapper.ensureInitialized().equalsValue(this as Todo, other);
  }

  @override
  int get hashCode {
    return TodoMapper.ensureInitialized().hashValue(this as Todo);
  }
}

extension TodoValueCopy<$R, $Out> on ObjectCopyWith<$R, Todo, $Out> {
  TodoCopyWith<$R, Todo, $Out> get $asTodo =>
      $base.as((v, t, t2) => _TodoCopyWithImpl(v, t, t2));
}

abstract class TodoCopyWith<$R, $In extends Todo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? title,
      String? description,
      String? status,
      DateTime? createdAt});
  TodoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TodoCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Todo, $Out>
    implements TodoCopyWith<$R, Todo, $Out> {
  _TodoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Todo> $mapper = TodoMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? title,
          Object? description = $none,
          String? status,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (description != $none) #description: description,
        if (status != null) #status: status,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  Todo $make(CopyWithData data) => Todo(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      status: data.get(#status, or: $value.status),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  TodoCopyWith<$R2, Todo, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TodoCopyWithImpl($value, $cast, t);
}

class TodoCreateMapper extends ClassMapperBase<TodoCreate> {
  TodoCreateMapper._();

  static TodoCreateMapper? _instance;
  static TodoCreateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TodoCreateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TodoCreate';

  static String _$title(TodoCreate v) => v.title;
  static const Field<TodoCreate, String> _f$title = Field('title', _$title);
  static String? _$description(TodoCreate v) => v.description;
  static const Field<TodoCreate, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<TodoCreate> fields = const {
    #title: _f$title,
    #description: _f$description,
  };

  static TodoCreate _instantiate(DecodingData data) {
    return TodoCreate(
        title: data.dec(_f$title), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static TodoCreate fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TodoCreate>(map);
  }

  static TodoCreate fromJsonString(String json) {
    return ensureInitialized().decodeJson<TodoCreate>(json);
  }
}

mixin TodoCreateMappable {
  String toJsonString() {
    return TodoCreateMapper.ensureInitialized()
        .encodeJson<TodoCreate>(this as TodoCreate);
  }

  Map<String, dynamic> toJson() {
    return TodoCreateMapper.ensureInitialized()
        .encodeMap<TodoCreate>(this as TodoCreate);
  }

  TodoCreateCopyWith<TodoCreate, TodoCreate, TodoCreate> get copyWith =>
      _TodoCreateCopyWithImpl(this as TodoCreate, $identity, $identity);
  @override
  String toString() {
    return TodoCreateMapper.ensureInitialized()
        .stringifyValue(this as TodoCreate);
  }

  @override
  bool operator ==(Object other) {
    return TodoCreateMapper.ensureInitialized()
        .equalsValue(this as TodoCreate, other);
  }

  @override
  int get hashCode {
    return TodoCreateMapper.ensureInitialized().hashValue(this as TodoCreate);
  }
}

extension TodoCreateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TodoCreate, $Out> {
  TodoCreateCopyWith<$R, TodoCreate, $Out> get $asTodoCreate =>
      $base.as((v, t, t2) => _TodoCreateCopyWithImpl(v, t, t2));
}

abstract class TodoCreateCopyWith<$R, $In extends TodoCreate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description});
  TodoCreateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TodoCreateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TodoCreate, $Out>
    implements TodoCreateCopyWith<$R, TodoCreate, $Out> {
  _TodoCreateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TodoCreate> $mapper =
      TodoCreateMapper.ensureInitialized();
  @override
  $R call({String? title, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (description != $none) #description: description
      }));
  @override
  TodoCreate $make(CopyWithData data) => TodoCreate(
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description));

  @override
  TodoCreateCopyWith<$R2, TodoCreate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TodoCreateCopyWithImpl($value, $cast, t);
}

class TodoUpdateMapper extends ClassMapperBase<TodoUpdate> {
  TodoUpdateMapper._();

  static TodoUpdateMapper? _instance;
  static TodoUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TodoUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TodoUpdate';

  static String _$title(TodoUpdate v) => v.title;
  static const Field<TodoUpdate, String> _f$title = Field('title', _$title);
  static String _$description(TodoUpdate v) => v.description;
  static const Field<TodoUpdate, String> _f$description =
      Field('description', _$description);
  static String _$status(TodoUpdate v) => v.status;
  static const Field<TodoUpdate, String> _f$status =
      Field('status', _$status, opt: true, def: "pending");

  @override
  final MappableFields<TodoUpdate> fields = const {
    #title: _f$title,
    #description: _f$description,
    #status: _f$status,
  };

  static TodoUpdate _instantiate(DecodingData data) {
    return TodoUpdate(
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static TodoUpdate fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TodoUpdate>(map);
  }

  static TodoUpdate fromJsonString(String json) {
    return ensureInitialized().decodeJson<TodoUpdate>(json);
  }
}

mixin TodoUpdateMappable {
  String toJsonString() {
    return TodoUpdateMapper.ensureInitialized()
        .encodeJson<TodoUpdate>(this as TodoUpdate);
  }

  Map<String, dynamic> toJson() {
    return TodoUpdateMapper.ensureInitialized()
        .encodeMap<TodoUpdate>(this as TodoUpdate);
  }

  TodoUpdateCopyWith<TodoUpdate, TodoUpdate, TodoUpdate> get copyWith =>
      _TodoUpdateCopyWithImpl(this as TodoUpdate, $identity, $identity);
  @override
  String toString() {
    return TodoUpdateMapper.ensureInitialized()
        .stringifyValue(this as TodoUpdate);
  }

  @override
  bool operator ==(Object other) {
    return TodoUpdateMapper.ensureInitialized()
        .equalsValue(this as TodoUpdate, other);
  }

  @override
  int get hashCode {
    return TodoUpdateMapper.ensureInitialized().hashValue(this as TodoUpdate);
  }
}

extension TodoUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TodoUpdate, $Out> {
  TodoUpdateCopyWith<$R, TodoUpdate, $Out> get $asTodoUpdate =>
      $base.as((v, t, t2) => _TodoUpdateCopyWithImpl(v, t, t2));
}

abstract class TodoUpdateCopyWith<$R, $In extends TodoUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description, String? status});
  TodoUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TodoUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TodoUpdate, $Out>
    implements TodoUpdateCopyWith<$R, TodoUpdate, $Out> {
  _TodoUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TodoUpdate> $mapper =
      TodoUpdateMapper.ensureInitialized();
  @override
  $R call({String? title, String? description, String? status}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (status != null) #status: status
      }));
  @override
  TodoUpdate $make(CopyWithData data) => TodoUpdate(
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      status: data.get(#status, or: $value.status));

  @override
  TodoUpdateCopyWith<$R2, TodoUpdate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TodoUpdateCopyWithImpl($value, $cast, t);
}
