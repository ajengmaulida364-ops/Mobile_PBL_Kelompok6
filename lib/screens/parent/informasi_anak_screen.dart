import 'package:flutter/material.dart';

class InformasiAnakScreen extends StatelessWidget {
  const InformasiAnakScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Informasi Anak",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// CARD PROFILE ANAK
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

                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.child_care,
                    size: 60,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "AFLAHUL EL ZEHAN",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Kelas A",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// DETAIL INFORMASI

            infoCard(
              icon: Icons.badge,
              title: "Nama",
              value: "AFLAHUL EL ZEHAN",
            ),

            infoCard(
              icon: Icons.credit_card,
              title: "NISN",
              value: "3221935788",
            ),

            infoCard(
              icon: Icons.school,
              title: "Kelas",
              value: "A",
            ),

            infoCard(
              icon: Icons.person,
              title: "Jenis Kelamin",
              value: "Laki-laki",
            ),

            infoCard(
              icon: Icons.family_restroom,
              title: "Nama Orang Tua",
              value: "SUPINIK",
            ),

            infoCard(
              icon: Icons.phone,
              title: "Telepon Orang Tua",
              value: "081234567890",
            ),

            infoCard(
              icon: Icons.home,
              title: "Alamat",
              value: "PASINAN TIMUR",
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [

          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),

            blurRadius: 6,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.teal,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}