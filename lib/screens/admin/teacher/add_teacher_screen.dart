import 'package:flutter/material.dart';

import '../../../services/admin/class_service.dart';
import '../../../services/admin/teacher_service.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() =>
      _AddTeacherScreenState();
}

class _AddTeacherScreenState
    extends State<AddTeacherScreen> {
  final nameController =
      TextEditingController();

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final nipController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  String selectedClass = '';

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

      if (!mounted) return;

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

      if (!mounted) return;

      setState(() {
        isLoadingClass = false;
      });
    }
  }

  Future<void> saveTeacher() async {
    final result =
        await TeacherService()
            .createTeacher(
      name:
          nameController.text.trim(),
      username:
          usernameController.text
              .trim(),
      password:
          passwordController.text
              .trim(),
      classId: selectedClass,
      nip:
          nipController.text.trim(),
      phone:
          phoneController.text.trim(),
      address:
          addressController.text
              .trim(),
    );

    if (!mounted) return;

    if (result) {
      Navigator.pop(
        context,
        true,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Gagal menyimpan guru",
          ),
        ),
      );
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
          "Tambah Guru",
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [
            const Text(
              "Tambah Guru",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            _label("Nama"),

            _input(
              controller:
                  nameController,
              hint:
                  "Nama lengkap guru",
            ),

            const SizedBox(
              height: 20,
            ),

            _label("Username"),

            _input(
              controller:
                  usernameController,
              hint:
                  "Username login",
            ),

            const SizedBox(
              height: 20,
            ),

            _label("Password"),

            _input(
              controller:
                  passwordController,
              hint: "Password",
              obscure: true,
            ),

            const SizedBox(
              height: 20,
            ),

            _label("Kelas"),

            isLoadingClass
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : Wrap(
                    spacing: 10,
                    children: classes
                        .map((kelas) {
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
                        labelStyle:
                            TextStyle(
                          color: selectedClass ==
                                  kelas['id']
                                      .toString()
                              ? Colors.white
                              : Colors.black,
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
                    }).toList(),
                  ),

            const SizedBox(
              height: 20,
            ),

            _label("NIP"),

            _input(
              controller:
                  nipController,
              hint: "NIP",
            ),

            const SizedBox(
              height: 20,
            ),

            _label("Telepon"),

            _input(
              controller:
                  phoneController,
              hint: "08xxxx",
            ),

            const SizedBox(
              height: 20,
            ),

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
                    14,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

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
                      14,
                    ),
                  ),
                ),
                onPressed:
                    saveTeacher,
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        text,
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
      decoration:
          InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),
          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}