import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  Future login({

    required String login,
    required String password,

  }) async {

    final response = await http.post(

      Uri.parse(
        'http://127.0.0.1:8000/api/login',
      ),

      headers: {
        'Accept': 'application/json',
      },

      body: {

        'login': login,
        'password': password,

      },
    );

    print(response.statusCode);

    print(response.body);

    if (response.body.isEmpty) {

      return {
        'status': false,
        'message': 'Response kosong'
      };
    }

    return jsonDecode(response.body);
  }
}