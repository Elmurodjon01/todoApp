import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/data/model/todo_model/todo_model.dart';
import 'package:todoapp/repository/todo_crud/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<TodoLoad>(_todoLoad);
    on<TodoInsert>(_insertTodo);
    on<TodoRemove>(_removeTodo);
    on<TodoMarkCompleted>(_markCompleted);
    on<TodoUpdate>(_updateTodo);
  }

  void _todoLoad(TodoLoad event, Emitter<TodoState> emit) async {
    print('comparing user id ${Supabase.instance.client.auth.currentUser!.id}');
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
    try {
      await todoRepository.insertTodo(event.todo);
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos = List<TodoModel>.from(currentState.todos)
          ..add(event.todo);
        emit(TodoLoaded(updatedTodos));
      } else if (state is TodoEmpty) {
        emit(TodoLoaded([event.todo]));
      }
    } catch (e) {
      emit(TodoFailure('todo bloc error => $e'));
    }
  }

  void _removeTodo(TodoRemove event, Emitter<TodoState> emit) async {
    // emit(TodoLoading());
    try {
      await todoRepository.remoteTodo(event.todo);
      // final res = await todoRepository.fetchTodos();
      // if (res.isEmpty) {
      //   emit(TodoEmpty());
      // } else {
      event.todos.remove(event.todo);
      emit(TodoLoaded(event.todos));
      // }
    } catch (e) {
      emit(TodoFailure('todo bloc error removing todo => $e'));
    }
  }

  void _markCompleted(TodoMarkCompleted event, Emitter<TodoState> emit) async {
    // emit(TodoLoading());
    try {
      await todoRepository.markCompleted(event.todo);
      final res = await todoRepository.fetchTodos();
      if (res.isEmpty) {
        emit(TodoEmpty());
      } else {
        emit(TodoLoaded(res));
      }
    } catch (e) {
      emit(TodoFailure('todo bloc error updating todo => $e'));
    }
  }

  void _updateTodo(TodoUpdate event, Emitter<TodoState> emit) async {
    try {
      await todoRepository.updateTodo(event.todo);
      final res = await todoRepository.fetchTodos();

      emit(TodoLoaded(res));
    } catch (e) {
      emit(TodoFailure('todo bloc error updating todo => $e'));
    }
  }
}
