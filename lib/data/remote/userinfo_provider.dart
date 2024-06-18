

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/data/model/user/userInfoModel.dart';

class UserInfoProvider {
  final _userInfoUrl =
      "https://oneylvbcepaesfnolxts.supabase.co/rest/v1/users?userid=eq.${Supabase.instance.client.auth.currentUser!.id}";
  Future<UserInfo> loadUserInfo() async {
    try {
      final res = await Supabase.instance.client
          .from('users')
          .select()
          .eq('userid', Supabase.instance.client.auth.currentUser!.id)
          .single();
      final fetchUserInfo = UserInfo.fromMap(res);
         
      return fetchUserInfo;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
