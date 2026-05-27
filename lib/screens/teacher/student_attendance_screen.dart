import 'package:flutter/material.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState
    extends State<StudentAttendanceScreen> {

  String selectedMonth = "Mei 2026";

  final List<String> statuses = ["H", "I", "S", "A"];

  String selectedStatus = "H";

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

                  final DateTime? picked =
                      await showDatePicker(

                    context: context,

                    initialDate: DateTime.now(),

                    firstDate: DateTime(2024),

                    lastDate: DateTime(2030),
                  );

                  if (picked != null) {

                    setState(() {

                      selectedMonth =
                          "${picked.month}/${picked.year}";
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

                    borderRadius:
                        BorderRadius.circular(16),

                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

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

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: statuses.map((status) {

                    final isSelected =
                        selectedStatus == status;

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

                          borderRadius:
                              BorderRadius.circular(16),

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

                              fontWeight:
                                  FontWeight.bold,

                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                height: 60,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(0xFFFFA000),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content:
                            Text("Presensi berhasil disimpan"),
                      ),
                    );
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