import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/utils/user_session.dart';

class ActivityService {

  Future<List<dynamic>> getActivities({
    String? date,
  }) async {

    String url =
        'http://127.0.0.1:8000/api/parent/activities?nisn=${UserSession.username}';

    if (date != null &&
        date.isNotEmpty) {

      url += '?date=$date';
    }

    final response =
        await http.get(

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

    final data =
        jsonDecode(response.body);

    return data['data'];
  }
}