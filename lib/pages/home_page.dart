import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          backgroundColor: Color.fromARGB(255, 60, 224, 242),
          actions: [
            IconButton(
              onPressed: () => GoRouter.of(context).push('/add'),
              icon: const Icon(
                Icons.add_box_outlined,
                size: 30,
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: context.watch<TodoProvider>().todos.length,
            itemBuilder: ((context, index) => TodoTile(
                      todo: context.watch<TodoProvider>().todos[index],
                    )
                // That widget should be a ListView.builder widget that returns a TodoTile and passing the todo object from our provider using the index.

                )));
  }
}
