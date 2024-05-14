part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignedIn extends AuthState {}

final class AuthSignedOut extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
