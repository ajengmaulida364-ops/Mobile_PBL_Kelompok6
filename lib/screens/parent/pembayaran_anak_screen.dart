import 'package:flutter/material.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> pembayaran = [

      {
        "bulan": "Februari 2026",
        "nominal": "Rp 30.000",
        "status": "Lunas",
        "warna": Colors.green,
      },

      {
        "bulan": "Januari 2026",
        "nominal": "Rp 30.000",
        "status": "Lunas",
        "warna": Colors.green,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Pembayaran",

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

            /// HERO HEADER
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
                    BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: const [

                  Text(
                    "Pembayaran SPP",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Informasi pembayaran anak",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// INFO TAGIHAN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(16),

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.grey.withValues(alpha: 0.1),

                    blurRadius: 6,

                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Informasi Tagihan",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 18),

                  infoRow(
                    "Nama Siswa",
                    "AFLAHUL EL ZEHAN",
                  ),

                  infoRow(
                    "NISN",
                    "3221935788",
                  ),

                  infoRow(
                    "Nama Orang Tua",
                    "SUPINIK",
                  ),

                  infoRow(
                    "Kelas",
                    "A",
                  ),

                  infoRow(
                    "Tahun Ajaran",
                    "2026/2027",
                  ),

                  const Divider(height: 32),

                  const Text(
                    "Total Tagihan",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Rp 60.000",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color(0xff0F172A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Pembayaran Bulanan",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 16),

            /// LIST PEMBAYARAN
            ListView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: pembayaran.length,

              itemBuilder: (context, index) {

                final item = pembayaran[index];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 16),

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(16),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey
                            .withValues(alpha: 0.1),

                        blurRadius: 6,

                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Container(
                        padding:
                            const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.green
                              .withValues(alpha: 0.1),

                          borderRadius:
                              BorderRadius.circular(12),
                        ),

                        child: const Icon(
                          Icons.payments,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              item['bulan'],

                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              item['nominal'],

                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.green
                              .withValues(alpha: 0.1),

                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        child: const Text(
                          "Lunas",

                          style: TextStyle(
                            color: Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(
    String title,
    String value,
  ) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 120,

            child: Text(
              title,

              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,

              style: const TextStyle(
                color: Color(0xff334155),
              ),
            ),
          ),
        ],
      ),
    );
  }
}