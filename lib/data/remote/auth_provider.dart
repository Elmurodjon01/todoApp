import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/data/model/user/user_model.dart';
class AuthProvider {
  final _signUpUrl = 'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/signup';
  final _signInUrl =
      'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/token?grant_type=password';
  final _signOutUrl = 'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/logout';

  Future<String> signUp(UserModel user) async {
    try {
      final res = await Supabase.instance.client.auth.signUp(
          password: user.password,
          email: user.email,
          data: {"username": user.username});
      if (res.user?.id.isEmpty == true) {
        throw 'something went wrong in data remote';
      }
      return res.user!.id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> signIn(UserModel user) async {
    try {
      final res = await Supabase.instance.client.auth
          .signInWithPassword(password: user.password, email: user.email);
      if (res.user?.id.isEmpty == true) {
        throw "user id is null";
      }
      return res.user!.id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
