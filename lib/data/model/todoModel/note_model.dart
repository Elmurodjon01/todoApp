import 'package:hive/hive.dart';

part "note_model.g.dart";

@HiveType(typeId: 1)
class NoteModel {
  NoteModel({
    required this.title,
    required this.mainText,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String mainText;
}
