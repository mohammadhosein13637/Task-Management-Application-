// login_response.dart
import 'package:taskmanagement/domains/user_repository/models/user.dart';

class LoginResponse {
  final String msg;
  final String token;
  final User user;

  LoginResponse({
    required this.msg,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      msg: json['msg'],
      token: json['token'],
      user: User.fromJson(json),
    );
  }
}
