import 'package:flutter/material.dart';

import '../../../services/admin/payment_service.dart';

class PaymentDetailScreen
    extends StatefulWidget {

  final int studentId;

  const PaymentDetailScreen({
    super.key,
    required this.studentId,
  });

  @override
  State<PaymentDetailScreen>
      createState() =>
          _PaymentDetailScreenState();
}

class _PaymentDetailScreenState
    extends State<PaymentDetailScreen> {

  bool isLoading = true;

  Map student = {};

  List payments = [];

  @override
  void initState() {
    super.initState();

    getDetail();
  }

  Future<void> getDetail() async {

    try {

      final result =
          await PaymentService()
              .getPaymentDetail(
        widget.studentId,
      );

      setState(() {

        student =
            result['student'];

        payments =
            result['payments'];

        isLoading = false;
      });

    } catch (e) {

      print(e);
    }
  }

  Future<void> bayar({

    required String bulan,

    required int jumlah,
  }) async {

    try {

      await PaymentService().pay(

        studentId:
            widget.studentId,

        bulan: bulan,

        jumlah: jumlah,
      );

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Pembayaran berhasil",
          ),
        ),
      );

      getDetail();

    } catch (e) {

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        title: const Text(

          "Detail Pembayaran",

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

          : SingleChildScrollView(

              padding:
                  const EdgeInsets
                      .all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  /// INFO SISWA
                  Container(

                    width:
                        double.infinity,

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

                        const Text(

                          "Informasi Siswa",

                          style:
                              TextStyle(

                            fontSize:
                                18,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                16),

                        Text(
                          "Nama : ${student['name']}",
                        ),

                        const SizedBox(
                            height:
                                8),

                        Text(
                          "NISN : ${student['nisn']}",
                        ),

                        const SizedBox(
                            height:
                                8),

                        Text(
                          "Kelas : ${student['class'] ?? '-'}",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  const Text(

                    "Pembayaran Bulanan",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 16),

                  ...payments.map(

                    (payment) {

                      final bool lunas =

                          payment[
                                  'status'] ==
                              'lunas';

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

                              payment[
                                  'bulan'],

                              style:
                                  const TextStyle(

                                fontSize:
                                    18,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    8),

                            Text(

                              "Rp ${payment['jumlah']}",
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

                                color: lunas

                                    ? Colors
                                        .green
                                        .withOpacity(
                                            0.1)

                                    : Colors
                                        .red
                                        .withOpacity(
                                            0.1),

                                borderRadius:
                                    BorderRadius.circular(
                                        30),
                              ),

                              child: Text(

                                lunas

                                    ? "Lunas"

                                    : "Belum Bayar",

                                style:
                                    TextStyle(

                                  color: lunas

                                      ? Colors
                                          .green

                                      : Colors
                                          .red,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height:
                                    16),

                            if (!lunas)

                              SizedBox(

                                width:
                                    double
                                        .infinity,

                                child:
                                    ElevatedButton(

                                  style:
                                      ElevatedButton.styleFrom(

                                    backgroundColor:
                                        Colors.orange,
                                  ),

                                  onPressed:
                                      () {

                                    bayar(

                                      bulan:
                                          payment[
                                              'bulan'],

                                      jumlah:
                                          payment[
                                              'jumlah'],
                                    );
                                  },

                                  child:
                                      const Text(
                                    "Bayar",
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
    );
  }
}