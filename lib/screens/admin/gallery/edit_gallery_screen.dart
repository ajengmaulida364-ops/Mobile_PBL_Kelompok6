import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditGalleryScreen
    extends StatefulWidget {

  final Map gallery;

  const EditGalleryScreen({

    super.key,

    required this.gallery,
  });

  @override
  State<EditGalleryScreen>
      createState() =>
          _EditGalleryScreenState();
}

class _EditGalleryScreenState
    extends State<EditGalleryScreen> {

  late TextEditingController
      titleController;

  late String category;

  File? imageFile;

  bool isLoading = false;

  @override
  void initState() {

    super.initState();

    titleController =
        TextEditingController(

      text:
          widget.gallery['title'],
    );

    category =
        widget.gallery['category'];
  }

  Future<void> pickImage()
  async {

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

  Future<void> updateGallery()
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
          "Galeri berhasil diupdate",
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

          "Edit Galeri",

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
                ),

                child: imageFile !=
                        null

                    ? ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        child:
                            Image.file(

                          imageFile!,

                          fit: BoxFit
                              .cover,
                        ),
                      )

                    : ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        child:
                            Image.network(

                          widget.gallery[
                              'image'],

                          fit: BoxFit
                              .cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(
                height: 24),

            /// TITLE
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

                        : updateGallery,

                child: isLoading

                    ? const CircularProgressIndicator(
                        color: Colors
                            .white,
                      )

                    : const Text(

                        "Update Galeri",

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