import 'package:flutter/material.dart';

class RekapTeacherDetailScreen
    extends StatelessWidget {

  final Map teacher;

  const RekapTeacherDetailScreen({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {

    final List data = [

      {
        "tanggal":
            "12 Mei 2026",
        "hari":
            "Senin",
        "status":
            "Hadir",
        "catatan":
            "-",
      },

      {
        "tanggal":
            "13 Mei 2026",
        "hari":
            "Selasa",
        "status":
            "Izin",
        "catatan":
            "Acara keluarga",
      },
    ];

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        title: const Text(

          "Detail Rekap Guru",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              teacher['name'],

              style:
                  const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(

              "Riwayat presensi guru",

              style: TextStyle(
                color:
                    Colors.grey[700],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child:
                  ListView.builder(

                itemCount:
                    data.length,

                itemBuilder:
                    (context, index) {

                  final item =
                      data[index];

                  return Container(

                    margin:
                        const EdgeInsets
                            .only(
                                bottom:
                                    16),

                    padding:
                        const EdgeInsets
                            .all(18),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          item[
                              'tanggal'],

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                6),

                        Text(
                          item['hari'],
                        ),

                        const SizedBox(
                            height:
                                10),

                        Container(

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal:
                                12,
                            vertical:
                                6,
                          ),

                          decoration:
                              BoxDecoration(

                            color: Colors
                                .teal
                                .withOpacity(
                                    0.1),

                            borderRadius:
                                BorderRadius.circular(
                                    30),
                          ),

                          child: Text(
                            item[
                                'status'],
                          ),
                        ),

                        const SizedBox(
                            height:
                                10),

                        Text(

                          "Catatan : ${item['catatan']}",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}