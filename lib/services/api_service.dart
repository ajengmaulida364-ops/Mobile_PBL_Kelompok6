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

  // TAMBAHAN FITUR DEVELOPMENT (TANPA MERUBAH LOGIN)

  Future storeDevelopment(Map<String, dynamic> data) async {

    final response = await http.post(

      Uri.parse('http://127.0.0.1:8000/api/development-note'),

      headers: {
        'Accept': 'application/json',
      },

      body: data,
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

  Future getDevelopment({
    String? year,
    String? studentId,
  }) async {

    final uri = Uri.parse(
      'http://127.0.0.1:8000/api/development-note?year=${year ?? ''}&student_id=${studentId ?? ''}',
    );

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.body.isEmpty) {
      return [];
    }

    return jsonDecode(response.body);
  }
}