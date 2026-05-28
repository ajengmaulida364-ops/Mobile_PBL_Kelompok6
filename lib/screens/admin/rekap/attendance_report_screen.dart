import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatelessWidget {
  const AttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.teal,

        title: const Text(
          "Rekap Presensi",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: const Center(
        child: Text(
          "Halaman Rekap Presensi",
        ),
      ),
    );
  }
}