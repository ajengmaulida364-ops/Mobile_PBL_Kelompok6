import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherAttendanceService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/teacher/attendance';

  // GET ATTENDANCE
  static Future<List<dynamic>> getAttendances() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] != null) {
          return json['data'];
        }
      }

      return [];
    } catch (e) {
      print('ERROR GET ATTENDANCE: $e');
      return [];
    }
  }

  // CREATE ATTENDANCE
  static Future<bool> createAttendance({
    required int teacherId,
    required String date,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "teacher_id": teacherId,
          "date": date,
        }),
      );

      print("POST STATUS: ${response.statusCode}");
      print("POST BODY: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("ERROR CREATE ATTENDANCE: $e");
      return false;
    }
  }

// CREATE PERMISSION (IZIN / SAKIT / CUTI)
  static Future<bool> createPermission({
    required int teacherId,
    required String date,
    required String status,
    required String note,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "teacher_id": teacherId,
          "date": date,
          "status": status,
          "note": note,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
