import 'package:flutter/material.dart';

class AddProfileScreen
    extends StatefulWidget {

  const AddProfileScreen({
    super.key,
  });

  @override
  State<AddProfileScreen>
      createState() =>
          _AddProfileScreenState();
}

class _AddProfileScreenState
    extends State<AddProfileScreen> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  final visionController =
      TextEditingController();

  final missionController =
      TextEditingController();

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

          "Tambah Profil",

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
                CrossAxisAlignment
                    .start,

            children: [

              const Text(

                "Tambah Profil Sekolah",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 8),

              Text(

                "Tambahkan informasi profil sekolah.",

                style: TextStyle(
                  color:
                      Colors.grey[700],
                ),
              ),

              const SizedBox(
                  height: 30),

              /// NAMA SEKOLAH
              _label(
                "Nama Sekolah",
              ),

              _input(
                controller:
                    titleController,
                hint:
                    "Nama sekolah",
              ),

              const SizedBox(
                  height: 20),

              /// DESKRIPSI
              _label(
                "Deskripsi",
              ),

              _textarea(
                controller:
                    descriptionController,
                hint:
                    "Deskripsi sekolah",
              ),

              const SizedBox(
                  height: 20),

              /// EMAIL
              _label(
                "Email",
              ),

              _input(
                controller:
                    emailController,
                hint:
                    "Email sekolah",
              ),

              const SizedBox(
                  height: 20),

              /// PHONE
              _label(
                "Nomor Telepon",
              ),

              _input(
                controller:
                    phoneController,
                hint:
                    "08xxxxxxxxxx",
              ),

              const SizedBox(
                  height: 20),

              /// ADDRESS
              _label(
                "Alamat",
              ),

              _textarea(
                controller:
                    addressController,
                hint:
                    "Alamat sekolah",
              ),

              const SizedBox(
                  height: 20),

              /// VISION
              _label(
                "Visi",
              ),

              _textarea(
                controller:
                    visionController,
                hint:
                    "Visi sekolah",
              ),

              const SizedBox(
                  height: 20),

              /// MISSION
              _label(
                "Misi",
              ),

              _textarea(
                controller:
                    missionController,
                hint:
                    "Misi sekolah",
              ),

              const SizedBox(
                  height: 30),

              /// BUTTON
              SizedBox(

                width:
                    double.infinity,

                height: 52,

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.orange,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              14),
                    ),
                  ),

                  onPressed: () {

                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Profil berhasil disimpan",
                        ),
                      ),
                    );
                  },

                  child: const Text(

                    "Simpan Profil",

                    style: TextStyle(
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