import 'package:flutter/material.dart';

class PerkembanganScreen extends StatelessWidget {
  const PerkembanganScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> perkembangan = [

      {
        "tanggal": "Mei 2026",
        "tb": "100 cm",
        "bb": "20 kg",
      },

      {
        "tanggal": "April 2026",
        "tb": "98 cm",
        "bb": "19 kg",
      },

      {
        "tanggal": "Maret 2026",
        "tb": "96 cm",
        "bb": "18 kg",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Perkembangan Anak",

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

            /// HERO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

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

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "Perkembangan Anak",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Monitoring tinggi dan berat badan anak",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// FILTER BULAN
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.grey.withValues(alpha: 0.08),

                    blurRadius: 8,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 54,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(14),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Row(
                        children: [

                          const SizedBox(width: 14),

                          const Icon(
                            Icons.calendar_month,
                            color: Colors.deepPurple,
                            size: 20,
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: TextFormField(
                              readOnly: true,

                              decoration:
                                  const InputDecoration(
                                hintText: "May 2026",

                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.only(right: 14),

                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 90,
                    height: 54,

                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffF59E0B),

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "Filter",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// CARD TB BB
            Row(
              children: [

                Expanded(
                  child: perkembanganCard(
                    title: "Tinggi Badan",
                    value: "100 cm",
                    icon: Icons.height,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: perkembanganCard(
                    title: "Berat Badan",
                    value: "20 kg",
                    icon: Icons.monitor_weight,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// CHART TB
            chartCard(
              title: "Grafik Tinggi Badan",
              value: "100 cm",
            ),

            const SizedBox(height: 22),

            /// CHART BB
            chartCard(
              title: "Grafik Berat Badan",
              value: "20 kg",
            ),

            const SizedBox(height: 28),

            const Text(
              "Riwayat Perkembangan",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 18),

            /// LIST RIWAYAT
            ListView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: perkembangan.length,

              itemBuilder: (context, index) {

                final item = perkembangan[index];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 18),

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(20),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey
                            .withValues(alpha: 0.08),

                        blurRadius: 8,

                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        item['tanggal'],

                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 20),

                      infoRow(
                        icon: Icons.height,
                        text:
                            "Tinggi Badan : ${item['tb']}",
                      ),

                      const SizedBox(height: 16),

                      infoRow(
                        icon: Icons.monitor_weight,
                        text:
                            "Berat Badan : ${item['bb']}",
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

  Widget chartCard({
    required String title,
    required String value,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),

            blurRadius: 8,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            height: 160,

            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: Center(
              child: Text(
                "Chart $value",

                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow({
    required IconData icon,
    required String text,
  }) {

    return Row(
      children: [

        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: const Color(0xffE6F7F5),

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: const Color(0xff0F9D94),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            text,

            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget perkembanganCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),

            blurRadius: 8,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xffE6F7F5),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: const Color(0xff0F9D94),
              size: 28,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,

            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}