import 'package:flutter/material.dart';
import '../../services/teacher/teacher_student_service.dart';

class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({super.key});

  @override
  State<StudentDataScreen> createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {
  String selectedClass = "Kelas A";

  List<dynamic> students = [];

  bool isLoading = true;

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
      backgroundColor: const Color(0xFFF3F3F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Data Siswa",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
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
                "Data Siswa",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Daftar siswa sesuai kelas",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Pilih Kelas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedClass,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "Kelas A",
                        child: Text("Kelas A"),
                      ),
                      DropdownMenuItem(
                        value: "Kelas B",
                        child: Text("Kelas B"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Nama",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "NISN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else if (students.isEmpty)
                      Center(
                        child: Text(
                          "Belum ada data siswa",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      )
                    else
                      Column(
                        children: students.map((student) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    student['name'] ?? '-',
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student['nisn'] ?? '-',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
