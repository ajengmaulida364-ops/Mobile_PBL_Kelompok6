import 'package:flutter/material.dart';

class KegiatanAnakScreen extends StatelessWidget {
  const KegiatanAnakScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Kegiatan Anak",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                gradient: const LinearGradient(

                  colors: [
                    Color(0xff0F766E),
                    Color(0xff0284C7),
                  ],

                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: const [

                  Text(
                    "Kegiatan Harian",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Aktivitas anak setiap hari di sekolah",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// FILTER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(
                    color: Colors.grey.withValues(
                      alpha: 0.08,
                    ),

                    blurRadius: 10,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                children: [

                  /// INPUT
                  Expanded(
                    child: TextField(

                      decoration: InputDecoration(

                        hintText: "dd/mm/yyyy",

                        prefixIcon: const Icon(
                          Icons.calendar_month,
                          color: Colors.purple,
                        ),

                        suffixIcon:
                            const Icon(Icons.calendar_today),

                        filled: true,
                        fillColor: Colors.white,

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),

                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),

                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// BUTTON
                  SizedBox(
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,

                        elevation: 0,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "Filter",

                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// LIST KEGIATAN
            kegiatanCard(
              tanggal: "22 Mei 2026",
              hari: "Jumat",
              image:
                  "https://img.freepik.com/free-photo/teacher-teaching-kids-classroom_23-2148892563.jpg",
              kegiatan: [
                "Senam",
                "Berhitung",
                "Membatik",
              ],
            ),

            const SizedBox(height: 18),

            kegiatanCard(
              tanggal: "23 Mei 2026",
              hari: "Sabtu",
              image:
                  "https://img.freepik.com/free-photo/children-playing-kindergarten_23-2149503444.jpg",
              kegiatan: [
                "Mewarnai",
                "Menyusun Balok",
                "Bernyanyi",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget kegiatanCard({
    required String tanggal,
    required String hari,
    required String image,
    required List<String> kegiatan,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color: Colors.grey.withValues(
              alpha: 0.08,
            ),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// LABEL
          Center(
            child: Text(
              "HASIL KARYA",

              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// IMAGE
          ClipRRect(
            borderRadius:
                BorderRadius.circular(20),

            child: Image.network(
              image,

              width: double.infinity,
              height: 220,

              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          /// DATE
          Row(
            children: [

              Text(
                tanggal,

                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xffEEF2FF),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  hari,

                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TITLE
          const Text(
            "Aktivitas Hari Ini",

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          /// LIST
          Padding(
            padding:
                const EdgeInsets.only(left: 8),

            child: Column(
              children:
                  kegiatan.map((item) {

                return kegiatanItem(item);

              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget kegiatanItem(String text) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "• ",

            style: TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),

          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}