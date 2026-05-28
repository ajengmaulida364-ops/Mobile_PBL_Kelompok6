import 'package:flutter/material.dart';

import '../../../services/admin/student_service.dart';

import 'add_student_screen.dart';
import 'edit_student_screen.dart';
import 'detail_student_screen.dart';

class StudentScreen extends StatefulWidget {

  const StudentScreen({
    super.key,
  });

  @override
  State<StudentScreen> createState() =>
      _StudentScreenState();
}

class _StudentScreenState
    extends State<StudentScreen> {

  final searchController =
      TextEditingController();

  List students = [];

  List filteredStudents = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getStudents();
  }

  Future<void> getStudents() async {

    try {

      setState(() {

        isLoading = true;
      });

      final result =
          await StudentService()
              .getStudents();

      setState(() {

        students = result;

        filteredStudents =
            result;

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {

        isLoading = false;
      });
    }
  }

  void searchStudent(String keyword) {

    final result = students.where((student) {

      final name =
          student['name']
              ?.toString()
              .toLowerCase() ?? '';

      final nisn =
          student['nisn']
              ?.toString() ?? '';

      final parentName =
          student['parent_name']
              ?.toString()
              .toLowerCase() ?? '';

      return name.contains(
                keyword.toLowerCase(),
             ) ||

             nisn.contains(
                keyword,
             ) ||

             parentName.contains(
                keyword.toLowerCase(),
             );

    }).toList();

    setState(() {

      filteredStudents = result;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        elevation: 0,

        title: const Text(

          "Data Siswa",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            Colors.orange,

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  const AddStudentScreen(),
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

          : Column(

              children: [

                /// SEARCH
                Padding(

                  padding:
                      const EdgeInsets
                          .all(16),

                  child: TextField(

                    controller:
                        searchController,

                    onChanged:
                        searchStudent,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Cari nama / NISN / orang tua",

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
                ),

                /// LIST
                Expanded(

                  child:
                      filteredStudents
                              .isEmpty

                          ? const Center(

                              child: Text(
                                "Belum ada data siswa",
                              ),
                            )

                          : RefreshIndicator(

                              onRefresh:
                                  getStudents,

                              child:
                                  ListView.builder(

                                padding:
                                    const EdgeInsets
                                        .all(
                                            16),

                                itemCount:
                                    filteredStudents
                                        .length,

                                itemBuilder:
                                    (context,
                                        index) {

                                  final student =
                                      filteredStudents[
                                          index];

                                  final bool isActive =

                                      student['is_active'] == 1 ||

                                      student['is_active'] == true;

                                  return Container(

                                    margin:
                                        const EdgeInsets
                                            .only(
                                                bottom:
                                                    16),

                                    padding:
                                        const EdgeInsets
                                            .all(
                                                16),

                                    decoration:
                                        BoxDecoration(

                                      color: Colors
                                          .white,

                                      borderRadius:
                                          BorderRadius.circular(
                                              16),

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

                                    child:
                                        Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        /// HEADER
                                        Row(

                                          children: [

                                            const CircleAvatar(

                                              backgroundColor:
                                                  Colors.teal,

                                              child:
                                                  Icon(
                                                Icons
                                                    .school,
                                                color:
                                                    Colors.white,
                                              ),
                                            ),

                                            const SizedBox(
                                                width:
                                                    14),

                                            Expanded(

                                              child:
                                                  Column(

                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [

                                                  Text(

                                                    student['name']
                                                            ?.toString() ??
                                                        '-',

                                                    style:
                                                        const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,

                                                      fontSize:
                                                          16,
                                                    ),
                                                  ),

                                                  Text(

                                                    "NISN : ${student['nisn']?.toString() ?? '-'}",
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PopupMenuButton(

                                              itemBuilder:
                                                  (context) => [

                                                const PopupMenuItem(
                                                  value:
                                                      'detail',

                                                  child:
                                                      Text(
                                                    "Detail",
                                                  ),
                                                ),

                                                const PopupMenuItem(
                                                  value:
                                                      'edit',

                                                  child:
                                                      Text(
                                                    "Edit",
                                                  ),
                                                ),

                                                const PopupMenuItem(
                                                  value:
                                                      'delete',

                                                  child:
                                                      Text(
                                                    "Hapus",
                                                  ),
                                                ),
                                              ],

                                              onSelected:
                                                  (
                                                value,
                                              ) {

                                                if (value ==
                                                    'detail') {

                                                  Navigator.push(

                                                    context,

                                                    MaterialPageRoute(
                                                      builder:
                                                          (_) =>
                                                              DetailStudentScreen(
                                                        student:
                                                            student,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                if (value ==
                                                    'edit') {

                                                  Navigator.push(

                                                    context,

                                                    MaterialPageRoute(
                                                      builder:
                                                          (_) =>
                                                              EditStudentScreen(
                                                        student:
                                                            student,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                if (value ==
                                                    'delete') {

                                                  showDialog(

                                                    context:
                                                        context,

                                                    builder:
                                                        (
                                                      context,
                                                    ) {

                                                      return AlertDialog(

                                                        title:
                                                            const Text(
                                                          "Hapus Siswa",
                                                        ),

                                                        content:
                                                            const Text(
                                                          "Yakin ingin menghapus siswa ini?",
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
                                                                    "Siswa berhasil dihapus",
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

                                        const SizedBox(
                                            height:
                                                16),

                                        /// INFO
                                        Wrap(

                                          spacing:
                                              10,

                                          runSpacing:
                                              10,

                                          children: [

                                            _chip(

                                              student['gender']
                                                      ?.toString() ??
                                                  '-',
                                            ),

                                            _chip(

                                              "Kelas ${student['class']?.toString() ?? '-'}",
                                            ),

                                            _chip(

                                              student['parent_name']
                                                      ?.toString() ??
                                                  '-',
                                            ),

                                            _chip(

                                              student['parent_phone']
                                                      ?.toString() ??
                                                  '-',
                                            ),

                                            Container(

                                              padding:
                                                  const EdgeInsets.symmetric(

                                                horizontal: 12,

                                                vertical: 8,
                                              ),

                                              decoration:
                                                  BoxDecoration(

                                                color: isActive

                                                    ? Colors.green
                                                        .withOpacity(0.1)

                                                    : Colors.red
                                                        .withOpacity(0.1),

                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30),
                                              ),

                                              child: Text(

                                                isActive

                                                    ? "Aktif"

                                                    : "Nonaktif",

                                                style: TextStyle(

                                                  color: isActive

                                                      ? Colors.green

                                                      : Colors.red,

                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
    );
  }

  Widget _chip(String text) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      decoration: BoxDecoration(

        color:
            Colors.grey.shade200,

        borderRadius:
            BorderRadius.circular(
                30),
      ),

      child: Text(text),
    );
  }
}