import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/teacher/dashboard_teacher_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      // sementara langsung ke dashboard guru
      home: DashboardTeacherScreen(),

      // kalau mau balik login tinggal ganti:
      // home: LoginScreen(),
    );
  }
}