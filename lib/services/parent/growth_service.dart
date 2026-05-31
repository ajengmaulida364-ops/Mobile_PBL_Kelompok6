import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/utils/user_session.dart';

class GrowthService {

  Future<List<dynamic>> getGrowths({
    String? month,
    String? year,
  }) async {

    String url =
        'http://127.0.0.1:8000/api/parent/growths?nisn=${UserSession.username}';

    if (month != null && year != null) {
    url += '&month=$month&year=$year';
  }
  print(url);
  
    final response = await http.get(
      Uri.parse(url),

      headers: {
        'Accept': 'application/json',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.body.isEmpty) {
      return [];
    }

    final data = jsonDecode(
      response.body,
    );

    return data['data'];
  }
}