import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoggedIn>(_login);
  }

  void _login(AuthLoggedIn event, Emitter<AuthBlocState> emit) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      if (response.user!.email != null) {
        emit(AuthAuthenticated());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  Stream<AuthBlocState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      yield AuthLoading();
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    } else if (event is AuthLoggedIn) {
      yield AuthLoading();
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      if (response.user!.email != null) {
        yield AuthError(message: response.toString());
      } else {
        yield AuthAuthenticated();
      }
    } else if (event is AuthLoggedOut) {
      yield AuthLoading();
      await Supabase.instance.client.auth.signOut();
      yield AuthUnauthenticated();
    }
  }
}
