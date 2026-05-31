import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherStudentService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/teacher/students';

  static Future<List<dynamic>> getStudents() async {
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
      print('ERROR GET STUDENTS: $e');

      return [];
    }
  }
}
