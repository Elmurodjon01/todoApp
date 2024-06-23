import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/res/constants/apis.dart';

class TodoProvider {
  String _filterFetchUrl(String userId) =>
      "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?created_by=eq.$userId";
  String _filterDateFetchUrl(
          {required String userId, required String created_at}) =>
      "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?created_by=eq.$userId&do_day=eq.$created_at";
  // final _readTodoUrl =
  //     "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?created_by=eq.${Supabase.instance.client.auth.currentUser!.id}";
  final _insertUrl = "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos";

  String _updateUrl(int id) =>
      'https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?id=eq.$id';
  final userToken = Supabase.instance.client.auth.currentSession!.accessToken;

  Future<List<TodoModel>> fetchTodos() async {
    String userId = Supabase.instance.client.auth.currentUser!.id;
    try {
      final res = await http.get(Uri.parse(_filterFetchUrl(userId)), headers: {
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
      throw "todo remote catched an error: ${e.toString()}";
    }
  }

  Future<List<TodoModel>> fetchByDate(String created_at) async {
    String userId = Supabase.instance.client.auth.currentUser!.id;
    try {
      final res = await http.get(
          Uri.parse(
            _filterDateFetchUrl(
              userId: userId,
              created_at: created_at,
            ),
          ),
          headers: {
            "apiKey": anonKey,
            "Authorization": "Bearer $userToken",
          });
      print('comparing date from supabase ${res.body}');
      if (res.statusCode != 200) {
        throw "status code is not 200";
      }

      final data = jsonDecode(res.body) as List;

      final values = data.map((e) => TodoModel.fromJson(e)).toList();
      return values;
    } catch (e) {
      throw "todo remote catched an error: ${e.toString()}";
    }
  }

  Future<void> insertTodo(TodoModel todo) async {
    try {
      await http.post(
        Uri.parse(_insertUrl),
        headers: {
          "apikey": anonKey,
          "Authorization": "Bearer $userToken",
          "Prefer": "return=minimal",
        },
        body: {
          "title": todo.title,
          "description": todo.description,
          "start_time": todo.start_time,
          "end_time": todo.end_time,
          "is_completed": "false",
          "category": todo.category.toLowerCase(),
          "priority": todo.priority.toLowerCase(),
          "created_by": todo.created_by,
          "do_day": todo.do_day,
          "created_at": todo.created_at,
        },
      );
    } catch (e) {
      throw "Error: $e";
    }
  }

  Future<void> todoRemove(TodoModel todo) async {
    final removeTodoUrl =
        "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/todos?id=eq.${todo.id}";
    try {
      final res = await http.delete(Uri.parse(removeTodoUrl), headers: {
        "apikey": anonKey,
        "Authorization": "Bearer $userToken",
      });
      print('delete method output ${res.body}');
    } catch (e) {
      throw "Error: $e";
    }
  }

  Future<void> markCompleted(TodoModel todo) async {
    try {
      await http.patch(
        Uri.parse(_updateUrl(todo.id)),
        headers: {
          "apikey": anonKey,
          "Authorization": "Bearer $userToken",
          "Content-Type": "application/json",
          "Prefer": "return=minimal",
        },
        body: jsonEncode({"is_completed": todo.is_completed}),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    try {
      final res = await Supabase.instance.client.from('todos').update({
        "id": todo.id,
        "title": todo.title,
        "description": todo.description,
        "start_time": "12:00",
        "end_time": "12:00",
        "is_completed": false, // assuming it's a boolean
        "category": todo.category.toLowerCase(),
        "priority": todo.priority.toLowerCase(),
        "created_by": todo.created_by,
        "do_day": todo.do_day,
        "created_at": DateTime.now().toIso8601String(),
      }).eq('id', todo.id);

      if (res.statusCode == 200 || res.statusCode == 204) {
        print('fff Update successful');
      } else {
        print('fff Failed to update: ${res.statusCode}');
        print('fff Response: ${res.body}');
      }
    } catch (e) {
      print('fff update method error ${e}');
      throw e.toString();
    }
  }
}
