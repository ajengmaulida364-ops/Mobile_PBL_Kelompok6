import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/admin/structure_service.dart';

class EditStructureScreen extends StatefulWidget {
  final Map structure;

  const EditStructureScreen({
    super.key,
    required this.structure,
  });

  @override
  State<EditStructureScreen> createState() => _EditStructureScreenState();
}

class _EditStructureScreenState extends State<EditStructureScreen> {
  final nameController = TextEditingController();

  final positionController = TextEditingController();

  final descriptionController = TextEditingController();

  String type = 'kepala';

  File? imageFile;

  final picker = ImagePicker();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    nameController.text = widget.structure['name'] ?? '';

    positionController.text = widget.structure['position'] ?? '';

    descriptionController.text = widget.structure['description'] ?? '';

    type = widget.structure['type'] ?? 'kepala';
  }

  Future pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        imageFile = File(
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
          'Tambah Struktur',
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
                'Edit Struktur',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Perbarui struktur organisasi sekolah.',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              _label('Nama'),
              _input(
                controller: nameController,
                hint: 'Masukkan nama',
              ),
              const SizedBox(height: 20),
              _label('Jabatan'),
              _input(
                controller: positionController,
                hint: 'Masukkan jabatan',
              ),
              const SizedBox(height: 20),
              _label('Jenis'),
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
                    value: 'kepala',
                    child: Text(
                      'Kepala Sekolah',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'guru',
                    child: Text(
                      'Guru',
                    ),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    type = v.toString();
                  });
                },
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
                          setState(() {
                            isLoading = true;
                          });

                          final success =
                              await StructureService().updateStructure(
                            id: widget.structure['id'],
                            name: nameController.text,
                            position: positionController.text,
                            type: type,
                            description: descriptionController.text,
                            image: imageFile,
                          );

                          if (!mounted) return;

                          setState(() {
                            isLoading = false;
                          });

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Struktur berhasil diupdate',
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
                                  'Gagal mengupdate struktur',
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
                          'Update Struktur',
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