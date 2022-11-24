import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/model/note_model.dart';

class HiveDB extends ChangeNotifier {
  ValueNotifier<List<NoteModel>> tasklistNotifier = ValueNotifier([]);
  // var box = Hive.box('Notes');

  // storeUser(NoteModel noteModel) {
  //   box.put('noteModel', noteModel.toJson());
  // }

  // NoteModel loadNote() {
  //   var noteModel = NoteModel.fromJson(box.get('noteModel'));
  //   return noteModel;
  // }

  // deleteNote() {
  //   box.delete('noteModel');
  // }
  void addTask(NoteModel value) async {
    final taskDb = await Hive.openBox<NoteModel>('Notes');
    final _id = await taskDb.add(value);

    await taskDb.put('Notes', value);
    tasklistNotifier.value.add(value);
    tasklistNotifier.notifyListeners();
  }

  getallTasks() async {
    final taskDb = await Hive.openBox<NoteModel>('Notes');
    tasklistNotifier.value.clear();
    tasklistNotifier.value.addAll(taskDb.values);
    tasklistNotifier.notifyListeners();
  }

  deleteTask(int id) async {
    final taskDb = await Hive.openBox<NoteModel>('Notes');
    await taskDb.delete(id);
    getallTasks();
  }
}
