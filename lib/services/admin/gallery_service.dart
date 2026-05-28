import 'dart:convert';

import 'package:http/http.dart'
    as http;

class GalleryService {

  final String baseUrl =
      "http://10.0.2.2:8000/api";

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

        return jsonDecode(
          response.body,
        );
      }

      return [];

    } catch (e) {

      print(e);

      return [];
    }
  }
}