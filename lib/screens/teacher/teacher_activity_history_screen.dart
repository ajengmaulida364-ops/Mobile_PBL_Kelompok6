import 'package:flutter/material.dart';

class TeacherActivityHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const TeacherActivityHistoryScreen({
    super.key,
    required this.data,
  });

  @override
  State<TeacherActivityHistoryScreen> createState() =>
      _TeacherActivityHistoryScreenState();
}

class _TeacherActivityHistoryScreenState
    extends State<TeacherActivityHistoryScreen> {
  String selectedMonth = "Semua";
  String selectedYear = "2026";

  final List<String> months = [
    "Semua",
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  final List<String> years = ["2025", "2026", "2027"];

  List<Map<String, dynamic>> get filteredData {
    return widget.data.where((item) {
      final tanggal = item["tanggal"].toString();

      final matchYear = tanggal.contains(selectedYear);

      final matchMonth =
          selectedMonth == "Semua" ? true : tanggal.contains(selectedMonth);

      return matchYear && matchMonth;
    }).toList();
  }

  Map<String, List<Map<String, dynamic>>> get groupedData {
    Map<String, List<Map<String, dynamic>>> map = {};

    for (var item in filteredData) {
      String date = item["tanggal"];

      if (!map.containsKey(date)) {
        map[date] = [];
      }

      map[date]!.add(item);
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text("Data Kegiatan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= FILTER =================
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedMonth,
                    items: months
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedMonth = val!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Bulan",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedYear,
                    items: years
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedYear = val!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Tahun",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ================= LIST =================
            Expanded(
              child: groupedData.isEmpty
                  ? const Center(
                      child: Text("Belum ada data kegiatan"),
                    )
                  : ListView(
                      children: groupedData.entries.map((entry) {
                        final date = entry.key;
                        final items = entry.value;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),

                              ...items.map((item) {
                                return Column(
                                  children: [
                                    _chip("P1", item["p1"], Colors.purple),
                                    _chip("P2", item["p2"], Colors.green),
                                    _chip("P3", item["p3"], Colors.orange),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, dynamic value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(value ?? "-"),
          ),
        ],
      ),
    );
  }
}