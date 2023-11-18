import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/common_error_widget.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/dialogs/logout_dialog.dart';
import 'package:poc_mvvm_riverpod_architecture/view/create_todo/create_todo.dart';
import 'package:poc_mvvm_riverpod_architecture/view/home_tab_view/empty_todos_widget.dart';
import 'package:poc_mvvm_riverpod_architecture/view/home_tab_view/todos_list.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/todo_view_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/user_info/user_id_provider.dart';

class HomeTabView extends ConsumerWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      final todoViewModel =
          ref.watch(getTodoFutureProvider(ref.watch(userIdProvider) ?? ''));
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final shouldLogOut =
                    await const LogoutDialog().present(context).then(
                          (value) => value ?? false,
                        );
                if (shouldLogOut) {
                  ref.invalidate(getTodoProvider);
                  ref.invalidate(getTodoFutureProvider);
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: todoViewModel.when(
            data: (data) {
              return Column(
                children: [
                  if (data.todos != null && data.todos!.isNotEmpty)
                    TodosList(
                      todos: data.todos ?? [],
                    ),
                  if (data.todos == null || data.todos!.isEmpty)
                    const EmptyTodosWidget(),
                ],
              );
            },
            error: (error, st) {
              return CommonErrorWidget(
                onPressed: () {
                  ref.invalidate(getTodoFutureProvider);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator())),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTodoView()),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
