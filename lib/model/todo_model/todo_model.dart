import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String created_at,
    required String title,
    required String description,
    required String start_time,
    required String end_time,
    required bool is_completed,
    required String category,
    required String priority,
    required String created_by,
    required String do_day,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, Object?> json) =>
      _$TodoModelFromJson(json);
}
