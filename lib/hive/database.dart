import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/model/todoModel/note_model.dart';

class Database extends ChangeNotifier {
  List notes = <NoteModel>[];
  addItem(NoteModel item) async {
    var box = await Hive.box<NoteModel>('Notes');

    box.add(item);
    getItem();
    notifyListeners();
  }

  getItem() async {
    final box = await Hive.box<NoteModel>('Notes');

    notes = box.values.toList();

    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<NoteModel>('Notes');
    box.deleteAt(index);
    getItem();
    notifyListeners();
  }

  updateItem(int index, NoteModel item) {
    final box = Hive.box<NoteModel>('Notes');
    box.putAt(index, item);
    notifyListeners();
  }
}
