import 'package:bloc/bloc.dart';
import 'package:todoapp/repository/auth/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthRepo authrepo;
  AuthBloc(this.authrepo) : super(AuthInitial()) {
    on<AuthLoggedIn>(_signIn);
    on<AuthLoggedOut>(_signOut);
    on<AuthSignUp>(_signUp);
  }

  void _signIn(AuthLoggedIn event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    try {
      await authrepo.signIn(event.user);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _signOut(AuthLoggedOut event, Emitter<AuthBlocState> emit) async {
    try {
      await authrepo.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _signUp(AuthSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());

    try {
      await authrepo.signUp(event.user);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
