import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'
    as http;

class GalleryService {

  final String baseUrl =
      "http://127.0.0.1:8000/api/admin";

  Future<List<dynamic>>
      getGallery() async {

    try {

      final response =
          await http.get(

        Uri.parse(
          "$baseUrl/gallery",
        ),
      );

      print(response.body);

      if (response.statusCode == 200) {

        final json =
            jsonDecode(
          response.body,
        );

        if (json['success'] ==
            true) {

          return json['data'];
        }
      }

      return [];

    } catch (e) {

      print(e);

      return [];
    }
  }

  Future<bool>
      createGallery({
    required String title,
    required String category,
    required File image,
  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          "$baseUrl/gallery/store",
        ),
      );

      request.fields['title'] =
          title;

      request.fields['category'] =
          category;

      request.files.add(

        await http.MultipartFile
            .fromPath(
          'image',
          image.path,
        ),
      );

      final response =
          await request.send();

      final body =
          await response.stream
              .bytesToString();

      print(body);

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      print(e);

      return false;
    }
  }

  Future<bool>
      updateGallery({
    required int id,
    required String title,
    required String category,
    File? image,
  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          "$baseUrl/gallery/update/$id",
        ),
      );

      request.fields['title'] =
          title;

      request.fields['category'] =
          category;

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

      final body =
          await response.stream
              .bytesToString();

      print(body);

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      print(e);

      return false;
    }
  }

  Future<bool>
      deleteGallery(
    int id,
  ) async {

    try {

      final response =
          await http.delete(

        Uri.parse(
          "$baseUrl/gallery/delete/$id",
        ),

        headers: {

          "Accept":
              "application/json",
        },
      );

      print(
          "DELETE STATUS: ${response.statusCode}");

      print(
          "DELETE BODY: ${response.body}");

      if (response.statusCode ==
          200) {

        final json =
            jsonDecode(
          response.body,
        );

        return json[
                'success'] ==
            true;
      }

      return false;

    } catch (e) {

      print(e);

      return false;
    }
  }
}