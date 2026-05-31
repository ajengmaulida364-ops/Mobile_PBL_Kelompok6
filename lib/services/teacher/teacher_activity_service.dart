import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherActivityService {
  // 🔥 endpoint sudah benar (khusus teacher)
  static const String baseUrl = "http://127.0.0.1:8000/api/teacher/activities";

  // ================= GET ACTIVITY =================
  static Future<List<dynamic>> getActivities({
    required int teacherId,
    int? month,
    int? year,
  }) async {
    try {
      final uri = Uri.parse(
        "$baseUrl?teacher_id=$teacherId"
        "${month != null ? '&month=$month' : ''}"
        "${year != null ? '&year=$year' : ''}",
      );

      final response = await http.get(uri);

      print("STATUS CODE: ${response.statusCode}");
      print("BODY RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] != null) {
          return json['data'];
        }
        return [];
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("GET Activities Error: $e");
    }
  }

  // ================= STORE ACTIVITY =================
  static Future<bool> createActivity({
    required int teacherId,
    required int schoolClassId,
    required String date,
    required String activity1,
    String? activity2,
    String? activity3,
    String? notes,
  }) async {
    try {
      final uri = Uri.parse(baseUrl);

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "teacher_id": teacherId,
          "school_class_id": schoolClassId,
          "date": date,
          "activity_1": activity1,
          "activity_2": activity2,
          "activity_3": activity3,
          "notes": notes,
        }),
      );

      print("POST STATUS: ${response.statusCode}");
      print("POST BODY: ${response.body}");

      final json = jsonDecode(response.body);

      // 🔥 debug penting
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json['success'] == true;
      } else {
        print(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception("POST Activity Error: $e");
    }
  }
}
