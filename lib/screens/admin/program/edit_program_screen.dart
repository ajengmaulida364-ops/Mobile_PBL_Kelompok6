import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditProgramScreen
    extends StatefulWidget {

  final Map program;

  const EditProgramScreen({
    super.key,
    required this.program,
  });

  @override
  State<EditProgramScreen>
      createState() =>
          _EditProgramScreenState();
}

class _EditProgramScreenState
    extends State<EditProgramScreen> {

  late TextEditingController
      titleController;

  late TextEditingController
      descriptionController;

  late String type;

  File? image;

  final picker = ImagePicker();

  bool isLoading = false;

  @override
  void initState() {

    super.initState();

    titleController =
        TextEditingController(

      text:
          widget.program[
              'title'],
    );

    descriptionController =
        TextEditingController(

      text:
          widget.program[
              'description'],
    );

    type =
        widget.program['type'];
  }

  Future pickImage() async {

    final picked =
        await picker.pickImage(

      source: ImageSource.gallery,
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

          'Edit Program',

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

                'Edit Program',

                style: TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 30),

              _label(
                  'Nama Program'),

              _input(
                controller:
                    titleController,
                hint:
                    'Nama program',
              ),

              const SizedBox(
                  height: 20),

              _label(
                  'Jenis Program'),

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
                        'mingguan',

                    child: Text(
                        'Mingguan'),
                  ),

                  DropdownMenuItem(

                    value:
                        'bulanan',

                    child: Text(
                        'Bulanan'),
                  ),

                  DropdownMenuItem(

                    value:
                        'tahunan',

                    child: Text(
                        'Tahunan'),
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

              _label(
                  'Foto Program'),

              GestureDetector(

                onTap: pickImage,

                child: Container(

                  height: 200,

                  width:
                      double.infinity,

                  decoration:
                      BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(
                            18),

                    color:
                        const Color(
                            0xffF9FAFB),
                  ),

                  child: image != null

                      ? ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                                  18),

                          child:
                              Image.file(

                            image!,

                            fit: BoxFit
                                .cover,
                          ),
                        )

                      : ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                                  18),

                          child:
                              Image.network(

                            widget.program[
                                'image'],

                            fit: BoxFit
                                .cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(
                  height: 20),

              _label(
                  'Deskripsi'),

              _textarea(
                controller:
                    descriptionController,
                hint:
                    'Deskripsi program',
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
                                    'Program berhasil diupdate',
                                  ),
                                ),
                              );

                              Navigator.pop(
                                  context,
                                  true);
                            },

                  child: isLoading

                      ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )

                      : const Text(

                          'Update Program',

                          style:
                              TextStyle(

                            color:
                                Colors.white,
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