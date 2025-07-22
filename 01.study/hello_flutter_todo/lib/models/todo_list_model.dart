import 'package:flutter/material.dart';
import 'package:hello_flutter_todo/models/todo.dart';

class TodoListModel extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos); // 외부에서 직접 수정 불가능하도록 unmodifiableList 반환

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners(); // 상태 변경 알림
  }

  void toggleTodoStatus(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      notifyListeners(); // 상태 변경 알림
    }
  }

  void removeTodo(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      notifyListeners(); // 상태 변경 알림
    }
  }
}
