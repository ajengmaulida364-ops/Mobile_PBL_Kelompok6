import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import 'teacher_attendance_screen.dart';
import 'student_attendance_screen.dart';
import 'student_data_screen.dart';
import 'teacher_activity_screen.dart';
import 'teacher_development_note_input_screen.dart';
import 'teacher_development_note_list_screen.dart';

class DashboardTeacherScreen extends StatelessWidget {
  DashboardTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> menus = [

      {
        "title": "Data Siswa",
        "subtitle": "Lihat data siswa",
        "icon": Icons.school,
      },

      {
        "title": "Presensi Guru",
        "subtitle": "Absen guru",
        "icon": Icons.fact_check,
      },

      {
        "title": "Presensi Siswa",
        "subtitle": "Input presensi",
        "icon": Icons.people,
      },

      {
        "title": "Kegiatan",
        "subtitle": "Kegiatan harian",
        "icon": Icons.menu_book,
      },

      {
        "title": "Perkembangan",
        "subtitle": "Perkembangan anak",
        "icon": Icons.trending_up,
      },
    ];

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Dashboard Guru",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KB Raudlotul Ilmi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Selamat datang, Guru 👋",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Menu Guru",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            GridView.builder(

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menus.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),

              itemBuilder: (context, index) {

                final menu = menus[index];

                return GestureDetector(

                  onTap: () {

                    if (menu['title'] == "Data Siswa") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StudentDataScreen(),
                        ),
                      );
                    }

                    else if (menu['title'] == "Presensi Guru") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TeacherAttendanceScreen(),
                        ),
                      );
                    }

                    else if (menu['title'] == "Presensi Siswa") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StudentAttendanceScreen(),
                        ),
                      );
                    }

                    else if (menu['title'] == "Kegiatan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TeacherActivityScreen(),
                        ),
                      );
                    }

                    else if (menu['title'] == "Perkembangan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DevelopmentNoteListScreen(),
                        ),
                      );
                    }
                  },

                  child: Container(

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Icon(
                          menu['icon'],
                          size: 32,
                          color: Colors.teal,
                        ),

                        const Spacer(),

                        Text(
                          menu['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          menu['subtitle'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}