import 'package:todoapp/data/provider/auth_provider.dart';
import 'package:todoapp/model/user/user_model.dart';

class AuthRepo {
  AuthProvider authProvider;
  AuthRepo(this.authProvider);

  Future<String> signUp(UserModel user) async {
    try {
      final res = await authProvider.signUp(user);
      if (res['access_token'] == null) {
        throw "error in signUp repo, access_token is null";
      }
      return res["access_token"];
    } catch (e) {
      throw "signup repo catched an error: ${e.toString()}";
    }
  }
}
