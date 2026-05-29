import 'dart:convert';

import 'package:http/http.dart'
    as http;

class StudentService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

  Future<List<dynamic>>
      getStudents() async {

    try {

      final response =
          await http.get(

        Uri.parse(
          "$baseUrl/students",
        ),
      );

      print(
        "STATUS STUDENT:",
      );

      print(
        response.statusCode,
      );

      print(
        "BODY STUDENT:",
      );

      print(
        response.body,
      );

      if (response.statusCode == 200) {

        final data =
            jsonDecode(
          response.body,
        );

        if (data is List) {

          return data;
        }

        return [];
      }

      throw Exception(
        "Gagal mengambil data siswa",
      );

    } catch (e) {

      print(
        "ERROR STUDENT:",
      );

      print(e);

      return [];
    }
  }
}