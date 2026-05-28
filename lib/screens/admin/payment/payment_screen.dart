import 'package:flutter/material.dart';

import '../../../services/admin/payment_service.dart';

import 'payment_detail_screen.dart';

class PaymentScreen
    extends StatefulWidget {

  const PaymentScreen({
    super.key,
  });

  @override
  State<PaymentScreen>
      createState() =>
          _PaymentScreenState();
}

class _PaymentScreenState
    extends State<PaymentScreen> {

  bool isLoading = true;

  List students = [];

  @override
  void initState() {
    super.initState();

    getStudents();
  }

  Future<void> getStudents() async {

    try {

      final result =
          await PaymentService()
              .getStudents();

      setState(() {

        students = result;

        isLoading = false;
      });

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

          "Pembayaran",

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

          : ListView.builder(

              padding:
                  const EdgeInsets
                      .all(16),

              itemCount:
                  students.length,

              itemBuilder:
                  (context, index) {

                final student =
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

                    boxShadow: [

                      BoxShadow(

                        color: Colors
                            .black
                            .withOpacity(
                                0.05),

                        blurRadius:
                            8,

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

                        student['name']
                            .toString(),

                        style:
                            const TextStyle(

                          fontSize: 18,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height:
                              8),

                      Text(
                        "NISN : ${student['nisn']}",
                      ),

                      const SizedBox(
                          height:
                              6),

                      Text(
                        "Kelas : ${student['class'] ?? '-'}",
                      ),

                      const SizedBox(
                          height:
                              18),

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
                                        PaymentDetailScreen(
                                  studentId:
                                      student[
                                          'id'],
                                ),
                              ),
                            );
                          },

                          child:
                              const Text(
                            "Lihat",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}