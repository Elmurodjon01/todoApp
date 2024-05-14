import 'package:dio/dio.dart';
import 'package:todoapp/constants/apis.dart';
import 'package:todoapp/model/user/user_model.dart';

class AuthProvider {
  final _signUpUrl = 'https://oneylvbcepaesfnolxts.supabase.co/auth/v1/signup';
  Future<dynamic> signUp(UserModel user) async {
    try {
      final res = await Dio().post(_signUpUrl, queryParameters: {
        "apikey": anonKey,
        "Content-Type": "application/json"
      }, data: {
        "email": user.email,
        "password": user.password,
        "username": user.username
      });
      if (res.statusCode != 200) {
        throw "wrong status code from auth provider";
      }

      return res.data;
    } catch (e) {
      throw "try catch in authprovider has thrown an error";
    }
  }
}
