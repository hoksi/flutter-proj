import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_flutter_todo/models/todo.dart';
import 'package:hello_flutter_todo/models/todo_list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => TodoListModel(),
        child: const TodoListScreen(),
      ),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple To-Do List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      labelText: '새로운 할 일 추가',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Provider.of<TodoListModel>(context, listen: false)
                            .addTodo(Todo(title: value));
                        _todoController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_todoController.text.isNotEmpty) {
                      Provider.of<TodoListModel>(context, listen: false)
                          .addTodo(Todo(title: _todoController.text));
                      _todoController.clear();
                    }
                  },
                  child: const Text('추가'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoListModel>(
              builder: (context, todoList, child) {
                return ListView.builder(
                  itemCount: todoList.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoList.todos[index];
                    return Dismissible(
                      key: Key(todo.title + index.toString()), // 고유한 Key
                      background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        todoList.removeTodo(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${todo.title} 삭제됨')),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todo.isCompleted ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (bool? value) {
                              todoList.toggleTodoStatus(index);
                            },
                          ),
                          onTap: () {
                            todoList.toggleTodoStatus(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}