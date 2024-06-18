// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoModelImpl _$$TodoModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoModelImpl(
      created_at: json['created_at'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      is_completed: json['is_completed'] as bool,
      category: json['category'] as String,
      priority: json['priority'] as String,
      created_by: json['created_by'] as String,
      do_day: json['do_day'] as String,
      id: (json['id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TodoModelImplToJson(_$TodoModelImpl instance) =>
    <String, dynamic>{
      'created_at': instance.created_at,
      'title': instance.title,
      'description': instance.description,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'is_completed': instance.is_completed,
      'category': instance.category,
      'priority': instance.priority,
      'created_by': instance.created_by,
      'do_day': instance.do_day,
      'id': instance.id,
    };
