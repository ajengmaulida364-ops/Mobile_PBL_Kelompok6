import 'package:flutter/material.dart';

import '../../../services/admin/student_service.dart';

import 'add_student_screen.dart';
import 'edit_student_screen.dart';
import 'detail_student_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final searchController = TextEditingController();

  List students = [];
  List filteredStudents = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  Future<void> getStudents() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await StudentService().getStudents();

      setState(() {
        students = result;
        filteredStudents = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchStudent(String keyword) {
    final result = students.where((student) {
      final name = student['name']?.toString().toLowerCase() ?? '';
      final nisn = student['nisn']?.toString() ?? '';
      final parentName = student['parent_name']?.toString().toLowerCase() ?? '';

      return name.contains(keyword.toLowerCase()) ||
          nisn.contains(keyword) ||
          parentName.contains(keyword.toLowerCase());
    }).toList();

    setState(() {
      filteredStudents = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text("Data Siswa"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,

        // 🔥 FIX DI SINI (WAJIB BIAR AUTO REFRESH)
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddStudentScreen(),
            ),
          );

          if (result == true) {
            getStudents(); // 🔥 REFRESH LIST
          }
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                /// SEARCH
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: searchController,
                    onChanged: searchStudent,
                    decoration: InputDecoration(
                      hintText: "Cari nama / NISN / orang tua",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                /// LIST
                Expanded(
                  child: filteredStudents.isEmpty
                      ? const Center(child: Text("Belum ada data siswa"))
                      : RefreshIndicator(
                          onRefresh: getStudents,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: filteredStudents.length,
                            itemBuilder: (context, index) {
                              final student = filteredStudents[index];

                              final bool isActive = student['is_active'] == 1 ||
                                  student['is_active'] == true;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.teal,
                                          child: Icon(Icons.school,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                student['name'] ?? '-',
                                              ),
                                              Text(
                                                "NISN : ${student['nisn'] ?? '-'}",
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuButton(
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              value: 'detail',
                                              child: Text("Detail"),
                                            ),
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Text("Edit"),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text("Hapus"),
                                            ),
                                          ],
                                          onSelected: (value) async {
                                            if (value == 'detail') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DetailStudentScreen(
                                                          student: student),
                                                ),
                                              );
                                            }

                                            if (value == 'edit') {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditStudentScreen(
                                                          student: student),
                                                ),
                                              );

                                              if (result == true) {
                                                getStudents(); // 🔥 REFRESH
                                              }
                                            }

                                            if (value == 'delete') {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Hapus Siswa"),
                                                    content: const Text(
                                                        "Yakin ingin menghapus siswa ini?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text("Batal"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          final success =
                                                              await StudentService()
                                                                  .deleteStudent(
                                                            student['id'],
                                                          );

                                                          if (!mounted) return;

                                                          Navigator.pop(
                                                              context);

                                                          if (success) {
                                                            await getStudents();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                  "Siswa berhasil dihapus",
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            const Text("Hapus"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}