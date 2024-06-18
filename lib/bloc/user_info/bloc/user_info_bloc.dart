import 'package:bloc/bloc.dart';
import 'package:todoapp/data/model/user/userInfoModel.dart';
import 'package:todoapp/repository/user_info/userinfo_repo.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepo _userInfoRepo;
  UserInfoBloc(this._userInfoRepo) : super(UserInfoInitial()) {
    on<LoadUserInfo>(_loadUserInfo);
  }
  void _loadUserInfo(LoadUserInfo event, Emitter<UserInfoState> emit) async {
    try {
      final res = await _userInfoRepo.fetchUserInfo();

      emit(UserInfoLoadedState(res));
    } catch (e) {
      emit(UserInfoLoadError(e.toString()));
    }
  }
}
