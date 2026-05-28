import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

import 'informasi_anak_screen.dart';
import 'kegiatan_anak_screen.dart';
import 'perkembangan_anak_screen.dart';
import 'pembayaran_anak_screen.dart';

class DashboardParentScreen extends StatelessWidget {
  const DashboardParentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> menus = [

      {
        "title": "Informasi Anak",
        "subtitle": "Data lengkap anak Anda",
        "icon": Icons.child_care,
      },

      {
        "title": "Kegiatan Anak",
        "subtitle": "Kegiatan harian anak",
        "icon": Icons.menu_book,
      },

      {
        "title": "Perkembangan",
        "subtitle": "Perkembangan anak",
        "icon": Icons.trending_up,
      },

      {
        "title": "Pembayaran",
        "subtitle": "Informasi pembayaran",
        "icon": Icons.payment,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Dashboard Orang Tua",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: ElevatedButton(
              onPressed: () {

                Navigator.pushReplacement(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: const Text(
                "Logout",

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.teal,

                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: const [

                  Text(
                    "KB Raudlotul Ilmi",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Selamat datang, Orang Tua 👋",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Menu Orang Tua",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            /// GRID MENU
            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: menus.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 16,
                mainAxisSpacing: 16,

                childAspectRatio: 1.1,
              ),

              itemBuilder: (context, index) {

                final menu = menus[index];

                return InkWell(

                  onTap: () {

                    /// INFORMASI ANAK
                    if (index == 0) {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const InformasiAnakScreen(),
                        ),
                      );
                    }

                    /// KEGIATAN ANAK
                    else if (index == 1) {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const KegiatanAnakScreen(),
                        ),
                      );
                    }

                    /// PERKEMBANGAN
                    else if (index == 2) {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const PerkembanganScreen(),
                        ),
                      );
                    }

                    /// PEMBAYARAN
                    else if (index == 3) {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const PembayaranScreen(),
                        ),
                      );
                    }
                  },

                  child: Container(
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

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Icon(
                          menu['icon'],

                          size: 32,
                          color: Colors.teal,
                        ),

                        const Spacer(),

                        Text(
                          menu['title'],

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          menu['subtitle'],

                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}