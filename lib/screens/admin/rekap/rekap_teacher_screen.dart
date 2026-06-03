import 'package:flutter/material.dart';

import '../../../services/admin/rekap_service.dart';
import 'rekap_teacher_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RekapTeacherScreen extends StatefulWidget {
  const RekapTeacherScreen({
    super.key,
  });

  @override
  State<RekapTeacherScreen> createState() => _RekapTeacherScreenState();
}

class _RekapTeacherScreenState extends State<RekapTeacherScreen> {
  List teachers = [];

  List filteredTeachers = [];

  bool isLoading = true;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await RekapService().getRekapGuru();

      setState(() {
        teachers = data;

        filteredTeachers = data;

        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  void searchTeacher(String keyword) {
    setState(() {
      filteredTeachers = teachers.where((item) {
        return item['name'].toString().toLowerCase().contains(
              keyword.toLowerCase(),
            );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Rekap Guru",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () async {
              final now = DateTime.now();

              final url = await RekapService().getExportGuruUrl(
                bulan: now.month,
                tahun: now.year,
              );

              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: searchTeacher,
                    decoration: InputDecoration(
                      hintText: "Cari nama guru...",
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredTeachers.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final item = filteredTeachers[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _info(
                                    "Hadir",
                                    item['hadir'].toString(),
                                    Colors.green,
                                  ),
                                  _info(
                                    "Izin",
                                    item['izin'].toString(),
                                    Colors.orange,
                                  ),
                                  _info(
                                    "Sakit",
                                    item['sakit'].toString(),
                                    Colors.blue,
                                  ),
                                  _info(
                                    "Alpha",
                                    item['alpha'].toString(),
                                    Colors.red,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            RekapTeacherDetailScreen(
                                          teacher: item,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Detail",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _info(
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }
}