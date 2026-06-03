import 'package:flutter/material.dart';
import '../../../services/admin/class_service.dart';
import '../../../services/admin/student_service.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final nameController = TextEditingController();
  final nisnController = TextEditingController();
  final parentNameController = TextEditingController();
  final parentPhoneController = TextEditingController();
  final addressController = TextEditingController();

  
  final parentUsernameController = TextEditingController();
  final parentPasswordController = TextEditingController();

  String selectedGender = 'Laki-laki';
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
    final result = await ClassService().getClasses();

    if (!mounted) return;

    setState(() {
      classes = result;

      if (classes.isNotEmpty) {
        selectedClass = classes[0]['id'].toString();
      }

      isLoadingClass = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Tambah Siswa"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _label("Nama"),
            _input(controller: nameController, hint: "Nama lengkap siswa"),
            const SizedBox(height: 15),
            _label("NISN"),
            _input(controller: nisnController, hint: "NISN siswa"),
            const SizedBox(height: 15),
            _label("Jenis Kelamin"),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("Laki-laki"),
                    value: "Laki-laki",
                    groupValue: selectedGender,
                    onChanged: (v) {
                      setState(() => selectedGender = v.toString());
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Perempuan"),
                    value: "Perempuan",
                    groupValue: selectedGender,
                    onChanged: (v) {
                      setState(() => selectedGender = v.toString());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _label("Kelas"),
            isLoadingClass
                ? const CircularProgressIndicator()
                : Wrap(
                    spacing: 10,
                    children: classes.map((kelas) {
                      return ChoiceChip(
                        label: Text("Kelas ${kelas['name']}"),
                        selected: selectedClass == kelas['id'].toString(),
                        onSelected: (v) {
                          setState(() {
                            selectedClass = kelas['id'].toString();
                          });
                        },
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 15),
            _label("Nama Orang Tua"),
            _input(controller: parentNameController, hint: "Nama orang tua"),
            const SizedBox(height: 15),
            _label("Username Parent"),
            _input(
              controller: parentUsernameController,
              hint: "Username login orang tua",
            ),
            const SizedBox(height: 15),
            _label("Password Parent"),
            TextField(
              controller: parentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password login orang tua",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _label("Telepon Orang Tua"),
            _input(controller: parentPhoneController, hint: "08xxxxxxxxxx"),
            const SizedBox(height: 15),
            _label("Alamat"),
            _input(controller: addressController, hint: "Alamat siswa"),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("Status Aktif"),
              value: isActive,
              onChanged: (v) {
                setState(() => isActive = v);
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () async {
                  final res = await StudentService().createStudent(
                    name: nameController.text,
                    nisn: nisnController.text,
                    gender: selectedGender == "Laki-laki" ? "L" : "P",
                    classId: selectedClass,
                    parentName: parentNameController.text,
                    parentPhone: parentPhoneController.text,
                    username: parentUsernameController.text,
                    password: parentPasswordController.text,
                    address: addressController.text,
                    isActive: isActive,
                  );

                  if (res == true) {
                    if (!mounted) return;
                    Navigator.pop(context, true);
                  }
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) {
    return Text(
      t,
      style: const TextStyle(fontWeight: FontWeight.bold),
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
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
