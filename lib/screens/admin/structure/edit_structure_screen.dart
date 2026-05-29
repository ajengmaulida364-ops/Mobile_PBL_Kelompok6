import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStructureScreen
    extends StatefulWidget {

  const AddStructureScreen({
    super.key,
  });

  @override
  State<AddStructureScreen>
      createState() =>
          _AddStructureScreenState();
}

class _AddStructureScreenState
    extends State<AddStructureScreen> {

  final nameController =
      TextEditingController();

  final positionController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  String type = 'kepala';

  File? image;

  final picker = ImagePicker();

  bool isLoading = false;

  Future pickImage() async {

    final picked =
        await picker.pickImage(

      source:
          ImageSource.gallery,
    );

    if (picked != null) {

      setState(() {

        image = File(
          picked.path,
        );
      });
    }
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

        title: const Text(

          'Tambah Struktur',

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
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const Text(

                'Tambah Struktur',

                style: TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 8),

              Text(

                'Tambahkan struktur organisasi sekolah.',

                style: TextStyle(
                  color:
                      Colors.grey[700],
                ),
              ),

              const SizedBox(
                  height: 30),

              _label('Nama'),

              _input(

                controller:
                    nameController,

                hint:
                    'Masukkan nama',
              ),

              const SizedBox(
                  height: 20),

              _label('Jabatan'),

              _input(

                controller:
                    positionController,

                hint:
                    'Masukkan jabatan',
              ),

              const SizedBox(
                  height: 20),

              _label('Jenis'),

              DropdownButtonFormField(

                value: type,

                decoration:
                    InputDecoration(

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

                items: const [

                  DropdownMenuItem(

                    value:
                        'kepala',

                    child: Text(
                      'Kepala Sekolah',
                    ),
                  ),

                  DropdownMenuItem(

                    value:
                        'guru',

                    child: Text(
                      'Guru',
                    ),
                  ),
                ],

                onChanged: (v) {

                  setState(() {

                    type =
                        v.toString();
                  });
                },
              ),

              const SizedBox(
                  height: 20),

              _label('Upload Foto'),

              GestureDetector(

                onTap: pickImage,

                child: Container(

                  height: 180,

                  width:
                      double.infinity,

                  decoration:
                      BoxDecoration(

                    color:
                        const Color(
                            0xffF9FAFB),

                    borderRadius:
                        BorderRadius.circular(
                            18),

                    border: Border.all(
                      color:
                          Colors.grey
                              .shade300,
                    ),
                  ),

                  child: image == null

                      ? Column(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: const [

                            Icon(
                              Icons
                                  .image,
                              size: 50,
                            ),

                            SizedBox(
                                height:
                                    10),

                            Text(
                              'Pilih Foto',
                            ),
                          ],
                        )

                      : ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                                  18),

                          child:
                              Image.file(

                            image!,

                            fit: BoxFit
                                .cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(
                  height: 20),

              _label('Deskripsi'),

              _textarea(

                controller:
                    descriptionController,

                hint:
                    'Masukkan deskripsi',
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

                  onPressed:
                      isLoading
                          ? null
                          : () async {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                const SnackBar(

                                  content: Text(
                                    'Struktur berhasil ditambahkan',
                                  ),
                                ),
                              );

                              Navigator.pop(
                                context,
                                true,
                              );
                            },

                  child: isLoading

                      ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )

                      : const Text(

                          'Simpan Struktur',

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
    String text,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 8),

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