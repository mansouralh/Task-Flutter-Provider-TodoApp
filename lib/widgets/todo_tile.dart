import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: ListTile(
          title: Text(todo.title),
          trailing: Checkbox(
            fillColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 57, 228, 225)),
            checkColor: Color.fromARGB(255, 56, 237, 225),
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 52, 188, 238)),
            ),
            value: todo.done,
            onChanged: (value) {
              context.read<TodoProvider>().CheckBox(id: todo.id);
            },
          ),
        ),
      ),
    );
  }
}
