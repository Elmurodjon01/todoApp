import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/constants/apis.dart';
import 'package:todoapp/model/user/user_model.dart';

class AuthProvider {
  final _signUpUrl = 'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/signup';
  final _signInUrl =
      'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/token?grant_type=password';
  final _signOutUrl = 'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/logout';

  Future<String> signUp(UserModel user) async {
    try {
      // final res = await Dio().post(_signUpUrl, queryParameters: {
      //   "apikey": anonKey,
      //   "Content-Type": "application/json"
      // }, data: {
      //   "email": user.email,
      //   "password": user.password,
      //   "username": user.username
      // });
      // if (res.statusCode != 200) {
      //   throw "wrong status code from auth provider";
      // }
      final res = await Supabase.instance.client.auth.signUp(
          password: user.password,
          email: user.email,
          data: {"username": user.username});
      if (res.user?.id.isEmpty == true) {
        throw 'something went wrong in data provider';
      }
      return res.user!.id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> signIn(UserModel user) async {
    try {
      // final res = await Dio().post(_signInUrl, queryParameters: {
      //   "apikey": anonKey,
      //   "Content-Type": "application/json"
      // }, data: {
      //   "email": user.email,
      //   "password": user.password,
      // });
      // if (res.data["access_token"] == null) {
      //   throw "Something went wrong in auth_provider signin method";
      // }
      // return res.data["access_token"];
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
      await Dio().post(_signOutUrl, queryParameters: {
        "apikey": anonKey,
        "Content-Type": "application/json",
        "Authorization":
            "Bearer ${Supabase.instance.client.auth.currentSession!.accessToken}",
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
