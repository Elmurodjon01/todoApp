import 'package:flutter/material.dart';

import '../model/note_model.dart';

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
  List<NoteModel> todos = [];

  void addTasks(NoteModel todo) {
    todos.add(todo);
    notifyListeners();
  }

  // void updateTasks(Task task) {
  //   task.doneChange();
  //   notifyListeners();
  // }

  void deletTask(NoteModel todo) {
    todos.remove(todo);
    notifyListeners();
  }
}

// class NoteModel {
//   // DateTime createdTime;
//   String title;
//   String mainText;
//   // String? id;
//   // bool? isDone = false;
//   NoteModel({
//     required this.title,
//     required this.mainText,
//     // this.id,
//     // this.isDone = false,
//   });
// }
