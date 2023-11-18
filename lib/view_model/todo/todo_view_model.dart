import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:poc_mvvm_riverpod_architecture/model/todo/todo.dart';
import 'package:poc_mvvm_riverpod_architecture/model/todo/todo_list_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/user_info/user_id_provider.dart';

class GetTodo {
  Ref ref;
  GetTodo(
    this.ref,
  );
  final _storage = const FlutterSecureStorage();

  Future<TodoListModel> getTodoText() async {
    try {
      final userId = ref.read(userIdProvider);
      final String? serializedTodoList =
          await _storage.read(key: 'todo_list_$userId');

      if (serializedTodoList != null) {
        final List<dynamic> decodedList = jsonDecode(serializedTodoList);
        final todos =
            decodedList.map((todoMap) => Todo.fromMap(todoMap)).toList();
        return TodoListModel(todos: List.from(todos));
      }
      return const TodoListModel(todos: []);
    } catch (err) {
      throw Exception();
    }
  }
}

final getTodoProvider = Provider((ref) => GetTodo(ref));
final getTodoFutureProvider = FutureProvider<TodoListModel>((ref) {
  return ref.watch(getTodoProvider).getTodoText();
});
