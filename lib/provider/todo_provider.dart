import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  var todos = [
    Todo(id: 1, title: "first todo"),
  ];

  void addTodo({required var title}) {
    todos.add(Todo(id: todos.length, title: title));
    notifyListeners();
    //  from change notifier
  }

  void CheckBox({required int id}) {
    var todo = todos.firstWhere((element) => element.id == id);
    todo.done = !todo.done;
    notifyListeners();
  }
}
