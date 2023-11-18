import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:poc_mvvm_riverpod_architecture/model/todo/todo.dart';
import 'package:poc_mvvm_riverpod_architecture/type_def/is_loading.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/user_info/user_id_provider.dart';

class LocalStorageService extends StateNotifier<IsLoading> {
  final _storage = const FlutterSecureStorage();
  Ref ref;

  LocalStorageService(this.ref) : super(false);

  set isLoading(bool value) => state = value;

  Future<void> saveOrUpdateTodo(Todo todo) async {
    isLoading = true;
    final userId = ref.read(userIdProvider) ?? '';
    final List<Todo> existingTodos = await _getTodoList(userId);
    // Find and update the todo with the provided ID, or add a new todo if not found
    try {
      if (existingTodos.isEmpty) {
        await _createTodoList(userId, [Todo(id: todo.id, text: todo.text)]);
      } else {
        // Check if the todo with the provided ID already exists
        final existingTodoIndex = existingTodos
            .indexWhere((existingTodo) => existingTodo.id == todo.id);

        if (existingTodoIndex != -1) {
          // Update existing todo
          existingTodos[existingTodoIndex] = todo;
        } else {
          // Add new todo
          existingTodos.add(todo);
        }

        await _createTodoList(userId, existingTodos);
      }
    } catch (err) {
      throw Exception();
    } finally {
      isLoading = false;
    }
  }

  Future<void> _createTodoList(String userId, List<Todo> todos) async {
    final serializedTodos = todos.map((todo) => todo.toMap()).toList();
    await _storage.write(
        key: 'todo_list_$userId', value: jsonEncode(serializedTodos));
  }

  Future<void> deleteTodoById(String todoId) async {
    try {
      isLoading = true;
      final userId = ref.read(userIdProvider) ?? '';
      // Retrieve the current list of todos
      final String? serializedTodoList =
          await _storage.read(key: 'todo_list_$userId');
      if (serializedTodoList != null) {
        final List<dynamic> decodedList = jsonDecode(serializedTodoList);

        // Remove the todo with the specified ID
        final updatedList = decodedList
            .where((todoMap) => Todo.fromMap(todoMap).id != todoId)
            .toList();

        // Save the updated list
        await _storage.write(
            key: 'todo_list_$userId', value: jsonEncode(updatedList));
      }
    } catch (err) {
      throw Exception();
    } finally {
      isLoading = false;
    }
  }

  Future<List<Todo>> _getTodoList(String userId) async {
    final String? serializedTodoList =
        await _storage.read(key: 'todo_list_$userId');

    if (serializedTodoList != null) {
      final List<dynamic> decodedList = jsonDecode(serializedTodoList);
      return decodedList.map((todoMap) => Todo.fromMap(todoMap)).toList();
    }

    return [];
  }
}

final localStorageProvider =
    StateNotifierProvider<LocalStorageService, IsLoading>((ref) {
  return LocalStorageService(ref);
});
