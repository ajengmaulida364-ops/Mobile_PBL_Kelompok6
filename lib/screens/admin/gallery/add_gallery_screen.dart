import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddGalleryScreen
    extends StatefulWidget {

  const AddGalleryScreen({
    super.key,
  });

  @override
  State<AddGalleryScreen>
      createState() =>
          _AddGalleryScreenState();
}

class _AddGalleryScreenState
    extends State<AddGalleryScreen> {

  final titleController =
      TextEditingController();

  String category =
      "Kegiatan Belajar";

  File? imageFile;

  bool isLoading = false;

  Future<void> pickImage() async {

    final picker =
        ImagePicker();

    final picked =
        await picker.pickImage(

      source:
          ImageSource.gallery,
    );

    if (picked != null) {

      setState(() {

        imageFile =
            File(picked.path);
      });
    }
  }

  Future<void> saveGallery()
  async {

    if (titleController
        .text
        .isEmpty) {

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Judul wajib diisi",
          ),
        ),
      );

      return;
    }

    if (imageFile == null) {

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Foto wajib dipilih",
          ),
        ),
      );

      return;
    }

    setState(() {

      isLoading = true;
    });

    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
            context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Galeri berhasil ditambahkan",
        ),
      ),
    );

    Navigator.pop(context);
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

          "Tambah Galeri",

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

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            /// IMAGE
            GestureDetector(

              onTap: pickImage,

              child: Container(

                height: 220,

                width:
                    double.infinity,

                decoration:
                    BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                          20),

                  border: Border.all(

                    color: Colors.grey
                        .shade300,
                  ),
                ),

                child: imageFile ==
                        null

                    ? Column(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: const [

                          Icon(

                            Icons
                                .image_outlined,

                            size: 70,

                            color:
                                Colors.grey,
                          ),

                          SizedBox(
                              height:
                                  12),

                          Text(
                            "Pilih Foto Galeri",
                          ),
                        ],
                      )

                    : ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        child:
                            Image.file(

                          imageFile!,

                          fit: BoxFit
                              .cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(
                height: 24),

            /// JUDUL
            const Text(

              "Judul Galeri",

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 10),

            TextField(

              controller:
                  titleController,

              decoration:
                  InputDecoration(

                hintText:
                    "Masukkan judul",

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          14),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
                height: 24),

            /// CATEGORY
            const Text(

              "Kategori",

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 10),

            DropdownButtonFormField(

              value: category,

              items: [

                "Kegiatan Belajar",

                "Outdoor",

                "Keagamaan",

                "Acara",
              ].map((e) {

                return DropdownMenuItem(

                  value: e,

                  child: Text(e),
                );
              }).toList(),

              onChanged: (value) {

                setState(() {

                  category =
                      value!;
                });
              },

              decoration:
                  InputDecoration(

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          14),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
                height: 34),

            /// BUTTON
            SizedBox(

              width:
                  double.infinity,

              height: 56,

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
                            18),
                  ),
                ),

                onPressed:
                    isLoading

                        ? null

                        : saveGallery,

                child: isLoading

                    ? const CircularProgressIndicator(
                        color: Colors
                            .white,
                      )

                    : const Text(

                        "Simpan Galeri",

                        style:
                            TextStyle(

                          fontSize:
                              16,

                          fontWeight:
                              FontWeight.bold,

                          color: Colors
                              .white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}