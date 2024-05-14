part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignInEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}
