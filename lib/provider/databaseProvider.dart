import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/model/note_model.dart';

class HiveDB extends ChangeNotifier {
  var box = Hive.box('Notes');

  storeUser(NoteModel noteModel) {
    box.put('noteModel', noteModel.toJson());
  }

  NoteModel loadNote() {
    var noteModel = NoteModel.fromJson(box.get('noteModel'));
    return noteModel;
  }

  deleteNote() {
    box.delete('noteModel');
  }
}
