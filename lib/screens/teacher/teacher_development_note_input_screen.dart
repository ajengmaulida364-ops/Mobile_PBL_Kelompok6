import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class DevelopmentNoteInputScreen extends StatefulWidget {
  const DevelopmentNoteInputScreen({super.key});

  @override
  State<DevelopmentNoteInputScreen> createState() =>
      _DevelopmentNoteInputScreenState();
}

class _DevelopmentNoteInputScreenState
    extends State<DevelopmentNoteInputScreen> {
  String selectedMonth = "Mei";
  String selectedYear = "2026";

  List<Map<String, TextEditingController>> rows = [];

  @override
  void initState() {
    super.initState();

    rows = List.generate(3, (i) {
      return {
        "name": TextEditingController(text: "Siswa ${i + 1}"),
        "tb": TextEditingController(),
        "bb": TextEditingController(),
        "catatan": TextEditingController(),
      };
    });
  }

  void save() async {
    final api = ApiService();

    for (var r in rows) {
      await api.storeDevelopment({
        "bulan": selectedMonth,
        "tahun": selectedYear,
        "nama": r["name"]!.text,
        "tb": r["tb"]!.text,
        "bb": r["bb"]!.text,
        "catatan": r["catatan"]!.text,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Kegiatan berhasil disimpan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3FA),

      appBar: AppBar(
        title: Text("Rekap Perkembangan Anak"),
        centerTitle: false,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== CARD CONTAINER (LIKE WEB) =====
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Perkembangan Anak Bulanan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Input perkembangan seluruh siswa.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  SizedBox(height: 16),

                  // FILTER (bulan + tahun)
                  Row(
                    children: [

                      // BULAN
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedMonth,
                          decoration: InputDecoration(
                            labelText: "Bulan",
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            "Januari","Februari","Maret","April","Mei",
                            "Juni","Juli","Agustus","September","Oktober",
                            "November","Desember"
                          ]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            setState(() => selectedMonth = v!);
                          },
                        ),
                      ),

                      SizedBox(width: 10),

                      // TAHUN
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Tahun",
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                            text: selectedYear,
                          ),
                          onChanged: (v) => selectedYear = v,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // HEADER TABLE
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Expanded(child: Text("Nama Siswa")),
                        Expanded(child: Text("TB (cm)")),
                        Expanded(child: Text("BB (kg)")),
                        Expanded(child: Text("Catatan")),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // INPUT ROWS
                  Column(
                    children: rows.map((r) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [

                            Expanded(
                              child: TextField(
                                controller: r["name"],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                            SizedBox(width: 5),

                            Expanded(
                              child: TextField(
                                controller: r["tb"],
                                decoration: InputDecoration(
                                  hintText: "TB",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                            SizedBox(width: 5),

                            Expanded(
                              child: TextField(
                                controller: r["bb"],
                                decoration: InputDecoration(
                                  hintText: "BB",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                            SizedBox(width: 5),

                            Expanded(
                              child: TextField(
                                controller: r["catatan"],
                                decoration: InputDecoration(
                                  hintText: "Catatan",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 20),

                  // BUTTON SAVE (ORANGE LIKE WEB)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.all(14),
                      ),
                      onPressed: save,
                      child: Text("Simpan"),
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
}