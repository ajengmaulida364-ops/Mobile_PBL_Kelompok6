import 'package:flutter/material.dart';

import 'detail_teacher_screen.dart';
import 'edit_teacher_screen.dart';
import 'add_teacher_screen.dart';

import '../../../services/admin/teacher_service.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() =>
      _TeacherScreenState();
}

class _TeacherScreenState
    extends State<TeacherScreen> {

  List teachers = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getTeachers();
  }

  Future<void> getTeachers() async {

    try {

      final result =
          await TeacherService()
              .getTeachers();

      print(result);

      setState(() {

        teachers = result;

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

        backgroundColor: Colors.teal,

        elevation: 0,

        title: const Text(

          "Data Guru",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// TAMBAH GURU
      floatingActionButton:
          FloatingActionButton(

        backgroundColor: Colors.orange,

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  const AddTeacherScreen(),
            ),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : teachers.isEmpty

              ? const Center(

                  child: Text(

                    "Data guru kosong",

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )

              : RefreshIndicator(

                  onRefresh: getTeachers,

                  child: ListView.builder(

                    padding:
                        const EdgeInsets.all(
                            16),

                    itemCount:
                        teachers.length,

                    itemBuilder:
                        (context, index) {

                      final teacher =
                          teachers[index];

                      return Container(

                        margin:
                            const EdgeInsets.only(
                                bottom: 16),

                        padding:
                            const EdgeInsets.all(
                                16),

                        decoration:
                            BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      16),

                          boxShadow: [

                            BoxShadow(
                              color: Colors
                                  .black
                                  .withValues(
                                      alpha:
                                          0.05),

                              blurRadius: 6,

                              offset:
                                  const Offset(
                                      0, 4),
                            ),
                          ],
                        ),

                        child: Row(

                          children: [

                            /// AVATAR
                            const CircleAvatar(

                              radius: 28,

                              backgroundColor:
                                  Colors.teal,

                              child: Icon(
                                Icons.person,
                                color: Colors
                                    .white,
                              ),
                            ),

                            const SizedBox(
                                width: 16),

                            /// CONTENT
                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  /// NAMA
                                  Text(

                                    teacher['name']
                                        .toString(),

                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize:
                                          16,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  /// EMAIL
                                  Row(

                                    children: [

                                      Icon(
                                        Icons
                                            .email,
                                        size:
                                            16,
                                        color: Colors
                                                .grey[
                                            600],
                                      ),

                                      const SizedBox(
                                          width:
                                              6),

                                      Expanded(

                                        child:
                                            Text(

                                          teacher[
                                                  'email']
                                              .toString(),

                                          style:
                                              TextStyle(
                                            color:
                                                Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  /// ROLE
                                  Row(

                                    children: [

                                      Icon(
                                        Icons
                                            .badge,
                                        size:
                                            16,
                                        color: Colors
                                                .grey[
                                            600],
                                      ),

                                      const SizedBox(
                                          width:
                                              6),

                                      Text(

                                        teacher[
                                                'role']
                                            .toString(),

                                        style:
                                            TextStyle(
                                          color:
                                              Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  /// CLASS
                                  Row(

                                    children: [

                                      Icon(
                                        Icons
                                            .school,
                                        size:
                                            16,
                                        color: Colors
                                                .grey[
                                            600],
                                      ),

                                      const SizedBox(
                                          width:
                                              6),

                                      Text(

                                        teacher[
                                                'class']
                                            .toString(),

                                        style:
                                            TextStyle(
                                          color:
                                              Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// MENU
                            PopupMenuButton(

                              itemBuilder:
                                  (context) => [

                                const PopupMenuItem(
                                  value:
                                      'detail',
                                  child: Text(
                                      "Detail"),
                                ),

                                const PopupMenuItem(
                                  value:
                                      'edit',
                                  child: Text(
                                      "Edit"),
                                ),

                                const PopupMenuItem(
                                  value:
                                      'delete',
                                  child: Text(
                                      "Hapus"),
                                ),
                              ],

                              onSelected:
                                  (value) {

                                /// DETAIL
                                if (value ==
                                    'detail') {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              DetailTeacherScreen(
                                        teacher:
                                            teacher,
                                      ),
                                    ),
                                  );
                                }

                                /// EDIT
                                if (value ==
                                    'edit') {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              EditTeacherScreen(
                                        teacher:
                                            teacher,
                                      ),
                                    ),
                                  );
                                }

                                /// DELETE
                                if (value ==
                                    'delete') {

                                  showDialog(

                                    context:
                                        context,

                                    builder:
                                        (context) {

                                      return AlertDialog(

                                        title:
                                            const Text(
                                          "Hapus Guru",
                                        ),

                                        content:
                                            const Text(
                                          "Yakin ingin menghapus guru ini?",
                                        ),

                                        actions: [

                                          TextButton(

                                            onPressed:
                                                () {

                                              Navigator.pop(
                                                  context);
                                            },

                                            child:
                                                const Text(
                                              "Batal",
                                            ),
                                          ),

                                          ElevatedButton(

                                            style:
                                                ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red,
                                            ),

                                            onPressed:
                                                () {

                                              Navigator.pop(
                                                  context);

                                              ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(

                                                const SnackBar(
                                                  content:
                                                      Text(
                                                    "Guru berhasil dihapus",
                                                  ),
                                                ),
                                              );
                                            },

                                            child:
                                                const Text(
                                              "Hapus",
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}