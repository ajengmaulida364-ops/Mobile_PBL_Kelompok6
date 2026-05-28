import 'package:flutter/material.dart';

class DetailTeacherScreen
    extends StatelessWidget {

  final Map teacher;

  const DetailTeacherScreen({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor: Colors.teal,

        title: const Text(

          "Detail Guru",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Container(

          padding:
              const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(20),
          ),

          child: Column(

            children: [

              const CircleAvatar(

                radius: 45,

                backgroundColor:
                    Colors.teal,

                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
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
                teacher['class'],
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
    );
  }

  Widget _item(
    String title,
    dynamic value,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 16),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value.toString(),
          ),

          const Divider(),
        ],
      ),
    );
  }
}