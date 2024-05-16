import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  AuthLoggedIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthLoggedOut extends AuthEvent {}
