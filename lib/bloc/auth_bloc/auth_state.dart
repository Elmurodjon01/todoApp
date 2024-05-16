import 'package:equatable/equatable.dart';

 abstract class AuthBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthAuthenticated extends AuthBlocState {}

class AuthUnauthenticated extends AuthBlocState {}

class AuthError extends AuthBlocState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
