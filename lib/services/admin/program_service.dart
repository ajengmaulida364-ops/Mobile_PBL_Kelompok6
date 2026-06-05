import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ProgramService {

  final String baseUrl =
      "http://127.0.0.1:8000/api/admin";

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

  Future<bool> deleteProgram(
    int id,
  ) async {

    try {

      final response =
          await http.delete(

        Uri.parse(
          '$baseUrl/programs/delete/$id',
        ),
      );

      return response.statusCode ==
          200;

    } catch (e) {

      return false;
    }
  }

  Future<bool> storeProgram({

    required String title,
    required String type,
    required String description,

    File? image,

  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          '$baseUrl/programs/store',
        ),
      );

      request.fields['title'] =
          title;

      request.fields['type'] =
          type;

      request.fields[
              'description'] =
          description;

      if (image != null) {

        request.files.add(

          await http.MultipartFile
              .fromPath(

            'image',

            image.path,
          ),
        );
      }

      final response =
          await request.send();

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      return false;
    }
  }

  Future<bool> updateProgram({

    required int id,
    required String title,
    required String type,
    required String description,

    File? image,

  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          '$baseUrl/programs/update/$id',
        ),
      );

      request.fields['title'] =
          title;

      request.fields['type'] =
          type;

      request.fields[
              'description'] =
          description;

      if (image != null) {

        request.files.add(

          await http.MultipartFile
              .fromPath(

            'image',

            image.path,
          ),
        );
      }

      final response =
          await request.send();

      return response.statusCode ==
          200;

    } catch (e) {

      return false;
    }
  }
}