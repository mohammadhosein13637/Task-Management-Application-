import 'package:flutter/foundation.dart';

class TaskServers {
  //
  static const develop = 'http://213.176.29.118';

  static const release = 'http://213.176.29.118';

  String get current => kDebugMode ? develop : release;
}

class TaskUrls {
  //
  final login = '/api/auth/jwt/create';
  final products = '/api/store/products/';
  final me = '/api/auth/users/me';
  final groups = '/api/store/groups/';
  final images = '/api/store/images/';
  final collections = '/api/store/collections/';
  final orders = '/api/store/orders';
  final customers = '/api/store/customers/';
}
