import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:poc_mvvm_riverpod_architecture/model/todo/todo.dart';

class TodoListModel extends Equatable {
  final List<Todo>? todos;
  const TodoListModel({
    this.todos,
  });

  TodoListModel copyWith({
    List<Todo>? todos,
  }) {
    return TodoListModel(
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todos': todos?.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoListModel.fromMap(Map<String, dynamic> map) {
    return TodoListModel(
      todos: map['todos'] != null
          ? List<Todo>.from(
              (map['todos'] as List<int>).map<Todo?>(
                (x) => Todo.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoListModel.fromJson(String source) =>
      TodoListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [todos];
}
