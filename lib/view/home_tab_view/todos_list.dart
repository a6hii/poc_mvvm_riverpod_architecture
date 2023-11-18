import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/model/todo/todo.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/dialogs/delete_dialog.dart';
import 'package:poc_mvvm_riverpod_architecture/view/create_todo/create_todo.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/local_storage_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/todo_view_model.dart';

class TodosList extends ConsumerWidget {
  final List<Todo> todos;
  const TodosList({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          todos[index].text,
          maxLines: 2,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        trailing: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateTodoView(
                      todo: todos[index],
                    ),
                  ));
                  if (context.mounted) {
                    ref.invalidate(getTodoFutureProvider);
                  }
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () async {
                  final shouldDelete =
                      await const DeleteDialog().present(context).then(
                            (value) => value ?? false,
                          );
                  if (shouldDelete) {
                    await ref
                        .read(localStorageProvider.notifier)
                        .deleteTodoById(todos[index].id ?? '');
                    if (context.mounted) {
                      ref.invalidate(getTodoFutureProvider);
                    }
                  }
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
