import 'package:flutter/material.dart';

import 'rekap_teacher_detail_screen.dart';

class RekapTeacherScreen
    extends StatelessWidget {

  const RekapTeacherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final List teachers = [

      {
        "name": "Widyawati, S.Pd",
        "hadir": 20,
        "izin": 1,
        "cuti": 0,
        "sakit": 1,
        "total": 22,
      },

      {
        "name": "Guru PAUD",
        "hadir": 18,
        "izin": 2,
        "cuti": 1,
        "sakit": 1,
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

          "Rekap Guru",

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
                    "Cari nama guru...",

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
                    teachers.length,

                itemBuilder:
                    (context, index) {

                  final item =
                      teachers[index];

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

                      boxShadow: [

                        BoxShadow(
                          color: Colors
                              .black
                              .withOpacity(
                                  0.05),

                          blurRadius:
                              6,

                          offset:
                              const Offset(
                                  0,
                                  4),
                        ),
                      ],
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
                              "Cuti",
                              item[
                                      'cuti']
                                  .toString(),
                              Colors.blue,
                            ),

                            _info(
                              "Sakit",
                              item[
                                      'sakit']
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
                                          RekapTeacherDetailScreen(
                                    teacher:
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