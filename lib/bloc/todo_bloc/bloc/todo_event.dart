part of 'todo_bloc.dart';

@sealed
class TodoEvent {}

final class TodoLoad extends TodoEvent {}

final class TodoInsert extends TodoEvent {
  final TodoModel todo;
  TodoInsert(this.todo);
}

final class TodoRemove extends TodoEvent {
  final TodoModel todo;
  TodoRemove(this.todo);
}

final class TodoMarkCompleted extends TodoEvent {
  final TodoModel todo;
  TodoMarkCompleted(this.todo);
}
