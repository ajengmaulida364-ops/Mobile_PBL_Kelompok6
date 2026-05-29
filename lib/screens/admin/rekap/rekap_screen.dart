import 'package:flutter/material.dart';

import 'rekap_teacher_screen.dart';
import 'rekap_student_screen.dart';

class RekapScreen extends StatelessWidget {

  const RekapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        elevation: 0,

        title: const Text(

          "Rekap Presensi",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 30),

            const Text(

              "Pilih Jenis Rekap",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(

              "Lihat rekap presensi guru dan siswa",

              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 40),

            /// REKAP GURU
            _menuCard(

              context,

              title:
                  "Rekap Guru",

              subtitle:
                  "Lihat rekap kehadiran guru",

              icon:
                  Icons.person,

              color:
                  Colors.orange,

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder:
                        (_) =>
                            const RekapTeacherScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// REKAP SISWA
            _menuCard(

              context,

              title:
                  "Rekap Siswa",

              subtitle:
                  "Lihat rekap kehadiran siswa",

              icon:
                  Icons.school,

              color:
                  Colors.teal,

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder:
                        (_) =>
                            const RekapStudentScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(

    BuildContext context, {

    required String title,

    required String subtitle,

    required IconData icon,

    required Color color,

    required VoidCallback onTap,
  }) {

    return InkWell(

      onTap: onTap,

      borderRadius:
          BorderRadius.circular(
              20),

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.all(
                22),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
                  20),

          boxShadow: [

            BoxShadow(

              color: Colors.black
                  .withOpacity(0.05),

              blurRadius: 8,

              offset:
                  const Offset(
                      0,
                      4),
            ),
          ],
        ),

        child: Row(

          children: [

            Container(

              padding:
                  const EdgeInsets
                      .all(18),

              decoration:
                  BoxDecoration(

                color: color
                    .withOpacity(
                        0.1),

                shape:
                    BoxShape.circle,
              ),

              child: Icon(

                icon,

                color: color,

                size: 30,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    title,

                    style:
                        const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Text(

                    subtitle,

                    style: TextStyle(
                      color:
                          Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}