import 'package:flutter/material.dart';

class DetailStudentScreen extends StatelessWidget {
  final Map student;

  const DetailStudentScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {

    final bool isActive =
        student['is_active'] == 1 ||
        student['is_active'] == true;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          "Detail Siswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [

                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.teal,
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    student['name']?.toString() ?? '-',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "NISN : ${student['nisn']?.toString() ?? '-'}",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      isActive ? "Aktif" : "Nonaktif",
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// DETAIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [

                  _item(
                    "Jenis Kelamin",
                    student['gender']?.toString() ?? '-',
                  ),

                  /// 🔥 FIX INI (SEBELUMNYA student['class'])
                  _item(
                    "Kelas",
                    student['class_name']?.toString() ?? '-',
                  ),

                  _item(
                    "Nama Orang Tua",
                    student['parent_name']?.toString() ?? '-',
                  ),

                  _item(
                    "Telepon Orang Tua",
                    student['parent_phone']?.toString() ?? '-',
                  ),

                  _item(
                    "Alamat",
                    student['address']?.toString() ?? '-',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),

          const SizedBox(height: 12),

          const Divider(height: 1),
        ],
      ),
    );
  }
}