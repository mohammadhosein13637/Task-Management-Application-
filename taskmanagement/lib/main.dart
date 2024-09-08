import 'package:flutter/material.dart';
import 'package:taskmanagement/data/hive_db/hive_db.dart';
import 'package:taskmanagement/data/task_api/task_api_engine.dart';
import 'package:taskmanagement/domains/user_repository/user_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDB.init(appName: 'atap');
  final userRepo = await UserRepository.init();
  TaskApi.init(
    logger: true,
    onUnAuthorized: userRepo.logOut,
  );

  runApp(App(
    userRepo: userRepo,
  ));
}

