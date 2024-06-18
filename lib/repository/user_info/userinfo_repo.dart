import 'package:todoapp/data/model/user/userInfoModel.dart';
import 'package:todoapp/data/remote/userinfo_provider.dart';

class UserInfoRepo {
  UserInfoProvider _userInfoProvider;
  UserInfoRepo(this._userInfoProvider);

  Future<UserInfo> fetchUserInfo() async {
    final userInfo = await _userInfoProvider.loadUserInfo();
  

    return userInfo;
  }
}
