import 'package:flutter/material.dart';

import '../../../services/admin/class_service.dart';

class AddTeacherScreen
    extends StatefulWidget {

  const AddTeacherScreen({
    super.key,
  });

  @override
  State<AddTeacherScreen>
      createState() =>
          _AddTeacherScreenState();
}

class _AddTeacherScreenState
    extends State<AddTeacherScreen> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final nipController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  String selectedRole =
      'teacher';

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

        elevation: 0,

        title: const Text(

          "Tambah Guru",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
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

              "Tambah Guru",

              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(

              "Isi data guru untuk disimpan ke sistem.",

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
                  "Nama lengkap guru",
            ),

            const SizedBox(height: 20),

            /// EMAIL
            _label("Email"),

            _input(
              controller:
                  emailController,
              hint: "Email guru",
            ),

            const SizedBox(height: 20),

            /// PASSWORD
            _label("Password"),

            _input(
              controller:
                  passwordController,
              hint: "Password akun",
              obscure: true,
            ),

            const SizedBox(height: 20),

            /// ROLE
            _label("Role"),

            Row(

              children: [

                Expanded(

                  child: RadioListTile(

                    value: 'teacher',

                    groupValue:
                        selectedRole,

                    activeColor:
                        Colors.teal,

                    title:
                        const Text(
                            "Guru"),

                    onChanged:
                        (value) {

                      setState(() {

                        selectedRole =
                            value!;

                        if (selectedRole ==
                            'operator') {

                          selectedClass =
                              '';
                        }
                      });
                    },
                  ),
                ),

                Expanded(

                  child: RadioListTile(

                    value: 'operator',

                    groupValue:
                        selectedRole,

                    activeColor:
                        Colors.teal,

                    title:
                        const Text(
                            "Operator"),

                    onChanged:
                        (value) {

                      setState(() {

                        selectedRole =
                            value!;

                        if (selectedRole ==
                            'operator') {

                          selectedClass =
                              '';
                        }
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
                            kelas['name']
                                .toString(),
                          ),

                          selected:
                              selectedClass ==
                              kelas['id']
                                  .toString(),

                          selectedColor:
                              Colors.teal,

                          disabledColor:
                              Colors.grey[
                                  300],

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
                              selectedRole ==
                                      'operator'

                                  ? null

                                  : (value) {

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

            /// NIP
            _label("NIP"),

            _input(
              controller:
                  nipController,
              hint:
                  "Nomor induk pegawai",
            ),

            const SizedBox(height: 20),

            /// PHONE
            _label("Telepon"),

            _input(
              controller:
                  phoneController,
              hint:
                  "08xxxxxxxxxx",
            ),

            const SizedBox(height: 20),

            /// ADDRESS
            _label("Alamat"),

            TextField(

              controller:
                  addressController,

              maxLines: 4,

              decoration:
                  InputDecoration(

                hintText:
                    "Alamat lengkap guru",

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

                  activeColor:
                      Colors.teal,

                  value: isActive,

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
                    "Tambah Guru",
                  );
                },

                child: const Text(

                  "Simpan",

                  style: TextStyle(
                    color:
                        Colors.white,

                    fontSize: 16,

                    fontWeight:
                        FontWeight.bold,
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

    bool obscure = false,
  }) {

    return TextField(

      controller: controller,

      obscureText: obscure,

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