import 'package:flutter/material.dart';

import 'rekap_student_detail_screen.dart';

class RekapStudentScreen
    extends StatelessWidget {

  const RekapStudentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final List students = [

      {
        "name":
            "AHMAD ANGGORO",
        "hadir": 20,
        "izin": 1,
        "sakit": 0,
        "alpha": 1,
        "total": 22,
      },
    ];

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        title: const Text(

          "Rekap Siswa",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              decoration:
                  InputDecoration(

                hintText:
                    "Cari nama siswa...",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                              14),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child:
                  ListView.builder(

                itemCount:
                    students.length,

                itemBuilder:
                    (context, index) {

                  final item =
                      students[index];

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

                          item['name'],

                          style:
                              const TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                16),

                        Row(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            _info(
                              "Hadir",
                              item[
                                      'hadir']
                                  .toString(),
                              Colors.green,
                            ),

                            _info(
                              "Izin",
                              item[
                                      'izin']
                                  .toString(),
                              Colors.orange,
                            ),

                            _info(
                              "Sakit",
                              item[
                                      'sakit']
                                  .toString(),
                              Colors.blue,
                            ),

                            _info(
                              "Alpha",
                              item[
                                      'alpha']
                                  .toString(),
                              Colors.red,
                            ),
                          ],
                        ),

                        const SizedBox(
                            height:
                                16),

                        SizedBox(

                          width: double.infinity,

                          child:
                              ElevatedButton(

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  Colors.teal,
                            ),

                            onPressed:
                                () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          RekapStudentDetailScreen(
                                    student:
                                        item,
                                  ),
                                ),
                              );
                            },

                            child:
                                const Text(
                              "Detail",
                            ),
                          ),
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

  Widget _info(

    String title,

    String value,

    Color color,
  ) {

    return Column(

      children: [

        Text(

          value,

          style: TextStyle(

            color: color,

            fontSize: 22,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        Text(title),
      ],
    );
  }
}