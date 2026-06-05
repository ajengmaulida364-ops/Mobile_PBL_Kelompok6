import 'dart:convert';

import 'package:http/http.dart'
    as http;

class ProfileService {

  final String baseUrl =
      "http://127.0.0.1:8000/api/admin";

  Future<Map<String, dynamic>>
      getProfile() async {

    final response =
        await http.get(

      Uri.parse(
        '$baseUrl/profile',
      ),
    );

    return jsonDecode(
      response.body,
    );
  }

  Future<void> updateProfile({

    required String title,

    required String description,

    required String email,

    required String phone,

    required String address,

    required String vision,

    required String mission,
  }) async {

    final response =
        await http.post(

      Uri.parse(
        '$baseUrl/profile/update',
      ),

      body: {

        'title': title,

        'description':
            description,

        'email': email,

        'phone': phone,

        'address': address,

        'vision': vision,

        'mission': mission,
      },
    );

    if (response.statusCode !=
        200) {

      throw Exception(
        'Update profile gagal',
      );
    }
  }
}