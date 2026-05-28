import 'dart:convert';

import 'package:http/http.dart' as http;

class ProgramService {

  final String baseUrl =
      'http://10.0.2.2:8000/api';

  /// GET PROGRAM
  Future<List> getPrograms({
    String? type,
  }) async {

    String url =
        '$baseUrl/programs';

    if (type != null) {

      url += '?type=$type';
    }

    final response =
        await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      'Gagal ambil program',
    );
  }

  /// DELETE PROGRAM
  Future<void> deleteProgram(
      int id) async {

    final response =
        await http.delete(

      Uri.parse(
        '$baseUrl/programs/delete/$id',
      ),
    );

    if (response.statusCode != 200) {

      throw Exception(
        'Gagal hapus program',
      );
    }
  }

  /// STORE PROGRAM
  Future<void> storeProgram({

    required String title,
    required String type,
    required String description,

  }) async {

    final response =
        await http.post(

      Uri.parse(
        '$baseUrl/programs/store',
      ),

      body: {

        'title': title,
        'type': type,
        'description': description,
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception(
        'Gagal tambah program',
      );
    }
  }

  /// UPDATE PROGRAM
  Future<void> updateProgram({

    required int id,
    required String title,
    required String type,
    required String description,

  }) async {

    final response =
        await http.post(

      Uri.parse(
        '$baseUrl/programs/update/$id',
      ),

      body: {

        'title': title,
        'type': type,
        'description': description,
      },
    );

    if (response.statusCode != 200) {

      throw Exception(
        'Gagal update program',
      );
    }
  }
}