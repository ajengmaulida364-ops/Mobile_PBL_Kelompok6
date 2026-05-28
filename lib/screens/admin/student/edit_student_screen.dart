import 'package:flutter/material.dart';

import '../../../services/admin/class_service.dart';

class EditStudentScreen
    extends StatefulWidget {

  final Map student;

  const EditStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentScreen>
      createState() =>
          _EditStudentScreenState();
}

class _EditStudentScreenState
    extends State<EditStudentScreen> {

  late TextEditingController
      nameController;

  late TextEditingController
      nisnController;

  late TextEditingController
      parentNameController;

  late TextEditingController
      parentPhoneController;

  late TextEditingController
      addressController;

  String selectedGender =
      'Laki-laki';

  String selectedClass = '';

  bool isActive = true;

  bool isLoadingClass = true;

  List classes = [];

  @override
  void initState() {
    super.initState();

    final student =
        widget.student;

    nameController =
        TextEditingController(
      text:
          student['name']
                  ?.toString() ??
              '',
    );

    nisnController =
        TextEditingController(
      text:
          student['nisn']
                  ?.toString() ??
              '',
    );

    parentNameController =
        TextEditingController(
      text:
          student['parent_name']
                  ?.toString() ??
              '',
    );

    parentPhoneController =
        TextEditingController(
      text:
          student['parent_phone']
                  ?.toString() ??
              '',
    );

    addressController =
        TextEditingController(
      text:
          student['address']
                  ?.toString() ??
              '',
    );

    selectedGender =
        student['gender']
                ?.toString() ??
            'Laki-laki';

    selectedClass =
        student['class']
                ?.toString() ??
            '';

    isActive =

        student['is_active'] == 1 ||

        student['is_active'] == true;

    getClasses();
  }

  Future<void> getClasses() async {

    try {

      final result =
          await ClassService()
              .getClasses();

      setState(() {

        classes = result;

        isLoadingClass = false;
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

          "Edit Siswa",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(

              "Edit Siswa",

              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              "Perbarui data siswa.",

              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 30),

            /// NAMA
            _label("Nama"),

            _input(
              controller:
                  nameController,
              hint:
                  "Nama lengkap siswa",
            ),

            const SizedBox(height: 20),

            /// NISN
            _label("NISN"),

            _input(
              controller:
                  nisnController,
              hint:
                  "NISN siswa",
            ),

            const SizedBox(height: 20),

            /// GENDER
            _label("Jenis Kelamin"),

            Row(

              children: [

                Expanded(

                  child: RadioListTile(

                    value:
                        'Laki-laki',

                    groupValue:
                        selectedGender,

                    title:
                        const Text(
                            "Laki-laki"),

                    activeColor:
                        Colors.teal,

                    onChanged:
                        (value) {

                      setState(() {

                        selectedGender =
                            value!;
                      });
                    },
                  ),
                ),

                Expanded(

                  child: RadioListTile(

                    value:
                        'Perempuan',

                    groupValue:
                        selectedGender,

                    title:
                        const Text(
                            "Perempuan"),

                    activeColor:
                        Colors.teal,

                    onChanged:
                        (value) {

                      setState(() {

                        selectedGender =
                            value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// KELAS
            _label("Kelas"),

            isLoadingClass

                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )

                : Wrap(

                    spacing: 10,

                    children:
                        classes.map(
                      (kelas) {

                        return ChoiceChip(

                          label: Text(
                            "Kelas ${kelas['name']}",
                          ),

                          selected:
                              selectedClass ==
                              kelas['name']
                                  .toString(),

                          selectedColor:
                              Colors.teal,

                          labelStyle:
                              TextStyle(

                            color:
                                selectedClass ==
                                        kelas['name']
                                            .toString()

                                    ? Colors
                                        .white

                                    : Colors
                                        .black,
                          ),

                          onSelected:
                              (value) {

                            setState(() {

                              selectedClass =
                                  kelas['name']
                                      .toString();
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),

            const SizedBox(height: 20),

            /// ORTU
            _label("Nama Orang Tua"),

            _input(
              controller:
                  parentNameController,
              hint:
                  "Nama orang tua",
            ),

            const SizedBox(height: 20),

            /// TELEPON
            _label("Telepon Orang Tua"),

            _input(
              controller:
                  parentPhoneController,
              hint:
                  "08xxxxxxxxxx",
            ),

            const SizedBox(height: 20),

            /// ALAMAT
            _label("Alamat"),

            TextField(

              controller:
                  addressController,

              maxLines: 4,

              decoration:
                  InputDecoration(

                hintText:
                    "Alamat siswa",

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

            const SizedBox(height: 20),

            /// STATUS
            Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(

                  "Status Aktif",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Switch(

                  value: isActive,

                  activeColor:
                      Colors.teal,

                  onChanged:
                      (value) {

                    setState(() {

                      isActive =
                          value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// BUTTON
            SizedBox(

              width: double.infinity,

              height: 52,

              child: ElevatedButton(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.orange,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius
                            .circular(
                                14),
                  ),
                ),

                onPressed: () {

                  print(
                    "Update Siswa",
                  );
                },

                child: const Text(

                  "Update",

                  style: TextStyle(
                    color:
                        Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String title) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 8),

      child: Text(

        title,

        style: const TextStyle(
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  Widget _input({

    required TextEditingController
        controller,

    required String hint,
  }) {

    return TextField(

      controller: controller,

      decoration: InputDecoration(

        hintText: hint,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}