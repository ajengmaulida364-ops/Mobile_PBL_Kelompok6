import 'dart:convert';

import 'package:http/http.dart'
    as http;

class ClassService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

  Future<List<dynamic>>
      getClasses() async {

    try {

      final response =
          await http.get(

        Uri.parse(
          "$baseUrl/classes",
        ),
      );

      print(
        "STATUS CLASS:",
      );

      print(
        response.statusCode,
      );

      print(
        "BODY CLASS:",
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
        "Gagal mengambil kelas",
      );

    } catch (e) {

      print(
        "ERROR CLASS:",
      );

      print(e);

      return [];
    }
  }
}