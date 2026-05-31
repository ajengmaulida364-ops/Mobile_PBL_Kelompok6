import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentAttendanceService {

  // endpoint student attendance
  static const String baseUrl =
      "http://127.0.0.1:8000/api/student/attendance";

  // ================= GET ATTENDANCE =================
  static Future<List<dynamic>> getAttendances({
    int? studentId,
  }) async {
    try {
      final uri = Uri.parse(
        "$baseUrl"
        "${studentId != null ? '?student_id=$studentId' : ''}",
      );

      final response = await http.get(uri);

      print("STATUS CODE: ${response.statusCode}");
      print("BODY RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true &&
            json['data'] != null) {
          return json['data'];
        }

        return [];
      } else {
        throw Exception(
          "Server error: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(
        "GET Attendance Error: $e",
      );
    }
  }

  // ================= STORE ATTENDANCE =================
  static Future<bool> createAttendance({
    required int studentId,
    required String date,
    required String status,
    String? note,
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
          "student_id": studentId,
          "date": date,
          "status": status,
          "note": note,
        }),
      );

      print("POST STATUS: ${response.statusCode}");
      print("POST BODY: ${response.body}");

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return json['success'] == true;
      } else {
        print(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(
        "POST Attendance Error: $e",
      );
    }
  }
}