import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class DevelopmentNoteListScreen extends StatefulWidget {
  const DevelopmentNoteListScreen({super.key});

  @override
  State<DevelopmentNoteListScreen> createState() =>
      _DevelopmentNoteListScreenState();
}

class _DevelopmentNoteListScreenState
    extends State<DevelopmentNoteListScreen> {

  List data = [];
  bool loading = true;
  String? selectedStudentId;

  String selectedYear = "2025";

  @override
  void initState() {
    super.initState();
    load();
  }
void load() async {
  try {
    setState(() => loading = true);

    final api = ApiService();
    final res = await api.getDevelopment(
  year: selectedYear,
  studentId: "1",
);

    print("RAW RESPONSE => $res");

    List result = [];

    if (res is Map<String, dynamic>) {
      if (res['data'] != null) {
        result = List.from(res['data']);
      }
    } 
    else if (res is List) {
      result = res;
    }

    setState(() {
      data = result;
      loading = false;
    });

  } catch (e) {
    print("ERROR LOAD: $e");

    setState(() {
      loading = false;
      data = [];
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      appBar: AppBar(
        title: const Text("Rekap Perkembangan Anak"),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [

                const SizedBox(height: 16),

                // ===== HEADER =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Tahun",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedYear,
                            items: ["2024", "2025", "2026"]
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              setState(() {
                                selectedYear = v!;
                              });
                              load();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ===== LIST =====
                Expanded(
                  child: data.isEmpty
                      ? const Center(
                          child: Text("Belum ada data perkembangan"),
                        )
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            final item = data[i];

                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['bulan'] ?? '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text("TB: ${item['tb']} cm"),
                                  Text("BB: ${item['bb']} kg"),
                                  Text("Catatan: ${item['catatan']}"),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}