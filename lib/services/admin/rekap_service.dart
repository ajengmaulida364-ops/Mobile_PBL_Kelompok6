import 'dart:convert';

import 'package:http/http.dart'
    as http;

class RekapService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

  Future<List<dynamic>>
      getRekapGuru() async {

    final response =
        await http.get(

      Uri.parse(
        "$baseUrl/rekap/guru",
      ),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      "Gagal mengambil rekap guru",
    );
  }

  Future<Map<String, dynamic>>
      getDetailGuru(
    int id,
  ) async {

    final response =
        await http.get(

      Uri.parse(
        "$baseUrl/rekap/guru/$id",
      ),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      "Gagal mengambil detail guru",
    );
  }
}