class NoteModel {
  String title;
  String mainText;
  // String id;
  // DateTime time;
  NoteModel({
    required this.title,
    required this.mainText,
    // required this.id,
    // required this.time,
  });
  NoteModel.fromJson(Map<String, dynamic> json)
      : title = json['label'],
        mainText = json['mainText'];
  // time = json['time'];
  // id = json['id'];

  Map<String, dynamic> toJson() => {
        'label': title,
        'mainText': mainText,
        // 'id': id,
        // 'time': time,
      };
}
