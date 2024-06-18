part of 'todo_bloc.dart';

@sealed
class TodoState {}

final class TodoLoaded extends TodoState {
  List<TodoModel> todos = [];
  TodoLoaded(this.todos);
}

final class TodoFailure extends TodoState {
  String error;
  TodoFailure(this.error);
}

final class TodoLoading extends TodoState {}

final class TodoInitial extends TodoState {}

final class TodoEmpty extends TodoState {

}
