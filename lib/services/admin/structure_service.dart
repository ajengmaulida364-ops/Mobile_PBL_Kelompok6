import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'
    as http;

class StructureService {

  final String baseUrl =
      "http://127.0.0.1:8000/api/admin";

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

  Future<bool> storeStructure({

    required String name,
    required String position,
    required String type,
    required String description,

    File? image,

  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          '$baseUrl/structures/store',
        ),
      );

      request.fields['name'] =
          name;

      request.fields['position'] =
          position;

      request.fields['type'] =
          type;

      request.fields['description'] =
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

      final streamedResponse =
          await request.send();

      final response =
          await http.Response
              .fromStream(
        streamedResponse,
      );

      print(response.body);

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      print(e);

      return false;
    }
  }

  Future<bool> updateStructure({

    required int id,
    required String name,
    required String position,
    required String type,
    required String description,

    File? image,

  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          '$baseUrl/structures/update/$id',
        ),
      );

      request.fields['name'] =
          name;

      request.fields['position'] =
          position;

      request.fields['type'] =
          type;

      request.fields['description'] =
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

      final streamedResponse =
          await request.send();

      final response =
          await http.Response
              .fromStream(
        streamedResponse,
      );

      print(response.body);

      return response.statusCode ==
          200;

    } catch (e) {

      print(e);

      return false;
    }
  }

  Future<bool> deleteStructure(
      int id) async {

    try {

      final response =
          await http.delete(

        Uri.parse(
          '$baseUrl/structures/delete/$id',
        ),
      );

      print(response.body);

      return response.statusCode ==
          200;

    } catch (e) {

      print(e);

      return false;
    }
  }
}