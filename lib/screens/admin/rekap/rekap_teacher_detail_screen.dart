import 'package:flutter/material.dart';

import '../../../services/admin/rekap_service.dart';

class RekapTeacherDetailScreen
    extends StatefulWidget {

  final Map teacher;

  const RekapTeacherDetailScreen({
    super.key,
    required this.teacher,
  });

  @override
  State<RekapTeacherDetailScreen>
      createState() =>
          _RekapTeacherDetailScreenState();
}

class _RekapTeacherDetailScreenState
    extends State<
        RekapTeacherDetailScreen> {

  bool isLoading = true;

  List attendances = [];

  @override
  void initState() {

    super.initState();

    loadData();
  }

  Future<void> loadData()
  async {

    try {

      final data =
          await RekapService()
              .getDetailGuru(
        widget.teacher['id'],
      );

      setState(() {

        attendances =
            data[
                'attendances'];

        isLoading =
            false;
      });

    } catch (e) {

      print(e);

      setState(() {

        isLoading =
            false;
      });
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
              0xffF5F7FA),

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

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Padding(

              padding:
                  const EdgeInsets
                      .all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    widget.teacher[
                        'name'],

                    style:
                        const TextStyle(

                      fontSize:
                          22,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  Expanded(

                    child:
                        ListView.builder(

                      itemCount:
                          attendances
                              .length,

                      itemBuilder:
                          (
                        context,
                        index,
                      ) {

                        final item =
                            attendances[
                                index];

                        return Container(

                          margin:
                              const EdgeInsets
                                  .only(
                                      bottom:
                                          16),

                          padding:
                              const EdgeInsets
                                  .all(
                                      18),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),

                          child:
                              Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                item[
                                    'tanggal'],
                              ),

                              const SizedBox(
                                  height:
                                      10),

                              Text(
                                "Status : ${item['status']}",
                              ),

                              Text(
                                "Jam Masuk : ${item['jam_masuk']}",
                              ),

                              Text(
                                "Jam Pulang : ${item['jam_pulang']}",
                              ),

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