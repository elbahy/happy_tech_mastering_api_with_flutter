abstract class Endpoints {
  static const String baseUrl = 'https://food-api-omega.vercel.app/api/v1/';
  static const String login = 'user/signin';
  static const String register = 'user/signup';
  static const String checkEmail = 'user/check-email';
  static const String getUserData = 'user/get-user';
  static const String logout = 'user/logout';
  static const String updateUser = 'user/update';
  static const String deleteUser = 'user/delete';
}

abstract class ApiKey {
  static const String email = 'email';
  static const String password = 'password';
  static const String errorMessage = 'ErrorMessage';
  static const String status = 'status';
  static const String message = 'message';
  static const String token = 'token';
  static const String id = 'id';
}
