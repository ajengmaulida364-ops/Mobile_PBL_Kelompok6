import 'dart:async';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 10),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff038F81),
              Color(0xff00B8A9),
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const Spacer(),

              Container(
                width: 240,
                height: 240,

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/logo_sipari.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "SIPARI PAUD",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              const SizedBox(
                width: 250,
                child: Divider(
                  thickness: 4,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Sistem Informasi PAUD Terintegrasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Spacer(),

              const CircularProgressIndicator(
                color: Colors.white,
              ),

              const SizedBox(height: 16),

              const Text(
                "Memuat...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}