class NoteModel {
  String label;
  String mainText;
  // String id;
  // DateTime time;
  NoteModel({
    required this.label,
    required this.mainText,
    // required this.id,
    // required this.time,
  });
  NoteModel.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        mainText = json['mainText'];
  // time = json['time'];
  // id = json['id'];

  Map<String, dynamic> toJson() => {
        'label': label,
        'mainText': mainText,
        // 'id': id,
        // 'time': time,
      };
}
