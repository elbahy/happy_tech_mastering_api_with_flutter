import 'package:happy_tech_mastering_api_with_flutter/core/databases/cache/cache_helper.dart';

abstract class Endpoints {
  static const String baseUrl = 'https://food-api-omega.vercel.app/api/v1/';
  static const String login = 'user/signin';
  static const String register = 'user/signup';
  static const String checkEmail = 'user/check-email';

  static const String logout = 'user/logout';
  static const String updateUser = 'user/update';
  static const String deleteUser = 'user/delete';

  static String getuserData() {
    return 'user/get-user/${CacheHelper().getData(key: ApiKey.id)}';
  }
}

abstract class ApiKey {
  static const String email = 'email';
  static const String password = 'password';
  static const String confirmPassword = 'confirmPassword';
  static const String errorMessage = 'ErrorMessage';
  static const String status = 'status';
  static const String message = 'message';
  static const String token = 'token';
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String pic = 'profilePic';
  static const String location = 'location';
}
