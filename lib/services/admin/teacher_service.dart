import 'dart:convert';

import 'package:http/http.dart'
    as http;

class TeacherService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

  Future<List<dynamic>>
      getTeachers() async {

    try {

      final response =
          await http.get(

        Uri.parse(
          "$baseUrl/teachers",
        ),
      );

      print(
        "STATUS TEACHER:",
      );

      print(
        response.statusCode,
      );

      print(
        "BODY TEACHER:",
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
        "Gagal mengambil data guru",
      );

    } catch (e) {

      print(
        "ERROR TEACHER:",
      );

      print(e);

      return [];
    }
  }
}