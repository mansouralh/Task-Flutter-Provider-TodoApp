1. Create a new project called: `todo_app`.
2. Create the structure of your folders: `models`, `widgets`, `pages` and `providers`.
3. Let's start by defining our model, in your `models` folder create a `todo.dart` and create a model with the following properties:

```dart
class Todo {
  int id;
  String title;
  bool done = false;
}
```

4. Generate a constructor for your `Todo` model.

```dart
class Todo {
  int id;
  String title;
  bool done = false;
  Todo({required this.id, required this.title});
}
```

5. Next, let's create our pages as empty pages for now, in your `pages` folder, create a `home_page.dart` with a `Scaffold` and an `AppBar`.

```dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Colors.amber.shade300,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
```

6. Do the same for the `add_page.dart`.

```dart
class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);
  final todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        backgroundColor: Colors.amber.shade300,
      ),
    );
  }
}
```

7. Install the `go_router` package and initialize your routes in `main.dart`.

```shell
flutter pub add go_router
```

```dart
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => AddPage(),
      ),
    ],
  );
}
```

8. Let's create our provider with the needed logic in it, install the `provider` package.

```shell
flutter pub add provider
```

9. In your `provider` folder, create a file named `todo_provider.dart`.
10. In your `todo_provider.dart` import the material package and your `Todo` model.

```dart
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
```

11. Create your provider that extends `ChangeNotifier`.

```dart
class TodoProvider extends ChangeNotifier {}
```

12. Create you `todos` list and initialize it with one `Todo` object to help us with testing our code.

```dart
  var todos = [
    Todo(id: 1, title: "first todo"),
  ];
```

13. It's time to use our provider, in your `main.dart` import the `provider` package.

```dart
import 'package:provider/provider.dart';
```

14. In your `runApp` function, replace the content with `ChangeNotifierProvider` widget with a create property that takes the `context` as an argument and returns our `TodoProvider`, and a `child` that takes our `MyApp()`.

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MyApp(),
    ),
  );
}
```

15. In your `widgets` folder, create a `todo_tile.dart` file.
16. Inside this file, create a `Card` widget with a child that is a `ListTile` widget that displays the title of our `todo` and a `Checkbox` widget.

```dart
class TodoTile extends StatelessWidget {
  const TodoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: ListTile(
          title: Text(todo.title),
          trailing: Checkbox(
              fillColor: MaterialStateProperty.all<Color>(Colors.white),
              checkColor: Colors.amber.shade300,
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(width: 1.0, color: Colors.amber.shade300),
              ),
              value: todo.done,
              onChanged: (value) => {},
            ),
        ),
      ),
    );
  }
}
```

17. `TodoTile` widget should expect a `Todo` object to be passed, generate a constructor for that.

```dart
class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({Key? key, required this.todo}) : super(key: key);
[...]
```

18. In your `home_page.dart` `Scaffold` `body`, add a `SingleChildScrollView` widget.

```dart
      body: SingleChildScrollView(),
```

19. Import the `provider` package and our `TodoProvider` in `home_page.dart`.

```dart
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
```

20. In your `SingleChildScrollView`. as child, add a `Consumer` widget that consumes our `TodoProvider`.

```dart
SingleChildScrollView(
        child: Consumer<TodoProvider>()
)
```

21. This consumer widget, will take a builder property that takes three arguments, `context`, ourProvider, and a `child` and returns a widget.

```dart
SingleChildScrollView(
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) =>
        )
```

22. That widget should be a `ListView.builder` widget that returns a `TodoTile` and passing the `todo` object from our provider using the `index`.

```dart
SingleChildScrollView(
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // <- Here
            itemCount: todoProvider.todos.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoTile(
                todo: todoProvider.todos[index],
              );
            },
          ),
        ),
      ),
```

23. Save your code, and test your app, you should see the `todo` we added in the provider.
24. Now in the same page, in your `AppBar` widget, add the `actions` property that takes a list of widgets.

```dart
appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Colors.amber.shade300,
        actions: [],
      ),
```

25. Inside this list, add an `IconButton` widget that takes you to the `add_page` `/add` using the `go_router` `push` method.

```dart
appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Colors.amber.shade300,
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
```

26. Setup your `add_page.dart` to have a `Scaffold`, an `AppBar`, `body`, `Column` with a `TextField` and a `ElevatedButton`.

```dart
class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);
  final todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        backgroundColor: Colors.amber.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextField(
                controller: todoController,
                decoration: InputDecoration(
                  hintText: 'Your todo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

27. Back to our `todo_provider.dart`, let's create a method `addTodo` for adding a `todo`, this method will take a `String` `title` argument, and will generate an `id` for our `todo`, then we will insert this new to do to our `todos` list.

```dart
  void addTodo({required String title}) {
    var todo = Todo(
      id: todos.isNotEmpty ? todos[todos.length - 1].id + 1 : 1,
      title: title,
    );

    todos.insert(0, todo);

  }
```

28. Don't forget to call `notifyListeners()`.

```dart
  void addTodo({required String title}) {
    var todo = Todo(
      id: todos.isNotEmpty ? todos[todos.length - 1].id + 1 : 1,
      title: title,
    );

    todos.insert(0, todo);

    notifyListeners();
  }
```

29. Back to our `add_page.dart` button `onPressed` method, call our provider `addTodo` method, and pass it the the value of our `TextField` controller.

```dart
onPressed: () {
    Provider.of<TodoProvider>(context).addTodo(title: todoController.text);
},
```

30. Don't forget to set `listen` to `false` since we are not rebuilding this widget.

```dart
onPressed: () {
    Provider.of<TodoProvider>(context, listen: false).addTodo(title: todoController.text);
},
```

31. Now we need to go back to our `home_page`, so use the `pop` method. Check you app to make sure todos are being added.

```dart
onPressed: () {
    Provider.of<TodoProvider>(context, listen: false).addTodo(title: todoController.text);
    GoRouter.of(context).pop();
},
```

32. The last thing to do is to change the `done` status of our todo using the `Checkbox` widget.
33. First, we need to create a method for that in our `todo_provider.dart`, this method takes an `id` as an argument, and looks for the `todo` with the same `id` within our `todos` list, and switch it's `done` property value to `true` or `false`.

```dart
  void toggleDone(int id) {
    Todo todoToUpdate = todos[todos.indexWhere((todo) => todo.id == id)];
    todoToUpdate.done = !todoToUpdate.done;
  }
```

34. Don't forget to call `notifyListeners()`.

```dart
  void toggleDone(int id) {
    Todo todoToUpdate = todos[todos.indexWhere((todo) => todo.id == id)];
    todoToUpdate.done = !todoToUpdate.done;
    notifyListeners();
  }
```

35. Then, we will wrap our `Checkbox` widget with a `Consumer` widget, and within our `onChange` property, we'll call our provider and the method we just created and pass the `id` to it.

```dart
          trailing: Consumer<TodoProvider>(
            builder: (context, todoProvider, child) => Checkbox(
              fillColor: MaterialStateProperty.all<Color>(Colors.white),
              checkColor: Colors.amber.shade300,
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(width: 1.0, color: Colors.amber.shade300),
              ),
              value: todo.done,
              onChanged: (value) => todoProvider.toggleDone(todo.id),
            ),
          ),
```
