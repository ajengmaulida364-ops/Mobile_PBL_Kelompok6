import 'package:flutter/material.dart';

class TeacherActivityHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  TeacherActivityHistoryScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Kegiatan"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: data.isEmpty
            ? Center(
                child: Text("Belum ada data kegiatan"),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final item = data[i];

                  return Card(
                    child: ListTile(
                      title: Text(
                        item["tanggal"].toString(),
                      ),
                      subtitle: Text(
                        "P1: ${item["p1"]}\nP2: ${item["p2"]}\nP3: ${item["p3"]}",
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}