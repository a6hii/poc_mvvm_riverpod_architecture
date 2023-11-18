import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poc_mvvm_riverpod_architecture/model/todo/todo.dart';
import 'package:poc_mvvm_riverpod_architecture/view/main/main_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/local_storage_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/todo_view_model.dart';

class CreateTodoView extends StatefulWidget {
  final Todo? todo;
  const CreateTodoView({super.key, this.todo});

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  final todoController = TextEditingController();
  @override
  void initState() {
    if (widget.todo != null) {
      todoController.text = widget.todo!.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
      ),
      body: Consumer(builder: (context, ref, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 10,
                maxLength: 1000,
                controller: todoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(MediaQuery.sizeOf(context).width, 44),
                  ),
                ),
                onPressed: () async {
                  if (todoController.text.isNotEmpty) {
                    if (widget.todo != null) {
                      await ref
                          .read(localStorageProvider.notifier)
                          .saveOrUpdateTodo(Todo(
                              id: widget.todo?.id, text: todoController.text));
                    } else {
                      await ref
                          .read(localStorageProvider.notifier)
                          .saveOrUpdateTodo(Todo(text: todoController.text));
                    }
                    Fluttertoast.showToast(
                      msg: "Todo added",
                    );
                    if (context.mounted) {
                      if (context.mounted) {
                        ref.invalidate(getTodoFutureProvider);
                      }
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) => const MainView()));
                    }
                  } else {
                    Fluttertoast.showToast(msg: "Please enter a todo");
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
