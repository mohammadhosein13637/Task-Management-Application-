import 'package:flutter/foundation.dart';

class TaskServers {
  //
  static const develop = 'http://localhost:3000';

  static const release = 'http://localhost:3000';

  String get current => kDebugMode ? develop : release;
}

class TaskUrls {
  //
  final login = '/user/login/';
  final register = '/user/register';
  final task = '/task';
  
}
