import 'dart:async';

import 'package:taskmanagement/data/task_api/task_api_engine.dart';
import 'package:taskmanagement/domains/user_repository/models/accsess_token.dart';
import 'package:taskmanagement/domains/user_repository/models/login_response.dart';
import 'package:taskmanagement/domains/user_repository/models/register_response.dart';
import 'package:taskmanagement/domains/user_repository/user_box.dart';

class UserRepository {
  static Future<UserRepository> init() async {
    //

    await UserBox.open();
    return UserRepository();
  }

  final _jwtAuthCtrl = StreamController<bool>.broadcast();
  Stream<bool> get jwtAuthStream => _jwtAuthCtrl.stream;

  //! Auth Base Methods to check Token
  bool checkJwtAuth() {
    return UserBox.getToken()?.canUse() ?? false;
  }

  Future<void> logOut() async {
    UserBox.setToken(null);
    _jwtAuthCtrl.add(false);
  }

  Future<String> getAccessToken() async {
    final accessToken = UserBox.getToken();
    if (accessToken?.canUse() ?? false) {
      return accessToken!.token;
    } else {
      logOut();
      return "its not oke";
    }
  }


  //! Login and Register Methods 
  Future<LoginResponse?> login({
  required String name,
  required String password,
}) async {
  try {
    final response = await TaskApi.client.post(
      TaskApi.urls.task,
      data: {
        "name": name,
        "password": password,
      },
    );

    //* Get Response and save it to use its token
    final LoginResponse loginResponse = LoginResponse.fromJson(response);

    // Store the token
    UserBox.setToken(AccessToken.create(token: loginResponse.token),);

    // Notify listeners about authentication success
    _jwtAuthCtrl.add(true);

    // Return the login response so it can be used elsewhere
    return loginResponse;

  } catch (e) {
    print("Error during login: $e");
    return null;
  }
}

  Future<RegisterResponse?> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await TaskApi.client.post(
      TaskApi.urls.register,  // Assuming TaskApi.urls.register points to the registration URL
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    //* Parse the response to get the message
    final registerResponse = RegisterResponse.fromJson(response);

    return registerResponse;

  } catch (e) {
    print("Error during registration: $e");
    return null;
  }
}

}