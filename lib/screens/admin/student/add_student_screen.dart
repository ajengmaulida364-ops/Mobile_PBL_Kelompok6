import 'package:flutter/material.dart';

import '../../../services/admin/class_service.dart';

class AddStudentScreen
    extends StatefulWidget {

  const AddStudentScreen({
    super.key,
  });

  @override
  State<AddStudentScreen>
      createState() =>
          _AddStudentScreenState();
}

class _AddStudentScreenState
    extends State<AddStudentScreen> {

  final nameController =
      TextEditingController();

  final nisnController =
      TextEditingController();

  final parentNameController =
      TextEditingController();

  final parentPhoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  String selectedGender =
      'Laki-laki';

  String selectedClass = '';

  bool isActive = true;

  bool isLoadingClass = true;

  List classes = [];

  @override
  void initState() {
    super.initState();

    getClasses();
  }

  Future<void> getClasses() async {

    try {

      final result =
          await ClassService()
              .getClasses();

      setState(() {

        classes = result;

        if (classes.isNotEmpty) {

          selectedClass =
              classes[0]['id']
                  .toString();
        }

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

        backgroundColor: Colors.teal,

        title: const Text(

          "Tambah Siswa",

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

              "Tambah Siswa",

              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              "Isi data siswa untuk kebutuhan presensi & laporan.",

              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 30),

            _label("Nama"),

            _input(
              controller:
                  nameController,
              hint:
                  "Nama lengkap siswa",
            ),

            const SizedBox(height: 20),

            _label("NISN"),

            _input(
              controller:
                  nisnController,
              hint:
                  "NISN siswa",
            ),

            const SizedBox(height: 20),

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
                              kelas['id']
                                  .toString(),

                          selectedColor:
                              Colors.teal,

                          labelStyle:
                              TextStyle(

                            color:
                                selectedClass ==
                                        kelas['id']
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
                                  kelas['id']
                                      .toString();
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),

            const SizedBox(height: 20),

            _label("Nama Orang Tua"),

            _input(
              controller:
                  parentNameController,
              hint:
                  "Nama orang tua",
            ),

            const SizedBox(height: 20),

            _label("Telepon Orang Tua"),

            _input(
              controller:
                  parentPhoneController,
              hint:
                  "08xxxxxxxxxx",
            ),

            const SizedBox(height: 20),

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
                    "Tambah Siswa",
                  );
                },

                child: const Text(

                  "Simpan",

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