import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  // List<ToDo> _todos = [];
  // List<ToDo> get todos => _todos;

  // void addTodo(ToDo todo) {
  //   _todos.add(todo);
  //   notifyListeners();
  // }

  // void toggleTodo(ToDo todo) {
  //   final taskIndex = _todos.indexOf(todo);
  //   // _todos[taskIndex].toggleCompleted();
  //   notifyListeners();
  // }

  // void deleteTodo(ToDo todo) {
  //   _todos.remove(todo);
  //   notifyListeners();
  // }
  List<ToDo> todos = [
    ToDo(title: "go shopping"),
    ToDo(title: "buy a gift"),
    ToDo(title: "repair the car"),
  ];

  void addTasks(ToDo todo) {
    todos.add(todo);
    notifyListeners();
  }

  // void updateTasks(Task task) {
  //   task.doneChange();
  //   notifyListeners();
  // }

  void deletTask(ToDo todo) {
    todos.remove(todo);
    notifyListeners();
  }
}

class ToDo {
  // DateTime createdTime;
  String title;
  // String? mainText;
  // String? id;
  // bool? isDone = false;
  ToDo({
    required this.title,
    // this.mainText,
    // this.id,
    // this.isDone = false,
  });
}
