import 'dart:convert';

import 'package:http/http.dart' as http;

class TeacherService {
  final String baseUrl =
      "http://127.0.0.1:8000/api/admin";
      
  Future<List<dynamic>> getTeachers() async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/teachers",
        ),
        headers: {
          "Accept": "application/json",
        },
      );

      print("STATUS TEACHER:");
      print(response.statusCode);

      print("BODY TEACHER:");
      print(response.body);

      if (response.statusCode == 200) {
        final json =
            jsonDecode(response.body);

        return json['data'] ?? [];
      }

      return [];
    } catch (e) {
      print("ERROR TEACHER:");
      print(e);

      return [];
    }
  }

  Future<bool> createTeacher({
    required String name,
    required String username,
    required String password,
    required String classId,
    required String nip,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "$baseUrl/teachers/store",
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type":
              "application/json",
        },
        body: jsonEncode({
          "name": name,
          "username": username,
          "password": password,
          "school_class_id": classId,
          "nip": nip,
          "phone": phone,
          "address": address,
        }),
      );

      print("CREATE STATUS:");
      print(response.statusCode);

      print("CREATE BODY:");
      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final json =
            jsonDecode(response.body);

        return json['success'] == true;
      }

      return false;
    } catch (e) {
      print("CREATE ERROR:");
      print(e);

      return false;
    }
  }

  Future<bool> updateTeacher({
    required int id,
    required String name,
    required String username,
    required String classId,
    required String nip,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "$baseUrl/teachers/update/$id",
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type":
              "application/json",
        },
        body: jsonEncode({
          "name": name,
          "username": username,
          "school_class_id": classId,
          "nip": nip,
          "phone": phone,
          "address": address,
        }),
      );

      print("UPDATE STATUS:");
      print(response.statusCode);

      print("UPDATE BODY:");
      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final json =
            jsonDecode(response.body);

        return json['success'] == true;
      }

      return false;
    } catch (e) {
      print("UPDATE ERROR:");
      print(e);

      return false;
    }
  }

  Future<bool> deleteTeacher(
    int id,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse(
          "$baseUrl/teachers/delete/$id",
        ),
        headers: {
          "Accept": "application/json",
        },
      );

      print("DELETE STATUS:");
      print(response.statusCode);

      print("DELETE BODY:");
      print(response.body);

      if (response.statusCode == 200) {
        final json =
            jsonDecode(response.body);

        return json['success'] == true;
      }

      return false;
    } catch (e) {
      print("DELETE ERROR:");
      print(e);

      return false;
    }
  }
}