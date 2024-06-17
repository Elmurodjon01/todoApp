import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/repository/todo_repo.dart';
import 'package:todoapp/model/todo_model/todo_model.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<TodoLoad>(_todoLoad);
    on<TodoInsert>(_insertTodo);
    on<TodoRemove>(_removeTodo);
    on<TodoMarkCompleted>(_markCompleted);
  }
  void _todoLoad(TodoLoad event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final res = await todoRepository.fetchTodos();
      if (res.isEmpty) {
        emit(TodoEmpty());
      } else {
        emit(TodoLoaded(res));
      }
    } catch (e) {
      emit(TodoFailure('todo bloc error => $e'));
    }
  }

  void _insertTodo(TodoInsert event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await todoRepository.insertTodo(event.todo);
    } catch (e) {
      emit(TodoFailure('todo bloc error => $e'));
    }
  }

  void _removeTodo(TodoRemove event, Emitter<TodoState> emit) async {
    // emit(TodoLoading());
    try {
      await todoRepository.remoteTodo(event.todo);
      final res = await todoRepository.fetchTodos();
      if (res.isEmpty) {
        emit(TodoEmpty());
      } else {
        emit(TodoLoaded(res));
      }
    } catch (e) {
      emit(TodoFailure('todo bloc error removing todo => $e'));
    }
  }

  void _markCompleted(TodoMarkCompleted event, Emitter<TodoState> emit) async {
    try {
      await todoRepository.markCompleted(event.todo);
      final res = await todoRepository.fetchTodos();
      if (res.isEmpty) {
        emit(TodoEmpty());
      } else {
        res.sort((a, b) => a.id.compareTo(b.id));
        emit(TodoLoaded(res));
      }
    } catch (e) {
      emit(TodoFailure('todo bloc error updating todo => $e'));
    }
  }
}
