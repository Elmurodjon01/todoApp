part of 'user_info_bloc.dart';

class UserInfoState {}

class UserInfoLoadedState extends UserInfoState {
  UserInfo userInfo;
  UserInfoLoadedState(this.userInfo);
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoadError extends UserInfoState {
  final String error;
  UserInfoLoadError(this.error);
}
