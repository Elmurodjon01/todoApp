

import '../../data/model/user/user_model.dart';
import '../../data/remote/auth_provider.dart';

class AuthRepo {
  AuthProvider authProvider;
  AuthRepo(this.authProvider);

  Future<void> signUp(UserModel user) async {
    await authProvider.signUp(user);
  }

  Future<void> signIn(UserModel user) async {
    await authProvider.signIn(user);
  }

  Future<void> signOut() async {
    await authProvider.signOut();
  }
}
