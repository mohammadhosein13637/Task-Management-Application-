import 'package:flutter/foundation.dart';
import 'package:taskmanagement/data/task_api/task_client.dart';
import 'package:taskmanagement/data/task_api/task_url.dart';

abstract class TaskApi {
  //
  static final servers = TaskServers();

  static final urls = TaskUrls();

  static late final TaskHttpClient client;

  static void init({
    String? server,
    bool? logger,
    Function? onUnAuthorized,
  }) {
    client = TaskHttpClient(
      server: server ?? servers.current,
      logger: logger ?? kDebugMode,
      onUnAuthorized: onUnAuthorized ?? () {},
    );
  }
}
