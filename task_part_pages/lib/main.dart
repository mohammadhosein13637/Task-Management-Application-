import 'package:flutter/material.dart';
import 'package:task_part_pages/pages/auth/login/login_page.dart';
import 'package:task_part_pages/pages/splash/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
