import 'dart:convert';

import 'package:http/http.dart'
    as http;

class StructureService {

  final String baseUrl =
      'http://10.0.2.2:8000/api/admin';

  Future<List> getStructures({

    String? type,
  }) async {

    String url =
        '$baseUrl/structures';

    if (type != null) {

      url += '?type=$type';
    }

    final response =
        await http.get(
      Uri.parse(url),
    );

    final data =
        jsonDecode(
            response.body);

    return data['data'];
  }

  Future<void> deleteStructure(
      int id) async {

    final response =
        await http.delete(

      Uri.parse(
        '$baseUrl/structures/delete/$id',
      ),
    );

    if (response.statusCode !=
        200) {

      throw Exception(
        'Gagal hapus struktur',
      );
    }
  }
}