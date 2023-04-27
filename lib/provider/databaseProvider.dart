import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/model/note_model.dart';

class HiveDB extends ChangeNotifier {
  List<NoteModel> _notes = [];
  List get notes => _notes;

  void writeData(String title, String desc) {
    var box = Hive.box('Notes');
    var data = box.put('todos', NoteModel(title: title, mainText: desc));
    // savedTodos.add(data);
    notifyListeners();
  }

  void savedData() {
    Box box = Hive.box('Notes');
    NoteModel todos = box.get('todos');

    notes.add(todos);
    notifyListeners();
  }

  deleteTask(int id) async {
    // final taskDb = await Hive.openBox<NoteModel>('Notes');
    // await myBox.delete(id);
  }
}
