import 'package:flutter/material.dart';
import '../../services/teacher/teacher_student_service.dart';
import '../../services/teacher/student_attendance_service.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  String selectedMonth = "Mei 2026";

  final List<String> statuses = ["H", "I", "S", "A"];

  List<dynamic> students = [];

  bool isLoading = true;
  String selectedStatus = "H";
  Map<int, String> attendanceMap = {};

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final data = await TeacherStudentService.getStudents();

    setState(() {
      students = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Presensi Siswa",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Presensi Siswa Bulanan",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Input absensi siswa selama 1 bulan.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Pilih Bulan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedMonth = "${picked.month}/${picked.year}";
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedMonth,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: statuses.map((status) {
                    final isSelected = selectedStatus == status;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStatus = status;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFA000)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.05,
                              ),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Column(
                  children: students.map((student) {
                    final studentId = student['id'];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              student['name'],
                            ),
                          ),
                          DropdownButton<String>(
                            value: attendanceMap[studentId],
                            hint: const Text("-"),
                            items: const [
                              DropdownMenuItem(
                                value: "HADIR",
                                child: Text("H"),
                              ),
                              DropdownMenuItem(
                                value: "IZIN",
                                child: Text("I"),
                              ),
                              DropdownMenuItem(
                                value: "SAKIT",
                                child: Text("S"),
                              ),
                              DropdownMenuItem(
                                value: "ALPA",
                                child: Text("A"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                attendanceMap[studentId] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA000),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      for (var student in students) {
                        final studentId = student['id'];

                        if (attendanceMap[studentId] == null) {
                          continue;
                        }

                        await StudentAttendanceService.createAttendance(
                          studentId: studentId,
                          date:
                              DateTime.now().toIso8601String().substring(0, 10),
                          status: attendanceMap[studentId]!,
                        );
                      }

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Presensi berhasil disimpan",
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Error: $e",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
