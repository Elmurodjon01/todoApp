part of 'todo_bloc.dart';

@sealed
class TodoEvent {}

final class TodoLoad extends TodoEvent {}

final class TodoInsert extends TodoEvent {
  final TodoModel todo;

  TodoInsert(this.todo);
}

final class TodoRemove extends TodoEvent {
  final List<TodoModel> todos;
  final TodoModel todo;

  TodoRemove(this.todos, this.todo);
}

final class TodoMarkCompleted extends TodoEvent {
  final TodoModel todo;

  TodoMarkCompleted(this.todo);
}

final class TodoUpdate extends TodoEvent {
  final TodoModel todo;

  TodoUpdate(this.todo);
}
