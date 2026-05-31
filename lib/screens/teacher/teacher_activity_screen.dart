import 'package:flutter/material.dart';
import 'teacher_activity_history_screen.dart';
import '../../services/teacher/teacher_activity_service.dart';

class TeacherActivityScreen extends StatefulWidget {
  TeacherActivityScreen({super.key});

  @override
  State<TeacherActivityScreen> createState() => _TeacherActivityScreenState();
}

class _TeacherActivityScreenState extends State<TeacherActivityScreen> {
  final TextEditingController pelajaran1Controller = TextEditingController();
  final TextEditingController pelajaran2Controller = TextEditingController();
  final TextEditingController pelajaran3Controller = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String formattedDate =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  List<Map<String, dynamic>> activities = [];

  bool isLoading = false;

  int teacherId = 1; // nanti dari login
  int schoolClassId = 1; // nanti dari login

  Future<void> loadActivities() async {
    try {
      final data = await TeacherActivityService.getActivities(
        teacherId: teacherId,
      );

      setState(() {
        activities = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F3F7),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Kegiatan",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Input Kegiatan Harian",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      formattedDate =
                          "${picked.year}-${picked.month}-${picked.day}";
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formattedDate),
                      Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: pelajaran1Controller,
                decoration: InputDecoration(
                  hintText: "Pelajaran 1",
                ),
              ),
              TextField(
                controller: pelajaran2Controller,
                decoration: InputDecoration(
                  hintText: "Pelajaran 2",
                ),
              ),
              TextField(
                controller: pelajaran3Controller,
                decoration: InputDecoration(
                  hintText: "Pelajaran 3",
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          bool result =
                              await TeacherActivityService.createActivity(
                            teacherId: teacherId,
                            schoolClassId: schoolClassId,
                            date: formattedDate,
                            activity1: pelajaran1Controller.text,
                            activity2: pelajaran2Controller.text,
                            activity3: pelajaran3Controller.text,
                          );

                          setState(() {
                            isLoading = false;
                          });

                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Berhasil disimpan ke server"),
                              ),
                            );

                            pelajaran1Controller.clear();
                            pelajaran2Controller.clear();
                            pelajaran3Controller.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Gagal menyimpan"),
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Simpan Kegiatan",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    await loadActivities();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherActivityHistoryScreen(
                          data: activities,
                        ),
                      ),
                    );
                  },
                  child: Text("Lihat Data Kegiatan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
