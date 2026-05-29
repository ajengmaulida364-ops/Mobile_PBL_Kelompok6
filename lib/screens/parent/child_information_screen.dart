import 'package:flutter/material.dart';

import '../../services/parent/profile_service.dart';

class ChildInformationScreen extends StatefulWidget {
  const ChildInformationScreen({super.key});

  @override
  State<ChildInformationScreen> createState() =>
      _ChildInformationScreenState();
}

class _ChildInformationScreenState
    extends State<ChildInformationScreen> {

  late Future<Map<String, dynamic>> profileFuture;

  @override
  void initState() {
    super.initState();

    profileFuture =
        ProfileService().getProfile();
  }

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

      body: FutureBuilder<Map<String, dynamic>>(

        future: profileFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Belum ada data profile",
              ),
            );
          }

          final profile = snapshot.data!;

          return SingleChildScrollView(
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

                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Column(
                    children: [

                      const Icon(
                        Icons.child_care,
                        size: 60,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        profile['name'] ?? '-',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        profile['class'] ?? '-',

                        style: const TextStyle(
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
                  value: profile['name'] ?? '-',
                ),

                infoCard(
                  icon: Icons.credit_card,
                  title: "NISN",
                  value: profile['nisn'] ?? '-',
                ),

                infoCard(
                  icon: Icons.school,
                  title: "Kelas",
                  value: profile['class'] ?? '-',
                ),

                infoCard(
                  icon: Icons.person,
                  title: "Jenis Kelamin",
                  value: profile['gender'] ?? '-',
                ),

                infoCard(
                  icon: Icons.family_restroom,
                  title: "Nama Orang Tua",
                  value: profile['parent_name'] ?? '-',
                ),

                infoCard(
                  icon: Icons.phone,
                  title: "Telepon Orang Tua",
                  value: profile['parent_phone'] ?? '-',
                ),

                infoCard(
                  icon: Icons.home,
                  title: "Alamat",
                  value: profile['address'] ?? '-',
                ),
              ],
            ),
          );
        },
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
            color:
                Colors.grey.withValues(alpha: 0.1),

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
              color:
                  Colors.teal.withOpacity(0.1),

              borderRadius:
                  BorderRadius.circular(12),
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