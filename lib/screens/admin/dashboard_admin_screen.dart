import 'package:flutter/material.dart';

import '../../services/admin/admin_service.dart';

import '../auth/login_screen.dart';

import 'teacher/teacher_screen.dart';
import 'student/student_screen.dart';
import 'payment/payment_screen.dart';

import 'profile/profile_screen.dart';
import 'program/program_screen.dart';
import 'structure/structure_screen.dart';
import 'gallery/gallery_screen.dart';

import 'rekap/rekap_screen.dart';

class DashboardAdminScreen
    extends StatefulWidget {

  const DashboardAdminScreen({
    super.key,
  });

  @override
  State<DashboardAdminScreen>
      createState() =>
          _DashboardAdminScreenState();
}

class _DashboardAdminScreenState
    extends State<DashboardAdminScreen> {

  int totalTeacher = 0;
  int totalStudent = 0;
  int totalPayment = 0;
  int totalGallery = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getDashboard();
  }

  Future<void> getDashboard() async {

    try {

      final result =
          await AdminService()
              .getDashboard();

      print(result);

      setState(() {

        totalTeacher =
            result['total_teacher'];

        totalStudent =
            result['total_student'];

        totalPayment =
            result['total_payment'];

        totalGallery =
            result['total_gallery'];

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

      /// APPBAR
      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        elevation: 0,

        title: const Text(

          "SIPARI ADMIN",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      /// DRAWER
      drawer: Drawer(

        child: ListView(

          padding: EdgeInsets.zero,

          children: [

            /// HEADER
            DrawerHeader(

              decoration:
                  const BoxDecoration(
                color: Colors.teal,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: const [

                  CircleAvatar(

                    radius: 28,

                    backgroundColor:
                        Colors.white,

                    child: Icon(

                      Icons
                          .admin_panel_settings,

                      color: Colors.teal,

                      size: 32,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(

                    "Admin SIPARI",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(

                    "KB Raudlotul Ilmi",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            /// DASHBOARD
            ListTile(

              leading:
                  const Icon(
                Icons.dashboard,
              ),

              title:
                  const Text(
                "Dashboard",
              ),

              onTap: () {

                Navigator.pop(
                    context);
              },
            ),

            /// GURU
            ListTile(

              leading:
                  const Icon(
                Icons.person,
              ),

              title:
                  const Text(
                "Guru",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const TeacherScreen(),
                  ),
                );
              },
            ),

            /// SISWA
            ListTile(

              leading:
                  const Icon(
                Icons.school,
              ),

              title:
                  const Text(
                "Siswa",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const StudentScreen(),
                  ),
                );
              },
            ),

            /// REKAP
            ListTile(

              leading:
                  const Icon(
                Icons.fact_check,
              ),

              title:
                  const Text(
                "Rekap Presensi",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const RekapScreen(),
                  ),
                );
              },
            ),

            /// PEMBAYARAN
            ListTile(

              leading:
                  const Icon(
                Icons.payment,
              ),

              title:
                  const Text(
                "Pembayaran",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const PaymentScreen(),
                  ),
                );
              },
            ),

            const Divider(),

            /// WEBSITE
            const Padding(

              padding: EdgeInsets.only(
                left: 16,
                top: 8,
                bottom: 8,
              ),

              child: Text(

                "WEBSITE",

                style: TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  color: Colors.grey,
                ),
              ),
            ),

            /// PROFIL
            ListTile(

              leading:
                  const Icon(
                Icons.home,
              ),

              title:
                  const Text(
                "Profil",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const ProfileScreen(),
                  ),
                );
              },
            ),

            /// PROGRAM
            ListTile(

              leading:
                  const Icon(
                Icons.menu_book,
              ),

              title:
                  const Text(
                "Program",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const ProgramScreen(),
                  ),
                );
              },
            ),

            /// STRUKTUR
            ListTile(

              leading:
                  const Icon(
                Icons.account_tree,
              ),

              title:
                  const Text(
                "Struktur",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const StructureScreen(),
                  ),
                );
              },
            ),

            /// GALERI
            ListTile(

              leading:
                  const Icon(
                Icons.photo,
              ),

              title:
                  const Text(
                "Galeri",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const GalleryScreen(),
                  ),
                );
              },
            ),

            const Divider(),

            /// LOGOUT
            ListTile(

              leading: const Icon(

                Icons.logout,

                color: Colors.red,
              ),

              title: const Text(

                "Logout",

                style: TextStyle(
                  color: Colors.red,
                ),
              ),

              onTap: () {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      /// BODY
      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  /// HERO
                  Stack(

                    children: [

                      Container(

                        height: 230,

                        width:
                            double.infinity,

                        decoration:
                            const BoxDecoration(

                          image:
                              DecorationImage(

                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9',
                            ),

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Container(

                        height: 230,

                        color: Colors.black
                            .withOpacity(
                                0.45),
                      ),

                      const Positioned(

                        left: 24,

                        bottom: 24,

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(

                              "Dashboard Admin",

                              style: TextStyle(

                                color:
                                    Colors.white,

                                fontSize: 34,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(

                              "KB Raudlotul Ilmi",

                              style: TextStyle(

                                color:
                                    Colors.white70,

                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// CONTENT
                  Padding(

                    padding:
                        const EdgeInsets.all(
                            20),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const Text(

                          "Ringkasan Sistem",

                          style: TextStyle(

                            fontSize: 22,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height: 20),

                        Row(

                          children: [

                            Expanded(

                              child:
                                  _buildCard(

                                title:
                                    "Guru",

                                total:
                                    totalTeacher
                                        .toString(),

                                icon:
                                    Icons.person,
                              ),
                            ),

                            const SizedBox(
                                width: 16),

                            Expanded(

                              child:
                                  _buildCard(

                                title:
                                    "Siswa",

                                total:
                                    totalStudent
                                        .toString(),

                                icon:
                                    Icons.school,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 16),

                        Row(

                          children: [

                            Expanded(

                              child:
                                  _buildCard(

                                title:
                                    "Pembayaran",

                                total:
                                    totalPayment
                                        .toString(),

                                icon:
                                    Icons.payment,
                              ),
                            ),

                            const SizedBox(
                                width: 16),

                            Expanded(

                              child:
                                  _buildCard(

                                title:
                                    "Galeri",

                                total:
                                    totalGallery
                                        .toString(),

                                icon:
                                    Icons.photo,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCard({

    required String title,

    required String total,

    required IconData icon,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(
              18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
                18),

        boxShadow: [

          BoxShadow(

            color: Colors.black
                .withOpacity(0.05),

            blurRadius: 8,

            offset:
                const Offset(
                    0,
                    4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(

            icon,

            color: Colors.teal,

            size: 32,
          ),

          const SizedBox(
              height: 16),

          Text(

            total,

            style: const TextStyle(

              fontSize: 28,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 4),

          Text(

            title,

            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}