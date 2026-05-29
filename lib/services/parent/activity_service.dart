import 'dart:convert';

import 'package:http/http.dart' as http;

class ActivityService {

  Future<List<dynamic>> getActivities() async {

    final response = await http.get(

      Uri.parse(
        'http://127.0.0.1:8000/api/parent/activities',
      ),

      headers: {
        'Accept': 'application/json',
      },
    );

    print(response.statusCode);

    print(response.body);

    if (response.body.isEmpty) {
      return [];
    }

    final data = jsonDecode(response.body);

    return data['data'];
  }
}