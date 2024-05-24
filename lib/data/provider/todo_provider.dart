import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/constants/apis.dart';
import 'package:todoapp/model/todo_model/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoProvider {
  final _readTodoUrl =
      "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?select=*";
  final _insertUrl = "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos";
  final userToken = Supabase.instance.client.auth.currentSession!.accessToken;
  Future<List<TodoModel>> fetchTodos() async {
    try {
      print('request made');
      final res = await http.get(Uri.parse(_readTodoUrl), headers: {
        "apiKey": anonKey,
        "Authorization": "Bearer $userToken",
      });
      if (res.statusCode != 200) {
        throw "status code is not 200";
      }

      final data = jsonDecode(res.body) as List;
      final values = data.map((e) => TodoModel.fromJson(e)).toList();
      return values;
    } catch (e) {
      throw "todo provider catched an error: ${e.toString()}";
    }
  }

  Future<void> insertTodo(TodoModel todo) async {
    try {
      print('started');
      await http.post(
        Uri.parse(_insertUrl),
        headers: {
          "apikey": anonKey,
          "Authorization": "Bearer $userToken",
          "Content-Type": "Content-Type",
          "Prefer": "return=minimal",
        },
        body: {
          "title": todo.title,
          "description": todo.description,
          "start_time": todo.start_time,
          "end_time": todo.end_time,
          "is_completed": todo.is_completed,
          "category": todo.category,
          "priority": todo.priority,
          "created_by": todo.created_by,
          "do_day": todo.do_day,
        },
      );
      print('ended');
    } catch (e) {
      throw "Something went wrong in todo_provider => $e";
    }
  }
}
