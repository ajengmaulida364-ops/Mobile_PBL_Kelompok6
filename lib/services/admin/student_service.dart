import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl = "http://127.0.0.1:8000/api/admin";

  Future<List<dynamic>> getStudents() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/students"),
        headers: {
          "Accept": "application/json",
        },
      );

      print("STATUS STUDENT: ${response.statusCode}");
      print("BODY STUDENT: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] != null) {
          return json['data'];
        }
      }

      return [];
    } catch (e) {
      print("GET ERROR: $e");
      return [];
    }
  }

  Future<bool> createStudent({
    required String name,
    required String nisn,
    required String gender,
    required String classId,
    required String parentName,
    required String parentPhone,
    required String username,
    required String password,
    required String address,
    required bool isActive,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/students/store"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "nisn": nisn,
          "gender": gender,
          "school_class_id": classId,
          "parent_name": parentName,
          "parent_phone": parentPhone,
          "username": username,
          "password": password,
          "address": address,
          "is_active": isActive ? 1 : 0,
        }),
      );

      print("CREATE STATUS: ${response.statusCode}");
      print("CREATE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['success'] == true;
      }

      return false;
    } catch (e) {
      print("CREATE ERROR: $e");
      return false;
    }
  }

  Future<bool> updateStudent({
    required int id,
    required String name,
    required String nisn,
    required String gender,
    required String classId,
    required String parentName,
    required String parentPhone,
    required String address,
    required bool isActive,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/students/update/$id"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "nisn": nisn,
          "gender": gender,
          "school_class_id": classId,
          "parent_name": parentName,
          "parent_phone": parentPhone,
          "address": address,
          "is_active": isActive ? 1 : 0,
        }),
      );

      print("UPDATE STATUS: ${response.statusCode}");
      print("UPDATE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['success'] == true;
      }

      return false;
    } catch (e) {
      print("UPDATE ERROR: $e");
      return false;
    }
  }

  Future<bool> deleteStudent(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/students/$id"),
        headers: {
          "Accept": "application/json",
        },
      );

      print("DELETE STATUS: ${response.statusCode}");
      print("DELETE BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<dynamic>> getClasses() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/classes"),
        headers: {
          "Accept": "application/json",
        },
      );

      print("STATUS CLASS: ${response.statusCode}");
      print("BODY CLASS: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == true && json['data'] != null) {
          return json['data'];
        }
      }

      return [];
    } catch (e) {
      print("GET CLASS ERROR: $e");
      return [];
    }
  }
}