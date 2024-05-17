import 'package:todoapp/data/provider/auth_provider.dart';
import 'package:todoapp/model/user/user_model.dart';

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
