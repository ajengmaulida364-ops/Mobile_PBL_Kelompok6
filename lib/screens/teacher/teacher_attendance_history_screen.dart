import 'package:flutter/material.dart';

class TeacherAttendanceHistoryScreen extends StatelessWidget {
  const TeacherAttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> histories = [
      {
        "date": "24 Mei 2026",
        "status": "Hadir",
        "note": "Masuk tepat waktu",
      },
      {
        "date": "23 Mei 2026",
        "status": "Izin",
        "note": "Sakit demam",
      },
      {
        "date": "22 Mei 2026",
        "status": "Hadir",
        "note": "Mengajar kelas A",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Riwayat Presensi Guru",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: histories.length,

        itemBuilder: (context, index) {
          final history = histories[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
                Text(
                  history['date'],

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: history['status'] == "Hadir"
                            ? Colors.green
                            : Colors.orange,

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        history['status'],

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  history['note'],

                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}