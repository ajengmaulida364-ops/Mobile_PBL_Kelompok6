import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherDevelopmentService {

  static const String baseUrl =
      "http://127.0.0.1:8000/api/teacher/development-notes";

  // ================= GET =================

  static Future<List<dynamic>> getDevelopmentNotes({
    int? studentId,
    int? year,
  }) async {
    try {
      final uri = Uri.parse(
        "$baseUrl"
        "${studentId != null ? '?student_id=$studentId' : ''}"
        "${year != null ? '&year=$year' : ''}",
      );

      final response = await http.get(uri);

      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true) {
          return json['data'];
        }
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  // ================= STORE =================

  static Future<bool> createDevelopmentNote({
    required int studentId,
    required int teacherId,
    required int month,
    required int year,
    required String description,
    double? tb,
    double? bb,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "student_id": studentId,
          "teacher_id": teacherId,
          "month": month,
          "year": year,
          "description": description,
          "tb": tb,
          "bb": bb,
        }),
      );

      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}