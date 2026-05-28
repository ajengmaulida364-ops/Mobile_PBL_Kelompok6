import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminService {

  /// ANDROID EMULATOR
  final String baseUrl =
      "http://10.0.2.2:8000/api";

  /// CHROME / WEB
  // final String baseUrl =
  //     "http://127.0.0.1:8000/api";

  Future<Map<String, dynamic>>
      getDashboard() async {

    final response = await http.get(

      Uri.parse(
        "$baseUrl/admin/dashboard",
      ),
    );

    print(response.statusCode);

    print(response.body);

    return jsonDecode(response.body);
  }
}