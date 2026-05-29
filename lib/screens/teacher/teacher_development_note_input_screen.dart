import 'package:flutter/material.dart';
import 'teacher_development_note_list_screen.dart';

class TeacherDevelopmentNoteInputScreen extends StatefulWidget {
  const TeacherDevelopmentNoteInputScreen({super.key});

  @override
  State<TeacherDevelopmentNoteInputScreen> createState() =>
      _TeacherDevelopmentNoteInputScreenState();
}

class _TeacherDevelopmentNoteInputScreenState
    extends State<TeacherDevelopmentNoteInputScreen> {
  List<Map<String, TextEditingController>> rows = [];

  void addRow() {
    setState(() {
      rows.add({
        "nama": TextEditingController(),
        "tb": TextEditingController(),
        "bb": TextEditingController(),
        "catatan": TextEditingController(),
      });
    });
  }

  // =========================
  // TAMBAHAN: SIMPAN DATA
  // =========================
  void saveData() {
    final data = rows.map((row) {
      return {
        "nama": row["nama"]!.text,
        "tb": row["tb"]!.text,
        "bb": row["bb"]!.text,
        "catatan": row["catatan"]!.text,
      };
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TeacherDevelopmentListScreen(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Input Perkembangan Anak"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                final data = rows.map((row) {
                  return {
                    "nama": row["nama"]!.text,
                    "tb": row["tb"]!.text,
                    "bb": row["bb"]!.text,
                    "catatan": row["catatan"]!.text,
                  };
                }).toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherDevelopmentListScreen(data: data),
                  ),
                );
              },
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Lihat Rekap",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Expanded(child: Text("Nama Siswa")),
                Expanded(child: Text("TB (cm)")),
                Expanded(child: Text("BB (kg)")),
                Expanded(child: Text("Catatan")),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: rows.length,
              itemBuilder: (context, index) {
                final row = rows[index];

                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: row["nama"],
                          decoration:
                              const InputDecoration(hintText: "Nama"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: row["tb"],
                          decoration:
                              const InputDecoration(hintText: "TB (cm)"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: row["bb"],
                          decoration:
                              const InputDecoration(hintText: "BB (kg)"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: row["catatan"],
                          decoration:
                              const InputDecoration(hintText: "Catatan"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // =========================
          // BUTTON BAWAH (TAMBAH + SIMPAN)
          // =========================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: addRow,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text("+ Tambah Siswa"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}