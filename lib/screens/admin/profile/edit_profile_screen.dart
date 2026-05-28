import 'package:flutter/material.dart';

import '../../../../services/admin/profile_service.dart';

class EditProfileScreen
    extends StatefulWidget {

  final Map profile;

  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfileScreen>
      createState() =>
          _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  late TextEditingController
      titleController;

  late TextEditingController
      descriptionController;

  late TextEditingController
      emailController;

  late TextEditingController
      phoneController;

  late TextEditingController
      addressController;

  late TextEditingController
      visionController;

  late TextEditingController
      missionController;

  bool isLoading = false;

  @override
  void initState() {

    super.initState();

    titleController =
        TextEditingController(
      text:
          widget.profile['title'] ??
              '',
    );

    descriptionController =
        TextEditingController(
      text:
          widget.profile[
                  'description'] ??
              '',
    );

    emailController =
        TextEditingController(
      text:
          widget.profile['email'] ??
              '',
    );

    phoneController =
        TextEditingController(
      text:
          widget.profile['phone'] ??
              '',
    );

    addressController =
        TextEditingController(
      text:
          widget.profile[
                  'address'] ??
              '',
    );

    visionController =
        TextEditingController(
      text:
          widget.profile['vision'] ??
              '',
    );

    missionController =
        TextEditingController(
      text:
          widget.profile[
                  'mission'] ??
              '',
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
              0xffF5F7FA),

      appBar: AppBar(

        backgroundColor:
            Colors.teal,

        elevation: 0,

        title: const Text(

          "Edit Profil",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(
                20),

        child: Container(

          padding:
              const EdgeInsets.all(
                  20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
                    20),

            boxShadow: [

              BoxShadow(

                color: Colors.black
                    .withOpacity(
                        0.05),

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
                CrossAxisAlignment
                    .start,

            children: [

              const Text(

                "Edit Profil Sekolah",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 8),

              Text(

                "Perbarui informasi sekolah.",

                style: TextStyle(
                  color:
                      Colors.grey[700],
                ),
              ),

              const SizedBox(
                  height: 30),

              _label(
                  "Nama Sekolah"),

              _input(
                controller:
                    titleController,
                hint:
                    "Nama sekolah",
              ),

              const SizedBox(
                  height: 20),

              _label("Deskripsi"),

              _textarea(
                controller:
                    descriptionController,
                hint:
                    "Deskripsi sekolah",
              ),

              const SizedBox(
                  height: 20),

              _label("Email"),

              _input(
                controller:
                    emailController,
                hint:
                    "Email sekolah",
              ),

              const SizedBox(
                  height: 20),

              _label(
                  "Nomor Telepon"),

              _input(
                controller:
                    phoneController,
                hint:
                    "08xxxxxxxxxx",
              ),

              const SizedBox(
                  height: 20),

              _label("Alamat"),

              _textarea(
                controller:
                    addressController,
                hint:
                    "Alamat sekolah",
              ),

              const SizedBox(
                  height: 20),

              _label("Visi"),

              _textarea(
                controller:
                    visionController,
                hint:
                    "Visi sekolah",
              ),

              const SizedBox(
                  height: 20),

              _label("Misi"),

              _textarea(
                controller:
                    missionController,
                hint:
                    "Misi sekolah",
              ),

              const SizedBox(
                  height: 30),

              SizedBox(

                width:
                    double.infinity,

                height: 52,

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton
                          .styleFrom(

                    backgroundColor:
                        Colors.orange,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              14),
                    ),
                  ),

                  onPressed:
                      isLoading
                          ? null
                          : () async {

                              try {

                                setState(() {

                                  isLoading =
                                      true;
                                });

                                await ProfileService()
                                    .updateProfile(

                                  title:
                                      titleController
                                          .text,

                                  description:
                                      descriptionController
                                          .text,

                                  email:
                                      emailController
                                          .text,

                                  phone:
                                      phoneController
                                          .text,

                                  address:
                                      addressController
                                          .text,

                                  vision:
                                      visionController
                                          .text,

                                  mission:
                                      missionController
                                          .text,
                                );

                                if (!mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(

                                  const SnackBar(

                                    content:
                                        Text(
                                      "Profil berhasil diupdate",
                                    ),
                                  ),
                                );

                                Navigator.pop(
                                  context,
                                  true,
                                );

                              } catch (e) {

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(

                                  SnackBar(

                                    content:
                                        Text(
                                      "Error: $e",
                                    ),
                                  ),
                                );

                              } finally {

                                if (mounted) {

                                  setState(() {

                                    isLoading =
                                        false;
                                  });
                                }
                              }
                            },

                  child: isLoading

                      ? const SizedBox(

                          height: 24,
                          width: 24,

                          child:
                              CircularProgressIndicator(

                            color:
                                Colors.white,

                            strokeWidth:
                                2,
                          ),
                        )

                      : const Text(

                          "Update Profil",

                          style:
                              TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(
    String title,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 8),

      child: Text(

        title,

        style: const TextStyle(

          fontWeight:
              FontWeight.bold,

          fontSize: 15,
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

        fillColor:
            const Color(
                0xffF9FAFB),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  14),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }

  Widget _textarea({

    required TextEditingController
        controller,

    required String hint,
  }) {

    return TextField(

      controller: controller,

      maxLines: 5,

      decoration: InputDecoration(

        hintText: hint,

        filled: true,

        fillColor:
            const Color(
                0xffF9FAFB),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  14),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}