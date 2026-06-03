import 'package:flutter/material.dart';

class DetailTeacherScreen extends StatelessWidget {

  final Map teacher;

  const DetailTeacherScreen({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor: Colors.teal,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(

          "Detail Guru",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Container(

            width: double.infinity,

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Center(

                  child: CircleAvatar(

                    radius: 45,

                    backgroundColor:
                        Colors.teal,

                    child: Icon(

                      Icons.person,

                      color: Colors.white,

                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                _item(
                  "Nama",
                  teacher['name'],
                ),

                _item(
                  "Email",
                  teacher['email'],
                ),

                _item(
                  "Role",
                  teacher['role'],
                ),

                _item(
                  "Kelas",
                  teacher['class_name'],
                ),

                _item(
                  "NIP",
                  teacher['nip'],
                ),

                _item(
                  "No HP",
                  teacher['phone'],
                ),

                _item(
                  "Alamat",
                  teacher['address'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(
    String title,
    dynamic value,
  ) {

    final displayValue =

        value == null ||
                value.toString().trim().isEmpty
            ? '-'
            : value.toString();

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize: 16,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(

            displayValue,

            style: const TextStyle(
              fontSize: 15,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          const Divider(),
        ],
      ),
    );
  }
}