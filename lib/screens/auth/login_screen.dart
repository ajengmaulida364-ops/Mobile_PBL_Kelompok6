import 'package:flutter/material.dart';

import '../teacher/dashboard_teacher_screen.dart';

import '../../services/api_service.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController loginController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Container(

            width: double.infinity,

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                // HEADER
                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: const BoxDecoration(

                    color: Color(0xFF00695C),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                  child: const Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

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
                        "Masuk sebagai admin, guru, atau orang tua.",

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // FORM
                Padding(

                  padding: const EdgeInsets.all(20),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Username",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomInput(
                        controller: loginController,
                        hint: "NPSN / Email / NISN",
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Password",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomInput(
                        controller: passwordController,
                        hint: "Masukkan password",
                        obscureText: true,
                      ),

                      const SizedBox(height: 30),

                      Align(

                        alignment: Alignment.centerRight,

                        child: SizedBox(

                          width: 120,

                          child: CustomButton(

                            text: "Login",

                            onPressed: () async {

                              print(
                                "BUTTON LOGIN DIKLIK",
                              );

                              try {

                                final result =
                                    await ApiService()
                                        .login(

                                  login:
                                      loginController
                                          .text
                                          .trim(),

                                  password:
                                      passwordController
                                          .text
                                          .trim(),

                                );

                                print(result);

                                if (result['status']
                                    == true) {

                                  if (result['role']
                                      == 'teacher') {

                                    Navigator.push(
                                      context,

                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const DashboardTeacherScreen(),
                                      ),
                                    );
                                  }

                                } else {

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(

                                    SnackBar(
                                      content: Text(

                                        result['message']
                                            ??
                                            "Login gagal",

                                      ),
                                    ),
                                  );
                                }

                              } catch (e) {

                                print(e);

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(

                                  SnackBar(
                                    content: Text(
                                      "Error: $e",
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
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