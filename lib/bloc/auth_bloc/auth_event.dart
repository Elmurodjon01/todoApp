import 'package:equatable/equatable.dart';
import 'package:todoapp/model/user/user_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSignUp extends AuthEvent {
  final UserModel user;
  AuthSignUp(this.user);
}

class AuthLoggedIn extends AuthEvent {
  final UserModel user;
  AuthLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthEvent {}
