part of 'auth_bloc.dart';

class AuthBlocState {}

final class AuthInitial extends AuthBlocState {}

final class AuthSignedIn extends AuthBlocState {
  final String userToken;
  AuthSignedIn({required this.userToken});
}

final class AuthSignedOut extends AuthBlocState {}

final class AuthFailure extends AuthBlocState {
  final String error;
  AuthFailure(this.error);
}
