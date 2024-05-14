part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignInEvent extends AuthEvent {
  final UserModel user;
  SignInEvent(this.user);
}

final class SignOutEvent extends AuthEvent {}
