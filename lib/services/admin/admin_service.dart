import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

  Future<Map<String, dynamic>>
      getDashboard() async {

    final response = await http.get(

      Uri.parse(
        "$baseUrl/admin/dashboard",
      ),
    );

    print(
      "STATUS DASHBOARD:",
    );

    print(
      response.statusCode,
    );

    print(
      "BODY DASHBOARD:",
    );

    print(
      response.body,
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      "Gagal mengambil dashboard",
    );
  }
}