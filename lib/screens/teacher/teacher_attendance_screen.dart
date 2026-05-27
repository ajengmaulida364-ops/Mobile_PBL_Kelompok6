import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'teacher_attendance_history_screen.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  bool isPermission = false;

  String? fileName;

  String selectedType = "Izin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Presensi Guru",

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

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
                  const Text(
                    "Input Presensi Guru",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Lakukan absensi kehadiran hari ini.",

                    style: TextStyle(color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 24),

                  /// TANGGAL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: const Color(0xffF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Text(
                      "Tanggal : 24 Mei 2026",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// BUTTON
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPermission = false;
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        child: const Text(
                          "Hadir",

                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(width: 12),

                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isPermission = true;
                          });
                        },

                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        child: const Text("Izin / Cuti"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// FORM IZIN
                  if (isPermission)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: const Color(0xffF5F7FA),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Jenis",

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              _buildTypeButton("Izin"),
                              const SizedBox(width: 10),

                              _buildTypeButton("Sakit"),
                              const SizedBox(width: 10),

                              _buildTypeButton("Cuti"),
                            ],
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Catatan",

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 12),

                          TextField(
                            maxLines: 4,

                            decoration: InputDecoration(
                              hintText: "Masukkan alasan",

                              filled: true,
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Upload Surat",

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 12),

                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles();

                              if (result != null) {
                                setState(() {
                                  fileName = result.files.single.name;
                                });
                              }
                            },

                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),

                                border: Border.all(color: Colors.grey.shade300),
                              ),

                              child: Text(
                                fileName ?? "Choose File",

                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,

                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Izin berhasil dikirim"),
                                  ),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherAttendanceHistoryScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),

                              child: const Text(
                                "Kirim Izin",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = type;
          });
        },

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),

          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.white,

            borderRadius: BorderRadius.circular(14),

            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Center(
            child: Text(
              type,

              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
