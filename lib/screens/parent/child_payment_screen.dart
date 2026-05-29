import 'package:flutter/material.dart';
import '../../services/parent/payment_service.dart';

class ChildPaymentScreen extends StatefulWidget {
  const ChildPaymentScreen({super.key});

  @override
  State<ChildPaymentScreen> createState() =>
      _ChildPaymentScreenState();
}

class _ChildPaymentScreenState
    extends State<ChildPaymentScreen> {

  late Future<List<dynamic>> paymentsFuture;

  @override
  void initState() {
    super.initState();

    paymentsFuture =
        PaymentService().getPayments();
  }

  @override
  Widget build(BuildContext context) {

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
            FutureBuilder<List<dynamic>>(
              future: paymentsFuture,

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {

                  return const Center(
                    child: Text(
                      "Belum ada pembayaran",
                    ),
                  );
                }

                final payments = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount: payments.length,

                  itemBuilder: (context, index) {

                    final item = payments[index];

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),

                      padding:
                          const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(16),

                        boxShadow: [

                          BoxShadow(
                            color: Colors.grey
                                .withValues(
                                    alpha: 0.1),

                            blurRadius: 6,

                            offset:
                                const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          Container(
                            padding:
                                const EdgeInsets.all(
                                    12),

                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withValues(
                                      alpha: 0.1),

                              borderRadius:
                                  BorderRadius.circular(
                                      12),
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
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                  item['bulan']
                                      .toString(),

                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                const SizedBox(
                                    height: 6),

                                Text(
                                  item['jumlah']
                                      .toString(),

                                  style: TextStyle(
                                    color:
                                        Colors.grey[700],
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),

                            decoration:
                                BoxDecoration(
                              color: Colors.green
                                  .withValues(
                                      alpha: 0.1),

                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),

                            child: Text(
                              item['status']
                                  .toString(),

                              style:
                                  const TextStyle(
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
      padding:
          const EdgeInsets.only(bottom: 14),

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