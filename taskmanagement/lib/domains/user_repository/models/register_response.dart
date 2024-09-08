// register_response.dart
class RegisterResponse {
  final String msg;

  RegisterResponse({
    required this.msg,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      msg: json['msg'],
    );
  }
}
