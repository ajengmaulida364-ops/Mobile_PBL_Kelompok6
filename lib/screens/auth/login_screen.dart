import 'package:flutter/material.dart';

import '../admin/dashboard_admin_screen.dart';
import '../teacher/dashboard_teacher_screen.dart';
import '../parent/parent_dashboard_screen.dart';

import '../../services/api_service.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import '../../core/utils/user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 3, 143, 129),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login Sistem",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Login admin, guru, atau orang tua",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                /// FORM
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Username",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      CustomInput(
                        controller: loginController,
                        hint: "Masukkan username",
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      CustomInput(
                        controller: passwordController,
                        hint: "Masukkan password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: isLoading ? "Loading..." : "Login",
                          onPressed: () async {
                            if (isLoading) return;

                            setState(() {
                              isLoading = true;
                            });

                            try {
                              print("BUTTON LOGIN DIKLIK");

                              final result = await ApiService().login(
                                login: loginController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              print(result);

                              final role = result['role']
                                  .toString()
                                  .trim()
                                  .toLowerCase();

                              print("ROLE: $role");

                              if (result['status'] == true) {
                                UserSession.id = result['id'];
                                UserSession.name = result['name'];
                                UserSession.username = result['username'];
                                UserSession.role = result['role'];

                                print("ID       : ${UserSession.id}");
                                print("NAME     : ${UserSession.name}");
                                print("USERNAME : ${UserSession.username}");
                                print("ROLE     : ${UserSession.role}");

                                /// ADMIN
                                if (role == 'admin') {
                                  print("MASUK ADMIN");

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const DashboardAdminScreen(),
                                    ),
                                  );
                                }

                                /// TEACHER
                                else if (role == 'teacher') {
                                  print("MASUK TEACHER");

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DashboardTeacherScreen(),
                                    ),
                                  );
                                }

                                /// PARENT
                                else if (role == 'parent') {
                                  print("MASUK PARENT");

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ParentDashboardScreen(),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Login gagal"),
                                  ),
                                );
                              }
                            } catch (e) {
                              print("ERROR LOGIN");

                              print(e);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Error: $e"),
                                ),
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
