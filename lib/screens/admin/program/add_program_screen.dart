import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import '../../../services/admin/program_service.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({
    super.key,
  });

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  String type = 'mingguan';

  File? image;

  final picker = ImagePicker();

  bool isLoading = false;

  Future pickImage() async {
    final picked = await picker.pickImage(
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
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Tambah Program',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Program',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Tambahkan program kegiatan sekolah.',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 30),

              /// TITLE
              _label('Nama Program'),

              _input(
                controller: titleController,
                hint: 'Masukkan nama program',
              ),

              const SizedBox(height: 20),

              /// TYPE
              _label('Jenis Program'),

              DropdownButtonFormField(
                value: type,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'mingguan',
                    child: Text('Mingguan'),
                  ),
                  DropdownMenuItem(
                    value: 'bulanan',
                    child: Text('Bulanan'),
                  ),
                  DropdownMenuItem(
                    value: 'tahunan',
                    child: Text('Tahunan'),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    type = v.toString();
                  });
                },
              ),

              const SizedBox(height: 20),

              /// IMAGE
              _label('Foto Program'),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffF9FAFB),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.image,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Pilih Foto Program',
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              _label('Deskripsi'),

              _textarea(
                controller: descriptionController,
                hint: 'Masukkan deskripsi program',
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Nama program wajib diisi',
                                ),
                              ),
                            );

                            return;
                          }

                          if (descriptionController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Deskripsi wajib diisi',
                                ),
                              ),
                            );

                            return;
                          }

                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Foto program wajib dipilih',
                                ),
                              ),
                            );

                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          final success = await ProgramService().storeProgram(
                            title: titleController.text,
                            type: type,
                            description: descriptionController.text,
                            image: image,
                          );

                          if (!mounted) return;

                          setState(() {
                            isLoading = false;
                          });

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Program berhasil ditambahkan',
                                ),
                              ),
                            );

                            Navigator.pop(
                              context,
                              true,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Gagal menambahkan program',
                                ),
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Simpan Program',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xffF9FAFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _textarea({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xffF9FAFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
