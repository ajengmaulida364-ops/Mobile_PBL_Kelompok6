import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'teacher_development_note_input_screen.dart';

class TeacherDevelopmentListScreen extends StatelessWidget {

  final List<Map<String, dynamic>> data;

  const TeacherDevelopmentListScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        title: const Text(
          "Rekap Perkembangan Anak",
        ),

        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        elevation: 0,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            // ===== FILTER =====

            Row(

              children: [

                Expanded(

                  child: DropdownButtonFormField<String>(

                    decoration: const InputDecoration(

                      labelText: "Bulan",

                      border: OutlineInputBorder(),
                    ),

                    items: const [],

                    onChanged: (v) {},
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(

                  child: TextFormField(

                    decoration: const InputDecoration(

                      labelText: "Tahun",

                      border: OutlineInputBorder(),
                    ),

                    initialValue: "2026",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== BUTTON INPUT (SUDAH DIUBAH TRANSPARAN) =====

            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 45,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TeacherDevelopmentNoteInputScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Input Perkembangan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== GRAFIK TB =====

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tinggi Badan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
                  titlesData: const FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 120),
                        FlSpot(1, 125),
                        FlSpot(2, 130),
                        FlSpot(3, 128),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== GRAFIK BB =====

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Berat Badan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
                  titlesData: const FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 20),
                        FlSpot(1, 22),
                        FlSpot(2, 24),
                        FlSpot(3, 25),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== HEADER TABLE =====

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7FF),
                borderRadius: BorderRadius.circular(12),
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

            // ===== DATA =====

            data.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Belum ada data perkembangan."),
                  )
                : Column(
                    children: data.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(item['nama'] ?? '-')),
                            Expanded(child: Text("${item['tb']} cm")),
                            Expanded(child: Text("${item['bb']} kg")),
                            Expanded(child: Text(item['catatan'] ?? '-')),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}