import 'package:flutter/material.dart';
import 'package:poc_mvvm_riverpod_architecture/view/create_todo/create_todo.dart';

class EmptyTodosWidget extends StatelessWidget {
  const EmptyTodosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTodoView(),
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.4,
            ),
            child: const Text(
              "Create a todo",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ));
  }
}
