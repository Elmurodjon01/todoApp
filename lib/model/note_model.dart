import 'package:hive/hive.dart';

part "note_model.g.dart";

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String mainText;
  // String id;
  // DateTime time;
  NoteModel({
    required this.title,
    required this.mainText,
    // required this.id,
    // required this.time,
  });
}
