import 'package:todoapp/data/provider/todo_provider.dart';
import 'package:todoapp/model/todo_model/todo_model.dart';

class TodoRepository {
  final TodoProvider todoProvider;
  TodoRepository(this.todoProvider);

  Future<List<TodoModel>> fetchTodos() async {
    final res = await todoProvider.fetchTodos();
    print('todo function response : $res');
    return res;
  }

  Future<void> insertTodo(TodoModel todo) async {
    await todoProvider.insertTodo(todo);
  }

  Future<void> remoteTodo(TodoModel todo) async {
    await todoProvider.todoRemove(todo);
  }

  Future<void> markCompleted(TodoModel todo) async {
    await todoProvider.markCompleted(todo);
  }
}
