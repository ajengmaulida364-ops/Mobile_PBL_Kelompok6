import 'package:flutter/material.dart';
import '../../services/teacher/teacher_attendance_service.dart';

class TeacherAttendanceHistoryScreen extends StatefulWidget {
  const TeacherAttendanceHistoryScreen({super.key});

  @override
  State<TeacherAttendanceHistoryScreen> createState() =>
      _TeacherAttendanceHistoryScreenState();
}

class _TeacherAttendanceHistoryScreenState
    extends State<TeacherAttendanceHistoryScreen> {
  List<dynamic> histories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await TeacherAttendanceService.getAttendances();

    setState(() {
      histories = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : histories.isEmpty
              ? const Center(
                  child: Text("Belum ada data presensi"),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: histories.length,
                  itemBuilder: (context, index) {
                    final history = histories[index];

                    final date = DateTime.parse(history['date']);

                    const bulan = [
                      '',
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'Mei',
                      'Jun',
                      'Jul',
                      'Agu',
                      'Sep',
                      'Okt',
                      'Nov',
                      'Des',
                    ];

                    final tanggal =
                        '${date.day} ${bulan[date.month]} ${date.year}';

                    final checkIn = history['check_in'];
                    final checkOut = history['check_out'];

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
                            tanggal,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Hadir",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Masuk : ${checkIn ?? '-'}",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Pulang : ${checkOut ?? '-'}",
                            style: TextStyle(
                              color: Colors.grey,
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
